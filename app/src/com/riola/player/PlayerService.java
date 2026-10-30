package com.riola.player;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.Icon;
import android.media.AudioAttributes;
import android.media.AudioFocusRequest;
import android.media.AudioManager;
import android.media.MediaMetadata;
import android.media.session.MediaSession;
import android.media.session.PlaybackState;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import android.os.SystemClock;

/**
 * Keeps the program running when the app is not on screen and puts transport
 * controls in the notification shade and on the lock screen.
 */
public class PlayerService extends Service implements Engine.Listener {

    public static final String ACT_ATTACH = "riola.attach";
    public static final String ACT_TOGGLE = "riola.toggle";
    public static final String ACT_NEXT   = "riola.next";
    public static final String ACT_PREV   = "riola.prev";
    public static final String ACT_STOP   = "riola.stop";

    private static final String CHANNEL = "riola.playback";
    private static final int NID = 4201;

    private Engine engine;
    private Prefs prefs;
    private AudioManager am;
    private AudioFocusRequest focus;
    private MediaSession session;
    private PowerManager.WakeLock wakeLock;
    private BroadcastReceiver noisy;
    private boolean started;
    private boolean pausedByFocus;
    private long lastPost;
    private String lastKey = "";

    @Override
    public void onCreate() {
        super.onCreate();
        prefs = new Prefs(this);
        engine = Engine.get(this);
        engine.addListener(this);
        am = (AudioManager) getSystemService(Context.AUDIO_SERVICE);

        NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        NotificationChannel ch = new NotificationChannel(CHANNEL, "Playback", NotificationManager.IMPORTANCE_LOW);
        ch.setDescription("Shows the running Riola program");
        ch.setShowBadge(false);
        ch.setSound(null, null);
        ch.enableVibration(false);
        nm.createNotificationChannel(ch);

        session = new MediaSession(this, "Riola");
        session.setCallback(new MediaSession.Callback() {
            @Override public void onPlay()           { engine.setPaused(false); }
            @Override public void onPause()          { engine.setPaused(true); }
            @Override public void onStop()           { engine.stop(); shutdown(); }
            @Override public void onSkipToNext()     { engine.next(); }
            @Override public void onSkipToPrevious() { engine.prev(); }
            @Override public void onSeekTo(long p)   { engine.seekTo((int) p); }
        });
        session.setActive(true);

        noisy = new BroadcastReceiver() {
            @Override public void onReceive(Context c, Intent i) {
                if (prefs.pauseUnplug() && engine.isRunning() && !engine.isPaused()) {
                    engine.setPaused(true);
                    engine.log("output disconnected - paused");
                }
            }
        };
        IntentFilter f = new IntentFilter(AudioManager.ACTION_AUDIO_BECOMING_NOISY);
        if (Build.VERSION.SDK_INT >= 33) registerReceiver(noisy, f, Context.RECEIVER_NOT_EXPORTED);
        else registerReceiver(noisy, f);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String a = intent == null ? ACT_ATTACH : intent.getAction();
        if (a == null) a = ACT_ATTACH;

        if (!started) {
            startForeground(NID, build());
            started = true;
            requestFocus();
            holdWakeLock(true);
        }

        if (ACT_TOGGLE.equals(a))      engine.togglePause();
        else if (ACT_NEXT.equals(a))   engine.next();
        else if (ACT_PREV.equals(a))   engine.prev();
        else if (ACT_STOP.equals(a))   { engine.stop(); shutdown(); return START_NOT_STICKY; }

        post(true);
        if (!engine.isRunning() && !ACT_ATTACH.equals(a)) shutdown();
        return START_NOT_STICKY;
    }

    @Override public IBinder onBind(Intent intent) { return null; }

    @Override
    public void onDestroy() {
        engine.removeListener(this);
        holdWakeLock(false);
        abandonFocus();
        try { unregisterReceiver(noisy); } catch (Exception e) { /* already gone */ }
        if (session != null) { session.setActive(false); session.release(); }
        started = false;
        super.onDestroy();
    }

    // ---- engine callbacks ------------------------------------------------
    @Override public void onState(Engine.St s) { post(false); }
    @Override public void onLog(String line) { }
    @Override public void onFinished(boolean completed) { shutdown(); }

    private void shutdown() {
        holdWakeLock(false);
        abandonFocus();
        started = false;
        stopForeground(Service.STOP_FOREGROUND_REMOVE);
        stopSelf();
    }

    // ---- notification ----------------------------------------------------
    private void post(boolean force) {
        if (!started) return;
        Engine.St s = engine.st;
        String key = s.stepTitle + "|" + s.stepDetail + "|" + s.paused + "|" + s.running + "|" + s.step;
        long now = SystemClock.elapsedRealtime();
        if (!force && key.equals(lastKey) && now - lastPost < 1000) return;
        lastKey = key;
        lastPost = now;
        NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        nm.notify(NID, build());
        updateSession(s);
    }

    private Notification build() {
        Engine.St s = engine.st;
        boolean playing = s.running && !s.paused;

        Intent open = new Intent(this, MainActivity.class)
                .setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        PendingIntent content = PendingIntent.getActivity(this, 0, open,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        StringBuilder sub = new StringBuilder();
        if (s.running) {
            sub.append(s.programName == null || s.programName.length() == 0 ? "Riola" : s.programName);
            if (!s.preview) sub.append("  .  step ").append(s.step + 1).append(" of ").append(s.steps);
            if (s.loopTotal < 0) sub.append("  .  loop ").append(s.loopDone + 1);
            else if (s.loopTotal > 1) sub.append("  .  loop ").append(s.loopDone + 1).append(" of ").append(s.loopTotal);
            if (s.stepRemainMs >= 0) sub.append("  .  ").append(Fmt.human(s.stepRemainMs)).append(" left");
            else if (s.repTotal > 1) sub.append("  .  pass ").append(Math.min(s.repDone + 1, s.repTotal))
                                        .append(" of ").append(s.repTotal);
        } else {
            sub.append("Idle");
        }

        Notification.Builder b = new Notification.Builder(this, CHANNEL)
                .setSmallIcon(R.drawable.ic_note)
                .setContentTitle(s.stepTitle == null || s.stepTitle.length() == 0 ? "Riola" : s.stepTitle)
                .setContentText(s.stepDetail)
                .setSubText(sub.toString())
                .setContentIntent(content)
                .setOngoing(s.running)
                .setOnlyAlertOnce(true)
                .setShowWhen(false)
                .setVisibility(Notification.VISIBILITY_PUBLIC)
                .setCategory(Notification.CATEGORY_TRANSPORT);

        b.addAction(action(R.drawable.ic_prev, "Previous", ACT_PREV));
        b.addAction(playing ? action(R.drawable.ic_pause, "Pause", ACT_TOGGLE)
                            : action(R.drawable.ic_play, "Play", ACT_TOGGLE));
        b.addAction(action(R.drawable.ic_next, "Next", ACT_NEXT));
        b.addAction(action(R.drawable.ic_stop, "Stop", ACT_STOP));

        Notification.MediaStyle style = new Notification.MediaStyle()
                .setShowActionsInCompactView(0, 1, 2);
        if (session != null) style.setMediaSession(session.getSessionToken());
        b.setStyle(style);

        if (s.durMs > 0) b.setProgress(s.durMs, s.posMs, false);
        return b.build();
    }

    private Notification.Action action(int icon, String title, String act) {
        PendingIntent pi = PendingIntent.getService(this, act.hashCode(),
                new Intent(this, PlayerService.class).setAction(act),
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        return new Notification.Action.Builder(Icon.createWithResource(this, icon), title, pi).build();
    }

    private void updateSession(Engine.St s) {
        if (session == null) return;
        try {
            session.setMetadata(new MediaMetadata.Builder()
                    .putString(MediaMetadata.METADATA_KEY_TITLE, s.stepTitle)
                    .putString(MediaMetadata.METADATA_KEY_ARTIST, s.programName)
                    .putString(MediaMetadata.METADATA_KEY_ALBUM, "Riola")
                    .putLong(MediaMetadata.METADATA_KEY_DURATION, s.durMs)
                    .build());
            int state = !s.running ? PlaybackState.STATE_STOPPED
                    : (s.paused ? PlaybackState.STATE_PAUSED : PlaybackState.STATE_PLAYING);
            session.setPlaybackState(new PlaybackState.Builder()
                    .setActions(PlaybackState.ACTION_PLAY | PlaybackState.ACTION_PAUSE
                            | PlaybackState.ACTION_PLAY_PAUSE | PlaybackState.ACTION_STOP
                            | PlaybackState.ACTION_SKIP_TO_NEXT | PlaybackState.ACTION_SKIP_TO_PREVIOUS
                            | PlaybackState.ACTION_SEEK_TO)
                    .setState(state, s.posMs, state == PlaybackState.STATE_PLAYING ? 1f : 0f)
                    .build());
        } catch (Exception e) { /* metadata is cosmetic */ }
    }

    // ---- audio focus and wake lock --------------------------------------
    private void requestFocus() {
        if (focus != null) return;
        AudioManager.OnAudioFocusChangeListener l = new AudioManager.OnAudioFocusChangeListener() {
            public void onAudioFocusChange(int change) {
                if (change == AudioManager.AUDIOFOCUS_LOSS) {
                    if (prefs.pauseOnFocus() && engine.isRunning() && !engine.isPaused()) {
                        pausedByFocus = true;
                        engine.setPaused(true);
                    }
                } else if (change == AudioManager.AUDIOFOCUS_LOSS_TRANSIENT) {
                    if (prefs.pauseOnFocus() && engine.isRunning() && !engine.isPaused()) {
                        pausedByFocus = true;
                        engine.setPaused(true);
                    }
                } else if (change == AudioManager.AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK) {
                    if (prefs.pauseOnFocus()) engine.setDuck(0.25f);
                } else if (change == AudioManager.AUDIOFOCUS_GAIN) {
                    engine.setDuck(1f);
                    if (pausedByFocus) {
                        pausedByFocus = false;
                        engine.setPaused(false);
                    }
                }
            }
        };
        focus = new AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                .setAudioAttributes(new AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build())
                .setWillPauseWhenDucked(false)
                .setOnAudioFocusChangeListener(l)
                .build();
        am.requestAudioFocus(focus);
    }

    private void abandonFocus() {
        if (focus != null) {
            am.abandonAudioFocusRequest(focus);
            focus = null;
        }
    }

    private void holdWakeLock(boolean on) {
        if (on) {
            if (!prefs.wakeLock() || wakeLock != null) return;
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "riola:program");
            wakeLock.setReferenceCounted(false);
            wakeLock.acquire(6L * 60L * 60L * 1000L);
        } else if (wakeLock != null) {
            try { if (wakeLock.isHeld()) wakeLock.release(); } catch (Exception e) { /* ignore */ }
            wakeLock = null;
        }
    }
}
