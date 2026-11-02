package com.riola.player;

import android.app.Activity;
import android.content.res.ColorStateList;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/**
 * A big, glanceable player for when you are not looking at the phone: large
 * targets you can find by feel, and a dim mode for a dark room.
 */
public class NowPlayingActivity extends Activity implements Engine.Listener {

    private Prefs prefs;
    private Engine eng;

    private TextView programName, stepTitle, stepDetail, clock, remain, badge;
    private SeekBar seek;
    private ImageView play, shuffle;
    private LinearLayout root;
    private boolean dragging;
    private boolean dimmed;

    @Override
    protected void onCreate(Bundle saved) {
        prefs = new Prefs(this);
        Ui.theme(prefs);
        setTheme(Ui.themeRes());
        super.onCreate(saved);
        eng = Engine.get(this);
        Store.load(this);
        setContentView(build());
        Ui.applyWindow(this);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        render(eng.st);
    }

    @Override protected void onResume() { super.onResume(); eng.addListener(this); render(eng.st); }
    @Override protected void onPause()  { eng.removeListener(this); super.onPause(); }

    private View build() {
        root = Ui.col(this);
        root.setBackgroundColor(Ui.BG);
        root.setFitsSystemWindows(true);

        shuffle = Ui.iconBtn(this, Ico.SHUFFLE, Ui.DIM, 20, "Shuffle", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); PlayerBar.askShuffle(NowPlayingActivity.this, eng); }
        });
        View[] actions = {
            shuffle,
            Ui.iconBtn(this, Ico.MOON, Ui.DIM, 20, "Dim the screen", new View.OnClickListener() {
                public void onClick(View v) { setDim(!dimmed); }
            })
        };
        Ui.Bar bar = Ui.appBar(this, 0, "Now playing", "", true, actions);
        programName = bar.sub;
        root.addView(bar.view);

        LinearLayout body = Ui.col(this);
        body.setLayoutParams(Ui.lpw(Ui.MATCH, 0, 1f));
        body.setGravity(Gravity.CENTER);
        int p = Ui.dp(this, 26);
        body.setPadding(p, p, p, p);

        badge = Ui.badge(this, "", Ui.ONACC, Ui.ACC);
        LinearLayout badgeRow = Ui.row(this);
        badgeRow.setGravity(Gravity.CENTER);
        badgeRow.addView(badge);
        body.addView(badgeRow);

        stepTitle = Ui.tv(this, "", 24, Ui.TXT, true);
        stepTitle.setGravity(Gravity.CENTER);
        stepTitle.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        stepTitle.setMaxLines(3);
        Ui.margin(this, stepTitle, 0, 18, 0, 0);
        body.addView(stepTitle);

        stepDetail = Ui.tv(this, "", 14, Ui.DIM, false);
        stepDetail.setGravity(Gravity.CENTER);
        stepDetail.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, stepDetail, 0, 8, 0, 0);
        body.addView(stepDetail);

        clock = Ui.mono(this, "0:00", 40, Ui.ACC_TXT);
        clock.setGravity(Gravity.CENTER);
        clock.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, clock, 0, 26, 0, 0);
        body.addView(clock);

        remain = Ui.tv(this, "", 13, Ui.DIM, false);
        remain.setGravity(Gravity.CENTER);
        remain.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(this, remain, 0, 6, 0, 0);
        body.addView(remain);

        seek = new SeekBar(this);
        seek.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int v, boolean fromUser) { }
            public void onStartTrackingTouch(SeekBar s) { dragging = true; }
            public void onStopTrackingTouch(SeekBar s) { dragging = false; eng.seekTo(s.getProgress()); }
        });
        Ui.margin(this, seek, 0, 20, 0, 0);
        body.addView(seek);
        root.addView(body);

        // big transport, spaced so it can be found without looking
        LinearLayout tr = Ui.row(this);
        tr.setGravity(Gravity.CENTER);
        Ui.margin(this, tr, 0, 0, 0, 30);
        tr.addView(Ui.roundBtn(this, Ico.PREV, 26, false, "Previous step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.prev(); }
        }));
        tr.addView(Ui.hgap(this, 16));
        play = Ui.roundBtn(this, Ico.PAUSE, 40, true, "Pause", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.togglePause(); }
        });
        tr.addView(play);
        tr.addView(Ui.hgap(this, 16));
        tr.addView(Ui.roundBtn(this, Ico.NEXT, 26, false, "Next step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.next(); }
        }));
        root.addView(tr);

        LinearLayout stopRow = Ui.row(this);
        stopRow.setGravity(Gravity.CENTER);
        Ui.margin(this, stopRow, 0, 0, 0, 24);
        LinearLayout stop = Ui.btn(this, "Stop the program", Ico.STOP, Ui.SECONDARY, new View.OnClickListener() {
            public void onClick(View v) {
                Ui.buzz(v);
                eng.stop();
                try { stopService(new android.content.Intent(NowPlayingActivity.this, PlayerService.class)); }
                catch (Exception e) { /* already gone */ }
                finish();
            }
        });
        stopRow.addView(stop);
        root.addView(stopRow);
        return root;
    }

    /** Almost black, for a dark room. Any tap brings it back. */
    private void setDim(boolean on) {
        dimmed = on;
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        lp.screenBrightness = on ? 0.02f : WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE;
        getWindow().setAttributes(lp);
        if (on) Ui.toast(this, "Screen dimmed - tap anywhere to bring it back");
    }

    @Override
    public boolean dispatchTouchEvent(android.view.MotionEvent ev) {
        if (dimmed && ev.getAction() == android.view.MotionEvent.ACTION_DOWN) {
            setDim(false);
            return true;            // swallow the tap that woke the screen
        }
        return super.dispatchTouchEvent(ev);
    }

    private void render(Engine.St s) {
        if (!s.running) {
            finish();
            return;
        }
        programName.setText(s.programName);
        stepTitle.setText(s.stepTitle);
        stepDetail.setText(s.resting && s.stepDetail.length() == 0 ? "resting" : s.stepDetail);

        if (s.countIn > 0) badge.setText("READY");
        else if (s.preview) badge.setText("PREVIEW");
        else badge.setText("STEP " + (s.step + 1) + " OF " + s.steps);

        int max = Math.max(1, s.durMs);
        if (!dragging) {
            seek.setMax(max);
            seek.setProgress(Math.min(s.posMs, max));
        }
        clock.setText(Fmt.ms(s.posMs));

        StringBuilder sb = new StringBuilder();
        if (s.durMs > 0) sb.append("of ").append(Fmt.ms(s.durMs));
        if (s.stepRemainMs >= 0) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append(Fmt.human(s.stepRemainMs)).append(" left in this step");
        } else if (s.repTotal > 1) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append("pass ").append(Math.min(s.repDone + 1, s.repTotal)).append(" of ").append(s.repTotal);
        }
        if (s.progRemainMs > 0) {
            if (sb.length() > 0) sb.append("   .   ");
            sb.append("~").append(Fmt.human(s.progRemainMs)).append(" to go");
        }
        remain.setText(sb.toString());

        Ui.setIcon(play, s.paused ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
        play.setContentDescription(s.paused ? "Resume" : "Pause");
        if (shuffle != null) Ui.setIcon(shuffle, Ico.SHUFFLE, s.shuffled ? Ui.ACC_TXT : Ui.DIM);
    }

    // ---- engine callbacks ------------------------------------------------
    public void onState(Engine.St s) { render(s); }
    public void onLog(String line) { }
    public void onFinished(boolean completed) { finish(); }
}
