param(
    [string]$Dir = ".\riola"
)

$ErrorActionPreference = 'Stop'

function Assert-Exit([string]$Step) {
    if ($LASTEXITCODE -ne 0) { throw "$Step failed (exit code $LASTEXITCODE)." }
}

# Toolchain / environment -------------------------------------------------
if (-not $env:ANDROID_HOME -and $env:ANDROID_SDK_ROOT) { $env:ANDROID_HOME = $env:ANDROID_SDK_ROOT }
if (-not $env:ANDROID_HOME) { $env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk" }
$AndroidJar = "$env:ANDROID_HOME\platforms\android-34\android.jar"
if (-not (Test-Path -LiteralPath $AndroidJar)) { throw "android-34 platform not found: $AndroidJar" }
foreach ($tool in @('aapt2', 'javac', 'd8.bat', 'jar.exe', 'zipalign.exe', 'apksigner.bat', 'keytool')) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) { throw "Required tool '$tool' not found in PATH." }
}

$SrcPkg = 'com\example\player'

# Prepare project directory -----------------------------------------------
New-Item -ItemType Directory -Force -Path "$Dir\$SrcPkg" | Out-Null
Push-Location $Dir
try {
    Remove-Item -LiteralPath '.\unaligned.apk', '.\classes.dex', '.\app-aligned.apk', '.\javac.log', '.\d8.log', '.\aapt2.log', '.\zipalign.log', '.\apksigner.log' -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath ".\com\example\player\*.class" -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath ".\com\example\player\R.java" -Force -ErrorAction SilentlyContinue

    # ------------------------------------------------------------------
    # AndroidManifest.xml  (framework resources only -> single aapt2 link)
    # ------------------------------------------------------------------
    @'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.player">

    <uses-sdk android:minSdkVersion="21" android:targetSdkVersion="34" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <application
        android:label="Programmable Player"
        android:theme="@android:style/Theme.Material.Light.NoActionBar">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:configChanges="orientation|screenSize|screenLayout|keyboardHidden">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <activity android:name=".SettingsActivity" />
        <service
            android:name=".PlayerService"
            android:foregroundServiceType="mediaPlayback"
            android:exported="false" />
    </application>

</manifest>
'@ | Out-File -Encoding ASCII -Force -FilePath 'AndroidManifest.xml'

    # ------------------------------------------------------------------
    # Cmd.java  (command model + codec)
    # ------------------------------------------------------------------
    @'
package com.example.player;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public abstract class Cmd {
    String keyword;
    String text;
    int track = -1;
}

class PlayCmd extends Cmd {
    int times;
}

class PauseCmd extends Cmd {
    long minutes;
}

class LoopCmd extends Cmd {
    long minutes;
}

class SectionCmd extends Cmd {
    long startMs;
    long endMs;
    boolean timed;
    long minutes;
    int times;
}

class CmdCodec {

    static String encode(Cmd c) {
        if (c instanceof PlayCmd) {
            PlayCmd p = (PlayCmd) c;
            return "PLAY|" + p.track + "|" + p.times;
        }
        if (c instanceof PauseCmd) {
            return "PAUSE|" + ((PauseCmd) c).minutes;
        }
        if (c instanceof LoopCmd) {
            LoopCmd p = (LoopCmd) c;
            return "LOOP|" + p.track + "|" + p.minutes;
        }
        if (c instanceof SectionCmd) {
            SectionCmd p = (SectionCmd) c;
            return "SECTION|" + p.track + "|" + p.startMs + "|" + p.endMs
                    + "|" + p.timed + "|" + (p.timed ? p.minutes : p.times);
        }
        throw new IllegalArgumentException("unknown command");
    }

    static String encodeProgram(List<Cmd> cmds) {
        StringBuilder sb = new StringBuilder();
        for (Cmd c : cmds) {
            sb.append(encode(c)).append('\n');
        }
        return sb.toString();
    }

    static Cmd decode(String line) {
        String[] t = line.split("\\|");
        String kw = t[0];
        Cmd c;
        if ("PLAY".equals(kw)) {
            PlayCmd p = new PlayCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.times = Integer.parseInt(t[2].trim());
            c = p;
        } else if ("PAUSE".equals(kw)) {
            PauseCmd p = new PauseCmd();
            p.keyword = kw;
            p.minutes = Long.parseLong(t[1].trim());
            c = p;
        } else if ("LOOP".equals(kw)) {
            LoopCmd p = new LoopCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.minutes = Long.parseLong(t[2].trim());
            c = p;
        } else if ("SECTION".equals(kw)) {
            SectionCmd p = new SectionCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.startMs = Long.parseLong(t[2].trim());
            p.endMs = Long.parseLong(t[3].trim());
            p.timed = Boolean.parseBoolean(t[4].trim());
            if (p.timed) {
                p.minutes = Long.parseLong(t[5].trim());
            } else {
                p.times = Integer.parseInt(t[5].trim());
            }
            c = p;
        } else {
            throw new IllegalArgumentException("unknown command '" + kw + "'");
        }
        c.text = describe(c);
        return c;
    }

    static List<Cmd> decodeProgram(String data) {
        List<Cmd> out = new ArrayList<Cmd>();
        if (data == null) return out;
        for (String raw : data.split("\r?\n")) {
            String line = raw.trim();
            if (line.length() == 0) continue;
            try {
                out.add(decode(line));
            } catch (Exception ignored) {
            }
        }
        return out;
    }

    static String describe(Cmd c) {
        if (c instanceof PlayCmd) {
            PlayCmd p = (PlayCmd) c;
            return "PLAY  trk" + p.track + "  " + p.times + " TIMES";
        }
        if (c instanceof PauseCmd) {
            return "PAUSE  " + ((PauseCmd) c).minutes + " MIN";
        }
        if (c instanceof LoopCmd) {
            LoopCmd p = (LoopCmd) c;
            return "LOOP  trk" + p.track + "  " + p.minutes + " MIN";
        }
        if (c instanceof SectionCmd) {
            SectionCmd p = (SectionCmd) c;
            String range = fmt(p.startMs) + " - " + fmt(p.endMs);
            if (p.timed) {
                return "SECTION  trk" + p.track + "  " + range + "  FOR " + p.minutes + " MIN";
            } else {
                return "SECTION  trk" + p.track + "  " + range + "  " + p.times + " TIMES";
            }
        }
        return "";
    }

    private static String fmt(long ms) {
        if (ms < 0) ms = 0;
        long total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\Cmd.java'

    # ------------------------------------------------------------------
    # Program.java  (program model + codec)
    # ------------------------------------------------------------------
    @'
package com.example.player;

import java.util.ArrayList;
import java.util.List;

class Program {
    String name;
    List<Cmd> cmds = new ArrayList<Cmd>();

    Program() {
    }

    Program(String name) {
        this.name = name;
    }
}

class ProgramCodec {

    static final String HEADER = "PROG\t";
    static final String FOOTER = "END";

    static String encode(List<Program> progs) {
        StringBuilder sb = new StringBuilder();
        for (Program p : progs) {
            sb.append(HEADER).append(escape(p.name)).append('\n');
            for (Cmd c : p.cmds) {
                sb.append(CmdCodec.encode(c)).append('\n');
            }
            sb.append(FOOTER).append('\n');
        }
        return sb.toString();
    }

    static List<Program> decode(String data) {
        List<Program> out = new ArrayList<Program>();
        if (data == null) return out;
        Program cur = null;
        for (String line : data.split("\r?\n")) {
            String trimmed = line.trim();
            if (trimmed.length() == 0) continue;
            if (line.startsWith(HEADER)) {
                cur = new Program(unescape(line.substring(HEADER.length())));
                out.add(cur);
            } else if (FOOTER.equals(trimmed)) {
                cur = null;
            } else if (cur != null) {
                try {
                    cur.cmds.add(CmdCodec.decode(line));
                } catch (Exception ignored) {
                }
            }
        }
        return out;
    }

    private static String escape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (ch == '\\') sb.append("\\\\");
            else if (ch == '\t') sb.append("\\t");
            else if (ch == '\n') sb.append("\\n");
            else if (ch == '\r') sb.append("\\r");
            else sb.append(ch);
        }
        return sb.toString();
    }

    private static String unescape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (ch == '\\' && i + 1 < s.length()) {
                char nxt = s.charAt(i + 1);
                if (nxt == 't') { sb.append('\t'); i++; }
                else if (nxt == 'n') { sb.append('\n'); i++; }
                else if (nxt == 'r') { sb.append('\r'); i++; }
                else if (nxt == '\\') { sb.append('\\'); i++; }
                else sb.append(ch);
            } else {
                sb.append(ch);
            }
        }
        return sb.toString();
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\Program.java'

    # ------------------------------------------------------------------
    # Storage.java
    # ------------------------------------------------------------------
    @'
package com.example.player;

import android.content.Context;
import android.net.Uri;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

public class Storage {

    static final String FILE_NAME = "programs.dat";

    static List<Program> loadPrograms(Context ctx) {
        try {
            InputStream is = ctx.openFileInput(FILE_NAME);
            String data = readAll(is);
            is.close();
            return ProgramCodec.decode(data);
        } catch (FileNotFoundException fnf) {
            return new ArrayList<Program>();
        } catch (Exception e) {
            return new ArrayList<Program>();
        }
    }

    static void savePrograms(Context ctx, List<Program> progs) {
        try {
            String data = ProgramCodec.encode(progs);
            FileOutputStream fos = ctx.openFileOutput(FILE_NAME, Context.MODE_PRIVATE);
            fos.write(data.getBytes("UTF-8"));
            fos.close();
        } catch (Exception e) {
            // best effort
        }
    }

    static String readUri(Context ctx, Uri uri) throws IOException {
        InputStream is = ctx.getContentResolver().openInputStream(uri);
        if (is == null) throw new IOException("cannot open input: " + uri);
        String data = readAll(is);
        is.close();
        return data;
    }

    static void writeUri(Context ctx, Uri uri, String data) throws IOException {
        OutputStream os = ctx.getContentResolver().openOutputStream(uri);
        if (os == null) throw new IOException("cannot open output: " + uri);
        os.write(data.getBytes("UTF-8"));
        os.flush();
        os.close();
    }

    private static String readAll(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buf = new byte[4096];
        int n;
        while ((n = is.read(buf)) > 0) {
            baos.write(buf, 0, n);
        }
        return new String(baos.toByteArray(), "UTF-8");
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\Storage.java'

    # ------------------------------------------------------------------
    # SettingsActivity.java  (programmatic, no PreferenceActivity / XML)
    # ------------------------------------------------------------------
    @'
package com.example.player;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class SettingsActivity extends Activity {

    static final String PREFS = "player_prefs";
    static final String K_AUTO_SAVE = "auto_save";
    static final String K_KEEP_SCREEN = "keep_screen_on";
    static final String K_NOTIFS = "notifications";
    static final String K_SLEEP_MIN = "default_sleep_min";

    static SharedPreferences sp(Context ctx) {
        return ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    static boolean autoSave(Context ctx) {
        return sp(ctx).getBoolean(K_AUTO_SAVE, true);
    }

    static boolean keepScreenOn(Context ctx) {
        return sp(ctx).getBoolean(K_KEEP_SCREEN, true);
    }

    static boolean notificationsEnabled(Context ctx) {
        return sp(ctx).getBoolean(K_NOTIFS, true);
    }

    static int defaultSleepMin(Context ctx) {
        return sp(ctx).getInt(K_SLEEP_MIN, 0);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        float density = getResources().getDisplayMetrics().density;
        int pad = Math.round(16f * density);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);

        addCheck(root, "Auto-save programs", K_AUTO_SAVE);
        addCheck(root, "Keep screen on during playback", K_KEEP_SCREEN);
        addCheck(root, "Show playback notification", K_NOTIFS);

        LinearLayout sleepRow = new LinearLayout(this);
        sleepRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView sl = new TextView(this);
        sl.setText("Default sleep timer (minutes, 0 = none):");
        final EditText sleepEdit = new EditText(this);
        sleepEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        sleepEdit.setText(String.valueOf(defaultSleepMin(this)));
        sleepRow.addView(sl, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        sleepRow.addView(sleepEdit, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        root.addView(sleepRow);

        Button applySleep = new Button(this);
        applySleep.setText("Apply default sleep timer");
        applySleep.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int m = parseInt(sleepEdit.getText().toString(), 0);
                if (m < 0) m = 0;
                sp(SettingsActivity.this).edit().putInt(K_SLEEP_MIN, m).apply();
                Toast.makeText(SettingsActivity.this, "Default sleep: " + m + " min", Toast.LENGTH_SHORT).show();
            }
        });
        root.addView(applySleep);

        Button back = new Button(this);
        back.setText("Back");
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        root.addView(back);

        setContentView(root);
    }

    private void addCheck(LinearLayout root, String label, String key) {
        CheckBox cb = new CheckBox(this);
        cb.setText(label);
        cb.setTag(key);
        cb.setChecked(sp(this).getBoolean(key, true));
        cb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                sp(SettingsActivity.this).edit()
                        .putBoolean((String) buttonView.getTag(), isChecked).apply();
            }
        });
        root.addView(cb);
    }

    private static int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\SettingsActivity.java'

    # ------------------------------------------------------------------
    # PlayerService.java  (fixed listener lifecycle + sleep/repeat/shuffle)
    # ------------------------------------------------------------------
    @'
package com.example.player;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.SystemClock;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

public class PlayerService extends Service {

    static final String ACTION_PLAY = "com.example.player.ACTION_PLAY";
    static final String ACTION_STOP = "com.example.player.ACTION_STOP";
    static final String ACTION_PAUSE = "com.example.player.ACTION_PAUSE";
    static final String ACTION_RESUME = "com.example.player.ACTION_RESUME";

    static final String BROADCAST_STATUS = "com.example.player.STATUS";
    static final String BROADCAST_FINISHED = "com.example.player.FINISHED";

    static final String EXTRA_PROGRAM = "program";
    static final String EXTRA_TRACK_URIS = "track_uris";
    static final String EXTRA_TRACK_NAMES = "track_names";
    static final String EXTRA_REPEAT = "repeat";
    static final String EXTRA_SLEEP_MIN = "sleep_min";
    static final String EXTRA_SHUFFLE = "shuffle";

    static final int NOTIF_ID = 1001;
    static final String CHANNEL_ID = "media_playback";

    private MediaPlayer player;
    private final Object playerLock = new Object();

    private volatile Thread worker = null;
    private volatile boolean running = false;
    private volatile boolean paused = false;
    private volatile boolean playComplete = false;
    private volatile boolean playError = false;
    private volatile boolean seekDone = true;

    private volatile int repeatCount = 0;
    private volatile int sleepMin = 0;
    private volatile boolean shuffle = false;

    private final List<Uri> tracks = new ArrayList<Uri>();
    private final List<String> names = new ArrayList<String>();
    private List<Cmd> program = new ArrayList<Cmd>();

    private volatile String currentStepText = "Idle.";
    private volatile String currentTrackName = "";

    private Handler mainHandler;
    private NotificationManager nm;
    private int piSeq = 1;

    private final Runnable ticker = new Runnable() {
        @Override
        public void run() {
            if (running) {
                refreshNotification();
                mainHandler.postDelayed(this, 500);
            }
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();
        mainHandler = new Handler(Looper.getMainLooper());
        nm = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        createChannel();
    }

    private void createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            android.app.NotificationChannel ch = new android.app.NotificationChannel(
                    CHANNEL_ID, "Media playback", NotificationManager.IMPORTANCE_LOW);
            ch.setShowBadge(false);
            nm.createNotificationChannel(ch);
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = intent == null ? null : intent.getAction();
        if (ACTION_STOP.equals(action)) {
            stopEngine();
            return START_NOT_STICKY;
        }
        if (ACTION_PAUSE.equals(action)) {
            paused = true;
            pauseCurrent();
            refreshNotification();
            return START_STICKY;
        }
        if (ACTION_RESUME.equals(action)) {
            paused = false;
            resumeCurrent();
            refreshNotification();
            return START_STICKY;
        }
        if (ACTION_PLAY.equals(action)) {
            cleanupPlayback();
            ArrayList<String> uris = intent.getStringArrayListExtra(EXTRA_TRACK_URIS);
            ArrayList<String> nms = intent.getStringArrayListExtra(EXTRA_TRACK_NAMES);
            String enc = intent.getStringExtra(EXTRA_PROGRAM);
            repeatCount = intent.getIntExtra(EXTRA_REPEAT, 0);
            sleepMin = intent.getIntExtra(EXTRA_SLEEP_MIN, SettingsActivity.defaultSleepMin(this));
            shuffle = intent.getBooleanExtra(EXTRA_SHUFFLE, false);
            tracks.clear();
            names.clear();
            if (uris != null) {
                for (String u : uris) tracks.add(Uri.parse(u));
            }
            if (nms != null) {
                for (String n : nms) names.add(n == null ? "" : n);
            }
            program = CmdCodec.decodeProgram(enc);
            currentStepText = "Starting...";
            currentTrackName = "";
            startForeground(NOTIF_ID, buildNotification());
            startEngine();
            return START_NOT_STICKY;
        }
        return START_NOT_STICKY;
    }

    private void startEngine() {
        running = true;
        paused = false;
        playComplete = false;
        playError = false;
        seekDone = true;
        mainHandler.post(ticker);
        worker = new Thread(new Runnable() {
            @Override
            public void run() {
                executeProgram();
            }
        }, "PlayerService-engine");
        worker.start();
    }

    private void cleanupPlayback() {
        running = false;
        paused = false;
        Thread w = worker;
        if (w != null && w.isAlive()) {
            w.interrupt();
            try {
                w.join(1500);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        worker = null;
        mainHandler.removeCallbacks(ticker);
        releasePlayer();
    }

    private void stopEngine() {
        cleanupPlayback();
        stopForeground(true);
        stopSelf();
    }

    private void executeProgram() {
        String endMessage;
        try {
            List<Cmd> base = new ArrayList<Cmd>(program);
            if (base.isEmpty()) {
                endMessage = "Empty program.";
            } else {
                List<Cmd> seq = shuffle ? shuffled(base) : base;
                long sleepDeadline = sleepMin > 0
                        ? SystemClock.elapsedRealtime() + sleepMin * 60000L
                        : Long.MAX_VALUE;
                boolean forever = repeatCount <= 0;
                int cap = forever ? Integer.MAX_VALUE : repeatCount;
                for (int it = 0; running && (forever || it < cap); it++) {
                    if (SystemClock.elapsedRealtime() >= sleepDeadline) {
                        running = false;
                        break;
                    }
                    for (int pc = 0; running && pc < seq.size(); pc++) {
                        if (SystemClock.elapsedRealtime() >= sleepDeadline) {
                            running = false;
                            break;
                        }
                        Cmd cmd = seq.get(pc);
                        if (cmd.track >= 0 && cmd.track >= tracks.size()) {
                            throw new IllegalArgumentException(cmd.keyword + ": track "
                                    + cmd.track + " out of range (loaded: " + tracks.size() + ")");
                        }
                        currentTrackName = trackName(cmd.track);
                        setStatus("[" + (it + 1) + "/" + (forever ? "inf" : cap)
                                + "] " + (pc + 1) + "/" + seq.size() + " | " + cmd.text);
                        dispatch(cmd, sleepDeadline);
                    }
                }
                endMessage = running ? "Program finished." : "Stopped.";
            }
        } catch (InterruptedException lost) {
            endMessage = "Stopped.";
        } catch (Exception ex) {
            String msg = ex.getMessage();
            endMessage = "ERROR: " + (msg == null ? ex.getClass().getSimpleName() : msg);
        } finally {
            releasePlayer();
            running = false;
            paused = false;
            mainHandler.removeCallbacks(ticker);
            mainHandler.post(new Runnable() {
                @Override
                public void run() {
                    refreshNotification();
                    stopForeground(true);
                    Intent f = new Intent(BROADCAST_FINISHED);
                    sendBroadcast(f);
                    stopSelf();
                }
            });
        }
        setStatus(endMessage);
    }

    private void dispatch(Cmd cmd, long sleepDeadline) throws Exception {
        if (cmd instanceof PlayCmd) {
            doPlay((PlayCmd) cmd, sleepDeadline);
        } else if (cmd instanceof PauseCmd) {
            doPause((PauseCmd) cmd, sleepDeadline);
        } else if (cmd instanceof LoopCmd) {
            doLoop((LoopCmd) cmd, sleepDeadline);
        } else if (cmd instanceof SectionCmd) {
            doSection((SectionCmd) cmd, sleepDeadline);
        }
    }

    private void doPlay(PlayCmd cmd, long sleepDeadline) throws Exception {
        for (int lap = 0; lap < cmd.times && running; lap++) {
            if (SystemClock.elapsedRealtime() >= sleepDeadline) {
                running = false;
                break;
            }
            waitIfPaused(sleepDeadline);
            if (!running) break;
            MediaPlayer mp = prepareTrack(cmd.track, false);
            playComplete = false;
            playError = false;
            synchronized (playerLock) {
                if (player != null) player.start();
            }
            awaitDone(sleepDeadline);
            if (playError) {
                setStatus("Playback error on trk" + cmd.track + " (" + currentTrackName + ")");
                break;
            }
        }
    }

    private void doPause(PauseCmd cmd, long sleepDeadline) throws InterruptedException {
        releasePlayer();
        long end = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        while (running && SystemClock.elapsedRealtime() < end && SystemClock.elapsedRealtime() < sleepDeadline) {
            if (paused) {
                while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
            } else {
                Thread.sleep(250);
            }
        }
        if (SystemClock.elapsedRealtime() >= sleepDeadline) running = false;
    }

    private void doLoop(LoopCmd cmd, long sleepDeadline) throws Exception {
        MediaPlayer mp = prepareTrack(cmd.track, true);
        playError = false;
        synchronized (playerLock) {
            if (player != null) player.start();
        }
        long end = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        while (running && SystemClock.elapsedRealtime() < end && !playError
                && SystemClock.elapsedRealtime() < sleepDeadline) {
            if (paused) {
                while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
                continue;
            }
            Thread.sleep(200);
        }
        if (playError) setStatus("Playback error on trk" + cmd.track);
        if (running && !playError && SystemClock.elapsedRealtime() < sleepDeadline) quietStop(mp);
    }

    private void doSection(SectionCmd cmd, long sleepDeadline) throws Exception {
        MediaPlayer mp = prepareTrack(cmd.track, false);
        playError = false;
        playComplete = false;
        seekDone = false;
        synchronized (playerLock) {
            if (player != null) player.seekTo((int) cmd.startMs);
        }
        waitSeek(sleepDeadline);
        if (!running || playError) {
            if (running) quietStop(mp);
            return;
        }
        synchronized (playerLock) {
            if (player != null) player.start();
        }
        long duration = 0;
        synchronized (playerLock) {
            if (player != null) duration = player.getDuration();
        }
        long startMs = cmd.startMs;
        long endMs = cmd.endMs;
        if (startMs > duration) startMs = 0;
        if (endMs > duration) endMs = duration;
        if (endMs <= startMs) {
            startMs = 0;
            endMs = duration;
        }
        long end = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        int laps = 0;
        while (running && !playError && SystemClock.elapsedRealtime() < sleepDeadline) {
            if (cmd.timed && SystemClock.elapsedRealtime() >= end) break;
            if (!cmd.timed && laps >= cmd.times) break;
            if (paused) {
                while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
                if (!running) break;
                continue;
            }
            int pos = 0;
            synchronized (playerLock) {
                if (player != null) pos = player.getCurrentPosition();
            }
            if (pos + 50 >= (int) endMs) {
                laps++;
                if (!cmd.timed && laps >= cmd.times) break;
                seekDone = false;
                synchronized (playerLock) {
                    if (player != null) player.seekTo((int) startMs);
                }
                waitSeek(sleepDeadline);
                if (running && !playError) {
                    synchronized (playerLock) {
                        if (player != null) player.start();
                    }
                }
            } else {
                Thread.sleep(100);
            }
        }
        if (playError) setStatus("Playback error on trk" + cmd.track);
        if (running && !playError && SystemClock.elapsedRealtime() < sleepDeadline) quietStop(mp);
    }

    private void waitIfPaused(long sleepDeadline) throws InterruptedException {
        while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
        if (SystemClock.elapsedRealtime() >= sleepDeadline) running = false;
    }

    private void awaitDone(long sleepDeadline) throws InterruptedException {
        while (running && !playComplete && !playError && SystemClock.elapsedRealtime() < sleepDeadline) {
            if (paused) {
                while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
                if (!running) break;
                continue;
            }
            Thread.sleep(50);
        }
        if (SystemClock.elapsedRealtime() >= sleepDeadline) running = false;
    }

    private void waitSeek(long sleepDeadline) throws InterruptedException {
        long waited = 0;
        while (running && !seekDone && waited < 3000 && !playError
                && SystemClock.elapsedRealtime() < sleepDeadline) {
            if (paused) {
                while (running && paused && SystemClock.elapsedRealtime() < sleepDeadline) Thread.sleep(150);
                if (!running) break;
            }
            Thread.sleep(25);
            waited += 25;
        }
    }

    private MediaPlayer prepareTrack(int index, boolean looping) throws Exception {
        final MediaPlayer mp = new MediaPlayer();
        mp.setOnSeekCompleteListener(new MediaPlayer.OnSeekCompleteListener() {
            @Override
            public void onSeekComplete(MediaPlayer m) {
                seekDone = true;
            }
        });
        mp.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            @Override
            public void onCompletion(MediaPlayer m) {
                playComplete = true;
            }
        });
        mp.setOnErrorListener(new MediaPlayer.OnErrorListener() {
            @Override
            public boolean onError(MediaPlayer m, int what, int extra) {
                playError = true;
                playComplete = true;
                return true;
            }
        });
        AudioAttributes attrs = new AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_MEDIA)
                .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                .build();
        mp.setAudioAttributes(attrs);
        mp.setLooping(looping);
        mp.setDataSource(this, tracks.get(index));
        mp.prepare();
        synchronized (playerLock) {
            player = mp;
        }
        return mp;
    }

    private void pauseCurrent() {
        synchronized (playerLock) {
            if (player != null) {
                try { player.pause(); } catch (Exception ignored) {}
            }
        }
    }

    private void resumeCurrent() {
        synchronized (playerLock) {
            if (player != null) {
                try { if (!player.isPlaying()) player.start(); } catch (Exception ignored) {}
            }
        }
    }

    private void quietStop(MediaPlayer mp) {
        try { mp.stop(); } catch (Exception ignored) {}
    }

    private void releasePlayer() {
        synchronized (playerLock) {
            MediaPlayer mp = player;
            player = null;
            if (mp != null) {
                try { mp.stop(); } catch (Exception ignored) {}
                try { mp.reset(); } catch (Exception ignored) {}
                try { mp.release(); } catch (Exception ignored) {}
            }
        }
    }

    private boolean isPlayingLocked() {
        synchronized (playerLock) {
            if (player == null) return false;
            try { return player.isPlaying(); } catch (Exception e) { return false; }
        }
    }

    private void setStatus(String text) {
        currentStepText = text;
        refreshNotification();
    }

    private void refreshNotification() {
        boolean playing = isPlayingLocked();
        int pos = 0, dur = 0;
        synchronized (playerLock) {
            if (player != null) {
                try {
                    pos = player.getCurrentPosition();
                    dur = player.getDuration();
                } catch (Exception ignored) {
                }
            }
        }
        Intent b = new Intent(BROADCAST_STATUS);
        b.putExtra("status", currentStepText);
        b.putExtra("playing", playing);
        b.putExtra("pos", pos);
        b.putExtra("dur", dur);
        b.putExtra("track", currentTrackName);
        sendBroadcast(b);
        nm.notify(NOTIF_ID, buildNotification());
    }

    private Notification buildNotification() {
        boolean playing = isPlayingLocked();
        int pos = 0, dur = 0;
        synchronized (playerLock) {
            if (player != null) {
                try {
                    pos = player.getCurrentPosition();
                    dur = player.getDuration();
                } catch (Exception ignored) {
                }
            }
        }
        String content;
        if (playing && !currentTrackName.isEmpty()) {
            content = currentTrackName + "  " + fmt(pos) + " / " + fmt(dur);
        } else {
            content = currentStepText;
        }
        Notification.Builder nb = new Notification.Builder(this);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            nb.setChannelId(CHANNEL_ID);
        }
        nb.setContentTitle("Programmable Player");
        nb.setContentText(content);
        nb.setSmallIcon(android.R.drawable.ic_media_play);
        nb.setOngoing(true);
        nb.setShowWhen(false);
        nb.setOnlyAlertOnce(true);
        Intent pa = new Intent(this, PlayerService.class).setAction(playing ? ACTION_PAUSE : ACTION_RESUME);
        Intent st = new Intent(this, PlayerService.class).setAction(ACTION_STOP);
        nb.addAction(android.R.drawable.ic_media_play, playing ? "Pause" : "Play",
                PendingIntent.getService(this, piSeq(), pa, PendingIntent.FLAG_IMMUTABLE));
        nb.addAction(android.R.drawable.ic_delete, "Stop",
                PendingIntent.getService(this, piSeq(), st, PendingIntent.FLAG_IMMUTABLE));
        return nb.build();
    }

    private int piSeq() {
        return piSeq++;
    }

    private String trackName(int idx) {
        if (idx >= 0 && idx < names.size()) {
            String n = names.get(idx);
            return n != null && n.length() > 0 ? n : ("track " + idx);
        }
        return idx < 0 ? "" : ("track " + idx);
    }

    private List<Cmd> shuffled(List<Cmd> base) {
        List<Cmd> copy = new ArrayList<Cmd>(base);
        Collections.shuffle(copy);
        return copy;
    }

    private static String fmt(int ms) {
        if (ms < 0) ms = 0;
        int total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onDestroy() {
        stopEngine();
        super.onDestroy();
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\PlayerService.java'

    # ------------------------------------------------------------------
    # MainActivity.java  (multi-program builder + extras + service UI)
    # ------------------------------------------------------------------
    @'
package com.example.player;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.OpenableColumns;
import android.text.InputType;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class MainActivity extends Activity {

    private static final int REQ_PICK_TRACKS = 41;
    private static final int REQ_EXPORT = 42;
    private static final int REQ_IMPORT = 43;
    private static final int REQ_POST_NOTIFICATIONS = 44;

    private final List<Uri> tracks = new ArrayList<Uri>();
    private final List<String> trackNames = new ArrayList<String>();
    private List<Program> programs = new ArrayList<Program>();
    private int currentProgramIndex = 0;
    private boolean ignoreSpinner = false;
    private boolean running = false;

    private TextView trackListView;
    private TextView programListView;
    private TextView statusView;
    private TextView positionView;
    private SeekBar volumeSeekBar;

    private Spinner programSpinner;
    private Spinner cmdSpinner;
    private Spinner trackSpinner;
    private Spinner sectionModeSpinner;
    private CheckBox shuffleCheck;
    private LinearLayout sectionTimeRow;
    private LinearLayout sectionModeRow;
    private EditText nEdit;
    private EditText repeatEdit;
    private EditText sleepEdit;
    private EditText startMinEdit;
    private EditText startSecEdit;
    private EditText endMinEdit;
    private EditText endSecEdit;
    private Button runButton;
    private Button stopButton;
    private Button addButton;
    private Button clearButton;
    private Button newButton;
    private Button deleteButton;
    private Button exportButton;
    private Button importButton;
    private Button settingsButton;
    private Button shuffleAllButton;

    private AudioManager audio;

    private final BroadcastReceiver statusReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context ctx, Intent i) {
            String a = i.getAction();
            if (PlayerService.BROADCAST_STATUS.equals(a)) {
                statusView.setText(i.getStringExtra("status"));
                boolean playing = i.getBooleanExtra("playing", false);
                int pos = i.getIntExtra("pos", 0);
                int dur = i.getIntExtra("dur", 0);
                positionView.setText(playing ? (fmtTime(pos) + " / " + fmtTime(dur)) : "");
            } else if (PlayerService.BROADCAST_FINISHED.equals(a)) {
                running = false;
                runButton.setEnabled(true);
                stopButton.setEnabled(false);
                setBuilderEnabled(true);
                positionView.setText("");
                statusView.setText("Idle.");
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        audio = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        if (SettingsActivity.keepScreenOn(this)) {
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
        float density = getResources().getDisplayMetrics().density;
        int pad = Math.round(16f * density);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);
        ScrollView scroller = new ScrollView(this);
        scroller.addView(root);
        setContentView(scroller);

        TextView title = new TextView(this);
        title.setText("Programmable Player");
        title.setTextSize(20f);
        title.setGravity(Gravity.CENTER);
        title.setPadding(0, 0, 0, Math.round(8f * density));
        root.addView(title);

        Button pickButton = new Button(this);
        pickButton.setText("Select Tracks");
        pickButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                launchPicker();
            }
        });
        root.addView(pickButton);

        trackListView = new TextView(this);
        trackListView.setText("No tracks loaded.\n");
        ScrollView trackScroller = new ScrollView(this);
        trackScroller.addView(trackListView);
        root.addView(trackScroller, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(120f * density)));

        LinearLayout progBar = new LinearLayout(this);
        progBar.setOrientation(LinearLayout.HORIZONTAL);
        programSpinner = new Spinner(this);
        programSpinner.setPrompt("Programs");
        programSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                if (!ignoreSpinner) switchProgram(pos);
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        LinearLayout.LayoutParams half = new LinearLayout.LayoutParams(0,
                ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        progBar.addView(programSpinner, half);
        newButton = new Button(this);
        newButton.setText("New");
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                newProgram();
            }
        });
        progBar.addView(newButton, half);
        deleteButton = new Button(this);
        deleteButton.setText("Delete");
        deleteButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteProgram();
            }
        });
        progBar.addView(deleteButton, half);
        root.addView(progBar);

        LinearLayout progActions = new LinearLayout(this);
        progActions.setOrientation(LinearLayout.HORIZONTAL);
        exportButton = new Button(this);
        exportButton.setText("Export");
        exportButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                exportProgram();
            }
        });
        importButton = new Button(this);
        importButton.setText("Import");
        importButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                importProgram();
            }
        });
        settingsButton = new Button(this);
        settingsButton.setText("Settings");
        settingsButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, SettingsActivity.class));
            }
        });
        progActions.addView(exportButton, half);
        progActions.addView(importButton, half);
        progActions.addView(settingsButton, half);
        root.addView(progActions);

        TextView builderTitle = new TextView(this);
        builderTitle.setText("Build program (visual):");
        builderTitle.setTextSize(15f);
        root.addView(builderTitle);

        LinearLayout cmdRow = new LinearLayout(this);
        cmdRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView cmdLabel = new TextView(this);
        cmdLabel.setText("Command");
        cmdSpinner = new Spinner(this);
        ArrayAdapter<String> cmdAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item,
                new ArrayList<String>(Arrays.asList("PLAY", "PAUSE", "LOOP", "SECTION")));
        cmdAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        cmdSpinner.setAdapter(cmdAdapter);
        cmdSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                applyFieldVisibility(pos);
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        cmdRow.addView(cmdLabel, half);
        cmdRow.addView(cmdSpinner, half);
        trackSpinner = new Spinner(this);
        refreshTrackSpinner();
        cmdRow.addView(trackSpinner, half);
        root.addView(cmdRow);

        LinearLayout nRow = new LinearLayout(this);
        nRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView nLabel = new TextView(this);
        nLabel.setText("N");
        nEdit = new EditText(this);
        nEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        nEdit.setText("1");
        nRow.addView(nLabel, half);
        nRow.addView(nEdit, half);
        root.addView(nRow);

        sectionTimeRow = new LinearLayout(this);
        sectionTimeRow.setOrientation(LinearLayout.VERTICAL);
        startMinEdit = newNumberEdit("0");
        startSecEdit = newNumberEdit("0");
        endMinEdit = newNumberEdit("0");
        endSecEdit = newNumberEdit("30");
        sectionTimeRow.addView(timeRow("Start", startMinEdit, startSecEdit, density));
        sectionTimeRow.addView(timeRow("End", endMinEdit, endSecEdit, density));
        root.addView(sectionTimeRow);

        sectionModeRow = new LinearLayout(this);
        sectionModeRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView modeLabel = new TextView(this);
        modeLabel.setText("Repeat mode");
        sectionModeSpinner = new Spinner(this);
        ArrayAdapter<String> modeAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item,
                new ArrayList<String>(Arrays.asList("FOR MINUTES", "N TIMES")));
        modeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sectionModeSpinner.setAdapter(modeAdapter);
        sectionModeRow.addView(modeLabel, half);
        sectionModeRow.addView(sectionModeSpinner, half);
        root.addView(sectionModeRow);

        LinearLayout repRow = new LinearLayout(this);
        repRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView repLabel = new TextView(this);
        repLabel.setText("Repeat program (0 = forever)");
        repeatEdit = new EditText(this);
        repeatEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        repeatEdit.setText("0");
        repRow.addView(repLabel, half);
        repRow.addView(repeatEdit, half);
        root.addView(repRow);

        LinearLayout optRow = new LinearLayout(this);
        optRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView sleepLabel = new TextView(this);
        sleepLabel.setText("Sleep timer (min)");
        sleepEdit = new EditText(this);
        sleepEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        sleepEdit.setText(String.valueOf(SettingsActivity.defaultSleepMin(this)));
        shuffleCheck = new CheckBox(this);
        shuffleCheck.setText("Shuffle order");
        optRow.addView(sleepLabel, half);
        optRow.addView(sleepEdit, half);
        optRow.addView(shuffleCheck);
        root.addView(optRow);

        LinearLayout actionRow = new LinearLayout(this);
        actionRow.setOrientation(LinearLayout.HORIZONTAL);
        addButton = new Button(this);
        addButton.setText("Add to program");
        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addStep();
            }
        });
        clearButton = new Button(this);
        clearButton.setText("Clear program");
        clearButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                currentProgram().cmds.clear();
                refreshProgramList();
                setStatus("Program cleared.");
                autoSave();
            }
        });
        actionRow.addView(addButton, half);
        actionRow.addView(clearButton, half);
        root.addView(actionRow);

        shuffleAllButton = new Button(this);
        shuffleAllButton.setText("Shuffle program");
        shuffleAllButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                java.util.Collections.shuffle(currentProgram().cmds);
                refreshProgramList();
                setStatus("Shuffled.");
                autoSave();
            }
        });
        root.addView(shuffleAllButton);

        programListView = new TextView(this);
        programListView.setText("(no steps yet)\n");
        ScrollView programScroller = new ScrollView(this);
        programScroller.addView(programListView);
        root.addView(programScroller, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(180f * density)));

        TextView volLabel = new TextView(this);
        volLabel.setText("Media volume");
        root.addView(volLabel);
        volumeSeekBar = new SeekBar(this);
        int maxVol = audio.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
        volumeSeekBar.setMax(maxVol);
        volumeSeekBar.setProgress(audio.getStreamVolume(AudioManager.STREAM_MUSIC));
        volumeSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser) {
                    audio.setStreamVolume(AudioManager.STREAM_MUSIC, progress, AudioManager.FLAG_SHOW_UI);
                }
            }
            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });
        root.addView(volumeSeekBar, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        positionView = new TextView(this);
        positionView.setText("");
        positionView.setTextSize(13f);
        positionView.setTextColor(0xFF666666);
        root.addView(positionView);

        LinearLayout runRow = new LinearLayout(this);
        runRow.setOrientation(LinearLayout.HORIZONTAL);
        runButton = new Button(this);
        runButton.setText("Run Program");
        runButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                runProgram();
            }
        });
        stopButton = new Button(this);
        stopButton.setText("Stop");
        stopButton.setEnabled(false);
        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                stopProgram();
            }
        });
        runRow.addView(runButton, half);
        runRow.addView(stopButton, half);
        root.addView(runRow);

        statusView = new TextView(this);
        statusView.setText("Idle.");
        statusView.setTextSize(13f);
        root.addView(statusView);

        programs = Storage.loadPrograms(this);
        if (programs.isEmpty()) {
            programs.add(new Program("Program 1"));
        }
        currentProgramIndex = 0;
        refreshProgramSpinner();
        applyFieldVisibility(cmdSpinner.getSelectedItemPosition());
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
            audio.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_RAISE, AudioManager.FLAG_SHOW_UI);
            return true;
        }
        if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
            audio.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_LOWER, AudioManager.FLAG_SHOW_UI);
            return true;
        }
        if (keyCode == KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE) {
            togglePlayback();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onResume() {
        super.onResume();
        registerReceiver(statusReceiver, new IntentFilter(PlayerService.BROADCAST_STATUS));
        registerReceiver(statusReceiver, new IntentFilter(PlayerService.BROADCAST_FINISHED));
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            unregisterReceiver(statusReceiver);
        } catch (Exception ignored) {
        }
    }

    @Override
    protected void onDestroy() {
        if (running) {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_STOP);
            startService(si);
        }
        super.onDestroy();
    }

    private void togglePlayback() {
        if (running) {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_PAUSE);
            startService(si);
            setStatus("Pausing...");
        } else {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_RESUME);
            startService(si);
        }
    }

    private void runProgram() {
        if (tracks.isEmpty()) {
            toastLong("Load at least one track first.");
            return;
        }
        if (currentProgram().cmds.isEmpty()) {
            toastShort("Add commands to the program first.");
            return;
        }
        requestNotificationPermissionIfNeeded();
        Intent si = new Intent(this, PlayerService.class);
        si.setAction(PlayerService.ACTION_PLAY);
        ArrayList<String> uris = new ArrayList<String>();
        for (Uri u : tracks) uris.add(u.toString());
        si.putStringArrayListExtra(PlayerService.EXTRA_TRACK_URIS, uris);
        si.putStringArrayListExtra(PlayerService.EXTRA_TRACK_NAMES, new ArrayList<String>(trackNames));
        si.putExtra(PlayerService.EXTRA_PROGRAM, CmdCodec.encodeProgram(currentProgram().cmds));
        si.putExtra(PlayerService.EXTRA_REPEAT, parseInt(repeatEdit, 0));
        si.putExtra(PlayerService.EXTRA_SLEEP_MIN, parseInt(sleepEdit, 0));
        si.putExtra(PlayerService.EXTRA_SHUFFLE, shuffleCheck.isChecked());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(si);
        } else {
            startService(si);
        }
        setBuilderEnabled(false);
        runButton.setEnabled(false);
        stopButton.setEnabled(true);
        running = true;
        setStatus("Starting playback...");
    }

    private void stopProgram() {
        Intent si = new Intent(this, PlayerService.class);
        si.setAction(PlayerService.ACTION_STOP);
        startService(si);
        running = false;
        runButton.setEnabled(true);
        stopButton.setEnabled(false);
        setBuilderEnabled(true);
        setStatus("Stopping...");
    }

    private void requestNotificationPermissionIfNeeded() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (checkSelfPermission(android.Manifest.permission.POST_NOTIFICATIONS)
                    != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{android.Manifest.permission.POST_NOTIFICATIONS},
                        REQ_POST_NOTIFICATIONS);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions,
                                           int[] grantResults) {
        if (requestCode == REQ_POST_NOTIFICATIONS) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                toastShort("Notifications enabled.");
            } else {
                toastShort("Enable notifications in system settings to see playback.");
            }
        }
    }

    private void exportProgram() {
        Intent share = new Intent(Intent.ACTION_CREATE_DOCUMENT);
        share.addCategory(Intent.CATEGORY_OPENABLE);
        share.setType("text/plain");
        share.putExtra(Intent.EXTRA_TITLE, currentProgram().name + ".pmp");
        startActivityForResult(share, REQ_EXPORT);
    }

    private void importProgram() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("text/plain");
        startActivityForResult(i, REQ_IMPORT);
    }

    private EditText newNumberEdit(String value) {
        EditText e = new EditText(this);
        e.setInputType(InputType.TYPE_CLASS_NUMBER);
        e.setGravity(Gravity.CENTER);
        e.setText(value);
        return e;
    }

    private LinearLayout timeRow(String label, EditText min, EditText sec, float density) {
        LinearLayout r = new LinearLayout(this);
        r.setOrientation(LinearLayout.HORIZONTAL);
        TextView l = new TextView(this);
        l.setText(label);
        TextView sep = new TextView(this);
        sep.setText(" : ");
        int fieldW = Math.round(56f * density);
        r.addView(l, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        r.addView(min, new LinearLayout.LayoutParams(fieldW, ViewGroup.LayoutParams.WRAP_CONTENT));
        r.addView(sep, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT));
        r.addView(sec, new LinearLayout.LayoutParams(fieldW, ViewGroup.LayoutParams.WRAP_CONTENT));
        return r;
    }

    private void applyFieldVisibility(int cmdIdx) {
        if (sectionTimeRow == null || sectionModeRow == null) {
            return;
        }
        boolean section = cmdIdx == 3;
        sectionTimeRow.setVisibility(section ? View.VISIBLE : View.GONE);
        sectionModeRow.setVisibility(section ? View.VISIBLE : View.GONE);
    }

    private Program currentProgram() {
        return programs.get(currentProgramIndex);
    }

    private void refreshProgramSpinner() {
        List<String> names = new ArrayList<String>();
        for (Program p : programs) {
            names.add(p.name);
        }
        ArrayAdapter<String> a = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, names);
        a.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        programSpinner.setAdapter(a);
        ignoreSpinner = true;
        programSpinner.setSelection(Math.min(currentProgramIndex, programs.size() - 1));
        ignoreSpinner = false;
        refreshProgramList();
    }

    private void setBuilderEnabled(boolean enabled) {
        cmdSpinner.setEnabled(enabled);
        trackSpinner.setEnabled(enabled);
        nEdit.setEnabled(enabled);
        repeatEdit.setEnabled(enabled);
        sleepEdit.setEnabled(enabled);
        shuffleCheck.setEnabled(enabled);
        shuffleAllButton.setEnabled(enabled);
        startMinEdit.setEnabled(enabled);
        startSecEdit.setEnabled(enabled);
        endMinEdit.setEnabled(enabled);
        endSecEdit.setEnabled(enabled);
        addButton.setEnabled(enabled);
        clearButton.setEnabled(enabled);
        newButton.setEnabled(enabled);
        deleteButton.setEnabled(enabled);
        exportButton.setEnabled(enabled);
        importButton.setEnabled(enabled);
    }

    private void switchProgram(int pos) {
        if (pos < 0 || pos >= programs.size()) return;
        currentProgramIndex = pos;
        refreshProgramList();
        setStatus("Switched to '" + programs.get(pos).name + "'.");
    }

    private void newProgram() {
        String base = "Program";
        String name = base + " " + (programs.size() + 1);
        int n = programs.size() + 1;
        while (programNameExists(name)) {
            n++;
            name = base + " " + n;
        }
        programs.add(new Program(name));
        currentProgramIndex = programs.size() - 1;
        autoSave();
        refreshProgramSpinner();
        applyFieldVisibility(cmdSpinner.getSelectedItemPosition());
        setStatus("Created new program.");
    }

    private boolean programNameExists(String name) {
        for (Program p : programs) {
            if (p.name != null && p.name.equals(name)) return true;
        }
        return false;
    }

    private void deleteProgram() {
        if (programs.size() <= 1) {
            toastShort("Keep at least one program.");
            return;
        }
        String removed = currentProgram().name;
        programs.remove(currentProgramIndex);
        if (currentProgramIndex >= programs.size()) currentProgramIndex = programs.size() - 1;
        autoSave();
        refreshProgramSpinner();
        setStatus("Deleted '" + removed + "'.");
    }

    private void refreshProgramList() {
        StringBuilder sb = new StringBuilder();
        List<Cmd> cmds = currentProgram().cmds;
        if (cmds.isEmpty()) {
            sb.append("(no steps yet)\n");
        } else {
            for (int i = 0; i < cmds.size(); i++) {
                sb.append(i + 1).append(". ").append(cmds.get(i).text).append('\n');
            }
        }
        programListView.setText(sb.toString());
    }

    private void addStep() {
        int cmdIdx = cmdSpinner.getSelectedItemPosition();
        int trackIdx = tracks.isEmpty() ? -1 : trackSpinner.getSelectedItemPosition();
        int n = parseInt(nEdit, 0);
        if (n < 0) n = 0;

        Cmd c;
        if (cmdIdx == 0) {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            if (n < 1) { toastShort("N must be >= 1."); return; }
            PlayCmd p = new PlayCmd();
            p.keyword = "PLAY";
            p.track = trackIdx;
            p.times = n;
            c = p;
        } else if (cmdIdx == 1) {
            PauseCmd p = new PauseCmd();
            p.keyword = "PAUSE";
            p.minutes = n;
            c = p;
        } else if (cmdIdx == 2) {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            if (n < 1) { toastShort("N must be >= 1."); return; }
            LoopCmd p = new LoopCmd();
            p.keyword = "LOOP";
            p.track = trackIdx;
            p.minutes = n;
            c = p;
        } else {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            int sm = clamp09(parseInt(startMinEdit, 0), 0, 59);
            int ss = clamp09(parseInt(startSecEdit, 0), 0, 59);
            int em = clamp09(parseInt(endMinEdit, 0), 0, 59);
            int es = clamp09(parseInt(endSecEdit, 0), 0, 59);
            long startMs = (sm * 60L + ss) * 1000L;
            long endMs = (em * 60L + es) * 1000L;
            if (endMs <= startMs) {
                toastShort("End must be after start.");
                return;
            }
            int mode = sectionModeSpinner.getSelectedItemPosition();
            SectionCmd p = new SectionCmd();
            p.keyword = "SECTION";
            p.track = trackIdx;
            p.startMs = startMs;
            p.endMs = endMs;
            if (mode == 0) {
                p.timed = true;
                p.minutes = n;
            } else {
                p.timed = false;
                p.times = n;
            }
            c = p;
        }
        c.text = CmdCodec.describe(c);
        currentProgram().cmds.add(c);
        refreshProgramList();
        setStatus("Added step " + currentProgram().cmds.size() + ".");
        autoSave();
    }

    private void launchPicker() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("audio/*");
        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        startActivityForResult(intent, REQ_PICK_TRACKS);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null) {
            return;
        }
        if (requestCode == REQ_PICK_TRACKS) {
            int before = tracks.size();
            if (data.getData() != null) {
                addTrack(data.getData());
            }
            ClipData clip = data.getClipData();
            if (clip != null) {
                for (int i = 0; i < clip.getItemCount(); i++) {
                    Uri uri = clip.getItemAt(i).getUri();
                    if (uri != null) {
                        addTrack(uri);
                    }
                }
            }
            if (tracks.size() != before) {
                refreshTrackList();
                refreshTrackSpinner();
                Toast.makeText(this, "Loaded " + (tracks.size() - before) + " track(s).",
                        Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "No new tracks selected.", Toast.LENGTH_SHORT).show();
            }
        } else if (requestCode == REQ_EXPORT) {
            Uri doc = data.getData();
            if (doc == null) return;
            try {
                String enc = CmdCodec.encodeProgram(currentProgram().cmds);
                Storage.writeUri(this, doc, enc);
                toastShort("Exported " + currentProgram().name + ".");
            } catch (Exception e) {
                toastLong("Export failed: " + e.getMessage());
            }
        } else if (requestCode == REQ_IMPORT) {
            Uri doc = data.getData();
            if (doc == null) return;
            try {
                String text = Storage.readUri(this, doc);
                List<Cmd> cmds = CmdCodec.decodeProgram(text);
                if (cmds.isEmpty()) {
                    toastShort("No commands found in file.");
                    return;
                }
                StringBuilder sb = new StringBuilder();
                for (Cmd c : cmds) sb.append(c.text).append('\n');
                String name = "Imported";
                int n = 1;
                while (programNameExists(name + " " + n)) n++;
                name = name + " " + n;
                Program p = new Program(name);
                p.cmds = cmds;
                programs.add(p);
                currentProgramIndex = programs.size() - 1;
                autoSave();
                refreshProgramSpinner();
                toastShort("Imported " + cmds.size() + " commands as '" + name + "'.");
            } catch (Exception e) {
                toastLong("Import failed: " + e.getMessage());
            }
        }
    }

    private void addTrack(Uri uri) {
        try {
            getContentResolver().takePersistableUriPermission(uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION);
        } catch (Exception ignored) {
        }
        tracks.add(uri);
        trackNames.add(queryDisplayName(uri));
    }

    private String queryDisplayName(Uri uri) {
        Cursor cursor = null;
        try {
            cursor = getContentResolver().query(uri, null, null, null, null);
            if (cursor != null && cursor.moveToFirst()) {
                int idx = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);
                if (idx >= 0) {
                    String name = cursor.getString(idx);
                    if (name != null && name.length() > 0) {
                        return name;
                    }
                }
            }
        } catch (Exception ignored) {
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        String last = uri.getLastPathSegment();
        if (last != null) {
            int slash = last.lastIndexOf('/');
            if (slash >= 0) last = last.substring(slash + 1);
        }
        return last != null && last.length() > 0 ? last : "track";
    }

    private void refreshTrackList() {
        StringBuilder sb = new StringBuilder();
        if (tracks.isEmpty()) {
            sb.append("No tracks loaded.\n");
        } else {
            for (int i = 0; i < tracks.size(); i++) {
                sb.append(i).append(". ").append(trackNames.get(i)).append('\n');
            }
        }
        trackListView.setText(sb.toString());
    }

    private void refreshTrackSpinner() {
        List<String> entries = new ArrayList<String>();
        if (tracks.isEmpty()) {
            entries.add("No tracks");
        } else {
            for (int i = 0; i < tracks.size(); i++) {
                entries.add(i + ": " + trackNames.get(i));
            }
        }
        ArrayAdapter<String> a = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, entries);
        a.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        trackSpinner.setAdapter(a);
        if (!tracks.isEmpty()) {
            trackSpinner.setSelection(0);
        }
    }

    private void autoSave() {
        if (SettingsActivity.autoSave(this)) {
            Storage.savePrograms(this, programs);
        }
    }

    private void setStatus(final String text) {
        statusView.setText(text);
    }

    private void toastShort(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }

    private void toastLong(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_LONG).show();
    }

    private static int parseInt(EditText et, int def) {
        return parseInt(et.getText().toString(), def);
    }

    private static int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    private static int clamp09(int v, int lo, int hi) {
        if (v < lo) v = lo;
        if (v > hi) v = hi;
        return v;
    }

    private static String fmtTime(int ms) {
        if (ms < 0) ms = 0;
        int total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\MainActivity.java'

    # ------------------------------------------------------------------
    # Debug keystore (generated if missing)
    # ------------------------------------------------------------------
    $Keystore = "$env:USERPROFILE\.android\debug.keystore"
    if (-not (Test-Path -LiteralPath $Keystore)) {
        New-Item -ItemType Directory -Force -Path (Split-Path $Keystore) | Out-Null
        keytool -genkeypair -keystore $Keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname 'CN=Android Debug,O=Android,C=US'
        Assert-Exit 'keytool (debug keystore generation)'
    }

    # Native stderr (javac deprecation note, d8 library warnings) is benign here;
    # tolerate it and rely on $LASTEXITCODE so the build never aborts on a note.
    $ErrorActionPreference = 'Continue'

    # ------------------------------------------------------------------
    # Build sequence (no Gradle, no AndroidX, no external libraries)
    # ------------------------------------------------------------------
    # 1. Package Manifest
    aapt2 link -I $AndroidJar --manifest AndroidManifest.xml --java . -o unaligned.apk
    Assert-Exit 'aapt2 link'

    # 2. Compile Java (Must use -source 8 -target 8)
    javac -source 8 -target 8 -bootclasspath $AndroidJar .\com\example\player\*.java
    Assert-Exit 'javac'

    # 3. Convert to Dex
    d8.bat .\com\example\player\*.class --output .
    Assert-Exit 'd8'

    # 4. Inject Dex into APK
    jar.exe uf unaligned.apk classes.dex
    Assert-Exit 'jar'

    # 5. Align
    zipalign.exe -f 4 unaligned.apk app-aligned.apk
    Assert-Exit 'zipalign'

    # 6. Sign
    apksigner.bat sign --ks $Keystore --ks-pass pass:android app-aligned.apk
    Assert-Exit 'apksigner sign'

    apksigner.bat verify app-aligned.apk
    Assert-Exit 'apksigner verify'

    $Apk = Join-Path (Get-Location).Path 'app-aligned.apk'
    Write-Host ''
    Write-Host "BUILD OK: $Apk"
    Write-Host "Install:  adb install -r `"$Apk`""
}
finally {
    Pop-Location
}
