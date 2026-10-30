package com.riola.player;

import android.app.Activity;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.view.Gravity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/** The transport strip pinned to the bottom of a screen while a program runs. */
public class PlayerBar implements Engine.Listener {

    public interface Host {
        void onEngineState(Engine.St s);
        void onEngineFinished(boolean completed);
    }

    private final Activity act;
    private final Engine eng;
    private final Host host;

    public final LinearLayout view;
    private final TextView title, detail, badge, time, remain;
    private final SeekBar seek;
    private final ImageView play;
    private ImageView shuffle;
    private boolean dragging;

    public PlayerBar(final Activity a, Host h) {
        act = a;
        host = h;
        eng = Engine.get(a);

        view = Ui.col(a);
        view.setBackgroundColor(Ui.SURF);
        view.setVisibility(View.GONE);
        // consume its own touches: nothing behind the bar should ever react to
        // a drag that started on the scrubber
        view.setClickable(true);
        view.setFocusable(true);

        View top = new View(a);
        top.setLayoutParams(Ui.lp(Ui.MATCH, Math.max(1, Ui.dp(a, 0.7f))));
        top.setBackgroundColor(Ui.LINE);
        view.addView(top);

        LinearLayout inner = Ui.col(a);
        inner.setPadding(Ui.dp(a, 14), Ui.dp(a, 10), Ui.dp(a, 14), Ui.dp(a, 12));
        view.addView(inner);

        LinearLayout line1 = Ui.row(a);
        // the strip is a handle for the full screen player
        line1.setBackground(Ui.ripple(Ui.rr(a, 0x00000000, 10)));
        line1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                try { a.startActivity(new Intent(a, NowPlayingActivity.class)); }
                catch (Exception e) { /* nothing to open */ }
            }
        });
        title = Ui.tv(a, "", 14.5f, Ui.TXT, true);
        Ui.ellipsize(title);
        title.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        line1.addView(title);
        badge = Ui.badge(a, "", Ui.ONACC, Ui.ACC);
        line1.addView(badge);
        inner.addView(line1);

        detail = Ui.tv(a, "", 12, Ui.DIM, false);
        Ui.ellipsize(detail);
        inner.addView(detail);
        line1.addView(Ui.icon(a, Ico.UP, Ui.DIM, 14));

        seek = new SeekBar(a);
        seek.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        seek.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seek.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int p, boolean fromUser) { }
            public void onStartTrackingTouch(SeekBar s) { dragging = true; }
            public void onStopTrackingTouch(SeekBar s) { dragging = false; eng.seekTo(s.getProgress()); }
        });
        Ui.margin(a, seek, 0, 2, 0, 0);
        inner.addView(seek);

        LinearLayout line3 = Ui.row(a);
        time = Ui.mono(a, "0:00 / 0:00", 11, Ui.DIM);
        line3.addView(time);
        line3.addView(Ui.spring(a));
        remain = Ui.tv(a, "", 11, Ui.DIM, false);
        line3.addView(remain);
        inner.addView(line3);

        LinearLayout tr = Ui.row(a);
        tr.setGravity(Gravity.CENTER);
        Ui.margin(a, tr, 0, 6, 0, 0);
        shuffle = Ui.roundBtn(a, Ico.SHUFFLE, 18, false, "Shuffle", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); askShuffle(a, eng); }
        });
        tr.addView(shuffle);
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.PREV, 20, false, "Previous step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.prev(); }
        }));
        tr.addView(Ui.hgap(a, 10));
        play = Ui.roundBtn(a, Ico.PAUSE, 22, true, "Pause", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.togglePause(); }
        });
        tr.addView(play);
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.STOP, 20, false, "Stop", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); stop(); }
        }));
        tr.addView(Ui.hgap(a, 10));
        tr.addView(Ui.roundBtn(a, Ico.NEXT, 20, false, "Next step", new View.OnClickListener() {
            public void onClick(View v) { Ui.buzz(v); eng.next(); }
        }));
        inner.addView(tr);
    }

    public void attach() {
        eng.addListener(this);
        render(eng.st);
    }

    public void detach() { eng.removeListener(this); }

    public void stop() {
        eng.stop();
        try { act.stopService(new Intent(act, PlayerService.class)); } catch (Exception e) { /* gone */ }
        render(eng.st);
    }

    /** Start the foreground service that keeps playback alive off screen. */
    public static void startService(Activity a) {
        Intent i = new Intent(a, PlayerService.class).setAction(PlayerService.ACT_ATTACH);
        try { a.startForegroundService(i); } catch (Exception e) {
            try { a.startService(i); } catch (Exception ignored) { }
        }
    }

    public void render(Engine.St s) {
        if (!s.running) {
            view.setVisibility(View.GONE);
            return;
        }
        view.setVisibility(View.VISIBLE);
        title.setText(s.stepTitle);
        detail.setText(s.resting && s.stepDetail.length() == 0 ? "resting" : s.stepDetail);

        if (s.countIn > 0) badge.setText("READY");
        else if (s.preview) badge.setText("PREVIEW");
        else badge.setText("STEP " + (s.step + 1) + "/" + s.steps);

        int max = Math.max(1, s.durMs);
        if (!dragging) {
            seek.setMax(max);
            seek.setProgress(Math.min(s.posMs, max));
        }
        time.setText(Fmt.ms(s.posMs) + " / " + Fmt.ms(s.durMs));

        String right = "";
        if (s.stepRemainMs >= 0) right = Fmt.human(s.stepRemainMs) + " left";
        else if (s.repTotal > 1) right = "pass " + Math.min(s.repDone + 1, s.repTotal) + " of " + s.repTotal;
        if (s.loopTotal < 0) right = append(right, "loop " + (s.loopDone + 1));
        else if (s.loopTotal > 1) right = append(right, "loop " + (s.loopDone + 1) + "/" + s.loopTotal);
        if (s.progRemainMs > 0) right = append(right, "~" + Fmt.human(s.progRemainMs) + " to go");
        remain.setText(right);

        Ui.setIcon(play, s.paused ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
        play.setContentDescription(s.paused ? "Resume" : "Pause");
        if (shuffle != null) {
            Ui.setIcon(shuffle, Ico.SHUFFLE, s.shuffled ? Ui.ACC_TXT : Ui.TXT);
            shuffle.setContentDescription(s.shuffled ? "Shuffling, tap to stop" : "Shuffle");
        }
    }

    private String append(String a, String b) { return a.length() == 0 ? b : (a + "  .  " + b); }

    /**
     * Turning shuffle on is worth a question - someone poking the unfamiliar
     * icon should not silently lose the order they built. Turning it off is
     * not, because that is the safe direction.
     */
    static void askShuffle(final android.app.Activity a, final Engine eng) {
        if (eng.isShuffled()) {
            eng.setShuffle(false);
            Ui.toast(a, "Back to the order you built");
            return;
        }
        Ui.dialog(a).setTitle("Shuffle the steps?")
                .setMessage("The steps will play in a random order instead of the order you built, "
                        + "and a new order is drawn each time the program repeats.\n\n"
                        + "Your program is not changed, and you can switch back at any time.")
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Shuffle", new android.content.DialogInterface.OnClickListener() {
                    public void onClick(android.content.DialogInterface d, int w) {
                        eng.setShuffle(true);
                        Ui.toast(a, "Playing in a random order");
                    }
                }).show();
    }

    // ---- engine callbacks ------------------------------------------------
    public void onState(Engine.St s) {
        render(s);
        if (host != null) host.onEngineState(s);
    }

    public void onLog(String line) { }

    public void onFinished(boolean completed) {
        render(eng.st);
        if (host != null) host.onEngineFinished(completed);
    }
}
