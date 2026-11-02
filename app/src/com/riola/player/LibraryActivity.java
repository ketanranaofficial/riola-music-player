package com.riola.player;

import android.app.Activity;
import android.content.ClipData;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Bundle;
import android.provider.DocumentsContract;
import android.provider.OpenableColumns;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/** Add, preview and organise the audio files Riola may use. */
public class LibraryActivity extends Activity implements PlayerBar.Host {

    private static final int REQ_FILES = 101, REQ_TREE = 102;

    private Prefs prefs;
    private Engine eng;
    private PlayerBar bar;
    private LinearLayout listBox;
    private TextView subtitle;
    private String filter = "";
    private android.widget.EditText search;

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes());
        super.onCreate(saved);
        Store.load(this);
        eng = Engine.get(this);
        setContentView(build());
        Ui.applyWindow(this);
        refresh();
    }

    @Override protected void onResume() { super.onResume(); bar.attach(); refresh(); }
    @Override protected void onPause()  { bar.detach(); super.onPause(); }

    private View build() {
        LinearLayout root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        Ui.Bar header = Ui.appBar(this, 0, "Tracks", "", true, null);
        subtitle = header.sub;
        root.addView(header.view);

        LinearLayout body = Ui.col(this);

        LinearLayout addCard = Ui.card(this);
        LinearLayout btns = Ui.row(this);
        LinearLayout files = Ui.btn(this, "Add files", Ico.PLUS, Ui.PRIMARY, new View.OnClickListener() {
            public void onClick(View v) { pickFiles(); }
        });
        files.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        Ui.margin(this, files, 0, 0, 8, 0);
        btns.addView(files);
        LinearLayout folder = Ui.btn(this, "Add folder", Ico.FOLDER, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { pickFolder(); }
        });
        folder.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        btns.addView(folder);
        addCard.addView(btns);
        TextView hint = Ui.tv(this, "Riola only reads your files - nothing is copied, moved or "
                + "changed. Video files work too: only their sound is played.",
                11.5f, Ui.DIM, false);
        Ui.margin(this, hint, 2, 8, 0, 0);
        addCard.addView(hint);
        body.addView(addCard);

        LinearLayout card = Ui.card(this);
        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.LIST, "In the library");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        head.addView(Ui.iconBtn(this, Ico.LIST, Ui.DIM, 16, "Sort the library", new View.OnClickListener() {
            public void onClick(View v) { sortMenu(); }
        }));
        head.addView(Ui.iconBtn(this, Ico.TRASH, Ui.DIM, 16, "Remove all tracks", new View.OnClickListener() {
            public void onClick(View v) { clearAll(); }
        }));
        card.addView(head);

        search = new android.widget.EditText(this);
        search.setHint("Search the library");
        search.setSingleLine(true);
        search.setTextSize(13);
        search.setTextColor(Ui.TXT);
        search.setHintTextColor(Ui.DIM);
        search.setBackground(Ui.rrs(this, Ui.FIELD, Ui.LINE, Ui.RAD_BTN, Ui.STROKE_W));
        int sp = Ui.dp(this, 10);
        search.setPadding(sp, sp, sp, sp);
        search.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, search, 0, 0, 0, 8);
        search.addTextChangedListener(new android.text.TextWatcher() {
            public void beforeTextChanged(CharSequence s, int a, int b, int c) { }
            public void onTextChanged(CharSequence s, int a, int b, int c) { }
            public void afterTextChanged(android.text.Editable e) {
                filter = e.toString().trim().toLowerCase();
                refresh();
            }
        });
        card.addView(search);

        listBox = Ui.col(this);
        card.addView(listBox);
        body.addView(card);

        body.addView(Ui.gap(this, 6));
        root.addView(Ui.scroller(this, body));

        bar = new PlayerBar(this, this);
        root.addView(bar.view);
        return root;
    }

    private void refresh() {
        int n = Store.LIB.size();
        String sortName = Store.SORTS[Math.max(0, Math.min(prefs.librarySort(), Store.SORTS.length - 1))];
        subtitle.setText(n == 0 ? "nothing added yet"
                : (n + (n == 1 ? " track" : " tracks") + "  .  " + sortName.toLowerCase()));
        if (search != null) search.setVisibility(n > 8 ? View.VISIBLE : View.GONE);

        listBox.removeAllViews();
        if (n == 0) {
            listBox.addView(Ui.emptyState(this, Ico.NOTE, "No tracks yet",
                    "Add single files, or point Riola at a folder and it will find the audio inside."));
            return;
        }

        List<Track> view = Store.view(prefs.librarySort(), filter);
        if (view.isEmpty()) {
            listBox.addView(Ui.tv(this, "Nothing matches \"" + filter + "\".", 13, Ui.DIM, false));
            return;
        }
        for (int i = 0; i < view.size(); i++) listBox.addView(row(view.get(i)));
    }

    private void sortMenu() {
        Ui.dialog(this).setTitle("Sort the library").setItems(Store.SORTS,
                new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                prefs.librarySort(which);
                refresh();
            }
        }).show();
    }

    private View row(final Track t) {
        boolean live = eng.st.running && eng.st.preview && t.uri.equals(eng.st.trackUri);

        LinearLayout r = Ui.row(this);
        r.setBackground(Ui.ripple(Ui.rr(this, Ui.SURF2, 12)));
        r.setPadding(Ui.dp(this, 6), Ui.dp(this, 8), Ui.dp(this, 2), Ui.dp(this, 8));
        Ui.margin(this, r, 0, 0, 0, 6);

        r.addView(Ui.roundBtn(this, live ? Ico.STOP : Ico.PLAY, 16, false, "Preview", new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                if (eng.isRunning()) { bar.stop(); }
                else { eng.previewTrack(t); PlayerBar.startService(LibraryActivity.this); }
                refresh();
            }
        }));
        r.addView(Ui.hgap(this, 6));

        LinearLayout col = Ui.col(this);
        col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        TextView title = Ui.tv(this, t.shortTitle(), 14, Ui.TXT, false);
        Ui.ellipsize(title);
        col.addView(title);
        col.addView(Ui.tv(this, (t.durMs > 0 ? Fmt.ms(t.durMs) : "length unknown")
                + (t.isVideo() ? "  .  video, audio only" : "") + usage(t),
                11, Ui.DIM, false));
        r.addView(col);

        r.addView(Ui.iconBtn(this, Ico.MORE, Ui.DIM, 16, "Track options", new View.OnClickListener() {
            public void onClick(View v) { menu(Store.LIB.indexOf(t)); }
        }));
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { menu(Store.LIB.indexOf(t)); }
        });
        return r;
    }

    private String usage(Track t) {
        int n = 0;
        for (Program p : Store.PROGRAMS) {
            for (int i = 0; i < p.steps.size(); i++) {
                if (t.uri.equals(p.steps.get(i).trackUri)) { n++; break; }
            }
        }
        return n == 0 ? "" : ("  .  used in " + n + (n == 1 ? " program" : " programs"));
    }

    private void menu(final int index) {
        if (index < 0 || index >= Store.LIB.size()) return;
        final Track t = Store.LIB.get(index);
        final String[] items = { "Preview", "Rename", "Choose audio stream",
                                 "Move up", "Move down", "Remove from library" };
        Ui.dialog(this).setTitle(t.shortTitle()).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                switch (which) {
                    case 0:
                        eng.previewTrack(t);
                        PlayerBar.startService(LibraryActivity.this);
                        refresh();
                        break;
                    case 1:
                        Pickers.text(LibraryActivity.this, "Rename track", t.shortTitle(), "name",
                                new Pickers.OnText() {
                            public void picked(String s) {
                                t.title = s;
                                Store.saveLib(LibraryActivity.this);
                                refresh();
                            }
                        });
                        break;
                    case 2: chooseAudioStream(t); break;
                    case 3: move(index, -1); break;
                    case 4: move(index, 1); break;
                    default: remove(index, t);
                }
            }
        }).show();
    }

    /**
     * Films and some recordings carry several audio streams. Reading them means
     * preparing the file, so it happens off the main thread.
     */
    private void chooseAudioStream(final Track t) {
        Ui.toast(this, "Reading " + t.shortTitle() + "...");
        new Thread(new Runnable() {
            public void run() {
                final java.util.List<String> labels = new ArrayList<String>();
                final java.util.List<Integer> indexes = new ArrayList<Integer>();
                android.media.MediaPlayer m = new android.media.MediaPlayer();
                try {
                    m.setDataSource(LibraryActivity.this, t.toUri());
                    m.prepare();
                    android.media.MediaPlayer.TrackInfo[] info = m.getTrackInfo();
                    for (int i = 0; i < info.length; i++) {
                        if (info[i].getTrackType() != android.media.MediaPlayer.TrackInfo.MEDIA_TRACK_TYPE_AUDIO) {
                            continue;
                        }
                        String lang = info[i].getLanguage();
                        if (lang == null || lang.length() == 0 || lang.equals("und")) lang = "unnamed";
                        labels.add("Stream " + (indexes.size() + 1) + "  (" + lang + ")");
                        indexes.add(Integer.valueOf(i));
                    }
                } catch (Exception e) {
                    labels.clear();
                } finally {
                    try { m.release(); } catch (Exception e) { /* ignore */ }
                }
                runOnUiThread(new Runnable() {
                    public void run() { showStreams(t, labels, indexes); }
                });
            }
        }, "riola-streams").start();
    }

    private void showStreams(final Track t, java.util.List<String> labels,
                             final java.util.List<Integer> indexes) {
        if (labels.isEmpty()) {
            Ui.dialog(this).setTitle("No choice to make")
                    .setMessage("Riola could not read the audio streams in this file, or there is "
                            + "only one. It will play whichever the file provides.")
                    .setPositiveButton("OK", null).show();
            return;
        }
        final String[] items = new String[labels.size() + 1];
        items[0] = "Whatever the file defaults to";
        for (int i = 0; i < labels.size(); i++) items[i + 1] = labels.get(i);
        Ui.dialog(this).setTitle(t.shortTitle()).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                t.audioTrack = which == 0 ? -1 : indexes.get(which - 1).intValue();
                Store.saveLib(LibraryActivity.this);
                Ui.toast(LibraryActivity.this, which == 0 ? "Using the file's own choice"
                                                          : ("Using " + items[which]));
                refresh();
            }
        }).show();
    }

    private void move(int index, int dir) {
        int to = index + dir;
        if (to < 0 || to >= Store.LIB.size()) return;
        if (prefs.librarySort() != 0) {
            prefs.librarySort(0);
            Ui.toast(this, "Switched back to manual order");
        }
        Track a = Store.LIB.get(index);
        Store.LIB.set(index, Store.LIB.get(to));
        Store.LIB.set(to, a);
        Store.saveLib(this);
        refresh();
    }

    private void remove(final int index, final Track t) {
        String extra = usage(t);
        Ui.dialog(this).setTitle("Remove " + t.shortTitle() + "?")
                .setMessage(extra.length() == 0
                        ? "The file on your phone is not touched."
                        : ("This track is" + extra.replace("  .  used", " used")
                           + ". Those steps will be marked missing and skipped.\n\nThe file itself is not touched."))
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Remove", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        Store.LIB.remove(index);
                        Store.saveLib(LibraryActivity.this);
                        refresh();
                    }
                }).show();
    }

    private void clearAll() {
        if (Store.LIB.isEmpty()) return;
        Ui.dialog(this).setTitle("Remove every track?")
                .setMessage("Programs keep their steps but they will have nothing to play. Your files are untouched.")
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Remove all", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        Store.LIB.clear();
                        Store.saveLib(LibraryActivity.this);
                        refresh();
                    }
                }).show();
    }

    // ======================================================================
    // adding files
    // ======================================================================
    private void pickFiles() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("*/*");
        i.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        i.putExtra(Intent.EXTRA_MIME_TYPES, new String[]{ "audio/*", "video/*",
                "application/ogg", "application/x-ogg" });
        i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
        try { startActivityForResult(i, REQ_FILES); }
        catch (Exception e) { Ui.toast(this, "No file picker on this device"); }
    }

    private void pickFolder() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
        i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
        try { startActivityForResult(i, REQ_TREE); }
        catch (Exception e) { Ui.toast(this, "No folder picker on this device"); }
    }

    @Override
    protected void onActivityResult(int req, int result, Intent data) {
        super.onActivityResult(req, result, data);
        if (result != RESULT_OK || data == null) return;

        if (req == REQ_FILES) {
            List<Uri> uris = new ArrayList<Uri>();
            ClipData clip = data.getClipData();
            if (clip != null) for (int i = 0; i < clip.getItemCount(); i++) uris.add(clip.getItemAt(i).getUri());
            else if (data.getData() != null) uris.add(data.getData());
            int added = 0;
            for (Uri u : uris) {
                persist(u);
                if (add(u, displayName(u), lastModified(u))) added++;
            }
            finishAdding(added);

        } else if (req == REQ_TREE) {
            Uri tree = data.getData();
            if (tree == null) return;
            persist(tree);
            scanFolder(tree);
        }
    }

    private void persist(Uri u) {
        try { getContentResolver().takePersistableUriPermission(u, Intent.FLAG_GRANT_READ_URI_PERMISSION); }
        catch (Exception e) { /* some providers do not offer persistable grants */ }
    }

    private boolean add(Uri u, String name) { return add(u, name, 0); }

    /**
     * The same file has a different uri depending on whether it was picked
     * directly or found by scanning a folder, so the check is on identity
     * rather than on the string.
     */
    private boolean add(Uri u, String name, long modified) {
        String s = u.toString();
        Store.MISSING.remove(s);      // adding it back clears any earlier failure
        Track t = new Track(s, name, 0);
        if (Store.byKey(t.key()) != null) return false;
        t.addedAt = System.currentTimeMillis();
        t.modifiedAt = modified;
        Store.LIB.add(t);
        return true;
    }

    private void finishAdding(int added) {
        Store.saveLib(this);
        refresh();
        Ui.toast(this, added == 0 ? "Nothing new was added" : (added + (added == 1 ? " track added" : " tracks added")));
        readDurations();
    }

    private long lastModified(Uri u) {
        Cursor c = null;
        try {
            c = getContentResolver().query(u,
                    new String[]{ DocumentsContract.Document.COLUMN_LAST_MODIFIED },
                    null, null, null);
            if (c != null && c.moveToFirst() && !c.isNull(0)) return c.getLong(0);
        } catch (Exception e) { /* the provider need not offer it */ }
        finally { if (c != null) c.close(); }
        return 0;
    }

    private String displayName(Uri u) {
        Cursor c = null;
        try {
            c = getContentResolver().query(u, new String[]{ OpenableColumns.DISPLAY_NAME }, null, null, null);
            if (c != null && c.moveToFirst()) {
                String n = c.getString(0);
                if (n != null && n.length() > 0) return n;
            }
        } catch (Exception e) { /* fall through */ }
        finally { if (c != null) c.close(); }
        String last = u.getLastPathSegment();
        return last == null ? "track" : last.substring(last.lastIndexOf('/') + 1);
    }

    private void scanFolder(final Uri tree) {
        Ui.toast(this, "Scanning folder...");
        new Thread(new Runnable() {
            public void run() {
                final List<Track> found = new ArrayList<Track>();
                try { collect(tree, DocumentsContract.getTreeDocumentId(tree), found, 0); }
                catch (Exception e) { /* partial results are fine */ }
                Collections.sort(found, new Comparator<Track>() {
                    public int compare(Track a, Track b) { return a.title.compareToIgnoreCase(b.title); }
                });
                final int[] added = { 0 };
                for (Track t : found) if (add(Uri.parse(t.uri), t.title, t.modifiedAt)) added[0]++;
                runOnUiThread(new Runnable() {
                    public void run() { finishAdding(added[0]); }
                });
            }
        }).start();
    }

    private void collect(Uri tree, String docId, List<Track> out, int depth) {
        if (depth > 6 || out.size() > 500) return;
        Uri children = DocumentsContract.buildChildDocumentsUriUsingTree(tree, docId);
        Cursor c = null;
        try {
            c = getContentResolver().query(children, new String[]{
                    DocumentsContract.Document.COLUMN_DOCUMENT_ID,
                    DocumentsContract.Document.COLUMN_DISPLAY_NAME,
                    DocumentsContract.Document.COLUMN_MIME_TYPE,
                    DocumentsContract.Document.COLUMN_LAST_MODIFIED }, null, null, null);
            if (c == null) return;
            while (c.moveToNext()) {
                String id = c.getString(0), name = c.getString(1), mime = c.getString(2);
                long modified = c.isNull(3) ? 0 : c.getLong(3);
                if (DocumentsContract.Document.MIME_TYPE_DIR.equals(mime)) {
                    collect(tree, id, out, depth + 1);
                } else if (isPlayable(name, mime)) {
                    Track t = new Track(DocumentsContract.buildDocumentUriUsingTree(tree, id).toString(),
                            name, 0);
                    t.modifiedAt = modified;
                    out.add(t);
                }
            }
        } catch (Exception e) { /* skip this folder */ }
        finally { if (c != null) c.close(); }
    }

    /** Anything Riola can pull sound out of, video included. */
    private boolean isPlayable(String name, String mime) {
        if (mime != null && (mime.startsWith("audio/") || mime.startsWith("video/"))) return true;
        if (name == null) return false;
        String n = name.toLowerCase();
        String[] ok = { ".mp3", ".m4a", ".aac", ".wav", ".ogg", ".oga", ".opus", ".flac", ".mka",
                        ".wma", ".aif", ".aiff", ".amr",
                        ".mp4", ".mkv", ".avi", ".mov", ".webm", ".m4v", ".3gp", ".ts", ".flv",
                        ".wmv", ".mpg", ".mpeg" };
        for (int i = 0; i < ok.length; i++) if (n.endsWith(ok[i])) return true;
        return false;
    }

    private void readDurations() {
        new Thread(new Runnable() {
            public void run() {
                boolean changed = false;
                for (Track t : Store.LIB) {
                    if (t.durMs > 0) continue;
                    MediaMetadataRetriever mmr = new MediaMetadataRetriever();
                    try {
                        mmr.setDataSource(LibraryActivity.this, t.toUri());
                        String d = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION);
                        if (d != null) { t.durMs = Long.parseLong(d); changed = true; }
                    } catch (Exception e) { /* unreadable file */ }
                    finally { try { mmr.release(); } catch (Exception e) { } }
                }
                if (!changed) return;
                Store.saveLib(LibraryActivity.this);
                runOnUiThread(new Runnable() {
                    public void run() { refresh(); }
                });
            }
        }).start();
    }

    // ---- engine callbacks ------------------------------------------------
    public void onEngineState(Engine.St s) { }

    public void onEngineFinished(boolean completed) { refresh(); }
}
