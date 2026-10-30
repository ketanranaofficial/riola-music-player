package com.riola.player;

import android.net.Uri;

/** One audio file in the library. */
public class Track {
    public String uri;
    public String title;
    public long durMs;
    /** Which audio stream to play, for files that carry more than one. -1 = whatever the file defaults to. */
    public int audioTrack = -1;
    /** When it was added to the library, and the file's own date if we could read it. */
    public long addedAt;
    public long modifiedAt;

    public Track(String uri, String title, long durMs) {
        this.uri = uri;
        this.title = title;
        this.durMs = durMs;
    }

    /** Video files are welcome; Riola just never asks for the picture. */
    public boolean isVideo() {
        String t = (title == null ? "" : title).toLowerCase();
        for (int i = 0; i < VIDEO.length; i++) if (t.endsWith(VIDEO[i])) return true;
        return false;
    }

    private static final String[] VIDEO = { ".mp4", ".mkv", ".avi", ".mov", ".webm", ".m4v",
            ".3gp", ".ts", ".flv", ".wmv", ".mpg", ".mpeg" };

    public Uri toUri() { return Uri.parse(uri); }

    /**
     * Identity that does not depend on how the file was picked. The same file
     * has one uri when chosen with Add files and another when found by
     * scanning a folder, but both carry the same provider and document id.
     */
    public String key() {
        try {
            Uri u = toUri();
            String id = android.provider.DocumentsContract.getDocumentId(u);
            if (id != null && id.length() > 0) return u.getAuthority() + "|" + id;
        } catch (Exception e) { /* not a document uri; fall back to the whole thing */ }
        return uri;
    }

    /**
     * The name without its file extension. Only a known audio extension is
     * stripped: guessing from "the last dot" quietly ate names like
     * "Soundarya_Lahari_(getmp3.pro)".
     */
    public String shortTitle() {
        String t = title == null ? "" : title;
        String low = t.toLowerCase();
        for (int i = 0; i < EXTS.length; i++) {
            if (low.endsWith(EXTS[i]) && t.length() > EXTS[i].length()) {
                return t.substring(0, t.length() - EXTS[i].length());
            }
        }
        return t;
    }

    private static final String[] EXTS = { ".mp3", ".m4a", ".aac", ".wav", ".ogg", ".oga",
            ".opus", ".flac", ".mp4", ".mka", ".wma", ".aif", ".aiff", ".mid", ".amr", ".3gp",
            ".mkv", ".avi", ".mov", ".webm", ".m4v", ".ts", ".flv", ".wmv", ".mpg", ".mpeg" };
}
