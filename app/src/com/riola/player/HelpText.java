package com.riola.player;

/** The in-app guide, as heading and body pairs so it can be laid out properly. */
public final class HelpText {

    private HelpText() { }

    public static final String ABOUT_TITLE = "About Riola";

    /** The last block of the guide. The version comes from the app itself, so it never goes stale. */
    public static String about(String version) {
        return "Riola is a programmable music player for practice loops, meditation and sleep "
             + "sequences, interval training and ear training: anything where \"play this bit "
             + "for ten minutes, rest two, then the whole thing twice\" is easier to set up once "
             + "than to babysit.\n\n"
             + "Made by ketanranaofficial. Free and open source under the MIT licence:\n"
             + "https://github.com/ketanranaofficial/riola-music-player\n\n"
             + "Version " + version + ".";
    }

    public static final String[][] SECTIONS = {
        { "The idea",
          "A program is a list of steps that Riola plays from top to bottom. You build it by "
        + "tapping, so there is nothing to type and no syntax to remember." },

        { "1. Add your tracks",
          "Open Tracks and add files, or point Riola at a whole folder. Riola only reads them: "
        + "your files are never moved, copied or changed. Tap a track to open its menu: "
        + "preview it, rename it, move it up or down, or remove it. The sort button orders the "
        + "whole list.\n\n"
        + "Video files work too, and only their sound is played. If a file carries several audio "
        + "streams, a dubbed film for instance, pick the one to use with Choose audio stream." },

        { "2. Build the steps",
          "There are four kinds of step.\n\n"
        + "Whole track plays a track from start to finish.\n"
        + "Section plays one slice of a track, from A to B.\n"
        + "Silence plays nothing for a while.\n"
        + "Bell rings a soft chime to mark a change.\n\n"
        + "If you delete a step by mistake, tap Undo straight away." },

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
        + "There are four voices. Low, Warm and Bright are soft bowls that ring for about six, "
        + "five and four seconds; Desk is a quick ting of about a second. A bell can ring more "
        + "than once, with a gap you choose. Tap Hear it while you set it up. The tone fades in "
        + "softly and rings out slowly, so it marks the moment without jolting you.\n\n"
        + "A silence can end with a bell too: switch on End with a bell. Riola lets the bell "
        + "finish ringing before the next step starts, so it never sounds over your music. If "
        + "the next step is more silence, the bell simply rings on into it, and a bell on the "
        + "very last step is heard in full before the session ends." },

        { "Running a program",
          "Press play next to a program on the home screen, or Run inside the editor. While it "
        + "runs you can pause, jump to the previous or next step, tap any step to go straight to "
        + "it, and drag the progress bar to move inside the current track.\n\n"
        + "Playback keeps going when you leave the app or lock the phone. The notification, "
        + "the lock screen and the buttons on a headset carry the same controls, and next and "
        + "previous move between steps.\n\n"
        + "The shuffle button plays the steps in a random order instead, with a new order each "
        + "time the program repeats. Your program is not changed, and you can switch back at "
        + "any time." },

        { "The full screen player",
          "Tap the strip at the bottom while something is playing and it opens full screen, with "
        + "large controls you can find without looking and the time in big figures.\n\n"
        + "The moon button dims the screen right down for a dark room; a tap anywhere brings it "
        + "back." },

        { "Repeating everything",
          "In the editor, Repeat program says how many times the whole list runs. Set it to "
        + "forever for an endless session." },

        { "Colour and look",
          "Colour sets the accent used for buttons, toggles, highlights and the playing step. "
        + "Pick one of the presets or mix your own.\n\n"
        + "Look changes the shape of everything: corners, borders, type and spacing. There are "
        + "ten, from the soft Material default to Brutalist and Neon.\n\n"
        + "Dark theme switches between a dark and a light page. The three are independent, so "
        + "any colour works with any look in either." },

        { "Settings worth knowing",
          "Count in before starting gives you a few seconds of silence before step one, handy "
        + "if you need to pick up an instrument.\n"
        + "Stop everything after is a sleep timer that ends the session after a set number of "
        + "minutes.\n"
        + "Fade at loop edges softens the jump when a loop restarts.\n"
        + "Keep the CPU awake holds the processor on so long silences stay exact.\n"
        + "Pause when headphones unplug stops playback if the headset is unplugged or its "
        + "Bluetooth connection drops.\n"
        + "Pause for calls and other apps is on by default. Switch it off and Riola keeps "
        + "playing through calls and other audio, without pausing or turning down." },

        { "Backing up and moving to another phone",
          "On the home screen, Export all writes every program to a file you choose, and a "
        + "program's own menu has Export to a file for just one. Import reads a file back and "
        + "tells you exactly what it added and what it skipped.\n\n"
        + "The file holds your programs and the names of the tracks they use, not the music "
        + "itself. After importing on a new phone, add the tracks again and the steps "
        + "reconnect on their own." },

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
