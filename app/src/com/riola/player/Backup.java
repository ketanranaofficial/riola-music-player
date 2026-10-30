package com.riola.player;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Writing programs out to a file and reading them back.
 *
 * Import is deliberately suspicious of what it is handed: the file came from a
 * picker and could be anything at all.
 */
public final class Backup {

    private static final int MAX_BYTES = 4 * 1024 * 1024;

    /** What the next create-document result should write. */
    private static String pending = "";

    private Backup() { }

    // ---- export ----------------------------------------------------------
    public static void exportAll(Activity a, int req) {
        if (Store.PROGRAMS.isEmpty()) {
            Ui.toast(a, "There are no programs to export");
            return;
        }
        pending = json(new ArrayList<Program>(Store.PROGRAMS), true);
        ask(a, req, "riola-programs.json");
    }

    public static void exportOne(Activity a, Program p, int req) {
        if (p == null) return;
        List<Program> one = new ArrayList<Program>();
        one.add(p);
        pending = json(one, false);
        ask(a, req, "riola-" + safe(p.name) + ".json");
    }

    private static void ask(Activity a, int req, String name) {
        Intent i = new Intent(Intent.ACTION_CREATE_DOCUMENT)
                .addCategory(Intent.CATEGORY_OPENABLE)
                .setType("application/json")
                .putExtra(Intent.EXTRA_TITLE, name);
        try { a.startActivityForResult(i, req); }
        catch (Exception e) { Ui.toast(a, "No file picker on this device"); }
    }

    public static void pickToImport(Activity a, int req) {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT)
                .addCategory(Intent.CATEGORY_OPENABLE)
                .setType("*/*");
        try { a.startActivityForResult(i, req); }
        catch (Exception e) { Ui.toast(a, "No file picker on this device"); }
    }

    /** Writes whatever the last export call prepared. */
    public static void write(Activity a, Uri uri) {
        String body = pending;
        pending = "";
        if (uri == null || body.length() == 0) {
            Ui.toast(a, "Nothing to write");
            return;
        }
        OutputStream out = null;
        try {
            out = a.getContentResolver().openOutputStream(uri);
            if (out == null) { Ui.toast(a, "Could not write that file"); return; }
            out.write(body.getBytes("UTF-8"));
            out.flush();
            Ui.toast(a, "Exported");
        } catch (Exception e) {
            Ui.toast(a, "Could not write that file");
        } finally {
            if (out != null) try { out.close(); } catch (Exception e) { /* ignore */ }
        }
    }

    private static String json(List<Program> progs, boolean everyTrack) {
        try {
            JSONObject o = new JSONObject();
            o.put("riola", 1);
            o.put("saved", System.currentTimeMillis());

            JSONArray parr = new JSONArray();
            for (int i = 0; i < progs.size(); i++) parr.put(progs.get(i).toJson());
            o.put("programs", parr);

            // carry the track names and lengths so an import still reads
            // sensibly even where the files themselves cannot be opened
            JSONArray lib = new JSONArray();
            for (Track t : Store.LIB) {
                if (!everyTrack && !usedBy(progs, t.uri)) continue;
                JSONObject j = new JSONObject();
                j.put("u", t.uri);
                j.put("t", t.title);
                j.put("d", t.durMs);
                lib.put(j);
            }
            o.put("lib", lib);
            return o.toString(2);
        } catch (Exception e) {
            return "";
        }
    }

    private static boolean usedBy(List<Program> progs, String uri) {
        for (int i = 0; i < progs.size(); i++) {
            List<Step> steps = progs.get(i).steps;
            for (int k = 0; k < steps.size(); k++) {
                if (uri.equals(steps.get(k).trackUri)) return true;
            }
        }
        return false;
    }

    private static String safe(String name) {
        StringBuilder sb = new StringBuilder();
        String s = name == null ? "" : name.trim();
        for (int i = 0; i < s.length() && sb.length() < 40; i++) {
            char c = s.charAt(i);
            if (Character.isLetterOrDigit(c)) sb.append(c);
            else if (c == ' ' || c == '-' || c == '_') sb.append('-');
        }
        return sb.length() == 0 ? "program" : sb.toString();
    }

    // ---- import ----------------------------------------------------------
    public static void read(final Activity a, Uri uri) {
        if (uri == null) return;

        String text = null;
        InputStream in = null;
        try {
            in = a.getContentResolver().openInputStream(uri);
            if (in == null) { fail(a, "Riola could not open that file."); return; }
            ByteArrayOutputStream buf = new ByteArrayOutputStream();
            byte[] chunk = new byte[8192];
            int n, total = 0;
            while ((n = in.read(chunk)) > 0) {
                total += n;
                if (total > MAX_BYTES) {
                    fail(a, "That file is far too large to be a Riola export.");
                    return;
                }
                buf.write(chunk, 0, n);
            }
            text = new String(buf.toByteArray(), "UTF-8");
        } catch (Exception e) {
            fail(a, "Riola could not read that file.");
            return;
        } finally {
            if (in != null) try { in.close(); } catch (Exception e) { /* ignore */ }
        }

        if (text.trim().length() == 0) {
            fail(a, "That file is empty.");
            return;
        }

        JSONObject root;
        try {
            root = new JSONObject(text);
        } catch (Exception e) {
            fail(a, "That is not a Riola export. Pick the .json file that Riola wrote.");
            return;
        }

        JSONArray arr = root.optJSONArray("programs");
        if (arr == null || arr.length() == 0) {
            fail(a, "That file is readable, but there are no Riola programs inside it.");
            return;
        }

        // held back until we know at least one program survived, so a junk file
        // cannot litter the library on its way to being rejected
        List<Track> incoming = new ArrayList<Track>();
        JSONArray lib = root.optJSONArray("lib");
        if (lib != null) {
            for (int i = 0; i < lib.length(); i++) {
                JSONObject j = lib.optJSONObject(i);
                if (j == null) continue;
                String u = j.optString("u", "");
                if (u.length() == 0 || Store.byUri(u) != null) continue;
                incoming.add(new Track(u, j.optString("t", "track"), j.optLong("d", 0)));
            }
        }

        int added = 0, skipped = 0;
        List<Program> fresh = new ArrayList<Program>();
        for (int i = 0; i < arr.length(); i++) {
            JSONObject j = arr.optJSONObject(i);
            if (j == null) { skipped++; continue; }
            try {
                Program p = Program.fromJson(j);
                if (p.name == null || p.name.trim().length() == 0) p.name = "Imported program";
                if (p.steps.isEmpty() && j.optJSONArray("st") == null) { skipped++; continue; }
                if (Store.program(p.id) != null) {          // already here, keep both
                    p.id = Program.blank(p.name).id;
                    p.name = p.name + " (imported)";
                }
                p.updated = System.currentTimeMillis();
                Store.PROGRAMS.add(p);
                fresh.add(p);
                added++;
            } catch (Exception e) {
                skipped++;
            }
        }

        if (added == 0) {
            fail(a, "Nothing in that file could be read as a program.");
            return;
        }

        int tracks = incoming.size();
        Store.LIB.addAll(incoming);
        Store.saveLib(a);
        Store.savePrograms(a);

        // only meaningful once the imported tracks are actually in the library
        boolean anyMissing = false;
        for (int i = 0; i < fresh.size(); i++) {
            if (fresh.get(i).hasMissing()) { anyMissing = true; break; }
        }

        StringBuilder msg = new StringBuilder();
        msg.append("Added ").append(added).append(added == 1 ? " program" : " programs");
        if (tracks > 0) msg.append(" and ").append(tracks).append(tracks == 1 ? " track" : " tracks");
        msg.append(".");
        if (skipped > 0) {
            msg.append("\n\n").append(skipped).append(skipped == 1 ? " entry was" : " entries were")
               .append(" skipped because they could not be read.");
        }
        if (anyMissing) {
            msg.append("\n\nSome steps point at files this phone cannot open, so they are marked "
                     + "missing. Add those tracks again and the steps will reconnect on their own.");
        }
        Ui.dialog(a).setTitle("Imported").setMessage(msg.toString())
                .setPositiveButton("Done", null).show();
    }

    private static void fail(Activity a, String why) {
        Ui.dialog(a).setTitle("Could not import").setMessage(why)
                .setPositiveButton("OK", null).show();
    }
}
