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
