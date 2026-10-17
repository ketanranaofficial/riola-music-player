package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public final class StepSheet {

    public interface OnDone {
        void changed();

        void deleted(int i);
    }

    private StepSheet() {
    }

    public static void show(final Activity activity, final Program program, final int i, final OnDone onDone) {
        String str;
        if (i < 0 || i >= program.steps.size()) {
            return;
        }
        final Step stepCopy = program.steps.get(i).copy();
        final LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 4.0f), iDp, 0);
        ScrollView scrollView = new ScrollView(activity);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        final Runnable[] runnableArr = new Runnable[1];
        runnableArr[0] = new Runnable() { // from class: com.riola.player.StepSheet.1
            @Override // java.lang.Runnable
            public void run() {
                StepSheet.fill(activity, linearLayoutCol, stepCopy, runnableArr[0]);
            }
        };
        runnableArr[0].run();
        if (stepCopy.type == 2) {
            str = "Silence";
        } else if (stepCopy.type == 3) {
            str = "Bell";
        } else {
            str = stepCopy.type == 1 ? "Section" : "Whole track";
        }
        Ui.dialog(activity).setTitle("Step " + (i + 1) + "  -  " + str).setView(scrollView).setNeutralButton("Delete", new DialogInterface.OnClickListener() { // from class: com.riola.player.StepSheet.3
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                onDone.deleted(i);
            }
        }).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Save", new DialogInterface.OnClickListener() { // from class: com.riola.player.StepSheet.2
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                program.steps.set(i, stepCopy);
                onDone.changed();
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void fill(final Activity activity, LinearLayout linearLayout, final Step step, final Runnable runnable) {
        String strShortTitle;
        linearLayout.removeAllViews();
        if (step.needsTrack()) {
            Track track = step.track();
            if (track != null) {
                strShortTitle = track.shortTitle();
            } else {
                strShortTitle = step.trackName.length() > 0 ? step.trackName + "  (missing)" : "pick a track";
            }
            linearLayout.addView(Ui.field(activity, "Track", strShortTitle, 14, new View.OnClickListener() { // from class: com.riola.player.StepSheet.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Pickers.track(activity, "Which track?", new Pickers.OnTrack() { // from class: com.riola.player.StepSheet.4.1
                        @Override // com.riola.player.Pickers.OnTrack
                        public void picked(Track track2) {
                            step.bind(track2);
                            if (step.type == 1 && track2.durMs > 0 && step.b > track2.durMs) {
                                step.b = track2.durMs;
                            }
                            runnable.run();
                        }
                    });
                }
            }));
        }
        if (step.type == 1) {
            final Track track2 = step.track();
            long j = track2 == null ? 0L : track2.durMs;
            LinearLayout linearLayoutRow = Ui.row(activity);
            LinearLayout linearLayoutCol = Ui.col(activity);
            linearLayoutCol.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            final long j2 = j;
            linearLayoutCol.addView(Ui.field(activity, "Start (A)", Fmt.ms(step.a), 20, new View.OnClickListener() { // from class: com.riola.player.StepSheet.5
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Pickers.position(activity, "Section starts at", step.a, j2, new Pickers.OnMs() { // from class: com.riola.player.StepSheet.5.1
                        @Override // com.riola.player.Pickers.OnMs
                        public void picked(long j3) {
                            step.a = j3;
                            if (step.b >= 0 && step.b <= step.a) {
                                step.b = step.a + 15000;
                            }
                            runnable.run();
                        }
                    });
                }
            }));
            LinearLayout linearLayoutCol2 = Ui.col(activity);
            linearLayoutCol2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            Ui.margin(activity, linearLayoutCol2, 8.0f, 0.0f, 0.0f, 0.0f);
            final long j3 = j;
            linearLayoutCol2.addView(Ui.field(activity, "End (B)", step.b < 0 ? "end of track" : Fmt.ms(step.b), 20, new View.OnClickListener() { // from class: com.riola.player.StepSheet.6
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Pickers.position(activity, "Section ends at", step.b < 0 ? j3 : step.b, j3, new Pickers.OnMs() { // from class: com.riola.player.StepSheet.6.1
                        @Override // com.riola.player.Pickers.OnMs
                        public void picked(long j4) {
                            Step step2 = step;
                            if (j4 <= step.a) {
                                j4 = step.a + 15000;
                            }
                            step2.b = j4;
                            runnable.run();
                        }
                    });
                }
            }));
            linearLayoutRow.addView(linearLayoutCol);
            linearLayoutRow.addView(linearLayoutCol2);
            linearLayout.addView(linearLayoutRow);
            LinearLayout linearLayoutBtn = Ui.btn(activity, "Pick by ear", 15, 1, new View.OnClickListener() { // from class: com.riola.player.StepSheet.7
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Track track3 = track2;
                    if (track3 == null) {
                        Ui.toast(activity, "Pick a track first");
                    } else {
                        AbDialog.show(activity, track3, step.a, step.b, new AbDialog.OnPick() { // from class: com.riola.player.StepSheet.7.1
                            @Override // com.riola.player.AbDialog.OnPick
                            public void picked(long j4, long j5) {
                                step.a = j4;
                                step.b = j5;
                                runnable.run();
                            }
                        });
                    }
                }
            });
            linearLayoutBtn.setLayoutParams(Ui.lp(-1, -2));
            Ui.margin(activity, linearLayoutBtn, 0.0f, 8.0f, 0.0f, 0.0f);
            linearLayout.addView(linearLayoutBtn);
            if (step.b > 0) {
                View viewTv = Ui.tv(activity, "that slice is " + Fmt.human(Math.max(0L, step.b - step.a)) + " long", 11.5f, Ui.DIM, false);
                Ui.margin(activity, viewTv, 2.0f, 6.0f, 0.0f, 0.0f);
                linearLayout.addView(viewTv);
            }
        }
        if (step.type == 2) {
            linearLayout.addView(Ui.field(activity, "How long", Fmt.human(step.durMs), 20, new View.OnClickListener() { // from class: com.riola.player.StepSheet.8
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Pickers.duration(activity, "Silence for", step.durMs, new Pickers.OnMs() { // from class: com.riola.player.StepSheet.8.1
                        @Override // com.riola.player.Pickers.OnMs
                        public void picked(long j4) {
                            step.durMs = Math.max(1000L, j4);
                            runnable.run();
                        }
                    });
                }
            }));
            linearLayout.addView(Ui.gap(activity, 6.0f));
            linearLayout.addView(Ui.switchRow(activity, "End with a bell", "chime when the rest is over", step.endBell, new Ui.OnToggle() { // from class: com.riola.player.StepSheet.9
                @Override // com.riola.player.Ui.OnToggle
                public void set(boolean z) {
                    step.endBell = z;
                    if (z) {
                        Bell.preview(step.tone, 1.0f);
                    }
                    runnable.run();
                }
            }));
            if (step.endBell) {
                linearLayout.addView(Ui.seg(activity, new String[]{"Low", "Warm", "Bright", "Desk"}, Bell.clamp(step.tone), new Ui.OnPick() { // from class: com.riola.player.StepSheet.10
                    @Override // com.riola.player.Ui.OnPick
                    public void set(int i) {
                        step.tone = i;
                        Bell.preview(i, 1.0f);
                        runnable.run();
                    }
                }));
            }
        } else if (step.type == 3) {
            linearLayout.addView(Ui.tv(activity, "TONE", 11.0f, Ui.DIM, true));
            linearLayout.addView(Ui.gap(activity, 6.0f));
            linearLayout.addView(Ui.seg(activity, new String[]{"Low", "Warm", "Bright", "Desk"}, Bell.clamp(step.tone), new Ui.OnPick() { // from class: com.riola.player.StepSheet.11
                @Override // com.riola.player.Ui.OnPick
                public void set(int i) {
                    step.tone = i;
                    Bell.preview(i, step.volumePct / 100.0f);
                    runnable.run();
                }
            }));
            View viewTv2 = Ui.tv(activity, "A soft chime to mark a change without opening your eyes.", 11.5f, Ui.DIM, false);
            Ui.margin(activity, viewTv2, 2.0f, 6.0f, 0.0f, 0.0f);
            linearLayout.addView(viewTv2);
            LinearLayout linearLayoutBtn2 = Ui.btn(activity, "Hear it", 35, 1, new View.OnClickListener() { // from class: com.riola.player.StepSheet.12
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Bell.preview(step.tone, step.volumePct / 100.0f);
                }
            });
            linearLayoutBtn2.setLayoutParams(Ui.lp(-1, -2));
            Ui.margin(activity, linearLayoutBtn2, 0.0f, 8.0f, 0.0f, 0.0f);
            linearLayout.addView(linearLayoutBtn2);
            LinearLayout linearLayoutRow2 = Ui.row(activity);
            Ui.margin(activity, linearLayoutRow2, 0.0f, 10.0f, 0.0f, 0.0f);
            TextView textViewTv = Ui.tv(activity, "Ring it", 13.5f, Ui.DIM, false);
            textViewTv.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutRow2.addView(textViewTv);
            LinearLayout linearLayoutStepper = Ui.stepper(activity, Math.max(1, step.times), 1, 9, 1, "x", new Ui.OnValue() { // from class: com.riola.player.StepSheet.13
                @Override // com.riola.player.Ui.OnValue
                public void set(int i) {
                    step.times = i;
                }
            });
            linearLayoutStepper.setLayoutParams(Ui.lp(Ui.dp(activity, 150.0f), -2));
            linearLayoutRow2.addView(linearLayoutStepper);
            linearLayout.addView(linearLayoutRow2);
            LinearLayout linearLayoutRow3 = Ui.row(activity);
            Ui.margin(activity, linearLayoutRow3, 0.0f, 8.0f, 0.0f, 0.0f);
            TextView textViewTv2 = Ui.tv(activity, "Gap between rings", 13.5f, Ui.DIM, false);
            textViewTv2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutRow3.addView(textViewTv2);
            LinearLayout linearLayoutStepper2 = Ui.stepper(activity, (int) (step.gapMs / 1000), 0, 120, 1, "s", new Ui.OnValue() { // from class: com.riola.player.StepSheet.14
                @Override // com.riola.player.Ui.OnValue
                public void set(int i) {
                    step.gapMs = ((long) i) * 1000;
                }
            });
            linearLayoutStepper2.setLayoutParams(Ui.lp(Ui.dp(activity, 150.0f), -2));
            linearLayoutRow3.addView(linearLayoutStepper2);
            linearLayout.addView(linearLayoutRow3);
            linearLayout.addView(Ui.divider(activity));
            linearLayout.addView(Ui.sliderRow(activity, "Bell volume", 10, 100, step.volumePct, "%", 100, new Ui.OnSlide() { // from class: com.riola.player.StepSheet.15
                @Override // com.riola.player.Ui.OnSlide
                public void set(int i) {
                    step.volumePct = i;
                }
            }));
        } else {
            linearLayout.addView(Ui.gap(activity, 10.0f));
            linearLayout.addView(Ui.tv(activity, "HOW OFTEN", 11.0f, Ui.DIM, true));
            linearLayout.addView(Ui.gap(activity, 6.0f));
            linearLayout.addView(Ui.seg(activity, new String[]{"A number of times", "For a length of time"}, step.timed() ? 1 : 0, new Ui.OnPick() { // from class: com.riola.player.StepSheet.16
                @Override // com.riola.player.Ui.OnPick
                public void set(int i) {
                    if (i == 0) {
                        step.times = 1;
                    } else {
                        step.times = -1;
                        if (step.durMs <= 0) {
                            step.durMs = 600000L;
                        }
                    }
                    runnable.run();
                }
            }));
            if (step.timed()) {
                linearLayout.addView(Ui.field(activity, "Keep looping for", Fmt.human(step.durMs), 20, new View.OnClickListener() { // from class: com.riola.player.StepSheet.17
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        Pickers.duration(activity, "Loop for", step.durMs, new Pickers.OnMs() { // from class: com.riola.player.StepSheet.17.1
                            @Override // com.riola.player.Pickers.OnMs
                            public void picked(long j4) {
                                step.durMs = Math.max(5000L, j4);
                                runnable.run();
                            }
                        });
                    }
                }));
            } else {
                LinearLayout linearLayoutRow4 = Ui.row(activity);
                Ui.margin(activity, linearLayoutRow4, 0.0f, 8.0f, 0.0f, 0.0f);
                TextView textViewTv3 = Ui.tv(activity, "Play it", 13.5f, Ui.DIM, false);
                textViewTv3.setLayoutParams(Ui.lpw(0, -2, 1.0f));
                linearLayoutRow4.addView(textViewTv3);
                LinearLayout linearLayoutStepper3 = Ui.stepper(activity, Math.max(1, step.times), 1, 99, 1, "x", new Ui.OnValue() { // from class: com.riola.player.StepSheet.18
                    @Override // com.riola.player.Ui.OnValue
                    public void set(int i) {
                        step.times = i;
                    }
                });
                linearLayoutStepper3.setLayoutParams(Ui.lp(Ui.dp(activity, 160.0f), -2));
                linearLayoutRow4.addView(linearLayoutStepper3);
                linearLayout.addView(linearLayoutRow4);
            }
            LinearLayout linearLayoutRow5 = Ui.row(activity);
            Ui.margin(activity, linearLayoutRow5, 0.0f, 10.0f, 0.0f, 0.0f);
            LinearLayout linearLayoutCol3 = Ui.col(activity);
            linearLayoutCol3.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutCol3.addView(Ui.tv(activity, "Gap between repeats", 13.5f, Ui.DIM, false));
            linearLayoutCol3.addView(Ui.tv(activity, "a short rest each time round", 11.0f, Ui.DIM, false));
            linearLayoutRow5.addView(linearLayoutCol3);
            LinearLayout linearLayoutStepper4 = Ui.stepper(activity, (int) (step.gapMs / 1000), 0, 300, 5, "s", new Ui.OnValue() { // from class: com.riola.player.StepSheet.19
                @Override // com.riola.player.Ui.OnValue
                public void set(int i) {
                    step.gapMs = ((long) i) * 1000;
                }
            });
            linearLayoutStepper4.setLayoutParams(Ui.lp(Ui.dp(activity, 150.0f), -2));
            linearLayoutRow5.addView(linearLayoutStepper4);
            linearLayout.addView(linearLayoutRow5);
            linearLayout.addView(Ui.divider(activity));
            linearLayout.addView(Ui.sliderRow(activity, "Speed for this step", 50, 200, step.speedPct, "%", 100, new Ui.OnSlide() { // from class: com.riola.player.StepSheet.20
                @Override // com.riola.player.Ui.OnSlide
                public void set(int i) {
                    step.speedPct = i;
                }
            }));
            linearLayout.addView(Ui.sliderRow(activity, "Volume for this step", 10, 100, step.volumePct, "%", 100, new Ui.OnSlide() { // from class: com.riola.player.StepSheet.21
                @Override // com.riola.player.Ui.OnSlide
                public void set(int i) {
                    step.volumePct = i;
                }
            }));
        }
        linearLayout.addView(Ui.divider(activity));
        linearLayout.addView(Ui.switchRow(activity, "Include this step", "turn it off to skip it for now", step.enabled, new Ui.OnToggle() { // from class: com.riola.player.StepSheet.22
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                step.enabled = z;
            }
        }));
        linearLayout.addView(Ui.gap(activity, 20.0f));
    }
}
