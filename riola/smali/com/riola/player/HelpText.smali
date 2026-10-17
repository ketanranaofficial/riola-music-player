.class public final Lcom/riola/player/HelpText;
.super Ljava/lang/Object;
.source "HelpText.java"


# static fields
.field public static final SECTIONS:[[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 15

    .line 8
    const-string v0, "The idea"

    const-string v1, "A program is a list of steps that Riola plays from top to bottom. You build it by tapping, so there is nothing to type and no syntax to remember."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v2

    const-string v0, "1. Add your tracks"

    const-string v1, "Open Tracks and add files, or point Riola at a whole folder. Riola only reads them: your files are never moved, copied or changed. Tap a track to hear it."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v3

    const-string v0, "2. Build the steps"

    const-string v1, "There are four kinds of step.\n\nWhole track plays a track from start to finish.\nSection plays one slice of a track, from A to B.\nSilence plays nothing for a while.\nBell rings a soft chime to mark a change."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v4

    const-string v0, "3. Say how often"

    const-string v1, "Every playing step repeats in one of two ways: a number of times, or for a length of time. Play the phrase eight times, or keep looping it for twelve minutes."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v5

    const-string v0, "Fine tuning a step"

    const-string v1, "Gap adds a rest between one repeat and the next.\nSpeed plays it slower or faster without changing the pitch.\nVolume makes one step quieter than the rest.\nTurning a step off keeps it in the list but skips it for now."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v6

    const-string v0, "Marking a section by ear"

    const-string v1, "In a section step, tap Pick by ear. Play the track, tap Set A where the slice should start and Set B where it should end. The 1s and 5s buttons nudge each mark, and Loop A-B plays the slice on repeat while you fine tune it."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v7

    const-string v0, "The bell"

    const-string v1, "Put a bell between two silences and you have a session you can follow with your eyes closed: sit for five minutes, hear the chime, change your breathing, sit for five more.\n\nThere are three voices, and it can ring more than once with a gap you choose. Tap Hear it while you set it up. The tone fades in softly and rings out slowly, so it marks the moment without jolting you."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v8

    const-string v0, "Running a program"

    const-string v1, "Press play next to a program on the home screen, or Run inside the editor. While it runs you can pause, jump to the previous or next step, tap any step to go straight to it, and drag the progress bar to move inside the current track.\n\nPlayback keeps going when you leave the app or lock the phone. The notification and the lock screen carry the same controls."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v9

    const-string v0, "The full screen player"

    const-string v1, "Tap the strip at the bottom while something is playing and it opens full screen, with large controls you can find without looking and the time in big figures.\n\nThe moon button dims the screen right down for a dark room; a tap anywhere brings it back."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v10

    const-string v0, "Repeating everything"

    const-string v1, "In the editor, Repeat program says how many times the whole list runs. Set it to forever for an endless session."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v11

    const-string v0, "Settings worth knowing"

    const-string v1, "Count in gives you a few seconds of silence before step one, handy if you need to pick up an instrument.\nStop after is a sleep timer that ends everything after a set number of minutes.\nFade at edges softens the jump when a loop restarts.\nKeep the CPU awake holds the processor on so long silences stay exact.\nPausing for calls and for unplugged headphones is on by default."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v12

    const-string v0, "If a track goes missing"

    const-string v1, "Steps remember the track itself, so reordering or renaming tracks never breaks a program. If a file is deleted or its storage is unavailable, Riola tells you which steps are affected before it starts playing, and those steps are skipped rather than stopping the session."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v13

    const-string v0, "Privacy"

    const-string v1, "Everything stays on the phone. Riola has no network permission at all, no accounts and no analytics."

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v14

    filled-new-array/range {v2 .. v14}, [[Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/HelpText;->SECTIONS:[[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
