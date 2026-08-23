package com.example.player;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public abstract class Cmd {
    String keyword;
    String text;
    int track = -1;
}

class PlayCmd extends Cmd {
    int times;
}

class PauseCmd extends Cmd {
    long minutes;
}

class LoopCmd extends Cmd {
    long minutes;
}

class SectionCmd extends Cmd {
    long startMs;
    long endMs;
    boolean timed;
    long minutes;
    int times;
}

class CmdCodec {

    static String encode(Cmd c) {
        if (c instanceof PlayCmd) {
            PlayCmd p = (PlayCmd) c;
            return "PLAY|" + p.track + "|" + p.times;
        }
        if (c instanceof PauseCmd) {
            return "PAUSE|" + ((PauseCmd) c).minutes;
        }
        if (c instanceof LoopCmd) {
            LoopCmd p = (LoopCmd) c;
            return "LOOP|" + p.track + "|" + p.minutes;
        }
        if (c instanceof SectionCmd) {
            SectionCmd p = (SectionCmd) c;
            return "SECTION|" + p.track + "|" + p.startMs + "|" + p.endMs
                    + "|" + p.timed + "|" + (p.timed ? p.minutes : p.times);
        }
        throw new IllegalArgumentException("unknown command");
    }

    static String encodeProgram(List<Cmd> cmds) {
        StringBuilder sb = new StringBuilder();
        for (Cmd c : cmds) {
            sb.append(encode(c)).append('\n');
        }
        return sb.toString();
    }

    static Cmd decode(String line) {
        String[] t = line.split("\\|");
        String kw = t[0];
        Cmd c;
        if ("PLAY".equals(kw)) {
            PlayCmd p = new PlayCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.times = Integer.parseInt(t[2].trim());
            c = p;
        } else if ("PAUSE".equals(kw)) {
            PauseCmd p = new PauseCmd();
            p.keyword = kw;
            p.minutes = Long.parseLong(t[1].trim());
            c = p;
        } else if ("LOOP".equals(kw)) {
            LoopCmd p = new LoopCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.minutes = Long.parseLong(t[2].trim());
            c = p;
        } else if ("SECTION".equals(kw)) {
            SectionCmd p = new SectionCmd();
            p.keyword = kw;
            p.track = Integer.parseInt(t[1].trim());
            p.startMs = Long.parseLong(t[2].trim());
            p.endMs = Long.parseLong(t[3].trim());
            p.timed = Boolean.parseBoolean(t[4].trim());
            if (p.timed) {
                p.minutes = Long.parseLong(t[5].trim());
            } else {
                p.times = Integer.parseInt(t[5].trim());
            }
            c = p;
        } else {
            throw new IllegalArgumentException("unknown command '" + kw + "'");
        }
        c.text = describe(c);
        return c;
    }

    static List<Cmd> decodeProgram(String data) {
        List<Cmd> out = new ArrayList<Cmd>();
        if (data == null) return out;
        for (String raw : data.split("\r?\n")) {
            String line = raw.trim();
            if (line.length() == 0) continue;
            try {
                out.add(decode(line));
            } catch (Exception ignored) {
            }
        }
        return out;
    }

    static String describe(Cmd c) {
        if (c instanceof PlayCmd) {
            PlayCmd p = (PlayCmd) c;
            return "PLAY  trk" + p.track + "  " + p.times + " TIMES";
        }
        if (c instanceof PauseCmd) {
            return "PAUSE  " + ((PauseCmd) c).minutes + " MIN";
        }
        if (c instanceof LoopCmd) {
            LoopCmd p = (LoopCmd) c;
            return "LOOP  trk" + p.track + "  " + p.minutes + " MIN";
        }
        if (c instanceof SectionCmd) {
            SectionCmd p = (SectionCmd) c;
            String range = fmt(p.startMs) + " - " + fmt(p.endMs);
            if (p.timed) {
                return "SECTION  trk" + p.track + "  " + range + "  FOR " + p.minutes + " MIN";
            } else {
                return "SECTION  trk" + p.track + "  " + range + "  " + p.times + " TIMES";
            }
        }
        return "";
    }

    private static String fmt(long ms) {
        if (ms < 0) ms = 0;
        long total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }
}
