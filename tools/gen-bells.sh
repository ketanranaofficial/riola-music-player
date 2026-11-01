#!/usr/bin/env bash
# Regenerates app/res/raw/bell_*.wav from the synthesis in Bell.java.
# Run it after changing the bell's partials, decay or length, then rebuild.
# Needs a JDK and android.jar (ANDROID_JAR, or the newest under $ANDROID_HOME/platforms).
set -euo pipefail
cd "$(dirname "$0")/.."
ANDROID_HOME=${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}}
if [ -z "${ANDROID_JAR:-}" ]; then
    pl=$(ls -1 "$ANDROID_HOME/platforms" 2>/dev/null | grep -E '^android-[0-9]+$' | sort -V | tail -n 1 || true)
    [ -n "$pl" ] || { echo "No android.jar found. Set ANDROID_JAR." >&2; exit 1; }
    ANDROID_JAR=$ANDROID_HOME/platforms/$pl/android.jar
fi
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p app/res/raw
# R.java is only needed so Bell.java compiles; the generator never touches it
mkdir -p "$tmp/src/com/riola/player"
cat > "$tmp/src/com/riola/player/R.java" <<'EOR'
package com.riola.player;
public final class R { public static final class raw { public static final int bell_low = 0, bell_warm = 0, bell_bright = 0, bell_desk = 0; } }
EOR
javac -nowarn -Xlint:-options -source 8 -target 8 -bootclasspath "$ANDROID_JAR" -d "$tmp/classes" \
      app/src/com/riola/player/Bell.java tools/GenBells.java "$tmp/src/com/riola/player/R.java"
java -cp "$tmp/classes:$ANDROID_JAR" com.riola.player.GenBells app/res/raw
