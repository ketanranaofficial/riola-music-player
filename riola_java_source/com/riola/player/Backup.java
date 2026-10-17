package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class Backup {
    private static final int MAX_BYTES = 4194304;
    private static String pending = "";

    private Backup() {
    }

    public static void exportAll(Activity activity, int i) {
        if (Store.PROGRAMS.isEmpty()) {
            Ui.toast(activity, "There are no programs to export");
        } else {
            pending = json(new ArrayList(Store.PROGRAMS), true);
            ask(activity, i, "riola-programs.json");
        }
    }

    public static void exportOne(Activity activity, Program program, int i) {
        if (program == null) {
            return;
        }
        ArrayList arrayList = new ArrayList();
        arrayList.add(program);
        pending = json(arrayList, false);
        ask(activity, i, "riola-" + safe(program.name) + ".json");
    }

    private static void ask(Activity activity, int i, String str) {
        try {
            activity.startActivityForResult(new Intent("android.intent.action.CREATE_DOCUMENT").addCategory("android.intent.category.OPENABLE").setType("application/json").putExtra("android.intent.extra.TITLE", str), i);
        } catch (Exception e) {
            Ui.toast(activity, "No file picker on this device");
        }
    }

    public static void pickToImport(Activity activity, int i) {
        try {
            activity.startActivityForResult(new Intent("android.intent.action.OPEN_DOCUMENT").addCategory("android.intent.category.OPENABLE").setType("*/*"), i);
        } catch (Exception e) {
            Ui.toast(activity, "No file picker on this device");
        }
    }

    public static void write(Activity activity, Uri uri) {
        String str = pending;
        pending = "";
        if (uri == null || str.length() == 0) {
            Ui.toast(activity, "Nothing to write");
            return;
        }
        OutputStream outputStream = null;
        try {
            try {
                try {
                    OutputStream outputStreamOpenOutputStream = activity.getContentResolver().openOutputStream(uri);
                    if (outputStreamOpenOutputStream == null) {
                        Ui.toast(activity, "Could not write that file");
                        if (outputStreamOpenOutputStream != null) {
                            try {
                                outputStreamOpenOutputStream.close();
                                return;
                            } catch (Exception e) {
                                return;
                            }
                        }
                        return;
                    }
                    outputStreamOpenOutputStream.write(str.getBytes("UTF-8"));
                    outputStreamOpenOutputStream.flush();
                    Ui.toast(activity, "Exported");
                    if (outputStreamOpenOutputStream != null) {
                        outputStreamOpenOutputStream.close();
                    }
                } catch (Exception e2) {
                }
            } catch (Exception e3) {
                Ui.toast(activity, "Could not write that file");
                if (0 != 0) {
                    outputStream.close();
                }
            }
        } catch (Throwable th) {
            if (0 != 0) {
                try {
                    outputStream.close();
                } catch (Exception e4) {
                }
            }
            throw th;
        }
    }

    private static String json(List<Program> list, boolean z) {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("riola", 1);
            jSONObject.put("saved", System.currentTimeMillis());
            JSONArray jSONArray = new JSONArray();
            for (int i = 0; i < list.size(); i++) {
                jSONArray.put(list.get(i).toJson());
            }
            jSONObject.put("programs", jSONArray);
            JSONArray jSONArray2 = new JSONArray();
            for (Track track : Store.LIB) {
                if (z || usedBy(list, track.uri)) {
                    JSONObject jSONObject2 = new JSONObject();
                    jSONObject2.put("u", track.uri);
                    jSONObject2.put("t", track.title);
                    jSONObject2.put("d", track.durMs);
                    jSONArray2.put(jSONObject2);
                }
            }
            jSONObject.put("lib", jSONArray2);
            return jSONObject.toString(2);
        } catch (Exception e) {
            return "";
        }
    }

    private static boolean usedBy(List<Program> list, String str) {
        for (int i = 0; i < list.size(); i++) {
            List<Step> list2 = list.get(i).steps;
            for (int i2 = 0; i2 < list2.size(); i2++) {
                if (str.equals(list2.get(i2).trackUri)) {
                    return true;
                }
            }
        }
        return false;
    }

    private static String safe(String str) {
        StringBuilder sb = new StringBuilder();
        String strTrim = str == null ? "" : str.trim();
        for (int i = 0; i < strTrim.length() && sb.length() < 40; i++) {
            char cCharAt = strTrim.charAt(i);
            if (Character.isLetterOrDigit(cCharAt)) {
                sb.append(cCharAt);
            } else if (cCharAt == ' ' || cCharAt == '-' || cCharAt == '_') {
                sb.append('-');
            }
        }
        return sb.length() == 0 ? "program" : sb.toString();
    }

    public static void read(Activity activity, Uri uri) throws Throwable {
        if (uri == null) {
            return;
        }
        InputStream inputStream = null;
        try {
            try {
                InputStream inputStreamOpenInputStream = activity.getContentResolver().openInputStream(uri);
                try {
                    if (inputStreamOpenInputStream == null) {
                        fail(activity, "Riola could not open that file.");
                        if (inputStreamOpenInputStream != null) {
                            try {
                                inputStreamOpenInputStream.close();
                                return;
                            } catch (Exception e) {
                                return;
                            }
                        }
                        return;
                    }
                    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                    byte[] bArr = new byte[8192];
                    boolean z = false;
                    int i = 0;
                    while (true) {
                        int i2 = inputStreamOpenInputStream.read(bArr);
                        if (i2 <= 0) {
                            String str = new String(byteArrayOutputStream.toByteArray(), "UTF-8");
                            if (inputStreamOpenInputStream != null) {
                                try {
                                    inputStreamOpenInputStream.close();
                                } catch (Exception e2) {
                                }
                            }
                            if (str.trim().length() == 0) {
                                fail(activity, "That file is empty.");
                                return;
                            }
                            try {
                                JSONObject jSONObject = new JSONObject(str);
                                JSONArray jSONArrayOptJSONArray = jSONObject.optJSONArray("programs");
                                if (jSONArrayOptJSONArray == null || jSONArrayOptJSONArray.length() == 0) {
                                    fail(activity, "That file is readable, but there are no Riola programs inside it.");
                                    return;
                                }
                                ArrayList arrayList = new ArrayList();
                                JSONArray jSONArrayOptJSONArray2 = jSONObject.optJSONArray("lib");
                                if (jSONArrayOptJSONArray2 != null) {
                                    for (int i3 = 0; i3 < jSONArrayOptJSONArray2.length(); i3++) {
                                        JSONObject jSONObjectOptJSONObject = jSONArrayOptJSONArray2.optJSONObject(i3);
                                        if (jSONObjectOptJSONObject != null) {
                                            String strOptString = jSONObjectOptJSONObject.optString("u", "");
                                            if (strOptString.length() != 0 && Store.byUri(strOptString) == null) {
                                                arrayList.add(new Track(strOptString, jSONObjectOptJSONObject.optString("t", "track"), jSONObjectOptJSONObject.optLong("d", 0L)));
                                            }
                                        }
                                    }
                                }
                                ArrayList arrayList2 = new ArrayList();
                                int i4 = 0;
                                int i5 = 0;
                                for (int i6 = 0; i6 < jSONArrayOptJSONArray.length(); i6++) {
                                    JSONObject jSONObjectOptJSONObject2 = jSONArrayOptJSONArray.optJSONObject(i6);
                                    if (jSONObjectOptJSONObject2 == null) {
                                        i5++;
                                    } else {
                                        try {
                                            Program programFromJson = Program.fromJson(jSONObjectOptJSONObject2);
                                            if (programFromJson.name == null || programFromJson.name.trim().length() == 0) {
                                                programFromJson.name = "Imported program";
                                            }
                                            if (programFromJson.steps.isEmpty() && jSONObjectOptJSONObject2.optJSONArray("st") == null) {
                                                i5++;
                                            } else {
                                                if (Store.program(programFromJson.id) != null) {
                                                    programFromJson.id = Program.blank(programFromJson.name).id;
                                                    programFromJson.name += " (imported)";
                                                }
                                                programFromJson.updated = System.currentTimeMillis();
                                                Store.PROGRAMS.add(programFromJson);
                                                arrayList2.add(programFromJson);
                                                i4++;
                                            }
                                        } catch (Exception e3) {
                                            i5++;
                                        }
                                    }
                                }
                                if (i4 == 0) {
                                    fail(activity, "Nothing in that file could be read as a program.");
                                    return;
                                }
                                int size = arrayList.size();
                                Store.LIB.addAll(arrayList);
                                Store.saveLib(activity);
                                Store.savePrograms(activity);
                                for (int i7 = 0; i7 < arrayList2.size(); i7++) {
                                    if (((Program) arrayList2.get(i7)).hasMissing()) {
                                        z = true;
                                        break;
                                    }
                                }
                                StringBuilder sb = new StringBuilder();
                                sb.append("Added ").append(i4).append(i4 == 1 ? " program" : " programs");
                                if (size > 0) {
                                    sb.append(" and ").append(size).append(size == 1 ? " track" : " tracks");
                                }
                                sb.append(".");
                                if (i5 > 0) {
                                    sb.append("\n\n").append(i5).append(i5 == 1 ? " entry was" : " entries were").append(" skipped because they could not be read.");
                                }
                                if (z) {
                                    sb.append("\n\nSome steps point at files this phone cannot open, so they are marked missing. Add those tracks again and the steps will reconnect on their own.");
                                }
                                Ui.dialog(activity).setTitle("Imported").setMessage(sb.toString()).setPositiveButton("Done", (DialogInterface.OnClickListener) null).show();
                                return;
                            } catch (Exception e4) {
                                fail(activity, "That is not a Riola export. Pick the .json file that Riola wrote.");
                                return;
                            }
                        }
                        i += i2;
                        if (i > MAX_BYTES) {
                            fail(activity, "That file is far too large to be a Riola export.");
                            if (inputStreamOpenInputStream != null) {
                                try {
                                    inputStreamOpenInputStream.close();
                                    return;
                                } catch (Exception e5) {
                                    return;
                                }
                            }
                            return;
                        }
                        byteArrayOutputStream.write(bArr, 0, i2);
                    }
                } catch (Exception e6) {
                    inputStream = inputStreamOpenInputStream;
                    fail(activity, "Riola could not read that file.");
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (Exception e7) {
                        }
                    }
                } catch (Throwable th) {
                    th = th;
                    inputStream = inputStreamOpenInputStream;
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (Exception e8) {
                        }
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (Exception e9) {
        }
    }

    private static void fail(Activity activity, String str) {
        Ui.dialog(activity).setTitle("Could not import").setMessage(str).setPositiveButton("OK", (DialogInterface.OnClickListener) null).show();
    }
}
