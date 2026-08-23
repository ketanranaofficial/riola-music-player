param(
    [string]$Dir = ".\riola"
)

$ErrorActionPreference = 'Stop'

function Assert-Exit([string]$Step) {
    if ($LASTEXITCODE -ne 0) { throw "$Step failed (exit code $LASTEXITCODE)." }
}

if (-not $env:ANDROID_HOME -and $env:ANDROID_SDK_ROOT) { $env:ANDROID_HOME = $env:ANDROID_SDK_ROOT }
if (-not $env:ANDROID_HOME) { $env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk" }
$PlatformJar = Join-Path $env:ANDROID_HOME 'platforms\android-34\android.jar'
if (-not (Test-Path -LiteralPath $PlatformJar)) { throw "android-34 platform not found: $PlatformJar" }
foreach ($tool in @('aapt2', 'javac', 'd8.bat', 'jar.exe', 'zipalign.exe', 'apksigner.bat', 'keytool')) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) { throw "Required tool '$tool' not found in PATH." }
}

New-Item -ItemType Directory -Force -Path "$Dir\com\example\player" | Out-Null
Push-Location $Dir
try {
    Remove-Item -LiteralPath '.\unaligned.apk', '.\classes.dex', '.\programmable-player.apk', '.\riola.apk' -Force -ErrorAction SilentlyContinue
    Get-ChildItem '.\com\example\player\*.class' -ErrorAction SilentlyContinue | Remove-Item -Force

    # ------------------------------------------------------------------
    # AndroidManifest.xml
    # ------------------------------------------------------------------
    @'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.player">

    <uses-sdk android:minSdkVersion="21" android:targetSdkVersion="34" />

    <application
        android:label="Programmable Music Player"
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
    </application>

</manifest>
'@ | Out-File -Encoding ASCII -Force -FilePath 'AndroidManifest.xml'

    # ------------------------------------------------------------------
    # MainActivity.java
    # ------------------------------------------------------------------
    @'
package com.example.player;

import android.app.Activity;
import android.content.ClipData;
import android.content.Intent;
import android.database.Cursor;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.SystemClock;
import android.provider.OpenableColumns;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class MainActivity extends Activity {

    private static final int REQ_PICK_TRACKS = 41;

    private final List<Uri> tracks = new ArrayList<Uri>();
    private final List<String> trackNames = new ArrayList<String>();
    private final List<Cmd> program = new ArrayList<Cmd>();

    private TextView trackListView;
    private TextView programListView;
    private TextView statusView;
    private TextView positionView;

    private Spinner cmdSpinner;
    private Spinner trackSpinner;
    private Spinner sectionModeSpinner;
    private LinearLayout sectionTimeRow;
    private LinearLayout sectionModeRow;
    private EditText nEdit;
    private EditText startMinEdit;
    private EditText startSecEdit;
    private EditText endMinEdit;
    private EditText endSecEdit;
    private Button runButton;
    private Button stopButton;
    private Button addButton;
    private Button clearButton;

    private volatile boolean running = false;
    private Thread worker = null;
    private MediaPlayer player = null;
    private final Object playerLock = new Object();

    private volatile boolean playComplete = false;
    private volatile boolean playError = false;
    private volatile boolean seekDone = true;

    private Handler uiHandler;
    private final Runnable positionTicker = new Runnable() {
        @Override
        public void run() {
            if (running) {
                int pos = 0;
                int dur = 0;
                boolean playing = false;
                synchronized (playerLock) {
                    if (player != null) {
                        try {
                            playing = player.isPlaying();
                            pos = player.getCurrentPosition();
                            dur = player.getDuration();
                        } catch (Exception ignored) {
                        }
                    }
                }
                positionView.setText(playing ? (fmtTime(pos) + " / " + fmtTime(dur)) : "paused");
                uiHandler.postDelayed(this, 500);
            } else {
                positionView.setText("");
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setVolumeControlStream(AudioManager.STREAM_MUSIC);

        uiHandler = new Handler();

        float density = getResources().getDisplayMetrics().density;
        int pad = Math.round(16f * density);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);

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
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(130f * density)));

        TextView builderTitle = new TextView(this);
        builderTitle.setText("Build program (visual, no plain-text scripting):");
        builderTitle.setTextSize(14f);
        root.addView(builderTitle);

        LinearLayout cmdRow = new LinearLayout(this);
        cmdRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView cmdLabel = new TextView(this);
        cmdLabel.setText("Command");
        LinearLayout.LayoutParams half = new LinearLayout.LayoutParams(0,
                ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
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
        modeLabel.setText("Repeat");
        sectionModeSpinner = new Spinner(this);
        ArrayAdapter<String> modeAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item,
                new ArrayList<String>(Arrays.asList("FOR MIN", "N TIMES")));
        modeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sectionModeSpinner.setAdapter(modeAdapter);
        sectionModeSpinner.setSelection(0);
        sectionModeRow.addView(modeLabel, half);
        sectionModeRow.addView(sectionModeSpinner, half);
        root.addView(sectionModeRow);

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
                program.clear();
                refreshProgramList();
                setStatus("Program cleared.");
            }
        });
        actionRow.addView(addButton, half);
        actionRow.addView(clearButton, half);
        root.addView(actionRow);

        programListView = new TextView(this);
        programListView.setText("(no steps yet)\n");
        ScrollView programScroller = new ScrollView(this);
        programScroller.addView(programListView);
        root.addView(programScroller, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(170f * density)));

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
                haltWorker();
                setStatus("Stopped.");
            }
        });
        runRow.addView(runButton, half);
        runRow.addView(stopButton, half);
        root.addView(runRow);

        statusView = new TextView(this);
        statusView.setText("Idle.");
        statusView.setTextSize(13f);
        root.addView(statusView);

        setContentView(root);
        applyFieldVisibility(cmdSpinner.getSelectedItemPosition());
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
        if (requestCode != REQ_PICK_TRACKS || resultCode != RESULT_OK || data == null) {
            return;
        }
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

    private void addStep() {
        int cmdIdx = cmdSpinner.getSelectedItemPosition();
        int trackIdx = tracks.isEmpty() ? -1 : trackSpinner.getSelectedItemPosition();
        int n = parseIntSafe(nEdit);
        if (n < 0) n = 0;

        Cmd c;
        if (cmdIdx == 0) {
            if (trackIdx < 0) {
                toastShort("Pick a track first.");
                return;
            }
            if (n < 1) {
                toastShort("N must be >= 1.");
                return;
            }
            PlayCmd p = new PlayCmd();
            p.keyword = "PLAY";
            p.track = trackIdx;
            p.times = n;
            p.text = "PLAY  trk" + trackIdx + "  " + n + " TIMES";
            c = p;
        } else if (cmdIdx == 1) {
            PauseCmd p = new PauseCmd();
            p.keyword = "PAUSE";
            p.minutes = n;
            p.text = "PAUSE  " + n + " MIN";
            c = p;
        } else if (cmdIdx == 2) {
            if (trackIdx < 0) {
                toastShort("Pick a track first.");
                return;
            }
            if (n < 1) {
                toastShort("N must be >= 1.");
                return;
            }
            LoopCmd p = new LoopCmd();
            p.keyword = "LOOP";
            p.track = trackIdx;
            p.minutes = n;
            p.text = "LOOP  trk" + trackIdx + "  " + n + " MIN";
            c = p;
        } else {
            if (trackIdx < 0) {
                toastShort("Pick a track first.");
                return;
            }
            int sm = clamp09(parseIntSafe(startMinEdit), 0, 59);
            int ss = clamp09(parseIntSafe(startSecEdit), 0, 59);
            int em = clamp09(parseIntSafe(endMinEdit), 0, 59);
            int es = clamp09(parseIntSafe(endSecEdit), 0, 59);
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
                p.text = "SECTION  trk" + trackIdx + "  " + fmtMs(startMs) + " - "
                        + fmtMs(endMs) + "  FOR " + n + " MIN";
            } else {
                p.timed = false;
                p.times = n;
                p.text = "SECTION  trk" + trackIdx + "  " + fmtMs(startMs) + " - "
                        + fmtMs(endMs) + "  " + n + " TIMES";
            }
            c = p;
        }
        program.add(c);
        refreshProgramList();
        setStatus("Added step " + program.size() + ".");
    }

    private void refreshProgramList() {
        StringBuilder sb = new StringBuilder();
        if (program.isEmpty()) {
            sb.append("(no steps yet)\n");
        } else {
            for (int i = 0; i < program.size(); i++) {
                sb.append(i + 1).append(". ").append(program.get(i).text).append('\n');
            }
        }
        programListView.setText(sb.toString());
    }

    private void runProgram() {
        if (tracks.isEmpty()) {
            toastLong("Load at least one track first.");
            return;
        }
        if (program.isEmpty()) {
            toastShort("Add commands to the program first.");
            return;
        }
        haltWorker();
        running = true;
        runButton.setEnabled(false);
        stopButton.setEnabled(true);
        addButton.setEnabled(false);
        clearButton.setEnabled(false);
        uiHandler.post(positionTicker);
        final List<Cmd> snapshot = new ArrayList<Cmd>(program);
        worker = new Thread(new Runnable() {
            @Override
            public void run() {
                executeProgram(snapshot);
            }
        }, "script-engine");
        worker.start();
    }

    private void haltWorker() {
        running = false;
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
        uiHandler.removeCallbacks(positionTicker);
        releasePlayer();
        resetUi();
    }

    private void executeProgram(List<Cmd> prog) {
        String endMessage;
        try {
            for (int pc = 0; pc < prog.size() && running; pc++) {
                Cmd cmd = prog.get(pc);
                if (cmd.track >= 0 && cmd.track >= tracks.size()) {
                    throw new IllegalArgumentException(cmd.keyword + ": track index "
                            + cmd.track + " out of range (loaded: " + tracks.size() + ")");
                }
                setStatus("[" + pc + "/" + prog.size() + "] " + cmd.text);
                if (cmd instanceof PlayCmd) {
                    doPlay((PlayCmd) cmd);
                } else if (cmd instanceof PauseCmd) {
                    doPause((PauseCmd) cmd);
                } else if (cmd instanceof LoopCmd) {
                    doLoop((LoopCmd) cmd);
                } else if (cmd instanceof SectionCmd) {
                    doSection((SectionCmd) cmd);
                }
            }
            endMessage = running ? "Program finished." : "Program halted.";
        } catch (InterruptedException lost) {
            endMessage = "Program halted.";
        } catch (Exception ex) {
            String msg = ex.getMessage();
            endMessage = "ERROR: " + (msg == null ? ex.getClass().getSimpleName() : msg);
        } finally {
            releasePlayer();
            running = false;
            uiHandler.post(new Runnable() {
                @Override
                public void run() {
                    resetUi();
                }
            });
        }
        setStatus(endMessage);
    }

    private void doPlay(PlayCmd cmd) throws Exception {
        for (int lap = 0; lap < cmd.times && running; lap++) {
            MediaPlayer mp = prepareTrack(cmd.track, false);
            playComplete = false;
            playError = false;
            mp.start();
            awaitPlaybackDone();
            if (playError) {
                setStatus("Playback error on track " + cmd.track + " ("
                        + trackNames.get(cmd.track) + ")");
                break;
            }
            if (!running) {
                quietStop(mp);
            }
        }
    }

    private void doPause(PauseCmd cmd) throws InterruptedException {
        releasePlayer();
        long deadline = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        while (running && SystemClock.elapsedRealtime() < deadline) {
            Thread.sleep(250);
        }
    }

    private void doLoop(LoopCmd cmd) throws Exception {
        MediaPlayer mp = prepareTrack(cmd.track, true);
        playError = false;
        mp.start();
        long deadline = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        while (running && SystemClock.elapsedRealtime() < deadline && !playError) {
            Thread.sleep(200);
        }
        if (playError) {
            setStatus("Playback error on track " + cmd.track);
        }
        if (running && !playError) {
            quietStop(mp);
        }
    }

    private void doSection(SectionCmd cmd) throws Exception {
        MediaPlayer mp = prepareTrack(cmd.track, false);
        playError = false;
        playComplete = false;
        seekDone = false;
        mp.seekTo((int) cmd.startMs);
        waitSeek();
        if (!running || playError) {
            if (running) quietStop(mp);
            return;
        }
        mp.start();
        long duration = mp.getDuration();
        long startMs = cmd.startMs;
        long endMs = cmd.endMs;
        if (startMs > duration) startMs = 0;
        if (endMs > duration) endMs = duration;
        if (endMs <= startMs) {
            startMs = 0;
            endMs = duration;
        }
        long deadline = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        int laps = 0;
        while (running && !playError) {
            if (cmd.timed && SystemClock.elapsedRealtime() >= deadline) {
                break;
            }
            if (!cmd.timed && laps >= cmd.times) {
                break;
            }
            int pos = mp.getCurrentPosition();
            if (pos + 50 >= (int) endMs) {
                laps++;
                if (!cmd.timed && laps >= cmd.times) {
                    break;
                }
                seekDone = false;
                mp.seekTo((int) startMs);
                waitSeek();
                if (running && !playError) {
                    mp.start();
                }
            } else {
                Thread.sleep(100);
            }
        }
        if (playError) {
            setStatus("Playback error on track " + cmd.track);
        }
        if (running && !playError) {
            quietStop(mp);
        }
    }

    private void awaitPlaybackDone() throws InterruptedException {
        while (running && !playComplete && !playError) {
            Thread.sleep(50);
        }
    }

    private MediaPlayer prepareTrack(int index, boolean looping) throws Exception {
        MediaPlayer mp = acquirePlayer();
        synchronized (playerLock) {
            mp.reset();
            AudioAttributes attrs = new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build();
            mp.setAudioAttributes(attrs);
            mp.setLooping(looping);
            mp.setDataSource(this, tracks.get(index));
            mp.prepare();
        }
        return mp;
    }

    private void waitSeek() throws InterruptedException {
        long waited = 0;
        while (running && !seekDone && waited < 3000 && !playError) {
            Thread.sleep(25);
            waited += 25;
        }
    }

    private MediaPlayer acquirePlayer() {
        synchronized (playerLock) {
            if (player == null) {
                player = new MediaPlayer();
                player.setOnSeekCompleteListener(new MediaPlayer.OnSeekCompleteListener() {
                    @Override
                    public void onSeekComplete(MediaPlayer mp) {
                        seekDone = true;
                    }
                });
                player.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                    @Override
                    public void onCompletion(MediaPlayer mp) {
                        playComplete = true;
                    }
                });
                player.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                    @Override
                    public boolean onError(MediaPlayer mp, int what, int extra) {
                        playError = true;
                        playComplete = true;
                        return true;
                    }
                });
            }
            return player;
        }
    }

    private void quietStop(MediaPlayer mp) {
        try {
            mp.stop();
        } catch (Exception ignored) {
        }
    }

    private void releasePlayer() {
        synchronized (playerLock) {
            MediaPlayer mp = player;
            player = null;
            if (mp != null) {
                try {
                    mp.stop();
                } catch (Exception ignored) {
                }
                try {
                    mp.reset();
                } catch (Exception ignored) {
                }
                try {
                    mp.release();
                } catch (Exception ignored) {
                }
            }
        }
    }

    private void resetUi() {
        uiHandler.removeCallbacks(positionTicker);
        positionView.setText("");
        runButton.setEnabled(true);
        stopButton.setEnabled(false);
        addButton.setEnabled(true);
        clearButton.setEnabled(true);
    }

    private void setStatus(final String text) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                statusView.setText(text);
            }
        });
    }

    private void toastShort(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }

    private void toastLong(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_LONG).show();
    }

    private static int parseIntSafe(EditText et) {
        try {
            return Integer.parseInt(et.getText().toString().trim());
        } catch (Exception e) {
            return 0;
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

    private static String fmtMs(long ms) {
        if (ms < 0) ms = 0;
        long total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }

    @Override
    protected void onDestroy() {
        haltWorker();
        super.onDestroy();
    }

    // ----- command model -----

    static abstract class Cmd {
        String keyword;
        String text;
        int track = -1;
    }

    static final class PlayCmd extends Cmd {
        int times;
    }

    static final class PauseCmd extends Cmd {
        long minutes;
    }

    static final class LoopCmd extends Cmd {
        long minutes;
    }

    static final class SectionCmd extends Cmd {
        long startMs;
        long endMs;
        boolean timed;
        long minutes;
        int times;
    }
}
'@ | Out-File -Encoding ASCII -Force -FilePath '.\com\example\player\MainActivity.java'

    # ------------------------------------------------------------------
    # Debug keystore (generated if missing)
    # ------------------------------------------------------------------
    $Keystore = Join-Path $env:USERPROFILE '.android\debug.keystore'
    if (-not (Test-Path -LiteralPath $Keystore)) {
        New-Item -ItemType Directory -Force -Path (Split-Path $Keystore) | Out-Null
        keytool -genkeypair -keystore $Keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname 'CN=Android Debug,O=Android,C=US'
        Assert-Exit 'keytool (debug keystore generation)'
    }

    # ------------------------------------------------------------------
    # Compile sequence (no Gradle, no AndroidX, no AppCompat)
    # ------------------------------------------------------------------
    aapt2 link -I $PlatformJar --manifest AndroidManifest.xml --java . -o unaligned.apk
    Assert-Exit 'aapt2 link'

    javac -source 8 -target 8 -bootclasspath $PlatformJar -nowarn .\com\example\player\*.java
    Assert-Exit 'javac'

    d8.bat --lib $PlatformJar .\com\example\player\*.class --output .
    Assert-Exit 'd8'

    jar.exe uf unaligned.apk classes.dex
    Assert-Exit 'jar'

    zipalign.exe -f 4 unaligned.apk programmable-player.apk
    Assert-Exit 'zipalign'

    apksigner.bat sign --ks $Keystore --ks-pass pass:android programmable-player.apk
    Assert-Exit 'apksigner sign'

    apksigner.bat verify programmable-player.apk
    Assert-Exit 'apksigner verify'

    $Apk = Join-Path (Get-Location).Path 'programmable-player.apk'
    Write-Host ''
    Write-Host "BUILD OK: $Apk"
    Write-Host "Install:  adb install -r `"$Apk`""
}
finally {
    Pop-Location
}
