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

/* JADX INFO: loaded from: classes.dex */
public class PlayerService extends Service implements Engine.Listener {
    public static final String ACT_ATTACH = "riola.attach";
    public static final String ACT_NEXT = "riola.next";
    public static final String ACT_PREV = "riola.prev";
    public static final String ACT_STOP = "riola.stop";
    public static final String ACT_TOGGLE = "riola.toggle";
    private static final String CHANNEL = "riola.playback";
    private static final int NID = 4201;
    private AudioManager am;
    private Engine engine;
    private AudioFocusRequest focus;
    private String lastKey = "";
    private long lastPost;
    private BroadcastReceiver noisy;
    private boolean pausedByFocus;
    private Prefs prefs;
    private MediaSession session;
    private boolean started;
    private PowerManager.WakeLock wakeLock;

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.prefs = new Prefs(this);
        Engine engine = Engine.get(this);
        this.engine = engine;
        engine.addListener(this);
        this.am = (AudioManager) getSystemService("audio");
        NotificationManager notificationManager = (NotificationManager) getSystemService("notification");
        NotificationChannel notificationChannel = new NotificationChannel(CHANNEL, "Playback", 2);
        notificationChannel.setDescription("Shows the running Riola program");
        notificationChannel.setShowBadge(false);
        notificationChannel.setSound(null, null);
        notificationChannel.enableVibration(false);
        notificationManager.createNotificationChannel(notificationChannel);
        MediaSession mediaSession = new MediaSession(this, "Riola");
        this.session = mediaSession;
        mediaSession.setCallback(new MediaSession.Callback() { // from class: com.riola.player.PlayerService.1
            @Override // android.media.session.MediaSession.Callback
            public void onPlay() {
                PlayerService.this.engine.setPaused(false);
            }

            @Override // android.media.session.MediaSession.Callback
            public void onPause() {
                PlayerService.this.engine.setPaused(true);
            }

            @Override // android.media.session.MediaSession.Callback
            public void onStop() {
                PlayerService.this.engine.stop();
                PlayerService.this.shutdown();
            }

            @Override // android.media.session.MediaSession.Callback
            public void onSkipToNext() {
                PlayerService.this.engine.next();
            }

            @Override // android.media.session.MediaSession.Callback
            public void onSkipToPrevious() {
                PlayerService.this.engine.prev();
            }

            @Override // android.media.session.MediaSession.Callback
            public void onSeekTo(long j) {
                PlayerService.this.engine.seekTo((int) j);
            }
        });
        this.session.setActive(true);
        this.noisy = new BroadcastReceiver() { // from class: com.riola.player.PlayerService.2
            @Override // android.content.BroadcastReceiver
            public void onReceive(Context context, Intent intent) {
                if (PlayerService.this.prefs.pauseUnplug() && PlayerService.this.engine.isRunning() && !PlayerService.this.engine.isPaused()) {
                    PlayerService.this.engine.setPaused(true);
                    PlayerService.this.engine.log("output disconnected - paused");
                }
            }
        };
        IntentFilter intentFilter = new IntentFilter("android.media.AUDIO_BECOMING_NOISY");
        if (Build.VERSION.SDK_INT < 33) {
            registerReceiver(this.noisy, intentFilter);
        } else {
            registerReceiver(this.noisy, intentFilter, 4);
        }
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        String action = intent == null ? ACT_ATTACH : intent.getAction();
        if (action == null) {
            action = ACT_ATTACH;
        }
        if (!this.started) {
            startForeground(NID, build());
            this.started = true;
            requestFocus();
            holdWakeLock(true);
        }
        if (ACT_TOGGLE.equals(action)) {
            this.engine.togglePause();
        } else if (ACT_NEXT.equals(action)) {
            this.engine.next();
        } else if (ACT_PREV.equals(action)) {
            this.engine.prev();
        } else if (ACT_STOP.equals(action)) {
            this.engine.stop();
            shutdown();
            return 2;
        }
        post(true);
        if (!this.engine.isRunning() && !ACT_ATTACH.equals(action)) {
            shutdown();
        }
        return 2;
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onDestroy() {
        this.engine.removeListener(this);
        holdWakeLock(false);
        abandonFocus();
        try {
            unregisterReceiver(this.noisy);
        } catch (Exception e) {
        }
        MediaSession mediaSession = this.session;
        if (mediaSession != null) {
            mediaSession.setActive(false);
            this.session.release();
        }
        this.started = false;
        super.onDestroy();
    }

    @Override // com.riola.player.Engine.Listener
    public void onState(Engine.St st) {
        post(false);
    }

    @Override // com.riola.player.Engine.Listener
    public void onLog(String str) {
    }

    @Override // com.riola.player.Engine.Listener
    public void onFinished(boolean z) {
        shutdown();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void shutdown() {
        holdWakeLock(false);
        abandonFocus();
        this.started = false;
        stopForeground(1);
        stopSelf();
    }

    private void post(boolean z) {
        if (this.started) {
            Engine.St st = this.engine.st;
            String str = st.stepTitle + "|" + st.stepDetail + "|" + st.paused + "|" + st.running + "|" + st.step;
            long jElapsedRealtime = SystemClock.elapsedRealtime();
            if (z || !str.equals(this.lastKey) || jElapsedRealtime - this.lastPost >= 1000) {
                this.lastKey = str;
                this.lastPost = jElapsedRealtime;
                ((NotificationManager) getSystemService("notification")).notify(NID, build());
                updateSession(st);
            }
        }
    }

    private Notification build() {
        Engine.St st = this.engine.st;
        boolean z = st.running && !st.paused;
        PendingIntent activity = PendingIntent.getActivity(this, 0, new Intent(this, (Class<?>) MainActivity.class).setFlags(805306368), 201326592);
        StringBuilder sb = new StringBuilder();
        String str = "Riola";
        if (st.running) {
            sb.append((st.programName == null || st.programName.length() == 0) ? "Riola" : st.programName);
            if (!st.preview) {
                sb.append("  .  step ").append(st.step + 1).append(" of ").append(st.steps);
            }
            if (st.loopTotal < 0) {
                sb.append("  .  loop ").append(st.loopDone + 1);
            } else if (st.loopTotal > 1) {
                sb.append("  .  loop ").append(st.loopDone + 1).append(" of ").append(st.loopTotal);
            }
            if (st.stepRemainMs >= 0) {
                sb.append("  .  ").append(Fmt.human(st.stepRemainMs)).append(" left");
            } else if (st.repTotal > 1) {
                sb.append("  .  pass ").append(Math.min(st.repDone + 1, st.repTotal)).append(" of ").append(st.repTotal);
            }
        } else {
            sb.append("Idle");
        }
        Notification.Builder smallIcon = new Notification.Builder(this, CHANNEL).setSmallIcon(R.drawable.ic_note);
        if (st.stepTitle != null && st.stepTitle.length() != 0) {
            str = st.stepTitle;
        }
        Notification.Builder category = smallIcon.setContentTitle(str).setContentText(st.stepDetail).setSubText(sb.toString()).setContentIntent(activity).setOngoing(st.running).setOnlyAlertOnce(true).setShowWhen(false).setVisibility(1).setCategory("transport");
        category.addAction(action(R.drawable.ic_prev, "Previous", ACT_PREV));
        category.addAction(z ? action(R.drawable.ic_pause, "Pause", ACT_TOGGLE) : action(R.drawable.ic_play, "Play", ACT_TOGGLE));
        category.addAction(action(R.drawable.ic_next, "Next", ACT_NEXT));
        category.addAction(action(R.drawable.ic_stop, "Stop", ACT_STOP));
        Notification.MediaStyle showActionsInCompactView = new Notification.MediaStyle().setShowActionsInCompactView(0, 1, 2);
        MediaSession mediaSession = this.session;
        if (mediaSession != null) {
            showActionsInCompactView.setMediaSession(mediaSession.getSessionToken());
        }
        category.setStyle(showActionsInCompactView);
        if (st.durMs > 0) {
            category.setProgress(st.durMs, st.posMs, false);
        }
        return category.build();
    }

    private Notification.Action action(int i, String str, String str2) {
        return new Notification.Action.Builder(Icon.createWithResource(this, i), str, PendingIntent.getService(this, str2.hashCode(), new Intent(this, (Class<?>) PlayerService.class).setAction(str2), 201326592)).build();
    }

    private void updateSession(Engine.St st) {
        int i;
        MediaSession mediaSession = this.session;
        if (mediaSession == null) {
            return;
        }
        try {
            mediaSession.setMetadata(new MediaMetadata.Builder().putString("android.media.metadata.TITLE", st.stepTitle).putString("android.media.metadata.ARTIST", st.programName).putString("android.media.metadata.ALBUM", "Riola").putLong("android.media.metadata.DURATION", st.durMs).build());
            if (st.running) {
                i = st.paused ? 2 : 3;
            } else {
                i = 1;
            }
            this.session.setPlaybackState(new PlaybackState.Builder().setActions(823L).setState(i, st.posMs, i == 3 ? 1.0f : 0.0f).build());
        } catch (Exception e) {
        }
    }

    private void requestFocus() {
        if (this.focus != null) {
            return;
        }
        AudioFocusRequest audioFocusRequestBuild = new AudioFocusRequest.Builder(1).setAudioAttributes(new AudioAttributes.Builder().setUsage(1).setContentType(2).build()).setWillPauseWhenDucked(false).setOnAudioFocusChangeListener(new AudioManager.OnAudioFocusChangeListener() { // from class: com.riola.player.PlayerService.3
            @Override // android.media.AudioManager.OnAudioFocusChangeListener
            public void onAudioFocusChange(int i) {
                if (i == -1) {
                    if (PlayerService.this.prefs.pauseOnFocus() && PlayerService.this.engine.isRunning() && !PlayerService.this.engine.isPaused()) {
                        PlayerService.this.pausedByFocus = true;
                        PlayerService.this.engine.setPaused(true);
                        return;
                    }
                    return;
                }
                if (i == -2) {
                    if (PlayerService.this.prefs.pauseOnFocus() && PlayerService.this.engine.isRunning() && !PlayerService.this.engine.isPaused()) {
                        PlayerService.this.pausedByFocus = true;
                        PlayerService.this.engine.setPaused(true);
                        return;
                    }
                    return;
                }
                if (i == -3) {
                    if (PlayerService.this.prefs.pauseOnFocus()) {
                        PlayerService.this.engine.setDuck(0.25f);
                    }
                } else if (i == 1) {
                    PlayerService.this.engine.setDuck(1.0f);
                    if (PlayerService.this.pausedByFocus) {
                        PlayerService.this.pausedByFocus = false;
                        PlayerService.this.engine.setPaused(false);
                    }
                }
            }
        }).build();
        this.focus = audioFocusRequestBuild;
        this.am.requestAudioFocus(audioFocusRequestBuild);
    }

    private void abandonFocus() {
        AudioFocusRequest audioFocusRequest = this.focus;
        if (audioFocusRequest != null) {
            this.am.abandonAudioFocusRequest(audioFocusRequest);
            this.focus = null;
        }
    }

    private void holdWakeLock(boolean z) {
        if (z) {
            if (!this.prefs.wakeLock() || this.wakeLock != null) {
                return;
            }
            PowerManager.WakeLock wakeLockNewWakeLock = ((PowerManager) getSystemService("power")).newWakeLock(1, "riola:program");
            this.wakeLock = wakeLockNewWakeLock;
            wakeLockNewWakeLock.setReferenceCounted(false);
            this.wakeLock.acquire(21600000L);
            return;
        }
        PowerManager.WakeLock wakeLock = this.wakeLock;
        if (wakeLock != null) {
            try {
                if (wakeLock.isHeld()) {
                    this.wakeLock.release();
                }
            } catch (Exception e) {
            }
            this.wakeLock = null;
        }
    }
}
