package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;

/** All settings live here. */
public class Prefs {

    public static final String FILE = "riola.prefs";

    private final SharedPreferences sp;

    public Prefs(Context c) {
        sp = c.getApplicationContext().getSharedPreferences(FILE, Context.MODE_PRIVATE);
    }

    public boolean dark()          { return sp.getBoolean("dark", true); }
    public boolean keepScreenOn()  { return sp.getBoolean("keepOn", true); }
    public boolean wakeLock()      { return sp.getBoolean("wake", true); }
    public boolean pauseUnplug()   { return sp.getBoolean("unplug", true); }
    public boolean pauseOnFocus()  { return sp.getBoolean("focus", true); }
    public boolean haptics()       { return sp.getBoolean("haptics", true); }
    public int     fadeMs()        { return sp.getInt("fade", 150); }
    public int     volume()        { return sp.getInt("vol", 100); }
    public int     speedPct()      { return sp.getInt("speed", 100); }
    public int     countIn()       { return sp.getInt("countin", 0); }      // seconds
    public int     autoStopMin()   { return sp.getInt("autostop", 0); }     // 0 = off
    public float   speed()         { return speedPct() / 100f; }
    public boolean seeded()        { return sp.getBoolean("seeded2", false); }
    public int     accent()        { return sp.getInt("accent", Ui.ACCENTS[0]); }
    public void    accent(int v)   { sp.edit().putInt("accent", v).apply(); }
    public int     style()         { return sp.getInt("style", Ui.STYLE_MATERIAL); }
    public int     librarySort()   { return sp.getInt("libsort", 0); }
    public void    librarySort(int v) { sp.edit().putInt("libsort", v).apply(); }
    public void    style(int v)    { sp.edit().putInt("style", v).apply(); }
    public boolean notifNagged()   { return sp.getBoolean("notifnag", false); }
    public void    notifNagged(boolean v) { sp.edit().putBoolean("notifnag", v).apply(); }

    public void dark(boolean v)         { sp.edit().putBoolean("dark", v).apply(); }
    public void keepScreenOn(boolean v) { sp.edit().putBoolean("keepOn", v).apply(); }
    public void wakeLock(boolean v)     { sp.edit().putBoolean("wake", v).apply(); }
    public void pauseUnplug(boolean v)  { sp.edit().putBoolean("unplug", v).apply(); }
    public void pauseOnFocus(boolean v) { sp.edit().putBoolean("focus", v).apply(); }
    public void haptics(boolean v)      { sp.edit().putBoolean("haptics", v).apply(); }
    public void fadeMs(int v)           { sp.edit().putInt("fade", v).apply(); }
    public void volume(int v)           { sp.edit().putInt("vol", v).apply(); }
    public void speedPct(int v)         { sp.edit().putInt("speed", v).apply(); }
    public void countIn(int v)          { sp.edit().putInt("countin", v).apply(); }
    public void autoStopMin(int v)      { sp.edit().putInt("autostop", v).apply(); }
    public void seeded(boolean v)       { sp.edit().putBoolean("seeded2", v).apply(); }

    public void resetAll() {
        sp.edit().remove("keepOn").remove("wake").remove("unplug").remove("focus")
          .remove("haptics").remove("fade").remove("vol").remove("speed")
          .remove("countin").remove("autostop").remove("accent").remove("style").apply();
    }
}
