package com.riola.player;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.media.PlaybackParams;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArrayList;

/* JADX INFO: loaded from: classes.dex */
public class Engine {
    private static Engine I;
    private volatile boolean completed;
    private final Context ctx;
    private volatile int gen;
    private volatile int idx;
    private MediaPlayer mp;
    private volatile int[] order;
    private volatile boolean paused;
    private final Prefs prefs;
    private volatile boolean pushPending;
    private volatile boolean running;
    private volatile boolean shuffled;
    private volatile int skip;
    private volatile boolean stopReq;
    private Thread worker;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final Object lock = new Object();
    private final CopyOnWriteArrayList<Listener> listeners = new CopyOnWriteArrayList<>();
    private final StringBuilder logBuf = new StringBuilder();
    public final St st = new St();
    private final Bell bell = new Bell();
    private String loadedUri = "";
    private final List<Step> steps = new ArrayList();
    private int loops = 1;
    private volatile int jump = -1;
    private volatile float duck = 1.0f;
    private volatile float gain = 1.0f;
    private volatile float vol = 1.0f;
    private volatile float speed = 1.0f;
    private volatile float stepVol = 1.0f;
    private volatile float stepSpeed = 1.0f;
    private volatile long fadeMs = 150;
    private volatile long deadline = -1;

    public interface Listener {
        void onFinished(boolean z);

        void onLog(String str);

        void onState(St st);
    }

    public static class St {
        public int durMs;
        public int loopDone;
        public boolean paused;
        public int posMs;
        public boolean preview;
        public int repDone;
        public boolean resting;
        public boolean running;
        public boolean shuffled;
        public int skipped;
        public int step;
        public int steps;
        public String programId = "";
        public String programName = "";
        public String stepTitle = "";
        public String stepDetail = "";
        public String trackUri = "";
        public long stepRemainMs = -1;
        public long progRemainMs = -1;
        public int repTotal = -1;
        public int loopTotal = 1;
        public int countIn = -1;
    }

    public static synchronized Engine get(Context context) {
        if (I == null) {
            I = new Engine(context.getApplicationContext());
        }
        return I;
    }

    private Engine(Context context) {
        this.ctx = context;
        this.prefs = new Prefs(context);
    }

    public void addListener(Listener listener) {
        if (listener == null || this.listeners.contains(listener)) {
            return;
        }
        this.listeners.add(listener);
    }

    public void removeListener(Listener listener) {
        this.listeners.remove(listener);
    }

    public boolean isRunning() {
        return this.running;
    }

    public boolean isPaused() {
        return this.paused;
    }

    public String logText() {
        String string;
        synchronized (this.logBuf) {
            string = this.logBuf.toString();
        }
        return string;
    }

    public void clearLog() {
        synchronized (this.logBuf) {
            this.logBuf.setLength(0);
        }
    }

    public boolean isPlaying(Program program) {
        return this.running && program != null && program.id.equals(this.st.programId);
    }

    public void start(Program program, int i) {
        if (program == null) {
            return;
        }
        if (program.enabledCount() == 0) {
            log("nothing to play - every step is switched off");
            return;
        }
        stop();
        this.steps.clear();
        for (int i2 = 0; i2 < program.steps.size(); i2++) {
            this.steps.add(program.steps.get(i2).copy());
        }
        this.loops = program.loops;
        this.st.programId = program.id;
        this.st.programName = program.name;
        this.st.preview = false;
        begin(Math.max(0, Math.min(i, this.steps.size() - 1)));
    }

    public void previewTrack(Track track) {
        if (track == null) {
            return;
        }
        stop();
        this.steps.clear();
        this.steps.add(Step.play(track));
        this.loops = 1;
        this.st.programId = "";
        this.st.programName = "Preview";
        this.st.preview = true;
        begin(0);
    }

    private void begin(int i) {
        this.vol = this.prefs.volume() / 100.0f;
        this.speed = this.prefs.speed();
        this.fadeMs = this.prefs.fadeMs();
        this.duck = 1.0f;
        this.gain = 1.0f;
        this.stepVol = 1.0f;
        this.stepSpeed = 1.0f;
        buildOrder(this.shuffled, -1);
        this.idx = i;
        if (this.shuffled) {
            for (int i2 = 0; i2 < this.order.length; i2++) {
                if (this.order[i2] == i) {
                    this.idx = i2;
                    break;
                }
            }
        }
        this.st.shuffled = this.shuffled;
        this.stopReq = false;
        this.paused = false;
        this.skip = 0;
        this.jump = -1;
        this.running = true;
        this.st.running = true;
        this.st.paused = false;
        this.st.steps = this.steps.size();
        this.st.step = this.idx;
        this.st.loopDone = 0;
        this.st.loopTotal = this.loops;
        this.st.countIn = -1;
        this.st.skipped = 0;
        int iAutoStopMin = this.st.preview ? 0 : this.prefs.autoStopMin();
        this.deadline = iAutoStopMin > 0 ? SystemClock.elapsedRealtime() + (((long) iAutoStopMin) * 60000) : -1L;
        final int i3 = this.gen + 1;
        this.gen = i3;
        Thread thread = new Thread(new Runnable() { // from class: com.riola.player.Engine.1
            @Override // java.lang.Runnable
            public void run() {
                Engine.this.loop(i3);
            }
        }, "riola-engine");
        thread.setPriority(6);
        this.worker = thread;
        thread.start();
    }

    public void stop() {
        Thread thread = this.worker;
        this.stopReq = true;
        this.paused = false;
        wake();
        if (thread != null && thread.isAlive() && Thread.currentThread() != thread) {
            try {
                thread.join(2000L);
            } catch (InterruptedException e) {
            }
        }
        this.worker = null;
        this.running = false;
        this.bell.stop();
        releasePlayer();
        this.st.running = false;
        this.st.paused = false;
        this.st.resting = false;
        this.st.posMs = 0;
        this.st.durMs = 0;
        this.st.stepRemainMs = -1L;
        this.st.progRemainMs = -1L;
        this.st.repTotal = -1;
        this.st.countIn = -1;
        push();
    }

    public void setPaused(boolean z) {
        if (!this.running || this.paused == z) {
            return;
        }
        this.paused = z;
        this.st.paused = z;
        if (z) {
            this.bell.stop();
        }
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer != null) {
            try {
                if (!z) {
                    mediaPlayer.start();
                    applySpeed();
                } else if (mediaPlayer.isPlaying()) {
                    mediaPlayer.pause();
                }
            } catch (IllegalStateException e) {
            }
        }
        log(z ? "paused" : "resumed");
        wake();
        push();
    }

    public void togglePause() {
        setPaused(!this.paused);
    }

    public void next() {
        if (this.running) {
            this.skip = 1;
            wake();
        }
    }

    public void prev() {
        if (this.running) {
            this.skip = -1;
            wake();
        }
    }

    public void jumpTo(int i) {
        if (!this.running || i < 0 || i >= this.steps.size()) {
            return;
        }
        int[] iArr = this.order;
        if (iArr != null) {
            for (int i2 = 0; i2 < iArr.length; i2++) {
                if (iArr[i2] == i) {
                    i = i2;
                    break;
                }
            }
        }
        this.jump = i;
        this.skip = 2;
        wake();
    }

    public void seekTo(int i) {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return;
        }
        try {
            mediaPlayer.seekTo(i);
        } catch (IllegalStateException e) {
        }
    }

    public boolean isShuffled() {
        return this.shuffled;
    }

    public void setShuffle(boolean z) {
        this.shuffled = z;
        this.st.shuffled = z;
        if (!this.running || this.order == null) {
            push();
            return;
        }
        int i = (this.idx < 0 || this.idx >= this.order.length) ? 0 : this.order[this.idx];
        buildOrder(z, i);
        this.idx = z ? 0 : i;
        log(z ? "shuffled" : "back to the written order");
        push();
    }

    private void buildOrder(boolean z, int i) {
        int size = this.steps.size();
        int[] iArr = new int[size];
        for (int i2 = 0; i2 < size; i2++) {
            iArr[i2] = i2;
        }
        if (z && size > 1) {
            Random random = new Random();
            for (int i3 = size - 1; i3 > 0; i3--) {
                int iNextInt = random.nextInt(i3 + 1);
                int i4 = iArr[i3];
                iArr[i3] = iArr[iNextInt];
                iArr[iNextInt] = i4;
            }
            if (i >= 0) {
                for (int i5 = 0; i5 < size; i5++) {
                    int i6 = iArr[i5];
                    if (i6 == i) {
                        int i7 = iArr[0];
                        iArr[0] = i6;
                        iArr[i5] = i7;
                        break;
                    }
                }
            }
        }
        this.order = iArr;
    }

    public void setDuck(float f) {
        this.duck = f;
        applyVol();
    }

    public void setMasterVolume(int i) {
        this.vol = i / 100.0f;
        applyVol();
    }

    public void setMasterSpeed(int i) {
        this.speed = i / 100.0f;
        applySpeed();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void loop(final int i) {
        int i2;
        int i3;
        log("started: " + this.st.programName);
        countIn();
        int i4 = 0;
        int i5 = 0;
        while (true) {
            if (this.stopReq || expired()) {
                break;
            }
            if (this.order == null || this.idx >= this.order.length) {
                i5++;
                if (i4 == 0 || ((i2 = this.loops) >= 0 && i5 >= Math.max(1, i2))) {
                    break;
                }
                if (this.shuffled) {
                    buildOrder(true, -1);
                }
                this.idx = 0;
                this.st.loopDone = i5;
                log("loop " + (i5 + 1) + (this.loops >= 0 ? " of " + this.loops : ""));
                i4 = 0;
            } else {
                if (this.idx < 0) {
                    this.idx = 0;
                }
                int i6 = this.order[this.idx];
                Step step = this.steps.get(i6);
                if (!step.enabled) {
                    this.idx++;
                } else {
                    int i7 = i4 + 1;
                    this.st.step = i6;
                    this.st.steps = this.steps.size();
                    this.st.stepTitle = step.title();
                    this.st.stepDetail = step.detail();
                    this.st.trackUri = step.needsTrack() ? step.trackUri : "";
                    this.st.repDone = 0;
                    this.st.posMs = 0;
                    this.st.durMs = 0;
                    this.st.repTotal = step.timed() ? -1 : Math.max(1, step.times);
                    this.st.stepRemainMs = step.timed() ? step.durMs : -1L;
                    this.st.resting = step.type == 2;
                    this.stepVol = Math.max(0.0f, step.volumePct / 100.0f);
                    this.stepSpeed = Math.max(0.25f, step.speedPct / 100.0f);
                    push();
                    log("step " + (this.idx + 1) + "/" + this.steps.size() + ": " + step.title() + " - " + step.detail());
                    long jRestEst = restEst(this.idx + 1);
                    if (step.type == 2) {
                        pausePlayer();
                        i3 = 2;
                        silence(step.durMs, jRestEst, true);
                        if (step.endBell && !this.stopReq && this.skip == 0) {
                            this.bell.ring(step.tone, this.vol * this.stepVol * this.duck);
                        }
                    } else {
                        i3 = 2;
                        if (step.type == 3) {
                            pausePlayer();
                            bellStep(step, jRestEst);
                        } else {
                            segment(step, jRestEst);
                        }
                    }
                    int i8 = this.skip;
                    this.skip = 0;
                    if (this.stopReq) {
                        break;
                    }
                    if (i8 == i3) {
                        this.idx = this.jump;
                        this.jump = -1;
                    } else if (i8 == -1) {
                        this.idx--;
                    } else {
                        this.idx++;
                    }
                    i4 = i7;
                }
            }
        }
        final boolean z = !this.stopReq;
        pausePlayer();
        this.bell.stop();
        releasePlayer();
        this.running = false;
        this.st.running = false;
        this.st.paused = false;
        this.st.resting = false;
        this.st.posMs = 0;
        this.st.durMs = 0;
        this.st.stepRemainMs = -1L;
        this.st.progRemainMs = -1L;
        this.st.countIn = -1;
        this.st.stepTitle = z ? "Finished" : "Stopped";
        this.st.stepDetail = "";
        log(z ? "finished" : "stopped");
        push();
        this.main.post(new Runnable() { // from class: com.riola.player.Engine.2
            @Override // java.lang.Runnable
            public void run() {
                if (i != Engine.this.gen) {
                    return;
                }
                Iterator it = Engine.this.listeners.iterator();
                while (it.hasNext()) {
                    ((Listener) it.next()).onFinished(z);
                }
            }
        });
    }

    private boolean expired() {
        if (this.deadline > 0 && SystemClock.elapsedRealtime() >= this.deadline) {
            log("stop timer reached");
            this.stopReq = true;
            return true;
        }
        return false;
    }

    private void countIn() {
        int iCountIn = this.st.preview ? 0 : this.prefs.countIn();
        if (iCountIn <= 0) {
            return;
        }
        log("starting in " + iCountIn + "s");
        while (iCountIn > 0 && !this.stopReq && this.skip == 0) {
            this.st.countIn = iCountIn;
            this.st.stepTitle = "Starting in " + iCountIn;
            this.st.stepDetail = "get ready";
            push();
            waitLock(1000L);
            iCountIn--;
        }
        this.st.countIn = -1;
    }

    private long restEst(int i) {
        long jEstMs = 0;
        while (i < this.steps.size()) {
            jEstMs += this.steps.get(i).estMs();
            i++;
        }
        return jEstMs;
    }

    private void silence(long j, long j2, boolean z) {
        long jElapsedRealtime = SystemClock.elapsedRealtime();
        long j3 = j;
        while (j3 > 0 && !this.stopReq && this.skip == 0 && !expired()) {
            waitLock(200L);
            long jElapsedRealtime2 = SystemClock.elapsedRealtime();
            long j4 = jElapsedRealtime2 - jElapsedRealtime;
            if (!this.paused) {
                j3 -= j4;
            }
            if (z) {
                this.st.posMs = (int) Math.min(2147483647L, j - j3);
                this.st.durMs = (int) Math.min(2147483647L, j);
                this.st.stepRemainMs = Math.max(0L, j3);
                this.st.progRemainMs = j2 + Math.max(0L, j3);
                push();
            }
            jElapsedRealtime = jElapsedRealtime2;
        }
    }

    private void bellStep(Step step, long j) {
        int iMax = Math.max(1, step.times);
        long jLengthMs = Bell.lengthMs(step.tone);
        this.st.repTotal = iMax;
        this.st.durMs = (int) jLengthMs;
        int i = 0;
        while (i < iMax) {
            if (this.stopReq || this.skip != 0 || expired()) {
                this.bell.stop();
                return;
            }
            this.st.repDone = i;
            this.bell.ring(step.tone, this.vol * this.stepVol * this.duck);
            long jElapsedRealtime = SystemClock.elapsedRealtime();
            long j2 = jLengthMs;
            while (j2 > 0) {
                if (!this.stopReq && this.skip == 0 && !expired()) {
                    waitLock(100L);
                    long jElapsedRealtime2 = SystemClock.elapsedRealtime();
                    long j3 = jElapsedRealtime2 - jElapsedRealtime;
                    if (this.paused) {
                        this.bell.stop();
                        while (this.paused && !this.stopReq && this.skip == 0) {
                            waitLock(150L);
                        }
                        if (!this.stopReq && this.skip == 0) {
                            this.bell.ring(step.tone, this.vol * this.stepVol * this.duck);
                            jElapsedRealtime = SystemClock.elapsedRealtime();
                            j2 = jLengthMs;
                        } else {
                            return;
                        }
                    } else {
                        j2 -= j3;
                        int i2 = iMax;
                        this.st.posMs = (int) Math.max(0L, jLengthMs - j2);
                        this.st.stepRemainMs = Math.max(0L, j2) + (((long) ((i2 - 1) - i)) * (step.gapMs + jLengthMs));
                        St st = this.st;
                        st.progRemainMs = j + st.stepRemainMs;
                        push();
                        jElapsedRealtime = jElapsedRealtime2;
                        iMax = i2;
                        i = i;
                    }
                } else {
                    this.bell.stop();
                    return;
                }
            }
            int i3 = iMax;
            int i4 = i;
            if (i4 < i3 - 1 && step.gapMs > 0) {
                this.st.resting = true;
                push();
                silence(step.gapMs, j, false);
                this.st.resting = false;
                if (this.stopReq || this.skip != 0) {
                    return;
                }
            }
            i = i4 + 1;
            iMax = i3;
        }
        this.st.repDone = iMax;
    }

    private void segment(Step step, long j) {
        long j2;
        long j3;
        int i;
        float f;
        Track track = step.track();
        if (track == null) {
            this.st.skipped++;
            log("  ! that track is not in the library any more - skipped");
            waitLock(400L);
            return;
        }
        if (!open(track)) {
            this.st.skipped++;
            Store.MISSING.add(track.uri);
            return;
        }
        Store.MISSING.remove(track.uri);
        long jDuration = duration();
        long j4 = 0;
        boolean z = jDuration > 0;
        if (step.type != 1 || step.b <= 0) {
            j2 = z ? jDuration : 2305843009213693951L;
        } else {
            long jMin = step.b;
            if (z) {
                jMin = Math.min(jMin, jDuration);
            }
            j2 = jMin;
        }
        long jMax = step.type == 1 ? Math.max(0L, step.a) : 0L;
        if (z && jMax >= j2 - 150) {
            log("  ! that section falls outside the track - skipped");
            return;
        }
        long j5 = step.timed() ? step.durMs : -1L;
        long j6 = j2 - jMax;
        long j7 = jDuration;
        long jMin2 = Math.min(this.fadeMs, Math.max(0L, j6 / 4));
        applySpeed();
        startAt(jMax);
        long jElapsedRealtime = SystemClock.elapsedRealtime() + 400;
        long jElapsedRealtime2 = SystemClock.elapsedRealtime();
        long j8 = j5;
        int i2 = 0;
        while (!this.stopReq && this.skip == 0 && !expired()) {
            waitLock(j2 - ((long) position()) < 500 ? 20L : 120L);
            long jElapsedRealtime3 = SystemClock.elapsedRealtime();
            long j9 = jElapsedRealtime3 - jElapsedRealtime2;
            if (this.paused) {
                jElapsedRealtime += j9;
                jElapsedRealtime2 = jElapsedRealtime3;
            } else {
                if (j5 > j4) {
                    long j10 = j8 - j9;
                    this.st.stepRemainMs = Math.max(0L, j10);
                    this.st.progRemainMs = j + Math.max(0L, j10);
                    if (j10 <= 0) {
                        fadeOut(160L);
                        pausePlayer();
                        setGain(1.0f);
                        log("  time is up after " + (i2 + 1) + " pass(es)");
                        return;
                    }
                    j8 = j10;
                } else {
                    this.st.progRemainMs = j + Math.max(0L, j2 - ((long) position())) + (Math.max(0L, (Math.max(1, step.times) - 1) - i2) * j6);
                }
                int iPosition = position();
                this.st.posMs = iPosition;
                St st = this.st;
                if (z) {
                    j3 = j7;
                    i = (int) j3;
                } else {
                    j3 = j7;
                    i = iPosition;
                }
                st.durMs = i;
                this.st.repDone = i2;
                if (jMin2 > 0) {
                    long j11 = iPosition;
                    long j12 = j11 - jMax;
                    long j13 = j2 - j11;
                    float fMin = (j12 < 0 || j12 >= jMin2) ? 1.0f : Math.min(1.0f, j12 / jMin2);
                    if (j13 >= 0 && j13 < jMin2) {
                        fMin = Math.min(fMin, j13 / jMin2);
                    }
                    f = 0.02f;
                    setGain(Math.max(0.02f, fMin));
                } else {
                    f = 0.02f;
                }
                push();
                if (this.completed || (jElapsedRealtime3 > jElapsedRealtime && z && ((long) iPosition) >= j2 - 30)) {
                    this.completed = false;
                    int i3 = i2 + 1;
                    this.st.repDone = i3;
                    if (!step.timed() && i3 >= Math.max(1, step.times)) {
                        pausePlayer();
                        setGain(1.0f);
                        log("  played " + i3 + " time(s)");
                        return;
                    }
                    if (step.gapMs > 0) {
                        pausePlayer();
                        setGain(1.0f);
                        this.st.resting = true;
                        push();
                        silence(step.gapMs, j, false);
                        this.st.resting = false;
                        if (this.stopReq || this.skip != 0) {
                            return;
                        } else {
                            SystemClock.elapsedRealtime();
                        }
                    }
                    if (jMin2 <= 0) {
                        f = 1.0f;
                    }
                    setGain(f);
                    startAt(jMax);
                    long jElapsedRealtime4 = SystemClock.elapsedRealtime() + 400;
                    jElapsedRealtime2 = SystemClock.elapsedRealtime();
                    jElapsedRealtime = jElapsedRealtime4;
                    j7 = j3;
                    i2 = i3;
                    jMax = jMax;
                    j4 = 0;
                } else {
                    i2 = i2;
                    jElapsedRealtime = jElapsedRealtime;
                    jElapsedRealtime2 = jElapsedRealtime3;
                    j4 = 0;
                    j7 = j3;
                }
            }
        }
        pausePlayer();
        setGain(1.0f);
    }

    private boolean open(Track track) {
        MediaPlayer mediaPlayer;
        Exception e;
        MediaPlayer mediaPlayer2 = this.mp;
        if (mediaPlayer2 != null && this.loadedUri.equals(track.uri)) {
            try {
                if (mediaPlayer2.isPlaying()) {
                    mediaPlayer2.pause();
                }
            } catch (IllegalStateException e2) {
            }
            return true;
        }
        releasePlayer();
        try {
            mediaPlayer = new MediaPlayer();
            try {
                mediaPlayer.setAudioAttributes(new AudioAttributes.Builder().setUsage(1).setContentType(2).build());
                mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() { // from class: com.riola.player.Engine.3
                    @Override // android.media.MediaPlayer.OnCompletionListener
                    public void onCompletion(MediaPlayer mediaPlayer3) {
                        Engine.this.completed = true;
                        Engine.this.wake();
                    }
                });
                mediaPlayer.setOnErrorListener(new MediaPlayer.OnErrorListener() { // from class: com.riola.player.Engine.4
                    @Override // android.media.MediaPlayer.OnErrorListener
                    public boolean onError(MediaPlayer mediaPlayer3, int i, int i2) {
                        Engine.this.log("  ! player error " + i + "/" + i2);
                        Engine.this.completed = true;
                        Engine.this.wake();
                        return true;
                    }
                });
                mediaPlayer.setWakeMode(this.ctx, 1);
                mediaPlayer.setDataSource(this.ctx, track.toUri());
                mediaPlayer.prepare();
                if (track.audioTrack >= 0) {
                    try {
                        mediaPlayer.selectTrack(track.audioTrack);
                    } catch (Exception e3) {
                        log("  ! could not switch to audio stream " + track.audioTrack);
                    }
                }
                this.mp = mediaPlayer;
                this.loadedUri = track.uri;
                applyVol();
                return true;
            } catch (Exception e4) {
                e = e4;
                log("  ! cannot open " + track.shortTitle() + " (" + e.getClass().getSimpleName() + ")");
                if (mediaPlayer != null) {
                    try {
                        mediaPlayer.release();
                    } catch (Exception e5) {
                    }
                }
                this.mp = null;
                this.loadedUri = "";
                return false;
            }
        } catch (Exception e6) {
            mediaPlayer = mediaPlayer2;
            e = e6;
        }
    }

    private void startAt(long j) {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return;
        }
        this.completed = false;
        int i = (int) j;
        try {
            try {
                mediaPlayer.seekTo(i, 3);
            } catch (Throwable th) {
                mediaPlayer.seekTo(i);
            }
            if (!this.paused) {
                mediaPlayer.start();
                applySpeed();
            }
            applyVol();
        } catch (IllegalStateException e) {
            log("  ! could not start playback");
        }
    }

    private void fadeOut(long j) {
        if (j <= 0 || this.mp == null) {
            return;
        }
        for (int i = 7; i >= 0; i--) {
            setGain(Math.max(0.02f, i / 8));
            waitLock(j / ((long) 8));
            if (this.stopReq) {
                return;
            }
        }
    }

    private void pausePlayer() {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return;
        }
        try {
            if (mediaPlayer.isPlaying()) {
                mediaPlayer.pause();
            }
        } catch (IllegalStateException e) {
        }
    }

    private void releasePlayer() {
        MediaPlayer mediaPlayer = this.mp;
        this.mp = null;
        this.loadedUri = "";
        if (mediaPlayer == null) {
            return;
        }
        try {
            mediaPlayer.reset();
        } catch (Exception e) {
        }
        try {
            mediaPlayer.release();
        } catch (Exception e2) {
        }
    }

    private int position() {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return 0;
        }
        try {
            return Math.max(0, mediaPlayer.getCurrentPosition());
        } catch (IllegalStateException e) {
            return 0;
        }
    }

    private long duration() {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return 0L;
        }
        try {
            return Math.max(0, mediaPlayer.getDuration());
        } catch (IllegalStateException e) {
            return 0L;
        }
    }

    private void setGain(float f) {
        this.gain = f;
        applyVol();
    }

    private void applyVol() {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return;
        }
        float f = this.vol * this.stepVol * this.duck * this.gain;
        if (f < 0.0f) {
            f = 0.0f;
        }
        if (f > 1.0f) {
            f = 1.0f;
        }
        try {
            mediaPlayer.setVolume(f, f);
        } catch (IllegalStateException e) {
        }
    }

    private void applySpeed() {
        MediaPlayer mediaPlayer = this.mp;
        if (mediaPlayer == null) {
            return;
        }
        try {
            if (mediaPlayer.isPlaying()) {
                float f = this.speed * this.stepSpeed;
                if (f < 0.25f) {
                    f = 0.25f;
                }
                if (f > 3.0f) {
                    f = 3.0f;
                }
                PlaybackParams playbackParams = mediaPlayer.getPlaybackParams();
                playbackParams.setSpeed(f);
                mediaPlayer.setPlaybackParams(playbackParams);
            }
        } catch (Exception e) {
        }
    }

    private void waitLock(long j) {
        if (j <= 0) {
            j = 1;
        }
        synchronized (this.lock) {
            try {
                this.lock.wait(j);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void wake() {
        synchronized (this.lock) {
            this.lock.notifyAll();
        }
    }

    private void push() {
        if (this.pushPending) {
            return;
        }
        this.pushPending = true;
        this.main.post(new Runnable() { // from class: com.riola.player.Engine.5
            @Override // java.lang.Runnable
            public void run() {
                Engine.this.pushPending = false;
                Iterator it = Engine.this.listeners.iterator();
                while (it.hasNext()) {
                    ((Listener) it.next()).onState(Engine.this.st);
                }
            }
        });
    }

    public void log(String str) {
        final String str2 = Fmt.ms(SystemClock.elapsedRealtime() % 3600000) + "  " + str;
        synchronized (this.logBuf) {
            this.logBuf.append(str2).append('\n');
            if (this.logBuf.length() > 24000) {
                StringBuilder sb = this.logBuf;
                sb.delete(0, sb.length() - 16000);
            }
        }
        this.main.post(new Runnable() { // from class: com.riola.player.Engine.6
            @Override // java.lang.Runnable
            public void run() {
                Iterator it = Engine.this.listeners.iterator();
                while (it.hasNext()) {
                    ((Listener) it.next()).onLog(str2);
                }
            }
        });
    }
}
