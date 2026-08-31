# Riola

A programmable music player for Android. You pick some tracks, write a short
program that says what to play, how many times, which slice of a track, and how
long to sit in silence — then hit run.

Built for practice loops, sleep/meditation sequences, interval training, ear
training: anything where "play this bit for ten minutes, rest two, then the
whole thing twice" is easier to write than to babysit.

## The whole app is one script

`build-riola.ps1` writes every source file and compiles a signed APK with the
Android SDK command-line tools. No Gradle, no AndroidX, no third-party
libraries — just `aapt2`, `javac`, `d8`, `zipalign` and `apksigner` against
`android.jar`.

```powershell
.\build-riola.ps1              # write sources + build riola\riola.apk
.\build-riola.ps1 -Clean       # wipe the output tree first
.\build-riola.ps1 -SourcesOnly # only write the sources
.\build-riola.ps1 -Install     # build, then adb install -r
```

Requirements: Android SDK with `platforms\android-34` and build-tools 33+, a
JDK (17 works), and a debug keystore (the script creates one if missing).

Everything under `riola/` is generated, so it is git-ignored. Edit the script,
not the generated Java.

## The language

One command per line, case insensitive, `#` and `//` start comments. Tracks are
addressed by the number shown next to them in the library.

```
PLAY 0                            play track 0 once
PLAY 0 3 TIMES                    ... three times   (also: x3)
PLAY 0 FOR 20 MIN                 keep replaying it for twenty minutes
LOOP 0 FOR 20 MIN                 same thing

SECTION 1 0:30 1:15               play just that slice
SECTION 1 0:30 1:15 8 TIMES       loop the slice eight times
SECTION 1 0:30 1:15 FOR 12 MIN    loop the slice for twelve minutes
SECTION 1 0:30-1:15 x8            dash form
SECTION 1 2:00 END                from 2:00 to the end of the track

PAUSE 5 MIN                       silence (also WAIT / SILENCE)
PAUSE 90 SEC
PAUSE 2:30

REPEAT 4                          repeat a block, nestable eight deep
  SECTION 0 0:10 0:40 x2
  PAUSE 30 SEC
END

VOLUME 70                         these apply to the steps that follow
SPEED 1.25
FADE 200                          fade at every loop edge, in ms
```

Lengths accept `90 SEC`, `5 MIN`, `1.5 MIN`, `2:30`, `500 MS`, `1 HOUR`.
Positions accept `0:30`, `1:02:05`, bare seconds, and `END`.

## What the app does

- **Library** — add individual files or scan a whole folder (Storage Access
  Framework, so no storage permission and the grants survive reboots).
  Durations are read in the background.
- **A-B picker** — audition a track, mark A and B by ear with 1s/5s nudges,
  and drop a finished `SECTION` line into the program.
- **Live step list** — every step with its estimated length; tap one to jump
  there while running, or to start the program from there.
- **Transport** — pause/resume, previous/next step, scrub, and a step list that
  highlights where you are. Time left in the step and in the whole program.
- **Background playback** — a foreground service with notification and lock
  screen controls, audio focus handling (pauses for calls, ducks for
  notifications), pause on headphone unplug, and an optional CPU wake lock so
  long silences do not oversleep.
- **Settings** — dark/light, keep screen on, master volume, playback speed,
  loop-edge fade, and the safety toggles above.
- **Saved programs** — name and reload as many programs as you like.

Nothing leaves the phone: no network permission, no accounts, no analytics.

## Layout of the generated code

| File | What it does |
| --- | --- |
| `MainActivity` | the whole screen, built programmatically |
| `Engine` | worker thread + one `MediaPlayer`, runs the step list |
| `PlayerService` | foreground service, notification, MediaSession, audio focus |
| `Parser` / `Cmd` | the script language |
| `Store` / `Prefs` | persistence (SharedPreferences + JSON) |
| `Ui` / `Ico` | palette, widget factory, hand-drawn vector icons |
| `AbDialog` | the A-B section picker |
| `Fmt` / `HelpText` | formatting and the in-app reference |

Min SDK 26, target SDK 34.
