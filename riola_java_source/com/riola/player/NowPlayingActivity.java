package com.riola.player;

import android.app.Activity;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public class NowPlayingActivity extends Activity implements Engine.Listener {
    private TextView badge;
    private TextView clock;
    private boolean dimmed;
    private boolean dragging;
    private Engine eng;
    private ImageView play;
    private Prefs prefs;
    private TextView programName;
    private TextView remain;
    private LinearLayout root;
    private SeekBar seek;
    private ImageView shuffle;
    private TextView stepDetail;
    private TextView stepTitle;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        Prefs prefs = new Prefs(this);
        this.prefs = prefs;
        Ui.theme(prefs);
        setTheme(Ui.themeRes(this.prefs.dark()));
        super.onCreate(bundle);
        this.eng = Engine.get(this);
        Store.load(this);
        setContentView(build());
        Ui.applyWindow(this);
        getWindow().addFlags(128);
        render(this.eng.st);
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        this.eng.addListener(this);
        render(this.eng.st);
    }

    @Override // android.app.Activity
    protected void onPause() {
        this.eng.removeListener(this);
        super.onPause();
    }

    private View build() {
        LinearLayout linearLayoutCol = Ui.col(this);
        this.root = linearLayoutCol;
        linearLayoutCol.setBackgroundColor(Ui.BG);
        this.root.setFitsSystemWindows(true);
        ImageView imageViewIconBtn = Ui.iconBtn(this, 36, Ui.DIM, 20, "Shuffle", new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                NowPlayingActivity nowPlayingActivity = NowPlayingActivity.this;
                PlayerBar.askShuffle(nowPlayingActivity, nowPlayingActivity.eng);
            }
        });
        this.shuffle = imageViewIconBtn;
        Ui.Bar barAppBar = Ui.appBar(this, 0, "Now playing", "", true, new View[]{imageViewIconBtn, Ui.iconBtn(this, 33, Ui.DIM, 20, "Dim the screen", new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                NowPlayingActivity nowPlayingActivity = NowPlayingActivity.this;
                nowPlayingActivity.setDim(!nowPlayingActivity.dimmed);
            }
        })});
        this.programName = barAppBar.sub;
        this.root.addView(barAppBar.view);
        LinearLayout linearLayoutCol2 = Ui.col(this);
        linearLayoutCol2.setLayoutParams(Ui.lpw(-1, 0, 1.0f));
        linearLayoutCol2.setGravity(17);
        int iDp = Ui.dp(this, 26.0f);
        linearLayoutCol2.setPadding(iDp, iDp, iDp, iDp);
        this.badge = Ui.badge(this, "", Ui.ONACC, Ui.ACC);
        LinearLayout linearLayoutRow = Ui.row(this);
        linearLayoutRow.setGravity(17);
        linearLayoutRow.addView(this.badge);
        linearLayoutCol2.addView(linearLayoutRow);
        TextView textViewTv = Ui.tv(this, "", 24.0f, Ui.TXT, true);
        this.stepTitle = textViewTv;
        textViewTv.setGravity(17);
        this.stepTitle.setLayoutParams(Ui.lp(-1, -2));
        this.stepTitle.setMaxLines(3);
        Ui.margin(this, this.stepTitle, 0.0f, 18.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(this.stepTitle);
        TextView textViewTv2 = Ui.tv(this, "", 14.0f, Ui.DIM, false);
        this.stepDetail = textViewTv2;
        textViewTv2.setGravity(17);
        this.stepDetail.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, this.stepDetail, 0.0f, 8.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(this.stepDetail);
        TextView textViewMono = Ui.mono(this, "0:00", 40.0f, Ui.ACC_TXT);
        this.clock = textViewMono;
        textViewMono.setGravity(17);
        this.clock.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, this.clock, 0.0f, 26.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(this.clock);
        TextView textViewTv3 = Ui.tv(this, "", 13.0f, Ui.DIM, false);
        this.remain = textViewTv3;
        textViewTv3.setGravity(17);
        this.remain.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(this, this.remain, 0.0f, 6.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(this.remain);
        SeekBar seekBar = new SeekBar(this);
        this.seek = seekBar;
        seekBar.setLayoutParams(Ui.lp(-1, -2));
        this.seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        this.seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        this.seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        this.seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.riola.player.NowPlayingActivity.3
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i, boolean z) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
                NowPlayingActivity.this.dragging = true;
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
                NowPlayingActivity.this.dragging = false;
                NowPlayingActivity.this.eng.seekTo(seekBar2.getProgress());
            }
        });
        Ui.margin(this, this.seek, 0.0f, 20.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(this.seek);
        this.root.addView(linearLayoutCol2);
        LinearLayout linearLayoutRow2 = Ui.row(this);
        linearLayoutRow2.setGravity(17);
        Ui.margin(this, linearLayoutRow2, 0.0f, 0.0f, 0.0f, 30.0f);
        linearLayoutRow2.addView(Ui.roundBtn(this, 5, 26, false, "Previous step", new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                NowPlayingActivity.this.eng.prev();
            }
        }));
        linearLayoutRow2.addView(Ui.hgap(this, 16.0f));
        ImageView imageViewRoundBtn = Ui.roundBtn(this, 2, 40, true, "Pause", new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.5
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                NowPlayingActivity.this.eng.togglePause();
            }
        });
        this.play = imageViewRoundBtn;
        linearLayoutRow2.addView(imageViewRoundBtn);
        linearLayoutRow2.addView(Ui.hgap(this, 16.0f));
        linearLayoutRow2.addView(Ui.roundBtn(this, 4, 26, false, "Next step", new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.6
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                NowPlayingActivity.this.eng.next();
            }
        }));
        this.root.addView(linearLayoutRow2);
        LinearLayout linearLayoutRow3 = Ui.row(this);
        linearLayoutRow3.setGravity(17);
        Ui.margin(this, linearLayoutRow3, 0.0f, 0.0f, 0.0f, 24.0f);
        linearLayoutRow3.addView(Ui.btn(this, "Stop the program", 3, 1, new View.OnClickListener() { // from class: com.riola.player.NowPlayingActivity.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                NowPlayingActivity.this.eng.stop();
                try {
                    NowPlayingActivity.this.stopService(new Intent(NowPlayingActivity.this, (Class<?>) PlayerService.class));
                } catch (Exception e) {
                }
                NowPlayingActivity.this.finish();
            }
        }));
        this.root.addView(linearLayoutRow3);
        return this.root;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setDim(boolean z) {
        this.dimmed = z;
        WindowManager.LayoutParams attributes = getWindow().getAttributes();
        attributes.screenBrightness = z ? 0.02f : -1.0f;
        getWindow().setAttributes(attributes);
        if (z) {
            Ui.toast(this, "Screen dimmed - tap anywhere to bring it back");
        }
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchTouchEvent(MotionEvent motionEvent) {
        if (this.dimmed && motionEvent.getAction() == 0) {
            setDim(false);
            return true;
        }
        return super.dispatchTouchEvent(motionEvent);
    }

    private void render(Engine.St st) {
        if (!st.running) {
            finish();
            return;
        }
        this.programName.setText(st.programName);
        this.stepTitle.setText(st.stepTitle);
        this.stepDetail.setText((st.resting && st.stepDetail.length() == 0) ? "resting" : st.stepDetail);
        if (st.countIn > 0) {
            this.badge.setText("READY");
        } else if (st.preview) {
            this.badge.setText("PREVIEW");
        } else {
            this.badge.setText("STEP " + (st.step + 1) + " OF " + st.steps);
        }
        int iMax = Math.max(1, st.durMs);
        if (!this.dragging) {
            this.seek.setMax(iMax);
            this.seek.setProgress(Math.min(st.posMs, iMax));
        }
        this.clock.setText(Fmt.ms(st.posMs));
        StringBuilder sb = new StringBuilder();
        if (st.durMs > 0) {
            sb.append("of ").append(Fmt.ms(st.durMs));
        }
        if (st.stepRemainMs >= 0) {
            if (sb.length() > 0) {
                sb.append("   .   ");
            }
            sb.append(Fmt.human(st.stepRemainMs)).append(" left in this step");
        } else if (st.repTotal > 1) {
            if (sb.length() > 0) {
                sb.append("   .   ");
            }
            sb.append("pass ").append(Math.min(st.repDone + 1, st.repTotal)).append(" of ").append(st.repTotal);
        }
        if (st.progRemainMs > 0) {
            if (sb.length() > 0) {
                sb.append("   .   ");
            }
            sb.append("~").append(Fmt.human(st.progRemainMs)).append(" to go");
        }
        this.remain.setText(sb.toString());
        Ui.setIcon(this.play, st.paused ? 1 : 2, Ui.ONACC);
        this.play.setContentDescription(st.paused ? "Resume" : "Pause");
        ImageView imageView = this.shuffle;
        if (imageView != null) {
            Ui.setIcon(imageView, 36, st.shuffled ? Ui.ACC_TXT : Ui.DIM);
        }
    }

    @Override // com.riola.player.Engine.Listener
    public void onState(Engine.St st) {
        render(st);
    }

    @Override // com.riola.player.Engine.Listener
    public void onLog(String str) {
    }

    @Override // com.riola.player.Engine.Listener
    public void onFinished(boolean z) {
        finish();
    }
}
