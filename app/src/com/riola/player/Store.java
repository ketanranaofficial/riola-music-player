package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

/** Persistent state: the track library and the saved programs. */
public final class Store {

    /** Shared by every screen and by the playback engine (one process). */
    public static final CopyOnWriteArrayList<Track> LIB = new CopyOnWriteArrayList<Track>();
    public static final CopyOnWriteArrayList<Program> PROGRAMS = new CopyOnWriteArrayList<Program>();

    /**
     * Uris that were in the library but could not be opened. A file can vanish
     * without leaving the library: deleted, on a card that was pulled, or the
     * permission grant was revoked. Filled in by the pre-play check and by the
     * engine, and used to mark steps as missing.
     */
    public static final Set<String> MISSING = Collections.synchronizedSet(new HashSet<String>());

    private static boolean loaded = false;

    private Store() { }

    private static SharedPreferences sp(Context c) {
        return c.getApplicationContext().getSharedPreferences(Prefs.FILE, Context.MODE_PRIVATE);
    }

    public static synchronized void load(Context c) {
        if (loaded) return;
        loaded = true;
        LIB.clear();
        PROGRAMS.clear();
        try {
            JSONArray arr = new JSONArray(sp(c).getString("lib", "[]"));
            for (int i = 0; i < arr.length(); i++) {
                JSONObject o = arr.getJSONObject(i);
                Track t = new Track(o.getString("u"), o.optString("t", "track"), o.optLong("d", 0));
                t.audioTrack = o.optInt("a", -1);
                t.addedAt = o.optLong("ad", 0);
                t.modifiedAt = o.optLong("md", 0);
                LIB.add(t);
            }
        } catch (Exception e) { LIB.clear(); }
        dedupe();
        try {
            JSONArray arr = new JSONArray(sp(c).getString("programs", "[]"));
            for (int i = 0; i < arr.length(); i++) {
                JSONObject o = arr.optJSONObject(i);
                if (o != null) PROGRAMS.add(Program.fromJson(o));
            }
        } catch (Exception e) { PROGRAMS.clear(); }
        sortPrograms();
    }

    // ---- library ---------------------------------------------------------
    /**
     * One entry per real file. Older versions keyed only on the exact uri, so a
     * file added twice through different routes could sit in the list twice.
     */
    public static void dedupe() {
        java.util.HashSet<String> seen = new java.util.HashSet<String>();
        List<Track> keep = new java.util.ArrayList<Track>();
        for (Track t : LIB) if (seen.add(t.key())) keep.add(t);
        if (keep.size() == LIB.size()) return;
        LIB.clear();
        LIB.addAll(keep);
    }

    /** Finds a track however its uri happens to be spelled. */
    public static Track byKey(String key) {
        for (Track t : LIB) if (t.key().equals(key)) return t;
        return null;
    }

    public static Track byUri(String uri) {
        if (uri == null || uri.length() == 0) return null;
        for (Track t : LIB) if (uri.equals(t.uri)) return t;
        return null;
    }

    public static int indexOf(String uri) {
        for (int i = 0; i < LIB.size(); i++) if (LIB.get(i).uri.equals(uri)) return i;
        return -1;
    }

    /**
     * Can this file still be opened right now? Cheap enough to run over a
     * program's steps before playing it. Remembers the answer in MISSING so the
     * lists can mark the step without doing io on every redraw.
     */
    public static boolean readable(Context c, String uri) {
        Track t = byUri(uri);
        if (t == null) return false;
        java.io.InputStream in = null;
        try {
            in = c.getContentResolver().openInputStream(t.toUri());
            boolean ok = in != null;
            if (ok) MISSING.remove(uri);
            else MISSING.add(uri);
            return ok;
        } catch (Exception e) {
            MISSING.add(uri);
            return false;
        } finally {
            if (in != null) try { in.close(); } catch (Exception e) { /* ignore */ }
        }
    }

    public static void saveLib(Context c) {
        JSONArray arr = new JSONArray();
        for (Track t : LIB) {
            try {
                JSONObject o = new JSONObject();
                o.put("u", t.uri);
                o.put("t", t.title);
                o.put("d", t.durMs);
                o.put("a", t.audioTrack);
                o.put("ad", t.addedAt);
                o.put("md", t.modifiedAt);
                arr.put(o);
            } catch (Exception e) { /* skip this one */ }
        }
        sp(c).edit().putString("lib", arr.toString()).apply();
    }

    // ---- programs --------------------------------------------------------
    public static void sortPrograms() {
        List<Program> copy = new java.util.ArrayList<Program>(PROGRAMS);
        Collections.sort(copy, new Comparator<Program>() {
            public int compare(Program x, Program y) {
                long a = Math.max(x.updated, x.lastRun), b = Math.max(y.updated, y.lastRun);
                return a == b ? 0 : (a > b ? -1 : 1);
            }
        });
        PROGRAMS.clear();
        PROGRAMS.addAll(copy);
    }

    public static Program program(String id) {
        if (id == null) return null;
        for (Program p : PROGRAMS) if (p.id.equals(id)) return p;
        return null;
    }

    public static void put(Context c, Program p) {
        p.updated = System.currentTimeMillis();
        if (program(p.id) == null) PROGRAMS.add(p);
        savePrograms(c);
    }

    public static void delete(Context c, Program p) {
        PROGRAMS.remove(p);
        savePrograms(c);
    }

    public static void savePrograms(Context c) {
        sortPrograms();
        JSONArray arr = new JSONArray();
        for (Program p : PROGRAMS) {
            try { arr.put(p.toJson()); } catch (Exception e) { /* skip */ }
        }
        sp(c).edit().putString("programs", arr.toString()).apply();
    }

    // ---- ordering --------------------------------------------------------
    /** Manual keeps whatever order the tracks were arranged into. */
    public static final String[] SORTS = {
        "Manual order", "Name A to Z", "Name Z to A",
        "Recently added", "Oldest added", "Newest file", "Oldest file",
        "Longest first", "Shortest first"
    };

    /**
     * The library filtered and sorted for display. The stored order is never
     * touched, so manual order survives being sorted and coming back.
     */
    public static List<Track> view(int mode, String filter) {
        String f = filter == null ? "" : filter.trim().toLowerCase();
        List<Track> out = new java.util.ArrayList<Track>();
        for (Track t : LIB) {
            if (f.length() == 0 || t.shortTitle().toLowerCase().contains(f)) out.add(t);
        }
        if (mode <= 0) return out;
        final int m = mode;
        Collections.sort(out, new Comparator<Track>() {
            public int compare(Track a, Track b) {
                switch (m) {
                    case 1: return a.shortTitle().compareToIgnoreCase(b.shortTitle());
                    case 2: return b.shortTitle().compareToIgnoreCase(a.shortTitle());
                    case 3: return cmp(b.addedAt, a.addedAt);
                    case 4: return cmp(a.addedAt, b.addedAt);
                    case 5: return cmp(b.modifiedAt, a.modifiedAt);
                    case 6: return cmp(a.modifiedAt, b.modifiedAt);
                    case 7: return cmp(b.durMs, a.durMs);
                    default: return cmp(a.durMs, b.durMs);
                }
            }
        });
        return out;
    }

    private static int cmp(long a, long b) { return a == b ? 0 : (a < b ? -1 : 1); }

    /** A ready made program so a new user can hear something immediately. */
    public static Program sample() {
        Program p = Program.blank("My first program");
        if (LIB.size() > 0) {
            Track t = LIB.get(0);
            Step warm = Step.play(t);
            p.steps.add(warm);
            p.steps.add(Step.silence(60000));
            long end = t.durMs > 90000 ? 90000 : Math.max(20000, t.durMs / 2);
            Step drill = Step.section(t, 30000, end);
            drill.times = 4;
            drill.gapMs = 3000;
            p.steps.add(drill);
        }
        return p;
    }
}
