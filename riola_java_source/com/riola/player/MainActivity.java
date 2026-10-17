package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class MainActivity extends Activity implements PlayerBar.Host {
    private static final int REQ_EXPORT = 201;
    private static final int REQ_IMPORT = 202;
    private static final int REQ_NOTIF = 103;
    private static boolean reopenSettings;
    private PlayerBar bar;
    private LinearLayout emptyBox;
    private Engine eng;
    private LinearLayout liveCard;
    private LinearLayout liveSteps;
    private TextView liveTitle;
    private Prefs prefs;
    private LinearLayout programsBox;
    private TextView tracksLine;
    private boolean wasRunning;
    private final List<View> liveRows = new ArrayList();
    private String liveProgramId = "";

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Prefs prefs = new Prefs(this);
        this.prefs = prefs;
        Ui.theme(prefs);
        setTheme(Ui.themeRes(this.prefs.dark()));
        super.onCreate(bundle);
        Store.load(this);
        this.eng = Engine.get(this);
        Bell.warm();
        setContentView(build());
        Ui.applyWindow(this);
        if (reopenSettings) {
            reopenSettings = false;
            settings();
        }
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        this.bar.attach();
        if (this.prefs.keepScreenOn()) {
            getWindow().addFlags(128);
        } else {
            getWindow().clearFlags(128);
        }
        refresh();
    }

    @Override // android.app.Activity
    protected void onPause() {
        this.bar.detach();
        super.onPause();
    }

    private View build() {
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setBackgroundColor(Ui.BG);
        linearLayoutCol.setFitsSystemWindows(true);
        linearLayoutCol.addView(Ui.appBar(this, 14, "Riola", "programmable music player", false, new View[]{Ui.iconBtn(this, 11, Ui.DIM, 20, "Help", new View.OnClickListener() { // from class: com.riola.player.MainActivity.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.help();
            }
        }), Ui.iconBtn(this, 12, Ui.DIM, 20, "Settings", new View.OnClickListener() { // from class: com.riola.player.MainActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.settings();
            }
        })}).view);
        LinearLayout linearLayoutCol2 = Ui.col(this);
        LinearLayout linearLayoutCard = Ui.card(this);
        linearLayoutCard.setPadding(Ui.dp(this, 14.0f), Ui.dp(this, 4.0f), Ui.dp(this, 10.0f), Ui.dp(this, 4.0f));
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setBackground(Ui.ripple(Ui.rr(this, 0, 12.0f)));
        linearLayoutRow.setPadding(0, Ui.dp(this, 12.0f), 0, Ui.dp(this, 12.0f));
        linearLayoutRow.addView(Ui.icon(this, 14, Ui.ACC_TXT, 18));
        linearLayoutRow.addView(Ui.hgap(this, 12.0f));
        LinearLayout linearLayoutCol3 = Ui.col(this);
        linearLayoutCol3.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutCol3.addView(Ui.tv(this, "Tracks", 15.0f, Ui.TXT, true));
        TextView textViewTv = Ui.tv(this, "", 12.0f, Ui.DIM, false);
        this.tracksLine = textViewTv;
        linearLayoutCol3.addView(textViewTv);
        linearLayoutRow.addView(linearLayoutCol3);
        linearLayoutRow.addView(Ui.icon(this, 27, Ui.DIM, 14));
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.MainActivity.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.startActivity(new Intent(MainActivity.this, (Class<?>) LibraryActivity.class));
            }
        });
        linearLayoutCard.addView(linearLayoutRow);
        linearLayoutCol2.addView(linearLayoutCard);
        this.liveCard = Ui.card(this);
        LinearLayout linearLayoutRow2 = Ui.row(this);
        LinearLayout linearLayoutHeading = Ui.heading(this, 22, "Now playing");
        linearLayoutHeading.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow2.addView(linearLayoutHeading);
        TextView textViewBadge = Ui.badge(this, "", Ui.ONACC, Ui.ACC2);
        this.liveTitle = textViewBadge;
        linearLayoutRow2.addView(textViewBadge);
        linearLayoutRow2.setBackground(Ui.ripple(Ui.rr(this, 0, 10.0f)));
        linearLayoutRow2.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.MainActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (MainActivity.this.eng.isRunning()) {
                    MainActivity.this.startActivity(new Intent(MainActivity.this, (Class<?>) NowPlayingActivity.class));
                }
            }
        });
        this.liveCard.addView(linearLayoutRow2);
        LinearLayout linearLayoutCol4 = Ui.col(this);
        this.liveSteps = linearLayoutCol4;
        this.liveCard.addView(linearLayoutCol4);
        this.liveCard.setVisibility(8);
        linearLayoutCol2.addView(this.liveCard);
        LinearLayout linearLayoutCard2 = Ui.card(this);
        linearLayoutCard2.addView(Ui.heading(this, 32, "Programs"));
        LinearLayout linearLayoutCol5 = Ui.col(this);
        this.programsBox = linearLayoutCol5;
        linearLayoutCard2.addView(linearLayoutCol5);
        LinearLayout linearLayoutCol6 = Ui.col(this);
        this.emptyBox = linearLayoutCol6;
        linearLayoutCard2.addView(linearLayoutCol6);
        LinearLayout linearLayoutBtn = Ui.btn(this, "New program", 6, 0, new View.OnClickListener() { // from class: com.riola.player.MainActivity.5
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.newProgram();
            }
        });
        linearLayoutBtn.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, linearLayoutBtn, 0.0f, 10.0f, 0.0f, 0.0f);
        linearLayoutCard2.addView(linearLayoutBtn);
        LinearLayout linearLayoutRow3 = Ui.row(this);
        Ui.margin(this, linearLayoutRow3, 0.0f, 4.0f, 0.0f, 0.0f);
        LinearLayout linearLayoutBtn2 = Ui.btn(this, "Export all", 9, 3, new View.OnClickListener() { // from class: com.riola.player.MainActivity.6
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Backup.exportAll(MainActivity.this, MainActivity.REQ_EXPORT);
            }
        });
        linearLayoutBtn2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow3.addView(linearLayoutBtn2);
        LinearLayout linearLayoutBtn3 = Ui.btn(this, "Import", 10, 3, new View.OnClickListener() { // from class: com.riola.player.MainActivity.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Backup.pickToImport(MainActivity.this, MainActivity.REQ_IMPORT);
            }
        });
        linearLayoutBtn3.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow3.addView(linearLayoutBtn3);
        linearLayoutCard2.addView(linearLayoutRow3);
        linearLayoutCol2.addView(linearLayoutCard2);
        linearLayoutCol2.addView(Ui.gap(this, 6.0f));
        linearLayoutCol.addView(Ui.scroller(this, linearLayoutCol2));
        PlayerBar playerBar = new PlayerBar(this, this);
        this.bar = playerBar;
        linearLayoutCol.addView(playerBar.view);
        return linearLayoutCol;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void refresh() {
        int size = Store.LIB.size();
        this.tracksLine.setText(size == 0 ? "none yet - tap to add music" : size + (size == 1 ? " track" : " tracks") + " - tap to manage");
        this.programsBox.removeAllViews();
        this.emptyBox.removeAllViews();
        if (Store.PROGRAMS.isEmpty()) {
            this.emptyBox.addView(Ui.emptyState(this, 32, "No programs yet", "A program is a list of steps: play a track, loop a section, rest, repeat."));
            if (!Store.LIB.isEmpty()) {
                LinearLayout linearLayoutBtn = Ui.btn(this, "Create an example program", 29, 1, new View.OnClickListener() { // from class: com.riola.player.MainActivity.8
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        Program programSample = Store.sample();
                        Store.put(MainActivity.this, programSample);
                        MainActivity.this.refresh();
                        MainActivity.this.open(programSample);
                    }
                });
                linearLayoutBtn.setLayoutParams(Ui.lp(-1, -2));
                this.emptyBox.addView(linearLayoutBtn);
            }
        } else {
            for (int i = 0; i < Store.PROGRAMS.size(); i++) {
                this.programsBox.addView(programRow(Store.PROGRAMS.get(i)));
            }
        }
        this.wasRunning = this.eng.isRunning();
        buildLive();
        this.bar.render(this.eng.st);
    }

    private View programRow(final Program program) {
        boolean zIsPlaying = this.eng.isPlaying(program);
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setBackground(Ui.ripple(zIsPlaying ? Ui.rrs(this, Ui.SURF2, Ui.ACC_TXT, 14.0f, 1.4f) : Ui.rr(this, Ui.SURF2, 14.0f)));
        linearLayoutRow.setPadding(Ui.dp(this, 10.0f), Ui.dp(this, 10.0f), Ui.dp(this, 4.0f), Ui.dp(this, 10.0f));
        Ui.margin(this, linearLayoutRow, 0.0f, 0.0f, 0.0f, 8.0f);
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.MainActivity.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.open(program);
            }
        });
        linearLayoutRow.setOnLongClickListener(new View.OnLongClickListener() { // from class: com.riola.player.MainActivity.10
            @Override // android.view.View.OnLongClickListener
            public boolean onLongClick(View view) {
                MainActivity.this.menu(program);
                return true;
            }
        });
        linearLayoutRow.addView(Ui.roundBtn(this, zIsPlaying ? 3 : 1, 20, true, zIsPlaying ? "Stop" : "Play " + program.name, new View.OnClickListener() { // from class: com.riola.player.MainActivity.11
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                if (MainActivity.this.eng.isPlaying(program)) {
                    MainActivity.this.bar.stop();
                } else {
                    MainActivity.this.run(program, 0);
                }
                MainActivity.this.refresh();
            }
        }));
        linearLayoutRow.addView(Ui.hgap(this, 12.0f));
        LinearLayout linearLayoutCol = Ui.col(this);
        linearLayoutCol.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        TextView textViewTv = Ui.tv(this, program.name, 15.5f, Ui.TXT, true);
        Ui.ellipsize(textViewTv);
        linearLayoutCol.addView(textViewTv);
        TextView textViewTv2 = Ui.tv(this, program.summary(), 12.0f, Ui.DIM, false);
        Ui.ellipsize(textViewTv2);
        linearLayoutCol.addView(textViewTv2);
        LinearLayout linearLayoutRow2 = Ui.row(this);
        if (zIsPlaying) {
            linearLayoutRow2.addView(Ui.badge(this, "PLAYING", Ui.ONACC, Ui.GREEN));
            linearLayoutRow2.addView(Ui.hgap(this, 6.0f));
        }
        if (program.hasMissing()) {
            linearLayoutRow2.addView(Ui.badge(this, "MISSING TRACK", Ui.ONACC, Ui.AMBER));
            linearLayoutRow2.addView(Ui.hgap(this, 6.0f));
        }
        if (program.lastRun > 0) {
            linearLayoutRow2.addView(Ui.tv(this, "last run " + Fmt.ago(program.lastRun), 11.0f, Ui.DIM, false));
        }
        if (linearLayoutRow2.getChildCount() > 0) {
            Ui.margin(this, linearLayoutRow2, 0.0f, 4.0f, 0.0f, 0.0f);
            linearLayoutCol.addView(linearLayoutRow2);
        }
        linearLayoutRow.addView(linearLayoutCol);
        linearLayoutRow.addView(Ui.iconBtn(this, 25, Ui.DIM, 16, "More options", new View.OnClickListener() { // from class: com.riola.player.MainActivity.12
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.menu(program);
            }
        }));
        return linearLayoutRow;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void menu(final Program program) {
        Ui.dialog(this).setTitle(program.name).setItems(new String[]{"Play", "Edit", "Rename", "Duplicate", "Export to a file", "Delete"}, new DialogInterface.OnClickListener() { // from class: com.riola.player.MainActivity.13
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                switch (i) {
                    case 0:
                        MainActivity.this.run(program, 0);
                        MainActivity.this.refresh();
                        break;
                    case 1:
                        MainActivity.this.open(program);
                        break;
                    case 2:
                        Pickers.text(MainActivity.this, "Rename program", program.name, "name", new Pickers.OnText() { // from class: com.riola.player.MainActivity.13.1
                            @Override // com.riola.player.Pickers.OnText
                            public void picked(String str) {
                                program.name = str;
                                Store.put(MainActivity.this, program);
                                MainActivity.this.refresh();
                            }
                        });
                        break;
                    case 3:
                        Store.put(MainActivity.this, program.copyAs(program.name + " copy"));
                        MainActivity.this.refresh();
                        Ui.toast(MainActivity.this, "Duplicated");
                        break;
                    case 4:
                        Backup.exportOne(MainActivity.this, program, MainActivity.REQ_EXPORT);
                        break;
                    default:
                        Ui.dialog(MainActivity.this).setTitle("Delete " + program.name + "?").setMessage("The program is removed. Your audio files are untouched.").setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Delete", new DialogInterface.OnClickListener() { // from class: com.riola.player.MainActivity.13.2
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface2, int i2) {
                                if (MainActivity.this.eng.isPlaying(program)) {
                                    MainActivity.this.bar.stop();
                                }
                                Store.delete(MainActivity.this, program);
                                MainActivity.this.refresh();
                            }
                        }).show();
                        break;
                }
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void newProgram() {
        Pickers.text(this, "New program", "Program " + (Store.PROGRAMS.size() + 1), "name", new Pickers.OnText() { // from class: com.riola.player.MainActivity.14
            @Override // com.riola.player.Pickers.OnText
            public void picked(String str) {
                Program programBlank = Program.blank(str);
                Store.put(MainActivity.this, programBlank);
                MainActivity.this.refresh();
                MainActivity.this.open(programBlank);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void open(Program program) {
        startActivity(new Intent(this, (Class<?>) EditorActivity.class).putExtra("id", program.id));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void run(Program program, int i) {
        if (program.enabledCount() == 0) {
            Ui.toast(this, "Add a step first");
            open(program);
        } else {
            Runner.play(this, program, i, new Runner.OnStarted() { // from class: com.riola.player.MainActivity.15
                @Override // com.riola.player.Runner.OnStarted
                public void started() {
                    MainActivity.this.liveProgramId = "";
                    MainActivity.this.buildLive();
                    MainActivity.this.refresh();
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Type inference incomplete: some casts might be missing */
    public void buildLive() {
        Engine.St st = this.eng.st;
        Program program = Store.program(st.programId);
        if (!st.running || program == null) {
            this.liveCard.setVisibility(8);
            this.liveRows.clear();
            this.liveSteps.removeAllViews();
            this.liveProgramId = "";
            return;
        }
        this.liveCard.setVisibility(0);
        this.liveTitle.setText(program.name.toUpperCase());
        if (program.id.equals(this.liveProgramId) && this.liveRows.size() == program.steps.size()) {
            highlight(st.step);
            return;
        }
        this.liveProgramId = program.id;
        this.liveSteps.removeAllViews();
        this.liveRows.clear();
        for (final int i = 0; i < program.steps.size(); i++) {
            Step step = program.steps.get(i);
            LinearLayout linearLayoutRow = Ui.row(this);
            linearLayoutRow.setPadding(Ui.dp(this, 8.0f), Ui.dp(this, 7.0f), Ui.dp(this, 8.0f), Ui.dp(this, 7.0f));
            Ui.margin(this, linearLayoutRow, 0.0f, 0.0f, 0.0f, 2.0f);
            linearLayoutRow.addView(Ui.icon(this, stepIcon(step), step.enabled ? Ui.DIM : Ui.LINE, 15));
            linearLayoutRow.addView(Ui.hgap(this, 10.0f));
            LinearLayout linearLayoutCol = Ui.col(this);
            linearLayoutCol.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            TextView textViewTv = Ui.tv(this, step.title(), 13.0f, step.enabled ? Ui.TXT : Ui.DIM, false);
            Ui.ellipsize(textViewTv);
            linearLayoutCol.addView(textViewTv);
            TextView textViewTv2 = Ui.tv(this, step.detail(), 11.0f, Ui.DIM, false);
            Ui.ellipsize(textViewTv2);
            linearLayoutCol.addView(textViewTv2);
            linearLayoutRow.addView(linearLayoutCol);
            linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.MainActivity.16
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.buzz(view);
                    MainActivity.this.eng.jumpTo(i);
                }
            });
            this.liveRows.add(linearLayoutRow);
            this.liveSteps.addView(linearLayoutRow);
        }
        highlight(st.step);
    }

    static int stepIcon(Step step) {
        if (step.type == 2) {
            return 20;
        }
        if (step.type == 3) {
            return 35;
        }
        return step.type == 1 ? 15 : 14;
    }

    private void highlight(int i) {
        for (int i2 = 0; i2 < this.liveRows.size(); i2++) {
            View view = this.liveRows.get(i2);
            if (i2 == i) {
                view.setBackground(Ui.rrs(this, Ui.ACC_SOFT, Ui.ACC_TXT, 10.0f, 1.0f));
            } else {
                view.setBackground(Ui.ripple(Ui.rr(this, 0, 10.0f)));
            }
        }
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineState(Engine.St st) {
        if (st.running != this.wasRunning) {
            this.wasRunning = st.running;
            refresh();
        } else {
            buildLive();
        }
    }

    @Override // com.riola.player.PlayerBar.Host
    public void onEngineFinished(boolean z) {
        int i = this.eng.st.skipped;
        refresh();
        if (i > 0) {
            Ui.toast(this, (z ? "Finished, but " : "Stopped. ") + i + (i == 1 ? " step was skipped - its track is missing" : " steps were skipped - their tracks are missing"));
        } else {
            Ui.toast(this, z ? "Program finished" : "Stopped");
        }
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) throws Throwable {
        super.onActivityResult(i, i2, intent);
        if (i2 != -1 || intent == null || intent.getData() == null) {
            return;
        }
        if (i == REQ_EXPORT) {
            Backup.write(this, intent.getData());
        } else if (i == REQ_IMPORT) {
            Backup.read(this, intent.getData());
            refresh();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void help() {
        LinearLayout linearLayoutCol = Ui.col(this);
        int iDp = Ui.dp(this, 20.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(this, 4.0f), iDp, 0);
        int i = 0;
        while (i < HelpText.SECTIONS.length) {
            String[] strArr = HelpText.SECTIONS[i];
            TextView textViewTv = Ui.tv(this, strArr[0], 14.0f, Ui.ACC_TXT, true);
            Ui.margin(this, textViewTv, 0.0f, i == 0 ? 0.0f : 18.0f, 0.0f, 6.0f);
            linearLayoutCol.addView(textViewTv);
            TextView textViewTv2 = Ui.tv(this, strArr[1], 13.5f, Ui.TXT, false);
            textViewTv2.setLineSpacing(Ui.dp(this, 3.0f), 1.0f);
            textViewTv2.setLayoutParams(Ui.lp(-1, -2));
            linearLayoutCol.addView(textViewTv2);
            i++;
        }
        linearLayoutCol.addView(Ui.gap(this, 12.0f));
        ScrollView scrollView = new ScrollView(this);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        Ui.dialog(this).setTitle("How Riola works").setView(scrollView).setPositiveButton("Close", (DialogInterface.OnClickListener) null).show();
    }

    private String colourName(int i) {
        for (int i2 = 0; i2 < Ui.ACCENTS.length; i2++) {
            if (Ui.ACCENTS[i2] == i) {
                return Ui.ACCENT_NAMES[i2];
            }
        }
        return String.format("Custom  #%06X", Integer.valueOf(i & 16777215));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void settings() {
        LinearLayout linearLayoutCol = Ui.col(this);
        int iDp = Ui.dp(this, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(this, 6.0f), iDp, 0);
        linearLayoutCol.addView(Ui.switchRow(this, "Dark theme", null, this.prefs.dark(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.17
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.dark(z);
                AlertDialog alertDialog = alertDialogArr[0];
                if (alertDialog != null) {
                    alertDialog.dismiss();
                }
                boolean unused = MainActivity.reopenSettings = true;
                MainActivity.this.recreate();
            }
        }));
        final Themes.OnChosen onChosen = new Themes.OnChosen() { // from class: com.riola.player.MainActivity.18
            @Override // com.riola.player.Themes.OnChosen
            public void chosen() {
                AlertDialog alertDialog = alertDialogArr[0];
                if (alertDialog != null) {
                    alertDialog.dismiss();
                }
                boolean unused = MainActivity.reopenSettings = true;
                MainActivity.this.recreate();
            }
        };
        linearLayoutCol.addView(Ui.field(this, "Colour", colourName(this.prefs.accent()), 22, new View.OnClickListener() { // from class: com.riola.player.MainActivity.19
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                AlertDialog alertDialog = alertDialogArr[0];
                if (alertDialog != null) {
                    alertDialog.dismiss();
                }
                MainActivity mainActivity = MainActivity.this;
                Themes.colour(mainActivity, mainActivity.prefs, onChosen);
            }
        }));
        linearLayoutCol.addView(Ui.field(this, "Look", Ui.STYLE_NAMES[Math.max(0, Math.min(this.prefs.style(), Ui.STYLE_NAMES.length - 1))], 23, new View.OnClickListener() { // from class: com.riola.player.MainActivity.20
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                AlertDialog alertDialog = alertDialogArr[0];
                if (alertDialog != null) {
                    alertDialog.dismiss();
                }
                MainActivity mainActivity = MainActivity.this;
                Themes.look(mainActivity, mainActivity.prefs, onChosen);
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(this, "Keep the screen on", "while the app is open", this.prefs.keepScreenOn(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.21
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.keepScreenOn(z);
                if (z) {
                    MainActivity.this.getWindow().addFlags(128);
                } else {
                    MainActivity.this.getWindow().clearFlags(128);
                }
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(this, "Keep the CPU awake", "so long rests stay exact", this.prefs.wakeLock(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.22
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.wakeLock(z);
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(this, "Pause when headphones unplug", null, this.prefs.pauseUnplug(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.23
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.pauseUnplug(z);
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(this, "Pause for calls and other apps", null, this.prefs.pauseOnFocus(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.24
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.pauseOnFocus(z);
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(this, "Vibrate on button taps", null, this.prefs.haptics(), new Ui.OnToggle() { // from class: com.riola.player.MainActivity.25
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                MainActivity.this.prefs.haptics(z);
            }
        }));
        linearLayoutCol.addView(Ui.divider(this));
        linearLayoutCol.addView(Ui.sliderRow(this, "Master volume", 0, 100, this.prefs.volume(), "%", 100, new Ui.OnSlide() { // from class: com.riola.player.MainActivity.26
            @Override // com.riola.player.Ui.OnSlide
            public void set(int i) {
                MainActivity.this.prefs.volume(i);
                MainActivity.this.eng.setMasterVolume(i);
            }
        }));
        linearLayoutCol.addView(Ui.sliderRow(this, "Playback speed", 50, 200, this.prefs.speedPct(), "%", 100, new Ui.OnSlide() { // from class: com.riola.player.MainActivity.27
            @Override // com.riola.player.Ui.OnSlide
            public void set(int i) {
                MainActivity.this.prefs.speedPct(i);
                MainActivity.this.eng.setMasterSpeed(i);
            }
        }));
        linearLayoutCol.addView(Ui.sliderRow(this, "Fade at loop edges", 0, 1000, this.prefs.fadeMs(), " ms", 150, new Ui.OnSlide() { // from class: com.riola.player.MainActivity.28
            @Override // com.riola.player.Ui.OnSlide
            public void set(int i) {
                MainActivity.this.prefs.fadeMs(i);
            }
        }));
        linearLayoutCol.addView(Ui.sliderRow(this, "Count in before starting", 0, 15, this.prefs.countIn(), " s", 0, new Ui.OnSlide() { // from class: com.riola.player.MainActivity.29
            @Override // com.riola.player.Ui.OnSlide
            public void set(int i) {
                MainActivity.this.prefs.countIn(i);
            }
        }));
        linearLayoutCol.addView(Ui.sliderRow(this, "Stop everything after", 0, 180, this.prefs.autoStopMin(), " min", 0, new Ui.OnSlide() { // from class: com.riola.player.MainActivity.30
            @Override // com.riola.player.Ui.OnSlide
            public void set(int i) {
                MainActivity.this.prefs.autoStopMin(i);
            }
        }));
        linearLayoutCol.addView(Ui.tv(this, "Set the stop timer to 0 to switch it off.", 11.0f, Ui.DIM, false));
        linearLayoutCol.addView(Ui.divider(this));
        linearLayoutCol.addView(Ui.btn(this, "Reset settings to defaults", 0, 2, new View.OnClickListener() { // from class: com.riola.player.MainActivity.31
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.prefs.resetAll();
                Ui.toast(MainActivity.this, "Settings reset");
                AlertDialog alertDialog = alertDialogArr[0];
                if (alertDialog != null) {
                    alertDialog.dismiss();
                }
                boolean unused = MainActivity.reopenSettings = true;
                MainActivity.this.recreate();
            }
        }));
        linearLayoutCol.addView(Ui.gap(this, 6.0f));
        linearLayoutCol.addView(Ui.tv(this, "Riola  -  no ads, no network, no accounts.", 11.0f, Ui.DIM, false));
        linearLayoutCol.addView(Ui.gap(this, 20.0f));
        ScrollView scrollView = new ScrollView(this);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        AlertDialog alertDialogCreate = Ui.dialog(this).setTitle("Settings").setView(scrollView).setPositiveButton("Done", (DialogInterface.OnClickListener) null).create();
        final AlertDialog[] alertDialogArr = {alertDialogCreate};
        alertDialogCreate.show();
    }
}
