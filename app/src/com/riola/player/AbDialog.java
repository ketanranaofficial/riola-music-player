package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.os.Handler;
import android.os.Looper;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

/** Listen to the track and mark A and B by ear. */
public final class AbDialog {

    public interface OnPick { void picked(long a, long b); }

    private AbDialog() { }

    public static void show(final Activity act, final Track track, long startMs, long endMs, final OnPick cb) {
        if (track == null) return;

        final Engine eng = Engine.get(act);
        if (eng.isRunning()) eng.stop();

        final long[] a = { Math.max(0, startMs) };
        final long[] b = { endMs };
        final boolean[] ready = { false };
        final boolean[] loopAb = { true };
        final MediaPlayer mp = new MediaPlayer();
        final Handler h = new Handler(Looper.getMainLooper());

        LinearLayout box = Ui.col(act);
        int p = Ui.dp(act, 18);
        box.setPadding(p, Ui.dp(act, 6), p, 0);

        final TextView clock = Ui.mono(act, "0:00 / 0:00", 15, Ui.ACC_TXT);
        clock.setGravity(Gravity.CENTER);
        clock.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(clock);

        final SeekBar bar = new SeekBar(act);
        bar.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        bar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        bar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        box.addView(bar);

        final TextView aTv = Ui.mono(act, "A   " + Fmt.ms(a[0]), 14, Ui.TXT);
        final TextView bTv = Ui.mono(act, "B   " + (b[0] < 0 ? "end" : Fmt.ms(b[0])), 14, Ui.TXT);

        LinearLayout tr = Ui.row(act);
        tr.setGravity(Gravity.CENTER);
        final ImageView play = Ui.roundBtn(act, Ico.PLAY, 20, true, "Play", null);
        tr.addView(nudge(act, "-5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, -5000); }
        }));
        tr.addView(play);
        tr.addView(nudge(act, "+5s", new View.OnClickListener() {
            public void onClick(View v) { seekBy(mp, ready, 5000); }
        }));
        Ui.margin(act, tr, 0, 8, 0, 6);
        box.addView(tr);

        play.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (!ready[0]) return;
                Ui.buzz(v);
                try {
                    boolean wasPlaying = mp.isPlaying();
                    if (wasPlaying) mp.pause(); else mp.start();
                    Ui.setIcon(play, wasPlaying ? Ico.PLAY : Ico.PAUSE, Ui.ONACC);
                    play.setContentDescription(wasPlaying ? "Play" : "Pause");
                } catch (IllegalStateException e) { /* ignore */ }
            }
        });

        box.addView(markRow(act, aTv, new View.OnClickListener() {
            public void onClick(View v) {
                a[0] = position(mp, ready);
                if (b[0] >= 0 && b[0] <= a[0]) b[0] = -1;
                aTv.setText("A   " + Fmt.ms(a[0]));
                bTv.setText("B   " + (b[0] < 0 ? "end" : Fmt.ms(b[0])));
            }
        }, new Nudge() {
            public void by(int ms) {
                a[0] = Math.max(0, a[0] + ms);
                if (b[0] >= 0 && a[0] >= b[0]) a[0] = Math.max(0, b[0] - 1000);
                aTv.setText("A   " + Fmt.ms(a[0]));
            }
        }));

        box.addView(markRow(act, bTv, new View.OnClickListener() {
            public void onClick(View v) {
                long pos = position(mp, ready);
                if (pos <= a[0]) { Ui.toast(act, "B has to come after A"); return; }
                b[0] = pos;
                bTv.setText("B   " + Fmt.ms(b[0]));
            }
        }, new Nudge() {
            public void by(int ms) {
                if (b[0] < 0) b[0] = position(mp, ready);
                b[0] = Math.max(a[0] + 1000, b[0] + ms);
                bTv.setText("B   " + Fmt.ms(b[0]));
            }
        }));

        box.addView(Ui.switchRow(act, "Loop A-B while listening", null, true, new Ui.OnToggle() {
            public void set(boolean v) { loopAb[0] = v; }
        }));

        LinearLayout jump = Ui.row(act);
        jump.addView(Ui.chip(act, "jump to A", false, new View.OnClickListener() {
            public void onClick(View v) { seekTo(mp, ready, a[0]); }
        }));
        jump.addView(Ui.chip(act, "jump to B", false, new View.OnClickListener() {
            public void onClick(View v) { seekTo(mp, ready, Math.max(0, (b[0] < 0 ? duration(mp, ready) : b[0]) - 3000)); }
        }));
        box.addView(jump);
        box.addView(Ui.gap(act, 4));

        ScrollView sv = new ScrollView(act);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        final AlertDialog dlg = Ui.dialog(act).setTitle(track.shortTitle())
                .setView(sv)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Use this section", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        long end = b[0];
                        if (end >= 0 && end <= a[0]) end = a[0] + 15000;
                        cb.picked(a[0], end);
                    }
                }).create();

        final Runnable tick = new Runnable() {
            public void run() {
                if (ready[0]) {
                    int pos = position(mp, ready);
                    int dur = duration(mp, ready);
                    if (!bar.isPressed()) bar.setProgress(pos);
                    clock.setText(Fmt.ms(pos) + " / " + Fmt.ms(dur));
                    if (loopAb[0] && b[0] > 0 && pos >= b[0]) seekTo(mp, ready, a[0]);
                    boolean playing = false;
                    try { playing = mp.isPlaying(); } catch (IllegalStateException e) { /* ignore */ }
                    Ui.setIcon(play, playing ? Ico.PAUSE : Ico.PLAY, Ui.ONACC);
                    play.setContentDescription(playing ? "Pause" : "Play");
                }
                h.postDelayed(this, 200);
            }
        };

        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar s, int prog, boolean fromUser) {
                if (fromUser) seekTo(mp, ready, prog);
            }
            public void onStartTrackingTouch(SeekBar s) { }
            public void onStopTrackingTouch(SeekBar s) { }
        });

        dlg.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public void onDismiss(DialogInterface d) {
                h.removeCallbacks(tick);
                try { mp.reset(); } catch (Exception e) { /* ignore */ }
                try { mp.release(); } catch (Exception e) { /* ignore */ }
            }
        });

        try {
            mp.setAudioAttributes(new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build());
            mp.setDataSource(act, track.toUri());
            mp.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                public void onPrepared(MediaPlayer m) {
                    ready[0] = true;
                    bar.setMax(Math.max(1, m.getDuration()));
                    clock.setText("0:00 / " + Fmt.ms(m.getDuration()));
                    seekTo(mp, ready, a[0]);
                }
            });
            mp.setOnErrorListener(new MediaPlayer.OnErrorListener() {
                public boolean onError(MediaPlayer m, int what, int extra) {
                    Ui.toast(act, "Cannot play this file");
                    return true;
                }
            });
            mp.prepareAsync();
        } catch (Exception e) {
            Ui.toast(act, "Cannot open this file");
        }

        dlg.show();
        h.postDelayed(tick, 200);
    }

    private interface Nudge { void by(int ms); }

    private static View markRow(Activity act, TextView label, View.OnClickListener setNow, final Nudge n) {
        LinearLayout r = Ui.row(act);
        Ui.margin(act, r, 0, 4, 0, 4);
        label.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(label);
        r.addView(nudge(act, "-1s", new View.OnClickListener() {
            public void onClick(View v) { n.by(-1000); }
        }));
        r.addView(nudge(act, "+1s", new View.OnClickListener() {
            public void onClick(View v) { n.by(1000); }
        }));
        View set = Ui.btn(act, "set", 0, Ui.SECONDARY, setNow);
        Ui.margin(act, set, 6, 0, 0, 0);
        r.addView(set);
        return r;
    }

    private static View nudge(Activity act, String text, View.OnClickListener l) {
        TextView t = Ui.tv(act, text, 12, Ui.ACC_TXT, true);
        t.setPadding(Ui.dp(act, 10), Ui.dp(act, 8), Ui.dp(act, 10), Ui.dp(act, 8));
        t.setBackground(Ui.ripple(Ui.rrs(act, Ui.SURF2, Ui.LINE, 10, 1)));
        t.setOnClickListener(l);
        LinearLayout.LayoutParams lp = Ui.lp(Ui.WRAP, Ui.WRAP);
        lp.setMargins(Ui.dp(act, 4), 0, Ui.dp(act, 4), 0);
        t.setLayoutParams(lp);
        return t;
    }

    private static void seekBy(MediaPlayer mp, boolean[] ready, int delta) {
        if (!ready[0]) return;
        try { mp.seekTo(Math.max(0, mp.getCurrentPosition() + delta)); }
        catch (IllegalStateException e) { /* ignore */ }
    }

    private static void seekTo(MediaPlayer mp, boolean[] ready, long ms) {
        if (!ready[0]) return;
        try { mp.seekTo((int) Math.max(0, ms)); } catch (IllegalStateException e) { /* ignore */ }
    }

    private static int position(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getCurrentPosition()); } catch (IllegalStateException e) { return 0; }
    }

    private static int duration(MediaPlayer mp, boolean[] ready) {
        if (!ready[0]) return 0;
        try { return Math.max(0, mp.getDuration()); } catch (IllegalStateException e) { return 0; }
    }
}
