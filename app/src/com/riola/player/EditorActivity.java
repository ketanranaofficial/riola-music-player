package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/** Build a program by tapping: no typing, no syntax. */
public class EditorActivity extends Activity implements PlayerBar.Host {

    private Prefs prefs;
    private Engine eng;
    private PlayerBar bar;
    private Program prog;

    private static final int REQ_EXPORT = 301;

    private LinearLayout stepsBox, loopBox;
    private android.widget.ScrollView scroller;
    private int liveRow = -1;
    private TextView titleView, subView, totalBadge;
    private final List<View> rows = new ArrayList<View>();
    private boolean dirty;
    private Step undoStep;          // last deleted, kept briefly so it can come back
    private int undoAt = -1;
    private int undoLeft;           // seconds still on the clock
    private TextView undoLabel;
    private static final int UNDO_SECONDS = 20;
    private final android.os.Handler ui = new android.os.Handler(android.os.Looper.getMainLooper());
    private final Runnable undoTick = new Runnable() {
        public void run() {
            if (undoStep == null) return;
            undoLeft--;
            if (undoLeft <= 0) {
                undoStep = null;
                undoAt = -1;
                refresh();
                return;
            }
            if (undoLabel != null) undoLabel.setText("Step removed  .  " + undoLeft + "s");
            ui.postDelayed(this, 1000);
        }
    };

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes());
        super.onCreate(saved);
        Store.load(this);
        eng = Engine.get(this);
        prog = Store.program(getIntent().getStringExtra("id"));
        if (prog == null) { finish(); return; }
        setContentView(build());
        Ui.applyWindow(this);
        refresh();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (prog == null) return;
        bar.attach();
        if (prefs.keepScreenOn()) getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        refresh();
    }

    @Override
    protected void onPause() {
        ui.removeCallbacks(undoTick);
        undoStep = null;
        undoAt = -1;
        undoLabel = null;
        if (prog != null) {
            bar.detach();
            // Every edit already saves through save(); writing again here would
            // bump the program's timestamp just for opening it and reshuffle
            // the home list.
            if (dirty) { Store.put(this, prog); dirty = false; }
        }
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
            Ui.iconBtn(this, Ico.PLAY, Ui.ACC_TXT, 20, "Run this program", new View.OnClickListener() {
                public void onClick(View v) { run(0); }
            }),
            Ui.iconBtn(this, Ico.MORE, Ui.DIM, 20, "More options", new View.OnClickListener() {
                public void onClick(View v) { menu(); }
            })
        };
        Ui.Bar header = Ui.appBar(this, 0, prog.name, prog.summary(), true, actions);
        titleView = header.title;
        subView = header.sub;
        header.titles.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { rename(); }
        });
        root.addView(header.view);

        LinearLayout body = Ui.col(this);

        LinearLayout loops = Ui.card(this);
        loops.addView(Ui.heading(this, Ico.LOOP, "Repeat program"));
        loopBox = Ui.col(this);
        loops.addView(loopBox);
        body.addView(loops);

        LinearLayout card = Ui.card(this);
        LinearLayout head = Ui.row(this);
        LinearLayout hd = Ui.heading(this, Ico.LIST, "Steps");
        hd.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        head.addView(hd);
        totalBadge = Ui.badge(this, "", Ui.DIM, Ui.SURF2);
        head.addView(totalBadge);
        card.addView(head);

        stepsBox = Ui.col(this);
        card.addView(stepsBox);

        LinearLayout add = Ui.btn(this, "Add step", Ico.PLUS, Ui.PRIMARY, new View.OnClickListener() {
            public void onClick(View v) { addStep(); }
        });
        add.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, add, 0, 10, 0, 0);
        card.addView(add);
        body.addView(card);

        body.addView(Ui.gap(this, 6));
        scroller = Ui.scroller(this, body);
        root.addView(scroller);

        bar = new PlayerBar(this, this);
        root.addView(bar.view);
        return root;
    }

    /** Keep the playing step on screen in a long program. */
    private void scrollToRow(final View row) {
        if (scroller == null || row == null) return;
        scroller.post(new Runnable() {
            public void run() {
                int y = 0;
                View v = row;
                while (v != null && v.getParent() instanceof View && v.getParent() != scroller) {
                    y += v.getTop();
                    v = (View) v.getParent();
                }
                if (v != null) y += v.getTop();
                scroller.smoothScrollTo(0, Math.max(0, y - Ui.dp(EditorActivity.this, 150)));
            }
        });
    }

    private void refresh() {
        if (prog == null) return;
        titleView.setText(prog.name);
        subView.setText(prog.summary());
        totalBadge.setText(prog.steps.isEmpty() ? "empty" : Fmt.rough(prog.estMs()));

        loopBox.removeAllViews();
        final int mode = prog.loops < 0 ? 2 : (prog.loops <= 1 ? 0 : 1);
        loopBox.addView(Ui.seg(this, new String[]{ "Once", "A few times", "Forever" }, mode, new Ui.OnPick() {
            public void set(int index) {
                prog.loops = index == 0 ? 1 : (index == 1 ? Math.max(2, prog.loops) : -1);
                save();
                refresh();
            }
        }));
        if (mode == 1) {
            LinearLayout r = Ui.row(this);
            Ui.margin(this, r, 0, 8, 0, 0);
            TextView t = Ui.tv(this, "Run the whole list", 13.5f, Ui.DIM, false);
            t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            r.addView(t);
            LinearLayout st = Ui.stepper(this, Math.max(2, prog.loops), 2, 99, 1, "x", new Ui.OnValue() {
                public void set(int v) {
                    prog.loops = v;
                    save();
                    subView.setText(prog.summary());
                    totalBadge.setText(Fmt.rough(prog.estMs()));
                }
            });
            st.setLayoutParams(Ui.lp(Ui.dp(this, 160), Ui.WRAP));
            r.addView(st);
            loopBox.addView(r);
        }

        stepsBox.removeAllViews();
        rows.clear();
        if (undoStep != null) stepsBox.addView(undoBar());
        if (prog.steps.isEmpty()) {
            stepsBox.addView(Ui.emptyState(this, Ico.LIST, "No steps yet",
                    "Add a whole track, a section of a track, or a stretch of silence."));
        } else {
            for (int i = 0; i < prog.steps.size(); i++) stepsBox.addView(stepRow(i));
        }
        bar.render(eng.st);
    }

    /** A short lived "step removed - undo" strip, friendlier than a confirm dialog. */
    private View undoBar() {
        View.OnClickListener undo = new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                restoreStep();
            }
        };
        LinearLayout r = Ui.row(this);
        r.setBackground(Ui.ripple(Ui.rrs(this, Ui.SURF2, Ui.AMBER, 12, 1)));
        r.setPadding(Ui.dp(this, 12), Ui.dp(this, 12), Ui.dp(this, 8), Ui.dp(this, 12));
        Ui.margin(this, r, 0, 0, 0, 8);
        // the whole strip undoes, not just the button - it is a small target
        // with a short life, so it should be hard to miss
        r.setClickable(true);
        r.setContentDescription("Undo removing the step");
        r.setOnClickListener(undo);
        undoLabel = Ui.tv(this, "Step removed  .  " + Math.max(1, undoLeft) + "s", 13, Ui.TXT, false);
        undoLabel.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(undoLabel);
        r.addView(Ui.btn(this, "Undo", Ico.RESET, Ui.SECONDARY, undo));
        return r;
    }

    /** Puts the last deleted step back where it was. */
    private void restoreStep() {
        ui.removeCallbacks(undoTick);
        Step back = undoStep;
        int at = undoAt;
        undoStep = null;
        undoAt = -1;
        if (back == null || prog == null) {
            refresh();          // at least clear the strip rather than sit there dead
            Ui.toast(this, "Too late to undo");
            return;
        }
        prog.steps.add(Math.max(0, Math.min(at, prog.steps.size())), back);
        save();
        refresh();
        Ui.toast(this, "Step restored");
    }

    private void removeStep(int index) {
        undoStep = prog.steps.remove(index);
        undoAt = index;
        undoLeft = UNDO_SECONDS;
        ui.removeCallbacks(undoTick);
        ui.postDelayed(undoTick, 1000);
        save();
        refresh();
    }

    private View stepRow(final int index) {
        final Step s = prog.steps.get(index);
        final boolean on = s.enabled;
        boolean live = eng.isPlaying(prog) && eng.st.step == index;

        LinearLayout r = Ui.row(this);
        r.setBackground(live ? Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f)
                             : Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD)));
        r.setPadding(Ui.dp(this, 8), Ui.dp(this, 9), Ui.dp(this, 2), Ui.dp(this, 9));
        Ui.margin(this, r, 0, 0, 0, 8);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // While this program is playing, a tap means "go here" - which is
                // what the guide promises. Editing stays on the menu.
                if (eng.isPlaying(prog)) { Ui.buzz(v); eng.jumpTo(index); }
                else edit(index);
            }
        });
        r.setOnLongClickListener(new View.OnLongClickListener() {
            public boolean onLongClick(View v) { stepMenu(index); return true; }
        });

        LinearLayout num = Ui.col(this);
        num.setLayoutParams(Ui.lp(Ui.dp(this, 28), Ui.WRAP));
        TextView n = Ui.tv(this, String.valueOf(index + 1), 12, on ? Ui.DIM : Ui.LINE, true);
        n.setGravity(Gravity.CENTER);
        n.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        num.addView(n);
        ImageView ic = Ui.icon(this, MainActivity.stepIcon(s), on ? Ui.ACC : Ui.LINE, 15);
        ic.setLayoutParams(Ui.lp(Ui.dp(this, 28), Ui.dp(this, 18)));
        num.addView(ic);
        r.addView(num);
        r.addView(Ui.hgap(this, 8));

        LinearLayout col = Ui.col(this);
        col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        LinearLayout tl = Ui.row(this);
        TextView t = Ui.tv(this, s.title(), 14.5f, on ? Ui.TXT : Ui.DIM, true);
        Ui.ellipsize(t);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        tl.addView(t);
        if (!on) tl.addView(Ui.badge(this, "OFF", Ui.DIM, Ui.SURF));
        else if (s.missing()) tl.addView(Ui.badge(this, "MISSING", Ui.ONACC, Ui.AMBER));
        col.addView(tl);
        TextView d = Ui.tv(this, s.detail(), 11.5f, Ui.DIM, false);
        Ui.ellipsize(d);
        col.addView(d);
        r.addView(col);

        // wrap, not match: a match-width column here would swallow the title
        LinearLayout arrows = Ui.col(this);
        arrows.setLayoutParams(Ui.lp(Ui.WRAP, Ui.WRAP));
        arrows.addView(Ui.iconBtn(this, Ico.UP, index == 0 ? Ui.LINE : Ui.DIM, 14, 6, "Move up",
                new View.OnClickListener() {
            public void onClick(View v) { move(index, -1); }
        }));
        arrows.addView(Ui.iconBtn(this, Ico.DOWN, index == prog.steps.size() - 1 ? Ui.LINE : Ui.DIM, 14, 6,
                "Move down", new View.OnClickListener() {
            public void onClick(View v) { move(index, 1); }
        }));
        r.addView(arrows);

        r.addView(Ui.iconBtn(this, Ico.MORE, Ui.DIM, 16, "Step options", new View.OnClickListener() {
            public void onClick(View v) { stepMenu(index); }
        }));
        rows.add(r);
        return r;
    }

    // ======================================================================
    // actions
    // ======================================================================
    private void addStep() { addStep(-1); }

    /** at < 0 appends; otherwise the new step lands at that index. */
    private void addStep(final int at) {
        final String[] items = { "Whole track", "Section of a track", "Silence", "Bell" };
        Ui.dialog(this).setTitle(at < 0 ? "Add step" : "Insert step").setItems(items,
                new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                if (which == 2 || which == 3) {
                    int where = place(which == 2 ? Step.silence(60000) : Step.bell(), at);
                    save();
                    refresh();
                    edit(where);
                    return;
                }
                final boolean section = which == 1;
                // a section is one slice of one track, but plain tracks can be
                // added by the handful
                TrackPicker.show(EditorActivity.this,
                        section ? "Section of which track?" : "Which tracks?",
                        !section, new TrackPicker.OnPicked() {
                    public void picked(java.util.List<Track> picked) {
                        if (picked.isEmpty()) return;
                        if (section) {
                            Track t = picked.get(0);
                            long end = t.durMs > 45000 ? 45000 : Math.max(10000, t.durMs);
                            long from = end > 20000 ? 15000 : 0;
                            Step s = Step.section(t, from, end);
                            s.times = 4;
                            int where = place(s, at);
                            save();
                            refresh();
                            edit(where);
                            return;
                        }
                        int where = -1;
                        int insertAt = at;
                        for (int i = 0; i < picked.size(); i++) {
                            where = place(Step.play(picked.get(i)), insertAt);
                            if (insertAt >= 0) insertAt = where + 1;
                        }
                        save();
                        refresh();
                        if (picked.size() == 1) edit(where);
                        else Ui.toast(EditorActivity.this, picked.size() + " steps added");
                    }
                });
            }
        }).show();
    }

    private int place(Step s, int at) {
        if (at < 0 || at > prog.steps.size()) {
            prog.steps.add(s);
            return prog.steps.size() - 1;
        }
        prog.steps.add(at, s);
        return at;
    }

    private void edit(final int index) {
        if (index < 0 || index >= prog.steps.size()) return;
        StepSheet.show(this, prog, index, new StepSheet.OnDone() {
            public void changed() { save(); refresh(); }
            public void deleted(int at) { removeStep(at); }
        });
    }

    private void stepMenu(final int index) {
        if (index < 0 || index >= prog.steps.size()) return;
        final Step s = prog.steps.get(index);
        final String[] items = { "Edit", "Play from here", s.enabled ? "Turn off" : "Turn on",
                                 "Insert a step below", "Duplicate", "Move up", "Move down", "Delete" };
        Ui.dialog(this).setTitle(s.title()).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                switch (which) {
                    case 0: edit(index); break;
                    case 1: run(index); break;
                    case 2: s.enabled = !s.enabled; save(); refresh(); break;
                    case 3: addStep(index + 1); break;
                    case 4: prog.steps.add(index + 1, s.copy()); save(); refresh(); break;
                    case 5: move(index, -1); break;
                    case 6: move(index, 1); break;
                    default: removeStep(index);
                }
            }
        }).show();
    }

    private void move(int index, int dir) {
        int to = index + dir;
        if (to < 0 || to >= prog.steps.size()) return;
        Step s = prog.steps.remove(index);
        prog.steps.add(to, s);
        save();
        refresh();
    }

    private void rename() {
        Pickers.text(this, "Rename program", prog.name, "name", new Pickers.OnText() {
            public void picked(String s) { prog.name = s; save(); refresh(); }
        });
    }

    private void menu() {
        final String[] items = { "Rename", "Duplicate", "Export to a file", "Delete program" };
        Ui.dialog(this).setTitle(prog.name).setItems(items, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface d, int which) {
                if (which == 0) {
                    rename();
                } else if (which == 1) {
                    Store.put(EditorActivity.this, prog.copyAs(prog.name + " copy"));
                    Ui.toast(EditorActivity.this, "Duplicated");
                } else if (which == 2) {
                    Backup.exportOne(EditorActivity.this, prog, REQ_EXPORT);
                } else {
                    Ui.dialog(EditorActivity.this).setTitle("Delete " + prog.name + "?")
                            .setNegativeButton("Cancel", null)
                            .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dd, int w) {
                                    if (eng.isPlaying(prog)) bar.stop();
                                    Store.delete(EditorActivity.this, prog);
                                    prog = null;
                                    finish();
                                }
                            }).show();
                }
            }
        }).show();
    }

    private void run(int from) {
        if (prog.enabledCount() == 0) { Ui.toast(this, "Add a step first"); return; }
        save();
        Runner.play(this, prog, from, new Runner.OnStarted() {
            public void started() { refresh(); }
        });
    }

    private void save() {
        if (prog == null) return;
        dirty = true;
        Store.put(this, prog);
        dirty = false;
    }

    @Override
    protected void onActivityResult(int req, int result, android.content.Intent data) {
        super.onActivityResult(req, result, data);
        if (req == REQ_EXPORT && result == RESULT_OK && data != null) {
            Backup.write(this, data.getData());
        }
    }

    // ======================================================================
    // engine callbacks
    // ======================================================================
    public void onEngineState(Engine.St s) {
        if (prog == null) return;
        boolean mine = s.running && prog.id.equals(s.programId);
        for (int i = 0; i < rows.size(); i++) {
            boolean live = mine && s.step == i;
            rows.get(i).setBackground(live
                    ? Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f)
                    : Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD)));
        }
        if (mine && s.step != liveRow) {
            liveRow = s.step;
            if (s.step >= 0 && s.step < rows.size()) scrollToRow(rows.get(s.step));
        } else if (!mine) {
            liveRow = -1;
        }
    }

    public void onEngineFinished(boolean completed) { refresh(); }
}
