package com.example.player;

import java.util.ArrayList;
import java.util.List;

class Program {
    String name;
    List<Cmd> cmds = new ArrayList<Cmd>();

    Program() {
    }

    Program(String name) {
        this.name = name;
    }
}

class ProgramCodec {

    static final String HEADER = "PROG\t";
    static final String FOOTER = "END";

    static String encode(List<Program> progs) {
        StringBuilder sb = new StringBuilder();
        for (Program p : progs) {
            sb.append(HEADER).append(escape(p.name)).append('\n');
            for (Cmd c : p.cmds) {
                sb.append(CmdCodec.encode(c)).append('\n');
            }
            sb.append(FOOTER).append('\n');
        }
        return sb.toString();
    }

    static List<Program> decode(String data) {
        List<Program> out = new ArrayList<Program>();
        if (data == null) return out;
        Program cur = null;
        for (String line : data.split("\r?\n")) {
            String trimmed = line.trim();
            if (trimmed.length() == 0) continue;
            if (line.startsWith(HEADER)) {
                cur = new Program(unescape(line.substring(HEADER.length())));
                out.add(cur);
            } else if (FOOTER.equals(trimmed)) {
                cur = null;
            } else if (cur != null) {
                try {
                    cur.cmds.add(CmdCodec.decode(line));
                } catch (Exception ignored) {
                }
            }
        }
        return out;
    }

    private static String escape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (ch == '\\') sb.append("\\\\");
            else if (ch == '\t') sb.append("\\t");
            else if (ch == '\n') sb.append("\\n");
            else if (ch == '\r') sb.append("\\r");
            else sb.append(ch);
        }
        return sb.toString();
    }

    private static String unescape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (ch == '\\' && i + 1 < s.length()) {
                char nxt = s.charAt(i + 1);
                if (nxt == 't') { sb.append('\t'); i++; }
                else if (nxt == 'n') { sb.append('\n'); i++; }
                else if (nxt == 'r') { sb.append('\r'); i++; }
                else if (nxt == '\\') { sb.append('\\'); i++; }
                else sb.append(ch);
            } else {
                sb.append(ch);
            }
        }
        return sb.toString();
    }
}
