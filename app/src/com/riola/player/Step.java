package com.riola.player;

import org.json.JSONObject;

/** One step of a program. Tracks are referenced by uri so reordering the library is safe. */
public class Step {

    public static final int PLAY = 0, SECTION = 1, SILENCE = 2, BELL = 3;

    public int type = PLAY;
    public String trackUri = "";
    public String trackName = "";   // remembered so a missing file still reads sensibly
    public long a = 0;              // section start
    public long b = -1;             // section end, -1 = end of track
    public int times = 1;           // -1 = run until durMs is used up; strikes for a bell
    public long durMs = 0;          // silence length, or the time budget when times < 0
    public long gapMs = 0;          // rest between repeats / between bell strikes
    public int speedPct = 100;
    public int volumePct = 100;
    public int tone = Bell.WARM;    // bell voice
    public boolean endBell = false; // a silence can chime when it finishes
    public boolean enabled = true;

    public static Step play(Track t) {
        Step s = new Step();
        s.type = PLAY;
        s.bind(t);
        return s;
    }

    public static Step section(Track t, long a, long b) {
        Step s = new Step();
        s.type = SECTION;
        s.bind(t);
        s.a = a;
        s.b = b;
        return s;
    }

    public static Step silence(long ms) {
        Step s = new Step();
        s.type = SILENCE;
        s.durMs = ms;
        return s;
    }

    public static Step bell() {
        Step s = new Step();
        s.type = BELL;
        s.tone = Bell.WARM;
        s.times = 1;
        s.gapMs = 4000;
        return s;
    }

    public void bind(Track t) {
        if (t == null) return;
        trackUri = t.uri;
        trackName = t.shortTitle();
    }

    public boolean needsTrack() { return type == PLAY || type == SECTION; }

    public Track track() {
        if (!needsTrack()) return null;
        Track t = Store.byUri(trackUri);
        return t;
    }

    /** Gone from the library, or the file itself could not be opened last time we looked. */
    public boolean missing() {
        return needsTrack() && (track() == null || Store.MISSING.contains(trackUri));
    }

    public boolean timed() { return times < 0; }

    public String title() {
        if (type == SILENCE) return "Silence";
        if (type == BELL) return "Bell";
        Track t = track();
        if (t != null) return t.shortTitle();
        return (trackName == null || trackName.length() == 0) ? "Missing track" : trackName;
    }

    /** The one line under the title in the step list. */
    public String detail() {
        StringBuilder sb = new StringBuilder();
        if (type == SILENCE) {
            sb.append("rest for ").append(Fmt.rough(durMs));
            if (endBell) sb.append("  .  ").append(Bell.toneName(tone)).append(" bell at the end");
            return sb.toString();
        }
        if (type == BELL) {
            sb.append(Bell.toneName(tone)).append(" tone");
            int n = Math.max(1, times);
            if (n > 1) {
                sb.append("  .  ").append(n).append(" rings");
                if (gapMs > 0) sb.append(" every ").append(Fmt.rough(gapMs));
            }
            if (volumePct != 100) sb.append("  .  vol ").append(volumePct).append("%");
            return sb.toString();
        }
        if (type == SECTION) sb.append(Fmt.ms(a)).append(" - ").append(b < 0 ? "end" : Fmt.ms(b));
        else sb.append("whole track");
        sb.append("  .  ");
        if (timed()) sb.append("loop for ").append(Fmt.rough(durMs));
        else sb.append(times == 1 ? "once" : (times + " times"));
        if (gapMs > 0) sb.append("  .  ").append(Fmt.rough(gapMs)).append(" gap");
        if (speedPct != 100) sb.append("  .  ").append(Fmt.speed(speedPct));
        if (volumePct != 100) sb.append("  .  vol ").append(volumePct).append("%");
        return sb.toString();
    }

    public long lengthMs() {
        Track t = track();
        long full = t == null ? 0 : t.durMs;
        if (type == SECTION) {
            long end = b < 0 ? full : b;
            return Math.max(0, end - a);
        }
        return full;
    }

    /** Estimated wall clock time for this step. */
    public long estMs() {
        if (!enabled) return 0;
        if (type == SILENCE) return durMs;
        if (type == BELL) {
            int n = Math.max(1, times);
            return Bell.lengthMs(tone) * n + gapMs * Math.max(0, n - 1);
        }
        if (timed()) return durMs;
        long one = lengthMs();
        if (speedPct > 0 && speedPct != 100) one = one * 100L / speedPct;
        int n = Math.max(1, times);
        return one * n + gapMs * Math.max(0, n - 1);
    }

    public Step copy() {
        Step s = new Step();
        s.type = type; s.trackUri = trackUri; s.trackName = trackName;
        s.a = a; s.b = b; s.times = times; s.durMs = durMs; s.gapMs = gapMs;
        s.speedPct = speedPct; s.volumePct = volumePct; s.tone = tone;
        s.endBell = endBell; s.enabled = enabled;
        return s;
    }

    public JSONObject toJson() throws Exception {
        JSONObject o = new JSONObject();
        o.put("ty", type);
        o.put("u", trackUri);
        o.put("n", trackName);
        o.put("a", a);
        o.put("b", b);
        o.put("x", times);
        o.put("d", durMs);
        o.put("g", gapMs);
        o.put("sp", speedPct);
        o.put("vo", volumePct);
        o.put("to", tone);
        o.put("eb", endBell);
        o.put("en", enabled);
        return o;
    }

    public static Step fromJson(JSONObject o) {
        Step s = new Step();
        s.type = o.optInt("ty", PLAY);
        s.trackUri = o.optString("u", "");
        s.trackName = o.optString("n", "");
        s.a = o.optLong("a", 0);
        s.b = o.optLong("b", -1);
        s.times = o.optInt("x", 1);
        s.durMs = o.optLong("d", 0);
        s.gapMs = o.optLong("g", 0);
        s.speedPct = o.optInt("sp", 100);
        s.volumePct = o.optInt("vo", 100);
        s.tone = o.optInt("to", Bell.WARM);
        s.endBell = o.optBoolean("eb", false);
        s.enabled = o.optBoolean("en", true);
        return s;
    }
}
