package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.media.MediaMetadataRetriever;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.provider.DocumentsContract;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class LibraryActivity extends Activity implements PlayerBar.Host {
    private static final int REQ_FILES = 101;
    private static final int REQ_TREE = 102;
    private PlayerBar bar;
    private Engine eng;
    private String filter = "";
    private LinearLayout listBox;
    private Prefs prefs;
    private EditText search;
    private TextView subtitle;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Prefs prefs = new Prefs(this);
        this.prefs = prefs;
        Ui.theme(prefs);
        setTheme(Ui.themeRes(this.prefs.dark()));
        super.onCreate(bundle);
        Store.load(this);
        this.eng = Engine.get(this);
        setContentView(build());
        Ui.applyWindow(this);
        refresh();
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        this.bar.attach();
        refresh();
    }

    @Override // android.app.Activity
    protected void onPause() {
        this.bar.detach();
        super.onPause();
    }

    private View build() {
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setBackgroundColor(Ui.BG);
        linearLayoutCol.setFitsSystemWindows(true);
        Ui.Bar barAppBar = Ui.appBar(this, 0, "Tracks", "", true, null);
        this.subtitle = barAppBar.sub;
        linearLayoutCol.addView(barAppBar.view);
        LinearLayout linearLayoutCol2 = Ui.col(this);
        LinearLayout linearLayoutCard = Ui.card(this);
        LinearLayout linearLayoutRow = Ui.row(this);
        LinearLayout linearLayoutBtn = Ui.btn(this, "Add files", 6, 0, new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.pickFiles();
            }
        });
        linearLayoutBtn.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        Ui.margin(this, linearLayoutBtn, 0.0f, 0.0f, 8.0f, 0.0f);
        linearLayoutRow.addView(linearLayoutBtn);
        LinearLayout linearLayoutBtn2 = Ui.btn(this, "Add folder", 7, 1, new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.pickFolder();
            }
        });
        linearLayoutBtn2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(linearLayoutBtn2);
        linearLayoutCard.addView(linearLayoutRow);
        View viewTv = Ui.tv(this, "Riola only reads your files - nothing is copied, moved or changed. Video files work too: only their sound is played.", 11.5f, Ui.DIM, false);
        Ui.margin(this, viewTv, 2.0f, 8.0f, 0.0f, 0.0f);
        linearLayoutCard.addView(viewTv);
        linearLayoutCol2.addView(linearLayoutCard);
        LinearLayout linearLayoutCard2 = Ui.card(this);
        LinearLayout linearLayoutRow2 = Ui.row(this);
        LinearLayout linearLayoutHeading = Ui.heading(this, 21, "In the library");
        linearLayoutHeading.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow2.addView(linearLayoutHeading);
        linearLayoutRow2.addView(Ui.iconBtn(this, 21, Ui.DIM, 16, "Sort the library", new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.sortMenu();
            }
        }));
        linearLayoutRow2.addView(Ui.iconBtn(this, 8, Ui.DIM, 16, "Remove all tracks", new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.clearAll();
            }
        }));
        linearLayoutCard2.addView(linearLayoutRow2);
        EditText editText = new EditText(this);
        this.search = editText;
        editText.setHint("Search the library");
        this.search.setSingleLine(true);
        this.search.setTextSize(13.0f);
        this.search.setTextColor(Ui.TXT);
        this.search.setHintTextColor(Ui.DIM);
        this.search.setBackground(Ui.rrs(this, Ui.FIELD, Ui.LINE, Ui.RAD_BTN, Ui.STROKE_W));
        int iDp = Ui.dp(this, 10.0f);
        this.search.setPadding(iDp, iDp, iDp, iDp);
        this.search.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, this.search, 0.0f, 0.0f, 0.0f, 8.0f);
        this.search.addTextChangedListener(new TextWatcher() { // from class: com.riola.player.LibraryActivity.5
            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                LibraryActivity.this.filter = editable.toString().trim().toLowerCase();
                LibraryActivity.this.refresh();
            }
        });
        linearLayoutCard2.addView(this.search);
        LinearLayout linearLayoutCol3 = Ui.col(this);
        this.listBox = linearLayoutCol3;
        linearLayoutCard2.addView(linearLayoutCol3);
        linearLayoutCol2.addView(linearLayoutCard2);
        linearLayoutCol2.addView(Ui.gap(this, 6.0f));
        linearLayoutCol.addView(Ui.scroller(this, linearLayoutCol2));
        PlayerBar playerBar = new PlayerBar(this, this);
        this.bar = playerBar;
        linearLayoutCol.addView(playerBar.view);
        return linearLayoutCol;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void refresh() {
        int size = Store.LIB.size();
        String str = Store.SORTS[Math.max(0, Math.min(this.prefs.librarySort(), Store.SORTS.length - 1))];
        this.subtitle.setText(size == 0 ? "nothing added yet" : size + (size == 1 ? " track" : " tracks") + "  .  " + str.toLowerCase());
        EditText editText = this.search;
        if (editText != null) {
            editText.setVisibility(size > 8 ? 0 : 8);
        }
        this.listBox.removeAllViews();
        if (size == 0) {
            this.listBox.addView(Ui.emptyState(this, 14, "No tracks yet", "Add single files, or point Riola at a folder and it will find the audio inside."));
            return;
        }
        List<Track> listView = Store.view(this.prefs.librarySort(), this.filter);
        if (listView.isEmpty()) {
            this.listBox.addView(Ui.tv(this, "Nothing matches \"" + this.filter + "\".", 13.0f, Ui.DIM, false));
            return;
        }
        for (int i = 0; i < listView.size(); i++) {
            this.listBox.addView(row(listView.get(i)));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void sortMenu() {
        Ui.dialog(this).setTitle("Sort the library").setItems(Store.SORTS, new DialogInterface.OnClickListener() { // from class: com.riola.player.LibraryActivity.6
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                LibraryActivity.this.prefs.librarySort(i);
                LibraryActivity.this.refresh();
            }
        }).show();
    }

    private View row(final Track track) {
        boolean z = this.eng.st.running && this.eng.st.preview && track.uri.equals(this.eng.st.trackUri);
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setBackground(Ui.ripple(Ui.rr(this, Ui.SURF2, 12.0f)));
        linearLayoutRow.setPadding(Ui.dp(this, 6.0f), Ui.dp(this, 8.0f), Ui.dp(this, 2.0f), Ui.dp(this, 8.0f));
        Ui.margin(this, linearLayoutRow, 0.0f, 0.0f, 0.0f, 6.0f);
        linearLayoutRow.addView(Ui.roundBtn(this, z ? 3 : 1, 16, false, "Preview", new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                if (LibraryActivity.this.eng.isRunning()) {
                    LibraryActivity.this.bar.stop();
                } else {
                    LibraryActivity.this.eng.previewTrack(track);
                    PlayerBar.startService(LibraryActivity.this);
                }
                LibraryActivity.this.refresh();
            }
        }));
        linearLayoutRow.addView(Ui.hgap(this, 6.0f));
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        TextView textViewTv = Ui.tv(this, track.shortTitle(), 14.0f, Ui.TXT, false);
        Ui.ellipsize(textViewTv);
        linearLayoutCol.addView(textViewTv);
        linearLayoutCol.addView(Ui.tv(this, (track.durMs > 0 ? Fmt.ms(track.durMs) : "length unknown") + (track.isVideo() ? "  .  video, audio only" : "") + usage(track), 11.0f, Ui.DIM, false));
        linearLayoutRow.addView(linearLayoutCol);
        linearLayoutRow.addView(Ui.iconBtn(this, 25, Ui.DIM, 16, "Track options", new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.8
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.menu(Store.LIB.indexOf(track));
            }
        }));
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.LibraryActivity.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                LibraryActivity.this.menu(Store.LIB.indexOf(track));
            }
        });
        return linearLayoutRow;
    }

    private String usage(Track track) {
        int i = 0;
        for (Program program : Store.PROGRAMS) {
            for (int i2 = 0; i2 < program.steps.size(); i2++) {
                if (track.uri.equals(program.steps.get(i2).trackUri)) {
                    i++;
                    break;
                }
            }
        }
        if (i == 0) {
            return "";
        }
        return "  .  used in " + i + (i == 1 ? " program" : " programs");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void menu(final int i) {
        if (i < 0 || i >= Store.LIB.size()) {
            return;
        }
        final Track track = Store.LIB.get(i);
        Ui.dialog(this).setTitle(track.shortTitle()).setItems(new String[]{"Preview", "Rename", "Choose audio stream", "Move up", "Move down", "Remove from library"}, new DialogInterface.OnClickListener() { // from class: com.riola.player.LibraryActivity.10
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                switch (i2) {
                    case 0:
                        LibraryActivity.this.eng.previewTrack(track);
                        PlayerBar.startService(LibraryActivity.this);
                        LibraryActivity.this.refresh();
                        break;
                    case 1:
                        Pickers.text(LibraryActivity.this, "Rename track", track.shortTitle(), "name", new Pickers.OnText() { // from class: com.riola.player.LibraryActivity.10.1
                            @Override // com.riola.player.Pickers.OnText
                            public void picked(String str) {
                                track.title = str;
                                Store.saveLib(LibraryActivity.this);
                                LibraryActivity.this.refresh();
                            }
                        });
                        break;
                    case 2:
                        LibraryActivity.this.chooseAudioStream(track);
                        break;
                    case 3:
                        LibraryActivity.this.move(i, -1);
                        break;
                    case 4:
                        LibraryActivity.this.move(i, 1);
                        break;
                    default:
                        LibraryActivity.this.remove(i, track);
                        break;
                }
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void chooseAudioStream(final Track track) {
        Ui.toast(this, "Reading " + track.shortTitle() + "...");
        new Thread(new Runnable() { // from class: com.riola.player.LibraryActivity.11
            @Override // java.lang.Runnable
            public void run() {
                final ArrayList arrayList = new ArrayList();
                final ArrayList arrayList2 = new ArrayList();
                MediaPlayer mediaPlayer = new MediaPlayer();
                try {
                    try {
                        try {
                            mediaPlayer.setDataSource(LibraryActivity.this, track.toUri());
                            mediaPlayer.prepare();
                            MediaPlayer.TrackInfo[] trackInfo = mediaPlayer.getTrackInfo();
                            for (int i = 0; i < trackInfo.length; i++) {
                                if (trackInfo[i].getTrackType() == 2) {
                                    String language = trackInfo[i].getLanguage();
                                    if (language == null || language.length() == 0 || language.equals("und")) {
                                        language = "unnamed";
                                    }
                                    arrayList.add("Stream " + (arrayList2.size() + 1) + "  (" + language + ")");
                                    arrayList2.add(Integer.valueOf(i));
                                }
                            }
                            mediaPlayer.release();
                        } catch (Throwable th) {
                            try {
                                mediaPlayer.release();
                            } catch (Exception e) {
                            }
                            throw th;
                        }
                    } catch (Exception e2) {
                        arrayList.clear();
                        mediaPlayer.release();
                    }
                } catch (Exception e3) {
                }
                LibraryActivity.this.runOnUiThread(new Runnable() { // from class: com.riola.player.LibraryActivity.11.1
                    @Override // java.lang.Runnable
                    public void run() {
                        LibraryActivity.this.showStreams(track, arrayList, arrayList2);
                    }
                });
            }
        }, "riola-streams").start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showStreams(final Track track, List<String> list, final List<Integer> list2) {
        if (list.isEmpty()) {
            Ui.dialog(this).setTitle("No choice to make").setMessage("Riola could not read the audio streams in this file, or there is only one. It will play whichever the file provides.").setPositiveButton("OK", (DialogInterface.OnClickListener) null).show();
            return;
        }
        final String[] strArr = new String[list.size() + 1];
        int i = 0;
        strArr[0] = "Whatever the file defaults to";
        while (i < list.size()) {
            int i2 = i + 1;
            strArr[i2] = list.get(i);
            i = i2;
        }
        Ui.dialog(this).setTitle(track.shortTitle()).setItems(strArr, new DialogInterface.OnClickListener() { // from class: com.riola.player.LibraryActivity.12
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i3) {
                track.audioTrack = i3 == 0 ? -1 : ((Integer) list2.get(i3 - 1)).intValue();
                Store.saveLib(LibraryActivity.this);
                Ui.toast(LibraryActivity.this, i3 == 0 ? "Using the file's own choice" : "Using " + strArr[i3]);
                LibraryActivity.this.refresh();
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void move(int i, int i2) {
        int i3 = i2 + i;
        if (i3 < 0 || i3 >= Store.LIB.size()) {
            return;
        }
        if (this.prefs.librarySort() != 0) {
            this.prefs.librarySort(0);
            Ui.toast(this, "Switched back to manual order");
        }
        Track track = Store.LIB.get(i);
        Store.LIB.set(i, Store.LIB.get(i3));
        Store.LIB.set(i3, track);
        Store.saveLib(this);
        refresh();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void remove(final int i, Track track) {
        String str;
        String strUsage = usage(track);
        AlertDialog.Builder title = Ui.dialog(this).setTitle("Remove " + track.shortTitle() + "?");
        if (strUsage.length() == 0) {
            str = "The file on your phone is not touched.";
        } else {
            str = "This track is" + strUsage.replace("  .  used", " used") + ". Those steps will be marked missing and skipped.\n\nThe file itself is not touched.";
        }
        title.setMessage(str).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Remove", new DialogInterface.OnClickListener() { // from class: com.riola.player.LibraryActivity.13
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                Store.LIB.remove(i);
                Store.saveLib(LibraryActivity.this);
                LibraryActivity.this.refresh();
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void clearAll() {
        if (Store.LIB.isEmpty()) {
            return;
        }
        Ui.dialog(this).setTitle("Remove every track?").setMessage("Programs keep their steps but they will have nothing to play. Your files are untouched.").setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Remove all", new DialogInterface.OnClickListener() { // from class: com.riola.player.LibraryActivity.14
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                Store.LIB.clear();
                Store.saveLib(LibraryActivity.this);
                LibraryActivity.this.refresh();
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pickFiles() {
        Intent intent = new Intent("android.intent.action.OPEN_DOCUMENT");
        intent.addCategory("android.intent.category.OPENABLE");
        intent.setType("*/*");
        intent.putExtra("android.intent.extra.ALLOW_MULTIPLE", true);
        intent.putExtra("android.intent.extra.MIME_TYPES", new String[]{"audio/*", "video/*", "application/ogg", "application/x-ogg"});
        intent.addFlags(65);
        try {
            startActivityForResult(intent, REQ_FILES);
        } catch (Exception e) {
            Ui.toast(this, "No file picker on this device");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pickFolder() {
        Intent intent = new Intent("android.intent.action.OPEN_DOCUMENT_TREE");
        intent.addFlags(65);
        try {
            startActivityForResult(intent, REQ_TREE);
        } catch (Exception e) {
            Ui.toast(this, "No folder picker on this device");
        }
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        Uri data;
        super.onActivityResult(i, i2, intent);
        if (i2 != -1 || intent == null) {
            return;
        }
        if (i == REQ_FILES) {
            ArrayList<Uri> arrayList = new ArrayList();
            ClipData clipData = intent.getClipData();
            int i3 = 0;
            if (clipData != null) {
                for (int i4 = 0; i4 < clipData.getItemCount(); i4++) {
                    arrayList.add(clipData.getItemAt(i4).getUri());
                }
            } else if (intent.getData() != null) {
                arrayList.add(intent.getData());
            }
            for (Uri uri : arrayList) {
                persist(uri);
                if (add(uri, displayName(uri), lastModified(uri))) {
                    i3++;
                }
            }
            finishAdding(i3);
            return;
        }
        if (i != REQ_TREE || (data = intent.getData()) == null) {
            return;
        }
        persist(data);
        scanFolder(data);
    }

    private void persist(Uri uri) {
        try {
            getContentResolver().takePersistableUriPermission(uri, 1);
        } catch (Exception e) {
        }
    }

    private boolean add(Uri uri, String str) {
        return add(uri, str, 0L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean add(Uri uri, String str, long j) {
        String string = uri.toString();
        Store.MISSING.remove(string);
        Track track = new Track(string, str, 0L);
        if (Store.byKey(track.key()) != null) {
            return false;
        }
        track.addedAt = System.currentTimeMillis();
        track.modifiedAt = j;
        Store.LIB.add(track);
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void finishAdding(int i) {
        String str;
        Store.saveLib(this);
        refresh();
        if (i == 0) {
            str = "Nothing new was added";
        } else {
            str = i + (i == 1 ? " track added" : " tracks added");
        }
        Ui.toast(this, str);
        readDurations();
    }

    private long lastModified(Uri uri) {
        Cursor cursorQuery = null;
        try {
            cursorQuery = getContentResolver().query(uri, new String[]{"last_modified"}, null, null, null);
            if (cursorQuery != null && cursorQuery.moveToFirst() && !cursorQuery.isNull(0)) {
                return cursorQuery.getLong(0);
            }
            if (cursorQuery == null) {
                return 0L;
            }
        } catch (Exception e) {
            if (cursorQuery == null) {
                return 0L;
            }
        } finally {
            if (cursorQuery != null) {
                cursorQuery.close();
            }
        }
        return 0L;
    }

    /* JADX WARN: Code duplicated, block: B:22:0x003d A[PHI: r1
      0x003d: PHI (r1v3 android.database.Cursor) = (r1v2 android.database.Cursor), (r1v7 android.database.Cursor) binds: [B:21:0x003b, B:14:0x0030] A[DONT_GENERATE, DONT_INLINE]] */
    private String displayName(Uri uri) {
        String string;
        Cursor cursorQuery = null;
        try {
            cursorQuery = getContentResolver().query(uri, new String[]{"_display_name"}, null, null, null);
            if (cursorQuery == null || !cursorQuery.moveToFirst() || (string = cursorQuery.getString(0)) == null || string.length() <= 0) {
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
                String lastPathSegment = uri.getLastPathSegment();
                return lastPathSegment == null ? "track" : lastPathSegment.substring(lastPathSegment.lastIndexOf(47) + 1);
            }
            if (cursorQuery != null) {
                cursorQuery.close();
            }
            return string;
        } catch (Exception e) {
            if (cursorQuery != null) {
                cursorQuery.close();
            }
        } catch (Throwable th) {
            if (cursorQuery != null) {
                cursorQuery.close();
            }
            throw th;
        }
    }

    private void scanFolder(final Uri uri) {
        Ui.toast(this, "Scanning folder...");
        new Thread(new Runnable() { // from class: com.riola.player.LibraryActivity.15
            @Override // java.lang.Runnable
            public void run() {
                ArrayList<Track> arrayList = new ArrayList();
                try {
                    LibraryActivity libraryActivity = LibraryActivity.this;
                    Uri uri2 = uri;
                    libraryActivity.collect(uri2, DocumentsContract.getTreeDocumentId(uri2), arrayList, 0);
                } catch (Exception e) {
                }
                Collections.sort(arrayList, new Comparator<Track>() { // from class: com.riola.player.LibraryActivity.15.1
                    @Override // java.util.Comparator
                    public int compare(Track track, Track track2) {
                        return track.title.compareToIgnoreCase(track2.title);
                    }
                });
                final int[] iArr = {0};
                for (Track track : arrayList) {
                    if (LibraryActivity.this.add(Uri.parse(track.uri), track.title, track.modifiedAt)) {
                        iArr[0] = iArr[0] + 1;
                    }
                }
                LibraryActivity.this.runOnUiThread(new Runnable() { // from class: com.riola.player.LibraryActivity.15.2
                    @Override // java.lang.Runnable
                    public void run() {
                        LibraryActivity.this.finishAdding(iArr[0]);
                    }
                });
            }
        }).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void collect(Uri uri, String str, List<Track> list, int i) {
        if (i > 6 || list.size() > 500) {
            return;
        }
        Cursor cursorQuery = null;
        try {
            int i2 = 2;
            int i3 = 3;
            cursorQuery = getContentResolver().query(DocumentsContract.buildChildDocumentsUriUsingTree(uri, str), new String[]{"document_id", "_display_name", "mime_type", "last_modified"}, null, null, null);
            if (cursorQuery != null) {
                while (cursorQuery.moveToNext()) {
                    String string = cursorQuery.getString(0);
                    String string2 = cursorQuery.getString(1);
                    String string3 = cursorQuery.getString(i2);
                    long j = cursorQuery.isNull(i3) ? 0L : cursorQuery.getLong(i3);
                    if ("vnd.android.document/directory".equals(string3)) {
                        collect(uri, string, list, i + 1);
                    } else if (isPlayable(string2, string3)) {
                        Track track = new Track(DocumentsContract.buildDocumentUriUsingTree(uri, string).toString(), string2, 0L);
                        track.modifiedAt = j;
                        list.add(track);
                    }
                    i2 = 2;
                    i3 = 3;
                }
            }
        } catch (Exception e) {
        } finally {
            if (0 != 0) {
                cursorQuery.close();
            }
        }
    }

    private boolean isPlayable(String str, String str2) {
        if (str2 != null && (str2.startsWith("audio/") || str2.startsWith("video/"))) {
            return true;
        }
        if (str == null) {
            return false;
        }
        String lowerCase = str.toLowerCase();
        String[] strArr = {".mp3", ".m4a", ".aac", ".wav", ".ogg", ".oga", ".opus", ".flac", ".mka", ".wma", ".aif", ".aiff", ".amr", ".mp4", ".mkv", ".avi", ".mov", ".webm", ".m4v", ".3gp", ".ts", ".flv", ".wmv", ".mpg", ".mpeg"};
        for (int i = 0; i < 25; i++) {
            if (lowerCase.endsWith(strArr[i])) {
                return true;
            }
        }
        return false;
    }

    private void readDurations() {
        new Thread(new Runnable() { // from class: com.riola.player.LibraryActivity.16
            @Override // java.lang.Runnable
            public void run() {
                boolean z = false;
                for (Track track : Store.LIB) {
                    if (track.durMs <= 0) {
                        MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
                        try {
                            mediaMetadataRetriever.setDataSource(LibraryActivity.this, track.toUri());
                            String strExtractMetadata = mediaMetadataRetriever.extractMetadata(9);
                            if (strExtractMetadata != null) {
                                track.durMs = Long.parseLong(strExtractMetadata);
                                z = true;
                            }
                            try {
                                mediaMetadataRetriever.release();
                            } catch (Exception e) {
                            }
                        } catch (Exception e2) {
                            mediaMetadataRetriever.release();
                        } catch (Throwable th) {
                            try {
                                mediaMetadataRetriever.release();
                            } catch (Exception e3) {
                            }
                            throw th;
                        }
                    }
                }
                if (z) {
                    Store.saveLib(LibraryActivity.this);
                    LibraryActivity.this.runOnUiThread(new Runnable() { // from class: com.riola.player.LibraryActivity.16.1
                        @Override // java.lang.Runnable
                        public void run() {
                            LibraryActivity.this.refresh();
                        }
                    });
                }
            }
        }).start();
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineState(Engine.St st) {
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineFinished(boolean z) {
        refresh();
    }
}
