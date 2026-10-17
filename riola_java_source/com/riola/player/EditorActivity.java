package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class EditorActivity extends Activity implements PlayerBar.Host {
    private static final int REQ_EXPORT = 301;
    private static final int UNDO_SECONDS = 20;
    private PlayerBar bar;
    private boolean dirty;
    private Engine eng;
    private LinearLayout loopBox;
    private Prefs prefs;
    private Program prog;
    private ScrollView scroller;
    private LinearLayout stepsBox;
    private TextView subView;
    private TextView titleView;
    private TextView totalBadge;
    private TextView undoLabel;
    private int undoLeft;
    private Step undoStep;
    private int liveRow = -1;
    private final List<View> rows = new ArrayList();
    private int undoAt = -1;
    private final Handler ui = new Handler(Looper.getMainLooper());
    private final Runnable undoTick = new Runnable() { // from class: com.riola.player.EditorActivity.1
        @Override // java.lang.Runnable
        public void run() {
            if (EditorActivity.this.undoStep == null) {
                return;
            }
            EditorActivity.access$110(EditorActivity.this);
            if (EditorActivity.this.undoLeft <= 0) {
                EditorActivity.this.undoStep = null;
                EditorActivity.this.undoAt = -1;
                EditorActivity.this.refresh();
            } else {
                if (EditorActivity.this.undoLabel != null) {
                    EditorActivity.this.undoLabel.setText("Step removed  .  " + EditorActivity.this.undoLeft + "s");
                }
                EditorActivity.this.ui.postDelayed(this, 1000L);
            }
        }
    };

    static /* synthetic */ int access$110(EditorActivity editorActivity) {
        int i = editorActivity.undoLeft;
        editorActivity.undoLeft = i - 1;
        return i;
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Prefs prefs = new Prefs(this);
        this.prefs = prefs;
        Ui.theme(prefs);
        setTheme(Ui.themeRes(this.prefs.dark()));
        super.onCreate(bundle);
        Store.load(this);
        this.eng = Engine.get(this);
        Program program = Store.program(getIntent().getStringExtra("id"));
        this.prog = program;
        if (program == null) {
            finish();
            return;
        }
        setContentView(build());
        Ui.applyWindow(this);
        refresh();
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        if (this.prog == null) {
            return;
        }
        this.bar.attach();
        if (this.prefs.keepScreenOn()) {
            getWindow().addFlags(128);
        }
        refresh();
    }

    @Override // android.app.Activity
    protected void onPause() {
        this.ui.removeCallbacks(this.undoTick);
        this.undoStep = null;
        this.undoAt = -1;
        this.undoLabel = null;
        if (this.prog != null) {
            this.bar.detach();
            if (this.dirty) {
                Store.put(this, this.prog);
                this.dirty = false;
            }
        }
        super.onPause();
    }

    private View build() {
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setBackgroundColor(Ui.BG);
        linearLayoutCol.setFitsSystemWindows(true);
        Ui.Bar barAppBar = Ui.appBar(this, 0, this.prog.name, this.prog.summary(), true, new View[]{Ui.iconBtn(this, 1, Ui.ACC_TXT, 20, "Run this program", new View.OnClickListener() { // from class: com.riola.player.EditorActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.run(0);
            }
        }), Ui.iconBtn(this, 25, Ui.DIM, 20, "More options", new View.OnClickListener() { // from class: com.riola.player.EditorActivity.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.menu();
            }
        })});
        this.titleView = barAppBar.title;
        this.subView = barAppBar.sub;
        barAppBar.titles.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.EditorActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.rename();
            }
        });
        linearLayoutCol.addView(barAppBar.view);
        LinearLayout linearLayoutCol2 = Ui.col(this);
        LinearLayout linearLayoutCard = Ui.card(this);
        linearLayoutCard.addView(Ui.heading(this, 13, "Repeat program"));
        LinearLayout linearLayoutCol3 = Ui.col(this);
        this.loopBox = linearLayoutCol3;
        linearLayoutCard.addView(linearLayoutCol3);
        linearLayoutCol2.addView(linearLayoutCard);
        LinearLayout linearLayoutCard2 = Ui.card(this);
        LinearLayout linearLayoutRow = Ui.row(this);
        LinearLayout linearLayoutHeading = Ui.heading(this, 21, "Steps");
        linearLayoutHeading.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(linearLayoutHeading);
        TextView textViewBadge = Ui.badge(this, "", Ui.DIM, Ui.SURF2);
        this.totalBadge = textViewBadge;
        linearLayoutRow.addView(textViewBadge);
        linearLayoutCard2.addView(linearLayoutRow);
        LinearLayout linearLayoutCol4 = Ui.col(this);
        this.stepsBox = linearLayoutCol4;
        linearLayoutCard2.addView(linearLayoutCol4);
        LinearLayout linearLayoutBtn = Ui.btn(this, "Add step", 6, 0, new View.OnClickListener() { // from class: com.riola.player.EditorActivity.5
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.addStep();
            }
        });
        linearLayoutBtn.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, linearLayoutBtn, 0.0f, 10.0f, 0.0f, 0.0f);
        linearLayoutCard2.addView(linearLayoutBtn);
        linearLayoutCol2.addView(linearLayoutCard2);
        linearLayoutCol2.addView(Ui.gap(this, 6.0f));
        ScrollView scrollViewScroller = Ui.scroller(this, linearLayoutCol2);
        this.scroller = scrollViewScroller;
        linearLayoutCol.addView(scrollViewScroller);
        PlayerBar playerBar = new PlayerBar(this, this);
        this.bar = playerBar;
        linearLayoutCol.addView(playerBar.view);
        return linearLayoutCol;
    }

    private void scrollToRow(final View view) {
        ScrollView scrollView = this.scroller;
        if (scrollView == null || view == null) {
            return;
        }
        scrollView.post(new Runnable() { // from class: com.riola.player.EditorActivity.6
            @Override // java.lang.Runnable
            public void run() {
                View view2 = view;
                int top = 0;
                while (view2 != null && (view2.getParent() instanceof View) && view2.getParent() != EditorActivity.this.scroller) {
                    top += view2.getTop();
                    view2 = (View) view2.getParent();
                }
                if (view2 != null) {
                    top += view2.getTop();
                }
                EditorActivity.this.scroller.smoothScrollTo(0, Math.max(0, top - Ui.dp(EditorActivity.this, 150.0f)));
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void refresh() {
        Program program = this.prog;
        if (program == null) {
            return;
        }
        this.titleView.setText(program.name);
        this.subView.setText(this.prog.summary());
        this.totalBadge.setText(this.prog.steps.isEmpty() ? "empty" : Fmt.rough(this.prog.estMs()));
        this.loopBox.removeAllViews();
        int i = this.prog.loops < 0 ? 2 : this.prog.loops <= 1 ? 0 : 1;
        this.loopBox.addView(Ui.seg(this, new String[]{"Once", "A few times", "Forever"}, i, new Ui.OnPick() { // from class: com.riola.player.EditorActivity.7
            @Override // com.riola.player.Ui.OnPick
            public void set(int i2) {
                Program program2 = EditorActivity.this.prog;
                int iMax = 1;
                if (i2 != 0) {
                    iMax = i2 == 1 ? Math.max(2, EditorActivity.this.prog.loops) : -1;
                }
                program2.loops = iMax;
                EditorActivity.this.save();
                EditorActivity.this.refresh();
            }
        }));
        if (i == 1) {
            LinearLayout linearLayoutRow = Ui.row(this);
            Ui.margin(this, linearLayoutRow, 0.0f, 8.0f, 0.0f, 0.0f);
            TextView textViewTv = Ui.tv(this, "Run the whole list", 13.5f, Ui.DIM, false);
            textViewTv.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutRow.addView(textViewTv);
            LinearLayout linearLayoutStepper = Ui.stepper(this, Math.max(2, this.prog.loops), 2, 99, 1, "x", new Ui.OnValue() { // from class: com.riola.player.EditorActivity.8
                @Override // com.riola.player.Ui.OnValue
                public void set(int i2) {
                    EditorActivity.this.prog.loops = i2;
                    EditorActivity.this.save();
                    EditorActivity.this.subView.setText(EditorActivity.this.prog.summary());
                    EditorActivity.this.totalBadge.setText(Fmt.rough(EditorActivity.this.prog.estMs()));
                }
            });
            linearLayoutStepper.setLayoutParams(Ui.lp(Ui.dp(this, 160.0f), -2));
            linearLayoutRow.addView(linearLayoutStepper);
            this.loopBox.addView(linearLayoutRow);
        }
        this.stepsBox.removeAllViews();
        this.rows.clear();
        if (this.undoStep != null) {
            this.stepsBox.addView(undoBar());
        }
        if (this.prog.steps.isEmpty()) {
            this.stepsBox.addView(Ui.emptyState(this, 21, "No steps yet", "Add a whole track, a section of a track, or a stretch of silence."));
        } else {
            for (int i2 = 0; i2 < this.prog.steps.size(); i2++) {
                this.stepsBox.addView(stepRow(i2));
            }
        }
        this.bar.render(this.eng.st);
    }

    private View undoBar() {
        View.OnClickListener onClickListener = new View.OnClickListener() { // from class: com.riola.player.EditorActivity.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                EditorActivity.this.restoreStep();
            }
        };
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setBackground(Ui.ripple(Ui.rrs(this, Ui.SURF2, Ui.AMBER, 12.0f, 1.0f)));
        linearLayoutRow.setPadding(Ui.dp(this, 12.0f), Ui.dp(this, 12.0f), Ui.dp(this, 8.0f), Ui.dp(this, 12.0f));
        Ui.margin(this, linearLayoutRow, 0.0f, 0.0f, 0.0f, 8.0f);
        linearLayoutRow.setClickable(true);
        linearLayoutRow.setContentDescription("Undo removing the step");
        linearLayoutRow.setOnClickListener(onClickListener);
        TextView textViewTv = Ui.tv(this, "Step removed  .  " + Math.max(1, this.undoLeft) + "s", 13.0f, Ui.TXT, false);
        this.undoLabel = textViewTv;
        textViewTv.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(this.undoLabel);
        linearLayoutRow.addView(Ui.btn(this, "Undo", 34, 1, onClickListener));
        return linearLayoutRow;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void restoreStep() {
        Program program;
        this.ui.removeCallbacks(this.undoTick);
        Step step = this.undoStep;
        int i = this.undoAt;
        this.undoStep = null;
        this.undoAt = -1;
        if (step == null || (program = this.prog) == null) {
            refresh();
            Ui.toast(this, "Too late to undo");
        } else {
            program.steps.add(Math.max(0, Math.min(i, this.prog.steps.size())), step);
            save();
            refresh();
            Ui.toast(this, "Step restored");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void removeStep(int i) {
        this.undoStep = this.prog.steps.remove(i);
        this.undoAt = i;
        this.undoLeft = 20;
        this.ui.removeCallbacks(this.undoTick);
        this.ui.postDelayed(this.undoTick, 1000L);
        save();
        refresh();
    }

    private View stepRow(final int i) {
        Step step = this.prog.steps.get(i);
        boolean z = step.enabled;
        boolean z2 = this.eng.isPlaying(this.prog) && this.eng.st.step == i;
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setBackground(z2 ? Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f) : Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD)));
        linearLayoutRow.setPadding(Ui.dp(this, 8.0f), Ui.dp(this, 9.0f), Ui.dp(this, 2.0f), Ui.dp(this, 9.0f));
        Ui.margin(this, linearLayoutRow, 0.0f, 0.0f, 0.0f, 8.0f);
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.EditorActivity.10
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (EditorActivity.this.eng.isPlaying(EditorActivity.this.prog)) {
                    Ui.buzz(view);
                    EditorActivity.this.eng.jumpTo(i);
                } else {
                    EditorActivity.this.edit(i);
                }
            }
        });
        linearLayoutRow.setOnLongClickListener(new View.OnLongClickListener() { // from class: com.riola.player.EditorActivity.11
            @Override // android.view.View.OnLongClickListener
            public boolean onLongClick(View view) {
                EditorActivity.this.stepMenu(i);
                return true;
            }
        });
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setLayoutParams(Ui.lp(Ui.dp(this, 28.0f), -2));
        TextView textViewTv = Ui.tv(this, String.valueOf(i + 1), 12.0f, z ? Ui.DIM : Ui.LINE, true);
        textViewTv.setGravity(17);
        textViewTv.setLayoutParams(Ui.lp(-1, -2));
        linearLayoutCol.addView(textViewTv);
        ImageView imageViewIcon = Ui.icon(this, MainActivity.stepIcon(step), z ? Ui.ACC : Ui.LINE, 15);
        imageViewIcon.setLayoutParams(Ui.lp(Ui.dp(this, 28.0f), Ui.dp(this, 18.0f)));
        linearLayoutCol.addView(imageViewIcon);
        linearLayoutRow.addView(linearLayoutCol);
        linearLayoutRow.addView(Ui.hgap(this, 8.0f));
        LinearLayout linearLayoutCol2 = Ui.col(this);
        linearLayoutCol2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        LinearLayout linearLayoutRow2 = Ui.row(this);
        TextView textViewTv2 = Ui.tv(this, step.title(), 14.5f, z ? Ui.TXT : Ui.DIM, true);
        Ui.ellipsize(textViewTv2);
        textViewTv2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow2.addView(textViewTv2);
        if (!z) {
            linearLayoutRow2.addView(Ui.badge(this, "OFF", Ui.DIM, Ui.SURF));
        } else if (step.missing()) {
            linearLayoutRow2.addView(Ui.badge(this, "MISSING", Ui.ONACC, Ui.AMBER));
        }
        linearLayoutCol2.addView(linearLayoutRow2);
        TextView textViewTv3 = Ui.tv(this, step.detail(), 11.5f, Ui.DIM, false);
        Ui.ellipsize(textViewTv3);
        linearLayoutCol2.addView(textViewTv3);
        linearLayoutRow.addView(linearLayoutCol2);
        LinearLayout linearLayoutCol3 = Ui.col(this);
        linearLayoutCol3.setLayoutParams(Ui.lp(-2, -2));
        linearLayoutCol3.addView(Ui.iconBtn(this, 18, i == 0 ? Ui.LINE : Ui.DIM, 14, 6, "Move up", new View.OnClickListener() { // from class: com.riola.player.EditorActivity.12
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.move(i, -1);
            }
        }));
        linearLayoutCol3.addView(Ui.iconBtn(this, 19, i == this.prog.steps.size() - 1 ? Ui.LINE : Ui.DIM, 14, 6, "Move down", new View.OnClickListener() { // from class: com.riola.player.EditorActivity.13
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.move(i, 1);
            }
        }));
        linearLayoutRow.addView(linearLayoutCol3);
        linearLayoutRow.addView(Ui.iconBtn(this, 25, Ui.DIM, 16, "Step options", new View.OnClickListener() { // from class: com.riola.player.EditorActivity.14
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                EditorActivity.this.stepMenu(i);
            }
        }));
        this.rows.add(linearLayoutRow);
        return linearLayoutRow;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void addStep() {
        addStep(-1);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void addStep(final int i) {
        Ui.dialog(this).setTitle(i < 0 ? "Add step" : "Insert step").setItems(new String[]{"Whole track", "Section of a track", "Silence", "Bell"}, new DialogInterface.OnClickListener() { // from class: com.riola.player.EditorActivity.15
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                if (i2 == 2 || i2 == 3) {
                    int iPlace = EditorActivity.this.place(i2 == 2 ? Step.silence(60000L) : Step.bell(), i);
                    EditorActivity.this.save();
                    EditorActivity.this.refresh();
                    EditorActivity.this.edit(iPlace);
                    return;
                }
                final boolean z = i2 == 1;
                TrackPicker.show(EditorActivity.this, z ? "Section of which track?" : "Which tracks?", !z, new TrackPicker.OnPicked() { // from class: com.riola.player.EditorActivity.15.1
                    @Override // com.riola.player.TrackPicker.OnPicked
                    public void picked(List<Track> list) {
                        if (list.isEmpty()) {
                            return;
                        }
                        if (z) {
                            Track track = list.get(0);
                            long jMax = track.durMs <= 45000 ? Math.max(10000L, track.durMs) : 45000L;
                            Step stepSection = Step.section(track, jMax > 20000 ? 15000L : 0L, jMax);
                            stepSection.times = 4;
                            int iPlace2 = EditorActivity.this.place(stepSection, i);
                            EditorActivity.this.save();
                            EditorActivity.this.refresh();
                            EditorActivity.this.edit(iPlace2);
                            return;
                        }
                        int i3 = i;
                        int iPlace3 = -1;
                        for (int i4 = 0; i4 < list.size(); i4++) {
                            iPlace3 = EditorActivity.this.place(Step.play(list.get(i4)), i3);
                            if (i3 >= 0) {
                                i3 = iPlace3 + 1;
                            }
                        }
                        EditorActivity.this.save();
                        EditorActivity.this.refresh();
                        if (list.size() == 1) {
                            EditorActivity.this.edit(iPlace3);
                        } else {
                            Ui.toast(EditorActivity.this, list.size() + " steps added");
                        }
                    }
                });
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public int place(Step step, int i) {
        if (i < 0 || i > this.prog.steps.size()) {
            this.prog.steps.add(step);
            return this.prog.steps.size() - 1;
        }
        this.prog.steps.add(i, step);
        return i;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void edit(int i) {
        if (i < 0 || i >= this.prog.steps.size()) {
            return;
        }
        StepSheet.show(this, this.prog, i, new StepSheet.OnDone() { // from class: com.riola.player.EditorActivity.16
            @Override // com.riola.player.StepSheet.OnDone
            public void changed() {
                EditorActivity.this.save();
                EditorActivity.this.refresh();
            }

            @Override // com.riola.player.StepSheet.OnDone
            public void deleted(int i2) {
                EditorActivity.this.removeStep(i2);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void stepMenu(final int i) {
        if (i < 0 || i >= this.prog.steps.size()) {
            return;
        }
        final Step step = this.prog.steps.get(i);
        String[] strArr = new String[8];
        strArr[0] = "Edit";
        strArr[1] = "Play from here";
        strArr[2] = step.enabled ? "Turn off" : "Turn on";
        strArr[3] = "Insert a step below";
        strArr[4] = "Duplicate";
        strArr[5] = "Move up";
        strArr[6] = "Move down";
        strArr[7] = "Delete";
        Ui.dialog(this).setTitle(step.title()).setItems(strArr, new DialogInterface.OnClickListener() { // from class: com.riola.player.EditorActivity.17
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                switch (i2) {
                    case 0:
                        EditorActivity.this.edit(i);
                        break;
                    case 1:
                        EditorActivity.this.run(i);
                        break;
                    case 2:
                        Step step2 = step;
                        step2.enabled = true ^ step2.enabled;
                        EditorActivity.this.save();
                        EditorActivity.this.refresh();
                        break;
                    case 3:
                        EditorActivity.this.addStep(i + 1);
                        break;
                    case 4:
                        EditorActivity.this.prog.steps.add(i + 1, step.copy());
                        EditorActivity.this.save();
                        EditorActivity.this.refresh();
                        break;
                    case 5:
                        EditorActivity.this.move(i, -1);
                        break;
                    case 6:
                        EditorActivity.this.move(i, 1);
                        break;
                    default:
                        EditorActivity.this.removeStep(i);
                        break;
                }
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void move(int i, int i2) {
        int i3 = i2 + i;
        if (i3 < 0 || i3 >= this.prog.steps.size()) {
            return;
        }
        this.prog.steps.add(i3, this.prog.steps.remove(i));
        save();
        refresh();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void rename() {
        Pickers.text(this, "Rename program", this.prog.name, "name", new Pickers.OnText() { // from class: com.riola.player.EditorActivity.18
            @Override // com.riola.player.Pickers.OnText
            public void picked(String str) {
                EditorActivity.this.prog.name = str;
                EditorActivity.this.save();
                EditorActivity.this.refresh();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void menu() {
        Ui.dialog(this).setTitle(this.prog.name).setItems(new String[]{"Rename", "Duplicate", "Export to a file", "Delete program"}, new DialogInterface.OnClickListener() { // from class: com.riola.player.EditorActivity.19
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    EditorActivity.this.rename();
                    return;
                }
                if (i == 1) {
                    EditorActivity editorActivity = EditorActivity.this;
                    Store.put(editorActivity, editorActivity.prog.copyAs(EditorActivity.this.prog.name + " copy"));
                    Ui.toast(EditorActivity.this, "Duplicated");
                } else if (i == 2) {
                    EditorActivity editorActivity2 = EditorActivity.this;
                    Backup.exportOne(editorActivity2, editorActivity2.prog, EditorActivity.REQ_EXPORT);
                } else {
                    Ui.dialog(EditorActivity.this).setTitle("Delete " + EditorActivity.this.prog.name + "?").setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Delete", new DialogInterface.OnClickListener() { // from class: com.riola.player.EditorActivity.19.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface2, int i2) {
                            if (EditorActivity.this.eng.isPlaying(EditorActivity.this.prog)) {
                                EditorActivity.this.bar.stop();
                            }
                            Store.delete(EditorActivity.this, EditorActivity.this.prog);
                            EditorActivity.this.prog = null;
                            EditorActivity.this.finish();
                        }
                    }).show();
                }
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void run(int i) {
        if (this.prog.enabledCount() == 0) {
            Ui.toast(this, "Add a step first");
        } else {
            save();
            Runner.play(this, this.prog, i, new Runner.OnStarted() { // from class: com.riola.player.EditorActivity.20
                @Override // com.riola.player.Runner.OnStarted
                public void started() {
                    EditorActivity.this.refresh();
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void save() {
        Program program = this.prog;
        if (program == null) {
            return;
        }
        this.dirty = true;
        Store.put(this, program);
        this.dirty = false;
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i == REQ_EXPORT && i2 == -1 && intent != null) {
            Backup.write(this, intent.getData());
        }
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineState(Engine.St st) {
        Drawable drawableRipple;
        if (this.prog == null) {
            return;
        }
        boolean z = st.running && this.prog.id.equals(st.programId);
        int i = 0;
        while (i < this.rows.size()) {
            boolean z2 = z && st.step == i;
            View view = this.rows.get(i);
            if (z2) {
                drawableRipple = Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_CARD, 1.4f);
            } else {
                drawableRipple = Ui.ripple(Ui.rr(this, Ui.SURF2, Ui.RAD_CARD));
            }
            view.setBackground(drawableRipple);
            i++;
        }
        if (z && st.step != this.liveRow) {
            this.liveRow = st.step;
            if (st.step < 0 || st.step >= this.rows.size()) {
                return;
            }
            scrollToRow(this.rows.get(st.step));
            return;
        }
        if (!z) {
            this.liveRow = -1;
        }
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineFinished(boolean z) {
        refresh();
    }
}
