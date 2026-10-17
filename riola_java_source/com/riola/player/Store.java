package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class Store {
    public static final CopyOnWriteArrayList<Track> LIB = new CopyOnWriteArrayList<>();
    public static final CopyOnWriteArrayList<Program> PROGRAMS = new CopyOnWriteArrayList<>();
    public static final Set<String> MISSING = Collections.synchronizedSet(new HashSet());
    private static boolean loaded = false;
    public static final String[] SORTS = {"Manual order", "Name A to Z", "Name Z to A", "Recently added", "Oldest added", "Newest file", "Oldest file", "Longest first", "Shortest first"};

    private Store() {
    }

    private static SharedPreferences sp(Context context) {
        return context.getApplicationContext().getSharedPreferences(Prefs.FILE, 0);
    }

    public static synchronized void load(Context context) {
        if (loaded) {
            return;
        }
        loaded = true;
        LIB.clear();
        PROGRAMS.clear();
        try {
            JSONArray jSONArray = new JSONArray(sp(context).getString("lib", "[]"));
            for (int i = 0; i < jSONArray.length(); i++) {
                JSONObject jSONObject = jSONArray.getJSONObject(i);
                Track track = new Track(jSONObject.getString("u"), jSONObject.optString("t", "track"), jSONObject.optLong("d", 0L));
                track.audioTrack = jSONObject.optInt("a", -1);
                track.addedAt = jSONObject.optLong("ad", 0L);
                track.modifiedAt = jSONObject.optLong("md", 0L);
                LIB.add(track);
            }
        } catch (Exception e) {
            LIB.clear();
        }
        dedupe();
        try {
            JSONArray jSONArray2 = new JSONArray(sp(context).getString("programs", "[]"));
            for (int i2 = 0; i2 < jSONArray2.length(); i2++) {
                JSONObject jSONObjectOptJSONObject = jSONArray2.optJSONObject(i2);
                if (jSONObjectOptJSONObject != null) {
                    PROGRAMS.add(Program.fromJson(jSONObjectOptJSONObject));
                }
            }
        } catch (Exception e2) {
            PROGRAMS.clear();
        }
        sortPrograms();
    }

    public static void dedupe() {
        HashSet hashSet = new HashSet();
        ArrayList arrayList = new ArrayList();
        for (Track track : LIB) {
            if (hashSet.add(track.key())) {
                arrayList.add(track);
            }
        }
        int size = arrayList.size();
        CopyOnWriteArrayList<Track> copyOnWriteArrayList = LIB;
        if (size == copyOnWriteArrayList.size()) {
            return;
        }
        copyOnWriteArrayList.clear();
        copyOnWriteArrayList.addAll(arrayList);
    }

    public static Track byKey(String str) {
        for (Track track : LIB) {
            if (track.key().equals(str)) {
                return track;
            }
        }
        return null;
    }

    public static Track byUri(String str) {
        if (str == null || str.length() == 0) {
            return null;
        }
        for (Track track : LIB) {
            if (str.equals(track.uri)) {
                return track;
            }
        }
        return null;
    }

    public static int indexOf(String str) {
        int i = 0;
        while (true) {
            CopyOnWriteArrayList<Track> copyOnWriteArrayList = LIB;
            if (i >= copyOnWriteArrayList.size()) {
                return -1;
            }
            if (copyOnWriteArrayList.get(i).uri.equals(str)) {
                return i;
            }
            i++;
        }
    }

    public static boolean readable(Context context, String str) {
        Track trackByUri = byUri(str);
        if (trackByUri == null) {
            return false;
        }
        InputStream inputStream = null;
        try {
            try {
                InputStream inputStreamOpenInputStream = context.getContentResolver().openInputStream(trackByUri.toUri());
                boolean z = inputStreamOpenInputStream != null;
                if (z) {
                    MISSING.remove(str);
                } else {
                    MISSING.add(str);
                }
                if (inputStreamOpenInputStream != null) {
                    try {
                        inputStreamOpenInputStream.close();
                    } catch (Exception e) {
                    }
                }
                return z;
            } catch (Throwable th) {
                if (0 != 0) {
                    try {
                        inputStream.close();
                    } catch (Exception e2) {
                    }
                }
                throw th;
            }
        } catch (Exception e3) {
            MISSING.add(str);
            if (0 != 0) {
                try {
                    inputStream.close();
                } catch (Exception e4) {
                }
            }
            return false;
        }
    }

    public static void saveLib(Context context) {
        JSONArray jSONArray = new JSONArray();
        for (Track track : LIB) {
            try {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("u", track.uri);
                jSONObject.put("t", track.title);
                jSONObject.put("d", track.durMs);
                jSONObject.put("a", track.audioTrack);
                jSONObject.put("ad", track.addedAt);
                jSONObject.put("md", track.modifiedAt);
                jSONArray.put(jSONObject);
            } catch (Exception e) {
            }
        }
        sp(context).edit().putString("lib", jSONArray.toString()).apply();
    }

    public static void sortPrograms() {
        CopyOnWriteArrayList<Program> copyOnWriteArrayList = PROGRAMS;
        ArrayList arrayList = new ArrayList(copyOnWriteArrayList);
        Collections.sort(arrayList, new Comparator<Program>() { // from class: com.riola.player.Store.1
            @Override // java.util.Comparator
            public int compare(Program program, Program program2) {
                long jMax = Math.max(program.updated, program.lastRun);
                long jMax2 = Math.max(program2.updated, program2.lastRun);
                if (jMax == jMax2) {
                    return 0;
                }
                return jMax > jMax2 ? -1 : 1;
            }
        });
        copyOnWriteArrayList.clear();
        copyOnWriteArrayList.addAll(arrayList);
    }

    public static Program program(String str) {
        if (str == null) {
            return null;
        }
        for (Program program : PROGRAMS) {
            if (program.id.equals(str)) {
                return program;
            }
        }
        return null;
    }

    public static void put(Context context, Program program) {
        program.updated = System.currentTimeMillis();
        if (program(program.id) == null) {
            PROGRAMS.add(program);
        }
        savePrograms(context);
    }

    public static void delete(Context context, Program program) {
        PROGRAMS.remove(program);
        savePrograms(context);
    }

    public static void savePrograms(Context context) {
        sortPrograms();
        JSONArray jSONArray = new JSONArray();
        Iterator<Program> it = PROGRAMS.iterator();
        while (it.hasNext()) {
            try {
                jSONArray.put(it.next().toJson());
            } catch (Exception e) {
            }
        }
        sp(context).edit().putString("programs", jSONArray.toString()).apply();
    }

    public static List<Track> view(final int i, String str) {
        String lowerCase = str == null ? "" : str.trim().toLowerCase();
        ArrayList arrayList = new ArrayList();
        for (Track track : LIB) {
            if (lowerCase.length() == 0 || track.shortTitle().toLowerCase().contains(lowerCase)) {
                arrayList.add(track);
            }
        }
        if (i <= 0) {
            return arrayList;
        }
        Collections.sort(arrayList, new Comparator<Track>() { // from class: com.riola.player.Store.2
            @Override // java.util.Comparator
            public int compare(Track track2, Track track3) {
                switch (i) {
                    case 1:
                        return track2.shortTitle().compareToIgnoreCase(track3.shortTitle());
                    case 2:
                        return track3.shortTitle().compareToIgnoreCase(track2.shortTitle());
                    case 3:
                        return Store.cmp(track3.addedAt, track2.addedAt);
                    case 4:
                        return Store.cmp(track2.addedAt, track3.addedAt);
                    case 5:
                        return Store.cmp(track3.modifiedAt, track2.modifiedAt);
                    case 6:
                        return Store.cmp(track2.modifiedAt, track3.modifiedAt);
                    case 7:
                        return Store.cmp(track3.durMs, track2.durMs);
                    default:
                        return Store.cmp(track2.durMs, track3.durMs);
                }
            }
        });
        return arrayList;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static int cmp(long j, long j2) {
        if (j == j2) {
            return 0;
        }
        return j < j2 ? -1 : 1;
    }

    public static Program sample() {
        Program programBlank = Program.blank("My first program");
        CopyOnWriteArrayList<Track> copyOnWriteArrayList = LIB;
        if (copyOnWriteArrayList.size() > 0) {
            Track track = copyOnWriteArrayList.get(0);
            programBlank.steps.add(Step.play(track));
            programBlank.steps.add(Step.silence(60000L));
            Step stepSection = Step.section(track, 30000L, track.durMs <= 90000 ? Math.max(20000L, track.durMs / 2) : 90000L);
            stepSection.times = 4;
            stepSection.gapMs = 3000L;
            programBlank.steps.add(stepSection);
        }
        return programBlank;
    }
}
