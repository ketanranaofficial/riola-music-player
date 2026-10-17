package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;

/* JADX INFO: loaded from: classes.dex */
public class Prefs {
    public static final String FILE = "riola.prefs";
    private final SharedPreferences sp;

    public Prefs(Context context) {
        this.sp = context.getApplicationContext().getSharedPreferences(FILE, 0);
    }

    public boolean dark() {
        return this.sp.getBoolean("dark", true);
    }

    public boolean keepScreenOn() {
        return this.sp.getBoolean("keepOn", true);
    }

    public boolean wakeLock() {
        return this.sp.getBoolean("wake", true);
    }

    public boolean pauseUnplug() {
        return this.sp.getBoolean("unplug", true);
    }

    public boolean pauseOnFocus() {
        return this.sp.getBoolean("focus", true);
    }

    public boolean haptics() {
        return this.sp.getBoolean("haptics", true);
    }

    public int fadeMs() {
        return this.sp.getInt("fade", 150);
    }

    public int volume() {
        return this.sp.getInt("vol", 100);
    }

    public int speedPct() {
        return this.sp.getInt("speed", 100);
    }

    public int countIn() {
        return this.sp.getInt("countin", 0);
    }

    public int autoStopMin() {
        return this.sp.getInt("autostop", 0);
    }

    public float speed() {
        return speedPct() / 100.0f;
    }

    public boolean seeded() {
        return this.sp.getBoolean("seeded2", false);
    }

    public int accent() {
        return this.sp.getInt("accent", Ui.ACCENTS[0]);
    }

    public void accent(int i) {
        this.sp.edit().putInt("accent", i).apply();
    }

    public int style() {
        return this.sp.getInt("style", 0);
    }

    public int librarySort() {
        return this.sp.getInt("libsort", 0);
    }

    public void librarySort(int i) {
        this.sp.edit().putInt("libsort", i).apply();
    }

    public void style(int i) {
        this.sp.edit().putInt("style", i).apply();
    }

    public boolean notifNagged() {
        return this.sp.getBoolean("notifnag", false);
    }

    public void notifNagged(boolean z) {
        this.sp.edit().putBoolean("notifnag", z).apply();
    }

    public void dark(boolean z) {
        this.sp.edit().putBoolean("dark", z).apply();
    }

    public void keepScreenOn(boolean z) {
        this.sp.edit().putBoolean("keepOn", z).apply();
    }

    public void wakeLock(boolean z) {
        this.sp.edit().putBoolean("wake", z).apply();
    }

    public void pauseUnplug(boolean z) {
        this.sp.edit().putBoolean("unplug", z).apply();
    }

    public void pauseOnFocus(boolean z) {
        this.sp.edit().putBoolean("focus", z).apply();
    }

    public void haptics(boolean z) {
        this.sp.edit().putBoolean("haptics", z).apply();
    }

    public void fadeMs(int i) {
        this.sp.edit().putInt("fade", i).apply();
    }

    public void volume(int i) {
        this.sp.edit().putInt("vol", i).apply();
    }

    public void speedPct(int i) {
        this.sp.edit().putInt("speed", i).apply();
    }

    public void countIn(int i) {
        this.sp.edit().putInt("countin", i).apply();
    }

    public void autoStopMin(int i) {
        this.sp.edit().putInt("autostop", i).apply();
    }

    public void seeded(boolean z) {
        this.sp.edit().putBoolean("seeded2", z).apply();
    }

    public void resetAll() {
        this.sp.edit().remove("keepOn").remove("wake").remove("unplug").remove("focus").remove("haptics").remove("fade").remove("vol").remove("speed").remove("countin").remove("autostop").remove("accent").remove("style").apply();
    }
}
