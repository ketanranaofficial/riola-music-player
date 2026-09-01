# Riola

A programmable music player for Android. Add some tracks, then build a program
by tapping: play this whole track, loop that 40-second section eight times with
a three-second rest between each, sit in silence for two minutes, repeat the
whole thing four times.

Built for practice loops, sleep and meditation sequences, interval training,
ear training — anything where "play this bit for ten minutes, rest two, then
the whole thing twice" is easier to set up once than to babysit.

There is no scripting language and nothing to type. Every part of a program is
a tap.

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

## How a program is built

**Home** lists your saved programs, each with a play button. Tap a program to
edit it, tap play to run it.

**A program** is an ordered list of steps plus a repeat count for the whole
list (once, a few times, or forever).

**A step** is one of four things:

| Step | What it does |
| --- | --- |
| Whole track | plays a track start to finish |
| Section | plays one A-B slice of a track |
| Silence | plays nothing (and can end with a bell) |
| Bell | a soft chime to mark a change |

Every playing step repeats either **a number of times** or **for a length of
time**, and can carry a gap between repeats, its own speed, its own volume, and
an on/off switch so you can park a step without deleting it.

**The bell** is synthesised at runtime, so the APK still carries no audio
assets. Six partials over a fundamental, where the bright ones decay in under a
second and the low ones ring on for four to six, an 8 ms ramped attack so there
is no click, and a second prime a hair sharp for a slow shimmer. Three voices,
one to nine rings with a gap you choose. It is built to mark a moment without
jolting you — which matters when the whole point is that your eyes are closed.

**Sections** can be typed as minutes and seconds, or marked by ear: play the
track, tap *Set A* and *Set B*, nudge each mark by a second, and loop the slice
while you fine-tune it.

## What else it does

- **Library** — add files or scan a whole folder. Storage Access Framework, so
  no storage permission, and the grants survive reboots. Durations are read in
  the background; tracks can be renamed, reordered and previewed.
- **Steps reference the track itself**, not its position, so reordering or
  renaming the library never breaks a program. Remove a track a program uses
  and the step is flagged *missing* and skipped rather than stopping the run.
- **Background playback** — a foreground service with notification and lock
  screen transport, MediaSession, audio focus handling (pauses for calls, ducks
  for notifications), pause on headphone unplug, and an optional CPU wake lock
  so long silences stay exact.
- **While running** — pause/resume, previous/next step, tap any step to jump to
  it, scrub inside the current track, and see time left in the step and in the
  whole program. The editor scrolls itself to keep the playing step in view.
- **Full screen player** — tap the transport strip for large controls you can
  find without looking, the time in big figures, and a moon button that dims
  the screen to near black for a dark room.
- **Missing files are caught before playback**, not twenty minutes into a
  session: Riola opens every track a program needs first and names the steps
  that cannot play.
- **Settings** — dark/light, keep screen on, master volume and speed, loop-edge
  fade, a count-in before the first step, and a stop-after timer.

No network permission, no accounts, no analytics. Nothing leaves the phone.

## Layout of the generated code

| File | What it does |
| --- | --- |
| `MainActivity` | home: saved programs, live step list, settings |
| `EditorActivity` | the tap-to-build program editor |
| `NowPlayingActivity` | the full screen player |
| `Bell` | the synthesised chime |
| `Runner` | pre-play checks, then hands the program to the engine |
| `LibraryActivity` | the track library |
| `StepSheet` | the editor for one step |
| `AbDialog` | mark a section by ear |
| `Pickers` | track / length / position / name dialogs |
| `PlayerBar` | the shared transport strip |
| `Engine` | worker thread + one `MediaPlayer`, runs the step list |
| `PlayerService` | foreground service, notification, MediaSession, audio focus |
| `Program` / `Step` | the data model |
| `Store` / `Prefs` | persistence (SharedPreferences + JSON) |
| `Ui` / `Ico` | palette, widget factory, hand-drawn vector icons |
| `Fmt` / `HelpText` | formatting and the in-app guide |

Min SDK 26, target SDK 34. Tested on a Galaxy A55 running Android 16.
