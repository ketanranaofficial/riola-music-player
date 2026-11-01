package com.riola.player;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.media.PlaybackParams;
import android.os.Handler;
import android.os.Looper;
import android.os.PowerManager;
import android.os.SystemClock;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Runs a program on a worker thread with a single MediaPlayer.
 * One instance per process, so the screens and the foreground service always
 * look at the same playback.
 */
public class Engine {

    /** Snapshot of what the engine is doing; read by the UI and the notification. */
    public static class St {
        public boolean running, paused, preview, resting;
        public String programId = "", programName = "";
        public int  step, steps;
        public String stepTitle = "", stepDetail = "";
        public String trackUri = "";     // what is loaded right now, "" for silence and bells
        public int  posMs, durMs;
        public long stepRemainMs = -1;   // -1 = not time limited
        public long progRemainMs = -1;
        public int  repDone;
        public int  repTotal = -1;       // -1 = not count limited
        public int  loopDone;
        public int  loopTotal = 1;       // -1 = forever
        public int  countIn = -1;        // seconds left before the first step
        public int  skipped;             // steps passed over because the track was gone
        public boolean shuffled;         // playing in a random order
    }

    public interface Listener {
        void onState(St s);
        void onLog(String line);
        void onFinished(boolean completed);
    }

    private static Engine I;

    public static synchronized Engine get(Context c) {
        if (I == null) I = new Engine(c.getApplicationContext());
        return I;
    }

    private final Context ctx;
    private final Prefs prefs;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final Object lock = new Object();
    private final CopyOnWriteArrayList<Listener> listeners = new CopyOnWriteArrayList<Listener>();
    private final StringBuilder logBuf = new StringBuilder();

    public final St st = new St();

    private MediaPlayer mp;
    private final Bell bell = new Bell();
    private String loadedUri = "";
    private Thread worker;
    private final List<Step> steps = new ArrayList<Step>();
    private int loops = 1;

    private volatile boolean stopReq, paused, running, completed, pushPending;
    private volatile int skip;          // -1 previous step, +1 next step, 2 jump
    private volatile int jump = -1;
    private volatile int idx;           // a position in order[], not a step number
    private volatile int[] order;
    private volatile boolean shuffled;
    private volatile int gen;           // run id, so a restart cannot fire the old "finished"
    private volatile float duck = 1f;
    private volatile float gain = 1f;   // fade envelope
    private volatile float vol = 1f;    // master volume
    private volatile float speed = 1f;  // master speed
    private volatile float stepVol = 1f, stepSpeed = 1f;
    private volatile long fadeMs = 150;
    private volatile long deadline = -1;

    private Engine(Context c) {
        ctx = c;
        prefs = new Prefs(c);
    }

    // ---- listeners -------------------------------------------------------
    public void addListener(Listener l)    { if (l != null && !listeners.contains(l)) listeners.add(l); }
    public void removeListener(Listener l) { listeners.remove(l); }

    public boolean isRunning() { return running; }
    public boolean isPaused()  { return paused; }
    public String  logText()   { synchronized (logBuf) { return logBuf.toString(); } }
    public void    clearLog()  { synchronized (logBuf) { logBuf.setLength(0); } }

    /** True when this exact program is the one playing. */
    public boolean isPlaying(Program p) {
        return running && p != null && p.id.equals(st.programId);
    }

    // ---- control ---------------------------------------------------------
    public void start(Program p, int fromStep) {
        if (p == null) return;
        if (p.enabledCount() == 0) {
            log("nothing to play - every step is switched off");
            return;
        }
        stop();
        steps.clear();
        for (int i = 0; i < p.steps.size(); i++) steps.add(p.steps.get(i).copy());
        loops = p.loops;
        st.programId = p.id;
        st.programName = p.name;
        st.preview = false;
        begin(Math.max(0, Math.min(fromStep, steps.size() - 1)));
    }

    public void previewTrack(Track t) {
        if (t == null) return;
        stop();
        steps.clear();
        steps.add(Step.play(t));
        loops = 1;
        st.programId = "";
        st.programName = "Preview";
        st.preview = true;
        begin(0);
    }

    private void begin(int from) {
        vol = prefs.volume() / 100f;
        speed = prefs.speed();
        fadeMs = prefs.fadeMs();
        duck = 1f;
        gain = 1f;
        stepVol = 1f;
        stepSpeed = 1f;
        buildOrder(shuffled, -1);
        idx = from;
        if (shuffled) {
            for (int i = 0; i < order.length; i++) if (order[i] == from) { idx = i; break; }
        }
        st.shuffled = shuffled;
        stopReq = false;
        paused = false;
        skip = 0;
        jump = -1;
        running = true;
        st.running = true;
        st.paused = false;
        st.steps = steps.size();
        st.step = idx;
        st.loopDone = 0;
        st.loopTotal = loops;
        st.countIn = -1;
        st.skipped = 0;
        int stopMin = st.preview ? 0 : prefs.autoStopMin();
        deadline = stopMin > 0 ? SystemClock.elapsedRealtime() + stopMin * 60000L : -1;
        final int myGen = ++gen;
        Thread t = new Thread(new Runnable() { public void run() { loop(myGen); } }, "riola-engine");
        t.setPriority(Thread.NORM_PRIORITY + 1);
        worker = t;
        t.start();
    }

    public void stop() {
        Thread w = worker;
        stopReq = true;
        paused = false;
        wake();
        if (w != null && w.isAlive() && Thread.currentThread() != w) {
            try { w.join(2000); } catch (InterruptedException e) { /* give up waiting */ }
        }
        worker = null;
        running = false;
        bell.stop();
        releasePlayer();
        st.running = false;
        st.paused = false;
        st.resting = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.repTotal = -1;
        st.countIn = -1;
        push();
    }

    public void setPaused(boolean p) {
        if (!running || paused == p) return;
        paused = p;
        st.paused = p;
        if (p) bell.stop();     // a chime from a previous step can still be ringing
        MediaPlayer m = mp;
        if (m != null) {
            try {
                if (p) { if (m.isPlaying()) m.pause(); }
                else   { m.start(); applySpeed(); }
            } catch (IllegalStateException e) { /* player is between states */ }
        }
        log(p ? "paused" : "resumed");
        wake();
        push();
    }

    public void togglePause() { setPaused(!paused); }
    public void next()        { if (running) { skip = 1;  wake(); } }
    public void prev()        { if (running) { skip = -1; wake(); } }

    /** Takes a step number and finds where it sits in the order being played. */
    public void jumpTo(int stepIndex) {
        if (!running || stepIndex < 0 || stepIndex >= steps.size()) return;
        int at = stepIndex;
        int[] o = order;
        if (o != null) {
            for (int i = 0; i < o.length; i++) if (o[i] == stepIndex) { at = i; break; }
        }
        jump = at;
        skip = 2;
        wake();
    }

    public void seekTo(int ms) {
        MediaPlayer m = mp;
        if (m == null) return;
        try { m.seekTo(ms); } catch (IllegalStateException e) { /* ignore */ }
    }

    public boolean isShuffled() { return shuffled; }

    /**
     * Play the steps in a random order. The step that is playing stays put and
     * everything after it is reshuffled, so turning it on does not cut off what
     * you are listening to. The program itself is never rewritten.
     */
    public void setShuffle(boolean on) {
        shuffled = on;
        st.shuffled = on;
        if (!running || order == null) { push(); return; }
        int current = (idx >= 0 && idx < order.length) ? order[idx] : 0;
        buildOrder(on, current);
        idx = on ? 0 : current;
        log(on ? "shuffled" : "back to the written order");
        push();
    }

    private void buildOrder(boolean shuffle, int keepFirst) {
        int n = steps.size();
        int[] o = new int[n];
        for (int i = 0; i < n; i++) o[i] = i;
        if (shuffle && n > 1) {
            java.util.Random r = new java.util.Random();
            for (int i = n - 1; i > 0; i--) {
                int j = r.nextInt(i + 1);
                int t = o[i]; o[i] = o[j]; o[j] = t;
            }
            if (keepFirst >= 0) {
                for (int i = 0; i < n; i++) {
                    if (o[i] == keepFirst) { int t = o[0]; o[0] = o[i]; o[i] = t; break; }
                }
            }
        }
        order = o;
    }

    public void setDuck(float d) { duck = d; applyVol(); }
    public void setMasterVolume(int percent) { vol = percent / 100f; applyVol(); }
    public void setMasterSpeed(int percent)  { speed = percent / 100f; applySpeed(); }

    // ---- worker ----------------------------------------------------------
    private void loop(final int myGen) {
        log("started: " + st.programName);
        countIn();

        int pass = 0;
        int playedThisPass = 0;
        while (!stopReq) {
            if (expired()) break;
            if (order == null || idx >= order.length) {
                pass++;
                if (playedThisPass == 0) break;                 // nothing runnable, do not spin
                if (loops >= 0 && pass >= Math.max(1, loops)) break;
                // a fresh shuffle each time round, which is what a playlist does
                if (shuffled) buildOrder(true, -1);
                idx = 0;
                playedThisPass = 0;
                st.loopDone = pass;
                log("loop " + (pass + 1) + (loops < 0 ? "" : " of " + loops));
                continue;
            }
            if (idx < 0) idx = 0;
            int stepAt = order[idx];
            Step s = steps.get(stepAt);
            if (!s.enabled) { idx++; continue; }

            playedThisPass++;
            st.step = stepAt;
            st.steps = steps.size();
            st.stepTitle = s.title();
            st.stepDetail = s.detail();
            st.trackUri = s.needsTrack() ? s.trackUri : "";
            st.repDone = 0;
            // clear the previous step's clock so the bar cannot flash its numbers
            st.posMs = 0;
            st.durMs = 0;
            st.repTotal = s.timed() ? -1 : Math.max(1, s.times);
            st.stepRemainMs = s.timed() ? s.durMs : -1;
            st.resting = s.type == Step.SILENCE;
            stepVol = Math.max(0f, s.volumePct / 100f);
            stepSpeed = Math.max(0.25f, s.speedPct / 100f);
            push();
            log("step " + (idx + 1) + "/" + steps.size() + ": " + s.title() + " - " + s.detail());

            long rest = restEst(idx + 1);
            if (s.type == Step.SILENCE) {
                pausePlayer();
                silence(s.durMs, rest, true);
                // the chime rings on into whatever comes next, which is exactly
                // what you want when the next step is more silence
                if (s.endBell && !stopReq && skip == 0) bell.ring(s.tone, vol * stepVol * duck);
            } else if (s.type == Step.BELL) {
                pausePlayer();
                bellStep(s, rest);
            } else {
                segment(s, rest);
            }

            int sk = skip;
            skip = 0;
            if (stopReq) break;
            if (sk == 2)       { idx = jump; jump = -1; }
            else if (sk == -1) { idx = idx - 1; }
            else               { idx = idx + 1; }
        }

        boolean finished = !stopReq;
        pausePlayer();
        bell.stop();
        releasePlayer();
        running = false;
        st.running = false;
        st.paused = false;
        st.resting = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.countIn = -1;
        st.stepTitle = finished ? "Finished" : "Stopped";
        st.stepDetail = "";
        log(finished ? "finished" : "stopped");
        push();
        final boolean done = finished;
        main.post(new Runnable() {
            public void run() {
                if (myGen != gen) return;      // a new run already took over
                for (Listener l : listeners) l.onFinished(done);
            }
        });
    }

    private boolean expired() {
        if (deadline > 0 && SystemClock.elapsedRealtime() >= deadline) {
            log("stop timer reached");
            stopReq = true;
            return true;
        }
        return false;
    }

    private void countIn() {
        int secs = st.preview ? 0 : prefs.countIn();
        if (secs <= 0) return;
        log("starting in " + secs + "s");
        for (int i = secs; i > 0 && !stopReq && skip == 0; i--) {
            st.countIn = i;
            st.stepTitle = "Starting in " + i;
            st.stepDetail = "get ready";
            push();
            waitLock(1000);
        }
        st.countIn = -1;
    }

    private long restEst(int from) {
        long t = 0;
        for (int i = from; i < steps.size(); i++) t += steps.get(i).estMs();
        return t;
    }

    /** Silence that still answers pause / skip / stop. */
    private void silence(long total, long rest, boolean showProgress) {
        long remain = total;
        long last = SystemClock.elapsedRealtime();
        while (remain > 0) {
            if (stopReq || skip != 0 || expired()) return;
            waitLock(200);
            long now = SystemClock.elapsedRealtime();
            long d = now - last;
            last = now;
            if (!paused) remain -= d;
            if (showProgress) {
                st.posMs = (int) Math.min(Integer.MAX_VALUE, total - remain);
                st.durMs = (int) Math.min(Integer.MAX_VALUE, total);
                st.stepRemainMs = Math.max(0, remain);
                st.progRemainMs = rest + Math.max(0, remain);
                push();
            }
        }
    }

    /** A gentle marker: one or more strikes, with an optional gap between them. */
    private void bellStep(Step step, long rest) {
        int strikes = Math.max(1, step.times);
        long len = Bell.lengthMs(step.tone);
        st.repTotal = strikes;
        st.durMs = (int) len;

        for (int i = 0; i < strikes; i++) {
            if (stopReq || skip != 0 || expired()) { bell.stop(); return; }
            st.repDone = i;
            bell.ring(step.tone, vol * stepVol * duck);

            long remain = len;
            long last = SystemClock.elapsedRealtime();
            while (remain > 0) {
                if (stopReq || skip != 0 || expired()) { bell.stop(); return; }
                waitLock(100);
                long now = SystemClock.elapsedRealtime();
                long d = now - last;
                last = now;
                if (paused) {
                    // let it fall silent, then strike again when we resume
                    bell.stop();
                    while (paused && !stopReq && skip == 0) waitLock(150);
                    if (stopReq || skip != 0) return;
                    bell.ring(step.tone, vol * stepVol * duck);
                    remain = len;
                    last = SystemClock.elapsedRealtime();
                    continue;
                }
                remain -= d;
                st.posMs = (int) Math.max(0, len - remain);
                st.stepRemainMs = Math.max(0, remain) + (long) (strikes - 1 - i) * (len + step.gapMs);
                st.progRemainMs = rest + st.stepRemainMs;
                push();
            }
            if (i < strikes - 1 && step.gapMs > 0) {
                st.resting = true;
                push();
                silence(step.gapMs, rest, false);
                st.resting = false;
                if (stopReq || skip != 0) return;
            }
        }
        st.repDone = strikes;
    }

    /** A whole track or an A-B slice, repeated a number of times or for a while. */
    private void segment(Step step, long rest) {
        Track track = step.track();
        if (track == null) {
            st.skipped++;
            log("  ! that track is not in the library any more - skipped");
            waitLock(400);
            return;
        }
        if (!open(track)) {
            st.skipped++;
            Store.MISSING.add(track.uri);
            return;
        }
        Store.MISSING.remove(track.uri);

        long dur = duration();
        boolean known = dur > 0;
        long end;
        if (step.type == Step.SECTION && step.b > 0) end = known ? Math.min(step.b, dur) : step.b;
        else end = known ? dur : Long.MAX_VALUE / 4;
        long start = step.type == Step.SECTION ? Math.max(0, step.a) : 0;
        if (known && start >= end - 150) {
            log("  ! that section falls outside the track - skipped");
            return;
        }

        long budget = step.timed() ? step.durMs : -1;
        long remain = budget;
        long fade = Math.min(fadeMs, Math.max(0, (end - start) / 4));
        int rep = 0;
        boolean warned = false;

        applySpeed();
        startAt(start);
        long grace = SystemClock.elapsedRealtime() + 400;
        long last = SystemClock.elapsedRealtime();

        while (true) {
            if (stopReq || skip != 0 || expired()) { pausePlayer(); setGain(1f); return; }

            int pos = position();
            waitLock(end - pos < 500 ? 20 : 120);

            long now = SystemClock.elapsedRealtime();
            long d = now - last;
            last = now;
            if (paused) { grace += d; continue; }

            if (budget > 0) {
                remain -= d;
                st.stepRemainMs = Math.max(0, remain);
                st.progRemainMs = rest + Math.max(0, remain);
                if (remain <= 0) {
                    fadeOut(160);
                    pausePlayer();
                    setGain(1f);
                    log("  time is up after " + (rep + 1) + " pass(es)");
                    return;
                }
            } else {
                long left = Math.max(0, end - position());
                long more = Math.max(0, (long) (Math.max(1, step.times) - 1 - rep)) * (end - start);
                st.progRemainMs = rest + left + more;
            }

            pos = position();
            st.posMs = pos;
            st.durMs = known ? (int) dur : pos;
            st.repDone = rep;

            if (fade > 0) {
                float g = 1f;
                long since = pos - start;
                long left = end - pos;
                if (since >= 0 && since < fade) g = Math.min(g, since / (float) fade);
                if (left  >= 0 && left  < fade) g = Math.min(g, left / (float) fade);
                setGain(Math.max(0.02f, g));
            }
            push();

            // A pass cannot really end in the first half of its length. An end
            // signal that early is a leftover: a completion report for the
            // pass before, or a position still read from before the seek
            // landed. Counting it would cut the repeat short, so drop it and
            // say so in the log. A real completion leaves the player stopped,
            // so one that arrives while it is playing is a leftover. So is one
            // in the first second, which can land before the restart has taken
            // effect and so finds the player not yet playing.
            long passMs = now - (grace - 400);          // playing time this pass, pauses excluded
            long expect = known ? (long) ((end - start) / Math.min(3f, Math.max(0.25f, speed * stepSpeed))) : 0;
            boolean tooSoon = expect > 1000 && passMs < expect / 2;
            if (completed && tooSoon && (passMs < 1000 || playerPlaying())) {
                completed = false;
                log("  (ignored an early end signal, " + passMs + " ms into a " + expect + " ms pass)");
                if (!paused && !playerPlaying()) {
                    // the leftover signal can also leave the player stopped
                    startAt(start);
                    grace = SystemClock.elapsedRealtime() + 400;
                    continue;
                }
            }
            if (tooSoon && !warned && now > grace && known && pos >= end - 30) {
                warned = true;
                log("  (ignored an early position reading, " + passMs + " ms into a " + expect + " ms pass)");
            }
            if (!paused && !completed && known && passMs > 5000 && pos < end - 1000 && !playerPlaying()) {
                // stopped by itself with no end signal: start it again rather than wait for ever
                log("  (player stopped by itself " + passMs + " ms into the pass - starting it again)");
                startAt(start);
                grace = SystemClock.elapsedRealtime() + 400;
                continue;
            }

            boolean byCompletion = completed;
            boolean atEnd = completed || (now > grace && !tooSoon && known && pos >= end - 30);
            if (!atEnd) continue;

            completed = false;
            rep++;
            st.repDone = rep;
            log("  pass " + rep + (step.timed() ? "" : " of " + Math.max(1, step.times))
                    + (byCompletion ? " (player finished)" : " (reached the end mark)"));
            if (!step.timed() && rep >= Math.max(1, step.times)) {
                pausePlayer();
                setGain(1f);
                log("  played " + rep + " time(s)");
                return;
            }
            if (budget > 0 && remain <= 0) { pausePlayer(); setGain(1f); return; }

            if (step.gapMs > 0) {
                pausePlayer();
                setGain(1f);
                st.resting = true;
                push();
                silence(step.gapMs, rest, false);
                st.resting = false;
                if (stopReq || skip != 0) return;
                last = SystemClock.elapsedRealtime();
            }
            setGain(fade > 0 ? 0.02f : 1f);
            startAt(start);
            warned = false;
            grace = SystemClock.elapsedRealtime() + 400;
            last = SystemClock.elapsedRealtime();
        }
    }

    // ---- MediaPlayer plumbing -------------------------------------------
    private boolean open(Track t) {
        MediaPlayer m = mp;
        if (m != null && loadedUri.equals(t.uri)) {
            try { if (m.isPlaying()) m.pause(); } catch (IllegalStateException e) { /* ignore */ }
            return true;
        }
        releasePlayer();
        try {
            m = new MediaPlayer();
            m.setAudioAttributes(new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build());
            m.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                public void onCompletion(MediaPlayer p) { completed = true; wake(); }
            });
            m.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                public boolean onError(MediaPlayer p, int what, int extra) {
                    log("  ! player error " + what + "/" + extra);
                    completed = true;
                    wake();
                    return true;
                }
            });
            m.setWakeMode(ctx, PowerManager.PARTIAL_WAKE_LOCK);
            m.setDataSource(ctx, t.toUri());
            m.prepare();
            // No Surface is ever attached, so a video file simply plays its
            // sound. Where there is more than one audio stream - a dubbed film,
            // say - use the one chosen for this track.
            if (t.audioTrack >= 0) {
                try { m.selectTrack(t.audioTrack); } catch (Exception e) {
                    log("  ! could not switch to audio stream " + t.audioTrack);
                }
            }
            mp = m;
            loadedUri = t.uri;
            applyVol();
            return true;
        } catch (Exception e) {
            log("  ! cannot open " + t.shortTitle() + " (" + e.getClass().getSimpleName() + ")");
            try { if (m != null) m.release(); } catch (Exception ignored) { }
            mp = null;
            loadedUri = "";
            return false;
        }
    }

    private void startAt(long ms) {
        MediaPlayer m = mp;
        if (m == null) return;
        completed = false;
        try {
            try { m.seekTo((int) ms, MediaPlayer.SEEK_CLOSEST); }
            catch (Throwable t) { m.seekTo((int) ms); }
            if (!paused) {
                m.start();
                applySpeed();
            }
            applyVol();
        } catch (IllegalStateException e) {
            log("  ! could not start playback");
        }
    }

    private void fadeOut(long ms) {
        if (ms <= 0 || mp == null) return;
        int steps = 8;
        for (int i = steps - 1; i >= 0; i--) {
            setGain(Math.max(0.02f, i / (float) steps));
            waitLock(ms / steps);
            if (stopReq) break;
        }
    }

    private void pausePlayer() {
        MediaPlayer m = mp;
        if (m == null) return;
        try { if (m.isPlaying()) m.pause(); } catch (IllegalStateException e) { /* ignore */ }
    }

    private void releasePlayer() {
        MediaPlayer m = mp;
        mp = null;
        loadedUri = "";
        if (m == null) return;
        try { m.reset(); } catch (Exception e) { /* ignore */ }
        try { m.release(); } catch (Exception e) { /* ignore */ }
    }

    private boolean playerPlaying() {
        MediaPlayer m = mp;
        if (m == null) return false;
        try { return m.isPlaying(); } catch (IllegalStateException e) { return false; }
    }

    private int position() {
        MediaPlayer m = mp;
        if (m == null) return 0;
        try { return Math.max(0, m.getCurrentPosition()); } catch (IllegalStateException e) { return 0; }
    }

    private long duration() {
        MediaPlayer m = mp;
        if (m == null) return 0;
        try { return Math.max(0, m.getDuration()); } catch (IllegalStateException e) { return 0; }
    }

    private void setGain(float g) { gain = g; applyVol(); }

    private void applyVol() {
        MediaPlayer m = mp;
        if (m == null) return;
        float v = vol * stepVol * duck * gain;
        if (v < 0f) v = 0f;
        if (v > 1f) v = 1f;
        try { m.setVolume(v, v); } catch (IllegalStateException e) { /* ignore */ }
    }

    private void applySpeed() {
        MediaPlayer m = mp;
        if (m == null) return;
        try {
            if (!m.isPlaying()) return;
            float f = speed * stepSpeed;
            if (f < 0.25f) f = 0.25f;
            if (f > 3f) f = 3f;
            PlaybackParams pp = m.getPlaybackParams();
            pp.setSpeed(f);
            m.setPlaybackParams(pp);
        } catch (Exception e) { /* the device refused the speed change */ }
    }

    // ---- helpers ---------------------------------------------------------
    private void waitLock(long ms) {
        if (ms <= 0) ms = 1;
        synchronized (lock) {
            try { lock.wait(ms); } catch (InterruptedException e) { Thread.currentThread().interrupt(); }
        }
    }

    private void wake() {
        synchronized (lock) { lock.notifyAll(); }
    }

    private void push() {
        if (pushPending) return;
        pushPending = true;
        main.post(new Runnable() {
            public void run() {
                pushPending = false;
                for (Listener l : listeners) l.onState(st);
            }
        });
    }

    public void log(String line) {
        final String entry = Fmt.ms(SystemClock.elapsedRealtime() % 3600000L) + "  " + line;
        android.util.Log.i("riola", line);
        synchronized (logBuf) {
            logBuf.append(entry).append('\n');
            if (logBuf.length() > 24000) logBuf.delete(0, logBuf.length() - 16000);
        }
        main.post(new Runnable() {
            public void run() {
                for (Listener l : listeners) l.onLog(entry);
            }
        });
    }
}
