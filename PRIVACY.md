# Privacy Policy for Riola

**Last updated: 1 September 2026**

Riola does not collect, store, transmit or share any personal data. There is no
account, no analytics, no advertising, no crash reporting and no tracking of any
kind.

## The short version

Riola has **no internet permission at all**. It is not capable of sending
anything anywhere, and you can verify that yourself: the app declares exactly
four permissions, none of which is `INTERNET`.

## What the app stores

Everything Riola keeps lives in its own private storage on your device, and is
removed when you uninstall it:

- Your programs — their names, steps, times and settings.
- A list of the audio files you added, held as Android document references
  plus the file name and length.
- Your preferences — theme, colour, volume, speed and the rest.

If you use **Export**, Riola writes a file to the location *you* pick. Nothing
is uploaded; the file goes only where you send it.

## Your audio files

Riola reads the audio and video files you choose through Android's Storage
Access Framework. It never copies, moves, modifies or deletes them, and it only
has access to the specific files or folders you selected.

Video files are read for their audio only.

## Permissions and why they exist

| Permission | Why |
| --- | --- |
| `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK` | Keeps a program playing when the app is not on screen |
| `POST_NOTIFICATIONS` | Shows the playback notification with its controls |
| `WAKE_LOCK` | Keeps the processor awake so long silences stay accurate |

There is no storage permission, because the Storage Access Framework does not
need one.

## Children

Riola contains no ads, no purchases and no user-generated content, and collects
nothing from anyone, including children.

## Changes

Any change to this policy will be published in this file in the project
repository, with the date above updated.

## Contact

Questions about this policy can be raised as an issue in the project
repository.
