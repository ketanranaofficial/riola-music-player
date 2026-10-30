package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/** The editor for a single step. Everything is tapped, nothing is typed. */
public final class StepSheet {

    public interface OnDone {
        void changed();
        void deleted(int index);
    }

    private StepSheet() { }

    public static void show(final Activity a, final Program prog, final int index, final OnDone cb) {
        if (index < 0 || index >= prog.steps.size()) return;
        final Step step = prog.steps.get(index).copy();

        final LinearLayout content = Ui.col(a);
        int p = Ui.dp(a, 18);
        content.setPadding(p, Ui.dp(a, 4), p, 0);

        ScrollView sv = new ScrollView(a);
        sv.addView(content, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        final Runnable[] render = new Runnable[1];
        render[0] = new Runnable() {
            public void run() { fill(a, content, step, render[0]); }
        };
        render[0].run();

        String kind = step.type == Step.SILENCE ? "Silence"
                : step.type == Step.BELL ? "Bell"
                : (step.type == Step.SECTION ? "Section" : "Whole track");

        Ui.dialog(a).setTitle("Step " + (index + 1) + "  -  " + kind)
                .setView(sv)
                .setNeutralButton("Delete", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.deleted(index); }
                })
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        prog.steps.set(index, step);
                        cb.changed();
                    }
                }).show();
    }

    private static void fill(final Activity a, final LinearLayout box, final Step step, final Runnable again) {
        box.removeAllViews();

        if (step.needsTrack()) {
            Track bound = step.track();
            String label = bound != null ? bound.shortTitle()
                    : (step.trackName.length() > 0 ? step.trackName + "  (missing)" : "pick a track");
            box.addView(Ui.field(a, "Track", label, Ico.NOTE, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.track(a, "Which track?", new Pickers.OnTrack() {
                        public void picked(Track picked) {
                            step.bind(picked);
                            if (step.type == Step.SECTION && picked.durMs > 0 && step.b > picked.durMs) {
                                step.b = picked.durMs;
                            }
                            again.run();
                        }
                    });
                }
            }));
        }

        if (step.type == Step.SECTION) {
            final Track t = step.track();
            final long cap = t == null ? 0 : t.durMs;

            LinearLayout ab = Ui.row(a);
            LinearLayout left = Ui.col(a);
            left.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            left.addView(Ui.field(a, "Start (A)", Fmt.ms(step.a), Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.position(a, "Section starts at", step.a, cap, new Pickers.OnMs() {
                        public void picked(long ms) {
                            step.a = ms;
                            if (step.b >= 0 && step.b <= step.a) step.b = step.a + 15000;
                            again.run();
                        }
                    });
                }
            }));
            LinearLayout right = Ui.col(a);
            right.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            Ui.margin(a, right, 8, 0, 0, 0);
            right.addView(Ui.field(a, "End (B)", step.b < 0 ? "end of track" : Fmt.ms(step.b),
                    Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.position(a, "Section ends at", step.b < 0 ? cap : step.b, cap, new Pickers.OnMs() {
                        public void picked(long ms) {
                            step.b = ms <= step.a ? step.a + 15000 : ms;
                            again.run();
                        }
                    });
                }
            }));
            ab.addView(left);
            ab.addView(right);
            box.addView(ab);

            LinearLayout ear = Ui.btn(a, "Pick by ear", Ico.AB, Ui.SECONDARY, new View.OnClickListener() {
                public void onClick(View v) {
                    if (t == null) { Ui.toast(a, "Pick a track first"); return; }
                    AbDialog.show(a, t, step.a, step.b, new AbDialog.OnPick() {
                        public void picked(long from, long to) {
                            step.a = from;
                            step.b = to;
                            again.run();
                        }
                    });
                }
            });
            ear.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            Ui.margin(a, ear, 0, 8, 0, 0);
            box.addView(ear);

            if (step.b > 0) {
                TextView len = Ui.tv(a, "that slice is " + Fmt.human(Math.max(0, step.b - step.a)) + " long",
                        11.5f, Ui.DIM, false);
                Ui.margin(a, len, 2, 6, 0, 0);
                box.addView(len);
            }
        }

        if (step.type == Step.SILENCE) {
            box.addView(Ui.field(a, "How long", Fmt.human(step.durMs), Ico.CLOCK, new View.OnClickListener() {
                public void onClick(View v) {
                    Pickers.duration(a, "Silence for", step.durMs, new Pickers.OnMs() {
                        public void picked(long ms) { step.durMs = Math.max(1000, ms); again.run(); }
                    });
                }
            }));

            box.addView(Ui.gap(a, 6));
            box.addView(Ui.switchRow(a, "End with a bell", "chime when the rest is over",
                    step.endBell, new Ui.OnToggle() {
                public void set(boolean v) {
                    step.endBell = v;
                    if (v) Bell.preview(step.tone, 1f);
                    again.run();
                }
            }));
            if (step.endBell) {
                box.addView(Ui.seg(a, new String[]{ "Low", "Warm", "Bright", "Desk" }, Bell.clamp(step.tone),
                        new Ui.OnPick() {
                    public void set(int i) {
                        step.tone = i;
                        Bell.preview(i, 1f);
                        again.run();
                    }
                }));
            }

        } else if (step.type == Step.BELL) {
            box.addView(Ui.tv(a, "TONE", 11, Ui.DIM, true));
            box.addView(Ui.gap(a, 6));
            box.addView(Ui.seg(a, new String[]{ "Low", "Warm", "Bright", "Desk" }, Bell.clamp(step.tone),
                    new Ui.OnPick() {
                public void set(int i) {
                    step.tone = i;
                    Bell.preview(i, step.volumePct / 100f);
                    again.run();
                }
            }));
            TextView hint = Ui.tv(a, "A soft chime to mark a change without opening your eyes.",
                    11.5f, Ui.DIM, false);
            Ui.margin(a, hint, 2, 6, 0, 0);
            box.addView(hint);

            LinearLayout hear = Ui.btn(a, "Hear it", Ico.BELL, Ui.SECONDARY, new View.OnClickListener() {
                public void onClick(View v) { Bell.preview(step.tone, step.volumePct / 100f); }
            });
            hear.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            Ui.margin(a, hear, 0, 8, 0, 0);
            box.addView(hear);

            LinearLayout rings = Ui.row(a);
            Ui.margin(a, rings, 0, 10, 0, 0);
            TextView rt = Ui.tv(a, "Ring it", 13.5f, Ui.DIM, false);
            rt.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            rings.addView(rt);
            LinearLayout rs = Ui.stepper(a, Math.max(1, step.times), 1, 9, 1, "x", new Ui.OnValue() {
                public void set(int v) { step.times = v; }
            });
            rs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            rings.addView(rs);
            box.addView(rings);

            LinearLayout bg = Ui.row(a);
            Ui.margin(a, bg, 0, 8, 0, 0);
            TextView bt = Ui.tv(a, "Gap between rings", 13.5f, Ui.DIM, false);
            bt.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            bg.addView(bt);
            LinearLayout bs = Ui.stepper(a, (int) (step.gapMs / 1000L), 0, 120, 1, "s", new Ui.OnValue() {
                public void set(int v) { step.gapMs = v * 1000L; }
            });
            bs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            bg.addView(bs);
            box.addView(bg);

            box.addView(Ui.divider(a));
            box.addView(Ui.sliderRow(a, "Bell volume", 10, 100, step.volumePct, "%", 100, new Ui.OnSlide() {
                public void set(int v) { step.volumePct = v; }
            }));

        } else {
            box.addView(Ui.gap(a, 10));
            box.addView(Ui.tv(a, "HOW OFTEN", 11, Ui.DIM, true));
            box.addView(Ui.gap(a, 6));
            box.addView(Ui.seg(a, new String[]{ "A number of times", "For a length of time" },
                    step.timed() ? 1 : 0, new Ui.OnPick() {
                public void set(int i) {
                    if (i == 0) step.times = 1;
                    else { step.times = -1; if (step.durMs <= 0) step.durMs = 600000; }
                    again.run();
                }
            }));
            if (step.timed()) {
                box.addView(Ui.field(a, "Keep looping for", Fmt.human(step.durMs), Ico.CLOCK,
                        new View.OnClickListener() {
                    public void onClick(View v) {
                        Pickers.duration(a, "Loop for", step.durMs, new Pickers.OnMs() {
                            public void picked(long ms) { step.durMs = Math.max(5000, ms); again.run(); }
                        });
                    }
                }));
            } else {
                LinearLayout r = Ui.row(a);
                Ui.margin(a, r, 0, 8, 0, 0);
                TextView t = Ui.tv(a, "Play it", 13.5f, Ui.DIM, false);
                t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
                r.addView(t);
                LinearLayout st = Ui.stepper(a, Math.max(1, step.times), 1, 99, 1, "x", new Ui.OnValue() {
                    public void set(int v) { step.times = v; }
                });
                st.setLayoutParams(Ui.lp(Ui.dp(a, 160), Ui.WRAP));
                r.addView(st);
                box.addView(r);
            }

            LinearLayout g = Ui.row(a);
            Ui.margin(a, g, 0, 10, 0, 0);
            LinearLayout gl = Ui.col(a);
            gl.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            gl.addView(Ui.tv(a, "Gap between repeats", 13.5f, Ui.DIM, false));
            gl.addView(Ui.tv(a, "a short rest each time round", 11, Ui.DIM, false));
            g.addView(gl);
            LinearLayout gs = Ui.stepper(a, (int) (step.gapMs / 1000L), 0, 300, 5, "s", new Ui.OnValue() {
                public void set(int v) { step.gapMs = v * 1000L; }
            });
            gs.setLayoutParams(Ui.lp(Ui.dp(a, 150), Ui.WRAP));
            g.addView(gs);
            box.addView(g);

            box.addView(Ui.divider(a));
            box.addView(Ui.sliderRow(a, "Speed for this step", 50, 200, step.speedPct, "%", 100,
                    new Ui.OnSlide() {
                public void set(int v) { step.speedPct = v; }
            }));
            box.addView(Ui.sliderRow(a, "Volume for this step", 10, 100, step.volumePct, "%", 100,
                    new Ui.OnSlide() {
                public void set(int v) { step.volumePct = v; }
            }));
        }

        box.addView(Ui.divider(a));
        box.addView(Ui.switchRow(a, "Include this step", "turn it off to skip it for now",
                step.enabled, new Ui.OnToggle() {
            public void set(boolean v) { step.enabled = v; }
        }));
        box.addView(Ui.gap(a, 20));
    }
}
