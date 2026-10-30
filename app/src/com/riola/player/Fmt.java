package com.riola.player;

/** Tiny formatting helpers (ASCII only). */
public final class Fmt {

    private Fmt() { }

    /** 0:07 / 4:31 / 1:02:44 */
    public static String ms(long v) {
        if (v < 0) v = 0;
        long t = v / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return h + ":" + two(m) + ":" + two(s);
        return m + ":" + two(s);
    }

    /** 45s / 3m 20s / 1h 05m */
    public static String human(long v) {
        if (v < 0) return "?";
        long t = (v + 500L) / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return h + "h " + two(m) + "m";
        if (m > 0) return m + "m " + two(s) + "s";
        return s + "s";
    }

    /** 45 sec / 3 min / 1 hr 5 min - for compact captions. */
    public static String rough(long v) {
        if (v <= 0) return "0 min";
        long t = (v + 500L) / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return m > 0 ? (h + " hr " + m + " min") : (h + " hr");
        if (m > 0) return m + " min";
        return s + " sec";
    }

    public static String two(long v) { return v < 10 ? "0" + v : Long.toString(v); }

    /** 1.25 -> "1.25x" without locale surprises. */
    public static String speed(int pct) {
        return (pct / 100) + "." + two(pct % 100) + "x";
    }

    public static String ago(long when) {
        if (when <= 0) return "never";
        long d = System.currentTimeMillis() - when;
        if (d < 60000L) return "just now";
        if (d < 3600000L) return (d / 60000L) + " min ago";
        if (d < 86400000L) return (d / 3600000L) + " hr ago";
        long days = d / 86400000L;
        return days == 1 ? "yesterday" : (days + " days ago");
    }
}
