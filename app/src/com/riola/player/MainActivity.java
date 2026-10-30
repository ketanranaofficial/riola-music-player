package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
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
        box.addView(Ui.tv(this, "Riola  -  no ads, no network, no accounts.", 11, Ui.DIM, false));
        box.addView(Ui.gap(this, 20));

        ScrollView sv = new ScrollView(this);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = Ui.dialog(this).setTitle("Settings").setView(sv)
                .setPositiveButton("Done", null).create();
        holder[0].show();
    }
}
