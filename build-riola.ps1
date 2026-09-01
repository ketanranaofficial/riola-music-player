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
    [string] $OutDir      = '',
    [string] $ApkName     = 'riola.apk',
    [switch] $SourcesOnly,
    [switch] $Install,
    [switch] $Clean,

    # Release signing. Without these the apk is signed with the debug key,
    # which is fine for your own phone and useless for a store.
    [switch] $Release,
    [string] $Keystore    = '',
    [string] $KeyAlias    = '',
    [string] $StorePass   = '',
    [string] $KeyPass     = '',

    # Play requires new apps to target a recent api. Leave this at 0 and the
    # build targets the newest platform installed in the sdk.
    [int]    $TargetSdk   = 0,
    [int]    $VersionCode = 4,
    [string] $VersionName = '1.0'
)

$ErrorActionPreference = 'Stop'
$PKG      = 'com.riola.player'
$PKG_PATH = 'com\riola\player'

# $PSScriptRoot is empty when the script is piped in or invoked oddly, so fall
# back to the working directory.
if (-not $OutDir -or $OutDir.Length -eq 0) {
    $base = $PSScriptRoot
    if (-not $base -or $base.Length -eq 0) {
        try { $base = Split-Path -Parent $MyInvocation.MyCommand.Path } catch { $base = '' }
    }
    if (-not $base -or $base.Length -eq 0) { $base = (Get-Location).Path }
    $OutDir = Join-Path $base 'riola'
}

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

# Compile against the newest platform present, unless told otherwise.
$platforms = Get-ChildItem -Path (Join-Path $env:ANDROID_HOME 'platforms') -Directory -ErrorAction SilentlyContinue |
             Where-Object { $_.Name -match '^android-(\d+)$' } |
             Sort-Object { [int]($_.Name -replace 'android-', '') }
if (-not $platforms) { Die "No android platform found under $env:ANDROID_HOME\platforms" }
$newest = [int](($platforms | Select-Object -Last 1).Name -replace 'android-', '')
if ($TargetSdk -le 0) { $TargetSdk = $newest }
if ($TargetSdk -gt $newest) {
    Warn "Asked to target android-$TargetSdk but the newest installed is android-$newest."
    Warn "Install it with:  sdkmanager `"platforms;android-$TargetSdk`""
    Die  "Missing platform android-$TargetSdk"
}
$AndroidJar = Join-Path $env:ANDROID_HOME "platforms\android-$TargetSdk\android.jar"
if (-not (Test-Path $AndroidJar)) { Die "Missing $AndroidJar" }

$btRoot = Join-Path $env:ANDROID_HOME 'build-tools'
$bt = Get-ChildItem -Path $btRoot -Directory -ErrorAction SilentlyContinue |
      Sort-Object { [version]($_.Name -replace '[^0-9\.].*$','0') } | Select-Object -Last 1
if (-not $bt) { Die "No build-tools found under $btRoot" }
$btPath = $bt.FullName
if ($env:PATH -notlike "*$btPath*") { $env:PATH = "$btPath;$env:PATH" }

if ($Release) {
    if (-not $Keystore -or -not (Test-Path $Keystore)) {
        Die "-Release needs -Keystore pointing at your upload key. See RELEASING.md."
    }
    if (-not $KeyAlias)  { Die "-Release needs -KeyAlias." }
    if (-not $StorePass) { $StorePass = $env:RIOLA_STOREPASS }
    if (-not $KeyPass)   { $KeyPass   = if ($env:RIOLA_KEYPASS) { $env:RIOLA_KEYPASS } else { $StorePass } }
    if (-not $StorePass) { Die "-Release needs -StorePass, or the RIOLA_STOREPASS environment variable." }
} else {
    $Keystore  = Join-Path $env:USERPROFILE '.android\debug.keystore'
    $KeyAlias  = 'androiddebugkey'
    $StorePass = 'android'
    $KeyPass   = 'android'
}

if (-not $Release -and -not (Test-Path $Keystore)) {
    Warn "No debug keystore - creating one..."
    New-Item -ItemType Directory -Force -Path (Split-Path $Keystore -Parent) | Out-Null
    keytool -genkeypair -v -keystore $Keystore -storepass android -keypass android `
            -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10950 `
            -dname "CN=Android Debug,O=Android,C=US" | Out-Null
    Assert-Exit 'keytool (create debug keystore)'
}

Write-Host ("  SDK          : " + $env:ANDROID_HOME)
Write-Host ("  build-tools  : " + $bt.Name)
Write-Host ("  platform jar : android-" + $TargetSdk)
Write-Host ("  version      : " + $VersionName + " (" + $VersionCode + ")")
Write-Host ("  signing      : " + $(if ($Release) { "release key $KeyAlias" } else { "debug key" }))
Write-Host ("  out dir      : " + $OutDir)

# ---------------------------------------------------------------------------
# 1. Prepare output tree
# ---------------------------------------------------------------------------
if ($Clean -and (Test-Path $OutDir)) { Say "`n[clean] removing $OutDir"; Remove-Item -Recurse -Force $OutDir }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

# The generated tree is rewritten from scratch every run, so a source file that
# this script no longer emits can never linger and break the build.
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $OutDir $PKG_PATH)
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $OutDir 'res')

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
Write-Src 'AndroidManifest.xml' @"
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.riola.player"
    android:versionCode="$VersionCode"
    android:versionName="$VersionName">

    <uses-sdk android:minSdkVersion="26" android:targetSdkVersion="$TargetSdk" />

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

        <activity
            android:name=".EditorActivity"
            android:exported="false"
            android:parentActivityName=".MainActivity"
            android:configChanges="orientation|screenSize|keyboardHidden|screenLayout|smallestScreenSize|uiMode"
            android:windowSoftInputMode="adjustResize" />

        <activity
            android:name=".LibraryActivity"
            android:exported="false"
            android:parentActivityName=".MainActivity"
            android:configChanges="orientation|screenSize|keyboardHidden|screenLayout|smallestScreenSize|uiMode"
            android:windowSoftInputMode="adjustResize" />

        <activity
            android:name=".NowPlayingActivity"
            android:exported="false"
            android:parentActivityName=".MainActivity"
            android:configChanges="orientation|screenSize|keyboardHidden|screenLayout|smallestScreenSize|uiMode" />

        <service
            android:name=".PlayerService"
            android:exported="false"
            android:foregroundServiceType="mediaPlayback" />
    </application>
</manifest>
"@

# ---------------------------------------------------------------------------
# Resources (app name, launcher icon, notification icons)
# ---------------------------------------------------------------------------
Write-Src 'res\values\strings.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Riola</string>
</resources>
'@

Write-Src 'res\values\styles.xml' @'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- The stock dialog scrim is barely there, which makes a modal sheet read
         as part of the page behind it. -->
    <style name="RiolaDialog" parent="@android:style/Theme.Material.Dialog.Alert">
        <item name="android:backgroundDimAmount">0.62</item>
    </style>
    <style name="RiolaDialogLight" parent="@android:style/Theme.Material.Light.Dialog.Alert">
        <item name="android:backgroundDimAmount">0.55</item>
    </style>
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
# Java: model and storage
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

    /** 45 sec / 3 min / 1 hr 5 min - for compact captions. */
    public static String rough(long v) {
        if (v <= 0) return "0 min";
        long t = (v + 500L) / 1000L;
        long h = t / 3600L, m = (t % 3600L) / 60L, s = t % 60L;
        if (h > 0) return m > 0 ? (h + " hr " + m + " min") : (h + " hr");
        if (m > 0) return m + " min";
        return s + " sec";
    }

    public static String two(long v) { return v < 10 ? "0" + v : Long.toString(v); }

    /** 1.25 -> "1.25x" without locale surprises. */
    public static String speed(int pct) {
        return (pct / 100) + "." + two(pct % 100) + "x";
    }

    public static String ago(long when) {
        if (when <= 0) return "never";
        long d = System.currentTimeMillis() - when;
        if (d < 60000L) return "just now";
        if (d < 3600000L) return (d / 60000L) + " min ago";
        if (d < 86400000L) return (d / 3600000L) + " hr ago";
        long days = d / 86400000L;
        return days == 1 ? "yesterday" : (days + " days ago");
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
'@

Write-Src "$PKG_PATH\Step.java" @'
package com.riola.player;

import org.json.JSONObject;

/** One step of a program. Tracks are referenced by uri so reordering the library is safe. */
public class Step {

    public static final int PLAY = 0, SECTION = 1, SILENCE = 2, BELL = 3;

    public int type = PLAY;
    public String trackUri = "";
    public String trackName = "";   // remembered so a missing file still reads sensibly
    public long a = 0;              // section start
    public long b = -1;             // section end, -1 = end of track
    public int times = 1;           // -1 = run until durMs is used up; strikes for a bell
    public long durMs = 0;          // silence length, or the time budget when times < 0
    public long gapMs = 0;          // rest between repeats / between bell strikes
    public int speedPct = 100;
    public int volumePct = 100;
    public int tone = Bell.WARM;    // bell voice
    public boolean endBell = false; // a silence can chime when it finishes
    public boolean enabled = true;

    public static Step play(Track t) {
        Step s = new Step();
        s.type = PLAY;
        s.bind(t);
        return s;
    }

    public static Step section(Track t, long a, long b) {
        Step s = new Step();
        s.type = SECTION;
        s.bind(t);
        s.a = a;
        s.b = b;
        return s;
    }

    public static Step silence(long ms) {
        Step s = new Step();
        s.type = SILENCE;
        s.durMs = ms;
        return s;
    }

    public static Step bell() {
        Step s = new Step();
        s.type = BELL;
        s.tone = Bell.WARM;
        s.times = 1;
        s.gapMs = 4000;
        return s;
    }

    public void bind(Track t) {
        if (t == null) return;
        trackUri = t.uri;
        trackName = t.shortTitle();
    }

    public boolean needsTrack() { return type == PLAY || type == SECTION; }

    public Track track() {
        if (!needsTrack()) return null;
        Track t = Store.byUri(trackUri);
        return t;
    }

    /** Gone from the library, or the file itself could not be opened last time we looked. */
    public boolean missing() {
        return needsTrack() && (track() == null || Store.MISSING.contains(trackUri));
    }

    public boolean timed() { return times < 0; }

    public String title() {
        if (type == SILENCE) return "Silence";
        if (type == BELL) return "Bell";
        Track t = track();
        if (t != null) return t.shortTitle();
        return (trackName == null || trackName.length() == 0) ? "Missing track" : trackName;
    }

    /** The one line under the title in the step list. */
    public String detail() {
        StringBuilder sb = new StringBuilder();
        if (type == SILENCE) {
            sb.append("rest for ").append(Fmt.rough(durMs));
            if (endBell) sb.append("  .  ").append(Bell.toneName(tone)).append(" bell at the end");
            return sb.toString();
        }
        if (type == BELL) {
            sb.append(Bell.toneName(tone)).append(" tone");
            int n = Math.max(1, times);
            if (n > 1) {
                sb.append("  .  ").append(n).append(" rings");
                if (gapMs > 0) sb.append(" every ").append(Fmt.rough(gapMs));
            }
            if (volumePct != 100) sb.append("  .  vol ").append(volumePct).append("%");
            return sb.toString();
        }
        if (type == SECTION) sb.append(Fmt.ms(a)).append(" - ").append(b < 0 ? "end" : Fmt.ms(b));
        else sb.append("whole track");
        sb.append("  .  ");
        if (timed()) sb.append("loop for ").append(Fmt.rough(durMs));
        else sb.append(times == 1 ? "once" : (times + " times"));
        if (gapMs > 0) sb.append("  .  ").append(Fmt.rough(gapMs)).append(" gap");
        if (speedPct != 100) sb.append("  .  ").append(Fmt.speed(speedPct));
        if (volumePct != 100) sb.append("  .  vol ").append(volumePct).append("%");
        return sb.toString();
    }

    public long lengthMs() {
        Track t = track();
        long full = t == null ? 0 : t.durMs;
        if (type == SECTION) {
            long end = b < 0 ? full : b;
            return Math.max(0, end - a);
        }
        return full;
    }

    /** Estimated wall clock time for this step. */
    public long estMs() {
        if (!enabled) return 0;
        if (type == SILENCE) return durMs;
        if (type == BELL) {
            int n = Math.max(1, times);
            return Bell.lengthMs(tone) * n + gapMs * Math.max(0, n - 1);
        }
        if (timed()) return durMs;
        long one = lengthMs();
        if (speedPct > 0 && speedPct != 100) one = one * 100L / speedPct;
        int n = Math.max(1, times);
        return one * n + gapMs * Math.max(0, n - 1);
    }

    public Step copy() {
        Step s = new Step();
        s.type = type; s.trackUri = trackUri; s.trackName = trackName;
        s.a = a; s.b = b; s.times = times; s.durMs = durMs; s.gapMs = gapMs;
        s.speedPct = speedPct; s.volumePct = volumePct; s.tone = tone;
        s.endBell = endBell; s.enabled = enabled;
        return s;
    }

    public JSONObject toJson() throws Exception {
        JSONObject o = new JSONObject();
        o.put("ty", type);
        o.put("u", trackUri);
        o.put("n", trackName);
        o.put("a", a);
        o.put("b", b);
        o.put("x", times);
        o.put("d", durMs);
        o.put("g", gapMs);
        o.put("sp", speedPct);
        o.put("vo", volumePct);
        o.put("to", tone);
        o.put("eb", endBell);
        o.put("en", enabled);
        return o;
    }

    public static Step fromJson(JSONObject o) {
        Step s = new Step();
        s.type = o.optInt("ty", PLAY);
        s.trackUri = o.optString("u", "");
        s.trackName = o.optString("n", "");
        s.a = o.optLong("a", 0);
        s.b = o.optLong("b", -1);
        s.times = o.optInt("x", 1);
        s.durMs = o.optLong("d", 0);
        s.gapMs = o.optLong("g", 0);
        s.speedPct = o.optInt("sp", 100);
        s.volumePct = o.optInt("vo", 100);
        s.tone = o.optInt("to", Bell.WARM);
        s.endBell = o.optBoolean("eb", false);
        s.enabled = o.optBoolean("en", true);
        return s;
    }
}
'@

Write-Src "$PKG_PATH\Program.java" @'
package com.riola.player;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/** A named list of steps. */
public class Program {

    public String id;
    public String name;
    public final List<Step> steps = new ArrayList<Step>();
    public int loops = 1;          // -1 = keep repeating the whole program
    public long updated;
    public long lastRun;

    public Program(String id, String name) {
        this.id = id;
        this.name = name;
        this.updated = System.currentTimeMillis();
    }

    public static Program blank(String name) {
        return new Program(Long.toHexString(System.currentTimeMillis()) + Integer.toHexString((int) (Math.random() * 65536)), name);
    }

    public int enabledCount() {
        int n = 0;
        for (int i = 0; i < steps.size(); i++) if (steps.get(i).enabled) n++;
        return n;
    }

    /** One pass through the enabled steps. */
    public long passMs() {
        long t = 0;
        for (int i = 0; i < steps.size(); i++) t += steps.get(i).estMs();
        return t;
    }

    public long estMs() {
        return passMs() * (loops < 0 ? 1 : Math.max(1, loops));
    }

    public boolean hasMissing() {
        for (int i = 0; i < steps.size(); i++) if (steps.get(i).enabled && steps.get(i).missing()) return true;
        return false;
    }

    public String summary() {
        int n = enabledCount();
        if (n == 0) return "no steps yet";
        String s = n + (n == 1 ? " step" : " steps");
        long t = estMs();
        if (t > 0) s = s + "  .  " + (loops < 0 ? "repeats forever" : ("about " + Fmt.rough(t)));
        else if (loops < 0) s = s + "  .  repeats forever";
        if (loops > 1) s = s + "  .  " + loops + " loops";
        return s;
    }

    public Program copyAs(String newName) {
        Program p = Program.blank(newName);
        p.loops = loops;
        for (int i = 0; i < steps.size(); i++) p.steps.add(steps.get(i).copy());
        return p;
    }

    public JSONObject toJson() throws Exception {
        JSONObject o = new JSONObject();
        o.put("id", id);
        o.put("nm", name);
        o.put("lp", loops);
        o.put("up", updated);
        o.put("lr", lastRun);
        JSONArray arr = new JSONArray();
        for (int i = 0; i < steps.size(); i++) arr.put(steps.get(i).toJson());
        o.put("st", arr);
        return o;
    }

    public static Program fromJson(JSONObject o) {
        Program p = new Program(o.optString("id", Long.toHexString(System.nanoTime())),
                                o.optString("nm", "Program"));
        p.loops = o.optInt("lp", 1);
        p.updated = o.optLong("up", 0);
        p.lastRun = o.optLong("lr", 0);
        JSONArray arr = o.optJSONArray("st");
        if (arr != null) {
            for (int i = 0; i < arr.length(); i++) {
                JSONObject s = arr.optJSONObject(i);
                if (s != null) p.steps.add(Step.fromJson(s));
            }
        }
        return p;
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
'@

Write-Src "$PKG_PATH\Store.java" @'
package com.riola.player;

import android.content.Context;
import android.content.SharedPreferences;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

/** Persistent state: the track library and the saved programs. */
public final class Store {

    /** Shared by every screen and by the playback engine (one process). */
    public static final CopyOnWriteArrayList<Track> LIB = new CopyOnWriteArrayList<Track>();
    public static final CopyOnWriteArrayList<Program> PROGRAMS = new CopyOnWriteArrayList<Program>();

    /**
     * Uris that were in the library but could not be opened. A file can vanish
     * without leaving the library: deleted, on a card that was pulled, or the
     * permission grant was revoked. Filled in by the pre-play check and by the
     * engine, and used to mark steps as missing.
     */
    public static final Set<String> MISSING = Collections.synchronizedSet(new HashSet<String>());

    private static boolean loaded = false;

    private Store() { }

    private static SharedPreferences sp(Context c) {
        return c.getApplicationContext().getSharedPreferences(Prefs.FILE, Context.MODE_PRIVATE);
    }

    public static synchronized void load(Context c) {
        if (loaded) return;
        loaded = true;
        LIB.clear();
        PROGRAMS.clear();
        try {
            JSONArray arr = new JSONArray(sp(c).getString("lib", "[]"));
            for (int i = 0; i < arr.length(); i++) {
                JSONObject o = arr.getJSONObject(i);
                Track t = new Track(o.getString("u"), o.optString("t", "track"), o.optLong("d", 0));
                t.audioTrack = o.optInt("a", -1);
                t.addedAt = o.optLong("ad", 0);
                t.modifiedAt = o.optLong("md", 0);
                LIB.add(t);
            }
        } catch (Exception e) { LIB.clear(); }
        dedupe();
        try {
            JSONArray arr = new JSONArray(sp(c).getString("programs", "[]"));
            for (int i = 0; i < arr.length(); i++) {
                JSONObject o = arr.optJSONObject(i);
                if (o != null) PROGRAMS.add(Program.fromJson(o));
            }
        } catch (Exception e) { PROGRAMS.clear(); }
        sortPrograms();
    }

    // ---- library ---------------------------------------------------------
    /**
     * One entry per real file. Older versions keyed only on the exact uri, so a
     * file added twice through different routes could sit in the list twice.
     */
    public static void dedupe() {
        java.util.HashSet<String> seen = new java.util.HashSet<String>();
        List<Track> keep = new java.util.ArrayList<Track>();
        for (Track t : LIB) if (seen.add(t.key())) keep.add(t);
        if (keep.size() == LIB.size()) return;
        LIB.clear();
        LIB.addAll(keep);
    }

    /** Finds a track however its uri happens to be spelled. */
    public static Track byKey(String key) {
        for (Track t : LIB) if (t.key().equals(key)) return t;
        return null;
    }

    public static Track byUri(String uri) {
        if (uri == null || uri.length() == 0) return null;
        for (Track t : LIB) if (uri.equals(t.uri)) return t;
        return null;
    }

    public static int indexOf(String uri) {
        for (int i = 0; i < LIB.size(); i++) if (LIB.get(i).uri.equals(uri)) return i;
        return -1;
    }

    /**
     * Can this file still be opened right now? Cheap enough to run over a
     * program's steps before playing it. Remembers the answer in MISSING so the
     * lists can mark the step without doing io on every redraw.
     */
    public static boolean readable(Context c, String uri) {
        Track t = byUri(uri);
        if (t == null) return false;
        java.io.InputStream in = null;
        try {
            in = c.getContentResolver().openInputStream(t.toUri());
            boolean ok = in != null;
            if (ok) MISSING.remove(uri);
            else MISSING.add(uri);
            return ok;
        } catch (Exception e) {
            MISSING.add(uri);
            return false;
        } finally {
            if (in != null) try { in.close(); } catch (Exception e) { /* ignore */ }
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
                o.put("a", t.audioTrack);
                o.put("ad", t.addedAt);
                o.put("md", t.modifiedAt);
                arr.put(o);
            } catch (Exception e) { /* skip this one */ }
        }
        sp(c).edit().putString("lib", arr.toString()).apply();
    }

    // ---- programs --------------------------------------------------------
    public static void sortPrograms() {
        List<Program> copy = new java.util.ArrayList<Program>(PROGRAMS);
        Collections.sort(copy, new Comparator<Program>() {
            public int compare(Program x, Program y) {
                long a = Math.max(x.updated, x.lastRun), b = Math.max(y.updated, y.lastRun);
                return a == b ? 0 : (a > b ? -1 : 1);
            }
        });
        PROGRAMS.clear();
        PROGRAMS.addAll(copy);
    }

    public static Program program(String id) {
        if (id == null) return null;
        for (Program p : PROGRAMS) if (p.id.equals(id)) return p;
        return null;
    }

    public static void put(Context c, Program p) {
        p.updated = System.currentTimeMillis();
        if (program(p.id) == null) PROGRAMS.add(p);
        savePrograms(c);
    }

    public static void delete(Context c, Program p) {
        PROGRAMS.remove(p);
        savePrograms(c);
    }

    public static void savePrograms(Context c) {
        sortPrograms();
        JSONArray arr = new JSONArray();
        for (Program p : PROGRAMS) {
            try { arr.put(p.toJson()); } catch (Exception e) { /* skip */ }
        }
        sp(c).edit().putString("programs", arr.toString()).apply();
    }

    /** A ready made program so a new user can hear something immediately. */
    public static Program sample() {
        Program p = Program.blank("My first program");
        if (LIB.size() > 0) {
            Track t = LIB.get(0);
            Step warm = Step.play(t);
            p.steps.add(warm);
            p.steps.add(Step.silence(60000));
            long end = t.durMs > 90000 ? 90000 : Math.max(20000, t.durMs / 2);
            Step drill = Step.section(t, 30000, end);
            drill.times = 4;
            drill.gapMs = 3000;
            p.steps.add(drill);
        }
        return p;
    }
}
'@

# ---------------------------------------------------------------------------
# Java: theme, widget factory, hand drawn icons
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Ui.java" @'
package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.HapticFeedbackConstants;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

/**
 * A very small design system: one palette plus factory methods for the widgets
 * the app needs. No AndroidX, no XML layouts.
 */
public final class Ui {

    public static final int PRIMARY = 0, SECONDARY = 1, DANGER = 2, GHOST = 3;
    public static final int MATCH = ViewGroup.LayoutParams.MATCH_PARENT;
    public static final int WRAP  = ViewGroup.LayoutParams.WRAP_CONTENT;

    public interface OnToggle { void set(boolean v); }
    public interface OnSlide  { void set(int v); }
    public interface OnValue  { void set(int v); }
    public interface OnPick   { void set(int index); }

    public static boolean dark = true;
    public static int BG, SURF, SURF2, LINE, TXT, DIM, ACC, ACC2, RED, GREEN, AMBER, RIPPLE, ONACC, FIELD;
    /** The accent, nudged until it is legible as text on a card. */
    public static int ACC_TXT;
    /** The accent at a whisper, for the highlight behind the playing step. */
    public static int ACC_SOFT;

    /** Colours offered in settings. Any other colour can be mixed by hand. */
    public static final int[] ACCENTS = {
        0xFF4CC2FF, 0xFF25D0B8, 0xFFFF5FA2, 0xFF9B7CFF,
        0xFFFFB300, 0xFF7ED957, 0xFFFF7043, 0xFF5C9DFF
    };
    public static final String[] ACCENT_NAMES = {
        "Aqua", "Teal", "Magenta", "Violet",
        "Amber", "Lime", "Coral", "Sky"
    };

    public static final int STYLE_MATERIAL = 0, STYLE_ELEGANT = 1, STYLE_RETRO = 2,
                            STYLE_CODER = 3, STYLE_98 = 4, STYLE_FUTURE = 5,
                            STYLE_NEON = 6, STYLE_PASTEL = 7, STYLE_BRUTAL = 8,
                            STYLE_MINIMAL = 9;
    public static final String[] STYLE_NAMES = {
        "Material", "Elegant", "Retro", "Coder", "98", "Futuristic",
        "Neon", "Pastel", "Brutalist", "Minimal"
    };
    public static final String[] STYLE_NOTES = {
        "Soft corners and quiet lines. The default.",
        "Serif type, thin rules, room to breathe.",
        "Warm paper, heavy borders, chunky type.",
        "Monospace everything and square corners.",
        "Grey panels and hard edges, like an old desktop.",
        "Wide letter spacing and very round shapes.",
        "Deep night, bright edges, everything glowing.",
        "Soft and quiet. Easy on the eyes late at night.",
        "Stark and heavy. Thick black rules, nothing soft.",
        "No borders at all. Space does the work."
    };

    // metrics the look controls
    public static float RAD_CARD, RAD_BTN, RAD_CHIP, STROKE_W, TRACK_SP, ICON_W, PAD;
    public static Typeface FONT, FONT_BOLD;
    public static boolean CAPS_HEADINGS, SQUARE_ICONS;
    public static int style = STYLE_MATERIAL;

    private Ui() { }

    public static void theme(Prefs p) {
        theme(p.dark(), p.accent(), p.style());
    }

    public static void theme(boolean isDark, int accent, int look) {
        dark = isDark;
        style = look < 0 || look >= STYLE_NAMES.length ? STYLE_MATERIAL : look;

        if (isDark) {
            BG    = 0xFF0E1116; SURF  = 0xFF161C24; SURF2 = 0xFF1E2630; LINE  = 0xFF2C3542;
            TXT   = 0xFFE8EDF3; DIM   = 0xFF93A1B0;
            RED   = 0xFFFF6B6B; GREEN = 0xFF3DDC97; AMBER = 0xFFFFC65C;
            RIPPLE = 0x33FFFFFF; FIELD = 0xFF0B0F14;
        } else {
            BG    = 0xFFF4F6FA; SURF  = 0xFFFFFFFF; SURF2 = 0xFFEDF1F7; LINE  = 0xFFD6DEE8;
            TXT   = 0xFF12181F; DIM   = 0xFF5A6673;
            RED   = 0xFFD03A3A; GREEN = 0xFF10875A; AMBER = 0xFFA97400;
            RIPPLE = 0x22000000; FIELD = 0xFFF8FAFC;
        }

        ACC = accent == 0 ? ACCENTS[0] : accent;
        ACC2 = shift(ACC, isDark);
        ONACC = luminance(ACC) > 0.55f ? 0xFF101418 : 0xFFFFFFFF;

        // defaults, then the look adjusts them
        RAD_CARD = 18; RAD_BTN = 12; RAD_CHIP = 20; STROKE_W = 1f;
        TRACK_SP = 0.12f; ICON_W = 1.9f; PAD = 1f;
        FONT = Typeface.DEFAULT; FONT_BOLD = Typeface.DEFAULT_BOLD;
        CAPS_HEADINGS = true; SQUARE_ICONS = false;

        switch (style) {
            case STYLE_ELEGANT:
                RAD_CARD = 6; RAD_BTN = 4; RAD_CHIP = 14; STROKE_W = 0.8f;
                TRACK_SP = 0.05f; ICON_W = 1.5f; PAD = 1.15f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, Typeface.BOLD);
                CAPS_HEADINGS = false;
                break;
            case STYLE_RETRO:
                RAD_CARD = 10; RAD_BTN = 8; RAD_CHIP = 12; STROKE_W = 2.2f;
                TRACK_SP = 0.08f; ICON_W = 2.4f; PAD = 1.05f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, Typeface.BOLD);
                if (isDark) {
                    BG = 0xFF17120E; SURF = 0xFF231A13; SURF2 = 0xFF2E231A; LINE = 0xFF4A3928;
                    TXT = 0xFFF3E7D6; DIM = 0xFFB9A487; FIELD = 0xFF120E0A;
                } else {
                    BG = 0xFFF6EFE2; SURF = 0xFFFFF9EE; SURF2 = 0xFFEFE4D2; LINE = 0xFFCBB694;
                    TXT = 0xFF2C2114; DIM = 0xFF7A6650; FIELD = 0xFFFFFBF3;
                }
                break;
            case STYLE_CODER:
                RAD_CARD = 2; RAD_BTN = 2; RAD_CHIP = 2; STROKE_W = 1.4f;
                TRACK_SP = 0.02f; ICON_W = 2f; PAD = 0.95f;
                FONT = Typeface.MONOSPACE;
                FONT_BOLD = Typeface.create(Typeface.MONOSPACE, Typeface.BOLD);
                CAPS_HEADINGS = false; SQUARE_ICONS = true;
                if (isDark) {
                    BG = 0xFF07090B; SURF = 0xFF0D1116; SURF2 = 0xFF141A21; LINE = 0xFF243040;
                    TXT = 0xFFD7E4D7; DIM = 0xFF7C8C7C; FIELD = 0xFF05070A;
                } else {
                    BG = 0xFFF7F8F5; SURF = 0xFFFFFFFF; SURF2 = 0xFFEDF0EA; LINE = 0xFFC9D2C4;
                    TXT = 0xFF13201A; DIM = 0xFF5A6B5F; FIELD = 0xFFFBFCFA;
                }
                break;
            case STYLE_98:
                RAD_CARD = 0; RAD_BTN = 0; RAD_CHIP = 0; STROKE_W = 2.4f;
                TRACK_SP = 0f; ICON_W = 2.2f; PAD = 0.9f;
                CAPS_HEADINGS = false; SQUARE_ICONS = true;
                if (isDark) {
                    BG = 0xFF2B2B2B; SURF = 0xFF3C3C3C; SURF2 = 0xFF4A4A4A; LINE = 0xFF7A7A7A;
                    TXT = 0xFFF0F0F0; DIM = 0xFFB4B4B4; FIELD = 0xFF262626;
                } else {
                    BG = 0xFFBFBFBF; SURF = 0xFFD8D8D8; SURF2 = 0xFFCCCCCC; LINE = 0xFF6E6E6E;
                    TXT = 0xFF101010; DIM = 0xFF4A4A4A; FIELD = 0xFFFFFFFF;
                }
                break;
            case STYLE_FUTURE:
                RAD_CARD = 26; RAD_BTN = 22; RAD_CHIP = 24; STROKE_W = 1f;
                TRACK_SP = 0.22f; ICON_W = 1.4f; PAD = 1.1f;
                if (isDark) {
                    BG = 0xFF080B14; SURF = 0xFF101528; SURF2 = 0xFF171E36; LINE = 0xFF2A3358;
                    TXT = 0xFFEDF1FF; DIM = 0xFF8E9AC6; FIELD = 0xFF070A12;
                } else {
                    BG = 0xFFF2F4FF; SURF = 0xFFFFFFFF; SURF2 = 0xFFEAEDFB; LINE = 0xFFC9D0F0;
                    TXT = 0xFF141833; DIM = 0xFF5F6790; FIELD = 0xFFF8F9FF;
                }
                break;
            case STYLE_NEON:
                RAD_CARD = 20; RAD_BTN = 16; RAD_CHIP = 22; STROKE_W = 1.3f;
                TRACK_SP = 0.14f; ICON_W = 1.7f; PAD = 1f;
                if (isDark) {
                    BG = 0xFF05060C; SURF = 0xFF0B0F1C; SURF2 = 0xFF121A2E; LINE = 0xFF2C3C6E;
                    TXT = 0xFFE9F1FF; DIM = 0xFF7C8CC4; FIELD = 0xFF04050A;
                } else {
                    BG = 0xFF11131C; SURF = 0xFF1A1E2C; SURF2 = 0xFF232838; LINE = 0xFF3C4A78;
                    TXT = 0xFFF0F3FF; DIM = 0xFF98A2C0; FIELD = 0xFF0F111A;
                }
                break;
            case STYLE_PASTEL:
                RAD_CARD = 22; RAD_BTN = 18; RAD_CHIP = 24; STROKE_W = 0.9f;
                TRACK_SP = 0.03f; ICON_W = 1.6f; PAD = 1.15f;
                CAPS_HEADINGS = false;
                if (isDark) {
                    BG = 0xFF191625; SURF = 0xFF221E31; SURF2 = 0xFF2C2740; LINE = 0xFF3F3857;
                    TXT = 0xFFEDE7FA; DIM = 0xFFA79CC4; FIELD = 0xFF15121F;
                } else {
                    BG = 0xFFFAF7FF; SURF = 0xFFFFFFFF; SURF2 = 0xFFF3EDFB; LINE = 0xFFE3D9F2;
                    TXT = 0xFF3B3350; DIM = 0xFF8B82A6; FIELD = 0xFFFDFBFF;
                }
                break;
            case STYLE_BRUTAL:
                RAD_CARD = 0; RAD_BTN = 0; RAD_CHIP = 0; STROKE_W = 3.2f;
                TRACK_SP = 0.02f; ICON_W = 2.8f; PAD = 1f;
                SQUARE_ICONS = true;
                FONT_BOLD = Typeface.DEFAULT_BOLD;
                if (isDark) {
                    BG = 0xFF000000; SURF = 0xFF0B0B0B; SURF2 = 0xFF141414; LINE = 0xFFFFFFFF;
                    TXT = 0xFFFFFFFF; DIM = 0xFFA8A8A8; FIELD = 0xFF000000;
                } else {
                    BG = 0xFFFFFFFF; SURF = 0xFFFFFFFF; SURF2 = 0xFFF2F2F2; LINE = 0xFF000000;
                    TXT = 0xFF000000; DIM = 0xFF444444; FIELD = 0xFFFFFFFF;
                }
                break;
            case STYLE_MINIMAL:
                RAD_CARD = 10; RAD_BTN = 8; RAD_CHIP = 12; STROKE_W = 0f;
                TRACK_SP = 0.06f; ICON_W = 1.4f; PAD = 1.25f;
                CAPS_HEADINGS = false;
                if (isDark) {
                    BG = 0xFF101215; SURF = 0xFF16191D; SURF2 = 0xFF1C2025; LINE = 0xFF262B31;
                    TXT = 0xFFE6E9EC; DIM = 0xFF8B9299; FIELD = 0xFF0D0F12;
                } else {
                    BG = 0xFFFBFBFC; SURF = 0xFFFFFFFF; SURF2 = 0xFFF4F5F7; LINE = 0xFFE8EAED;
                    TXT = 0xFF1B1E22; DIM = 0xFF6B7278; FIELD = 0xFFFFFFFF;
                }
                break;
            default:
                break;
        }

        // Only now are the surfaces final, so the legible accent has to be
        // worked out here rather than above: a pale accent is invisible on a
        // white card, and a dark one vanishes on a black one.
        ACC_TXT = readable(ACC, SURF, isDark);
        ACC_SOFT = blend(ACC, SURF, isDark ? 0.20f : 0.14f);
    }

    /** Lighten or darken the accent until it stands off the surface behind it. */
    private static int readable(int accent, int surface, boolean isDark) {
        float[] hsv = new float[3];
        android.graphics.Color.colorToHSV(accent, hsv);
        int c = accent;
        for (int i = 0; i < 30 && contrast(c, surface) < 3.4f; i++) {
            hsv[2] = isDark ? Math.min(1f, hsv[2] + 0.035f) : Math.max(0.12f, hsv[2] - 0.035f);
            if (isDark && hsv[1] > 0.18f) hsv[1] = Math.max(0.18f, hsv[1] - 0.012f);
            c = android.graphics.Color.HSVToColor(hsv);
        }
        return c;
    }

    private static float contrast(int a, int b) {
        float la = luminance(a), lb = luminance(b);
        float hi = Math.max(la, lb), lo = Math.min(la, lb);
        return (hi + 0.05f) / (lo + 0.05f);
    }

    public static int blend(int fg, int bg, float amount) {
        int r = (int) (((fg >> 16) & 0xFF) * amount + ((bg >> 16) & 0xFF) * (1 - amount));
        int g = (int) (((fg >> 8) & 0xFF) * amount + ((bg >> 8) & 0xFF) * (1 - amount));
        int b = (int) ((fg & 0xFF) * amount + (bg & 0xFF) * (1 - amount));
        return 0xFF000000 | (r << 16) | (g << 8) | b;
    }

    /** A companion colour for the accent, used for small marks. */
    private static int shift(int c, boolean isDark) {
        float[] hsv = new float[3];
        android.graphics.Color.colorToHSV(c, hsv);
        hsv[0] = (hsv[0] + 38f) % 360f;
        hsv[1] = Math.min(1f, hsv[1] * 0.95f);
        hsv[2] = isDark ? Math.min(1f, hsv[2] * 1.05f) : hsv[2] * 0.9f;
        return android.graphics.Color.HSVToColor(hsv);
    }

    /** Rough perceived brightness, for deciding what reads on top of the accent. */
    public static float luminance(int c) {
        int r = (c >> 16) & 0xFF, g = (c >> 8) & 0xFF, b = c & 0xFF;
        return (0.299f * r + 0.587f * g + 0.114f * b) / 255f;
    }

    public static int dp(Context c, float v) {
        return Math.round(v * c.getResources().getDisplayMetrics().density);
    }

    public static void applyWindow(Activity a) {
        a.getWindow().setStatusBarColor(BG);
        a.getWindow().setNavigationBarColor(BG);
        int flags = dark ? 0 : (View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR | View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR);
        a.getWindow().getDecorView().setSystemUiVisibility(flags);
    }

    public static int themeRes(boolean isDark) {
        return isDark ? android.R.style.Theme_Material_NoActionBar
                      : android.R.style.Theme_Material_Light_NoActionBar;
    }

    public static AlertDialog.Builder dialog(Activity a) {
        return new AlertDialog.Builder(a, dark ? R.style.RiolaDialog : R.style.RiolaDialogLight);
    }

    public static void toast(Context c, String s) { Toast.makeText(c, s, Toast.LENGTH_SHORT).show(); }

    public static void buzz(View v) {
        try { v.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY); } catch (Exception e) { }
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
        if (wDp > 0f) g.setStroke(Math.max(1, dp(c, wDp)), stroke);
        return g;
    }

    public static Drawable ripple(Drawable content) {
        return new RippleDrawable(ColorStateList.valueOf(RIPPLE), content, null);
    }

    // ---- layout params ---------------------------------------------------
    public static LinearLayout.LayoutParams lp(int w, int h) {
        return new LinearLayout.LayoutParams(w, h);
    }

    public static LinearLayout.LayoutParams lpw(int w, int h, float weight) {
        return new LinearLayout.LayoutParams(w, h, weight);
    }

    public static View margin(Context c, View v, float l, float t, float r, float b) {
        ViewGroup.LayoutParams p = v.getLayoutParams();
        LinearLayout.LayoutParams lp = (p instanceof LinearLayout.LayoutParams)
                ? (LinearLayout.LayoutParams) p : new LinearLayout.LayoutParams(MATCH, WRAP);
        lp.setMargins(dp(c, l), dp(c, t), dp(c, r), dp(c, b));
        v.setLayoutParams(lp);
        return v;
    }

    public static View weight(View v, float w) {
        v.setLayoutParams(lpw(0, WRAP, w));
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
        l.setBackground(rrs(c, SURF, LINE, RAD_CARD, STROKE_W));
        int p = dp(c, 14 * PAD);
        l.setPadding(p, dp(c, 12 * PAD), p, dp(c, 12 * PAD));
        margin(c, l, 12, 0, 12, 10);
        return l;
    }

    /** A scrolling body that stretches between the header and whatever is pinned below. */
    public static ScrollView scroller(Context c, LinearLayout body) {
        ScrollView sv = new ScrollView(c);
        sv.setLayoutParams(lpw(MATCH, 0, 1f));
        sv.setFillViewport(true);
        sv.addView(body, new FrameLayout.LayoutParams(MATCH, WRAP));
        return sv;
    }

    public static View gap(Context c, float h) {
        View v = new View(c);
        v.setLayoutParams(lp(MATCH, dp(c, h)));
        return v;
    }

    public static View hgap(Context c, float w) {
        View v = new View(c);
        v.setLayoutParams(lp(dp(c, w), 1));
        return v;
    }

    public static View spring(Context c) {
        View v = new View(c);
        v.setLayoutParams(lpw(0, 1, 1f));
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
        t.setTypeface(bold ? FONT_BOLD : FONT);
        t.setLayoutParams(lp(WRAP, WRAP));
        return t;
    }

    public static TextView mono(Context c, String s, float sp, int color) {
        TextView t = tv(c, s, sp, color, false);
        t.setTypeface(Typeface.MONOSPACE);
        return t;
    }

    public static LinearLayout heading(Context c, int icoId, String text) {
        LinearLayout r = row(c);
        if (icoId > 0) {
            r.addView(icon(c, icoId, ACC_TXT, 16));
            r.addView(hgap(c, 8));
        }
        TextView t = tv(c, CAPS_HEADINGS ? text.toUpperCase() : text, 12, DIM, true);
        t.setLetterSpacing(TRACK_SP);
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

    public static void ellipsize(TextView t) {
        t.setSingleLine(true);
        t.setEllipsize(TextUtils.TruncateAt.END);
    }

    // ---- icons and buttons ----------------------------------------------
    public static ImageView icon(Context c, int icoId, int color, int sizeDp) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        v.setLayoutParams(lp(dp(c, sizeDp), dp(c, sizeDp)));
        return v;
    }

    public static ImageView iconBtn(Context c, int icoId, int color, int sizeDp, String describe, View.OnClickListener l) {
        return iconBtn(c, icoId, color, sizeDp, 9, describe, l);
    }

    public static ImageView iconBtn(Context c, int icoId, int color, int sizeDp, int padDp,
                                    String describe, View.OnClickListener l) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        int pad = dp(c, padDp);
        v.setPadding(pad, pad, pad, pad);
        int total = dp(c, sizeDp) + pad * 2;
        v.setLayoutParams(lp(total, total));
        v.setBackground(ripple(rr(c, 0x00000000, 40)));
        v.setContentDescription(describe);
        v.setOnClickListener(l);
        return v;
    }

    public static ImageView roundBtn(Context c, int icoId, int sizeDp, boolean filled, String describe, View.OnClickListener l) {
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
        v.setContentDescription(describe);
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
        b.setPadding(dp(c, 14 * PAD), dp(c, 11 * PAD), dp(c, 14 * PAD), dp(c, 11 * PAD));
        b.setBackground(ripple(rrs(c, fill, stroke, RAD_BTN, STROKE_W)));
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
        if (text != null) b.setContentDescription(text);
        return b;
    }

    public static TextView chip(Context c, String text, boolean on, View.OnClickListener l) {
        TextView t = tv(c, text, 12, on ? ONACC : DIM, true);
        t.setPadding(dp(c, 13), dp(c, 8), dp(c, 13), dp(c, 8));
        t.setBackground(ripple(rrs(c, on ? ACC : SURF2, on ? ACC : LINE, RAD_CHIP, STROKE_W)));
        t.setOnClickListener(l);
        t.setSingleLine(true);
        LinearLayout.LayoutParams p = lp(WRAP, WRAP);
        p.setMargins(0, 0, dp(c, 6), dp(c, 6));
        t.setLayoutParams(p);
        return t;
    }

    // ---- composite rows --------------------------------------------------
    /** What appBar hands back, so callers never index into its children. */
    public static class Bar {
        public LinearLayout view;
        public LinearLayout titles;
        public TextView title;
        public TextView sub;
    }

    /** Screen header: optional back arrow, title, subtitle, trailing action views. */
    public static Bar appBar(final Activity a, int icoId, String title, String sub, boolean back, View[] actions) {
        Bar bar = new Bar();
        LinearLayout h = row(a);
        h.setPadding(dp(a, back ? 4 : 16), dp(a, 12), dp(a, 8), dp(a, 8));
        if (back) {
            h.addView(iconBtn(a, Ico.BACK, TXT, 20, "Back", new View.OnClickListener() {
                public void onClick(View v) { a.finish(); }
            }));
        } else if (icoId > 0) {
            ImageView mark = icon(a, icoId, ACC, 20);
            int p = dp(a, 7);
            mark.setPadding(p, p, p, p);
            mark.setLayoutParams(lp(dp(a, 34), dp(a, 34)));
            mark.setBackground(rr(a, SURF2, 10));
            h.addView(mark);
            h.addView(hgap(a, 10));
        }
        LinearLayout titles = col(a);
        titles.setLayoutParams(lpw(0, WRAP, 1f));
        TextView t = tv(a, title, back ? 17 : 20, TXT, true);
        ellipsize(t);
        titles.addView(t);
        // The subtitle view is always created, even when it starts empty, so a
        // screen can fill it in later.
        TextView s = tv(a, sub == null ? "" : sub, 11, DIM, false);
        ellipsize(s);
        titles.addView(s);
        h.addView(titles);
        if (actions != null) for (View v : actions) if (v != null) h.addView(v);

        bar.view = h;
        bar.titles = titles;
        bar.title = t;
        bar.sub = s;
        return bar;
    }

    public static LinearLayout emptyState(Context c, int icoId, String title, String body) {
        LinearLayout box = col(c);
        box.setGravity(Gravity.CENTER_HORIZONTAL);
        box.setPadding(dp(c, 24), dp(c, 26), dp(c, 24), dp(c, 26));
        ImageView i = icon(c, icoId, LINE, 42);
        box.addView(i);
        TextView t = tv(c, title, 15, TXT, true);
        margin(c, t, 0, 12, 0, 0);
        t.setGravity(Gravity.CENTER);
        box.addView(t);
        TextView b = tv(c, body, 12.5f, DIM, false);
        b.setGravity(Gravity.CENTER);
        margin(c, b, 0, 6, 0, 0);
        box.addView(b);
        return box;
    }

    public static View switchRow(Context c, String label, String sub, boolean value, final OnToggle cb) {
        LinearLayout r = row(c);
        margin(c, r, 0, 4, 0, 4);
        int pad = dp(c, 6);
        r.setPadding(pad, pad, pad, pad);
        LinearLayout col = col(c);
        col.setLayoutParams(lpw(0, WRAP, 1f));
        col.addView(tv(c, label, 14, TXT, false));
        if (sub != null && sub.length() > 0) {
            col.addView(tv(c, sub, 11.5f, DIM, false));
        }
        r.addView(col);
        final Switch sw = new Switch(c);
        sw.setChecked(value);
        sw.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton b, boolean v) { cb.set(v); }
        });
        r.addView(sw);

        // The label looks tappable, so it has to be tappable: hitting anywhere
        // on the row flips the switch.
        r.setBackground(ripple(rr(c, 0x00000000, 10)));
        r.setClickable(true);
        r.setContentDescription(label);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { buzz(v); sw.toggle(); }
        });
        return r;
    }

    public static View sliderRow(Context c, String label, int min, int max, int value,
                                 String unit, OnSlide cb) {
        return sliderRow(c, label, min, max, value, unit, Integer.MIN_VALUE, cb);
    }

    /**
     * A labelled slider. Pass a normal value and it grows an inline reset
     * button, shown whenever the slider is not sitting on that value.
     */
    public static View sliderRow(Context c, String label, final int min, int max, int value,
                                 final String unit, final int normal, final OnSlide cb) {
        LinearLayout box = col(c);
        margin(c, box, 0, 6, 0, 2);

        LinearLayout head = row(c);
        TextView t = tv(c, label, 14, TXT, false);
        t.setLayoutParams(lpw(0, WRAP, 1f));
        head.addView(t);
        final TextView val = mono(c, value + unit, 12, ACC_TXT);
        head.addView(val);

        final SeekBar s = new SeekBar(c);
        final ImageView reset = iconBtn(c, Ico.RESET, DIM, 15, 6, "Reset " + label, null);
        final boolean hasNormal = normal != Integer.MIN_VALUE;
        if (hasNormal) {
            reset.setVisibility(value == normal ? View.INVISIBLE : View.VISIBLE);
            reset.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    buzz(v);
                    s.setProgress(normal - min);
                    val.setText(normal + unit);
                    reset.setVisibility(View.INVISIBLE);
                    cb.set(normal);
                }
            });
            head.addView(reset);
        }
        box.addView(head);

        s.setMax(max - min);
        s.setProgress(Math.max(0, value - min));
        s.setProgressTintList(ColorStateList.valueOf(ACC));
        s.setThumbTintList(ColorStateList.valueOf(ACC));
        s.setLayoutParams(lp(MATCH, WRAP));
        s.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int p, boolean fromUser) {
                val.setText((min + p) + unit);
                if (hasNormal) reset.setVisibility((min + p) == normal ? View.INVISIBLE : View.VISIBLE);
            }
            public void onStartTrackingTouch(SeekBar b) { }
            public void onStopTrackingTouch(SeekBar b) { cb.set(min + b.getProgress()); }
        });
        box.addView(s);
        return box;
    }

    /** Two or three mutually exclusive options. */
    public static LinearLayout seg(final Context c, final String[] labels, final int selected, final OnPick cb) {
        final LinearLayout r = row(c);
        r.setBackground(rr(c, SURF2, RAD_BTN));
        int pad = dp(c, 3);
        r.setPadding(pad, pad, pad, pad);
        for (int i = 0; i < labels.length; i++) {
            final int index = i;
            TextView t = tv(c, labels[i], 12.5f, i == selected ? ONACC : DIM, true);
            t.setGravity(Gravity.CENTER);
            t.setPadding(dp(c, 10), dp(c, 9), dp(c, 10), dp(c, 9));
            t.setLayoutParams(lpw(0, WRAP, 1f));
            if (i == selected) t.setBackground(rr(c, ACC, Math.max(2f, RAD_BTN - 2f)));
            else t.setBackground(ripple(rr(c, 0x00000000, Math.max(2f, RAD_BTN - 2f))));
            t.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) { buzz(v); cb.set(index); }
            });
            r.addView(t);
        }
        return r;
    }

    /** Minus / value / plus. */
    public static LinearLayout stepper(final Context c, final int start, final int min, final int max,
                                       final int by, final String unit, final OnValue cb) {
        final int[] value = { start };
        final LinearLayout r = row(c);
        final TextView val = tv(c, start + unit, 15, TXT, true);
        val.setGravity(Gravity.CENTER);
        val.setLayoutParams(lpw(0, WRAP, 1f));

        ImageView minus = iconBtn(c, Ico.MINUS, TXT, 16, "less", null);
        ImageView plus  = iconBtn(c, Ico.PLUS, TXT, 16, "more", null);
        minus.setBackground(ripple(rrs(c, SURF2, LINE, 10, 1)));
        plus.setBackground(ripple(rrs(c, SURF2, LINE, 10, 1)));
        minus.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                value[0] = Math.max(min, value[0] - by);
                val.setText(value[0] + unit);
                buzz(v);
                cb.set(value[0]);
            }
        });
        plus.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                value[0] = Math.min(max, value[0] + by);
                val.setText(value[0] + unit);
                buzz(v);
                cb.set(value[0]);
            }
        });
        r.addView(minus);
        r.addView(val);
        r.addView(plus);
        return r;
    }

    /** A tappable "label / value >" row used for pickers. */
    public static LinearLayout field(Context c, String label, String value, int icoId, View.OnClickListener l) {
        LinearLayout r = row(c);
        r.setBackground(ripple(rrs(c, FIELD, LINE, RAD_BTN, STROKE_W)));
        r.setPadding(dp(c, 12), dp(c, 11), dp(c, 10), dp(c, 11));
        margin(c, r, 0, 6, 0, 0);
        r.setOnClickListener(l);
        if (icoId > 0) {
            r.addView(icon(c, icoId, DIM, 16));
            r.addView(hgap(c, 10));
        }
        LinearLayout box = col(c);
        box.setLayoutParams(lpw(0, WRAP, 1f));
        box.addView(tv(c, label, 11, DIM, false));
        TextView v = tv(c, value, 14.5f, TXT, false);
        ellipsize(v);
        box.addView(v);
        r.addView(box);
        r.addView(icon(c, Ico.RIGHT, DIM, 14));
        return r;
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
 * Every icon is drawn here on a 24x24 grid, so the apk needs no bitmap assets
 * and no icon font.
 */
public class Ico extends Drawable {

    public static final int PLAY = 1, PAUSE = 2, STOP = 3, NEXT = 4, PREV = 5, PLUS = 6,
            FOLDER = 7, TRASH = 8, SAVE = 9, OPEN = 10, HELP = 11, GEAR = 12, LOOP = 13,
            NOTE = 14, AB = 15, CHECK = 16, CLOSE = 17, UP = 18, DOWN = 19, CLOCK = 20,
            LIST = 21, WAVE = 22, EDIT = 23, SCISSOR = 24, MORE = 25, BACK = 26, RIGHT = 27,
            SEARCH = 28, COPY = 29, MINUS = 30, DRAG = 31, PROGRAM = 32, MOON = 33,
            RESET = 34, BELL = 35, SHUFFLE = 36;

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
        p.setStrokeWidth(Ui.ICON_W * u);
        p.setStrokeCap(Ui.SQUARE_ICONS ? Paint.Cap.BUTT : Paint.Cap.ROUND);
        p.setStrokeJoin(Ui.SQUARE_ICONS ? Paint.Join.MITER : Paint.Join.ROUND);
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
            case MINUS:
                line(cv, ox, oy, u, 5f, 12f, 19f, 12f);
                break;
            case FOLDER:
                poly(cv, ox, oy, u, true, 3f, 19f, 3f, 5.5f, 9f, 5.5f, 11f, 8.5f, 21f, 8.5f, 21f, 19f);
                break;
            case TRASH:
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
                float cx = ox + 12f * u, cy = oy + 12f * u;
                for (int i = 0; i < 8; i++) {
                    cv.save();
                    cv.rotate(i * 45f, cx, cy);
                    r.set(cx - 1.9f * u, cy - 11f * u, cx + 1.9f * u, cy - 6.4f * u);
                    p.setStyle(Paint.Style.FILL);
                    cv.drawRoundRect(r, 0.8f * u, 0.8f * u, p);
                    cv.restore();
                }
                p.setStyle(Paint.Style.STROKE);
                p.setStrokeWidth(2.6f * u);
                cv.drawCircle(cx, cy, 6.4f * u, p);
                p.setStrokeWidth(1.9f * u);
                p.setColor(0x00000000);
                p.setStyle(Paint.Style.FILL);
                p.setColor(color);
                p.setStyle(Paint.Style.STROKE);
                cv.drawCircle(cx, cy, 3.1f * u, p);
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
            case BACK:
                poly(cv, ox, oy, u, false, 15f, 5f, 8f, 12f, 15f, 19f);
                break;
            case RIGHT:
                poly(cv, ox, oy, u, false, 9.5f, 5f, 16.5f, 12f, 9.5f, 19f);
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
            case PROGRAM:
                for (int i = 0; i < 3; i++) {
                    float y = 6.5f + i * 5.5f;
                    line(cv, ox, oy, u, 4f, y, 14f, y);
                }
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 17f, 8f, 22f, 12f, 17f, 16f);
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
            case MORE:
                p.setStyle(Paint.Style.FILL);
                for (int i = 0; i < 3; i++) cv.drawCircle(ox + 12f * u, oy + (5.5f + i * 6.5f) * u, 1.7f * u, p);
                break;
            case DRAG:
                p.setStyle(Paint.Style.FILL);
                for (int i = 0; i < 3; i++) {
                    cv.drawCircle(ox + 9f * u, oy + (6f + i * 6f) * u, 1.5f * u, p);
                    cv.drawCircle(ox + 15f * u, oy + (6f + i * 6f) * u, 1.5f * u, p);
                }
                break;
            case SEARCH:
                cv.drawCircle(ox + 10.5f * u, oy + 10.5f * u, 6.2f * u, p);
                line(cv, ox, oy, u, 15.2f, 15.2f, 20f, 20f);
                break;
            case COPY:
                box(cv, ox, oy, u, 8f, 8f, 20f, 20f, 2.4f);
                poly(cv, ox, oy, u, false, 16f, 5f, 4.5f, 5f, 4.5f, 16f);
                break;
            case SHUFFLE:
                poly(cv, ox, oy, u, false, 3f, 7f, 8f, 7f, 16f, 17f, 21f, 17f);
                poly(cv, ox, oy, u, false, 3f, 17f, 8f, 17f, 16f, 7f, 21f, 7f);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 18f, 4f, 22f, 7f, 18f, 10f);
                poly(cv, ox, oy, u, true, 18f, 14f, 22f, 17f, 18f, 20f);
                break;
            case RESET:
                r.set(ox + 4.5f * u, oy + 4.5f * u, ox + 19.5f * u, oy + 19.5f * u);
                cv.drawArc(r, -60f, 300f, false, p);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 11.2f, 2.8f, 6.0f, 3.4f, 8.8f, 8.2f);
                break;
            case BELL:
                path.reset();
                path.moveTo(ox + 6.2f * u, oy + 16.8f * u);
                path.cubicTo(ox + 6.2f * u, oy + 10.4f * u, ox + 8.2f * u, oy + 7.6f * u,
                             ox + 12f * u, oy + 7.6f * u);
                path.cubicTo(ox + 15.8f * u, oy + 7.6f * u, ox + 17.8f * u, oy + 10.4f * u,
                             ox + 17.8f * u, oy + 16.8f * u);
                cv.drawPath(path, p);
                line(cv, ox, oy, u, 4.6f, 16.8f, 19.4f, 16.8f);
                line(cv, ox, oy, u, 12f, 4.8f, 12f, 7.6f);
                p.setStyle(Paint.Style.FILL);
                cv.drawCircle(ox + 12f * u, oy + 19.8f * u, 1.8f * u, p);
                break;
            case MOON:
                path.reset();
                path.moveTo(ox + 19f * u, oy + 15.5f * u);
                path.cubicTo(ox + 13f * u, oy + 17.5f * u, ox + 7f * u, oy + 13f * u,
                             ox + 9.5f * u, oy + 5.5f * u);
                path.cubicTo(ox + 3f * u, oy + 8f * u, ox + 4f * u, oy + 20f * u,
                             ox + 13f * u, oy + 20.5f * u);
                path.cubicTo(ox + 16.5f * u, oy + 20.5f * u, ox + 18.5f * u, oy + 18f * u,
                             ox + 19f * u, oy + 15.5f * u);
                path.close();
                p.setStyle(Paint.Style.FILL);
                cv.drawPath(path, p);
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
# Java: choosing the colour and the look
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Themes.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

/** The two dialogs behind "Colour" and "Look" in settings. */
public final class Themes {

    public interface OnChosen { void chosen(); }

    private Themes() { }

    // ---- colour ----------------------------------------------------------
    public static void colour(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int current = prefs.accent();

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final android.app.AlertDialog[] holder = new android.app.AlertDialog[1];

        LinearLayout row = Ui.row(a);
        for (int i = 0; i < Ui.ACCENTS.length; i++) {
            final int colour = Ui.ACCENTS[i];
            if (i == 4) {                       // second row of swatches
                box.addView(row);
                row = Ui.row(a);
                Ui.margin(a, row, 0, 8, 0, 0);
            }
            View sw = swatch(a, colour, colour == current);
            sw.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    Ui.buzz(v);
                    prefs.accent(colour);
                    if (holder[0] != null) holder[0].dismiss();
                    cb.chosen();
                }
            });
            row.addView(sw);
        }
        box.addView(row);

        TextView note = Ui.tv(a, "The colour is used for buttons, highlights and the playing step.",
                11.5f, Ui.DIM, false);
        Ui.margin(a, note, 2, 12, 0, 0);
        box.addView(note);
        box.addView(Ui.gap(a, 6));

        holder[0] = Ui.dialog(a).setTitle("Colour").setView(box)
                .setNegativeButton("Cancel", null)
                .setNeutralButton("Mix your own", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { custom(a, prefs, cb); }
                }).create();
        holder[0].show();
    }

    private static View swatch(Activity a, int colour, boolean selected) {
        GradientDrawable g = new GradientDrawable();
        g.setShape(GradientDrawable.OVAL);
        g.setColor(colour);
        if (selected) g.setStroke(Ui.dp(a, 3), Ui.TXT);
        View v = new View(a);
        v.setBackground(g);
        LinearLayout.LayoutParams lp = Ui.lp(Ui.dp(a, 52), Ui.dp(a, 52));
        lp.setMargins(Ui.dp(a, 6), 0, Ui.dp(a, 6), 0);
        v.setLayoutParams(lp);
        v.setContentDescription(selected ? "colour, selected" : "colour");
        return v;
    }

    /** Three sliders and a live preview - enough, and no library needed. */
    private static void custom(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int start = prefs.accent();
        final int[] rgb = { (start >> 16) & 0xFF, (start >> 8) & 0xFF, start & 0xFF };

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 10), p, 0);

        final View preview = new View(a);
        preview.setLayoutParams(Ui.lp(Ui.MATCH, Ui.dp(a, 64)));
        box.addView(preview);

        final TextView hex = Ui.mono(a, "", 13, Ui.DIM);
        hex.setGravity(Gravity.CENTER);
        hex.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(a, hex, 0, 8, 0, 4);
        box.addView(hex);

        final Runnable paint = new Runnable() {
            public void run() {
                int c = 0xFF000000 | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
                GradientDrawable g = new GradientDrawable();
                g.setColor(c);
                g.setCornerRadius(Ui.dp(a, Ui.RAD_BTN));
                g.setStroke(Math.max(1, Ui.dp(a, 1)), Ui.LINE);
                preview.setBackground(g);
                hex.setText(String.format("#%02X%02X%02X", rgb[0], rgb[1], rgb[2]));
            }
        };
        paint.run();

        String[] names = { "Red", "Green", "Blue" };
        for (int i = 0; i < 3; i++) {
            final int channel = i;
            LinearLayout r = Ui.row(a);
            Ui.margin(a, r, 0, 4, 0, 0);
            TextView label = Ui.tv(a, names[i], 13, Ui.DIM, false);
            label.setWidth(Ui.dp(a, 56));
            r.addView(label);
            SeekBar s = new SeekBar(a);
            s.setMax(255);
            s.setProgress(rgb[i]);
            s.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            s.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
            s.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
            s.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                public void onProgressChanged(SeekBar b, int v, boolean fromUser) {
                    rgb[channel] = v;
                    paint.run();
                }
                public void onStartTrackingTouch(SeekBar b) { }
                public void onStopTrackingTouch(SeekBar b) { }
            });
            r.addView(s);
            box.addView(r);
        }
        box.addView(Ui.gap(a, 8));

        Ui.dialog(a).setTitle("Mix a colour").setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Use it", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        prefs.accent(0xFF000000 | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2]);
                        cb.chosen();
                    }
                }).show();
    }

    // ---- look ------------------------------------------------------------
    public static void look(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int current = prefs.style();

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 12);
        box.setPadding(p, p, p, 0);

        final android.app.AlertDialog[] holder = new android.app.AlertDialog[1];

        for (int i = 0; i < Ui.STYLE_NAMES.length; i++) {
            final int which = i;
            LinearLayout r = Ui.row(a);
            r.setPadding(Ui.dp(a, 12), Ui.dp(a, 11), Ui.dp(a, 12), Ui.dp(a, 11));
            r.setBackground(Ui.ripple(i == current
                    ? Ui.rrs(a, Ui.SURF2, Ui.ACC_TXT, Ui.RAD_BTN, 1.4f)
                    : Ui.rr(a, Ui.SURF2, Ui.RAD_BTN)));
            Ui.margin(a, r, 0, 0, 0, 6);
            LinearLayout col = Ui.col(a);
            col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            col.addView(Ui.tv(a, Ui.STYLE_NAMES[i], 15, Ui.TXT, true));
            col.addView(Ui.tv(a, Ui.STYLE_NOTES[i], 11.5f, Ui.DIM, false));
            r.addView(col);
            if (i == current) r.addView(Ui.icon(a, Ico.CHECK, Ui.ACC_TXT, 18));
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    Ui.buzz(v);
                    prefs.style(which);
                    if (holder[0] != null) holder[0].dismiss();
                    cb.chosen();
                }
            });
            box.addView(r);
        }

        ScrollView sv = new ScrollView(a);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = Ui.dialog(a).setTitle("Look").setView(sv)
                .setNegativeButton("Cancel", null).create();
        holder[0].show();
    }
}
'@

# ---------------------------------------------------------------------------
# Java: the synthesised bell
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Bell.java" @'
package com.riola.player;

import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Handler;
import android.os.Looper;

/**
 * A soft struck bell, synthesised at runtime so the apk carries no audio files.
 *
 * The gentleness comes from the envelope, not the volume: the bright partials
 * die away in well under a second while the low ones ring on for seconds, and
 * the attack is ramped over 8 ms so there is no click. That is roughly what a
 * singing bowl does, and it is why this does not sound like a beep.
 */
public class Bell {

    public static final int LOW = 0, WARM = 1, BRIGHT = 2, DESK = 3;

    private static final int RATE = 44100;
    private static final float[] F0    = { 174.6f, 261.6f, 392.0f, 1480.0f };  // F3, C4, G4, F#6
    private static final long[]  LEN   = { 6000, 5000, 4000, 900 };
    private static final String[] NAMES = { "low", "warm", "bright", "desk" };

    private static final short[][] CACHE = new short[4][];

    private AudioTrack track;

    public static int clamp(int tone) { return tone < 0 ? 0 : (tone > 3 ? 3 : tone); }
    public static long lengthMs(int tone) { return LEN[clamp(tone)]; }
    public static String toneName(int tone) { return NAMES[clamp(tone)]; }

    /** Build the samples ahead of time so the first ring is not late. */
    public static void warm() {
        new Thread(new Runnable() {
            public void run() {
                try { pcm(WARM); } catch (Throwable t) { /* not important */ }
            }
        }, "riola-bell-warm").start();
    }

    private static synchronized short[] pcm(int tone) {
        tone = clamp(tone);
        if (CACHE[tone] != null) return CACHE[tone];

        int n = (int) (RATE * LEN[tone] / 1000L);
        short[] out = new short[n];
        float f0 = F0[tone];

        // partial: ratio to the fundamental, starting level, seconds to decay
        float[] ratio, amp, decay;
        float attack, tail, scale, shimmer;
        if (tone == DESK) {
            // a little metal dome struck once: high, inharmonic, and gone in
            // about a second. Short decays are what make it read as a "ting"
            // rather than a chime.
            ratio = new float[]{ 1.00f, 2.71f, 5.18f, 8.16f, 9.42f };
            amp   = new float[]{ 1.00f, 0.58f, 0.32f, 0.16f, 0.08f };
            decay = new float[]{ 0.42f, 0.26f, 0.16f, 0.10f, 0.06f };
            attack = 0.0015f;
            tail = 0.08f;
            scale = 9000f;
            shimmer = 0f;
        } else {
            ratio = new float[]{ 0.5f,  1.0f,  2.0f,  2.97f, 4.06f, 5.43f };
            amp   = new float[]{ 0.32f, 1.00f, 0.40f, 0.18f, 0.09f, 0.05f };
            decay = new float[]{ 6.5f,  4.5f,  2.4f,  1.3f,  0.8f,  0.45f };
            attack = 0.008f;
            tail = 0.35f;
            scale = 11000f;
            shimmer = 0.22f;
        }

        double w = 2.0 * Math.PI / RATE;

        for (int i = 0; i < n; i++) {
            float t = i / (float) RATE;
            float s = 0f;
            for (int k = 0; k < ratio.length; k++) {
                // a partial above the nyquist limit does not disappear, it folds
                // back down as an out of tune whine - so it never gets written
                if (f0 * ratio[k] > RATE * 0.45f) continue;
                s += amp[k] * (float) Math.exp(-t / decay[k]) * (float) Math.sin(w * f0 * ratio[k] * i);
            }
            // a second prime a hair sharp gives the tone a slow, warm shimmer
            if (shimmer > 0f) {
                s += shimmer * (float) Math.exp(-t / 4.0f) * (float) Math.sin(w * f0 * 1.003f * i);
            }

            if (t < attack) s *= 0.5f - 0.5f * (float) Math.cos(Math.PI * t / attack);
            float left = (n - i) / (float) RATE;
            if (left < tail) s *= left / tail;

            int v = (int) (s * scale);
            if (v > 32000) v = 32000;
            if (v < -32000) v = -32000;
            out[i] = (short) v;
        }
        CACHE[tone] = out;
        return out;
    }

    /** Strike it. Returns straight away; the tone rings on by itself. */
    public void ring(int tone, float volume) {
        stop();
        try {
            short[] data = pcm(tone);
            AudioTrack t = new AudioTrack.Builder()
                    .setAudioAttributes(new AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_MEDIA)
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            .build())
                    .setAudioFormat(new AudioFormat.Builder()
                            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                            .setSampleRate(RATE)
                            .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                            .build())
                    .setBufferSizeInBytes(data.length * 2)
                    .setTransferMode(AudioTrack.MODE_STATIC)
                    .build();
            t.write(data, 0, data.length);
            float v = volume < 0f ? 0f : (volume > 1f ? 1f : volume);
            t.setVolume(v);
            t.play();
            track = t;
        } catch (Throwable e) {
            track = null;
        }
    }

    public void stop() {
        AudioTrack t = track;
        track = null;
        if (t == null) return;
        try { t.setVolume(0f); } catch (Exception e) { /* ignore */ }
        try { t.pause(); } catch (Exception e) { /* ignore */ }
        try { t.flush(); } catch (Exception e) { /* ignore */ }
        try { t.stop(); } catch (Exception e) { /* ignore */ }
        try { t.release(); } catch (Exception e) { /* ignore */ }
    }

    /** One strike that cleans up after itself, for the editor preview. */
    public static void preview(int tone, float volume) {
        final Bell b = new Bell();
        b.ring(tone, volume);
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            public void run() { b.stop(); }
        }, lengthMs(tone) + 250);
    }
}
'@


# ---------------------------------------------------------------------------
# Java: in-app guide
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\HelpText.java" @'
package com.riola.player;

/** The in-app guide, as heading and body pairs so it can be laid out properly. */
public final class HelpText {

    private HelpText() { }

    public static final String[][] SECTIONS = {
        { "The idea",
          "A program is a list of steps that Riola plays from top to bottom. You build it by "
        + "tapping, so there is nothing to type and no syntax to remember." },

        { "1. Add your tracks",
          "Open Tracks and add files, or point Riola at a whole folder. Riola only reads them: "
        + "your files are never moved, copied or changed. Tap a track to hear it." },

        { "2. Build the steps",
          "There are four kinds of step.\n\n"
        + "Whole track plays a track from start to finish.\n"
        + "Section plays one slice of a track, from A to B.\n"
        + "Silence plays nothing for a while.\n"
        + "Bell rings a soft chime to mark a change." },

        { "3. Say how often",
          "Every playing step repeats in one of two ways: a number of times, or for a length of "
        + "time. Play the phrase eight times, or keep looping it for twelve minutes." },

        { "Fine tuning a step",
          "Gap adds a rest between one repeat and the next.\n"
        + "Speed plays it slower or faster without changing the pitch.\n"
        + "Volume makes one step quieter than the rest.\n"
        + "Turning a step off keeps it in the list but skips it for now." },

        { "Marking a section by ear",
          "In a section step, tap Pick by ear. Play the track, tap Set A where the slice should "
        + "start and Set B where it should end. The 1s and 5s buttons nudge each mark, and Loop "
        + "A-B plays the slice on repeat while you fine tune it." },

        { "The bell",
          "Put a bell between two silences and you have a session you can follow with your eyes "
        + "closed: sit for five minutes, hear the chime, change your breathing, sit for five "
        + "more.\n\n"
        + "There are three voices, and it can ring more than once with a gap you choose. Tap "
        + "Hear it while you set it up. The tone fades in softly and rings out slowly, so it "
        + "marks the moment without jolting you." },

        { "Running a program",
          "Press play next to a program on the home screen, or Run inside the editor. While it "
        + "runs you can pause, jump to the previous or next step, tap any step to go straight to "
        + "it, and drag the progress bar to move inside the current track.\n\n"
        + "Playback keeps going when you leave the app or lock the phone. The notification and "
        + "the lock screen carry the same controls." },

        { "The full screen player",
          "Tap the strip at the bottom while something is playing and it opens full screen, with "
        + "large controls you can find without looking and the time in big figures.\n\n"
        + "The moon button dims the screen right down for a dark room; a tap anywhere brings it "
        + "back." },

        { "Repeating everything",
          "In the editor, Repeat program says how many times the whole list runs. Set it to "
        + "forever for an endless session." },

        { "Settings worth knowing",
          "Count in gives you a few seconds of silence before step one, handy if you need to "
        + "pick up an instrument.\n"
        + "Stop after is a sleep timer that ends everything after a set number of minutes.\n"
        + "Fade at edges softens the jump when a loop restarts.\n"
        + "Keep the CPU awake holds the processor on so long silences stay exact.\n"
        + "Pausing for calls and for unplugged headphones is on by default." },

        { "If a track goes missing",
          "Steps remember the track itself, so reordering or renaming tracks never breaks a "
        + "program. If a file is deleted or its storage is unavailable, Riola tells you which "
        + "steps are affected before it starts playing, and those steps are skipped rather than "
        + "stopping the session." },

        { "Privacy",
          "Everything stays on the phone. Riola has no network permission at all, no accounts "
        + "and no analytics." }
    };
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
 * One instance per process, so the screens and the foreground service always
 * look at the same playback.
 */
public class Engine {

    /** Snapshot of what the engine is doing; read by the UI and the notification. */
    public static class St {
        public boolean running, paused, preview, resting;
        public String programId = "", programName = "";
        public int  step, steps;
        public String stepTitle = "", stepDetail = "";
        public String trackUri = "";     // what is loaded right now, "" for silence and bells
        public int  posMs, durMs;
        public long stepRemainMs = -1;   // -1 = not time limited
        public long progRemainMs = -1;
        public int  repDone;
        public int  repTotal = -1;       // -1 = not count limited
        public int  loopDone;
        public int  loopTotal = 1;       // -1 = forever
        public int  countIn = -1;        // seconds left before the first step
        public int  skipped;             // steps passed over because the track was gone
        public boolean shuffled;         // playing in a random order
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
    private final Bell bell = new Bell();
    private String loadedUri = "";
    private Thread worker;
    private final List<Step> steps = new ArrayList<Step>();
    private int loops = 1;

    private volatile boolean stopReq, paused, running, completed, pushPending;
    private volatile int skip;          // -1 previous step, +1 next step, 2 jump
    private volatile int jump = -1;
    private volatile int idx;           // a position in order[], not a step number
    private volatile int[] order;
    private volatile boolean shuffled;
    private volatile int gen;           // run id, so a restart cannot fire the old "finished"
    private volatile float duck = 1f;
    private volatile float gain = 1f;   // fade envelope
    private volatile float vol = 1f;    // master volume
    private volatile float speed = 1f;  // master speed
    private volatile float stepVol = 1f, stepSpeed = 1f;
    private volatile long fadeMs = 150;
    private volatile long deadline = -1;

    private Engine(Context c) {
        ctx = c;
        prefs = new Prefs(c);
    }

    // ---- listeners -------------------------------------------------------
    public void addListener(Listener l)    { if (l != null && !listeners.contains(l)) listeners.add(l); }
    public void removeListener(Listener l) { listeners.remove(l); }

    public boolean isRunning() { return running; }
    public boolean isPaused()  { return paused; }
    public String  logText()   { synchronized (logBuf) { return logBuf.toString(); } }
    public void    clearLog()  { synchronized (logBuf) { logBuf.setLength(0); } }

    /** True when this exact program is the one playing. */
    public boolean isPlaying(Program p) {
        return running && p != null && p.id.equals(st.programId);
    }

    // ---- control ---------------------------------------------------------
    public void start(Program p, int fromStep) {
        if (p == null) return;
        if (p.enabledCount() == 0) {
            log("nothing to play - every step is switched off");
            return;
        }
        stop();
        steps.clear();
        for (int i = 0; i < p.steps.size(); i++) steps.add(p.steps.get(i).copy());
        loops = p.loops;
        st.programId = p.id;
        st.programName = p.name;
        st.preview = false;
        begin(Math.max(0, Math.min(fromStep, steps.size() - 1)));
    }

    public void previewTrack(Track t) {
        if (t == null) return;
        stop();
        steps.clear();
        steps.add(Step.play(t));
        loops = 1;
        st.programId = "";
        st.programName = "Preview";
        st.preview = true;
        begin(0);
    }

    private void begin(int from) {
        vol = prefs.volume() / 100f;
        speed = prefs.speed();
        fadeMs = prefs.fadeMs();
        duck = 1f;
        gain = 1f;
        stepVol = 1f;
        stepSpeed = 1f;
        buildOrder(shuffled, -1);
        idx = from;
        if (shuffled) {
            for (int i = 0; i < order.length; i++) if (order[i] == from) { idx = i; break; }
        }
        st.shuffled = shuffled;
        stopReq = false;
        paused = false;
        skip = 0;
        jump = -1;
        running = true;
        st.running = true;
        st.paused = false;
        st.steps = steps.size();
        st.step = idx;
        st.loopDone = 0;
        st.loopTotal = loops;
        st.countIn = -1;
        st.skipped = 0;
        int stopMin = st.preview ? 0 : prefs.autoStopMin();
        deadline = stopMin > 0 ? SystemClock.elapsedRealtime() + stopMin * 60000L : -1;
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
        bell.stop();
        releasePlayer();
        st.running = false;
        st.paused = false;
        st.resting = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.repTotal = -1;
        st.countIn = -1;
        push();
    }

    public void setPaused(boolean p) {
        if (!running || paused == p) return;
        paused = p;
        st.paused = p;
        if (p) bell.stop();     // a chime from a previous step can still be ringing
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

    /** Takes a step number and finds where it sits in the order being played. */
    public void jumpTo(int stepIndex) {
        if (!running || stepIndex < 0 || stepIndex >= steps.size()) return;
        int at = stepIndex;
        int[] o = order;
        if (o != null) {
            for (int i = 0; i < o.length; i++) if (o[i] == stepIndex) { at = i; break; }
        }
        jump = at;
        skip = 2;
        wake();
    }

    public void seekTo(int ms) {
        MediaPlayer m = mp;
        if (m == null) return;
        try { m.seekTo(ms); } catch (IllegalStateException e) { /* ignore */ }
    }

    public boolean isShuffled() { return shuffled; }

    /**
     * Play the steps in a random order. The step that is playing stays put and
     * everything after it is reshuffled, so turning it on does not cut off what
     * you are listening to. The program itself is never rewritten.
     */
    public void setShuffle(boolean on) {
        shuffled = on;
        st.shuffled = on;
        if (!running || order == null) { push(); return; }
        int current = (idx >= 0 && idx < order.length) ? order[idx] : 0;
        buildOrder(on, current);
        idx = on ? 0 : current;
        log(on ? "shuffled" : "back to the written order");
        push();
    }

    private void buildOrder(boolean shuffle, int keepFirst) {
        int n = steps.size();
        int[] o = new int[n];
        for (int i = 0; i < n; i++) o[i] = i;
        if (shuffle && n > 1) {
            java.util.Random r = new java.util.Random();
            for (int i = n - 1; i > 0; i--) {
                int j = r.nextInt(i + 1);
                int t = o[i]; o[i] = o[j]; o[j] = t;
            }
            if (keepFirst >= 0) {
                for (int i = 0; i < n; i++) {
                    if (o[i] == keepFirst) { int t = o[0]; o[0] = o[i]; o[i] = t; break; }
                }
            }
        }
        order = o;
    }

    public void setDuck(float d) { duck = d; applyVol(); }
    public void setMasterVolume(int percent) { vol = percent / 100f; applyVol(); }
    public void setMasterSpeed(int percent)  { speed = percent / 100f; applySpeed(); }

    // ---- worker ----------------------------------------------------------
    private void loop(final int myGen) {
        log("started: " + st.programName);
        countIn();

        int pass = 0;
        int playedThisPass = 0;
        while (!stopReq) {
            if (expired()) break;
            if (order == null || idx >= order.length) {
                pass++;
                if (playedThisPass == 0) break;                 // nothing runnable, do not spin
                if (loops >= 0 && pass >= Math.max(1, loops)) break;
                // a fresh shuffle each time round, which is what a playlist does
                if (shuffled) buildOrder(true, -1);
                idx = 0;
                playedThisPass = 0;
                st.loopDone = pass;
                log("loop " + (pass + 1) + (loops < 0 ? "" : " of " + loops));
                continue;
            }
            if (idx < 0) idx = 0;
            int stepAt = order[idx];
            Step s = steps.get(stepAt);
            if (!s.enabled) { idx++; continue; }

            playedThisPass++;
            st.step = stepAt;
            st.steps = steps.size();
            st.stepTitle = s.title();
            st.stepDetail = s.detail();
            st.trackUri = s.needsTrack() ? s.trackUri : "";
            st.repDone = 0;
            // clear the previous step's clock so the bar cannot flash its numbers
            st.posMs = 0;
            st.durMs = 0;
            st.repTotal = s.timed() ? -1 : Math.max(1, s.times);
            st.stepRemainMs = s.timed() ? s.durMs : -1;
            st.resting = s.type == Step.SILENCE;
            stepVol = Math.max(0f, s.volumePct / 100f);
            stepSpeed = Math.max(0.25f, s.speedPct / 100f);
            push();
            log("step " + (idx + 1) + "/" + steps.size() + ": " + s.title() + " - " + s.detail());

            long rest = restEst(idx + 1);
            if (s.type == Step.SILENCE) {
                pausePlayer();
                silence(s.durMs, rest, true);
                // the chime rings on into whatever comes next, which is exactly
                // what you want when the next step is more silence
                if (s.endBell && !stopReq && skip == 0) bell.ring(s.tone, vol * stepVol * duck);
            } else if (s.type == Step.BELL) {
                pausePlayer();
                bellStep(s, rest);
            } else {
                segment(s, rest);
            }

            int sk = skip;
            skip = 0;
            if (stopReq) break;
            if (sk == 2)       { idx = jump; jump = -1; }
            else if (sk == -1) { idx = idx - 1; }
            else               { idx = idx + 1; }
        }

        boolean finished = !stopReq;
        pausePlayer();
        bell.stop();
        releasePlayer();
        running = false;
        st.running = false;
        st.paused = false;
        st.resting = false;
        st.posMs = 0;
        st.durMs = 0;
        st.stepRemainMs = -1;
        st.progRemainMs = -1;
        st.countIn = -1;
        st.stepTitle = finished ? "Finished" : "Stopped";
        st.stepDetail = "";
        log(finished ? "finished" : "stopped");
        push();
        final boolean done = finished;
        main.post(new Runnable() {
            public void run() {
                if (myGen != gen) return;      // a new run already took over
                for (Listener l : listeners) l.onFinished(done);
            }
        });
    }

    private boolean expired() {
        if (deadline > 0 && SystemClock.elapsedRealtime() >= deadline) {
            log("stop timer reached");
            stopReq = true;
            return true;
        }
        return false;
    }

    private void countIn() {
        int secs = st.preview ? 0 : prefs.countIn();
        if (secs <= 0) return;
        log("starting in " + secs + "s");
        for (int i = secs; i > 0 && !stopReq && skip == 0; i--) {
            st.countIn = i;
            st.stepTitle = "Starting in " + i;
            st.stepDetail = "get ready";
            push();
            waitLock(1000);
        }
        st.countIn = -1;
    }

    private long restEst(int from) {
        long t = 0;
        for (int i = from; i < steps.size(); i++) t += steps.get(i).estMs();
        return t;
    }

    /** Silence that still answers pause / skip / stop. */
    private void silence(long total, long rest, boolean showProgress) {
        long remain = total;
        long last = SystemClock.elapsedRealtime();
        while (remain > 0) {
            if (stopReq || skip != 0 || expired()) return;
            waitLock(200);
            long now = SystemClock.elapsedRealtime();
            long d = now - last;
            last = now;
            if (!paused) remain -= d;
            if (showProgress) {
                st.posMs = (int) Math.min(Integer.MAX_VALUE, total - remain);
                st.durMs = (int) Math.min(Integer.MAX_VALUE, total);
                st.stepRemainMs = Math.max(0, remain);
                st.progRemainMs = rest + Math.max(0, remain);
                push();
            }
        }
    }

    /** A gentle marker: one or more strikes, with an optional gap between them. */
    private void bellStep(Step step, long rest) {
        int strikes = Math.max(1, step.times);
        long len = Bell.lengthMs(step.tone);
        st.repTotal = strikes;
        st.durMs = (int) len;

        for (int i = 0; i < strikes; i++) {
            if (stopReq || skip != 0 || expired()) { bell.stop(); return; }
            st.repDone = i;
            bell.ring(step.tone, vol * stepVol * duck);

            long remain = len;
            long last = SystemClock.elapsedRealtime();
            while (remain > 0) {
                if (stopReq || skip != 0 || expired()) { bell.stop(); return; }
                waitLock(100);
                long now = SystemClock.elapsedRealtime();
                long d = now - last;
                last = now;
                if (paused) {
                    // let it fall silent, then strike again when we resume
                    bell.stop();
                    while (paused && !stopReq && skip == 0) waitLock(150);
                    if (stopReq || skip != 0) return;
                    bell.ring(step.tone, vol * stepVol * duck);
                    remain = len;
                    last = SystemClock.elapsedRealtime();
                    continue;
                }
                remain -= d;
                st.posMs = (int) Math.max(0, len - remain);
                st.stepRemainMs = Math.max(0, remain) + (long) (strikes - 1 - i) * (len + step.gapMs);
                st.progRemainMs = rest + st.stepRemainMs;
                push();
            }
            if (i < strikes - 1 && step.gapMs > 0) {
                st.resting = true;
                push();
                silence(step.gapMs, rest, false);
                st.resting = false;
                if (stopReq || skip != 0) return;
            }
        }
        st.repDone = strikes;
    }

    /** A whole track or an A-B slice, repeated a number of times or for a while. */
    private void segment(Step step, long rest) {
        Track track = step.track();
        if (track == null) {
            st.skipped++;
            log("  ! that track is not in the library any more - skipped");
            waitLock(400);
            return;
        }
        if (!open(track)) {
            st.skipped++;
            Store.MISSING.add(track.uri);
            return;
        }
        Store.MISSING.remove(track.uri);

        long dur = duration();
        boolean known = dur > 0;
        long end;
        if (step.type == Step.SECTION && step.b > 0) end = known ? Math.min(step.b, dur) : step.b;
        else end = known ? dur : Long.MAX_VALUE / 4;
        long start = step.type == Step.SECTION ? Math.max(0, step.a) : 0;
        if (known && start >= end - 150) {
            log("  ! that section falls outside the track - skipped");
            return;
        }

        long budget = step.timed() ? step.durMs : -1;
        long remain = budget;
        long fade = Math.min(fadeMs, Math.max(0, (end - start) / 4));
        int rep = 0;

        applySpeed();
        startAt(start);
        long grace = SystemClock.elapsedRealtime() + 400;
        long last = SystemClock.elapsedRealtime();

        while (true) {
            if (stopReq || skip != 0 || expired()) { pausePlayer(); setGain(1f); return; }

            int pos = position();
            waitLock(end - pos < 500 ? 20 : 120);

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
                    setGain(1f);
                    log("  time is up after " + (rep + 1) + " pass(es)");
                    return;
                }
            } else {
                long left = Math.max(0, end - position());
                long more = Math.max(0, (long) (Math.max(1, step.times) - 1 - rep)) * (end - start);
                st.progRemainMs = rest + left + more;
            }

            pos = position();
            st.posMs = pos;
            st.durMs = known ? (int) dur : pos;
            st.repDone = rep;

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
            if (!step.timed() && rep >= Math.max(1, step.times)) {
                pausePlayer();
                setGain(1f);
                log("  played " + rep + " time(s)");
                return;
            }
            if (budget > 0 && remain <= 0) { pausePlayer(); setGain(1f); return; }

            if (step.gapMs > 0) {
                pausePlayer();
                setGain(1f);
                st.resting = true;
                push();
                silence(step.gapMs, rest, false);
                st.resting = false;
                if (stopReq || skip != 0) return;
                last = SystemClock.elapsedRealtime();
            }
            setGain(fade > 0 ? 0.02f : 1f);
            startAt(start);
            grace = SystemClock.elapsedRealtime() + 400;
            last = SystemClock.elapsedRealtime();
        }
    }

    // ---- MediaPlayer plumbing -------------------------------------------
    private boolean open(Track t) {
        MediaPlayer m = mp;
        if (m != null && loadedUri.equals(t.uri)) {
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
            // No Surface is ever attached, so a video file simply plays its
            // sound. Where there is more than one audio stream - a dubbed film,
            // say - use the one chosen for this track.
            if (t.audioTrack >= 0) {
                try { m.selectTrack(t.audioTrack); } catch (Exception e) {
                    log("  ! could not switch to audio stream " + t.audioTrack);
                }
            }
            mp = m;
            loadedUri = t.uri;
            applyVol();
            return true;
        } catch (Exception e) {
            log("  ! cannot open " + t.shortTitle() + " (" + e.getClass().getSimpleName() + ")");
            try { if (m != null) m.release(); } catch (Exception ignored) { }
            mp = null;
            loadedUri = "";
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
        loadedUri = "";
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

    private void setGain(float g) { gain = g; applyVol(); }

    private void applyVol() {
        MediaPlayer m = mp;
        if (m == null) return;
        float v = vol * stepVol * duck * gain;
        if (v < 0f) v = 0f;
        if (v > 1f) v = 1f;
        try { m.setVolume(v, v); } catch (IllegalStateException e) { /* ignore */ }
    }

    private void applySpeed() {
        MediaPlayer m = mp;
        if (m == null) return;
        try {
            if (!m.isPlaying()) return;
            float f = speed * stepSpeed;
            if (f < 0.25f) f = 0.25f;
            if (f > 3f) f = 3f;
            PlaybackParams pp = m.getPlaybackParams();
            pp.setSpeed(f);
            m.setPlaybackParams(pp);
        } catch (Exception e) { /* the device refused the speed change */ }
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
            @Override public void onPlay()           { engine.setPaused(false); }
            @Override public void onPause()          { engine.setPaused(true); }
            @Override public void onStop()           { engine.stop(); shutdown(); }
            @Override public void onSkipToNext()     { engine.next(); }
            @Override public void onSkipToPrevious() { engine.prev(); }
            @Override public void onSeekTo(long p)   { engine.seekTo((int) p); }
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

    // ---- engine callbacks ------------------------------------------------
    @Override public void onState(Engine.St s) { post(false); }
    @Override public void onLog(String line) { }
    @Override public void onFinished(boolean completed) { shutdown(); }

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
        String key = s.stepTitle + "|" + s.stepDetail + "|" + s.paused + "|" + s.running + "|" + s.step;
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

        StringBuilder sub = new StringBuilder();
        if (s.running) {
            sub.append(s.programName == null || s.programName.length() == 0 ? "Riola" : s.programName);
            if (!s.preview) sub.append("  .  step ").append(s.step + 1).append(" of ").append(s.steps);
            if (s.loopTotal < 0) sub.append("  .  loop ").append(s.loopDone + 1);
            else if (s.loopTotal > 1) sub.append("  .  loop ").append(s.loopDone + 1).append(" of ").append(s.loopTotal);
            if (s.stepRemainMs >= 0) sub.append("  .  ").append(Fmt.human(s.stepRemainMs)).append(" left");
            else if (s.repTotal > 1) sub.append("  .  pass ").append(Math.min(s.repDone + 1, s.repTotal))
                                        .append(" of ").append(s.repTotal);
        } else {
            sub.append("Idle");
        }

        Notification.Builder b = new Notification.Builder(this, CHANNEL)
                .setSmallIcon(R.drawable.ic_note)
                .setContentTitle(s.stepTitle == null || s.stepTitle.length() == 0 ? "Riola" : s.stepTitle)
                .setContentText(s.stepDetail)
                .setSubText(sub.toString())
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
                    .putString(MediaMetadata.METADATA_KEY_TITLE, s.stepTitle)
                    .putString(MediaMetadata.METADATA_KEY_ARTIST, s.programName)
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
# Java: shared transport bar and picker dialogs
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\PlayerBar.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.view.Gravity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/** The transport strip pinned to the bottom of a screen while a program runs. */
public class PlayerBar implements Engine.Listener {

    public interface Host {
        void onEngineState(Engine.St s);
        void onEngineFinished(boolean completed);
    }

    private final Activity act;
    private final Engine eng;
    private final Host host;

    public final LinearLayout view;
    private final TextView title, detail, badge, time, remain;
    private final SeekBar seek;
    private final ImageView play;
    private ImageView shuffle;
    private boolean dragging;

    public PlayerBar(final Activity a, Host h) {
        act = a;
        host = h;
        eng = Engine.get(a);

        view = Ui.col(a);
        view.setBackgroundColor(Ui.SURF);
        view.setVisibility(View.GONE);
        // consume its own touches: nothing behind the bar should ever react to
        // a drag that started on the scrubber
        view.setClickable(true);
        view.setFocusable(true);

        View top = new View(a);
        top.setLayoutParams(Ui.lp(Ui.MATCH, Math.max(1, Ui.dp(a, 0.7f))));
        top.setBackgroundColor(Ui.LINE);
        view.addView(top);

        LinearLayout inner = Ui.col(a);
        inner.setPadding(Ui.dp(a, 14), Ui.dp(a, 10), Ui.dp(a, 14), Ui.dp(a, 12));
        view.addView(inner);

        LinearLayout line1 = Ui.row(a);
        // the strip is a handle for the full screen player
        line1.setBackground(Ui.ripple(Ui.rr(a, 0x00000000, 10)));
        line1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                try { a.startActivity(new Intent(a, NowPlayingActivity.class)); }
                catch (Exception e) { /* nothing to open */ }
            }
        });
        title = Ui.tv(a, "", 14.5f, Ui.TXT, true);
        Ui.ellipsize(title);
        title.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        line1.addView(title);
        badge = Ui.badge(a, "", Ui.ONACC, Ui.ACC);
        line1.addView(badge);
        inner.addView(line1);

        detail = Ui.tv(a, "", 12, Ui.DIM, false);
        Ui.ellipsize(detail);
        inner.addView(detail);
        line1.addView(Ui.icon(a, Ico.UP, Ui.DIM, 14));

        seek = new SeekBar(a);
        seek.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int p, boolean fromUser) { }
            public void onStartTrackingTouch(SeekBar s) { dragging = true; }
            public void onStopTrackingTouch(SeekBar s) { dragging = false; eng.seekTo(s.getProgress()); }
        });
        Ui.margin(a, seek, 0, 2, 0, 0);
        inner.addView(seek);

        LinearLayout line3 = Ui.row(a);
        time = Ui.mono(a, "0:00 / 0:00", 11, Ui.DIM);
        line3.addView(time);
        line3.addView(Ui.spring(a));
        remain = Ui.tv(a, "", 11, Ui.DIM, false);
        line3.addView(remain);
        inner.addView(line3);

        LinearLayout tr = Ui.row(a);
        tr.setGravity(Gravity.CENTER);
        Ui.margin(a, tr, 0, 6, 0, 0);
        shuffle = Ui.roundBtn(a, Ico.SHUFFLE, 18, false, "Shuffle", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); askShuffle(a, eng); }
        });
        tr.addView(shuffle);
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.PREV, 20, false, "Previous step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.prev(); }
        }));
        tr.addView(Ui.hgap(a, 10));
        play = Ui.roundBtn(a, Ico.PAUSE, 22, true, "Pause", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.togglePause(); }
        });
        tr.addView(play);
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.STOP, 20, false, "Stop", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); stop(); }
        }));
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.NEXT, 20, false, "Next step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.next(); }
        }));
        inner.addView(tr);
    }

    public void attach() {
        eng.addListener(this);
        render(eng.st);
    }

    public void detach() { eng.removeListener(this); }

    public void stop() {
        eng.stop();
        try { act.stopService(new Intent(act, PlayerService.class)); } catch (Exception e) { /* gone */ }
        render(eng.st);
    }

    /** Start the foreground service that keeps playback alive off screen. */
    public static void startService(Activity a) {
        Intent i = new Intent(a, PlayerService.class).setAction(PlayerService.ACT_ATTACH);
        try { a.startForegroundService(i); } catch (Exception e) {
            try { a.startService(i); } catch (Exception ignored) { }
        }
    }

    public void render(Engine.St s) {
        if (!s.running) {
            view.setVisibility(View.GONE);
            return;
        }
        view.setVisibility(View.VISIBLE);
        title.setText(s.stepTitle);
        detail.setText(s.resting && s.stepDetail.length() == 0 ? "resting" : s.stepDetail);

        if (s.countIn > 0) badge.setText("READY");
        else if (s.preview) badge.setText("PREVIEW");
        else badge.setText("STEP " + (s.step + 1) + "/" + s.steps);

        int max = Math.max(1, s.durMs);
        if (!dragging) {
            seek.setMax(max);
            seek.setProgress(Math.min(s.posMs, max));
        }
        time.setText(Fmt.ms(s.posMs) + " / " + Fmt.ms(s.durMs));

        String right = "";
        if (s.stepRemainMs >= 0) right = Fmt.human(s.stepRemainMs) + " left";
        else if (s.repTotal > 1) right = "pass " + Math.min(s.repDone + 1, s.repTotal) + " of " + s.repTotal;
        if (s.loopTotal < 0) right = append(right, "loop " + (s.loopDone + 1));
        else if (s.loopTotal > 1) right = append(right, "loop " + (s.loopDone + 1) + "/" + s.loopTotal);
        if (s.progRemainMs > 0) right = append(right, "~" + Fmt.human(s.progRemainMs) + " to go");
        remain.setText(right);

        Ui.setIcon(play, s.paused ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
        play.setContentDescription(s.paused ? "Resume" : "Pause");
        if (shuffle != null) {
            Ui.setIcon(shuffle, Ico.SHUFFLE, s.shuffled ? Ui.ACC_TXT : Ui.TXT);
            shuffle.setContentDescription(s.shuffled ? "Shuffling, tap to stop" : "Shuffle");
        }
    }

    private String append(String a, String b) { return a.length() == 0 ? b : (a + "  .  " + b); }

    /**
     * Turning shuffle on is worth a question - someone poking the unfamiliar
     * icon should not silently lose the order they built. Turning it off is
     * not, because that is the safe direction.
     */
    static void askShuffle(final android.app.Activity a, final Engine eng) {
        if (eng.isShuffled()) {
            eng.setShuffle(false);
            Ui.toast(a, "Back to the order you built");
            return;
        }
        Ui.dialog(a).setTitle("Shuffle the steps?")
                .setMessage("The steps will play in a random order instead of the order you built, "
                        + "and a new order is drawn each time the program repeats.\n\n"
                        + "Your program is not changed, and you can switch back at any time.")
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Shuffle", new android.content.DialogInterface.OnClickListener() {
                    public void onClick(android.content.DialogInterface d, int w) {
                        eng.setShuffle(true);
                        Ui.toast(a, "Playing in a random order");
                    }
                }).show();
    }

    // ---- engine callbacks ------------------------------------------------
    public void onState(Engine.St s) {
        render(s);
        if (host != null) host.onEngineState(s);
    }

    public void onLog(String line) { }

    public void onFinished(boolean completed) {
        render(eng.st);
        if (host != null) host.onEngineFinished(completed);
    }
}
'@

Write-Src "$PKG_PATH\Runner.java" @'
package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;

import java.util.ArrayList;
import java.util.List;

/**
 * Starts a program. Before any sound comes out it checks that every track the
 * program needs can still be opened, so a file that vanished is reported now
 * rather than silently skipped twenty minutes into a session.
 */
public final class Runner {

    public interface OnStarted { void started(); }

    private Runner() { }

    public static void play(final Activity a, final Program p, final int from, final OnStarted cb) {
        if (p == null) return;
        if (p.enabledCount() == 0) {
            Ui.toast(a, "Add a step first");
            return;
        }
        new Thread(new Runnable() {
            public void run() {
                final List<String> bad = new ArrayList<String>();
                // a program often uses the same file many times over; opening it
                // once per step would be pointless io
                java.util.HashMap<String, Boolean> seen = new java.util.HashMap<String, Boolean>();
                int playable = 0;
                for (int i = 0; i < p.steps.size(); i++) {
                    Step s = p.steps.get(i);
                    if (!s.enabled) continue;
                    if (!s.needsTrack()) { playable++; continue; }
                    Boolean known = seen.get(s.trackUri);
                    if (known == null) {
                        known = Boolean.valueOf(s.track() != null && Store.readable(a, s.trackUri));
                        seen.put(s.trackUri, known);
                    }
                    if (!known.booleanValue()) {
                        String name = s.trackName == null || s.trackName.length() == 0
                                ? "unknown track" : s.trackName;
                        bad.add("Step " + (i + 1) + "  -  " + name);
                    } else {
                        playable++;
                    }
                }
                final int ok = playable;
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    public void run() {
                        if (a.isFinishing() || a.isDestroyed()) return;
                        if (bad.isEmpty()) go(a, p, from, cb);
                        else warn(a, p, from, bad, ok, cb);
                    }
                });
            }
        }, "riola-precheck").start();
    }

    private static void warn(final Activity a, final Program p, final int from,
                             List<String> bad, int playable, final OnStarted cb) {
        StringBuilder sb = new StringBuilder();
        sb.append(playable == 0
                ? "Nothing in this program can play right now:\n\n"
                : "These steps cannot play, so they will be skipped:\n\n");
        for (int i = 0; i < bad.size() && i < 6; i++) sb.append("    ").append(bad.get(i)).append('\n');
        if (bad.size() > 6) sb.append("    ...and ").append(bad.size() - 6).append(" more\n");
        sb.append("\nThe file may have been deleted or moved, or it lives on storage that is not available. "
                + "Open the program and point those steps at a file again.");

        AlertDialog.Builder b = Ui.dialog(a)
                .setTitle(bad.size() == 1 ? "1 step cannot play" : (bad.size() + " steps cannot play"))
                .setMessage(sb.toString())
                .setNegativeButton("Cancel", null);

        if (!(a instanceof EditorActivity)) {
            b.setNeutralButton("Open program", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface d, int w) {
                    a.startActivity(new Intent(a, EditorActivity.class).putExtra("id", p.id));
                }
            });
        }
        if (playable > 0) {
            b.setPositiveButton("Play anyway", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface d, int w) { go(a, p, from, cb); }
            });
        }
        b.show();
    }

    private static void go(Activity a, Program p, int from, OnStarted cb) {
        askNotificationPermission(a);
        p.lastRun = System.currentTimeMillis();
        Store.savePrograms(a);
        Engine.get(a).start(p, from);
        PlayerBar.startService(a);
        if (cb != null) cb.started();
        explainSilentNotifications(a);
    }

    /**
     * On some phones the runtime prompt never appears, because notifications
     * are already switched off for the app - several skins do that to
     * sideloaded apps. Playback still works, but there would be no
     * notification and no lock screen controls and no hint as to why, so say
     * it once and offer the settings page.
     */
    private static void explainSilentNotifications(final Activity a) {
        final Prefs prefs = new Prefs(a);
        if (prefs.notifNagged()) return;
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            public void run() {
                if (a.isFinishing() || a.isDestroyed()) return;
                NotificationManager nm = (NotificationManager) a.getSystemService(Context.NOTIFICATION_SERVICE);
                if (nm == null || nm.areNotificationsEnabled()) return;
                prefs.notifNagged(true);
                Ui.dialog(a)
                        .setTitle("Notifications are off")
                        .setMessage("Riola cannot show its playback notification, so its controls will "
                                + "not appear in the notification shade. The program still plays "
                                + "normally, and your phone's own media controls may still work. "
                                + "Some phones switch notifications off for apps installed outside "
                                + "the store. You can turn them back on in Android settings.")
                        .setNegativeButton("Not now", null)
                        .setPositiveButton("Open settings", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface d, int w) {
                                try {
                                    a.startActivity(new Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                                            .putExtra(Settings.EXTRA_APP_PACKAGE, a.getPackageName()));
                                } catch (Exception e) {
                                    Ui.toast(a, "Could not open notification settings");
                                }
                            }
                        }).show();
            }
        }, 4000);
    }

    public static void askNotificationPermission(Activity a) {
        if (Build.VERSION.SDK_INT >= 33
                && a.checkSelfPermission("android.permission.POST_NOTIFICATIONS")
                   != PackageManager.PERMISSION_GRANTED) {
            a.requestPermissions(new String[]{ "android.permission.POST_NOTIFICATIONS" }, 103);
        }
    }
}
'@

Write-Src "$PKG_PATH\Pickers.java" @'
package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/** Small reusable dialogs: pick a track, a length, a position, or type a name. */
public final class Pickers {

    public interface OnTrack { void picked(Track t); }
    public interface OnMs    { void picked(long ms); }
    public interface OnText  { void picked(String s); }

    private Pickers() { }

    // ---- track -----------------------------------------------------------
    public static void track(final Activity a, String title, final OnTrack cb) {
        if (Store.LIB.isEmpty()) {
            Ui.dialog(a).setTitle("No tracks yet")
                    .setMessage("Add some audio files first and they will show up here.")
                    .setNegativeButton("Not now", null)
                    .setPositiveButton("Add tracks", new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface d, int w) {
                            a.startActivity(new android.content.Intent(a, LibraryActivity.class));
                        }
                    }).show();
            return;
        }

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 12);
        box.setPadding(p, p, p, p);

        final LinearLayout list = Ui.col(a);
        final AlertDialog[] holder = new AlertDialog[1];

        if (Store.LIB.size() > 7) {
            final EditText search = new EditText(a);
            search.setHint("Search tracks");
            search.setSingleLine(true);
            search.setTextColor(Ui.TXT);
            search.setHintTextColor(Ui.DIM);
            search.setInputType(InputType.TYPE_CLASS_TEXT);
            search.addTextChangedListener(new TextWatcher() {
                public void beforeTextChanged(CharSequence s, int x, int y, int z) { }
                public void onTextChanged(CharSequence s, int x, int y, int z) { }
                public void afterTextChanged(Editable e) {
                    fill(a, list, e.toString(), holder, cb);
                }
            });
            box.addView(search);
        }
        box.addView(list);
        fill(a, list, "", holder, cb);

        ScrollView sv = new ScrollView(a);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = Ui.dialog(a).setTitle(title).setView(sv)
                .setNegativeButton("Cancel", null)
                .setNeutralButton("Manage tracks", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        a.startActivity(new android.content.Intent(a, LibraryActivity.class));
                    }
                }).create();
        holder[0].show();
    }

    private static void fill(final Activity a, LinearLayout list, String query,
                             final AlertDialog[] holder, final OnTrack cb) {
        list.removeAllViews();
        String q = query.toLowerCase().trim();
        int shown = 0;
        for (int i = 0; i < Store.LIB.size(); i++) {
            final Track t = Store.LIB.get(i);
            if (q.length() > 0 && !t.shortTitle().toLowerCase().contains(q)) continue;
            shown++;
            LinearLayout r = Ui.row(a);
            r.setBackground(Ui.ripple(Ui.rr(a, Ui.SURF2, 10)));
            r.setPadding(Ui.dp(a, 12), Ui.dp(a, 10), Ui.dp(a, 12), Ui.dp(a, 10));
            Ui.margin(a, r, 0, 0, 0, 6);
            r.addView(Ui.icon(a, Ico.NOTE, Ui.ACC_TXT, 16));
            r.addView(Ui.hgap(a, 10));
            LinearLayout col = Ui.col(a);
            col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            TextView name = Ui.tv(a, t.shortTitle(), 14, Ui.TXT, false);
            Ui.ellipsize(name);
            col.addView(name);
            col.addView(Ui.tv(a, t.durMs > 0 ? Fmt.ms(t.durMs) : "length unknown", 11, Ui.DIM, false));
            r.addView(col);
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (holder[0] != null) holder[0].dismiss();
                    cb.picked(t);
                }
            });
            list.addView(r);
        }
        if (shown == 0) list.addView(Ui.tv(a, "Nothing matches that.", 13, Ui.DIM, false));
    }

    // ---- length ----------------------------------------------------------
    public static void duration(final Activity a, String title, long ms, final OnMs cb) {
        final long[] value = { Math.max(0, ms) };

        final LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final Runnable[] render = new Runnable[1];
        render[0] = new Runnable() {
            public void run() { fillDuration(a, box, value, render[0]); }
        };
        render[0].run();

        ScrollView sv = new ScrollView(a);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        Ui.dialog(a).setTitle(title).setView(sv)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Set", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.picked(value[0]); }
                }).show();
    }

    /**
     * Rebuilt whenever a preset is tapped. The steppers keep their own internal
     * counter, so redrawing is the only way to stop them showing a stale number.
     */
    private static void fillDuration(final Activity a, final LinearLayout box,
                                     final long[] value, final Runnable again) {
        box.removeAllViews();

        final TextView shown = Ui.tv(a, Fmt.ms(value[0]), 30, Ui.ACC_TXT, true);
        shown.setGravity(Gravity.CENTER);
        shown.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(shown);

        LinearLayout quick = Ui.row(a);
        final int[] presets = { 15, 30, 60, 120, 300, 600, 1200 };
        for (int i = 0; i < presets.length; i++) {
            final int secs = presets[i];
            quick.addView(Ui.chip(a, secs < 60 ? (secs + "s") : ((secs / 60) + "m"),
                    value[0] == secs * 1000L, new View.OnClickListener() {
                public void onClick(View v) {
                    value[0] = secs * 1000L;
                    again.run();
                }
            }));
        }
        android.widget.HorizontalScrollView row = new android.widget.HorizontalScrollView(a);
        row.setHorizontalScrollBarEnabled(false);
        row.addView(quick, new FrameLayout.LayoutParams(Ui.WRAP, Ui.WRAP));
        Ui.margin(a, row, 0, 8, 0, 4);
        box.addView(row);

        box.addView(labelled(a, "Minutes", Ui.stepper(a, (int) (value[0] / 60000L), 0, 600, 1, "",
                new Ui.OnValue() {
            public void set(int v) {
                value[0] = v * 60000L + (value[0] % 60000L);
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(labelled(a, "Seconds", Ui.stepper(a, (int) ((value[0] % 60000L) / 1000L), 0, 55, 5, "",
                new Ui.OnValue() {
            public void set(int v) {
                value[0] = (value[0] / 60000L) * 60000L + v * 1000L;
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(Ui.gap(a, 6));
    }

    // ---- position inside a track ----------------------------------------
    public static void position(final Activity a, String title, long ms, long maxMs, final OnMs cb) {
        final long[] value = { Math.max(0, ms) };
        final long cap = maxMs > 0 ? maxMs : 24L * 3600000L;

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final TextView shown = Ui.tv(a, Fmt.ms(value[0]), 30, Ui.ACC_TXT, true);
        shown.setGravity(Gravity.CENTER);
        shown.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(shown);
        if (maxMs > 0) {
            TextView cap2 = Ui.tv(a, "track is " + Fmt.ms(maxMs) + " long", 11.5f, Ui.DIM, false);
            cap2.setGravity(Gravity.CENTER);
            cap2.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            box.addView(cap2);
        }

        box.addView(labelled(a, "Minutes", Ui.stepper(a, (int) (value[0] / 60000L), 0, (int) (cap / 60000L) + 1, 1, "", new Ui.OnValue() {
            public void set(int v) {
                value[0] = Math.min(cap, v * 60000L + (value[0] % 60000L));
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(labelled(a, "Seconds", Ui.stepper(a, (int) ((value[0] % 60000L) / 1000L), 0, 59, 1, "", new Ui.OnValue() {
            public void set(int v) {
                value[0] = Math.min(cap, (value[0] / 60000L) * 60000L + v * 1000L);
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(Ui.gap(a, 6));

        Ui.dialog(a).setTitle(title).setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Set", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.picked(value[0]); }
                }).show();
    }

    // ---- text ------------------------------------------------------------
    public static void text(final Activity a, String title, String value, String hint, final OnText cb) {
        final EditText in = new EditText(a);
        in.setSingleLine(true);
        in.setHint(hint);
        in.setText(value == null ? "" : value);
        in.setSelectAllOnFocus(true);
        in.selectAll();          // typing replaces the suggestion instead of appending
        in.setTextColor(Ui.TXT);
        in.setHintTextColor(Ui.DIM);
        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 20);
        box.setPadding(p, Ui.dp(a, 8), p, 0);
        box.addView(in);
        Ui.dialog(a).setTitle(title).setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        String s = in.getText().toString().trim();
                        if (s.length() == 0) { Ui.toast(a, "Give it a name"); return; }
                        cb.picked(s);
                    }
                }).show();
    }

    private static View labelled(Activity a, String label, View control) {
        LinearLayout r = Ui.row(a);
        Ui.margin(a, r, 0, 6, 0, 0);
        TextView t = Ui.tv(a, label, 13.5f, Ui.DIM, false);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(t);
        control.setLayoutParams(Ui.lp(Ui.dp(a, 170), Ui.WRAP));
        r.addView(control);
        return r;
    }
}
'@

# ---------------------------------------------------------------------------
# Java: exporting and importing programs
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\Backup.java" @'
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
'@

# ---------------------------------------------------------------------------
# Java: home screen (saved programs)
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\MainActivity.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/** Home: the saved programs, each with a play button. */
public class MainActivity extends Activity implements PlayerBar.Host {

    private static final int REQ_NOTIF = 103, REQ_EXPORT = 201, REQ_IMPORT = 202;

    private Prefs prefs;
    private Engine eng;
    private PlayerBar bar;

    private LinearLayout programsBox, liveCard, liveSteps, emptyBox;
    private TextView tracksLine, liveTitle;
    private final List<View> liveRows = new ArrayList<View>();
    private boolean wasRunning;
    private String liveProgramId = "";
    /** Survives the recreate() that a theme change triggers. */
    private static boolean reopenSettings;

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes(prefs.dark()));
        super.onCreate(saved);
        Store.load(this);
        eng = Engine.get(this);
        Bell.warm();
        setContentView(build());
        Ui.applyWindow(this);
        if (reopenSettings) {
            reopenSettings = false;
            settings();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        bar.attach();
        if (prefs.keepScreenOn()) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        else getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        refresh();
    }

    @Override
    protected void onPause() {
        bar.detach();
        super.onPause();
    }

    // ======================================================================
    // layout
    // ======================================================================
    private View build() {
        LinearLayout root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        View[] actions = {
            Ui.iconBtn(this, Ico.HELP, Ui.DIM, 20, "Help", new View.OnClickListener() {
                public void onClick(View v) { help(); }
            }),
            Ui.iconBtn(this, Ico.GEAR, Ui.DIM, 20, "Settings", new View.OnClickListener() {
                public void onClick(View v) { settings(); }
            })
        };
        root.addView(Ui.appBar(this, Ico.NOTE, "Riola", "programmable music player", false, actions).view);

        LinearLayout body = Ui.col(this);

        // tracks shortcut
        LinearLayout tracks = Ui.card(this);
        tracks.setPadding(Ui.dp(this, 14), Ui.dp(this, 4), Ui.dp(this, 10), Ui.dp(this, 4));
        LinearLayout tr = Ui.row(this);
        tr.setBackground(Ui.ripple(Ui.rr(this, 0x00000000, 12)));
        tr.setPadding(0, Ui.dp(this, 12), 0, Ui.dp(this, 12));
        tr.addView(Ui.icon(this, Ico.NOTE, Ui.ACC_TXT, 18));
        tr.addView(Ui.hgap(this, 12));
        LinearLayout tcol = Ui.col(this);
        tcol.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        tcol.addView(Ui.tv(this, "Tracks", 15, Ui.TXT, true));
        tracksLine = Ui.tv(this, "", 12, Ui.DIM, false);
        tcol.addView(tracksLine);
        tr.addView(tcol);
        tr.addView(Ui.icon(this, Ico.RIGHT, Ui.DIM, 14));
        tr.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { startActivity(new Intent(MainActivity.this, LibraryActivity.class)); }
        });
        tracks.addView(tr);
        body.addView(tracks);

        // live step list while a program runs
        liveCard = Ui.card(this);
        LinearLayout lh = Ui.row(this);
        LinearLayout lhd = Ui.heading(this, Ico.WAVE, "Now playing");
        lhd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        lh.addView(lhd);
        liveTitle = Ui.badge(this, "", Ui.ONACC, Ui.ACC2);
        lh.addView(liveTitle);
        lh.setBackground(Ui.ripple(Ui.rr(this, 0x00000000, 10)));
        lh.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (eng.isRunning()) startActivity(new Intent(MainActivity.this, NowPlayingActivity.class));
            }
        });
        liveCard.addView(lh);
        liveSteps = Ui.col(this);
        liveCard.addView(liveSteps);
        liveCard.setVisibility(View.GONE);
        body.addView(liveCard);

        // programs
        LinearLayout progs = Ui.card(this);
        progs.addView(Ui.heading(this, Ico.PROGRAM, "Programs"));
        programsBox = Ui.col(this);
        progs.addView(programsBox);
        emptyBox = Ui.col(this);
        progs.addView(emptyBox);
        LinearLayout add = Ui.btn(this, "New program", Ico.PLUS, Ui.PRIMARY, new View.OnClickListener() {
            public void onClick(View v) { newProgram(); }
        });
        add.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, add, 0, 10, 0, 0);
        progs.addView(add);

        LinearLayout io = Ui.row(this);
        Ui.margin(this, io, 0, 4, 0, 0);
        LinearLayout exportAll = Ui.btn(this, "Export all", Ico.SAVE, Ui.GHOST, new View.OnClickListener() {
            public void onClick(View v) { Backup.exportAll(MainActivity.this, REQ_EXPORT); }
        });
        exportAll.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        io.addView(exportAll);
        LinearLayout importOne = Ui.btn(this, "Import", Ico.OPEN, Ui.GHOST, new View.OnClickListener() {
            public void onClick(View v) { Backup.pickToImport(MainActivity.this, REQ_IMPORT); }
        });
        importOne.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        io.addView(importOne);
        progs.addView(io);

        body.addView(progs);

        body.addView(Ui.gap(this, 6));
        root.addView(Ui.scroller(this, body));

        bar = new PlayerBar(this, this);
        root.addView(bar.view);
        return root;
    }

    // ======================================================================
    // programs
    // ======================================================================
    private void refresh() {
        int n = Store.LIB.size();
        tracksLine.setText(n == 0 ? "none yet - tap to add music"
                                  : (n + (n == 1 ? " track" : " tracks") + " - tap to manage"));

        programsBox.removeAllViews();
        emptyBox.removeAllViews();
        if (Store.PROGRAMS.isEmpty()) {
            emptyBox.addView(Ui.emptyState(this, Ico.PROGRAM, "No programs yet",
                    "A program is a list of steps: play a track, loop a section, rest, repeat."));
            if (!Store.LIB.isEmpty()) {
                LinearLayout sample = Ui.btn(this, "Create an example program", Ico.COPY, Ui.SECONDARY,
                        new View.OnClickListener() {
                            public void onClick(View v) {
                                Program p = Store.sample();
                                Store.put(MainActivity.this, p);
                                refresh();
                                open(p);
                            }
                        });
                sample.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
                emptyBox.addView(sample);
            }
        } else {
            for (int i = 0; i < Store.PROGRAMS.size(); i++) {
                programsBox.addView(programRow(Store.PROGRAMS.get(i)));
            }
        }
        wasRunning = eng.isRunning();
        buildLive();
        bar.render(eng.st);
    }

    private View programRow(final Program p) {
        final boolean playing = eng.isPlaying(p);

        LinearLayout r = Ui.row(this);
        r.setBackground(Ui.ripple(playing ? Ui.rrs(this, Ui.SURF2, Ui.ACC_TXT, 14, 1.4f)
                                          : Ui.rr(this, Ui.SURF2, 14)));
        r.setPadding(Ui.dp(this, 10), Ui.dp(this, 10), Ui.dp(this, 4), Ui.dp(this, 10));
        Ui.margin(this, r, 0, 0, 0, 8);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { open(p); }
        });
        r.setOnLongClickListener(new View.OnLongClickListener() {
            public boolean onLongClick(View v) { menu(p); return true; }
        });

        ImageView go = Ui.roundBtn(this, playing ? Ico.STOP : Ico.PLAY, 20, true,
                playing ? "Stop" : "Play " + p.name, new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                if (eng.isPlaying(p)) bar.stop();
                else run(p, 0);
                refresh();
            }
        });
        r.addView(go);
        r.addView(Ui.hgap(this, 12));

        LinearLayout col = Ui.col(this);
        col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        TextView name = Ui.tv(this, p.name, 15.5f, Ui.TXT, true);
        Ui.ellipsize(name);
        col.addView(name);
        TextView sum = Ui.tv(this, p.summary(), 12, Ui.DIM, false);
        Ui.ellipsize(sum);
        col.addView(sum);
        LinearLayout tags = Ui.row(this);
        if (playing) {
            tags.addView(Ui.badge(this, "PLAYING", Ui.ONACC, Ui.GREEN));
            tags.addView(Ui.hgap(this, 6));
        }
        if (p.hasMissing()) {
            tags.addView(Ui.badge(this, "MISSING TRACK", Ui.ONACC, Ui.AMBER));
            tags.addView(Ui.hgap(this, 6));
        }
        if (p.lastRun > 0) tags.addView(Ui.tv(this, "last run " + Fmt.ago(p.lastRun), 11, Ui.DIM, false));
        if (tags.getChildCount() > 0) {
            Ui.margin(this, tags, 0, 4, 0, 0);
            col.addView(tags);
        }
        r.addView(col);

        r.addView(Ui.iconBtn(this, Ico.MORE, Ui.DIM, 16, "More options", new View.OnClickListener() {
            public void onClick(View v) { menu(p); }
        }));
        return r;
    }

    private void menu(final Program p) {
        final String[] items = { "Play", "Edit", "Rename", "Duplicate", "Export to a file", "Delete" };
        Ui.dialog(this).setTitle(p.name).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                switch (which) {
                    case 0: run(p, 0); refresh(); break;
                    case 1: open(p); break;
                    case 2:
                        Pickers.text(MainActivity.this, "Rename program", p.name, "name", new Pickers.OnText() {
                            public void picked(String s) {
                                p.name = s;
                                Store.put(MainActivity.this, p);
                                refresh();
                            }
                        });
                        break;
                    case 3: {
                        Program copy = p.copyAs(p.name + " copy");
                        Store.put(MainActivity.this, copy);
                        refresh();
                        Ui.toast(MainActivity.this, "Duplicated");
                        break;
                    }
                    case 4:
                        Backup.exportOne(MainActivity.this, p, REQ_EXPORT);
                        break;
                    default:
                        Ui.dialog(MainActivity.this).setTitle("Delete " + p.name + "?")
                                .setMessage("The program is removed. Your audio files are untouched.")
                                .setNegativeButton("Cancel", null)
                                .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dd, int w) {
                                        if (eng.isPlaying(p)) bar.stop();
                                        Store.delete(MainActivity.this, p);
                                        refresh();
                                    }
                                }).show();
                }
            }
        }).show();
    }

    private void newProgram() {
        Pickers.text(this, "New program", "Program " + (Store.PROGRAMS.size() + 1), "name", new Pickers.OnText() {
            public void picked(String s) {
                Program p = Program.blank(s);
                Store.put(MainActivity.this, p);
                refresh();
                open(p);
            }
        });
    }

    private void open(Program p) {
        startActivity(new Intent(this, EditorActivity.class).putExtra("id", p.id));
    }

    private void run(Program p, int from) {
        if (p.enabledCount() == 0) {
            Ui.toast(this, "Add a step first");
            open(p);
            return;
        }
        Runner.play(this, p, from, new Runner.OnStarted() {
            public void started() {
                liveProgramId = "";
                buildLive();
                refresh();
            }
        });
    }

    // ======================================================================
    // live step list
    // ======================================================================
    private void buildLive() {
        Engine.St s = eng.st;
        Program p = Store.program(s.programId);
        if (!s.running || p == null) {
            liveCard.setVisibility(View.GONE);
            liveRows.clear();
            liveSteps.removeAllViews();
            liveProgramId = "";
            return;
        }
        liveCard.setVisibility(View.VISIBLE);
        liveTitle.setText(p.name.toUpperCase());
        if (p.id.equals(liveProgramId) && liveRows.size() == p.steps.size()) {
            highlight(s.step);
            return;
        }
        liveProgramId = p.id;
        liveSteps.removeAllViews();
        liveRows.clear();
        for (int i = 0; i < p.steps.size(); i++) {
            final int index = i;
            Step st = p.steps.get(i);
            LinearLayout r = Ui.row(this);
            r.setPadding(Ui.dp(this, 8), Ui.dp(this, 7), Ui.dp(this, 8), Ui.dp(this, 7));
            Ui.margin(this, r, 0, 0, 0, 2);
            r.addView(Ui.icon(this, stepIcon(st), st.enabled ? Ui.DIM : Ui.LINE, 15));
            r.addView(Ui.hgap(this, 10));
            LinearLayout col = Ui.col(this);
            col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            TextView t = Ui.tv(this, st.title(), 13, st.enabled ? Ui.TXT : Ui.DIM, false);
            Ui.ellipsize(t);
            col.addView(t);
            TextView d = Ui.tv(this, st.detail(), 11, Ui.DIM, false);
            Ui.ellipsize(d);
            col.addView(d);
            r.addView(col);
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) { Ui.buzz(v); eng.jumpTo(index); }
            });
            liveRows.add(r);
            liveSteps.addView(r);
        }
        highlight(s.step);
    }

    static int stepIcon(Step s) {
        if (s.type == Step.SILENCE) return Ico.CLOCK;
        if (s.type == Step.BELL) return Ico.BELL;
        if (s.type == Step.SECTION) return Ico.AB;
        return Ico.NOTE;
    }

    private void highlight(int active) {
        for (int i = 0; i < liveRows.size(); i++) {
            View v = liveRows.get(i);
            if (i == active) v.setBackground(Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, 10, 1));
            else v.setBackground(Ui.ripple(Ui.rr(this, 0x00000000, 10)));
        }
    }

    // ======================================================================
    // engine callbacks
    // ======================================================================
    public void onEngineState(Engine.St s) {
        if (s.running != wasRunning) {
            wasRunning = s.running;
            refresh();
            return;
        }
        buildLive();
    }

    public void onEngineFinished(boolean completed) {
        int skipped = eng.st.skipped;
        refresh();
        if (skipped > 0) {
            Ui.toast(this, (completed ? "Finished, but " : "Stopped. ") + skipped
                    + (skipped == 1 ? " step was skipped - its track is missing"
                                    : " steps were skipped - their tracks are missing"));
        } else {
            Ui.toast(this, completed ? "Program finished" : "Stopped");
        }
    }

    // ======================================================================
    // backup
    // ======================================================================
    @Override
    protected void onActivityResult(int req, int result, Intent data) {
        super.onActivityResult(req, result, data);
        if (result != RESULT_OK || data == null || data.getData() == null) return;
        if (req == REQ_EXPORT) {
            Backup.write(this, data.getData());
        } else if (req == REQ_IMPORT) {
            Backup.read(this, data.getData());
            refresh();
        }
    }

    // ======================================================================
    // dialogs
    // ======================================================================
    private void help() {
        LinearLayout box = Ui.col(this);
        int p = Ui.dp(this, 20);
        box.setPadding(p, Ui.dp(this, 4), p, 0);
        for (int i = 0; i < HelpText.SECTIONS.length; i++) {
            String[] section = HelpText.SECTIONS[i];
            TextView h = Ui.tv(this, section[0], 14, Ui.ACC_TXT, true);
            Ui.margin(this, h, 0, i == 0 ? 0 : 18, 0, 6);
            box.addView(h);
            TextView b = Ui.tv(this, section[1], 13.5f, Ui.TXT, false);
            b.setLineSpacing(Ui.dp(this, 3), 1f);
            b.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            box.addView(b);
        }
        box.addView(Ui.gap(this, 12));
        ScrollView sv = new ScrollView(this);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        Ui.dialog(this).setTitle("How Riola works").setView(sv).setPositiveButton("Close", null).show();
    }

    private String colourName(int c) {
        for (int i = 0; i < Ui.ACCENTS.length; i++) {
            if (Ui.ACCENTS[i] == c) return Ui.ACCENT_NAMES[i];
        }
        return String.format("Custom  #%06X", c & 0xFFFFFF);
    }

    private void settings() {
        final android.app.AlertDialog[] holder = new android.app.AlertDialog[1];

        LinearLayout box = Ui.col(this);
        int p = Ui.dp(this, 18);
        box.setPadding(p, Ui.dp(this, 6), p, 0);

        box.addView(Ui.switchRow(this, "Dark theme", null, prefs.dark(), new Ui.OnToggle() {
            public void set(boolean v) {
                prefs.dark(v);
                // the dialog belongs to this activity, so it has to go before the
                // activity does - otherwise it lingers in the old colours
                if (holder[0] != null) holder[0].dismiss();
                reopenSettings = true;
                recreate();
            }
        }));

        final Themes.OnChosen restyle = new Themes.OnChosen() {
            public void chosen() {
                if (holder[0] != null) holder[0].dismiss();
                reopenSettings = true;
                recreate();
            }
        };
        box.addView(Ui.field(this, "Colour", colourName(prefs.accent()), Ico.WAVE,
                new View.OnClickListener() {
            public void onClick(View v) {
                if (holder[0] != null) holder[0].dismiss();
                Themes.colour(MainActivity.this, prefs, restyle);
            }
        }));
        box.addView(Ui.field(this, "Look", Ui.STYLE_NAMES[Math.max(0, Math.min(prefs.style(),
                Ui.STYLE_NAMES.length - 1))], Ico.EDIT, new View.OnClickListener() {
            public void onClick(View v) {
                if (holder[0] != null) holder[0].dismiss();
                Themes.look(MainActivity.this, prefs, restyle);
            }
        }));
        box.addView(Ui.switchRow(this, "Keep the screen on", "while the app is open",
                prefs.keepScreenOn(), new Ui.OnToggle() {
            public void set(boolean v) {
                prefs.keepScreenOn(v);
                if (v) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                else getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
            }
        }));
        box.addView(Ui.switchRow(this, "Keep the CPU awake", "so long rests stay exact",
                prefs.wakeLock(), new Ui.OnToggle() {
            public void set(boolean v) { prefs.wakeLock(v); }
        }));
        box.addView(Ui.switchRow(this, "Pause when headphones unplug", null,
                prefs.pauseUnplug(), new Ui.OnToggle() {
            public void set(boolean v) { prefs.pauseUnplug(v); }
        }));
        box.addView(Ui.switchRow(this, "Pause for calls and other apps", null,
                prefs.pauseOnFocus(), new Ui.OnToggle() {
            public void set(boolean v) { prefs.pauseOnFocus(v); }
        }));
        box.addView(Ui.switchRow(this, "Vibrate on button taps", null,
                prefs.haptics(), new Ui.OnToggle() {
            public void set(boolean v) { prefs.haptics(v); }
        }));

        box.addView(Ui.divider(this));
        box.addView(Ui.sliderRow(this, "Master volume", 0, 100, prefs.volume(), "%", 100, new Ui.OnSlide() {
            public void set(int v) { prefs.volume(v); eng.setMasterVolume(v); }
        }));
        box.addView(Ui.sliderRow(this, "Playback speed", 50, 200, prefs.speedPct(), "%", 100, new Ui.OnSlide() {
            public void set(int v) { prefs.speedPct(v); eng.setMasterSpeed(v); }
        }));
        box.addView(Ui.sliderRow(this, "Fade at loop edges", 0, 1000, prefs.fadeMs(), " ms", 150, new Ui.OnSlide() {
            public void set(int v) { prefs.fadeMs(v); }
        }));
        box.addView(Ui.sliderRow(this, "Count in before starting", 0, 15, prefs.countIn(), " s", 0, new Ui.OnSlide() {
            public void set(int v) { prefs.countIn(v); }
        }));
        box.addView(Ui.sliderRow(this, "Stop everything after", 0, 180, prefs.autoStopMin(), " min", 0, new Ui.OnSlide() {
            public void set(int v) { prefs.autoStopMin(v); }
        }));
        TextView note = Ui.tv(this, "Set the stop timer to 0 to switch it off.", 11, Ui.DIM, false);
        box.addView(note);

        box.addView(Ui.divider(this));
        box.addView(Ui.btn(this, "Reset settings to defaults", 0, Ui.DANGER, new View.OnClickListener() {
            public void onClick(View v) {
                prefs.resetAll();
                Ui.toast(MainActivity.this, "Settings reset");
                if (holder[0] != null) holder[0].dismiss();
                reopenSettings = true;
                recreate();
            }
        }));
        box.addView(Ui.gap(this, 6));
        box.addView(Ui.tv(this, "Riola 4.0  -  no ads, no network, no accounts.", 11, Ui.DIM, false));
        box.addView(Ui.gap(this, 6));

        ScrollView sv = new ScrollView(this);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = Ui.dialog(this).setTitle("Settings").setView(sv)
                .setPositiveButton("Done", null).create();
        holder[0].show();
    }
}
'@

# ---------------------------------------------------------------------------
# Java: program editor and the step sheet
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\EditorActivity.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/** Build a program by tapping: no typing, no syntax. */
public class EditorActivity extends Activity implements PlayerBar.Host {

    private Prefs prefs;
    private Engine eng;
    private PlayerBar bar;
    private Program prog;

    private static final int REQ_EXPORT = 301;

    private LinearLayout stepsBox, loopBox;
    private android.widget.ScrollView scroller;
    private int liveRow = -1;
    private TextView titleView, subView, totalBadge;
    private final List<View> rows = new ArrayList<View>();
    private boolean dirty;
    private Step undoStep;          // last deleted, kept briefly so it can come back
    private int undoAt = -1;
    private int undoLeft;           // seconds still on the clock
    private TextView undoLabel;
    private static final int UNDO_SECONDS = 20;
    private final android.os.Handler ui = new android.os.Handler(android.os.Looper.getMainLooper());
    private final Runnable undoTick = new Runnable() {
        public void run() {
            if (undoStep == null) return;
            undoLeft--;
            if (undoLeft <= 0) {
                undoStep = null;
                undoAt = -1;
                refresh();
                return;
            }
            if (undoLabel != null) undoLabel.setText("Step removed  .  " + undoLeft + "s");
            ui.postDelayed(this, 1000);
        }
    };

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes(prefs.dark()));
        super.onCreate(saved);
        Store.load(this);
        eng = Engine.get(this);
        prog = Store.program(getIntent().getStringExtra("id"));
        if (prog == null) { finish(); return; }
        setContentView(build());
        Ui.applyWindow(this);
        refresh();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (prog == null) return;
        bar.attach();
        if (prefs.keepScreenOn()) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        refresh();
    }

    @Override
    protected void onPause() {
        ui.removeCallbacks(undoTick);
        undoStep = null;
        undoAt = -1;
        undoLabel = null;
        if (prog != null) {
            bar.detach();
            // Every edit already saves through save(); writing again here would
            // bump the program's timestamp just for opening it and reshuffle
            // the home list.
            if (dirty) { Store.put(this, prog); dirty = false; }
        }
        super.onPause();
    }

    // ======================================================================
    // layout
    // ======================================================================
    private View build() {
        LinearLayout root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        View[] actions = {
            Ui.iconBtn(this, Ico.PLAY, Ui.ACC_TXT, 20, "Run this program", new View.OnClickListener() {
                public void onClick(View v) { run(0); }
            }),
            Ui.iconBtn(this, Ico.MORE, Ui.DIM, 20, "More options", new View.OnClickListener() {
                public void onClick(View v) { menu(); }
            })
        };
        Ui.Bar header = Ui.appBar(this, 0, prog.name, prog.summary(), true, actions);
        titleView = header.title;
        subView = header.sub;
        header.titles.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { rename(); }
        });
        root.addView(header.view);

        LinearLayout body = Ui.col(this);

        LinearLayout loops = Ui.card(this);
        loops.addView(Ui.heading(this, Ico.LOOP, "Repeat program"));
        loopBox = Ui.col(this);
        loops.addView(loopBox);
        body.addView(loops);

        LinearLayout card = Ui.card(this);
        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.LIST, "Steps");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        totalBadge = Ui.badge(this, "", Ui.DIM, Ui.SURF2);
        head.addView(totalBadge);
        card.addView(head);

        stepsBox = Ui.col(this);
        card.addView(stepsBox);

        LinearLayout add = Ui.btn(this, "Add step", Ico.PLUS, Ui.PRIMARY, new View.OnClickListener() {
            public void onClick(View v) { addStep(); }
        });
        add.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, add, 0, 10, 0, 0);
        card.addView(add);
        body.addView(card);

        body.addView(Ui.gap(this, 6));
        scroller = Ui.scroller(this, body);
        root.addView(scroller);

        bar = new PlayerBar(this, this);
        root.addView(bar.view);
        return root;
    }

    /** Keep the playing step on screen in a long program. */
    private void scrollToRow(final View row) {
        if (scroller == null || row == null) return;
        scroller.post(new Runnable() {
            public void run() {
                int y = 0;
                View v = row;
                while (v != null && v.getParent() instanceof View && v.getParent() != scroller) {
                    y += v.getTop();
                    v = (View) v.getParent();
                }
                if (v != null) y += v.getTop();
                scroller.smoothScrollTo(0, Math.max(0, y - Ui.dp(EditorActivity.this, 150)));
            }
        });
    }

    private void refresh() {
        if (prog == null) return;
        titleView.setText(prog.name);
        subView.setText(prog.summary());
        totalBadge.setText(prog.steps.isEmpty() ? "empty" : Fmt.rough(prog.estMs()));

        loopBox.removeAllViews();
        final int mode = prog.loops < 0 ? 2 : (prog.loops <= 1 ? 0 : 1);
        loopBox.addView(Ui.seg(this, new String[]{ "Once", "A few times", "Forever" }, mode, new Ui.OnPick() {
            public void set(int index) {
                prog.loops = index == 0 ? 1 : (index == 1 ? Math.max(2, prog.loops) : -1);
                save();
                refresh();
            }
        }));
        if (mode == 1) {
            LinearLayout r = Ui.row(this);
            Ui.margin(this, r, 0, 8, 0, 0);
            TextView t = Ui.tv(this, "Run the whole list", 13.5f, Ui.DIM, false);
            t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            r.addView(t);
            LinearLayout st = Ui.stepper(this, Math.max(2, prog.loops), 2, 99, 1, "x", new Ui.OnValue() {
                public void set(int v) {
                    prog.loops = v;
                    save();
                    subView.setText(prog.summary());
                    totalBadge.setText(Fmt.rough(prog.estMs()));
                }
            });
            st.setLayoutParams(Ui.lp(Ui.dp(this, 160), Ui.WRAP));
            r.addView(st);
            loopBox.addView(r);
        }

        stepsBox.removeAllViews();
        rows.clear();
        if (undoStep != null) stepsBox.addView(undoBar());
        if (prog.steps.isEmpty()) {
            stepsBox.addView(Ui.emptyState(this, Ico.LIST, "No steps yet",
                    "Add a whole track, a section of a track, or a stretch of silence."));
        } else {
            for (int i = 0; i < prog.steps.size(); i++) stepsBox.addView(stepRow(i));
        }
        bar.render(eng.st);
    }

    /** A short lived "step removed - undo" strip, friendlier than a confirm dialog. */
    private View undoBar() {
        View.OnClickListener undo = new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                restoreStep();
            }
        };
        LinearLayout r = Ui.row(this);
        r.setBackground(Ui.ripple(Ui.rrs(this, Ui.SURF2, Ui.AMBER, 12, 1)));
        r.setPadding(Ui.dp(this, 12), Ui.dp(this, 12), Ui.dp(this, 8), Ui.dp(this, 12));
        Ui.margin(this, r, 0, 0, 0, 8);
        // the whole strip undoes, not just the button - it is a small target
        // with a short life, so it should be hard to miss
        r.setClickable(true);
        r.setContentDescription("Undo removing the step");
        r.setOnClickListener(undo);
        undoLabel = Ui.tv(this, "Step removed  .  " + Math.max(1, undoLeft) + "s", 13, Ui.TXT, false);
        undoLabel.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(undoLabel);
        r.addView(Ui.btn(this, "Undo", Ico.RESET, Ui.SECONDARY, undo));
        return r;
    }

    /** Puts the last deleted step back where it was. */
    private void restoreStep() {
        ui.removeCallbacks(undoTick);
        Step back = undoStep;
        int at = undoAt;
        undoStep = null;
        undoAt = -1;
        if (back == null || prog == null) {
            refresh();          // at least clear the strip rather than sit there dead
            Ui.toast(this, "Too late to undo");
            return;
        }
        prog.steps.add(Math.max(0, Math.min(at, prog.steps.size())), back);
        save();
        refresh();
        Ui.toast(this, "Step restored");
    }

    private void removeStep(int index) {
        undoStep = prog.steps.remove(index);
        undoAt = index;
        undoLeft = UNDO_SECONDS;
        ui.removeCallbacks(undoTick);
        ui.postDelayed(undoTick, 1000);
        save();
        refresh();
    }

    private View stepRow(final int index) {
        final Step s = prog.steps.get(index);
        final boolean on = s.enabled;
        boolean live = eng.isPlaying(prog) && eng.st.step == index;

        LinearLayout r = Ui.row(this);
        r.setBackground(live ? Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f)
                             : Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD)));
        r.setPadding(Ui.dp(this, 8), Ui.dp(this, 9), Ui.dp(this, 2), Ui.dp(this, 9));
        Ui.margin(this, r, 0, 0, 0, 8);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // While this program is playing, a tap means "go here" - which is
                // what the guide promises. Editing stays on the menu.
                if (eng.isPlaying(prog)) { Ui.buzz(v); eng.jumpTo(index); }
                else edit(index);
            }
        });
        r.setOnLongClickListener(new View.OnLongClickListener() {
            public boolean onLongClick(View v) { stepMenu(index); return true; }
        });

        LinearLayout num = Ui.col(this);
        num.setLayoutParams(Ui.lp(Ui.dp(this, 28), Ui.WRAP));
        TextView n = Ui.tv(this, String.valueOf(index + 1), 12, on ? Ui.DIM : Ui.LINE, true);
        n.setGravity(Gravity.CENTER);
        n.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        num.addView(n);
        ImageView ic = Ui.icon(this, MainActivity.stepIcon(s), on ? Ui.ACC : Ui.LINE, 15);
        ic.setLayoutParams(Ui.lp(Ui.dp(this, 28), Ui.dp(this, 18)));
        num.addView(ic);
        r.addView(num);
        r.addView(Ui.hgap(this, 8));

        LinearLayout col = Ui.col(this);
        col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        LinearLayout tl = Ui.row(this);
        TextView t = Ui.tv(this, s.title(), 14.5f, on ? Ui.TXT : Ui.DIM, true);
        Ui.ellipsize(t);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        tl.addView(t);
        if (!on) tl.addView(Ui.badge(this, "OFF", Ui.DIM, Ui.SURF));
        else if (s.missing()) tl.addView(Ui.badge(this, "MISSING", Ui.ONACC, Ui.AMBER));
        col.addView(tl);
        TextView d = Ui.tv(this, s.detail(), 11.5f, Ui.DIM, false);
        Ui.ellipsize(d);
        col.addView(d);
        r.addView(col);

        // wrap, not match: a match-width column here would swallow the title
        LinearLayout arrows = Ui.col(this);
        arrows.setLayoutParams(Ui.lp(Ui.WRAP, Ui.WRAP));
        arrows.addView(Ui.iconBtn(this, Ico.UP, index == 0 ? Ui.LINE : Ui.DIM, 14, 6, "Move up",
                new View.OnClickListener() {
            public void onClick(View v) { move(index, -1); }
        }));
        arrows.addView(Ui.iconBtn(this, Ico.DOWN, index == prog.steps.size() - 1 ? Ui.LINE : Ui.DIM, 14, 6,
                "Move down", new View.OnClickListener() {
            public void onClick(View v) { move(index, 1); }
        }));
        r.addView(arrows);

        r.addView(Ui.iconBtn(this, Ico.MORE, Ui.DIM, 16, "Step options", new View.OnClickListener() {
            public void onClick(View v) { stepMenu(index); }
        }));
        rows.add(r);
        return r;
    }

    // ======================================================================
    // actions
    // ======================================================================
    private void addStep() { addStep(-1); }

    /** at < 0 appends; otherwise the new step lands at that index. */
    private void addStep(final int at) {
        final String[] items = { "Whole track", "Section of a track", "Silence", "Bell" };
        Ui.dialog(this).setTitle(at < 0 ? "Add step" : "Insert step").setItems(items,
                new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                if (which == 2 || which == 3) {
                    int where = place(which == 2 ? Step.silence(60000) : Step.bell(), at);
                    save();
                    refresh();
                    edit(where);
                    return;
                }
                final boolean section = which == 1;
                Pickers.track(EditorActivity.this, section ? "Section of which track?" : "Which track?",
                        new Pickers.OnTrack() {
                    public void picked(Track t) {
                        Step s;
                        if (section) {
                            long end = t.durMs > 45000 ? 45000 : Math.max(10000, t.durMs);
                            long from = end > 20000 ? 15000 : 0;
                            s = Step.section(t, from, end);
                            s.times = 4;
                        } else {
                            s = Step.play(t);
                        }
                        int where = place(s, at);
                        save();
                        refresh();
                        edit(where);
                    }
                });
            }
        }).show();
    }

    private int place(Step s, int at) {
        if (at < 0 || at > prog.steps.size()) {
            prog.steps.add(s);
            return prog.steps.size() - 1;
        }
        prog.steps.add(at, s);
        return at;
    }

    private void edit(final int index) {
        if (index < 0 || index >= prog.steps.size()) return;
        StepSheet.show(this, prog, index, new StepSheet.OnDone() {
            public void changed() { save(); refresh(); }
            public void deleted(int at) { removeStep(at); }
        });
    }

    private void stepMenu(final int index) {
        if (index < 0 || index >= prog.steps.size()) return;
        final Step s = prog.steps.get(index);
        final String[] items = { "Edit", "Play from here", s.enabled ? "Turn off" : "Turn on",
                                 "Insert a step below", "Duplicate", "Move up", "Move down", "Delete" };
        Ui.dialog(this).setTitle(s.title()).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                switch (which) {
                    case 0: edit(index); break;
                    case 1: run(index); break;
                    case 2: s.enabled = !s.enabled; save(); refresh(); break;
                    case 3: addStep(index + 1); break;
                    case 4: prog.steps.add(index + 1, s.copy()); save(); refresh(); break;
                    case 5: move(index, -1); break;
                    case 6: move(index, 1); break;
                    default: removeStep(index);
                }
            }
        }).show();
    }

    private void move(int index, int dir) {
        int to = index + dir;
        if (to < 0 || to >= prog.steps.size()) return;
        Step s = prog.steps.remove(index);
        prog.steps.add(to, s);
        save();
        refresh();
    }

    private void rename() {
        Pickers.text(this, "Rename program", prog.name, "name", new Pickers.OnText() {
            public void picked(String s) { prog.name = s; save(); refresh(); }
        });
    }

    private void menu() {
        final String[] items = { "Rename", "Duplicate", "Export to a file", "Delete program" };
        Ui.dialog(this).setTitle(prog.name).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                if (which == 0) {
                    rename();
                } else if (which == 1) {
                    Store.put(EditorActivity.this, prog.copyAs(prog.name + " copy"));
                    Ui.toast(EditorActivity.this, "Duplicated");
                } else if (which == 2) {
                    Backup.exportOne(EditorActivity.this, prog, REQ_EXPORT);
                } else {
                    Ui.dialog(EditorActivity.this).setTitle("Delete " + prog.name + "?")
                            .setNegativeButton("Cancel", null)
                            .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dd, int w) {
                                    if (eng.isPlaying(prog)) bar.stop();
                                    Store.delete(EditorActivity.this, prog);
                                    prog = null;
                                    finish();
                                }
                            }).show();
                }
            }
        }).show();
    }

    private void run(int from) {
        if (prog.enabledCount() == 0) { Ui.toast(this, "Add a step first"); return; }
        save();
        Runner.play(this, prog, from, new Runner.OnStarted() {
            public void started() { refresh(); }
        });
    }

    private void save() {
        if (prog == null) return;
        dirty = true;
        Store.put(this, prog);
        dirty = false;
    }

    @Override
    protected void onActivityResult(int req, int result, android.content.Intent data) {
        super.onActivityResult(req, result, data);
        if (req == REQ_EXPORT && result == RESULT_OK && data != null) {
            Backup.write(this, data.getData());
        }
    }

    // ======================================================================
    // engine callbacks
    // ======================================================================
    public void onEngineState(Engine.St s) {
        if (prog == null) return;
        boolean mine = s.running && prog.id.equals(s.programId);
        for (int i = 0; i < rows.size(); i++) {
            boolean live = mine && s.step == i;
            rows.get(i).setBackground(live
                    ? Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f)
                    : Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD)));
        }
        if (mine && s.step != liveRow) {
            liveRow = s.step;
            if (s.step >= 0 && s.step < rows.size()) scrollToRow(rows.get(s.step));
        } else if (!mine) {
            liveRow = -1;
        }
    }

    public void onEngineFinished(boolean completed) { refresh(); }
}
'@

Write-Src "$PKG_PATH\StepSheet.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/** The editor for a single step. Everything is tapped, nothing is typed. */
public final class StepSheet {

    public interface OnDone {
        void changed();
        void deleted(int index);
    }

    private StepSheet() { }

    public static void show(final Activity a, final Program prog, final int index, final OnDone cb) {
        if (index < 0 || index >= prog.steps.size()) return;
        final Step step = prog.steps.get(index).copy();

        final LinearLayout content = Ui.col(a);
        int p = Ui.dp(a, 18);
        content.setPadding(p, Ui.dp(a, 4), p, 0);

        ScrollView sv = new ScrollView(a);
        sv.addView(content, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        final Runnable[] render = new Runnable[1];
        render[0] = new Runnable() {
            public void run() { fill(a, content, step, render[0]); }
        };
        render[0].run();

        String kind = step.type == Step.SILENCE ? "Silence"
                : step.type == Step.BELL ? "Bell"
                : (step.type == Step.SECTION ? "Section" : "Whole track");

        Ui.dialog(a).setTitle("Step " + (index + 1) + "  -  " + kind)
                .setView(sv)
                .setNeutralButton("Delete", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.deleted(index); }
                })
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        prog.steps.set(index, step);
                        cb.changed();
                    }
                }).show();
    }

    private static void fill(final Activity a, final LinearLayout box, final Step step, final Runnable again) {
        box.removeAllViews();

        if (step.needsTrack()) {
            Track bound = step.track();
            String label = bound != null ? bound.shortTitle()
                    : (step.trackName.length() > 0 ? step.trackName + "  (missing)" : "pick a track");
            box.addView(Ui.field(a, "Track", label, Ico.NOTE, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.track(a, "Which track?", new Pickers.OnTrack() {
                        public void picked(Track picked) {
                            step.bind(picked);
                            if (step.type == Step.SECTION && picked.durMs > 0 && step.b > picked.durMs) {
                                step.b = picked.durMs;
                            }
                            again.run();
                        }
                    });
                }
            }));
        }

        if (step.type == Step.SECTION) {
            final Track t = step.track();
            final long cap = t == null ? 0 : t.durMs;

            LinearLayout ab = Ui.row(a);
            LinearLayout left = Ui.col(a);
            left.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            left.addView(Ui.field(a, "Start (A)", Fmt.ms(step.a), Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.position(a, "Section starts at", step.a, cap, new Pickers.OnMs() {
                        public void picked(long ms) {
                            step.a = ms;
                            if (step.b >= 0 && step.b <= step.a) step.b = step.a + 15000;
                            again.run();
                        }
                    });
                }
            }));
            LinearLayout right = Ui.col(a);
            right.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            Ui.margin(a, right, 8, 0, 0, 0);
            right.addView(Ui.field(a, "End (B)", step.b < 0 ? "end of track" : Fmt.ms(step.b),
                    Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.position(a, "Section ends at", step.b < 0 ? cap : step.b, cap, new Pickers.OnMs() {
                        public void picked(long ms) {
                            step.b = ms <= step.a ? step.a + 15000 : ms;
                            again.run();
                        }
                    });
                }
            }));
            ab.addView(left);
            ab.addView(right);
            box.addView(ab);

            LinearLayout ear = Ui.btn(a, "Pick by ear", Ico.AB, Ui.SECONDARY, new View.OnClickListener() {
                public void onClick(View v) {
                    if (t == null) { Ui.toast(a, "Pick a track first"); return; }
                    AbDialog.show(a, t, step.a, step.b, new AbDialog.OnPick() {
                        public void picked(long from, long to) {
                            step.a = from;
                            step.b = to;
                            again.run();
                        }
                    });
                }
            });
            ear.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            Ui.margin(a, ear, 0, 8, 0, 0);
            box.addView(ear);

            if (step.b > 0) {
                TextView len = Ui.tv(a, "that slice is " + Fmt.human(Math.max(0, step.b - step.a)) + " long",
                        11.5f, Ui.DIM, false);
                Ui.margin(a, len, 2, 6, 0, 0);
                box.addView(len);
            }
        }

        if (step.type == Step.SILENCE) {
            box.addView(Ui.field(a, "How long", Fmt.human(step.durMs), Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.duration(a, "Silence for", step.durMs, new Pickers.OnMs() {
                        public void picked(long ms) { step.durMs = Math.max(1000, ms); again.run(); }
                    });
                }
            }));

            box.addView(Ui.gap(a, 6));
            box.addView(Ui.switchRow(a, "End with a bell", "chime when the rest is over",
                    step.endBell, new Ui.OnToggle() {
                public void set(boolean v) {
                    step.endBell = v;
                    if (v) Bell.preview(step.tone, 1f);
                    again.run();
                }
            }));
            if (step.endBell) {
                box.addView(Ui.seg(a, new String[]{ "Low", "Warm", "Bright", "Desk" }, Bell.clamp(step.tone),
                        new Ui.OnPick() {
                    public void set(int i) {
                        step.tone = i;
                        Bell.preview(i, 1f);
                        again.run();
                    }
                }));
            }

        } else if (step.type == Step.BELL) {
            box.addView(Ui.tv(a, "TONE", 11, Ui.DIM, true));
            box.addView(Ui.gap(a, 6));
            box.addView(Ui.seg(a, new String[]{ "Low", "Warm", "Bright", "Desk" }, Bell.clamp(step.tone),
                    new Ui.OnPick() {
                public void set(int i) {
                    step.tone = i;
                    Bell.preview(i, step.volumePct / 100f);
                    again.run();
                }
            }));
            TextView hint = Ui.tv(a, "A soft chime to mark a change without opening your eyes.",
                    11.5f, Ui.DIM, false);
            Ui.margin(a, hint, 2, 6, 0, 0);
            box.addView(hint);

            LinearLayout hear = Ui.btn(a, "Hear it", Ico.BELL, Ui.SECONDARY, new View.OnClickListener() {
                public void onClick(View v) { Bell.preview(step.tone, step.volumePct / 100f); }
            });
            hear.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            Ui.margin(a, hear, 0, 8, 0, 0);
            box.addView(hear);

            LinearLayout rings = Ui.row(a);
            Ui.margin(a, rings, 0, 10, 0, 0);
            TextView rt = Ui.tv(a, "Ring it", 13.5f, Ui.DIM, false);
            rt.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            rings.addView(rt);
            LinearLayout rs = Ui.stepper(a, Math.max(1, step.times), 1, 9, 1, "x", new Ui.OnValue() {
                public void set(int v) { step.times = v; }
            });
            rs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            rings.addView(rs);
            box.addView(rings);

            LinearLayout bg = Ui.row(a);
            Ui.margin(a, bg, 0, 8, 0, 0);
            TextView bt = Ui.tv(a, "Gap between rings", 13.5f, Ui.DIM, false);
            bt.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            bg.addView(bt);
            LinearLayout bs = Ui.stepper(a, (int) (step.gapMs / 1000L), 0, 120, 1, "s", new Ui.OnValue() {
                public void set(int v) { step.gapMs = v * 1000L; }
            });
            bs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            bg.addView(bs);
            box.addView(bg);

            box.addView(Ui.divider(a));
            box.addView(Ui.sliderRow(a, "Bell volume", 10, 100, step.volumePct, "%", 100, new Ui.OnSlide() {
                public void set(int v) { step.volumePct = v; }
            }));

        } else {
            box.addView(Ui.gap(a, 10));
            box.addView(Ui.tv(a, "HOW OFTEN", 11, Ui.DIM, true));
            box.addView(Ui.gap(a, 6));
            box.addView(Ui.seg(a, new String[]{ "A number of times", "For a length of time" },
                    step.timed() ? 1 : 0, new Ui.OnPick() {
                public void set(int i) {
                    if (i == 0) step.times = 1;
                    else { step.times = -1; if (step.durMs <= 0) step.durMs = 600000; }
                    again.run();
                }
            }));
            if (step.timed()) {
                box.addView(Ui.field(a, "Keep looping for", Fmt.human(step.durMs), Ico.CLOCK,
                        new View.OnClickListener() {
                    public void onClick(View v) {
                        Pickers.duration(a, "Loop for", step.durMs, new Pickers.OnMs() {
                            public void picked(long ms) { step.durMs = Math.max(5000, ms); again.run(); }
                        });
                    }
                }));
            } else {
                LinearLayout r = Ui.row(a);
                Ui.margin(a, r, 0, 8, 0, 0);
                TextView t = Ui.tv(a, "Play it", 13.5f, Ui.DIM, false);
                t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
                r.addView(t);
                LinearLayout st = Ui.stepper(a, Math.max(1, step.times), 1, 99, 1, "x", new Ui.OnValue() {
                    public void set(int v) { step.times = v; }
                });
                st.setLayoutParams(Ui.lp(Ui.dp(a, 160), Ui.WRAP));
                r.addView(st);
                box.addView(r);
            }

            LinearLayout g = Ui.row(a);
            Ui.margin(a, g, 0, 10, 0, 0);
            LinearLayout gl = Ui.col(a);
            gl.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            gl.addView(Ui.tv(a, "Gap between repeats", 13.5f, Ui.DIM, false));
            gl.addView(Ui.tv(a, "a short rest each time round", 11, Ui.DIM, false));
            g.addView(gl);
            LinearLayout gs = Ui.stepper(a, (int) (step.gapMs / 1000L), 0, 300, 5, "s", new Ui.OnValue() {
                public void set(int v) { step.gapMs = v * 1000L; }
            });
            gs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            g.addView(gs);
            box.addView(g);

            box.addView(Ui.divider(a));
            box.addView(Ui.sliderRow(a, "Speed for this step", 50, 200, step.speedPct, "%", 100,
                    new Ui.OnSlide() {
                public void set(int v) { step.speedPct = v; }
            }));
            box.addView(Ui.sliderRow(a, "Volume for this step", 10, 100, step.volumePct, "%", 100,
                    new Ui.OnSlide() {
                public void set(int v) { step.volumePct = v; }
            }));
        }

        box.addView(Ui.divider(a));
        box.addView(Ui.switchRow(a, "Include this step", "turn it off to skip it for now",
                step.enabled, new Ui.OnToggle() {
            public void set(boolean v) { step.enabled = v; }
        }));
        box.addView(Ui.gap(a, 8));
    }
}
'@

# ---------------------------------------------------------------------------
# Java: the track library
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\LibraryActivity.java" @'
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

    /** Manual keeps whatever order you dragged things into. */
    private static final String[] SORTS = {
        "Manual order", "Name A to Z", "Name Z to A",
        "Recently added", "Oldest added", "Newest file", "Oldest file",
        "Longest first", "Shortest first"
    };

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes(prefs.dark()));
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
        String sortName = SORTS[Math.max(0, Math.min(prefs.librarySort(), SORTS.length - 1))];
        subtitle.setText(n == 0 ? "nothing added yet"
                : (n + (n == 1 ? " track" : " tracks") + "  .  " + sortName.toLowerCase()));
        if (search != null) search.setVisibility(n > 8 ? View.VISIBLE : View.GONE);

        listBox.removeAllViews();
        if (n == 0) {
            listBox.addView(Ui.emptyState(this, Ico.NOTE, "No tracks yet",
                    "Add single files, or point Riola at a folder and it will find the audio inside."));
            return;
        }

        List<Track> view = ordered();
        if (view.isEmpty()) {
            listBox.addView(Ui.tv(this, "Nothing matches \"" + filter + "\".", 13, Ui.DIM, false));
            return;
        }
        for (int i = 0; i < view.size(); i++) listBox.addView(row(view.get(i)));
    }

    /** The library filtered and sorted for display; the stored order is untouched. */
    private List<Track> ordered() {
        List<Track> view = new ArrayList<Track>();
        for (Track t : Store.LIB) {
            if (filter.length() == 0 || t.shortTitle().toLowerCase().contains(filter)) view.add(t);
        }
        final int mode = prefs.librarySort();
        if (mode == 0) return view;
        Collections.sort(view, new Comparator<Track>() {
            public int compare(Track a, Track b) {
                switch (mode) {
                    case 1: return a.shortTitle().compareToIgnoreCase(b.shortTitle());
                    case 2: return b.shortTitle().compareToIgnoreCase(a.shortTitle());
                    case 3: return cmp(b.addedAt, a.addedAt);
                    case 4: return cmp(a.addedAt, b.addedAt);
                    case 5: return cmp(b.modifiedAt, a.modifiedAt);
                    case 6: return cmp(a.modifiedAt, b.modifiedAt);
                    case 7: return cmp(b.durMs, a.durMs);
                    default: return cmp(a.durMs, b.durMs);
                }
            }
        });
        return view;
    }

    private static int cmp(long a, long b) { return a == b ? 0 : (a < b ? -1 : 1); }

    private void sortMenu() {
        Ui.dialog(this).setTitle("Sort the library").setItems(SORTS,
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
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;

/** Listen to the track and mark A and B by ear. */
public final class AbDialog {

    public interface OnPick { void picked(long a, long b); }

    private AbDialog() { }

    public static void show(final Activity act, final Track track, long startMs, long endMs, final OnPick cb) {
        if (track == null) return;

        final Engine eng = Engine.get(act);
        if (eng.isRunning()) eng.stop();

        final long[] a = { Math.max(0, startMs) };
        final long[] b = { endMs };
        final boolean[] ready = { false };
        final boolean[] loopAb = { true };
        final MediaPlayer mp = new MediaPlayer();
        final Handler h = new Handler(Looper.getMainLooper());

        LinearLayout box = Ui.col(act);
        int p = Ui.dp(act, 18);
        box.setPadding(p, Ui.dp(act, 6), p, 0);

        final TextView clock = Ui.mono(act, "0:00 / 0:00", 15, Ui.ACC_TXT);
        clock.setGravity(Gravity.CENTER);
        clock.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(clock);

        final SeekBar bar = new SeekBar(act);
        bar.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        bar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        bar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        box.addView(bar);

        final TextView aTv = Ui.mono(act, "A   " + Fmt.ms(a[0]), 14, Ui.TXT);
        final TextView bTv = Ui.mono(act, "B   " + (b[0] < 0 ? "end" : Fmt.ms(b[0])), 14, Ui.TXT);

        LinearLayout tr = Ui.row(act);
        tr.setGravity(Gravity.CENTER);
        final ImageView play = Ui.roundBtn(act, Ico.PLAY, 20, true, "Play", null);
        tr.addView(nudge(act, "-5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, -5000); }
        }));
        tr.addView(play);
        tr.addView(nudge(act, "+5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, 5000); }
        }));
        Ui.margin(act, tr, 0, 8, 0, 6);
        box.addView(tr);

        play.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (!ready[0]) return;
                Ui.buzz(v);
                try {
                    boolean wasPlaying = mp.isPlaying();
                    if (wasPlaying) mp.pause(); else mp.start();
                    Ui.setIcon(play, wasPlaying ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
                    play.setContentDescription(wasPlaying ? "Play" : "Pause");
                } catch (IllegalStateException e) { /* ignore */ }
            }
        });

        box.addView(markRow(act, aTv, new View.OnClickListener() {
            public void onClick(View v) {
                a[0] = position(mp, ready);
                if (b[0] >= 0 && b[0] <= a[0]) b[0] = -1;
                aTv.setText("A   " + Fmt.ms(a[0]));
                bTv.setText("B   " + (b[0] < 0 ? "end" : Fmt.ms(b[0])));
            }
        }, new Nudge() {
            public void by(int ms) {
                a[0] = Math.max(0, a[0] + ms);
                if (b[0] >= 0 && a[0] >= b[0]) a[0] = Math.max(0, b[0] - 1000);
                aTv.setText("A   " + Fmt.ms(a[0]));
            }
        }));

        box.addView(markRow(act, bTv, new View.OnClickListener() {
            public void onClick(View v) {
                long pos = position(mp, ready);
                if (pos <= a[0]) { Ui.toast(act, "B has to come after A"); return; }
                b[0] = pos;
                bTv.setText("B   " + Fmt.ms(b[0]));
            }
        }, new Nudge() {
            public void by(int ms) {
                if (b[0] < 0) b[0] = position(mp, ready);
                b[0] = Math.max(a[0] + 1000, b[0] + ms);
                bTv.setText("B   " + Fmt.ms(b[0]));
            }
        }));

        box.addView(Ui.switchRow(act, "Loop A-B while listening", null, true, new Ui.OnToggle() {
            public void set(boolean v) { loopAb[0] = v; }
        }));

        LinearLayout jump = Ui.row(act);
        jump.addView(Ui.chip(act, "jump to A", false, new View.OnClickListener() {
            public void onClick(View v) { seekTo(mp, ready, a[0]); }
        }));
        jump.addView(Ui.chip(act, "jump to B", false, new View.OnClickListener() {
            public void onClick(View v) { seekTo(mp, ready, Math.max(0, (b[0] < 0 ? duration(mp, ready) : b[0]) - 3000)); }
        }));
        box.addView(jump);
        box.addView(Ui.gap(act, 4));

        ScrollView sv = new ScrollView(act);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        final AlertDialog dlg = Ui.dialog(act).setTitle(track.shortTitle())
                .setView(sv)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Use this section", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        long end = b[0];
                        if (end >= 0 && end <= a[0]) end = a[0] + 15000;
                        cb.picked(a[0], end);
                    }
                }).create();

        final Runnable tick = new Runnable() {
            public void run() {
                if (ready[0]) {
                    int pos = position(mp, ready);
                    int dur = duration(mp, ready);
                    if (!bar.isPressed()) bar.setProgress(pos);
                    clock.setText(Fmt.ms(pos) + " / " + Fmt.ms(dur));
                    if (loopAb[0] && b[0] > 0 && pos >= b[0]) seekTo(mp, ready, a[0]);
                    boolean playing = false;
                    try { playing = mp.isPlaying(); } catch (IllegalStateException e) { /* ignore */ }
                    Ui.setIcon(play, playing ? Ico.PAUSE : Ico.PLAY, Ui.ONACC);
                    play.setContentDescription(playing ? "Pause" : "Play");
                }
                h.postDelayed(this, 200);
            }
        };

        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int prog, boolean fromUser) {
                if (fromUser) seekTo(mp, ready, prog);
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
                    seekTo(mp, ready, a[0]);
                }
            });
            mp.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                public boolean onError(MediaPlayer m, int what, int extra) {
                    Ui.toast(act, "Cannot play this file");
                    return true;
                }
            });
            mp.prepareAsync();
        } catch (Exception e) {
            Ui.toast(act, "Cannot open this file");
        }

        dlg.show();
        h.postDelayed(tick, 200);
    }

    private interface Nudge { void by(int ms); }

    private static View markRow(Activity act, TextView label, View.OnClickListener setNow, final Nudge n) {
        LinearLayout r = Ui.row(act);
        Ui.margin(act, r, 0, 4, 0, 4);
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
        TextView t = Ui.tv(act, text, 12, Ui.ACC_TXT, true);
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

    private static void seekTo(MediaPlayer mp, boolean[] ready, long ms) {
        if (!ready[0]) return;
        try { mp.seekTo((int) Math.max(0, ms)); } catch (IllegalStateException e) { /* ignore */ }
    }

    private static int position(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getCurrentPosition()); } catch (IllegalStateException e) { return 0; }
    }

    private static int duration(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getDuration()); } catch (IllegalStateException e) { return 0; }
    }
}
'@

# ---------------------------------------------------------------------------
# Java: the full screen player
# ---------------------------------------------------------------------------
Write-Src "$PKG_PATH\NowPlayingActivity.java" @'
package com.riola.player;

import android.app.Activity;
import android.content.res.ColorStateList;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/**
 * A big, glanceable player for when you are not looking at the phone: large
 * targets you can find by feel, and a dim mode for a dark room.
 */
public class NowPlayingActivity extends Activity implements Engine.Listener {

    private Prefs prefs;
    private Engine eng;

    private TextView programName, stepTitle, stepDetail, clock, remain, badge;
    private SeekBar seek;
    private ImageView play, shuffle;
    private LinearLayout root;
    private boolean dragging;
    private boolean dimmed;

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes(prefs.dark()));
        super.onCreate(saved);
        eng = Engine.get(this);
        Store.load(this);
        setContentView(build());
        Ui.applyWindow(this);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        render(eng.st);
    }

    @Override protected void onResume() { super.onResume(); eng.addListener(this); render(eng.st); }
    @Override protected void onPause()  { eng.removeListener(this); super.onPause(); }

    private View build() {
        root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        shuffle = Ui.iconBtn(this, Ico.SHUFFLE, Ui.DIM, 20, "Shuffle", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); PlayerBar.askShuffle(NowPlayingActivity.this, eng); }
        });
        View[] actions = {
            shuffle,
            Ui.iconBtn(this, Ico.MOON, Ui.DIM, 20, "Dim the screen", new View.OnClickListener() {
                public void onClick(View v) { setDim(!dimmed); }
            })
        };
        Ui.Bar bar = Ui.appBar(this, 0, "Now playing", "", true, actions);
        programName = bar.sub;
        root.addView(bar.view);

        LinearLayout body = Ui.col(this);
        body.setLayoutParams(Ui.lpw(Ui.MATCH, 0, 1f));
        body.setGravity(Gravity.CENTER);
        int p = Ui.dp(this, 26);
        body.setPadding(p, p, p, p);

        badge = Ui.badge(this, "", Ui.ONACC, Ui.ACC);
        LinearLayout badgeRow = Ui.row(this);
        badgeRow.setGravity(Gravity.CENTER);
        badgeRow.addView(badge);
        body.addView(badgeRow);

        stepTitle = Ui.tv(this, "", 24, Ui.TXT, true);
        stepTitle.setGravity(Gravity.CENTER);
        stepTitle.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        stepTitle.setMaxLines(3);
        Ui.margin(this, stepTitle, 0, 18, 0, 0);
        body.addView(stepTitle);

        stepDetail = Ui.tv(this, "", 14, Ui.DIM, false);
        stepDetail.setGravity(Gravity.CENTER);
        stepDetail.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, stepDetail, 0, 8, 0, 0);
        body.addView(stepDetail);

        clock = Ui.mono(this, "0:00", 40, Ui.ACC_TXT);
        clock.setGravity(Gravity.CENTER);
        clock.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, clock, 0, 26, 0, 0);
        body.addView(clock);

        remain = Ui.tv(this, "", 13, Ui.DIM, false);
        remain.setGravity(Gravity.CENTER);
        remain.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, remain, 0, 6, 0, 0);
        body.addView(remain);

        seek = new SeekBar(this);
        seek.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int v, boolean fromUser) { }
            public void onStartTrackingTouch(SeekBar s) { dragging = true; }
            public void onStopTrackingTouch(SeekBar s) { dragging = false; eng.seekTo(s.getProgress()); }
        });
        Ui.margin(this, seek, 0, 20, 0, 0);
        body.addView(seek);
        root.addView(body);

        // big transport, spaced so it can be found without looking
        LinearLayout tr = Ui.row(this);
        tr.setGravity(Gravity.CENTER);
        Ui.margin(this, tr, 0, 0, 0, 30);
        tr.addView(Ui.roundBtn(this, Ico.PREV, 26, false, "Previous step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.prev(); }
        }));
        tr.addView(Ui.hgap(this, 16));
        play = Ui.roundBtn(this, Ico.PAUSE, 40, true, "Pause", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.togglePause(); }
        });
        tr.addView(play);
        tr.addView(Ui.hgap(this, 16));
        tr.addView(Ui.roundBtn(this, Ico.NEXT, 26, false, "Next step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.next(); }
        }));
        root.addView(tr);

        LinearLayout stopRow = Ui.row(this);
        stopRow.setGravity(Gravity.CENTER);
        Ui.margin(this, stopRow, 0, 0, 0, 24);
        LinearLayout stop = Ui.btn(this, "Stop the program", Ico.STOP, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                eng.stop();
                try { stopService(new android.content.Intent(NowPlayingActivity.this, PlayerService.class)); }
                catch (Exception e) { /* already gone */ }
                finish();
            }
        });
        stopRow.addView(stop);
        root.addView(stopRow);
        return root;
    }

    /** Almost black, for a dark room. Any tap brings it back. */
    private void setDim(boolean on) {
        dimmed = on;
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        lp.screenBrightness = on ? 0.02f : WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE;
        getWindow().setAttributes(lp);
        if (on) Ui.toast(this, "Screen dimmed - tap anywhere to bring it back");
    }

    @Override
    public boolean dispatchTouchEvent(android.view.MotionEvent ev) {
        if (dimmed && ev.getAction() == android.view.MotionEvent.ACTION_DOWN) {
            setDim(false);
            return true;            // swallow the tap that woke the screen
        }
        return super.dispatchTouchEvent(ev);
    }

    private void render(Engine.St s) {
        if (!s.running) {
            finish();
            return;
        }
        programName.setText(s.programName);
        stepTitle.setText(s.stepTitle);
        stepDetail.setText(s.resting && s.stepDetail.length() == 0 ? "resting" : s.stepDetail);

        if (s.countIn > 0) badge.setText("READY");
        else if (s.preview) badge.setText("PREVIEW");
        else badge.setText("STEP " + (s.step + 1) + " OF " + s.steps);

        int max = Math.max(1, s.durMs);
        if (!dragging) {
            seek.setMax(max);
            seek.setProgress(Math.min(s.posMs, max));
        }
        clock.setText(Fmt.ms(s.posMs));

        StringBuilder sb = new StringBuilder();
        if (s.durMs > 0) sb.append("of ").append(Fmt.ms(s.durMs));
        if (s.stepRemainMs >= 0) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append(Fmt.human(s.stepRemainMs)).append(" left in this step");
        } else if (s.repTotal > 1) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append("pass ").append(Math.min(s.repDone + 1, s.repTotal)).append(" of ").append(s.repTotal);
        }
        if (s.progRemainMs > 0) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append("~").append(Fmt.human(s.progRemainMs)).append(" to go");
        }
        remain.setText(sb.toString());

        Ui.setIcon(play, s.paused ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
        play.setContentDescription(s.paused ? "Resume" : "Pause");
        if (shuffle != null) Ui.setIcon(shuffle, Ico.SHUFFLE, s.shuffled ? Ui.ACC_TXT : Ui.DIM);
    }

    // ---- engine callbacks ------------------------------------------------
    public void onState(Engine.St s) { render(s); }
    public void onLog(String line) { }
    public void onFinished(boolean completed) { finish(); }
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
    Remove-Item -LiteralPath '.\unaligned.apk', '.\classes.dex', '.\compiled_res.zip', '.\classes.jar', `
                ".\$ApkName", ".\$ApkName.idsig" -Force -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue '.\classes'

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
    New-Item -ItemType Directory -Force -Path '.\classes' | Out-Null
    cmd /c "javac -nowarn -Xlint:-options -source 8 -target 8 -bootclasspath ""$AndroidJar"" -encoding US-ASCII -d classes @javac.args > javac.log 2>&1"
    if ($LASTEXITCODE -ne 0) { Get-Content -LiteralPath 'javac.log' | Write-Host }
    Assert-Exit 'javac'

    # 4. bundle the classes so d8 gets one short argument
    #    (inner classes alone would blow past the Windows command line limit)
    jar.exe cf classes.jar -C classes .
    Assert-Exit 'jar (collect classes)'

    # 5. class -> dex
    d8.bat --lib $AndroidJar --min-api 26 --output . classes.jar
    Assert-Exit 'd8'

    # 6. add the dex to the apk
    jar.exe uf unaligned.apk classes.dex
    Assert-Exit 'jar (add classes.dex)'

    # 7. align, then sign (signing preserves the alignment)
    zipalign.exe -f 4 unaligned.apk $ApkName
    Assert-Exit 'zipalign'

    apksigner.bat sign --ks $Keystore --ks-pass "pass:$StorePass" --ks-key-alias $KeyAlias `
                       --key-pass "pass:$KeyPass" --min-sdk-version 26 $ApkName
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
