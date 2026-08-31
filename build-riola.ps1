<#
  ============================================================================
   Riola - Programmable Music Player
   Single-file generator + builder. No Gradle, no AndroidX, no dependencies.

   What it does
     1. Writes every source file (AndroidManifest.xml, res/, pure-Java sources)
        into .\riola\
     2. Builds a signed, zipaligned debug APK with the Android SDK
        command-line tools (aapt2 / javac / d8 / zipalign / apksigner).

   Usage
     .\build-riola.ps1                 # write sources + build APK
     .\build-riola.ps1 -SourcesOnly    # only (re)write the sources
     .\build-riola.ps1 -Install        # build, then adb install -r
     .\build-riola.ps1 -Clean          # wipe generated output first

   Requirements
     - Android SDK with platforms\android-34 and build-tools (33+; 34.0.0 used)
     - JDK 17 (or 11) on PATH
     - Debug keystore at %USERPROFILE%\.android\debug.keystore  (auto-created)
  ============================================================================
#>
[CmdletBinding()]
param(
    [string] $OutDir      = (Join-Path $PSScriptRoot 'riola'),
    [string] $ApkName     = 'riola.apk',
    [switch] $SourcesOnly,
    [switch] $Install,
    [switch] $Clean
)

$ErrorActionPreference = 'Stop'
$PKG      = 'com.riola.player'
$PKG_PATH = 'com\riola\player'

function Say  ([string]$m) { Write-Host $m -ForegroundColor Cyan }
function Ok   ([string]$m) { Write-Host $m -ForegroundColor Green }
function Warn ([string]$m) { Write-Host $m -ForegroundColor Yellow }
function Die  ([string]$m) { Write-Host $m -ForegroundColor Red; exit 1 }

function Assert-Exit([string]$what) {
    if ($LASTEXITCODE -ne 0) { Die ("FAILED: $what (exit $LASTEXITCODE)") }
    Ok  ("  ok: $what")
}

# ---------------------------------------------------------------------------
# 0. Locate the SDK / tools
# ---------------------------------------------------------------------------
Say "`n=== Riola build ==============================================="

if (-not $env:ANDROID_HOME -and $env:ANDROID_SDK_ROOT) { $env:ANDROID_HOME = $env:ANDROID_SDK_ROOT }
if (-not $env:ANDROID_HOME) { $env:ANDROID_HOME = Join-Path $env:LOCALAPPDATA 'Android\Sdk' }
if (-not (Test-Path $env:ANDROID_HOME)) { Die "Android SDK not found. Set ANDROID_HOME." }

$AndroidJar = Join-Path $env:ANDROID_HOME 'platforms\android-34\android.jar'
if (-not (Test-Path $AndroidJar)) { Die "Missing $AndroidJar  (install platform android-34)" }

$btRoot = Join-Path $env:ANDROID_HOME 'build-tools'
$bt = Get-ChildItem -Path $btRoot -Directory -ErrorAction SilentlyContinue |
      Sort-Object { [version]($_.Name -replace '[^0-9\.].*$','0') } | Select-Object -Last 1
if (-not $bt) { Die "No build-tools found under $btRoot" }
$btPath = $bt.FullName
if ($env:PATH -notlike "*$btPath*") { $env:PATH = "$btPath;$env:PATH" }

$Keystore = Join-Path $env:USERPROFILE '.android\debug.keystore'
if (-not (Test-Path $Keystore)) {
    Warn "No debug keystore - creating one..."
    New-Item -ItemType Directory -Force -Path (Split-Path $Keystore -Parent) | Out-Null
    keytool -genkeypair -v -keystore $Keystore -storepass android -keypass android `
            -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10950 `
            -dname "CN=Android Debug,O=Android,C=US" | Out-Null
    Assert-Exit 'keytool (create debug keystore)'
}

Write-Host ("  SDK          : " + $env:ANDROID_HOME)
Write-Host ("  build-tools  : " + $bt.Name)
Write-Host ("  platform jar : android-34")
Write-Host ("  out dir      : " + $OutDir)

# ---------------------------------------------------------------------------
# 1. Prepare output tree
# ---------------------------------------------------------------------------
if ($Clean -and (Test-Path $OutDir)) { Say "`n[clean] removing $OutDir"; Remove-Item -Recurse -Force $OutDir }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

function Write-Src([string]$Rel, [string]$Body) {
    $full = Join-Path $OutDir $Rel
    $dir  = Split-Path $full -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    # ASCII on purpose: every generated source is plain 7-bit ASCII.
    $Body | Out-File -LiteralPath $full -Encoding ASCII -Force
    Write-Host ("  + " + $Rel)
}

Say "`n[1/3] writing sources"

# ---------------------------------------------------------------------------
# AndroidManifest.xml
# ---------------------------------------------------------------------------
Write-Src 'AndroidManifest.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.riola.player"
    android:versionCode="3"
    android:versionName="3.0">

    <uses-sdk android:minSdkVersion="26" android:targetSdkVersion="34" />

    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <application
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:theme="@android:style/Theme.Material.NoActionBar"
        android:allowBackup="true"
        android:hardwareAccelerated="true">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTask"
            android:configChanges="orientation|screenSize|keyboardHidden|screenLayout|smallestScreenSize|uiMode"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <service
            android:name=".PlayerService"
            android:exported="false"
            android:foregroundServiceType="mediaPlayback" />
    </application>
</manifest>
'@

# ---------------------------------------------------------------------------
# Resources (app name, launcher icon, notification icons)
# ---------------------------------------------------------------------------
Write-Src 'res\values\strings.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Riola</string>
</resources>
'@

Write-Src 'res\mipmap-anydpi-v26\ic_launcher.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_bg" />
    <foreground android:drawable="@drawable/ic_launcher_fg" />
    <monochrome android:drawable="@drawable/ic_launcher_mono" />
</adaptive-icon>
'@

Write-Src 'res\mipmap-anydpi-v26\ic_launcher_round.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_bg" />
    <foreground android:drawable="@drawable/ic_launcher_fg" />
    <monochrome android:drawable="@drawable/ic_launcher_mono" />
</adaptive-icon>
'@

Write-Src 'res\drawable\ic_launcher_bg.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp" android:height="108dp"
    android:viewportWidth="108" android:viewportHeight="108">
    <path android:fillColor="#0E1116" android:pathData="M0,0h108v108h-108z" />
    <path android:fillColor="#17202B" android:pathData="M54,10 A44,44 0 1,0 54.1,10 z" />
    <path android:fillColor="#1E2A38" android:pathData="M54,22 A32,32 0 1,0 54.1,22 z" />
</vector>
'@

Write-Src 'res\drawable\ic_launcher_fg.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp" android:height="108dp"
    android:viewportWidth="108" android:viewportHeight="108">
    <path android:fillColor="#4CC2FF" android:pathData="M57,28h7v44h-7z" />
    <path android:fillColor="#4CC2FF" android:pathData="M64,28c12,2 21,9 23,20l0,10c-4,-13 -11,-20 -23,-22z" />
    <path android:fillColor="#7C6CFF" android:pathData="M47,60 A15,13 0 1,0 47.1,60 z" />
    <path android:fillColor="#4CC2FF" android:pathData="M24,50h5v20h-5z" />
    <path android:fillColor="#4CC2FF" android:pathData="M33,44h5v32h-5z" />
</vector>
'@

Write-Src 'res\drawable\ic_launcher_mono.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp" android:height="108dp"
    android:viewportWidth="108" android:viewportHeight="108">
    <path android:fillColor="#FFFFFFFF" android:pathData="M57,28h7v44h-7z" />
    <path android:fillColor="#FFFFFFFF" android:pathData="M64,28c12,2 21,9 23,20l0,10c-4,-13 -11,-20 -23,-22z" />
    <path android:fillColor="#FFFFFFFF" android:pathData="M47,60 A15,13 0 1,0 47.1,60 z" />
</vector>
'@

Write-Src 'res\drawable\ic_note.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24" android:tint="#FFFFFFFF">
    <path android:fillColor="#FFFFFFFF" android:pathData="M12,3h2.5v11h-2.5z" />
    <path android:fillColor="#FFFFFFFF" android:pathData="M14.5,3c4,0.7 6.5,3 7,6.5l0,3c-1.3,-4 -3.5,-6 -7,-6.7z" />
    <path android:fillColor="#FFFFFFFF" android:pathData="M8.5,13.5 A4.5,4 0 1,0 8.6,13.5 z" />
</vector>
'@

Write-Src 'res\drawable\ic_play.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M7,4l13,8l-13,8z" />
</vector>
'@

Write-Src 'res\drawable\ic_pause.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M6,4h4v16h-4zM14,4h4v16h-4z" />
</vector>
'@

Write-Src 'res\drawable\ic_stop.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M5,5h14v14h-14z" />
</vector>
'@

Write-Src 'res\drawable\ic_next.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M5,4l11,8l-11,8zM17,4h3v16h-3z" />
</vector>
'@

Write-Src 'res\drawable\ic_prev.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp" android:height="24dp"
    android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M19,4l-11,8l11,8zM4,4h3v16h-3z" />
</vector>
'@

# ---------------------------------------------------------------------------
# Java: small utilities and model
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Fmt.java" @'
package com.riola.player;

/** Tiny formatting helpers (ASCII only). */
public final class Fmt {

    private Fmt() { }

    /** 0:07 / 4:31 / 1:02:44 */
    public static String ms(long v) {
        if (v < 0) v = 0;
        long t = v / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return h + ":" + two(m) + ":" + two(s);
        return m + ":" + two(s);
    }

    /** 45s / 3m 20s / 1h 05m */
    public static String human(long v) {
        if (v < 0) return "?";
        long t = (v + 500L) / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return h + "h " + two(m) + "m";
        if (m > 0) return m + "m " + two(s) + "s";
        return s + "s";
    }

    public static String two(long v) { return v < 10 ? "0" + v : Long.toString(v); }

    /** 1.25 -> "1.25x" without locale surprises. */
    public static String speed(float v) {
        int hundredths = Math.round(v * 100f);
        return (hundredths / 100) + "." + two(hundredths % 100) + "x";
    }
}
'@

Write-Src "$PKG_PATH\Track.java" @'
package com.riola.player;

import android.net.Uri;

/** One audio file in the library. */
public class Track {
    public String uri;
    public String title;
    public long durMs;

    public Track(String uri, String title, long durMs) {
        this.uri = uri;
        this.title = title;
        this.durMs = durMs;
    }

    public Uri toUri() { return Uri.parse(uri); }

    public String shortTitle() {
        String t = title == null ? "" : title;
        int dot = t.lastIndexOf('.');
        if (dot > 0 && t.length() - dot <= 6) t = t.substring(0, dot);
        return t;
    }
}
'@

Write-Src "$PKG_PATH\Cmd.java" @'
package com.riola.player;

import java.util.List;

/** One step of a program. */
public class Cmd {

    public static final int PLAY     = 0;  // whole track, N times or for a duration
    public static final int PAUSE    = 1;  // silence
    public static final int SECTION  = 2;  // a-b region, N times or for a duration
    public static final int VOLUME   = 3;
    public static final int SPEED    = 4;
    public static final int FADE     = 5;

    public int  type;
    public int  track = -1;
    public int  times = 1;      // -1 = until the time budget runs out
    public long a = 0;          // section start (ms)
    public long b = -1;         // section end (ms), -1 = end of track
    public long durMs = 0;      // time budget / pause length
    public int  value;          // VOLUME 0-100, SPEED percent, FADE ms
    public int  line;           // source line number

    public Cmd copy() {
        Cmd c = new Cmd();
        c.type = type; c.track = track; c.times = times; c.a = a; c.b = b;
        c.durMs = durMs; c.value = value; c.line = line;
        return c;
    }

    public String trackTitle() {
        List<Track> lib = Store.LIB;
        if (track < 0 || track >= lib.size()) return "track " + track + " (missing)";
        return lib.get(track).shortTitle();
    }

    /** Short human label used in the step list, notification and log. */
    public String label() {
        switch (type) {
            case PAUSE:
                return "Silence for " + Fmt.human(durMs);
            case VOLUME:
                return "Set volume to " + value + "%";
            case SPEED:
                return "Set speed to " + Fmt.speed(value / 100f);
            case FADE:
                return "Set edge fade to " + value + " ms";
            case SECTION:
                return "[" + track + "] " + trackTitle() + "  " + Fmt.ms(a) + "-"
                        + (b < 0 ? "end" : Fmt.ms(b)) + "  " + repeatText();
            default:
                return "[" + track + "] " + trackTitle() + "  full track  " + repeatText();
        }
    }

    private String repeatText() {
        if (durMs > 0) return "looped for " + Fmt.human(durMs);
        if (times == 1) return "once";
        return times + "x";
    }

    /** Rough length of this step, for the "program lasts about N" estimate. */
    public long estMs() {
        if (type == PAUSE) return durMs;
        if (type == VOLUME || type == SPEED || type == FADE) return 0;
        if (durMs > 0) return durMs;
        long span;
        if (type == SECTION) {
            long end = b < 0 ? trackDur() : b;
            span = Math.max(0, end - a);
        } else {
            span = trackDur();
        }
        return span * Math.max(1, times);
    }

    private long trackDur() {
        List<Track> lib = Store.LIB;
        if (track < 0 || track >= lib.size()) return 0;
        return lib.get(track).durMs;
    }
}
'@

Write-Src "$PKG_PATH\Prefs.java" @'
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
    public boolean autoSave()      { return sp.getBoolean("autosave", true); }
    public boolean showLog()       { return sp.getBoolean("showlog", true); }
    public int     fadeMs()        { return sp.getInt("fade", 150); }
    public int     volume()        { return sp.getInt("vol", 100); }
    public int     speedPct()      { return sp.getInt("speed", 100); }
    public boolean seeded()        { return sp.getBoolean("seeded", false); }
    public void    seeded(boolean v) { sp.edit().putBoolean("seeded", v).apply(); }
    public float   speed()         { return speedPct() / 100f; }

    public void dark(boolean v)         { sp.edit().putBoolean("dark", v).apply(); }
    public void keepScreenOn(boolean v) { sp.edit().putBoolean("keepOn", v).apply(); }
    public void wakeLock(boolean v)     { sp.edit().putBoolean("wake", v).apply(); }
    public void pauseUnplug(boolean v)  { sp.edit().putBoolean("unplug", v).apply(); }
    public void pauseOnFocus(boolean v) { sp.edit().putBoolean("focus", v).apply(); }
    public void autoSave(boolean v)     { sp.edit().putBoolean("autosave", v).apply(); }
    public void showLog(boolean v)      { sp.edit().putBoolean("showlog", v).apply(); }
    public void fadeMs(int v)           { sp.edit().putInt("fade", v).apply(); }
    public void volume(int v)           { sp.edit().putInt("vol", v).apply(); }
    public void speedPct(int v)         { sp.edit().putInt("speed", v).apply(); }

    public void resetAll() {
        sp.edit().remove("keepOn").remove("wake").remove("unplug").remove("focus")
          .remove("autosave").remove("showlog")
          .remove("fade").remove("vol").remove("speed").apply();
    }
}
'@

Write-Src "$PKG_PATH\Store.java" @'
package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/** Persistent state: track library, current script, saved programs. */
public final class Store {

    /** Shared by the UI and the playback engine (same process). */
    public static final CopyOnWriteArrayList<Track> LIB = new CopyOnWriteArrayList<Track>();

    private static boolean loaded = false;

    private Store() { }

    private static SharedPreferences sp(Context c) {
        return c.getApplicationContext().getSharedPreferences(Prefs.FILE, Context.MODE_PRIVATE);
    }

    public static synchronized void load(Context c) {
        if (loaded) return;
        loaded = true;
        LIB.clear();
        try {
            JSONArray arr = new JSONArray(sp(c).getString("lib", "[]"));
            for (int i = 0; i < arr.length(); i++) {
                JSONObject o = arr.getJSONObject(i);
                LIB.add(new Track(o.getString("u"), o.optString("t", "track"), o.optLong("d", 0)));
            }
        } catch (Exception e) {
            LIB.clear();
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
                arr.put(o);
            } catch (Exception e) { /* skip this one */ }
        }
        sp(c).edit().putString("lib", arr.toString()).apply();
    }

    public static String script(Context c)           { return sp(c).getString("script", ""); }
    public static void   script(Context c, String v) { sp(c).edit().putString("script", v).apply(); }

    // ---- saved programs -------------------------------------------------
    private static JSONObject progs(Context c) {
        try { return new JSONObject(sp(c).getString("progs", "{}")); }
        catch (Exception e) { return new JSONObject(); }
    }

    public static List<String> programNames(Context c) {
        List<String> out = new ArrayList<String>();
        JSONObject o = progs(c);
        for (Iterator<String> it = o.keys(); it.hasNext(); ) out.add(it.next());
        Collections.sort(out, String.CASE_INSENSITIVE_ORDER);
        return out;
    }

    public static String program(Context c, String name) { return progs(c).optString(name, ""); }

    public static void saveProgram(Context c, String name, String body) {
        JSONObject o = progs(c);
        try { o.put(name, body); } catch (Exception e) { return; }
        sp(c).edit().putString("progs", o.toString()).apply();
    }

    public static void deleteProgram(Context c, String name) {
        JSONObject o = progs(c);
        o.remove(name);
        sp(c).edit().putString("progs", o.toString()).apply();
    }
}
'@

# ---------------------------------------------------------------------------
# Java: theme + widget factory + hand drawn icons
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Ui.java" @'
package com.riola.player;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

/**
 * A very small design system: one palette plus factory methods for the few
 * widgets the app needs. Nothing here depends on AndroidX or on XML layouts.
 */
public final class Ui {

    public static final int PRIMARY = 0, SECONDARY = 1, DANGER = 2, GHOST = 3;

    public static boolean dark = true;
    public static int BG, SURF, SURF2, LINE, TXT, DIM, ACC, ACC2, RED, GREEN, AMBER, RIPPLE, ONACC;

    private Ui() { }

    public static void theme(boolean isDark) {
        dark = isDark;
        if (isDark) {
            BG    = 0xFF0E1116; SURF  = 0xFF161C24; SURF2 = 0xFF1E2630; LINE  = 0xFF2C3542;
            TXT   = 0xFFE8EDF3; DIM   = 0xFF93A1B0; ACC   = 0xFF4CC2FF; ACC2  = 0xFF8B7CFF;
            RED   = 0xFFFF6B6B; GREEN = 0xFF3DDC97; AMBER = 0xFFFFC65C;
            RIPPLE = 0x33FFFFFF; ONACC = 0xFF06131C;
        } else {
            BG    = 0xFFF4F6FA; SURF  = 0xFFFFFFFF; SURF2 = 0xFFEDF1F7; LINE  = 0xFFD6DEE8;
            TXT   = 0xFF12181F; DIM   = 0xFF5A6673; ACC   = 0xFF0A7FC7; ACC2  = 0xFF5B4BE0;
            RED   = 0xFFD03A3A; GREEN = 0xFF10875A; AMBER = 0xFFA97400;
            RIPPLE = 0x22000000; ONACC = 0xFFFFFFFF;
        }
    }

    public static int dp(Context c, float v) {
        return Math.round(v * c.getResources().getDisplayMetrics().density);
    }

    // ---- drawables -------------------------------------------------------
    public static GradientDrawable rr(Context c, int fill, float radDp) {
        GradientDrawable g = new GradientDrawable();
        g.setColor(fill);
        g.setCornerRadius(dp(c, radDp));
        return g;
    }

    public static GradientDrawable rrs(Context c, int fill, int stroke, float radDp, float wDp) {
        GradientDrawable g = rr(c, fill, radDp);
        g.setStroke(Math.max(1, dp(c, wDp)), stroke);
        return g;
    }

    public static Drawable ripple(Drawable content) {
        return new RippleDrawable(ColorStateList.valueOf(RIPPLE), content, null);
    }

    public static Drawable circle(Context c, int fill, int sizeDp) {
        GradientDrawable g = new GradientDrawable();
        g.setShape(GradientDrawable.OVAL);
        g.setColor(fill);
        g.setSize(dp(c, sizeDp), dp(c, sizeDp));
        return g;
    }

    // ---- layout params ---------------------------------------------------
    public static LinearLayout.LayoutParams lp(int w, int h) {
        return new LinearLayout.LayoutParams(w, h);
    }

    public static LinearLayout.LayoutParams lpw(int w, int h, float weight) {
        return new LinearLayout.LayoutParams(w, h, weight);
    }

    public static final int MATCH = ViewGroup.LayoutParams.MATCH_PARENT;
    public static final int WRAP  = ViewGroup.LayoutParams.WRAP_CONTENT;

    public static View margin(Context c, View v, float l, float t, float r, float b) {
        ViewGroup.LayoutParams p = v.getLayoutParams();
        LinearLayout.LayoutParams lp = (p instanceof LinearLayout.LayoutParams)
                ? (LinearLayout.LayoutParams) p : new LinearLayout.LayoutParams(MATCH, WRAP);
        lp.setMargins(dp(c, l), dp(c, t), dp(c, r), dp(c, b));
        v.setLayoutParams(lp);
        return v;
    }

    // ---- containers ------------------------------------------------------
    public static LinearLayout col(Context c) {
        LinearLayout l = new LinearLayout(c);
        l.setOrientation(LinearLayout.VERTICAL);
        l.setLayoutParams(lp(MATCH, WRAP));
        return l;
    }

    public static LinearLayout row(Context c) {
        LinearLayout l = new LinearLayout(c);
        l.setOrientation(LinearLayout.HORIZONTAL);
        l.setGravity(Gravity.CENTER_VERTICAL);
        l.setLayoutParams(lp(MATCH, WRAP));
        return l;
    }

    public static LinearLayout card(Context c) {
        LinearLayout l = col(c);
        l.setBackground(rrs(c, SURF, LINE, 18, 1));
        int p = dp(c, 14);
        l.setPadding(p, dp(c, 12), p, dp(c, 12));
        margin(c, l, 12, 0, 12, 10);
        return l;
    }

    public static View gap(Context c, float h) {
        View v = new View(c);
        v.setLayoutParams(lp(MATCH, dp(c, h)));
        return v;
    }

    public static View divider(Context c) {
        View v = new View(c);
        v.setBackgroundColor(LINE);
        LinearLayout.LayoutParams p = lp(MATCH, Math.max(1, dp(c, 0.7f)));
        p.setMargins(0, dp(c, 8), 0, dp(c, 8));
        v.setLayoutParams(p);
        return v;
    }

    // ---- text ------------------------------------------------------------
    public static TextView tv(Context c, String s, float sp, int color, boolean bold) {
        TextView t = new TextView(c);
        t.setText(s);
        t.setTextSize(sp);
        t.setTextColor(color);
        if (bold) t.setTypeface(Typeface.DEFAULT_BOLD);
        t.setLayoutParams(lp(WRAP, WRAP));
        return t;
    }

    public static TextView mono(Context c, String s, float sp, int color) {
        TextView t = tv(c, s, sp, color, false);
        t.setTypeface(Typeface.MONOSPACE);
        return t;
    }

    /** Small upper-case section heading with an icon. */
    public static LinearLayout heading(Context c, int icoId, String text) {
        LinearLayout r = row(c);
        r.addView(icon(c, icoId, ACC, 16));
        TextView t = tv(c, text.toUpperCase(), 12, DIM, true);
        t.setLetterSpacing(0.12f);
        margin(c, t, 8, 0, 0, 0);
        r.addView(t);
        margin(c, r, 0, 0, 0, 8);
        return r;
    }

    public static TextView badge(Context c, String s, int fg, int bg) {
        TextView t = tv(c, s, 10, fg, true);
        t.setBackground(rr(c, bg, 20));
        t.setPadding(dp(c, 8), dp(c, 3), dp(c, 8), dp(c, 3));
        t.setLetterSpacing(0.06f);
        return t;
    }

    // ---- icons and buttons ----------------------------------------------
    public static ImageView icon(Context c, int icoId, int color, int sizeDp) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        v.setLayoutParams(lp(dp(c, sizeDp), dp(c, sizeDp)));
        return v;
    }

    public static ImageView iconBtn(Context c, int icoId, int color, int sizeDp, View.OnClickListener l) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        int pad = dp(c, 9);
        v.setPadding(pad, pad, pad, pad);
        int total = dp(c, sizeDp) + pad * 2;
        v.setLayoutParams(lp(total, total));
        v.setBackground(ripple(rr(c, 0x00000000, 40)));
        v.setOnClickListener(l);
        return v;
    }

    /** Big round transport button. */
    public static ImageView roundBtn(Context c, int icoId, int sizeDp, boolean filled, View.OnClickListener l) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, filled ? ONACC : TXT));
        int pad = dp(c, filled ? 15 : 12);
        v.setPadding(pad, pad, pad, pad);
        int total = dp(c, sizeDp) + pad * 2;
        v.setLayoutParams(lp(total, total));
        GradientDrawable g = new GradientDrawable();
        g.setShape(GradientDrawable.OVAL);
        g.setColor(filled ? ACC : SURF2);
        if (!filled) g.setStroke(Math.max(1, dp(c, 1)), LINE);
        v.setBackground(ripple(g));
        v.setOnClickListener(l);
        return v;
    }

    public static void setIcon(ImageView v, int icoId, int color) {
        v.setImageDrawable(new Ico(icoId, color));
    }

    public static LinearLayout btn(Context c, String text, int icoId, int kind, View.OnClickListener l) {
        int fill, fg, stroke;
        switch (kind) {
            case PRIMARY:   fill = ACC;   fg = ONACC; stroke = ACC;   break;
            case DANGER:    fill = SURF2; fg = RED;   stroke = RED;   break;
            case GHOST:     fill = 0x00000000; fg = DIM; stroke = 0x00000000; break;
            default:        fill = SURF2; fg = TXT;   stroke = LINE;  break;
        }
        LinearLayout b = new LinearLayout(c);
        b.setOrientation(LinearLayout.HORIZONTAL);
        b.setGravity(Gravity.CENTER);
        b.setPadding(dp(c, 14), dp(c, 11), dp(c, 14), dp(c, 11));
        b.setBackground(ripple(rrs(c, fill, stroke, 12, 1)));
        b.setClickable(true);
        b.setOnClickListener(l);
        b.setLayoutParams(lp(WRAP, WRAP));
        if (icoId > 0) {
            ImageView i = icon(c, icoId, fg, 16);
            margin(c, i, 0, 0, 8, 0);
            b.addView(i);
        }
        if (text != null && text.length() > 0) {
            TextView t = tv(c, text, 13, fg, true);
            t.setSingleLine(true);
            b.addView(t);
        }
        return b;
    }

    /** Rounded pill used for script snippets. */
    public static TextView chip(Context c, String text, View.OnClickListener l) {
        TextView t = tv(c, text, 12, ACC, true);
        t.setPadding(dp(c, 12), dp(c, 7), dp(c, 12), dp(c, 7));
        t.setBackground(ripple(rrs(c, SURF2, LINE, 20, 1)));
        t.setOnClickListener(l);
        t.setSingleLine(true);
        LinearLayout.LayoutParams p = lp(WRAP, WRAP);
        p.setMargins(0, 0, dp(c, 6), dp(c, 6));
        t.setLayoutParams(p);
        return t;
    }

    public static void ellipsize(TextView t) {
        t.setSingleLine(true);
        t.setEllipsize(TextUtils.TruncateAt.END);
    }
}
'@

Write-Src "$PKG_PATH\Ico.java" @'
package com.riola.player;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;

/**
 * Every icon in the app is drawn here on a 24x24 grid, so the APK needs no
 * bitmap assets and no icon font.
 */
public class Ico extends Drawable {

    public static final int PLAY = 1, PAUSE = 2, STOP = 3, NEXT = 4, PREV = 5, PLUS = 6,
            FOLDER = 7, TRASH = 8, SAVE = 9, OPEN = 10, HELP = 11, GEAR = 12, LOOP = 13,
            NOTE = 14, AB = 15, CHECK = 16, CLOSE = 17, UP = 18, DOWN = 19, CLOCK = 20,
            LIST = 21, WAVE = 22, EDIT = 23, SCISSOR = 24;

    private final int id;
    private int color;
    private final Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Path path = new Path();
    private final RectF r = new RectF();

    public Ico(int id, int color) {
        this.id = id;
        this.color = color;
    }

    @Override
    public void draw(Canvas cv) {
        Rect b = getBounds();
        float s = Math.min(b.width(), b.height());
        if (s <= 0) return;
        float u = s / 24f;
        float ox = b.exactCenterX() - 12f * u;
        float oy = b.exactCenterY() - 12f * u;

        p.setColor(color);
        p.setStrokeWidth(1.9f * u);
        p.setStrokeCap(Paint.Cap.ROUND);
        p.setStrokeJoin(Paint.Join.ROUND);
        p.setStyle(Paint.Style.STROKE);
        p.setTextAlign(Paint.Align.CENTER);

        switch (id) {
            case PLAY:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 6.5f, 4f, 19.5f, 12f, 6.5f, 20f);
                break;
            case PAUSE:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 6.5f, 4f, 10.5f, 20f, 1.4f);
                box(cv, ox, oy, u, 13.5f, 4f, 17.5f, 20f, 1.4f);
                break;
            case STOP:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 5.5f, 5.5f, 18.5f, 18.5f, 2.4f);
                break;
            case NEXT:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 5f, 4f, 15.5f, 12f, 5f, 20f);
                box(cv, ox, oy, u, 16.5f, 4f, 19.5f, 20f, 1.2f);
                break;
            case PREV:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 19f, 4f, 8.5f, 12f, 19f, 20f);
                box(cv, ox, oy, u, 4.5f, 4f, 7.5f, 20f, 1.2f);
                break;
            case PLUS:
                line(cv, ox, oy, u, 12f, 5f, 12f, 19f);
                line(cv, ox, oy, u, 5f, 12f, 19f, 12f);
                break;
            case FOLDER:
                poly(cv, ox, oy, u, true, 3f, 19f, 3f, 5.5f, 9f, 5.5f, 11f, 8.5f, 21f, 8.5f, 21f, 19f);
                break;
            case TRASH:
                p.setStyle(Paint.Style.STROKE);
                box(cv, ox, oy, u, 6f, 7.5f, 18f, 20.5f, 2f);
                line(cv, ox, oy, u, 3.5f, 7.5f, 20.5f, 7.5f);
                poly(cv, ox, oy, u, false, 9f, 7.5f, 9f, 4f, 15f, 4f, 15f, 7.5f);
                break;
            case SAVE:
                line(cv, ox, oy, u, 12f, 3.5f, 12f, 15f);
                poly(cv, ox, oy, u, false, 7f, 10.5f, 12f, 15.5f, 17f, 10.5f);
                line(cv, ox, oy, u, 4.5f, 20f, 19.5f, 20f);
                break;
            case OPEN:
                line(cv, ox, oy, u, 12f, 15.5f, 12f, 4f);
                poly(cv, ox, oy, u, false, 7f, 9f, 12f, 4f, 17f, 9f);
                line(cv, ox, oy, u, 4.5f, 20f, 19.5f, 20f);
                break;
            case HELP:
                cv.drawCircle(ox + 12f * u, oy + 12f * u, 8.8f * u, p);
                p.setStyle(Paint.Style.FILL);
                p.setTextSize(13f * u);
                cv.drawText("?", ox + 12f * u, oy + 16.6f * u, p);
                break;
            case GEAR: {
                cv.drawCircle(ox + 12f * u, oy + 12f * u, 4.2f * u, p);
                for (int i = 0; i < 8; i++) {
                    double a = Math.PI * i / 4.0;
                    float cxp = ox + 12f * u, cyp = oy + 12f * u;
                    cv.drawLine(cxp + (float) Math.cos(a) * 6.6f * u, cyp + (float) Math.sin(a) * 6.6f * u,
                                cxp + (float) Math.cos(a) * 9.4f * u, cyp + (float) Math.sin(a) * 9.4f * u, p);
                }
                break;
            }
            case LOOP:
                r.set(ox + 3.5f * u, oy + 6.5f * u, ox + 20.5f * u, oy + 17.5f * u);
                cv.drawRoundRect(r, 5.5f * u, 5.5f * u, p);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 13f, 3.6f, 17.5f, 6.5f, 13f, 9.4f);
                break;
            case NOTE:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 11.6f, 3.5f, 14.2f, 17f, 1f);
                poly(cv, ox, oy, u, true, 14.2f, 3.5f, 20.5f, 6f, 20.5f, 10.2f, 14.2f, 7.6f);
                r.set(ox + 5.4f * u, oy + 13.6f * u, ox + 13.4f * u, oy + 20.4f * u);
                cv.drawOval(r, p);
                break;
            case AB:
                p.setStyle(Paint.Style.FILL);
                p.setTextSize(11.5f * u);
                cv.drawText("AB", ox + 12f * u, oy + 16.2f * u, p);
                break;
            case CHECK:
                poly(cv, ox, oy, u, false, 4.5f, 12.8f, 9.8f, 18f, 19.5f, 6f);
                break;
            case CLOSE:
                line(cv, ox, oy, u, 6f, 6f, 18f, 18f);
                line(cv, ox, oy, u, 18f, 6f, 6f, 18f);
                break;
            case UP:
                poly(cv, ox, oy, u, false, 5.5f, 15f, 12f, 8.5f, 18.5f, 15f);
                break;
            case DOWN:
                poly(cv, ox, oy, u, false, 5.5f, 9f, 12f, 15.5f, 18.5f, 9f);
                break;
            case CLOCK:
                cv.drawCircle(ox + 12f * u, oy + 12f * u, 8.8f * u, p);
                line(cv, ox, oy, u, 12f, 12f, 12f, 6.6f);
                line(cv, ox, oy, u, 12f, 12f, 16f, 14f);
                break;
            case LIST:
                for (int i = 0; i < 3; i++) {
                    float y = 6.5f + i * 5.5f;
                    line(cv, ox, oy, u, 8.5f, y, 20f, y);
                    p.setStyle(Paint.Style.FILL);
                    cv.drawCircle(ox + 4.5f * u, oy + y * u, 1.5f * u, p);
                    p.setStyle(Paint.Style.STROKE);
                }
                break;
            case WAVE: {
                p.setStyle(Paint.Style.FILL);
                float[] h = { 7f, 13f, 20f, 11f, 6f };
                for (int i = 0; i < 5; i++) {
                    float x = 2.6f + i * 4.4f;
                    box(cv, ox, oy, u, x, 12f - h[i] / 2f, x + 2.8f, 12f + h[i] / 2f, 1.3f);
                }
                break;
            }
            case EDIT:
                poly(cv, ox, oy, u, true, 4f, 20f, 5.2f, 15.6f, 15.6f, 5.2f, 18.8f, 8.4f, 8.4f, 18.8f);
                break;
            case SCISSOR:
                line(cv, ox, oy, u, 6f, 4f, 18f, 18f);
                line(cv, ox, oy, u, 18f, 4f, 6f, 18f);
                cv.drawCircle(ox + 5.5f * u, oy + 19f * u, 2.6f * u, p);
                cv.drawCircle(ox + 18.5f * u, oy + 19f * u, 2.6f * u, p);
                break;
            default:
                break;
        }
    }

    private void poly(Canvas cv, float ox, float oy, float u, boolean close, float... pts) {
        path.reset();
        for (int i = 0; i + 1 < pts.length; i += 2) {
            if (i == 0) path.moveTo(ox + pts[i] * u, oy + pts[i + 1] * u);
            else path.lineTo(ox + pts[i] * u, oy + pts[i + 1] * u);
        }
        if (close) path.close();
        cv.drawPath(path, p);
    }

    private void box(Canvas cv, float ox, float oy, float u, float l, float t, float rr, float bb, float rad) {
        r.set(ox + l * u, oy + t * u, ox + rr * u, oy + bb * u);
        cv.drawRoundRect(r, rad * u, rad * u, p);
    }

    private void line(Canvas cv, float ox, float oy, float u, float x1, float y1, float x2, float y2) {
        cv.drawLine(ox + x1 * u, oy + y1 * u, ox + x2 * u, oy + y2 * u, p);
    }

    @Override public void setAlpha(int alpha) { p.setAlpha(alpha); invalidateSelf(); }
    @Override public void setColorFilter(ColorFilter cf) { p.setColorFilter(cf); invalidateSelf(); }
    @Override public int getOpacity() { return PixelFormat.TRANSLUCENT; }
    @Override public int getIntrinsicWidth() { return -1; }
    @Override public int getIntrinsicHeight() { return -1; }

    public void setColor(int c) { color = c; invalidateSelf(); }
}
'@

# ---------------------------------------------------------------------------
# Java: the script language
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Parser.java" @'
package com.riola.player;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Turns the program text into a flat list of Cmd steps.
 * Everything is case insensitive; "#" and "//" start a comment.
 */
public final class Parser {

    public static class Result {
        public final List<Cmd> cmds   = new ArrayList<Cmd>();
        public final List<String> errors = new ArrayList<String>();
        public boolean ok() { return errors.isEmpty(); }
        public long estMs() {
            long t = 0;
            for (int i = 0; i < cmds.size(); i++) t += cmds.get(i).estMs();
            return t;
        }
    }

    private static class PErr extends Exception {
        PErr(String m) { super(m); }
    }

    private static final int MAX_CMDS = 4000;

    private Parser() { }

    public static Result parse(String script, int trackCount) {
        Result res = new Result();
        if (script == null) script = "";
        String[] lines = script.split("\n", -1);
        List<int[]> stack = new ArrayList<int[]>();   // {startIndex, times, line}

        for (int li = 0; li < lines.length; li++) {
            int ln = li + 1;
            String s = strip(lines[li]);
            if (s.length() == 0) continue;
            String[] t = s.split("\\s+");
            String head = t[0].toUpperCase();
            try {
                if (head.equals("REPEAT")) {
                    int n = pint(word(t, 1, "a repeat count"));
                    if (n < 1) throw new PErr("REPEAT count must be 1 or more");
                    if (stack.size() >= 8) throw new PErr("REPEAT blocks are nested too deep");
                    stack.add(new int[]{ res.cmds.size(), n, ln });

                } else if (head.equals("END") || head.equals("ENDREPEAT")) {
                    if (stack.isEmpty()) throw new PErr("END without a matching REPEAT");
                    int[] top = stack.remove(stack.size() - 1);
                    int from = top[0], n = top[1];
                    int count = res.cmds.size() - from;
                    if (count == 0) throw new PErr("this REPEAT block is empty");
                    for (int k = 1; k < n; k++) {
                        for (int j = 0; j < count; j++) res.cmds.add(res.cmds.get(from + j).copy());
                        if (res.cmds.size() > MAX_CMDS) throw new PErr("program is too long after expanding REPEAT");
                    }

                } else if (head.equals("PLAY") || head.equals("LOOP")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.PLAY;
                    c.line = ln;
                    c.track = pint(word(t, 1, "a track number"));
                    int i = repeatSpec(t, 2, c, head.equals("LOOP"));
                    tail(t, i);
                    res.cmds.add(c);

                } else if (head.equals("SECTION") || head.equals("PART")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.SECTION;
                    c.line = ln;
                    c.track = pint(word(t, 1, "a track number"));
                    int i;
                    String p1 = word(t, 2, "a start time such as 0:30");
                    if (p1.indexOf('-') > 0) {
                        String[] halves = p1.split("-", 2);
                        c.a = pos(halves[0]);
                        c.b = pos(halves[1]);
                        i = 3;
                    } else {
                        c.a = pos(p1);
                        c.b = pos(word(t, 3, "an end time such as 1:15"));
                        i = 4;
                    }
                    if (c.b >= 0 && c.b <= c.a) throw new PErr("the end time must be after the start time");
                    i = repeatSpec(t, i, c, false);
                    tail(t, i);
                    res.cmds.add(c);

                } else if (head.equals("PAUSE") || head.equals("WAIT") || head.equals("SILENCE")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.PAUSE;
                    c.line = ln;
                    long[] d = dur(t, 1);
                    c.durMs = d[0];
                    tail(t, 1 + (int) d[1]);
                    res.cmds.add(c);

                } else if (head.equals("VOLUME") || head.equals("VOL")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.VOLUME;
                    c.line = ln;
                    c.value = pint(word(t, 1, "a volume from 0 to 100").replace("%", ""));
                    if (c.value < 0 || c.value > 100) throw new PErr("volume must be between 0 and 100");
                    tail(t, 2);
                    res.cmds.add(c);

                } else if (head.equals("SPEED")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.SPEED;
                    c.line = ln;
                    String v = word(t, 1, "a speed such as 1.0 or 125%");
                    c.value = v.endsWith("%") ? pint(v.substring(0, v.length() - 1))
                                              : Math.round(pfloat(v) * 100f);
                    if (c.value < 25 || c.value > 300) throw new PErr("speed must be between 0.25x and 3.0x");
                    tail(t, 2);
                    res.cmds.add(c);

                } else if (head.equals("FADE")) {
                    Cmd c = new Cmd();
                    c.type = Cmd.FADE;
                    c.line = ln;
                    String v = word(t, 1, "a fade length in milliseconds");
                    if (v.indexOf(':') >= 0 || hasUnit(v) || t.length > 2) {
                        long[] d = dur(t, 1);
                        c.value = (int) d[0];
                        tail(t, 1 + (int) d[1]);
                    } else {
                        c.value = pint(v);
                        tail(t, 2);
                    }
                    if (c.value < 0 || c.value > 5000) throw new PErr("fade must be between 0 and 5000 ms");
                    res.cmds.add(c);

                } else {
                    throw new PErr("do not know the command '" + t[0] + "'");
                }
            } catch (PErr e) {
                res.errors.add("Line " + ln + ": " + e.getMessage());
            }
        }

        if (!stack.isEmpty()) {
            res.errors.add("Line " + stack.get(stack.size() - 1)[2] + ": REPEAT is never closed with END");
        }

        Set<Integer> reported = new HashSet<Integer>();
        for (int i = 0; i < res.cmds.size(); i++) {
            Cmd c = res.cmds.get(i);
            if (c.track < 0) continue;
            if (c.track >= trackCount && reported.add(Integer.valueOf(c.line))) {
                res.errors.add("Line " + c.line + ": there is no track " + c.track
                        + " (the library holds " + trackCount + ")");
            }
        }
        return res;
    }

    // ---- pieces ----------------------------------------------------------

    /** Parses the optional "FOR <time>" / "<n> TIMES" suffix. Returns the next index. */
    private static int repeatSpec(String[] t, int i, Cmd c, boolean loopRequired) throws PErr {
        if (i >= t.length) {
            if (loopRequired) throw new PErr("LOOP needs 'FOR <time>' or '<n> TIMES'");
            c.times = 1;
            return i;
        }
        String w = t[i].toUpperCase();
        if (w.equals("FOR")) {
            long[] d = dur(t, i + 1);
            c.durMs = d[0];
            c.times = -1;
            if (c.durMs <= 0) throw new PErr("the duration must be longer than zero");
            return i + 1 + (int) d[1];
        }
        if (w.equals("ONCE")) { c.times = 1; return i + 1; }
        int[] n = timesSpec(t, i);
        c.times = n[0];
        if (c.times < 1) throw new PErr("the repeat count must be 1 or more");
        return i + n[1];
    }

    private static int[] timesSpec(String[] t, int i) throws PErr {
        String s = t[i].toUpperCase();
        if (s.length() > 1 && s.charAt(0) == 'X') return new int[]{ pint(s.substring(1)), 1 };
        if (s.length() > 1 && s.endsWith("X"))    return new int[]{ pint(s.substring(0, s.length() - 1)), 1 };
        int n = pint(s);
        if (i + 1 < t.length && t[i + 1].toUpperCase().startsWith("TIME")) return new int[]{ n, 2 };
        return new int[]{ n, 1 };
    }

    private static void tail(String[] t, int i) throws PErr {
        if (i < t.length) throw new PErr("did not expect '" + t[i] + "' at the end of the line");
    }

    private static String word(String[] t, int i, String what) throws PErr {
        if (i >= t.length) throw new PErr("expected " + what);
        return t[i];
    }

    private static String strip(String raw) {
        String s = raw;
        int h = s.indexOf('#');
        if (h >= 0) s = s.substring(0, h);
        int c = s.indexOf("//");
        if (c >= 0) s = s.substring(0, c);
        return s.trim();
    }

    private static boolean hasUnit(String s) {
        String u = s.toUpperCase();
        return u.endsWith("MS") || u.endsWith("S") || u.endsWith("SEC") || u.endsWith("SECS")
                || u.endsWith("M") || u.endsWith("MIN") || u.endsWith("MINS")
                || u.endsWith("H") || u.endsWith("HR");
    }

    private static long unitMs(String u) {
        String s = u.toUpperCase();
        if (s.equals("MS") || s.equals("MSEC")) return 1L;
        if (s.equals("S") || s.equals("SEC") || s.equals("SECS") || s.equals("SECOND") || s.equals("SECONDS")) return 1000L;
        if (s.equals("M") || s.equals("MIN") || s.equals("MINS") || s.equals("MINUTE") || s.equals("MINUTES")) return 60000L;
        if (s.equals("H") || s.equals("HR") || s.equals("HRS") || s.equals("HOUR") || s.equals("HOURS")) return 3600000L;
        return 0L;
    }

    /** Returns {milliseconds, tokensUsed}. */
    private static long[] dur(String[] t, int i) throws PErr {
        if (i >= t.length) throw new PErr("expected a length such as '5 MIN', '90 SEC' or '2:30'");
        String s = t[i];
        if (s.indexOf(':') >= 0) return new long[]{ clock(s), 1 };

        int split = 0;
        while (split < s.length() && (Character.isDigit(s.charAt(split)) || s.charAt(split) == '.')) split++;
        if (split == 0) throw new PErr("'" + s + "' is not a length");
        String num = s.substring(0, split);
        String unit = s.substring(split);
        if (unit.length() > 0) {
            long m = unitMs(unit);
            if (m == 0) throw new PErr("'" + unit + "' is not a time unit (use MS, SEC, MIN or HOUR)");
            return new long[]{ (long) (pfloat(num) * m), 1 };
        }
        if (i + 1 < t.length) {
            long m = unitMs(t[i + 1]);
            if (m > 0) return new long[]{ (long) (pfloat(num) * m), 2 };
        }
        throw new PErr("add a unit after " + num + " (MS, SEC, MIN or HOUR)");
    }

    /** A position inside a track: 0:30, 1:02:05, 45 (seconds), 45s, or END. */
    private static long pos(String s) throws PErr {
        String u = s.toUpperCase();
        if (u.equals("END") || u.equals("*")) return -1L;
        if (s.indexOf(':') >= 0) return clock(s);
        int split = 0;
        while (split < s.length() && (Character.isDigit(s.charAt(split)) || s.charAt(split) == '.')) split++;
        if (split == 0) throw new PErr("'" + s + "' is not a time position");
        String num = s.substring(0, split);
        String unit = s.substring(split);
        long mult = unit.length() == 0 ? 1000L : unitMs(unit);
        if (mult == 0) throw new PErr("'" + unit + "' is not a time unit");
        return (long) (pfloat(num) * mult);
    }

    private static long clock(String s) throws PErr {
        String[] parts = s.split(":");
        if (parts.length < 2 || parts.length > 3) throw new PErr("'" + s + "' is not a mm:ss time");
        try {
            if (parts.length == 2) {
                long m = Long.parseLong(parts[0].trim());
                float sec = Float.parseFloat(parts[1].trim());
                return m * 60000L + (long) (sec * 1000f);
            }
            long h = Long.parseLong(parts[0].trim());
            long m = Long.parseLong(parts[1].trim());
            float sec = Float.parseFloat(parts[2].trim());
            return h * 3600000L + m * 60000L + (long) (sec * 1000f);
        } catch (NumberFormatException e) {
            throw new PErr("'" + s + "' is not a mm:ss time");
        }
    }

    private static int pint(String s) throws PErr {
        try { return Integer.parseInt(s.trim()); }
        catch (NumberFormatException e) { throw new PErr("'" + s + "' is not a whole number"); }
    }

    private static float pfloat(String s) throws PErr {
        try { return Float.parseFloat(s.trim()); }
        catch (NumberFormatException e) { throw new PErr("'" + s + "' is not a number"); }
    }
}
'@

Write-Src "$PKG_PATH\HelpText.java" @'
package com.riola.player;

/** The in-app script reference. */
public final class HelpText {

    private HelpText() { }

    public static final String TEXT =
        "RIOLA PROGRAM LANGUAGE\n" +
        "======================\n" +
        "\n" +
        "A program is one command per line, run from top to bottom.\n" +
        "Tracks are addressed by the number shown next to them in the\n" +
        "library ([0], [1], [2] ...). Commands are case insensitive.\n" +
        "\n" +
        "PLAY\n" +
        "----\n" +
        "  PLAY 0                 play track 0 once, start to finish\n" +
        "  PLAY 0 3 TIMES         play it three times\n" +
        "  PLAY 0 x3              same thing, shorter\n" +
        "  PLAY 0 FOR 20 MIN      keep replaying it for twenty minutes\n" +
        "  LOOP 0 FOR 20 MIN      identical to the line above\n" +
        "\n" +
        "SECTION (A-B repeat)\n" +
        "--------------------\n" +
        "  SECTION 1 0:30 1:15              play 0:30 - 1:15 once\n" +
        "  SECTION 1 0:30 1:15 8 TIMES      loop that part eight times\n" +
        "  SECTION 1 0:30 1:15 FOR 12 MIN   loop it for twelve minutes\n" +
        "  SECTION 1 0:30-1:15 x8           dash form, same as above\n" +
        "  SECTION 1 2:00 END               from 2:00 to the end\n" +
        "\n" +
        "SILENCE\n" +
        "-------\n" +
        "  PAUSE 5 MIN            five minutes of silence\n" +
        "  PAUSE 90 SEC           ninety seconds\n" +
        "  PAUSE 2:30             two and a half minutes\n" +
        "  WAIT 45 SEC            WAIT and SILENCE mean PAUSE\n" +
        "\n" +
        "REPEAT BLOCKS\n" +
        "-------------\n" +
        "  REPEAT 4               run everything up to END four times\n" +
        "    SECTION 0 0:10 0:40 x2\n" +
        "    PAUSE 30 SEC\n" +
        "  END\n" +
        "  Blocks can be nested up to eight deep.\n" +
        "\n" +
        "TUNING (applies to the steps that follow)\n" +
        "-----------------------------------------\n" +
        "  VOLUME 70              70% of the master volume\n" +
        "  SPEED 1.25             play 25% faster (pitch corrected)\n" +
        "  FADE 200               200 ms fade at every loop edge\n" +
        "\n" +
        "TIME FORMATS\n" +
        "------------\n" +
        "  Lengths : 90 SEC, 5 MIN, 1.5 MIN, 2:30, 500 MS, 1 HOUR\n" +
        "  Points  : 0:30, 1:02:05, 45 (bare numbers mean seconds), END\n" +
        "\n" +
        "COMMENTS\n" +
        "--------\n" +
        "  # everything after a hash is ignored\n" +
        "  // so is everything after a double slash\n" +
        "\n" +
        "EXAMPLE: A PRACTICE SESSION\n" +
        "---------------------------\n" +
        "  # warm up with the full piece\n" +
        "  PLAY 0\n" +
        "  PAUSE 1 MIN\n" +
        "\n" +
        "  # drill the hard bar, slowly, then at tempo\n" +
        "  SPEED 0.8\n" +
        "  SECTION 0 1:12 1:28 FOR 10 MIN\n" +
        "  SPEED 1.0\n" +
        "  SECTION 0 1:12 1:28 x10\n" +
        "\n" +
        "  PAUSE 5 MIN\n" +
        "  PLAY 0 2 TIMES\n" +
        "\n" +
        "TIPS\n" +
        "----\n" +
        "  - Tap the A-B button on a track to pick section times by ear.\n" +
        "  - Tap any step in the step list to jump straight to it.\n" +
        "  - Playback keeps running in the background; use the\n" +
        "    notification to pause, skip or stop.\n";
}
'@

# ---------------------------------------------------------------------------
# Java: the playback engine
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Engine.java" @'
package com.riola.player;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.media.PlaybackParams;
import android.os.Handler;
import android.os.Looper;
import android.os.PowerManager;
import android.os.SystemClock;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Runs a program on a worker thread with a single MediaPlayer.
 *
 * One instance per process (Engine.get) so the activity and the foreground
 * service always look at the same playback.
 */
public class Engine {

    /** Snapshot of what the engine is doing; read by the UI and the notification. */
    public static class St {
        public boolean running, paused, preview;
        public int  step, steps;
        public String stepText = "";
        public String trackTitle = "";
        public int  posMs, durMs;
        public long stepRemainMs = -1;   // -1 = not time limited
        public long progRemainMs = -1;
        public int  repDone;
        public int  repTotal = -1;       // -1 = not count limited
    }

    public interface Listener {
        void onState(St s);
        void onLog(String line);
        void onFinished(boolean completed);
    }

    private static Engine I;

    public static synchronized Engine get(Context c) {
        if (I == null) I = new Engine(c.getApplicationContext());
        return I;
    }

    private final Context ctx;
    private final Prefs prefs;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final Object lock = new Object();
    private final CopyOnWriteArrayList<Listener> listeners = new CopyOnWriteArrayList<Listener>();
    private final StringBuilder logBuf = new StringBuilder();

    public final St st = new St();

    private MediaPlayer mp;
    private int loaded = -1;
    private Thread worker;
    private List<Cmd> cmds = new ArrayList<Cmd>();

    private volatile boolean stopReq, paused, running, completed, pushPending;
    private volatile int skip;        // -1 previous step, +1 next step, 2 jump
    private volatile int jump = -1;
    private volatile int idx;
    private volatile int gen;         // run id, so a restart cannot fire the old "finished"
    private volatile float duck = 1f;
    private volatile float gain = 1f;  // fade envelope
    private volatile float vol = 1f;
    private volatile float speed = 1f;
    private volatile long fadeMs = 150;

    private Engine(Context c) {
        ctx = c;
        prefs = new Prefs(c);
    }

    // ---- listeners -------------------------------------------------------
    public void addListener(Listener l)    { if (l != null && !listeners.contains(l)) listeners.add(l); }
    public void removeListener(Listener l) { listeners.remove(l); }

    public boolean isRunning() { return running; }
    public boolean isPaused()  { return paused; }
    public int stepCount()     { return cmds.size(); }
    public String logText()    { synchronized (logBuf) { return logBuf.toString(); } }
    public void clearLog()     { synchronized (logBuf) { logBuf.setLength(0); } }

    // ---- control ---------------------------------------------------------
    public void start(List<Cmd> program, int from) { begin(program, from, false); }

    public void preview(int track) {
        Cmd c = new Cmd();
        c.type = Cmd.PLAY;
        c.track = track;
        c.times = 1;
        List<Cmd> one = new ArrayList<Cmd>();
        one.add(c);
        begin(one, 0, true);
    }

    private void begin(List<Cmd> program, int from, boolean preview) {
        stop();
        cmds = new ArrayList<Cmd>(program);
        if (cmds.isEmpty()) return;
        vol = prefs.volume() / 100f;
        speed = prefs.speed();
        fadeMs = prefs.fadeMs();
        duck = 1f;
        gain = 1f;
        idx = Math.max(0, Math.min(from, cmds.size() - 1));
        stopReq = false;
        paused = false;
        skip = 0;
        jump = -1;
        running = true;
        st.running = true;
        st.paused = false;
        st.preview = preview;
        st.steps = cmds.size();
        st.step = idx;
        final int myGen = ++gen;
        Thread t = new Thread(new Runnable() { public void run() { loop(myGen); } }, "riola-engine");
        t.setPriority(Thread.NORM_PRIORITY + 1);
        worker = t;
        t.start();
    }

    public void stop() {
        Thread w = worker;
        stopReq = true;
        paused = false;
        wake();
        if (w != null && w.isAlive() && Thread.currentThread() != w) {
            try { w.join(2000); } catch (InterruptedException e) { /* give up waiting */ }
        }
        worker = null;
        running = false;
        releasePlayer();
        st.running = false;
        st.paused = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.repTotal = -1;
        push();
    }

    public void setPaused(boolean p) {
        if (!running || paused == p) return;
        paused = p;
        st.paused = p;
        MediaPlayer m = mp;
        if (m != null) {
            try {
                if (p) { if (m.isPlaying()) m.pause(); }
                else   { m.start(); applySpeed(); }
            } catch (IllegalStateException e) { /* player is between states */ }
        }
        log(p ? "paused" : "resumed");
        wake();
        push();
    }

    public void togglePause() { setPaused(!paused); }
    public void next()        { if (running) { skip = 1;  wake(); } }
    public void prev()        { if (running) { skip = -1; wake(); } }

    public void jumpTo(int i) {
        if (running && i >= 0 && i < cmds.size()) { jump = i; skip = 2; wake(); }
    }

    public void seekTo(int ms) {
        MediaPlayer m = mp;
        if (m == null) return;
        try { m.seekTo(ms); } catch (IllegalStateException e) { /* ignore */ }
    }

    public void setDuck(float d) { duck = d; applyVol(); }

    /** Live volume change from the settings sheet. */
    public void setMasterVolume(int percent) { vol = percent / 100f; applyVol(); }

    public void setMasterSpeed(int percent) { speed = percent / 100f; applySpeed(); }

    // ---- worker ----------------------------------------------------------
    private void loop(final int myGen) {
        log("program started, " + cmds.size() + " step(s)");
        while (!stopReq) {
            if (idx < 0) idx = 0;
            if (idx >= cmds.size()) break;
            Cmd c = cmds.get(idx);

            st.step = idx;
            st.steps = cmds.size();
            st.stepText = c.label();
            st.trackTitle = (c.type == Cmd.PAUSE) ? "Silence" : c.trackTitle();
            st.repDone = 0;
            st.repTotal = c.times > 0 ? c.times : -1;
            st.stepRemainMs = c.durMs > 0 ? c.durMs : -1;
            st.progRemainMs = restEst(idx + 1) + c.estMs();
            push();
            log("[" + (idx + 1) + "/" + cmds.size() + "] " + c.label());

            exec(c, restEst(idx + 1));

            int s = skip;
            skip = 0;
            if (stopReq) break;
            if (s == 2)       { idx = jump; jump = -1; }
            else if (s == -1) { idx = idx - 1; }
            else              { idx = idx + 1; }
        }

        boolean finished = !stopReq;
        pausePlayer();
        releasePlayer();
        running = false;
        st.running = false;
        st.paused = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.stepText = finished ? "Program finished" : "Stopped";
        log(finished ? "program finished" : "program stopped");
        push();
        final boolean done = finished;
        main.post(new Runnable() {
            public void run() {
                if (myGen != gen) return;      // a new program already took over
                for (Listener l : listeners) l.onFinished(done);
            }
        });
    }

    private long restEst(int from) {
        long t = 0;
        for (int i = from; i < cmds.size(); i++) t += cmds.get(i).estMs();
        return t;
    }

    private void exec(Cmd c, long rest) {
        switch (c.type) {
            case Cmd.VOLUME:
                vol = c.value / 100f;
                applyVol();
                return;
            case Cmd.SPEED:
                speed = c.value / 100f;
                applySpeed();
                return;
            case Cmd.FADE:
                fadeMs = c.value;
                return;
            case Cmd.PAUSE:
                pausePlayer();
                silence(c.durMs, rest);
                return;
            default:
                segment(c, rest);
        }
    }

    /** A stretch of silence that still responds to pause / skip / stop. */
    private void silence(long total, long rest) {
        long remain = total;
        long last = SystemClock.elapsedRealtime();
        while (remain > 0) {
            if (stopReq || skip != 0) return;
            waitLock(200);
            long now = SystemClock.elapsedRealtime();
            long d = now - last;
            last = now;
            if (!paused) remain -= d;
            st.posMs = (int) Math.min(Integer.MAX_VALUE, total - remain);
            st.durMs = (int) Math.min(Integer.MAX_VALUE, total);
            st.stepRemainMs = Math.max(0, remain);
            st.progRemainMs = rest + Math.max(0, remain);
            push();
        }
    }

    /** PLAY / SECTION: one region, repeated a number of times or for a while. */
    private void segment(Cmd c, long rest) {
        List<Track> lib = Store.LIB;
        if (c.track < 0 || c.track >= lib.size()) {
            log("  ! track " + c.track + " is not in the library - step skipped");
            return;
        }
        Track track = lib.get(c.track);
        if (!open(c.track, track)) return;

        long dur = duration();
        boolean known = dur > 0;
        long end = (c.b < 0 || (known && c.b > dur)) ? (known ? dur : Long.MAX_VALUE / 4) : c.b;
        long start = Math.max(0, c.a);
        if (known && start >= end - 150) {
            log("  ! that section is outside the track - step skipped");
            return;
        }

        long budget = c.durMs > 0 ? c.durMs : -1;
        long remain = budget;
        long fade = Math.min(fadeMs, Math.max(0, (end - start) / 4));
        int rep = 0;

        startAt(start);
        long grace = SystemClock.elapsedRealtime() + 400;
        long last = SystemClock.elapsedRealtime();

        while (true) {
            if (stopReq || skip != 0) { pausePlayer(); setGain(1f); return; }

            int pos = position();
            long toEnd = end - pos;
            waitLock(toEnd < 500 ? 20 : 120);

            long now = SystemClock.elapsedRealtime();
            long d = now - last;
            last = now;
            if (paused) { grace += d; continue; }

            if (budget > 0) {
                remain -= d;
                st.stepRemainMs = Math.max(0, remain);
                st.progRemainMs = rest + Math.max(0, remain);
                if (remain <= 0) {
                    fadeOut(160);
                    pausePlayer();
                    log("  time is up after " + (rep + 1) + " pass(es)");
                    setGain(1f);
                    return;
                }
            } else {
                st.progRemainMs = rest + Math.max(0, (long) (end - position()) + (long) (end - start) * Math.max(0, c.times - 1 - rep));
            }

            pos = position();
            st.posMs = pos;
            st.durMs = known ? (int) dur : pos;
            st.repDone = rep;

            // fade envelope at both edges of the region
            if (fade > 0) {
                float g = 1f;
                long since = pos - start;
                long left = end - pos;
                if (since >= 0 && since < fade) g = Math.min(g, since / (float) fade);
                if (left  >= 0 && left  < fade) g = Math.min(g, left / (float) fade);
                setGain(Math.max(0.02f, g));
            }
            push();

            boolean atEnd = completed || (now > grace && known && pos >= end - 30);
            if (!atEnd) continue;

            completed = false;
            rep++;
            st.repDone = rep;
            if (c.times > 0 && rep >= c.times) {
                pausePlayer();
                setGain(1f);
                log("  played " + rep + " time(s)");
                return;
            }
            if (budget > 0 && remain <= 0) { pausePlayer(); setGain(1f); return; }
            setGain(fade > 0 ? 0.02f : 1f);
            startAt(start);
            grace = SystemClock.elapsedRealtime() + 400;
            last = SystemClock.elapsedRealtime();
        }
    }

    // ---- MediaPlayer plumbing -------------------------------------------
    private boolean open(int index, Track t) {
        MediaPlayer m = mp;
        if (m != null && loaded == index) {
            try { if (m.isPlaying()) m.pause(); } catch (IllegalStateException e) { /* ignore */ }
            return true;
        }
        releasePlayer();
        try {
            m = new MediaPlayer();
            m.setAudioAttributes(new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build());
            m.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                public void onCompletion(MediaPlayer p) { completed = true; wake(); }
            });
            m.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                public boolean onError(MediaPlayer p, int what, int extra) {
                    log("  ! player error " + what + "/" + extra);
                    completed = true;
                    wake();
                    return true;
                }
            });
            m.setWakeMode(ctx, PowerManager.PARTIAL_WAKE_LOCK);
            m.setDataSource(ctx, t.toUri());
            m.prepare();
            mp = m;
            loaded = index;
            applyVol();
            return true;
        } catch (Exception e) {
            log("  ! cannot open " + t.shortTitle() + " (" + e.getClass().getSimpleName() + ")");
            try { if (m != null) m.release(); } catch (Exception ignored) { }
            mp = null;
            loaded = -1;
            return false;
        }
    }

    private void startAt(long ms) {
        MediaPlayer m = mp;
        if (m == null) return;
        completed = false;
        try {
            try { m.seekTo((int) ms, MediaPlayer.SEEK_CLOSEST); }
            catch (Throwable t) { m.seekTo((int) ms); }
            if (!paused) {
                m.start();
                applySpeed();
            }
            applyVol();
        } catch (IllegalStateException e) {
            log("  ! could not start playback");
        }
    }

    private void fadeOut(long ms) {
        if (ms <= 0 || mp == null) return;
        int steps = 8;
        for (int i = steps - 1; i >= 0; i--) {
            setGain(Math.max(0.02f, i / (float) steps));
            waitLock(ms / steps);
            if (stopReq) break;
        }
    }

    private void pausePlayer() {
        MediaPlayer m = mp;
        if (m == null) return;
        try { if (m.isPlaying()) m.pause(); } catch (IllegalStateException e) { /* ignore */ }
    }

    private void releasePlayer() {
        MediaPlayer m = mp;
        mp = null;
        loaded = -1;
        if (m == null) return;
        try { m.reset(); } catch (Exception e) { /* ignore */ }
        try { m.release(); } catch (Exception e) { /* ignore */ }
    }

    private int position() {
        MediaPlayer m = mp;
        if (m == null) return 0;
        try { return Math.max(0, m.getCurrentPosition()); } catch (IllegalStateException e) { return 0; }
    }

    private long duration() {
        MediaPlayer m = mp;
        if (m == null) return 0;
        try { return Math.max(0, m.getDuration()); } catch (IllegalStateException e) { return 0; }
    }

    private void setGain(float g) {
        gain = g;
        applyVol();
    }

    private void applyVol() {
        MediaPlayer m = mp;
        if (m == null) return;
        float v = vol * duck * gain;
        if (v < 0f) v = 0f;
        if (v > 1f) v = 1f;
        try { m.setVolume(v, v); } catch (IllegalStateException e) { /* ignore */ }
    }

    private void applySpeed() {
        MediaPlayer m = mp;
        if (m == null) return;
        try {
            if (!m.isPlaying()) return;
            PlaybackParams pp = m.getPlaybackParams();
            pp.setSpeed(speed <= 0f ? 1f : speed);
            m.setPlaybackParams(pp);
        } catch (Exception e) { /* device refused the speed change */ }
    }

    // ---- helpers ---------------------------------------------------------
    private void waitLock(long ms) {
        if (ms <= 0) ms = 1;
        synchronized (lock) {
            try { lock.wait(ms); } catch (InterruptedException e) { Thread.currentThread().interrupt(); }
        }
    }

    private void wake() {
        synchronized (lock) { lock.notifyAll(); }
    }

    private void push() {
        if (pushPending) return;
        pushPending = true;
        main.post(new Runnable() {
            public void run() {
                pushPending = false;
                for (Listener l : listeners) l.onState(st);
            }
        });
    }

    public void log(String line) {
        final String entry = Fmt.ms(SystemClock.elapsedRealtime() % 3600000L) + "  " + line;
        synchronized (logBuf) {
            logBuf.append(entry).append('\n');
            if (logBuf.length() > 24000) logBuf.delete(0, logBuf.length() - 16000);
        }
        main.post(new Runnable() {
            public void run() {
                for (Listener l : listeners) l.onLog(entry);
            }
        });
    }
}
'@

# ---------------------------------------------------------------------------
# Java: foreground service (notification, lock screen, audio focus)
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\PlayerService.java" @'
package com.riola.player;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.Icon;
import android.media.AudioAttributes;
import android.media.AudioFocusRequest;
import android.media.AudioManager;
import android.media.MediaMetadata;
import android.media.session.MediaSession;
import android.media.session.PlaybackState;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import android.os.SystemClock;

/**
 * Keeps the program running when the app is not on screen and puts transport
 * controls in the notification shade and on the lock screen.
 */
public class PlayerService extends Service implements Engine.Listener {

    public static final String ACT_ATTACH = "riola.attach";
    public static final String ACT_TOGGLE = "riola.toggle";
    public static final String ACT_NEXT   = "riola.next";
    public static final String ACT_PREV   = "riola.prev";
    public static final String ACT_STOP   = "riola.stop";

    private static final String CHANNEL = "riola.playback";
    private static final int NID = 4201;

    private Engine engine;
    private Prefs prefs;
    private AudioManager am;
    private AudioFocusRequest focus;
    private MediaSession session;
    private PowerManager.WakeLock wakeLock;
    private BroadcastReceiver noisy;
    private boolean started;
    private boolean pausedByFocus;
    private long lastPost;
    private String lastKey = "";

    @Override
    public void onCreate() {
        super.onCreate();
        prefs = new Prefs(this);
        engine = Engine.get(this);
        engine.addListener(this);
        am = (AudioManager) getSystemService(Context.AUDIO_SERVICE);

        NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        NotificationChannel ch = new NotificationChannel(CHANNEL, "Playback", NotificationManager.IMPORTANCE_LOW);
        ch.setDescription("Shows the running Riola program");
        ch.setShowBadge(false);
        ch.setSound(null, null);
        ch.enableVibration(false);
        nm.createNotificationChannel(ch);

        session = new MediaSession(this, "Riola");
        session.setCallback(new MediaSession.Callback() {
            @Override public void onPlay()             { engine.setPaused(false); }
            @Override public void onPause()            { engine.setPaused(true); }
            @Override public void onStop()             { engine.stop(); shutdown(); }
            @Override public void onSkipToNext()       { engine.next(); }
            @Override public void onSkipToPrevious()   { engine.prev(); }
            @Override public void onSeekTo(long p)     { engine.seekTo((int) p); }
        });
        session.setActive(true);

        noisy = new BroadcastReceiver() {
            @Override public void onReceive(Context c, Intent i) {
                if (prefs.pauseUnplug() && engine.isRunning() && !engine.isPaused()) {
                    engine.setPaused(true);
                    engine.log("output disconnected - paused");
                }
            }
        };
        IntentFilter f = new IntentFilter(AudioManager.ACTION_AUDIO_BECOMING_NOISY);
        if (Build.VERSION.SDK_INT >= 33) registerReceiver(noisy, f, Context.RECEIVER_NOT_EXPORTED);
        else registerReceiver(noisy, f);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String a = intent == null ? ACT_ATTACH : intent.getAction();
        if (a == null) a = ACT_ATTACH;

        if (!started) {
            startForeground(NID, build());
            started = true;
            requestFocus();
            holdWakeLock(true);
        }

        if (ACT_TOGGLE.equals(a))      engine.togglePause();
        else if (ACT_NEXT.equals(a))   engine.next();
        else if (ACT_PREV.equals(a))   engine.prev();
        else if (ACT_STOP.equals(a))   { engine.stop(); shutdown(); return START_NOT_STICKY; }

        post(true);
        if (!engine.isRunning() && !ACT_ATTACH.equals(a)) shutdown();
        return START_NOT_STICKY;
    }

    @Override public IBinder onBind(Intent intent) { return null; }

    @Override
    public void onDestroy() {
        engine.removeListener(this);
        holdWakeLock(false);
        abandonFocus();
        try { unregisterReceiver(noisy); } catch (Exception e) { /* already gone */ }
        if (session != null) { session.setActive(false); session.release(); }
        started = false;
        super.onDestroy();
    }

    @Override
    public void onTaskRemoved(Intent rootIntent) {
        // A swipe of the task must not kill the audio: nothing to do here,
        // the foreground notification keeps the service alive.
        super.onTaskRemoved(rootIntent);
    }

    // ---- engine callbacks ------------------------------------------------
    @Override public void onState(Engine.St s) { post(false); }
    @Override public void onLog(String line) { }

    @Override
    public void onFinished(boolean completed) {
        shutdown();
    }

    private void shutdown() {
        holdWakeLock(false);
        abandonFocus();
        started = false;
        stopForeground(Service.STOP_FOREGROUND_REMOVE);
        stopSelf();
    }

    // ---- notification ----------------------------------------------------
    private void post(boolean force) {
        if (!started) return;
        Engine.St s = engine.st;
        String key = s.trackTitle + "|" + s.stepText + "|" + s.paused + "|" + s.running + "|" + s.step;
        long now = SystemClock.elapsedRealtime();
        if (!force && key.equals(lastKey) && now - lastPost < 1000) return;
        lastKey = key;
        lastPost = now;
        NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        nm.notify(NID, build());
        updateSession(s);
    }

    private Notification build() {
        Engine.St s = engine.st;
        boolean playing = s.running && !s.paused;

        Intent open = new Intent(this, MainActivity.class)
                .setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        PendingIntent content = PendingIntent.getActivity(this, 0, open,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        String sub = s.running ? ("Step " + (s.step + 1) + " of " + s.steps) : "Idle";
        if (s.running && s.stepRemainMs >= 0) sub = sub + "  -  " + Fmt.human(s.stepRemainMs) + " left";
        else if (s.running && s.repTotal > 0) sub = sub + "  -  pass " + Math.min(s.repDone + 1, s.repTotal) + " of " + s.repTotal;

        Notification.Builder b = new Notification.Builder(this, CHANNEL)
                .setSmallIcon(R.drawable.ic_note)
                .setContentTitle(s.trackTitle == null || s.trackTitle.length() == 0 ? "Riola" : s.trackTitle)
                .setContentText(s.stepText)
                .setSubText(sub)
                .setContentIntent(content)
                .setOngoing(s.running)
                .setOnlyAlertOnce(true)
                .setShowWhen(false)
                .setVisibility(Notification.VISIBILITY_PUBLIC)
                .setCategory(Notification.CATEGORY_TRANSPORT);

        b.addAction(action(R.drawable.ic_prev, "Previous", ACT_PREV));
        b.addAction(playing ? action(R.drawable.ic_pause, "Pause", ACT_TOGGLE)
                            : action(R.drawable.ic_play, "Play", ACT_TOGGLE));
        b.addAction(action(R.drawable.ic_next, "Next", ACT_NEXT));
        b.addAction(action(R.drawable.ic_stop, "Stop", ACT_STOP));

        Notification.MediaStyle style = new Notification.MediaStyle()
                .setShowActionsInCompactView(0, 1, 2);
        if (session != null) style.setMediaSession(session.getSessionToken());
        b.setStyle(style);

        if (s.durMs > 0) b.setProgress(s.durMs, s.posMs, false);
        return b.build();
    }

    private Notification.Action action(int icon, String title, String act) {
        PendingIntent pi = PendingIntent.getService(this, act.hashCode(),
                new Intent(this, PlayerService.class).setAction(act),
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        return new Notification.Action.Builder(Icon.createWithResource(this, icon), title, pi).build();
    }

    private void updateSession(Engine.St s) {
        if (session == null) return;
        try {
            session.setMetadata(new MediaMetadata.Builder()
                    .putString(MediaMetadata.METADATA_KEY_TITLE, s.trackTitle)
                    .putString(MediaMetadata.METADATA_KEY_ARTIST, s.stepText)
                    .putString(MediaMetadata.METADATA_KEY_ALBUM, "Riola")
                    .putLong(MediaMetadata.METADATA_KEY_DURATION, s.durMs)
                    .build());
            int state = !s.running ? PlaybackState.STATE_STOPPED
                    : (s.paused ? PlaybackState.STATE_PAUSED : PlaybackState.STATE_PLAYING);
            session.setPlaybackState(new PlaybackState.Builder()
                    .setActions(PlaybackState.ACTION_PLAY | PlaybackState.ACTION_PAUSE
                            | PlaybackState.ACTION_PLAY_PAUSE | PlaybackState.ACTION_STOP
                            | PlaybackState.ACTION_SKIP_TO_NEXT | PlaybackState.ACTION_SKIP_TO_PREVIOUS
                            | PlaybackState.ACTION_SEEK_TO)
                    .setState(state, s.posMs, state == PlaybackState.STATE_PLAYING ? 1f : 0f)
                    .build());
        } catch (Exception e) { /* metadata is cosmetic */ }
    }

    // ---- audio focus and wake lock --------------------------------------
    private void requestFocus() {
        if (focus != null) return;
        AudioManager.OnAudioFocusChangeListener l = new AudioManager.OnAudioFocusChangeListener() {
            public void onAudioFocusChange(int change) {
                if (change == AudioManager.AUDIOFOCUS_LOSS) {
                    if (prefs.pauseOnFocus() && engine.isRunning() && !engine.isPaused()) {
                        pausedByFocus = true;
                        engine.setPaused(true);
                    }
                } else if (change == AudioManager.AUDIOFOCUS_LOSS_TRANSIENT) {
                    if (engine.isRunning() && !engine.isPaused()) {
                        pausedByFocus = true;
                        engine.setPaused(true);
                    }
                } else if (change == AudioManager.AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK) {
                    engine.setDuck(0.25f);
                } else if (change == AudioManager.AUDIOFOCUS_GAIN) {
                    engine.setDuck(1f);
                    if (pausedByFocus) {
                        pausedByFocus = false;
                        engine.setPaused(false);
                    }
                }
            }
        };
        focus = new AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                .setAudioAttributes(new AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build())
                .setWillPauseWhenDucked(false)
                .setOnAudioFocusChangeListener(l)
                .build();
        am.requestAudioFocus(focus);
    }

    private void abandonFocus() {
        if (focus != null) {
            am.abandonAudioFocusRequest(focus);
            focus = null;
        }
    }

    private void holdWakeLock(boolean on) {
        if (on) {
            if (!prefs.wakeLock() || wakeLock != null) return;
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "riola:program");
            wakeLock.setReferenceCounted(false);
            wakeLock.acquire(6L * 60L * 60L * 1000L);
        } else if (wakeLock != null) {
            try { if (wakeLock.isHeld()) wakeLock.release(); } catch (Exception e) { /* ignore */ }
            wakeLock = null;
        }
    }
}
'@

# ---------------------------------------------------------------------------
# Java: the screen
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\MainActivity.java" @'
package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.ColorStateList;
import android.database.Cursor;
import android.graphics.Typeface;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.DocumentsContract;
import android.provider.OpenableColumns;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.HorizontalScrollView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class MainActivity extends Activity implements Engine.Listener {

    private static final int REQ_FILES = 101, REQ_TREE = 102, REQ_NOTIF = 103;
    private static final char NL = (char) 10;

    private Prefs prefs;
    private Engine eng;
    private final Handler ui = new Handler(Looper.getMainLooper());

    private LinearLayout tracksBox, stepsBox, stepsCard, logCard, idleBar, playBar;
    private EditText editor;
    private TextView libCount, validateMsg, logView, npTitle, npStep, npBadge, npTime, npRemain, stepsCount;
    private ScrollView logScroll;
    private SeekBar seek;
    private ImageView btnPlay;
    private final List<View> stepRows = new ArrayList<View>();
    private boolean dragging;
    private Runnable pendingValidate;

    // ======================================================================
    // lifecycle
    // ======================================================================
    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs.dark());
        setTheme(prefs.dark() ? android.R.style.Theme_Material_NoActionBar
                              : android.R.style.Theme_Material_Light_NoActionBar);
        super.onCreate(saved);
        Store.load(this);
        eng = Engine.get(this);

        setContentView(buildUi());
        getWindow().setStatusBarColor(Ui.BG);
        getWindow().setNavigationBarColor(Ui.BG);
        if (!Ui.dark) {
            getWindow().getDecorView().setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR | View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR);
        }

        editor.setText(firstRunText());
        refreshTracks();
        validate(false);
        logView.setText(eng.logText());
    }

    /** On a fresh install the editor starts with a short commented guide. */
    private String firstRunText() {
        String saved = Store.script(this);
        if (saved.length() > 0 || prefs.seeded()) return saved;
        prefs.seeded(true);
        StringBuilder b = new StringBuilder();
        b.append("# Welcome to Riola.").append(NL);
        b.append("#").append(NL);
        b.append("# 1. Add tracks with the buttons above.").append(NL);
        b.append("# 2. Write one step per line here.").append(NL);
        b.append("#    Tracks are numbered [0], [1], [2] ...").append(NL);
        b.append("# 3. Tap RUN PROGRAM.").append(NL);
        b.append("#").append(NL);
        b.append("# For example:").append(NL);
        b.append("#   PLAY 0 2 TIMES").append(NL);
        b.append("#   SECTION 0 0:30 1:15 FOR 10 MIN").append(NL);
        b.append("#   PAUSE 5 MIN").append(NL);
        b.append("#").append(NL);
        b.append("# Tap the ? in the corner for the whole language.").append(NL);
        return b.toString();
    }

    @Override
    protected void onResume() {
        super.onResume();
        eng.addListener(this);
        if (prefs.keepScreenOn()) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        else getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        logCard.setVisibility(prefs.showLog() ? View.VISIBLE : View.GONE);
        render(eng.st);
    }

    @Override
    protected void onPause() {
        eng.removeListener(this);
        if (prefs.autoSave()) Store.script(this, editor.getText().toString());
        super.onPause();
    }

    // ======================================================================
    // layout
    // ======================================================================
    private View buildUi() {
        LinearLayout root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        root.addView(header());

        ScrollView sv = new ScrollView(this);
        sv.setLayoutParams(Ui.lpw(Ui.MATCH, 0, 1f));
        sv.setFillViewport(true);
        sv.setClipToPadding(false);
        LinearLayout body = Ui.col(this);
        body.addView(libraryCard());
        body.addView(programCard());
        body.addView(stepsCard = stepsCard());
        body.addView(logCard = logCard());
        body.addView(Ui.gap(this, 6));
        sv.addView(body, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        root.addView(sv);

        root.addView(transportBar());
        return root;
    }

    private View header() {
        LinearLayout h = Ui.row(this);
        h.setPadding(Ui.dp(this, 16), Ui.dp(this, 14), Ui.dp(this, 8), Ui.dp(this, 8));

        ImageView mark = Ui.icon(this, Ico.NOTE, Ui.ACC, 20);
        mark.setPadding(Ui.dp(this, 7), Ui.dp(this, 7), Ui.dp(this, 7), Ui.dp(this, 7));
        mark.setLayoutParams(Ui.lp(Ui.dp(this, 34), Ui.dp(this, 34)));
        mark.setBackground(Ui.rr(this, Ui.SURF2, 10));
        h.addView(mark);

        LinearLayout titles = Ui.col(this);
        titles.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        Ui.margin(this, titles, 10, 0, 0, 0);
        TextView t = Ui.tv(this, "Riola", 20, Ui.TXT, true);
        t.setLetterSpacing(0.02f);
        titles.addView(t);
        titles.addView(Ui.tv(this, "programmable music player", 11, Ui.DIM, false));
        h.addView(titles);

        h.addView(Ui.iconBtn(this, Ico.HELP, Ui.DIM, 20, new View.OnClickListener() {
            public void onClick(View v) { helpDialog(); }
        }));
        h.addView(Ui.iconBtn(this, Ico.GEAR, Ui.DIM, 20, new View.OnClickListener() {
            public void onClick(View v) { settingsDialog(); }
        }));
        return h;
    }

    // ---- library ---------------------------------------------------------
    private View libraryCard() {
        LinearLayout c = Ui.card(this);

        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.LIST, "Library");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        libCount = Ui.badge(this, "0 tracks", Ui.DIM, Ui.SURF2);
        head.addView(libCount);
        c.addView(head);

        tracksBox = Ui.col(this);
        c.addView(tracksBox);

        LinearLayout btns = Ui.row(this);
        Ui.margin(this, btns, 0, 8, 0, 0);
        LinearLayout add = Ui.btn(this, "Add files", Ico.PLUS, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { pickFiles(); }
        });
        Ui.margin(this, add, 0, 0, 8, 0);
        btns.addView(add);
        btns.addView(Ui.btn(this, "Add folder", Ico.FOLDER, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { pickFolder(); }
        }));
        View spring = new View(this);
        spring.setLayoutParams(Ui.lpw(0, 1, 1f));
        btns.addView(spring);
        btns.addView(Ui.iconBtn(this, Ico.TRASH, Ui.DIM, 18, new View.OnClickListener() {
            public void onClick(View v) { confirmClearLibrary(); }
        }));
        c.addView(btns);
        return c;
    }

    private void refreshTracks() {
        tracksBox.removeAllViews();
        int n = Store.LIB.size();
        libCount.setText(n + (n == 1 ? " track" : " tracks"));
        if (n == 0) {
            TextView empty = Ui.tv(this, "No tracks yet. Add a few files or a whole folder,\nthen write a program that refers to them by number.",
                    12, Ui.DIM, false);
            Ui.margin(this, empty, 2, 4, 0, 6);
            tracksBox.addView(empty);
            return;
        }
        for (int i = 0; i < n; i++) tracksBox.addView(trackRow(i, Store.LIB.get(i)));
    }

    private View trackRow(final int index, Track t) {
        LinearLayout r = Ui.row(this);
        r.setBackground(Ui.ripple(Ui.rr(this, Ui.SURF2, 12)));
        r.setPadding(Ui.dp(this, 10), Ui.dp(this, 8), Ui.dp(this, 4), Ui.dp(this, 8));
        Ui.margin(this, r, 0, 0, 0, 6);

        TextView num = Ui.tv(this, String.valueOf(index), 12, Ui.ONACC, true);
        num.setBackground(Ui.rr(this, Ui.ACC2, 9));
        num.setPadding(Ui.dp(this, 9), Ui.dp(this, 4), Ui.dp(this, 9), Ui.dp(this, 4));
        num.setGravity(Gravity.CENTER);
        r.addView(num);

        LinearLayout mid = Ui.col(this);
        mid.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        Ui.margin(this, mid, 10, 0, 6, 0);
        TextView title = Ui.tv(this, t.shortTitle(), 14, Ui.TXT, false);
        Ui.ellipsize(title);
        mid.addView(title);
        mid.addView(Ui.tv(this, t.durMs > 0 ? Fmt.ms(t.durMs) : "length unknown", 11, Ui.DIM, false));
        r.addView(mid);

        r.addView(Ui.iconBtn(this, Ico.PLAY, Ui.ACC, 16, new View.OnClickListener() {
            public void onClick(View v) { previewTrack(index); }
        }));
        r.addView(Ui.iconBtn(this, Ico.AB, Ui.ACC, 16, new View.OnClickListener() {
            public void onClick(View v) { AbDialog.show(MainActivity.this, index, new AbDialog.OnInsert() {
                public void insert(String line) { insertLine(line); }
            }); }
        }));
        r.addView(Ui.iconBtn(this, Ico.LIST, Ui.DIM, 16, new View.OnClickListener() {
            public void onClick(View v) { trackMenu(index); }
        }));

        r.setOnLongClickListener(new View.OnLongClickListener() {
            public boolean onLongClick(View v) { trackMenu(index); return true; }
        });
        return r;
    }

    private void trackMenu(final int index) {
        if (index < 0 || index >= Store.LIB.size()) return;
        final Track t = Store.LIB.get(index);
        final String[] items = {
                "Insert  PLAY " + index,
                "Insert  SECTION " + index + " 0:00 0:30",
                "Pick an A-B section by ear",
                "Move up", "Move down", "Remove from library"
        };
        dialog().setTitle(t.shortTitle()).setItems(items, new android.content.DialogInterface.OnClickListener() {
            public void onClick(android.content.DialogInterface d, int which) {
                switch (which) {
                    case 0: insertLine("PLAY " + index); break;
                    case 1: insertLine("SECTION " + index + " 0:00 0:30 x2"); break;
                    case 2: AbDialog.show(MainActivity.this, index, new AbDialog.OnInsert() {
                                public void insert(String line) { insertLine(line); }
                            }); break;
                    case 3: move(index, -1); break;
                    case 4: move(index, 1); break;
                    default: remove(index); break;
                }
            }
        }).show();
    }

    private void move(int index, int dir) {
        int to = index + dir;
        if (to < 0 || to >= Store.LIB.size()) return;
        Track a = Store.LIB.get(index);
        Store.LIB.set(index, Store.LIB.get(to));
        Store.LIB.set(to, a);
        Store.saveLib(this);
        refreshTracks();
        toast("Track numbers changed - check your program");
    }

    private void remove(int index) {
        if (index < 0 || index >= Store.LIB.size()) return;
        Store.LIB.remove(index);
        Store.saveLib(this);
        refreshTracks();
        validate(false);
    }

    private void confirmClearLibrary() {
        if (Store.LIB.isEmpty()) return;
        dialog().setTitle("Clear the library?")
                .setMessage("This removes every track from Riola. Your files are not touched.")
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Clear", new android.content.DialogInterface.OnClickListener() {
                    public void onClick(android.content.DialogInterface d, int w) {
                        Store.LIB.clear();
                        Store.saveLib(MainActivity.this);
                        refreshTracks();
                        validate(false);
                    }
                }).show();
    }

    // ---- program ---------------------------------------------------------
    private View programCard() {
        LinearLayout c = Ui.card(this);
        c.addView(Ui.heading(this, Ico.EDIT, "Program"));

        HorizontalScrollView hs = new HorizontalScrollView(this);
        hs.setHorizontalScrollBarEnabled(false);
        hs.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        LinearLayout chips = Ui.row(this);
        chips.addView(snippet("PLAY", "PLAY 0 2 TIMES"));
        chips.addView(snippet("SECTION", "SECTION 0 0:30 1:15 FOR 10 MIN"));
        chips.addView(snippet("PAUSE", "PAUSE 5 MIN"));
        chips.addView(snippet("LOOP", "LOOP 0 FOR 15 MIN"));
        chips.addView(snippet("REPEAT", "REPEAT 3"));
        chips.addView(snippet("END", "END"));
        chips.addView(snippet("SPEED", "SPEED 1.0"));
        chips.addView(snippet("VOLUME", "VOLUME 80"));
        chips.addView(snippet("#", "# note to self"));
        hs.addView(chips, new FrameLayout.LayoutParams(Ui.WRAP, Ui.WRAP));
        c.addView(hs);

        editor = new EditText(this);
        editor.setTypeface(Typeface.MONOSPACE);
        editor.setTextSize(13);
        editor.setTextColor(Ui.TXT);
        editor.setHintTextColor(Ui.DIM);
        editor.setHint("PLAY 0\nSECTION 0 0:30 1:15 FOR 10 MIN\nPAUSE 2 MIN");
        editor.setGravity(Gravity.TOP | Gravity.START);
        editor.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_MULTI_LINE
                | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS | InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS);
        editor.setMinLines(6);
        editor.setBackground(Ui.rrs(this, Ui.dark ? 0xFF0B0F14 : 0xFFF8FAFC, Ui.LINE, 12, 1));
        int p = Ui.dp(this, 12);
        editor.setPadding(p, p, p, p);
        editor.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, editor, 0, 6, 0, 0);
        editor.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int a, int b, int c) { }
            public void onTextChanged(CharSequence s, int a, int b, int c) { }
            public void afterTextChanged(Editable e) { scheduleValidate(); }
        });
        c.addView(editor);

        validateMsg = Ui.tv(this, "", 12, Ui.DIM, false);
        Ui.margin(this, validateMsg, 2, 8, 0, 0);
        c.addView(validateMsg);

        LinearLayout btns = Ui.row(this);
        Ui.margin(this, btns, 0, 10, 0, 0);
        btns.addView(spaced(Ui.btn(this, "Check", Ico.CHECK, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { validate(true); }
        })));
        btns.addView(spaced(Ui.btn(this, "Save", Ico.SAVE, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { saveDialog(); }
        })));
        btns.addView(spaced(Ui.btn(this, "Load", Ico.OPEN, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) { loadDialog(); }
        })));
        View spring = new View(this);
        spring.setLayoutParams(Ui.lpw(0, 1, 1f));
        btns.addView(spring);
        btns.addView(Ui.btn(this, "Clear", 0, Ui.GHOST, new View.OnClickListener() {
            public void onClick(View v) {
                dialog().setTitle("Clear the program text?")
                        .setNegativeButton("Cancel", null)
                        .setPositiveButton("Clear", new android.content.DialogInterface.OnClickListener() {
                            public void onClick(android.content.DialogInterface d, int w) {
                                editor.setText("");
                                validate(false);
                            }
                        }).show();
            }
        }));
        c.addView(btns);
        return c;
    }

    private View spaced(View v) {
        Ui.margin(this, v, 0, 0, 8, 0);
        return v;
    }

    private View snippet(String label, final String text) {
        return Ui.chip(this, label, new View.OnClickListener() {
            public void onClick(View v) { insertLine(text); }
        });
    }

    private void insertLine(String line) {
        Editable e = editor.getText();
        String cur = e.toString();
        int at = Math.max(0, Math.min(editor.getSelectionStart(), cur.length()));
        int lineEnd = cur.indexOf('\n', at);
        if (lineEnd < 0) lineEnd = cur.length();
        String ins = (cur.trim().length() == 0) ? line + "\n" : "\n" + line;
        e.insert(lineEnd, ins);
        editor.setSelection(Math.min(e.length(), lineEnd + ins.length()));
        editor.requestFocus();
        scheduleValidate();
    }

    private void scheduleValidate() {
        if (pendingValidate != null) ui.removeCallbacks(pendingValidate);
        pendingValidate = new Runnable() {
            public void run() {
                if (prefs.autoSave()) Store.script(MainActivity.this, editor.getText().toString());
                validate(false);
            }
        };
        ui.postDelayed(pendingValidate, 500);
    }

    private Parser.Result validate(boolean loud) {
        Parser.Result r = Parser.parse(editor.getText().toString(), Store.LIB.size());
        if (r.cmds.isEmpty() && r.errors.isEmpty()) {
            validateMsg.setTextColor(Ui.DIM);
            validateMsg.setText("Empty program. Tap a chip above or the ? in the corner.");
        } else if (r.ok()) {
            validateMsg.setTextColor(Ui.GREEN);
            validateMsg.setText("Looks good: " + r.cmds.size() + " step(s), about " + Fmt.human(r.estMs()) + ".");
        } else {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < r.errors.size() && i < 6; i++) {
                if (i > 0) sb.append('\n');
                sb.append(r.errors.get(i));
            }
            if (r.errors.size() > 6) sb.append("\n...and ").append(r.errors.size() - 6).append(" more.");
            validateMsg.setTextColor(Ui.RED);
            validateMsg.setText(sb.toString());
        }
        showSteps(r.ok() ? r.cmds : new ArrayList<Cmd>());
        if (loud) toast(r.ok() ? "Program is valid" : (r.errors.size() + " problem(s) found"));
        return r;
    }

    // ---- steps -----------------------------------------------------------
    private LinearLayout stepsCard() {
        LinearLayout c = Ui.card(this);
        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.CLOCK, "Steps");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        stepsCount = Ui.badge(this, "", Ui.DIM, Ui.SURF2);
        head.addView(stepsCount);
        c.addView(head);
        stepsBox = Ui.col(this);
        c.addView(stepsBox);
        c.setVisibility(View.GONE);
        return c;
    }

    private void showSteps(List<Cmd> cmds) {
        stepsBox.removeAllViews();
        stepRows.clear();
        if (cmds.isEmpty()) {
            stepsCard.setVisibility(View.GONE);
            return;
        }
        stepsCard.setVisibility(View.VISIBLE);
        stepsCount.setText(cmds.size() + " steps  -  " + Fmt.human(estimate(cmds)));
        int limit = Math.min(cmds.size(), 60);
        for (int i = 0; i < limit; i++) {
            final int index = i;
            Cmd cmd = cmds.get(i);
            LinearLayout r = Ui.row(this);
            r.setPadding(Ui.dp(this, 8), Ui.dp(this, 7), Ui.dp(this, 8), Ui.dp(this, 7));
            r.setBackground(Ui.ripple(Ui.rr(this, 0x00000000, 10)));
            Ui.margin(this, r, 0, 0, 0, 2);
            TextView num = Ui.mono(this, pad(i + 1), 11, Ui.DIM);
            r.addView(num);
            TextView lbl = Ui.tv(this, cmd.label(), 12.5f, Ui.TXT, false);
            Ui.ellipsize(lbl);
            lbl.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            Ui.margin(this, lbl, 10, 0, 0, 0);
            r.addView(lbl);
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (eng.isRunning()) eng.jumpTo(index);
                    else runProgram(index);
                }
            });
            stepRows.add(r);
            stepsBox.addView(r);
        }
        if (cmds.size() > limit) {
            stepsBox.addView(Ui.tv(this, "...and " + (cmds.size() - limit) + " more steps", 11, Ui.DIM, false));
        }
    }

    private String pad(int n) {
        String s = String.valueOf(n);
        while (s.length() < 3) s = " " + s;
        return s;
    }

    private long estimate(List<Cmd> cmds) {
        long t = 0;
        for (int i = 0; i < cmds.size(); i++) t += cmds.get(i).estMs();
        return t;
    }

    private void highlight(int active) {
        for (int i = 0; i < stepRows.size(); i++) {
            View v = stepRows.get(i);
            if (i == active) v.setBackground(Ui.rrs(this, Ui.dark ? 0xFF10202B : 0xFFE3F2FB, Ui.ACC, 10, 1));
            else v.setBackground(Ui.ripple(Ui.rr(this, 0x00000000, 10)));
        }
    }

    // ---- log -------------------------------------------------------------
    private LinearLayout logCard() {
        LinearLayout c = Ui.card(this);
        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.WAVE, "Activity");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        head.addView(Ui.iconBtn(this, Ico.CLOSE, Ui.DIM, 14, new View.OnClickListener() {
            public void onClick(View v) { eng.clearLog(); logView.setText(""); }
        }));
        c.addView(head);

        logScroll = new ScrollView(this);
        logScroll.setLayoutParams(Ui.lp(Ui.MATCH, Ui.dp(this, 132)));
        logView = Ui.mono(this, "", 11, Ui.DIM);
        logScroll.addView(logView, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        c.addView(logScroll);
        return c;
    }

    private void appendLog(String line) {
        logView.append(line + "\n");
        logScroll.post(new Runnable() {
            public void run() { logScroll.fullScroll(View.FOCUS_DOWN); }
        });
    }

    // ---- transport -------------------------------------------------------
    private View transportBar() {
        LinearLayout wrap = Ui.col(this);
        wrap.setBackgroundColor(Ui.SURF);
        View top = new View(this);
        top.setLayoutParams(Ui.lp(Ui.MATCH, Math.max(1, Ui.dp(this, 0.7f))));
        top.setBackgroundColor(Ui.LINE);
        wrap.addView(top);

        LinearLayout inner = Ui.col(this);
        inner.setPadding(Ui.dp(this, 14), Ui.dp(this, 10), Ui.dp(this, 14), Ui.dp(this, 12));
        wrap.addView(inner);

        // idle
        idleBar = Ui.col(this);
        LinearLayout run = Ui.btn(this, "RUN PROGRAM", Ico.PLAY, Ui.PRIMARY, new View.OnClickListener() {
            public void onClick(View v) { runProgram(0); }
        });
        run.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        idleBar.addView(run);
        inner.addView(idleBar);

        // running
        playBar = Ui.col(this);
        playBar.setVisibility(View.GONE);

        LinearLayout line1 = Ui.row(this);
        npTitle = Ui.tv(this, "", 14, Ui.TXT, true);
        Ui.ellipsize(npTitle);
        npTitle.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        line1.addView(npTitle);
        npBadge = Ui.badge(this, "", Ui.ONACC, Ui.ACC);
        line1.addView(npBadge);
        playBar.addView(line1);

        npStep = Ui.tv(this, "", 12, Ui.DIM, false);
        Ui.ellipsize(npStep);
        Ui.margin(this, npStep, 0, 2, 0, 0);
        playBar.addView(npStep);

        seek = new SeekBar(this);
        seek.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int p, boolean fromUser) { }
            public void onStartTrackingTouch(SeekBar s) { dragging = true; }
            public void onStopTrackingTouch(SeekBar s) { dragging = false; eng.seekTo(s.getProgress()); }
        });
        Ui.margin(this, seek, 0, 4, 0, 0);
        playBar.addView(seek);

        LinearLayout line3 = Ui.row(this);
        npTime = Ui.mono(this, "0:00 / 0:00", 11, Ui.DIM);
        line3.addView(npTime);
        View spring = new View(this);
        spring.setLayoutParams(Ui.lpw(0, 1, 1f));
        line3.addView(spring);
        npRemain = Ui.tv(this, "", 11, Ui.DIM, false);
        line3.addView(npRemain);
        playBar.addView(line3);

        LinearLayout tr = Ui.row(this);
        tr.setGravity(Gravity.CENTER);
        Ui.margin(this, tr, 0, 6, 0, 0);
        tr.addView(Ui.roundBtn(this, Ico.PREV, 20, false, new View.OnClickListener() {
            public void onClick(View v) { eng.prev(); }
        }));
        tr.addView(gapH(10));
        btnPlay = Ui.roundBtn(this, Ico.PAUSE, 22, true, new View.OnClickListener() {
            public void onClick(View v) { eng.togglePause(); }
        });
        tr.addView(btnPlay);
        tr.addView(gapH(10));
        tr.addView(Ui.roundBtn(this, Ico.STOP, 20, false, new View.OnClickListener() {
            public void onClick(View v) { stopProgram(); }
        }));
        tr.addView(gapH(10));
        tr.addView(Ui.roundBtn(this, Ico.NEXT, 20, false, new View.OnClickListener() {
            public void onClick(View v) { eng.next(); }
        }));
        playBar.addView(tr);

        inner.addView(playBar);
        return wrap;
    }

    private View gapH(int w) {
        View v = new View(this);
        v.setLayoutParams(Ui.lp(Ui.dp(this, w), 1));
        return v;
    }

    // ======================================================================
    // running a program
    // ======================================================================
    private void runProgram(int from) {
        Store.script(this, editor.getText().toString());
        Parser.Result r = validate(false);
        if (r.cmds.isEmpty()) {
            toast(r.errors.isEmpty() ? "Write a program first" : "Fix the errors first");
            return;
        }
        if (!r.ok()) { toast("Fix the errors first"); return; }
        if (Store.LIB.isEmpty()) { toast("Add some tracks first"); return; }
        askNotificationPermission();
        eng.start(r.cmds, from);
        startPlaybackService();
    }

    private void previewTrack(int index) {
        askNotificationPermission();
        eng.preview(index);
        startPlaybackService();
    }

    private void startPlaybackService() {
        Intent i = new Intent(this, PlayerService.class).setAction(PlayerService.ACT_ATTACH);
        try { startForegroundService(i); }
        catch (Exception e) { startService(i); }
    }

    private void stopProgram() {
        eng.stop();
        // The engine tells the service it is done; this is only a safety net so
        // a stray notification can never outlive the playback.
        try { stopService(new Intent(this, PlayerService.class)); }
        catch (Exception e) { /* the service already went away */ }
        render(eng.st);
    }

    private void askNotificationPermission() {
        if (Build.VERSION.SDK_INT >= 33
                && checkSelfPermission("android.permission.POST_NOTIFICATIONS") != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(new String[]{ "android.permission.POST_NOTIFICATIONS" }, REQ_NOTIF);
        }
    }

    // ---- engine callbacks ------------------------------------------------
    public void onState(Engine.St s) { render(s); }

    public void onLog(String line) { appendLog(line); }

    public void onFinished(boolean completed) {
        render(eng.st);
        toast(completed ? "Program finished" : "Playback stopped");
    }

    private void render(Engine.St s) {
        boolean run = s.running;
        idleBar.setVisibility(run ? View.GONE : View.VISIBLE);
        playBar.setVisibility(run ? View.VISIBLE : View.GONE);
        if (!run) { highlight(-1); return; }

        npTitle.setText(s.trackTitle);
        npStep.setText(s.stepText);
        npBadge.setText(s.preview ? "PREVIEW" : ("STEP " + (s.step + 1) + "/" + s.steps));
        int max = Math.max(1, s.durMs);
        if (!dragging) {
            seek.setMax(max);
            seek.setProgress(Math.min(s.posMs, max));
        }
        npTime.setText(Fmt.ms(s.posMs) + " / " + Fmt.ms(s.durMs));

        String right = "";
        if (s.stepRemainMs >= 0) right = Fmt.human(s.stepRemainMs) + " left";
        else if (s.repTotal > 0) right = "pass " + Math.min(s.repDone + 1, s.repTotal) + " of " + s.repTotal;
        if (s.progRemainMs > 0) right = right + (right.length() == 0 ? "" : "  -  ") + "~" + Fmt.human(s.progRemainMs) + " to go";
        npRemain.setText(right);

        Ui.setIcon(btnPlay, s.paused ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
        highlight(s.preview ? -1 : s.step);
    }

    // ======================================================================
    // picking files
    // ======================================================================
    private void pickFiles() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("audio/*");
        i.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        i.putExtra(Intent.EXTRA_MIME_TYPES, new String[]{ "audio/*", "application/ogg", "application/x-ogg" });
        i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
        try { startActivityForResult(i, REQ_FILES); }
        catch (Exception e) { toast("No file picker on this device"); }
    }

    private void pickFolder() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
        i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
        try { startActivityForResult(i, REQ_TREE); }
        catch (Exception e) { toast("No folder picker on this device"); }
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
                if (addTrack(u, displayName(u))) added++;
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
        try {
            getContentResolver().takePersistableUriPermission(u, Intent.FLAG_GRANT_READ_URI_PERMISSION);
        } catch (Exception e) { /* some providers do not offer persistable grants */ }
    }

    private boolean addTrack(Uri u, String name) {
        String s = u.toString();
        for (Track t : Store.LIB) if (t.uri.equals(s)) return false;
        Store.LIB.add(new Track(s, name, 0));
        return true;
    }

    private void finishAdding(int added) {
        Store.saveLib(this);
        refreshTracks();
        validate(false);
        toast(added == 0 ? "Nothing new was added" : (added + " track(s) added"));
        readDurations();
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
        toast("Scanning folder...");
        new Thread(new Runnable() {
            public void run() {
                final List<Track> found = new ArrayList<Track>();
                try {
                    collect(tree, DocumentsContract.getTreeDocumentId(tree), found, 0);
                } catch (Exception e) { /* partial results are fine */ }
                Collections.sort(found, new Comparator<Track>() {
                    public int compare(Track a, Track b) { return a.title.compareToIgnoreCase(b.title); }
                });
                final int[] added = { 0 };
                for (Track t : found) if (addTrack(Uri.parse(t.uri), t.title)) added[0]++;
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
                    DocumentsContract.Document.COLUMN_MIME_TYPE }, null, null, null);
            if (c == null) return;
            while (c.moveToNext()) {
                String id = c.getString(0), name = c.getString(1), mime = c.getString(2);
                if (DocumentsContract.Document.MIME_TYPE_DIR.equals(mime)) {
                    collect(tree, id, out, depth + 1);
                } else if (isAudio(name, mime)) {
                    out.add(new Track(DocumentsContract.buildDocumentUriUsingTree(tree, id).toString(), name, 0));
                }
            }
        } catch (Exception e) { /* skip this folder */ }
        finally { if (c != null) c.close(); }
    }

    private boolean isAudio(String name, String mime) {
        if (mime != null && mime.startsWith("audio/")) return true;
        if (name == null) return false;
        String n = name.toLowerCase();
        return n.endsWith(".mp3") || n.endsWith(".m4a") || n.endsWith(".aac") || n.endsWith(".wav")
                || n.endsWith(".ogg") || n.endsWith(".opus") || n.endsWith(".flac") || n.endsWith(".mp4");
    }

    private void readDurations() {
        new Thread(new Runnable() {
            public void run() {
                boolean changed = false;
                for (Track t : Store.LIB) {
                    if (t.durMs > 0) continue;
                    MediaMetadataRetriever mmr = new MediaMetadataRetriever();
                    try {
                        mmr.setDataSource(MainActivity.this, t.toUri());
                        String d = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION);
                        if (d != null) { t.durMs = Long.parseLong(d); changed = true; }
                    } catch (Exception e) { /* unreadable file */ }
                    finally { try { mmr.release(); } catch (Exception e) { } }
                }
                if (!changed) return;
                Store.saveLib(MainActivity.this);
                runOnUiThread(new Runnable() {
                    public void run() { refreshTracks(); validate(false); }
                });
            }
        }).start();
    }

    // ======================================================================
    // dialogs
    // ======================================================================
    private AlertDialog.Builder dialog() {
        return new AlertDialog.Builder(this, Ui.dark ? android.R.style.Theme_Material_Dialog_Alert
                                                     : android.R.style.Theme_Material_Light_Dialog_Alert);
    }

    private void helpDialog() {
        ScrollView sv = new ScrollView(this);
        TextView t = Ui.mono(this, HelpText.TEXT, 11, Ui.TXT);
        int p = Ui.dp(this, 16);
        t.setPadding(p, p, p, p);
        t.setTextIsSelectable(true);
        sv.addView(t, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        dialog().setTitle("Script reference").setView(sv).setPositiveButton("Close", null).show();
    }

    private void saveDialog() {
        final EditText in = new EditText(this);
        in.setHint("name for this program");
        in.setSingleLine(true);
        int p = Ui.dp(this, 20);
        LinearLayout box = Ui.col(this);
        box.setPadding(p, Ui.dp(this, 8), p, 0);
        box.addView(in);
        dialog().setTitle("Save program").setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Save", new android.content.DialogInterface.OnClickListener() {
                    public void onClick(android.content.DialogInterface d, int w) {
                        String name = in.getText().toString().trim();
                        if (name.length() == 0) { toast("Give it a name"); return; }
                        Store.saveProgram(MainActivity.this, name, editor.getText().toString());
                        toast("Saved as " + name);
                    }
                }).show();
    }

    private void loadDialog() {
        final List<String> names = Store.programNames(this);
        if (names.isEmpty()) { toast("Nothing saved yet"); return; }
        LinearLayout box = Ui.col(this);
        int p = Ui.dp(this, 12);
        box.setPadding(p, p, p, p);
        final AlertDialog[] holder = new AlertDialog[1];
        for (int i = 0; i < names.size(); i++) {
            final String name = names.get(i);
            LinearLayout r = Ui.row(this);
            r.setBackground(Ui.ripple(Ui.rr(this, Ui.SURF2, 10)));
            r.setPadding(Ui.dp(this, 12), Ui.dp(this, 10), Ui.dp(this, 4), Ui.dp(this, 10));
            Ui.margin(this, r, 0, 0, 0, 6);
            TextView t = Ui.tv(this, name, 14, Ui.TXT, false);
            t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            Ui.ellipsize(t);
            r.addView(t);
            r.addView(Ui.iconBtn(this, Ico.TRASH, Ui.DIM, 16, new View.OnClickListener() {
                public void onClick(View v) {
                    Store.deleteProgram(MainActivity.this, name);
                    if (holder[0] != null) holder[0].dismiss();
                    toast("Deleted " + name);
                }
            }));
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    editor.setText(Store.program(MainActivity.this, name));
                    validate(false);
                    if (holder[0] != null) holder[0].dismiss();
                    toast("Loaded " + name);
                }
            });
            box.addView(r);
        }
        ScrollView sv = new ScrollView(this);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = dialog().setTitle("Saved programs").setView(sv).setNegativeButton("Close", null).create();
        holder[0].show();
    }

    private void settingsDialog() {
        LinearLayout box = Ui.col(this);
        int p = Ui.dp(this, 18);
        box.setPadding(p, Ui.dp(this, 6), p, 0);

        box.addView(switchRow("Dark theme", prefs.dark(), new OnToggle() {
            public void set(boolean v) { prefs.dark(v); recreate(); }
        }));
        box.addView(switchRow("Keep the screen on", prefs.keepScreenOn(), new OnToggle() {
            public void set(boolean v) {
                prefs.keepScreenOn(v);
                if (v) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                else getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
            }
        }));
        box.addView(switchRow("Hold the CPU awake while a program runs", prefs.wakeLock(), new OnToggle() {
            public void set(boolean v) { prefs.wakeLock(v); }
        }));
        box.addView(switchRow("Pause when headphones are unplugged", prefs.pauseUnplug(), new OnToggle() {
            public void set(boolean v) { prefs.pauseUnplug(v); }
        }));
        box.addView(switchRow("Pause for calls and other apps", prefs.pauseOnFocus(), new OnToggle() {
            public void set(boolean v) { prefs.pauseOnFocus(v); }
        }));
        box.addView(switchRow("Save the program text automatically", prefs.autoSave(), new OnToggle() {
            public void set(boolean v) { prefs.autoSave(v); }
        }));
        box.addView(switchRow("Show the activity log", prefs.showLog(), new OnToggle() {
            public void set(boolean v) {
                prefs.showLog(v);
                logCard.setVisibility(v ? View.VISIBLE : View.GONE);
            }
        }));

        box.addView(Ui.divider(this));
        box.addView(sliderRow("Master volume", 0, 100, prefs.volume(), "%", new OnSlide() {
            public void set(int v) { prefs.volume(v); eng.setMasterVolume(v); }
        }));
        box.addView(sliderRow("Playback speed", 50, 200, prefs.speedPct(), "%", new OnSlide() {
            public void set(int v) { prefs.speedPct(v); eng.setMasterSpeed(v); }
        }));
        box.addView(sliderRow("Fade at loop edges", 0, 1000, prefs.fadeMs(), " ms", new OnSlide() {
            public void set(int v) { prefs.fadeMs(v); }
        }));

        box.addView(Ui.divider(this));
        box.addView(Ui.btn(this, "Reset settings to defaults", 0, Ui.DANGER, new View.OnClickListener() {
            public void onClick(View v) {
                prefs.resetAll();
                toast("Settings reset");
                recreate();
            }
        }));
        box.addView(Ui.gap(this, 6));
        box.addView(Ui.tv(this, "Riola 3.0  -  no ads, no network, no accounts.", 11, Ui.DIM, false));
        box.addView(Ui.gap(this, 6));

        ScrollView sv = new ScrollView(this);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        dialog().setTitle("Settings").setView(sv).setPositiveButton("Done", null).show();
    }

    private interface OnToggle { void set(boolean v); }
    private interface OnSlide  { void set(int v); }

    private View switchRow(String label, boolean value, final OnToggle cb) {
        LinearLayout r = Ui.row(this);
        Ui.margin(this, r, 0, 4, 0, 4);
        TextView t = Ui.tv(this, label, 14, Ui.TXT, false);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(t);
        Switch s = new Switch(this);
        s.setChecked(value);
        s.setOnCheckedChangeListener(new android.widget.CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(android.widget.CompoundButton b, boolean v) { cb.set(v); }
        });
        r.addView(s);
        return r;
    }

    private View sliderRow(String label, final int min, int max, int value, final String unit, final OnSlide cb) {
        LinearLayout c = Ui.col(this);
        Ui.margin(this, c, 0, 6, 0, 2);
        LinearLayout head = Ui.row(this);
        TextView t = Ui.tv(this, label, 14, Ui.TXT, false);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(t);
        final TextView val = Ui.mono(this, value + unit, 12, Ui.ACC);
        head.addView(val);
        c.addView(head);
        SeekBar s = new SeekBar(this);
        s.setMax(max - min);
        s.setProgress(Math.max(0, value - min));
        s.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        s.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        s.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        s.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int p, boolean fromUser) {
                val.setText((min + p) + unit);
            }
            public void onStartTrackingTouch(SeekBar b) { }
            public void onStopTrackingTouch(SeekBar b) { cb.set(min + b.getProgress()); }
        });
        c.addView(s);
        return c;
    }

    private void toast(String s) { Toast.makeText(this, s, Toast.LENGTH_SHORT).show(); }
}
'@

# ---------------------------------------------------------------------------
# Java: the A-B section picker
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\AbDialog.java" @'
package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.os.Handler;
import android.os.Looper;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Listen to the track, mark A and B by ear, then drop a ready made SECTION
 * line into the program.
 */
public final class AbDialog {

    public interface OnInsert { void insert(String line); }

    private AbDialog() { }

    public static void show(final Activity act, final int index, final OnInsert cb) {
        if (index < 0 || index >= Store.LIB.size()) return;
        final Track track = Store.LIB.get(index);

        final Engine eng = Engine.get(act);
        if (eng.isRunning()) eng.stop();

        final long[] a = { 0 };
        final long[] b = { -1 };
        final boolean[] ready = { false };
        final boolean[] loopAb = { true };
        final MediaPlayer mp = new MediaPlayer();
        final Handler h = new Handler(Looper.getMainLooper());

        LinearLayout box = Ui.col(act);
        int p = Ui.dp(act, 18);
        box.setPadding(p, Ui.dp(act, 6), p, 0);

        final TextView clock = Ui.mono(act, "0:00 / 0:00", 13, Ui.ACC);
        clock.setGravity(Gravity.CENTER);
        clock.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(clock);

        final SeekBar bar = new SeekBar(act);
        bar.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        bar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        bar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        box.addView(bar);

        final TextView aTv = Ui.mono(act, "A  0:00", 13, Ui.TXT);
        final TextView bTv = Ui.mono(act, "B  end", 13, Ui.TXT);

        // transport
        LinearLayout tr = Ui.row(act);
        tr.setGravity(Gravity.CENTER);
        final ImageView play = Ui.roundBtn(act, Ico.PLAY, 20, true, null);
        tr.addView(nudge(act, "-5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, -5000); }
        }));
        tr.addView(play);
        tr.addView(nudge(act, "+5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, 5000); }
        }));
        Ui.margin(act, tr, 0, 6, 0, 6);
        box.addView(tr);

        play.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (!ready[0]) return;
                try {
                    if (mp.isPlaying()) { mp.pause(); Ui.setIcon(play, Ico.PLAY, Ui.ONACC); }
                    else { mp.start(); Ui.setIcon(play, Ico.PAUSE, Ui.ONACC); }
                } catch (IllegalStateException e) { /* ignore */ }
            }
        });

        // A and B rows
        box.addView(markRow(act, aTv, new View.OnClickListener() {
            public void onClick(View v) {
                a[0] = position(mp, ready);
                if (b[0] >= 0 && b[0] <= a[0]) b[0] = -1;
                aTv.setText("A  " + Fmt.ms(a[0]));
                bTv.setText("B  " + (b[0] < 0 ? "end" : Fmt.ms(b[0])));
            }
        }, new Nudge() {
            public void by(int ms) {
                a[0] = Math.max(0, a[0] + ms);
                aTv.setText("A  " + Fmt.ms(a[0]));
            }
        }));

        box.addView(markRow(act, bTv, new View.OnClickListener() {
            public void onClick(View v) {
                long pos = position(mp, ready);
                if (pos <= a[0]) { toast(act, "B must come after A"); return; }
                b[0] = pos;
                bTv.setText("B  " + Fmt.ms(b[0]));
            }
        }, new Nudge() {
            public void by(int ms) {
                if (b[0] < 0) return;
                b[0] = Math.max(a[0] + 500, b[0] + ms);
                bTv.setText("B  " + Fmt.ms(b[0]));
            }
        }));

        // loop while auditioning
        LinearLayout loopRow = Ui.row(act);
        TextView loopLbl = Ui.tv(act, "Loop A-B while listening", 13, Ui.DIM, false);
        loopLbl.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        loopRow.addView(loopLbl);
        Switch loopSw = new Switch(act);
        loopSw.setChecked(true);
        loopSw.setOnCheckedChangeListener(new android.widget.CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(android.widget.CompoundButton c, boolean v) { loopAb[0] = v; }
        });
        loopRow.addView(loopSw);
        box.addView(loopRow);

        box.addView(Ui.divider(act));

        // repeat spec for the generated line
        LinearLayout spec = Ui.row(act);
        TextView specLbl = Ui.tv(act, "Repeat", 13, Ui.DIM, false);
        specLbl.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        spec.addView(specLbl);
        final EditText count = new EditText(act);
        count.setInputType(InputType.TYPE_CLASS_NUMBER);
        count.setText("4");
        count.setSingleLine(true);
        count.setWidth(Ui.dp(act, 64));
        count.setGravity(Gravity.CENTER);
        spec.addView(count);
        final Switch asMinutes = new Switch(act);
        asMinutes.setText("minutes");
        asMinutes.setTextColor(Ui.DIM);
        spec.addView(asMinutes);
        box.addView(spec);
        box.addView(Ui.tv(act, "Off = repeat that many times. On = keep looping for that many minutes.",
                11, Ui.DIM, false));
        box.addView(Ui.gap(act, 8));

        ScrollView sv = new ScrollView(act);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        AlertDialog.Builder bld = new AlertDialog.Builder(act,
                Ui.dark ? android.R.style.Theme_Material_Dialog_Alert
                        : android.R.style.Theme_Material_Light_Dialog_Alert);
        final AlertDialog dlg = bld.setTitle(track.shortTitle())
                .setView(sv)
                .setNegativeButton("Close", null)
                .setPositiveButton("Insert line", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        int n;
                        try { n = Integer.parseInt(count.getText().toString().trim()); }
                        catch (NumberFormatException e) { n = 1; }
                        if (n < 1) n = 1;
                        String line = "SECTION " + index + " " + Fmt.ms(a[0]) + " "
                                + (b[0] < 0 ? "END" : Fmt.ms(b[0]));
                        line = line + (asMinutes.isChecked() ? (" FOR " + n + " MIN") : (" x" + n));
                        cb.insert(line);
                    }
                }).create();

        final Runnable tick = new Runnable() {
            public void run() {
                if (ready[0]) {
                    int pos = position(mp, ready);
                    int dur = duration(mp, ready);
                    if (!bar.isPressed()) bar.setProgress(pos);
                    clock.setText(Fmt.ms(pos) + " / " + Fmt.ms(dur));
                    if (loopAb[0] && b[0] > 0 && pos >= b[0]) {
                        try { mp.seekTo((int) a[0]); } catch (IllegalStateException e) { /* ignore */ }
                    }
                    boolean playing = false;
                    try { playing = mp.isPlaying(); } catch (IllegalStateException e) { /* ignore */ }
                    Ui.setIcon(play, playing ? Ico.PAUSE : Ico.PLAY, Ui.ONACC);
                }
                h.postDelayed(this, 200);
            }
        };

        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int prog, boolean fromUser) {
                if (fromUser && ready[0]) {
                    try { mp.seekTo(prog); } catch (IllegalStateException e) { /* ignore */ }
                }
            }
            public void onStartTrackingTouch(SeekBar s) { }
            public void onStopTrackingTouch(SeekBar s) { }
        });

        dlg.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public void onDismiss(DialogInterface d) {
                h.removeCallbacks(tick);
                try { mp.reset(); } catch (Exception e) { /* ignore */ }
                try { mp.release(); } catch (Exception e) { /* ignore */ }
            }
        });

        try {
            mp.setAudioAttributes(new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build());
            mp.setDataSource(act, track.toUri());
            mp.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                public void onPrepared(MediaPlayer m) {
                    ready[0] = true;
                    bar.setMax(Math.max(1, m.getDuration()));
                    clock.setText("0:00 / " + Fmt.ms(m.getDuration()));
                }
            });
            mp.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                public boolean onError(MediaPlayer m, int what, int extra) {
                    toast(act, "Cannot play this file");
                    return true;
                }
            });
            mp.prepareAsync();
        } catch (Exception e) {
            toast(act, "Cannot open this file");
        }

        dlg.show();
        h.postDelayed(tick, 200);
    }

    private interface Nudge { void by(int ms); }

    private static View markRow(Activity act, TextView label, View.OnClickListener setNow, final Nudge n) {
        LinearLayout r = Ui.row(act);
        Ui.margin(act, r, 0, 2, 0, 2);
        label.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(label);
        r.addView(nudge(act, "-1s", new View.OnClickListener() {
            public void onClick(View v) { n.by(-1000); }
        }));
        r.addView(nudge(act, "+1s", new View.OnClickListener() {
            public void onClick(View v) { n.by(1000); }
        }));
        View set = Ui.btn(act, "set", 0, Ui.SECONDARY, setNow);
        Ui.margin(act, set, 6, 0, 0, 0);
        r.addView(set);
        return r;
    }

    private static View nudge(Activity act, String text, View.OnClickListener l) {
        TextView t = Ui.tv(act, text, 12, Ui.ACC, true);
        t.setPadding(Ui.dp(act, 10), Ui.dp(act, 8), Ui.dp(act, 10), Ui.dp(act, 8));
        t.setBackground(Ui.ripple(Ui.rrs(act, Ui.SURF2, Ui.LINE, 10, 1)));
        t.setOnClickListener(l);
        LinearLayout.LayoutParams lp = Ui.lp(Ui.WRAP, Ui.WRAP);
        lp.setMargins(Ui.dp(act, 4), 0, Ui.dp(act, 4), 0);
        t.setLayoutParams(lp);
        return t;
    }

    private static void seekBy(MediaPlayer mp, boolean[] ready, int delta) {
        if (!ready[0]) return;
        try { mp.seekTo(Math.max(0, mp.getCurrentPosition() + delta)); }
        catch (IllegalStateException e) { /* ignore */ }
    }

    private static int position(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getCurrentPosition()); } catch (IllegalStateException e) { return 0; }
    }

    private static int duration(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getDuration()); } catch (IllegalStateException e) { return 0; }
    }

    private static void toast(Activity act, String s) {
        Toast.makeText(act, s, Toast.LENGTH_SHORT).show();
    }
}
'@

# ---------------------------------------------------------------------------
# 2. Compile
# ---------------------------------------------------------------------------
if ($SourcesOnly) {
    Ok "`nSources written to $OutDir (build skipped: -SourcesOnly)"
    exit 0
}

Say "`n[2/3] building"
# Native tools write progress and notes to stderr; that is not a failure here.
# Success is decided by the exit code (Assert-Exit) instead.
$ErrorActionPreference = 'Continue'
Push-Location $OutDir
try {
    Remove-Item -LiteralPath '.\unaligned.apk', '.\classes.dex', '.\compiled_res.zip', ".\$ApkName", ".\$ApkName.idsig" `
                -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path ".\$PKG_PATH" -Filter *.class -ErrorAction SilentlyContinue | Remove-Item -Force

    # 1. resources -> flat archive
    aapt2 compile --dir res -o compiled_res.zip
    Assert-Exit 'aapt2 compile (resources)'

    # 2. link resources + manifest, emit R.java
    aapt2 link -I $AndroidJar --manifest AndroidManifest.xml -R compiled_res.zip `
               --java . --auto-add-overlay -o unaligned.apk
    Assert-Exit 'aapt2 link'

    # 3. java -> class  (framework classes come from android.jar only)
    #    javac talks on stderr even when it succeeds, so it runs through cmd
    #    with an @argfile and its output is kept in javac.log.
    Get-ChildItem -Path ".\$PKG_PATH" -Filter *.java |
        ForEach-Object { '"' + $_.FullName.Replace([char]92, [char]47) + '"' } |
        Out-File -LiteralPath 'javac.args' -Encoding ASCII
    cmd /c "javac -nowarn -Xlint:-options -source 8 -target 8 -bootclasspath ""$AndroidJar"" -encoding US-ASCII @javac.args > javac.log 2>&1"
    if ($LASTEXITCODE -ne 0) { Get-Content -LiteralPath 'javac.log' | Write-Host }
    Assert-Exit 'javac'

    # 4. class -> dex
    $classes = Get-ChildItem -Path ".\$PKG_PATH" -Filter *.class | ForEach-Object { $_.FullName }
    d8.bat --lib $AndroidJar --min-api 26 --output . @classes
    Assert-Exit 'd8'

    # 5. add the dex to the apk
    jar.exe uf unaligned.apk classes.dex
    Assert-Exit 'jar (add classes.dex)'

    # 6. align, then sign (signing preserves the alignment)
    zipalign.exe -f 4 unaligned.apk $ApkName
    Assert-Exit 'zipalign'

    apksigner.bat sign --ks $Keystore --ks-pass pass:android --ks-key-alias androiddebugkey `
                       --key-pass pass:android --min-sdk-version 26 $ApkName
    Assert-Exit 'apksigner sign'

    apksigner.bat verify --min-sdk-version 26 $ApkName
    Assert-Exit 'apksigner verify'

    $apk = Get-Item $ApkName
    Say "`n[3/3] done"
    Ok  ("  APK   : " + $apk.FullName)
    Ok  ("  size  : " + [math]::Round($apk.Length / 1KB, 1) + " KB")

    if ($Install) {
        Say "`n[install] adb install -r"
        adb install -r $apk.FullName
        Assert-Exit 'adb install'
    } else {
        Write-Host ""
        Write-Host "  Copy it to the phone and open it, or run:" -ForegroundColor DarkGray
        Write-Host ("    adb install -r `"" + $apk.FullName + "`"") -ForegroundColor DarkGray
    }
}
finally {
    Pop-Location
}
