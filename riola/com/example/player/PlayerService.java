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
            stopEngine();
            ArrayList<String> uris = intent.getStringArrayListExtra(EXTRA_TRACK_URIS);
            ArrayList<String> nms = intent.getStringArrayListExtra(EXTRA_TRACK_NAMES);
            String enc = intent.getStringExtra(EXTRA_PROGRAM);
            tracks.clear();
            names.clear();
            if (uris != null) {
                for (String u : uris) {
                    tracks.add(Uri.parse(u));
                }
            }
            if (nms != null) {
                for (String n : nms) {
                    names.add(n == null ? "" : n);
                }
            }
            program = CmdCodec.decodeProgram(enc);
            currentStepText = "Loading...";
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

    private void stopEngine() {
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
        stopForeground(true);
        stopSelf();
    }

    private void executeProgram() {
        String endMessage;
        try {
            for (int pc = 0; pc < program.size() && running; pc++) {
                Cmd cmd = program.get(pc);
                if (cmd.track >= 0 && cmd.track >= tracks.size()) {
                    throw new IllegalArgumentException(cmd.keyword + ": track index "
                            + cmd.track + " out of range (loaded: " + tracks.size() + ")");
                }
                currentTrackName = trackName(cmd.track);
                setStatus("[" + pc + "/" + program.size() + "] " + cmd.text);
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
            paused = false;
            playComplete = false;
            playError = false;
            currentStepText = "Idle.";
            currentTrackName = "";
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

    private void setStatus(String text) {
        currentStepText = text;
        refreshNotification();
    }

    private void refreshNotification() {
        boolean playing = isPlayingLocked();
        int pos = 0;
        int dur = 0;
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
        int pos = 0;
        int dur = 0;
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
        Notification.Builder b = new Notification.Builder(this, CHANNEL_ID);
        b.setContentTitle("Programmable Player");
        b.setContentText(content);
        b.setSmallIcon(R.drawable.ic_notification);
        b.setOngoing(true);
        b.setShowWhen(false);
        b.setOnlyAlertOnce(true);

        Intent stop = new Intent(this, PlayerService.class).setAction(ACTION_STOP);
        Intent pa = new Intent(this, PlayerService.class)
                .setAction(playing ? ACTION_PAUSE : ACTION_RESUME);
        b.addAction(playing ? android.R.drawable.ic_media_pause : android.R.drawable.ic_media_play,
                playing ? "Pause" : "Play",
                PendingIntent.getService(this, piSeq(), pa, PendingIntent.FLAG_IMMUTABLE));
        b.addAction(android.R.drawable.ic_delete, "Stop",
                PendingIntent.getService(this, piSeq(), stop, PendingIntent.FLAG_IMMUTABLE));
        return b.build();
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

    private void doPlay(PlayCmd cmd) throws Exception {
        currentTrackName = trackName(cmd.track);
        for (int lap = 0; lap < cmd.times && running; lap++) {
            if (paused) {
                while (running && paused) Thread.sleep(100);
                if (!running) break;
            }
            MediaPlayer mp = prepareTrack(cmd.track, false);
            playComplete = false;
            playError = false;
            mp.start();
            awaitPlaybackDone();
            if (playError) {
                setStatus("Playback error on trk" + cmd.track + " (" + currentTrackName + ")");
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
            if (paused) {
                while (running && paused) Thread.sleep(100);
                if (!running) break;
                continue;
            }
            Thread.sleep(250);
        }
    }

    private void doLoop(LoopCmd cmd) throws Exception {
        currentTrackName = trackName(cmd.track);
        MediaPlayer mp = prepareTrack(cmd.track, true);
        playError = false;
        mp.start();
        long deadline = SystemClock.elapsedRealtime() + cmd.minutes * 60000L;
        while (running && SystemClock.elapsedRealtime() < deadline && !playError) {
            if (paused) {
                while (running && paused) Thread.sleep(100);
                if (!running) break;
                continue;
            }
            Thread.sleep(200);
        }
        if (playError) {
            setStatus("Playback error on trk" + cmd.track);
        }
        if (running && !playError) {
            quietStop(mp);
        }
    }

    private void doSection(SectionCmd cmd) throws Exception {
        currentTrackName = trackName(cmd.track);
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
            if (paused) {
                while (running && paused) Thread.sleep(100);
                if (!running) break;
                continue;
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
            setStatus("Playback error on trk" + cmd.track);
        }
        if (running && !playError) {
            quietStop(mp);
        }
    }

    private void awaitPlaybackDone() throws InterruptedException {
        while (running && !playComplete && !playError) {
            if (paused) {
                while (running && paused) Thread.sleep(100);
                if (!running) break;
            }
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

    private boolean isPlayingLocked() {
        synchronized (playerLock) {
            if (player == null) return false;
            try {
                return player.isPlaying();
            } catch (Exception e) {
                return false;
            }
        }
    }

    private void pauseCurrent() {
        synchronized (playerLock) {
            if (player != null) {
                try {
                    player.pause();
                } catch (Exception ignored) {
                }
            }
        }
    }

    private void resumeCurrent() {
        synchronized (playerLock) {
            if (player != null) {
                try {
                    if (!player.isPlaying()) {
                        player.start();
                    }
                } catch (Exception ignored) {
                }
            }
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
