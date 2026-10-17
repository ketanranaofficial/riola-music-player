package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public class PlayerBar implements Engine.Listener {
    private final Activity act;
    private final TextView badge;
    private final TextView detail;
    private boolean dragging;
    private final Engine eng;
    private final Host host;
    private final ImageView play;
    private final TextView remain;
    private final SeekBar seek;
    private ImageView shuffle;
    private final TextView time;
    private final TextView title;
    public final LinearLayout view;

    public interface Host {
        void onEngineFinished(boolean z);

        void onEngineState(Engine.St st);
    }

    public PlayerBar(final Activity activity, Host host) {
        this.act = activity;
        this.host = host;
        this.eng = Engine.get(activity);
        LinearLayout linearLayoutCol = Ui.col(activity);
        this.view = linearLayoutCol;
        linearLayoutCol.setBackgroundColor(Ui.SURF);
        linearLayoutCol.setVisibility(8);
        linearLayoutCol.setClickable(true);
        linearLayoutCol.setFocusable(true);
        View view = new View(activity);
        view.setLayoutParams(Ui.lp(-1, Math.max(1, Ui.dp(activity, 0.7f))));
        view.setBackgroundColor(Ui.LINE);
        linearLayoutCol.addView(view);
        LinearLayout linearLayoutCol2 = Ui.col(activity);
        linearLayoutCol2.setPadding(Ui.dp(activity, 14.0f), Ui.dp(activity, 10.0f), Ui.dp(activity, 14.0f), Ui.dp(activity, 12.0f));
        linearLayoutCol.addView(linearLayoutCol2);
        LinearLayout linearLayoutRow = Ui.row(activity);
        linearLayoutRow.setBackground(Ui.ripple(Ui.rr(activity, 0, 10.0f)));
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.PlayerBar.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                try {
                    activity.startActivity(new Intent(activity, (Class<?>) NowPlayingActivity.class));
                } catch (Exception e) {
                }
            }
        });
        TextView textViewTv = Ui.tv(activity, "", 14.5f, Ui.TXT, true);
        this.title = textViewTv;
        Ui.ellipsize(textViewTv);
        textViewTv.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(textViewTv);
        TextView textViewBadge = Ui.badge(activity, "", Ui.ONACC, Ui.ACC);
        this.badge = textViewBadge;
        linearLayoutRow.addView(textViewBadge);
        linearLayoutCol2.addView(linearLayoutRow);
        TextView textViewTv2 = Ui.tv(activity, "", 12.0f, Ui.DIM, false);
        this.detail = textViewTv2;
        Ui.ellipsize(textViewTv2);
        linearLayoutCol2.addView(textViewTv2);
        linearLayoutRow.addView(Ui.icon(activity, 18, Ui.DIM, 14));
        SeekBar seekBar = new SeekBar(activity);
        this.seek = seekBar;
        seekBar.setLayoutParams(Ui.lp(-1, -2));
        seekBar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seekBar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        seekBar.setProgressBackgroundTintList(ColorStateList.valueOf(Ui.LINE));
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.riola.player.PlayerBar.2
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i, boolean z) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
                PlayerBar.this.dragging = true;
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
                PlayerBar.this.dragging = false;
                PlayerBar.this.eng.seekTo(seekBar2.getProgress());
            }
        });
        Ui.margin(activity, seekBar, 0.0f, 2.0f, 0.0f, 0.0f);
        linearLayoutCol2.addView(seekBar);
        LinearLayout linearLayoutRow2 = Ui.row(activity);
        TextView textViewMono = Ui.mono(activity, "0:00 / 0:00", 11.0f, Ui.DIM);
        this.time = textViewMono;
        linearLayoutRow2.addView(textViewMono);
        linearLayoutRow2.addView(Ui.spring(activity));
        TextView textViewTv3 = Ui.tv(activity, "", 11.0f, Ui.DIM, false);
        this.remain = textViewTv3;
        linearLayoutRow2.addView(textViewTv3);
        linearLayoutCol2.addView(linearLayoutRow2);
        LinearLayout linearLayoutRow3 = Ui.row(activity);
        linearLayoutRow3.setGravity(17);
        Ui.margin(activity, linearLayoutRow3, 0.0f, 6.0f, 0.0f, 0.0f);
        ImageView imageViewRoundBtn = Ui.roundBtn(activity, 36, 18, false, "Shuffle", new View.OnClickListener() { // from class: com.riola.player.PlayerBar.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                Ui.buzz(view2);
                PlayerBar.askShuffle(activity, PlayerBar.this.eng);
            }
        });
        this.shuffle = imageViewRoundBtn;
        linearLayoutRow3.addView(imageViewRoundBtn);
        linearLayoutRow3.addView(Ui.hgap(activity, 10.0f));
        linearLayoutRow3.addView(Ui.roundBtn(activity, 5, 20, false, "Previous step", new View.OnClickListener() { // from class: com.riola.player.PlayerBar.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                Ui.buzz(view2);
                PlayerBar.this.eng.prev();
            }
        }));
        linearLayoutRow3.addView(Ui.hgap(activity, 10.0f));
        ImageView imageViewRoundBtn2 = Ui.roundBtn(activity, 2, 22, true, "Pause", new View.OnClickListener() { // from class: com.riola.player.PlayerBar.5
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                Ui.buzz(view2);
                PlayerBar.this.eng.togglePause();
            }
        });
        this.play = imageViewRoundBtn2;
        linearLayoutRow3.addView(imageViewRoundBtn2);
        linearLayoutRow3.addView(Ui.hgap(activity, 10.0f));
        linearLayoutRow3.addView(Ui.roundBtn(activity, 3, 20, false, "Stop", new View.OnClickListener() { // from class: com.riola.player.PlayerBar.6
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                Ui.buzz(view2);
                PlayerBar.this.stop();
            }
        }));
        linearLayoutRow3.addView(Ui.hgap(activity, 10.0f));
        linearLayoutRow3.addView(Ui.roundBtn(activity, 4, 20, false, "Next step", new View.OnClickListener() { // from class: com.riola.player.PlayerBar.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                Ui.buzz(view2);
                PlayerBar.this.eng.next();
            }
        }));
        linearLayoutCol2.addView(linearLayoutRow3);
    }

    public void attach() {
        this.eng.addListener(this);
        render(this.eng.st);
    }

    public void detach() {
        this.eng.removeListener(this);
    }

    public void stop() {
        this.eng.stop();
        try {
            this.act.stopService(new Intent(this.act, (Class<?>) PlayerService.class));
        } catch (Exception e) {
        }
        render(this.eng.st);
    }

    public static void startService(Activity activity) {
        Intent action = new Intent(activity, (Class<?>) PlayerService.class).setAction(PlayerService.ACT_ATTACH);
        try {
            activity.startForegroundService(action);
        } catch (Exception e) {
            try {
                activity.startService(action);
            } catch (Exception e2) {
            }
        }
    }

    public void render(Engine.St st) {
        String strAppend;
        if (!st.running) {
            this.view.setVisibility(8);
            return;
        }
        this.view.setVisibility(0);
        this.title.setText(st.stepTitle);
        this.detail.setText((st.resting && st.stepDetail.length() == 0) ? "resting" : st.stepDetail);
        if (st.countIn > 0) {
            this.badge.setText("READY");
        } else if (st.preview) {
            this.badge.setText("PREVIEW");
        } else {
            this.badge.setText("STEP " + (st.step + 1) + "/" + st.steps);
        }
        int iMax = Math.max(1, st.durMs);
        if (!this.dragging) {
            this.seek.setMax(iMax);
            this.seek.setProgress(Math.min(st.posMs, iMax));
        }
        this.time.setText(Fmt.ms(st.posMs) + " / " + Fmt.ms(st.durMs));
        if (st.stepRemainMs >= 0) {
            strAppend = Fmt.human(st.stepRemainMs) + " left";
        } else {
            strAppend = st.repTotal > 1 ? "pass " + Math.min(st.repDone + 1, st.repTotal) + " of " + st.repTotal : "";
        }
        if (st.loopTotal < 0) {
            strAppend = append(strAppend, "loop " + (st.loopDone + 1));
        } else if (st.loopTotal > 1) {
            strAppend = append(strAppend, "loop " + (st.loopDone + 1) + "/" + st.loopTotal);
        }
        if (st.progRemainMs > 0) {
            strAppend = append(strAppend, "~" + Fmt.human(st.progRemainMs) + " to go");
        }
        this.remain.setText(strAppend);
        Ui.setIcon(this.play, st.paused ? 1 : 2, Ui.ONACC);
        this.play.setContentDescription(st.paused ? "Resume" : "Pause");
        ImageView imageView = this.shuffle;
        if (imageView != null) {
            Ui.setIcon(imageView, 36, st.shuffled ? Ui.ACC_TXT : Ui.TXT);
            this.shuffle.setContentDescription(st.shuffled ? "Shuffling, tap to stop" : "Shuffle");
        }
    }

    private String append(String str, String str2) {
        return str.length() == 0 ? str2 : str + "  .  " + str2;
    }

    static void askShuffle(final Activity activity, final Engine engine) {
        if (engine.isShuffled()) {
            engine.setShuffle(false);
            Ui.toast(activity, "Back to the order you built");
        } else {
            Ui.dialog(activity).setTitle("Shuffle the steps?").setMessage("The steps will play in a random order instead of the order you built, and a new order is drawn each time the program repeats.\n\nYour program is not changed, and you can switch back at any time.").setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Shuffle", new DialogInterface.OnClickListener() { // from class: com.riola.player.PlayerBar.8
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    engine.setShuffle(true);
                    Ui.toast(activity, "Playing in a random order");
                }
            }).show();
        }
    }

    @Override // com.riola.player.Engine.Listener
    public void onState(Engine.St st) {
        render(st);
        Host host = this.host;
        if (host != null) {
            host.onEngineState(st);
        }
    }

    @Override // com.riola.player.Engine.Listener
    public void onLog(String str) {
    }

    @Override // com.riola.player.Engine.Listener
    public void onFinished(boolean z) {
        render(this.eng.st);
        Host host = this.host;
        if (host != null) {
            host.onEngineFinished(z);
        }
    }
}
