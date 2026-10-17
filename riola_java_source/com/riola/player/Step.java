package com.riola.player;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class Step {
    public static final int BELL = 3;
    public static final int PLAY = 0;
    public static final int SECTION = 1;
    public static final int SILENCE = 2;
    public int type = 0;
    public String trackUri = "";
    public String trackName = "";
    public long a = 0;
    public long b = -1;
    public int times = 1;
    public long durMs = 0;
    public long gapMs = 0;
    public int speedPct = 100;
    public int volumePct = 100;
    public int tone = 1;
    public boolean endBell = false;
    public boolean enabled = true;

    public static Step play(Track track) {
        Step step = new Step();
        step.type = 0;
        step.bind(track);
        return step;
    }

    public static Step section(Track track, long j, long j2) {
        Step step = new Step();
        step.type = 1;
        step.bind(track);
        step.a = j;
        step.b = j2;
        return step;
    }

    public static Step silence(long j) {
        Step step = new Step();
        step.type = 2;
        step.durMs = j;
        return step;
    }

    public static Step bell() {
        Step step = new Step();
        step.type = 3;
        step.tone = 1;
        step.times = 1;
        step.gapMs = 4000L;
        return step;
    }

    public void bind(Track track) {
        if (track == null) {
            return;
        }
        this.trackUri = track.uri;
        this.trackName = track.shortTitle();
    }

    public boolean needsTrack() {
        int i = this.type;
        return i == 0 || i == 1;
    }

    public Track track() {
        if (needsTrack()) {
            return Store.byUri(this.trackUri);
        }
        return null;
    }

    public boolean missing() {
        return needsTrack() && (track() == null || Store.MISSING.contains(this.trackUri));
    }

    public boolean timed() {
        return this.times < 0;
    }

    public String title() {
        int i = this.type;
        if (i == 2) {
            return "Silence";
        }
        if (i == 3) {
            return "Bell";
        }
        Track track = track();
        if (track != null) {
            return track.shortTitle();
        }
        String str = this.trackName;
        return (str == null || str.length() == 0) ? "Missing track" : this.trackName;
    }

    public String detail() {
        StringBuilder sb = new StringBuilder();
        int i = this.type;
        if (i == 2) {
            sb.append("rest for ").append(Fmt.rough(this.durMs));
            if (this.endBell) {
                sb.append("  .  ").append(Bell.toneName(this.tone)).append(" bell at the end");
            }
            return sb.toString();
        }
        if (i == 3) {
            sb.append(Bell.toneName(this.tone)).append(" tone");
            int iMax = Math.max(1, this.times);
            if (iMax > 1) {
                sb.append("  .  ").append(iMax).append(" rings");
                if (this.gapMs > 0) {
                    sb.append(" every ").append(Fmt.rough(this.gapMs));
                }
            }
            if (this.volumePct != 100) {
                sb.append("  .  vol ").append(this.volumePct).append("%");
            }
            return sb.toString();
        }
        if (i == 1) {
            StringBuilder sbAppend = sb.append(Fmt.ms(this.a)).append(" - ");
            long j = this.b;
            sbAppend.append(j < 0 ? "end" : Fmt.ms(j));
        } else {
            sb.append("whole track");
        }
        sb.append("  .  ");
        if (timed()) {
            sb.append("loop for ").append(Fmt.rough(this.durMs));
        } else {
            sb.append(this.times == 1 ? "once" : this.times + " times");
        }
        if (this.gapMs > 0) {
            sb.append("  .  ").append(Fmt.rough(this.gapMs)).append(" gap");
        }
        if (this.speedPct != 100) {
            sb.append("  .  ").append(Fmt.speed(this.speedPct));
        }
        if (this.volumePct != 100) {
            sb.append("  .  vol ").append(this.volumePct).append("%");
        }
        return sb.toString();
    }

    public long lengthMs() {
        Track track = track();
        long j = track == null ? 0L : track.durMs;
        if (this.type == 1) {
            long j2 = this.b;
            if (j2 >= 0) {
                j = j2;
            }
            return Math.max(0L, j - this.a);
        }
        return j;
    }

    public long estMs() {
        if (!this.enabled) {
            return 0L;
        }
        int i = this.type;
        if (i == 2) {
            return this.durMs;
        }
        if (i == 3) {
            int iMax = Math.max(1, this.times);
            return (Bell.lengthMs(this.tone) * ((long) iMax)) + (this.gapMs * ((long) Math.max(0, iMax - 1)));
        }
        if (timed()) {
            return this.durMs;
        }
        long jLengthMs = lengthMs();
        int i2 = this.speedPct;
        if (i2 > 0 && i2 != 100) {
            jLengthMs = (jLengthMs * 100) / ((long) i2);
        }
        int iMax2 = Math.max(1, this.times);
        return (jLengthMs * ((long) iMax2)) + (this.gapMs * ((long) Math.max(0, iMax2 - 1)));
    }

    public Step copy() {
        Step step = new Step();
        step.type = this.type;
        step.trackUri = this.trackUri;
        step.trackName = this.trackName;
        step.a = this.a;
        step.b = this.b;
        step.times = this.times;
        step.durMs = this.durMs;
        step.gapMs = this.gapMs;
        step.speedPct = this.speedPct;
        step.volumePct = this.volumePct;
        step.tone = this.tone;
        step.endBell = this.endBell;
        step.enabled = this.enabled;
        return step;
    }

    public JSONObject toJson() throws Exception {
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("ty", this.type);
        jSONObject.put("u", this.trackUri);
        jSONObject.put("n", this.trackName);
        jSONObject.put("a", this.a);
        jSONObject.put("b", this.b);
        jSONObject.put("x", this.times);
        jSONObject.put("d", this.durMs);
        jSONObject.put("g", this.gapMs);
        jSONObject.put("sp", this.speedPct);
        jSONObject.put("vo", this.volumePct);
        jSONObject.put("to", this.tone);
        jSONObject.put("eb", this.endBell);
        jSONObject.put("en", this.enabled);
        return jSONObject;
    }

    public static Step fromJson(JSONObject jSONObject) {
        Step step = new Step();
        step.type = jSONObject.optInt("ty", 0);
        step.trackUri = jSONObject.optString("u", "");
        step.trackName = jSONObject.optString("n", "");
        step.a = jSONObject.optLong("a", 0L);
        step.b = jSONObject.optLong("b", -1L);
        step.times = jSONObject.optInt("x", 1);
        step.durMs = jSONObject.optLong("d", 0L);
        step.gapMs = jSONObject.optLong("g", 0L);
        step.speedPct = jSONObject.optInt("sp", 100);
        step.volumePct = jSONObject.optInt("vo", 100);
        step.tone = jSONObject.optInt("to", 1);
        step.endBell = jSONObject.optBoolean("eb", false);
        step.enabled = jSONObject.optBoolean("en", true);
        return step;
    }
}
