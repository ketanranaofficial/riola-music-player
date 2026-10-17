package com.riola.player;

/* JADX INFO: loaded from: classes.dex */
public final class Fmt {
    private Fmt() {
    }

    public static String ms(long j) {
        if (j < 0) {
            j = 0;
        }
        long j2 = j / 1000;
        long j3 = j2 / 3600;
        long j4 = (j2 % 3600) / 60;
        long j5 = j2 % 60;
        return j3 > 0 ? j3 + ":" + two(j4) + ":" + two(j5) : j4 + ":" + two(j5);
    }

    public static String human(long j) {
        if (j < 0) {
            return "?";
        }
        long j2 = (j + 500) / 1000;
        long j3 = j2 / 3600;
        long j4 = (j2 % 3600) / 60;
        long j5 = j2 % 60;
        if (j3 > 0) {
            return j3 + "h " + two(j4) + "m";
        }
        return j4 > 0 ? j4 + "m " + two(j5) + "s" : j5 + "s";
    }

    public static String rough(long j) {
        if (j <= 0) {
            return "0 min";
        }
        long j2 = (j + 500) / 1000;
        long j3 = j2 / 3600;
        long j4 = (j2 % 3600) / 60;
        long j5 = j2 % 60;
        if (j3 > 0) {
            return (j4 > 0 ? new StringBuilder().append(j3).append(" hr ").append(j4).append(" min") : new StringBuilder().append(j3).append(" hr")).toString();
        }
        return j4 > 0 ? j4 + " min" : j5 + " sec";
    }

    public static String two(long j) {
        return j < 10 ? "0" + j : Long.toString(j);
    }

    public static String speed(int i) {
        return (i / 100) + "." + two(i % 100) + "x";
    }

    public static String ago(long j) {
        if (j <= 0) {
            return "never";
        }
        long jCurrentTimeMillis = System.currentTimeMillis() - j;
        if (jCurrentTimeMillis < 60000) {
            return "just now";
        }
        if (jCurrentTimeMillis < 3600000) {
            return (jCurrentTimeMillis / 60000) + " min ago";
        }
        if (jCurrentTimeMillis < 86400000) {
            return (jCurrentTimeMillis / 3600000) + " hr ago";
        }
        long j2 = jCurrentTimeMillis / 86400000;
        return j2 == 1 ? "yesterday" : j2 + " days ago";
    }
}
