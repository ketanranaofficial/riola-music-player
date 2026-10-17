# Riola Music Player

Riola is a programmable music player for Android. It lets you build playlists with repeatable steps (tracks, sections, bells, silence) and run them as scheduled programs.

## Source origin

The source under `riola/` was decompiled from the installed APK (`com.riola.player`, package version 1.0 / versionCode 4) using `apktool`. The original APK is backed up at `apks_backup/riola.apk`.

## Build requirements

- `apktool` (used to decompile/rebuild the smali resources)
- Android SDK build-tools (`aapt2`, `zipalign`, `apksigner`)
- A signing keystore (`test.keystore` is present for test signing; replace with your release keystore for production)

## How to rebuild and install

```bash
# Rebuild the APK from smali resources
apktool b riola -o riola_unsigned.apk --use-aapt2

# Sign the APK (test keystore)
apksigner sign --ks test.keystore --ks-key-alias testkey --ks-pass pass:android --key-pass pass:android riola_unsigned.apk

# Install on device
adb install -r riola_unsigned.apk
```

## Fixes applied (dev branch)

### 1. Pause-on-focus now respected for all audio focus loss events
**File:** `riola/smali/com/riola/player/PlayerService$3.smali`

Previously, when the "Pause for calls and other apps" setting was **unchecked**, the app still ducked volume (`AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK`, -3) or paused (`AUDIOFOCUS_LOSS_TRANSIENT`, -2) on focus changes. Now `pauseOnFocus` is checked for all focus-loss cases (`LOSS`, `LOSS_TRANSIENT`, `CAN_DUCK`). When unchecked, the app ignores phone rings, calls, and other audio apps entirely and keeps playing.

### 2. Repeat count bug fixed
**File:** `riola/smali/com/riola/player/Engine.smali`

Steps with `times > 1` AND `gapMs > 0` were only playing once instead of the configured `times` count. The `segment()` method had an early `return-void` in the repeat-branch (`:cond_15`) that skipped restarting the step when a gap was configured. Fixed to always proceed to gap handling and step restart.

## Original APK

The exact APK pulled from the device before any modifications is stored at `apks_backup/riola.apk`. Use `adb install -r apks_backup/riola.apk` to restore the original build.

## Notes

- The repository contains decompiled smali code, not original Java sources. All modifications were made directly to `.smali` files.
- The `build-riola.ps1` script present in the repo is a separate reference build for a different app (`com.example.player`) and is not used to build Riola.