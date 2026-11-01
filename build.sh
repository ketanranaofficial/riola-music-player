#!/usr/bin/env bash
# Riola - build a signed, zipaligned APK on Linux (Ubuntu).
# No Gradle, no AndroidX, no dependencies: aapt2, javac, d8, zipalign and
# apksigner against android.jar.
#
# Usage
#   ./build.sh                    # debug-signed build/riola.apk
#   ./build.sh --install          # build, then adb install -r
#   ./build.sh --clean            # wipe build/ first
#   ./build.sh --app-id com.riola.player.test --debuggable --out build/test
#                                 # side-by-side test build; leaves the installed app alone
#   ./build.sh --release --keystore ~/keys/riola-upload.jks --alias riola \
#              --version-code 5 --version-name 1.1
#
# Requirements
#   - JDK 17+ on PATH (javac, jar, keytool)
#   - Android SDK pieces, found in this order:
#       ANDROID_JAR   path to android.jar          (else $ANDROID_HOME/platforms/android-N/android.jar)
#       BUILD_TOOLS   dir holding aapt2, d8, ...   (else newest $ANDROID_HOME/build-tools/*)
#     ANDROID_HOME defaults to $ANDROID_SDK_ROOT, then ~/Android/Sdk.
#   - Release signing asks for the keystore password in the terminal. For scripts,
#     RIOLA_STOREPASS (and optionally RIOLA_KEYPASS) in the environment is read
#     instead, so the password is never on the command line.
set -euo pipefail
cd "$(dirname "$0")"

OUT=build
APK_NAME=riola.apk
MIN_SDK=26
TARGET_SDK=0
VERSION_CODE=6
VERSION_NAME=1.2
CLEAN=0 INSTALL=0 RELEASE=0
KEYSTORE='' KEY_ALIAS=''
APP_ID='' DEBUGGABLE=0

die() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }
say() { printf '\033[36m%s\033[0m\n' "$*"; }
ok()  { printf '\033[32m%s\033[0m\n' "$*"; }

while [ $# -gt 0 ]; do
    case "$1" in
        --clean)        CLEAN=1 ;;
        --install)      INSTALL=1 ;;
        --release)      RELEASE=1 ;;
        --keystore)     KEYSTORE=${2:?--keystore needs a path}; shift ;;
        --alias)        KEY_ALIAS=${2:?--alias needs a name}; shift ;;
        --version-code) VERSION_CODE=${2:?--version-code needs a number}; shift ;;
        --version-name) VERSION_NAME=${2:?--version-name needs a string}; shift ;;
        --target-sdk)   TARGET_SDK=${2:?--target-sdk needs a number}; shift ;;
        --app-id)       APP_ID=${2:?--app-id needs a package name}; shift ;;
        --debuggable)   DEBUGGABLE=1 ;;
        --out)          OUT=${2:?--out needs a directory}; shift ;;
        -h|--help)      sed -n '2,/^set -euo/p' "$0" | sed '$d;s/^# \{0,1\}//'; exit 0 ;;
        *)              die "unknown option: $1 (see --help)" ;;
    esac
    shift
done

# ---------------------------------------------------------------------------
# 0. Locate the SDK / tools
# ---------------------------------------------------------------------------
say "=== Riola build ==============================================="

command -v javac >/dev/null || die "javac not found. Install a JDK:  sudo apt install openjdk-17-jdk-headless"
command -v jar   >/dev/null || die "jar not found (part of the JDK)."

ANDROID_HOME=${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}}

# newest entry of a directory, by version order
newest() { ls -1 "$1" 2>/dev/null | sort -V | tail -n 1; }

if [ -z "${BUILD_TOOLS:-}" ]; then
    bt=$(newest "$ANDROID_HOME/build-tools")
    [ -n "$bt" ] || die "No build-tools in $ANDROID_HOME/build-tools. Set ANDROID_HOME or BUILD_TOOLS (see --help)."
    BUILD_TOOLS=$ANDROID_HOME/build-tools/$bt
fi
for t in aapt2 d8 zipalign apksigner; do
    [ -x "$BUILD_TOOLS/$t" ] || die "$t not found in $BUILD_TOOLS"
done
PATH=$BUILD_TOOLS:$PATH

if [ -z "${ANDROID_JAR:-}" ]; then
    if [ "$TARGET_SDK" -gt 0 ]; then
        pl=android-$TARGET_SDK
    else
        pl=$(newest "$ANDROID_HOME/platforms" | grep -E '^android-[0-9]+$' || true)
        [ -n "$pl" ] || die "No android platform in $ANDROID_HOME/platforms. Install one:
  sdkmanager \"platforms;android-34\"   (or set ANDROID_JAR to an android.jar)"
    fi
    ANDROID_JAR=$ANDROID_HOME/platforms/$pl/android.jar
    [ "$TARGET_SDK" -gt 0 ] || TARGET_SDK=${pl#android-}
fi
[ -f "$ANDROID_JAR" ] || die "Missing $ANDROID_JAR"
# With a custom ANDROID_JAR and no --target-sdk, fall back to 34.
[ "$TARGET_SDK" -gt 0 ] || TARGET_SDK=34

if [ "$RELEASE" = 1 ]; then
    [ -n "$KEYSTORE" ] && [ -f "$KEYSTORE" ] || die "--release needs --keystore pointing at your upload key. See RELEASING.md."
    [ -n "$KEY_ALIAS" ] || die "--release needs --alias."
    if [ -z "${RIOLA_STOREPASS:-}" ]; then
        # No password in the environment: ask for it, with nothing echoed and nothing
        # left in the shell history. This works the same whichever shell started the script.
        [ -t 0 ] || die "--release needs the keystore password: set RIOLA_STOREPASS, or run this in a terminal and it will ask."
        read -rsp "Password for $KEYSTORE: " RIOLA_STOREPASS
        echo
        [ -n "$RIOLA_STOREPASS" ] || die "No password entered."
        export RIOLA_STOREPASS
    fi
    export RIOLA_KEYPASS=${RIOLA_KEYPASS:-$RIOLA_STOREPASS}
    STORE_PASS=env:RIOLA_STOREPASS
    KEY_PASS=env:RIOLA_KEYPASS
else
    KEYSTORE=$HOME/.android/debug.keystore
    KEY_ALIAS=androiddebugkey
    STORE_PASS=pass:android
    KEY_PASS=pass:android
    if [ ! -f "$KEYSTORE" ]; then
        say "No debug keystore - creating one..."
        mkdir -p "$(dirname "$KEYSTORE")"
        keytool -genkeypair -keystore "$KEYSTORE" -storepass android -keypass android \
                -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10950 \
                -dname "CN=Android Debug,O=Android,C=US" >/dev/null
    fi
fi

echo "  build-tools  : $BUILD_TOOLS"
echo "  android.jar  : $ANDROID_JAR"
echo "  target sdk   : $TARGET_SDK (min $MIN_SDK)"
echo "  version      : $VERSION_NAME ($VERSION_CODE)"
echo "  signing      : $([ "$RELEASE" = 1 ] && echo "release key $KEY_ALIAS" || echo "debug key")"
echo "  out dir      : $OUT"

# ---------------------------------------------------------------------------
# 1. Prepare output tree
# ---------------------------------------------------------------------------
[ "$CLEAN" = 1 ] && { say "[clean] removing $OUT"; rm -rf "$OUT"; }
mkdir -p "$OUT"
rm -rf "$OUT/classes" "$OUT/gen" "$OUT/compiled_res.zip" "$OUT/classes.jar" \
       "$OUT/classes.dex" "$OUT/unaligned.apk" "$OUT/$APK_NAME" "$OUT/$APK_NAME.idsig"
mkdir -p "$OUT/classes" "$OUT/gen"

# ---------------------------------------------------------------------------
# 2. Build
# ---------------------------------------------------------------------------
say "[1/2] building"

# resources -> flat archive
aapt2 compile --dir app/res -o "$OUT/compiled_res.zip"

# link resources + manifest, emit R.java. Version and target come from here,
# not from the manifest. --app-id renames the installed package only; the Java
# code and R.java stay in com.riola.player.
EXTRA=()
[ -n "$APP_ID" ] && EXTRA+=(--rename-manifest-package "$APP_ID" --custom-package com.riola.player)
[ "$DEBUGGABLE" = 1 ] && EXTRA+=(--debug-mode)
aapt2 link "${EXTRA[@]}" -I "$ANDROID_JAR" --manifest app/AndroidManifest.xml -R "$OUT/compiled_res.zip" \
           --java "$OUT/gen" --auto-add-overlay \
           --min-sdk-version "$MIN_SDK" --target-sdk-version "$TARGET_SDK" \
           --version-code "$VERSION_CODE" --version-name "$VERSION_NAME" \
           -o "$OUT/unaligned.apk"

# java -> class (framework classes come from android.jar only)
mapfile -t SOURCES < <(find app/src "$OUT/gen" -name '*.java' | sort)
javac -nowarn -Xlint:-options -source 8 -target 8 -bootclasspath "$ANDROID_JAR" \
      -encoding US-ASCII -d "$OUT/classes" "${SOURCES[@]}"

# class -> dex, then add the dex to the apk
jar cf "$OUT/classes.jar" -C "$OUT/classes" .
d8 --lib "$ANDROID_JAR" --min-api "$MIN_SDK" --output "$OUT" "$OUT/classes.jar"
( cd "$OUT" && jar uf unaligned.apk classes.dex )

# align, then sign (signing preserves the alignment)
zipalign -f 4 "$OUT/unaligned.apk" "$OUT/$APK_NAME"
apksigner sign --ks "$KEYSTORE" --ks-pass "$STORE_PASS" --ks-key-alias "$KEY_ALIAS" \
         --key-pass "$KEY_PASS" --min-sdk-version "$MIN_SDK" "$OUT/$APK_NAME"
apksigner verify --min-sdk-version "$MIN_SDK" "$OUT/$APK_NAME"

say "[2/2] done"
ok "  APK   : $(realpath "$OUT/$APK_NAME")"
ok "  size  : $(( $(stat -c %s "$OUT/$APK_NAME") / 1024 )) KB"

if [ "$INSTALL" = 1 ]; then
    say "[install] adb install -r"
    adb install -r "$OUT/$APK_NAME"
else
    echo "  Copy it to the phone, or run:  adb install -r $OUT/$APK_NAME"
fi
