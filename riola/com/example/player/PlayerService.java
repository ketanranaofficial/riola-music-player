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
