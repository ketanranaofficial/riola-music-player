package com.riola.player;

import android.net.Uri;
import android.provider.DocumentsContract;

/* JADX INFO: loaded from: classes.dex */
public class Track {
    public long addedAt;
    public int audioTrack = -1;
    public long durMs;
    public long modifiedAt;
    public String title;
    public String uri;
    private static final String[] VIDEO = {".mp4", ".mkv", ".avi", ".mov", ".webm", ".m4v", ".3gp", ".ts", ".flv", ".wmv", ".mpg", ".mpeg"};
    private static final String[] EXTS = {".mp3", ".m4a", ".aac", ".wav", ".ogg", ".oga", ".opus", ".flac", ".mp4", ".mka", ".wma", ".aif", ".aiff", ".mid", ".amr", ".3gp", ".mkv", ".avi", ".mov", ".webm", ".m4v", ".ts", ".flv", ".wmv", ".mpg", ".mpeg"};

    public Track(String str, String str2, long j) {
        this.uri = str;
        this.title = str2;
        this.durMs = j;
    }

    public boolean isVideo() {
        String str = this.title;
        if (str == null) {
            str = "";
        }
        String lowerCase = str.toLowerCase();
        int i = 0;
        while (true) {
            String[] strArr = VIDEO;
            if (i >= strArr.length) {
                return false;
            }
            if (lowerCase.endsWith(strArr[i])) {
                return true;
            }
            i++;
        }
    }

    public Uri toUri() {
        return Uri.parse(this.uri);
    }

    public String key() {
        try {
            Uri uri = toUri();
            String documentId = DocumentsContract.getDocumentId(uri);
            if (documentId != null && documentId.length() > 0) {
                return uri.getAuthority() + "|" + documentId;
            }
        } catch (Exception e) {
        }
        return this.uri;
    }

    public String shortTitle() {
        String str = this.title;
        if (str == null) {
            str = "";
        }
        String lowerCase = str.toLowerCase();
        int i = 0;
        while (true) {
            String[] strArr = EXTS;
            if (i < strArr.length) {
                if (!lowerCase.endsWith(strArr[i]) || str.length() <= strArr[i].length()) {
                    i++;
                } else {
                    return str.substring(0, str.length() - strArr[i].length());
                }
            } else {
                return str;
            }
        }
    }
}
