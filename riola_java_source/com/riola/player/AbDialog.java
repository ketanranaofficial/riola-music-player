package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public final class AbDialog {

    private interface Nudge {
        void by(int i);
    }

    public interface OnPick {
        void picked(long j, long j2);
    }

    private AbDialog() {
    }

    public static void show(final Activity activity, Track track, long j, long j2, final OnPick onPick) {
        if (track == null) {
            return;
        }
        Engine engine = Engine.get(activity);
        if (engine.isRunning()) {
            engine.stop();
        }
        final long[] jArr = {Math.max(0L, j)};
        final long[] jArr2 = {j2};
        final boolean[] zArr = {false};
        final boolean[] zArr2 = {true};
        final MediaPlayer mediaPlayer = new MediaPlayer();
        final Handler handler = new Handler(Looper.getMainLooper());
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 6.0f), iDp, 0);
        final TextView textViewMono = Ui.mono(activity, "0:00 / 0:00", 15.0f, Ui.ACC_TXT);
        textViewMono.setGravity(17);
        textViewMono.setLayoutParams(Ui.lp(-1, -2));
        linearLayoutCol.addView(textViewMono);
        final SeekBar seekBar = new SeekBar(activity);
        seekBar.setLayoutParams(Ui.lp(-1, -2));
        seekBar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
        seekBar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
        linearLayoutCol.addView(seekBar);
        final TextView textViewMono2 = Ui.mono(activity, "A   " + Fmt.ms(jArr[0]), 14.0f, Ui.TXT);
        StringBuilder sbAppend = new StringBuilder().append("B   ");
        long j3 = jArr2[0];
        final TextView textViewMono3 = Ui.mono(activity, sbAppend.append(j3 < 0 ? "end" : Fmt.ms(j3)).toString(), 14.0f, Ui.TXT);
        LinearLayout linearLayoutRow = Ui.row(activity);
        linearLayoutRow.setGravity(17);
        final ImageView imageViewRoundBtn = Ui.roundBtn(activity, 1, 20, true, "Play", null);
        linearLayoutRow.addView(nudge(activity, "-5s", new View.OnClickListener() { // from class: com.riola.player.AbDialog.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                AbDialog.seekBy(mediaPlayer, zArr, -5000);
            }
        }));
        linearLayoutRow.addView(imageViewRoundBtn);
        linearLayoutRow.addView(nudge(activity, "+5s", new View.OnClickListener() { // from class: com.riola.player.AbDialog.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                AbDialog.seekBy(mediaPlayer, zArr, 5000);
            }
        }));
        Ui.margin(activity, linearLayoutRow, 0.0f, 8.0f, 0.0f, 6.0f);
        linearLayoutCol.addView(linearLayoutRow);
        imageViewRoundBtn.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.AbDialog.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (zArr[0]) {
                    Ui.buzz(view);
                    try {
                        boolean zIsPlaying = mediaPlayer.isPlaying();
                        if (zIsPlaying) {
                            mediaPlayer.pause();
                        } else {
                            mediaPlayer.start();
                        }
                        Ui.setIcon(imageViewRoundBtn, zIsPlaying ? 1 : 2, Ui.ONACC);
                        imageViewRoundBtn.setContentDescription(zIsPlaying ? "Play" : "Pause");
                    } catch (IllegalStateException e) {
                    }
                }
            }
        });
        linearLayoutCol.addView(markRow(activity, textViewMono2, new View.OnClickListener() { // from class: com.riola.player.AbDialog.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                jArr[0] = AbDialog.position(mediaPlayer, zArr);
                long[] jArr3 = jArr2;
                long j4 = jArr3[0];
                if (j4 >= 0 && j4 <= jArr[0]) {
                    jArr3[0] = -1;
                }
                textViewMono2.setText("A   " + Fmt.ms(jArr[0]));
                TextView textView = textViewMono3;
                StringBuilder sbAppend2 = new StringBuilder().append("B   ");
                long j5 = jArr2[0];
                textView.setText(sbAppend2.append(j5 < 0 ? "end" : Fmt.ms(j5)).toString());
            }
        }, new Nudge() { // from class: com.riola.player.AbDialog.5
            @Override // com.riola.player.AbDialog.Nudge
            public void by(int i) {
                long[] jArr3 = jArr;
                jArr3[0] = Math.max(0L, jArr3[0] + ((long) i));
                long j4 = jArr2[0];
                if (j4 >= 0) {
                    long[] jArr4 = jArr;
                    if (jArr4[0] >= j4) {
                        jArr4[0] = Math.max(0L, j4 - 1000);
                    }
                }
                textViewMono2.setText("A   " + Fmt.ms(jArr[0]));
            }
        }));
        linearLayoutCol.addView(markRow(activity, textViewMono3, new View.OnClickListener() { // from class: com.riola.player.AbDialog.6
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                long jPosition = AbDialog.position(mediaPlayer, zArr);
                if (jPosition <= jArr[0]) {
                    Ui.toast(activity, "B has to come after A");
                } else {
                    jArr2[0] = jPosition;
                    textViewMono3.setText("B   " + Fmt.ms(jArr2[0]));
                }
            }
        }, new Nudge() { // from class: com.riola.player.AbDialog.7
            @Override // com.riola.player.AbDialog.Nudge
            public void by(int i) {
                long[] jArr3 = jArr2;
                if (jArr3[0] < 0) {
                    jArr3[0] = AbDialog.position(mediaPlayer, zArr);
                }
                long[] jArr4 = jArr2;
                jArr4[0] = Math.max(jArr[0] + 1000, jArr4[0] + ((long) i));
                textViewMono3.setText("B   " + Fmt.ms(jArr2[0]));
            }
        }));
        linearLayoutCol.addView(Ui.switchRow(activity, "Loop A-B while listening", null, true, new Ui.OnToggle() { // from class: com.riola.player.AbDialog.8
            @Override // com.riola.player.Ui.OnToggle
            public void set(boolean z) {
                zArr2[0] = z;
            }
        }));
        LinearLayout linearLayoutRow2 = Ui.row(activity);
        linearLayoutRow2.addView(Ui.chip(activity, "jump to A", false, new View.OnClickListener() { // from class: com.riola.player.AbDialog.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                AbDialog.seekTo(mediaPlayer, zArr, jArr[0]);
            }
        }));
        linearLayoutRow2.addView(Ui.chip(activity, "jump to B", false, new View.OnClickListener() { // from class: com.riola.player.AbDialog.10
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MediaPlayer mediaPlayer2 = mediaPlayer;
                boolean[] zArr3 = zArr;
                long jDuration = jArr2[0];
                if (jDuration < 0) {
                    jDuration = AbDialog.duration(mediaPlayer2, zArr3);
                }
                AbDialog.seekTo(mediaPlayer2, zArr3, Math.max(0L, jDuration - 3000));
            }
        }));
        linearLayoutCol.addView(linearLayoutRow2);
        linearLayoutCol.addView(Ui.gap(activity, 4.0f));
        ScrollView scrollView = new ScrollView(activity);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        AlertDialog alertDialogCreate = Ui.dialog(activity).setTitle(track.shortTitle()).setView(scrollView).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Use this section", new DialogInterface.OnClickListener() { // from class: com.riola.player.AbDialog.11
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                long j4 = jArr2[0];
                if (j4 >= 0) {
                    long j5 = jArr[0];
                    if (j4 <= j5) {
                        j4 = 15000 + j5;
                    }
                }
                onPick.picked(jArr[0], j4);
            }
        }).create();
        final Runnable runnable = new Runnable() { // from class: com.riola.player.AbDialog.12
            @Override // java.lang.Runnable
            public void run() {
                boolean[] zArr3 = zArr;
                boolean zIsPlaying = false;
                if (zArr3[0]) {
                    int iPosition = AbDialog.position(mediaPlayer, zArr3);
                    int iDuration = AbDialog.duration(mediaPlayer, zArr);
                    if (!seekBar.isPressed()) {
                        seekBar.setProgress(iPosition);
                    }
                    long j4 = iPosition;
                    textViewMono.setText(Fmt.ms(j4) + " / " + Fmt.ms(iDuration));
                    if (zArr2[0]) {
                        long j5 = jArr2[0];
                        if (j5 > 0 && j4 >= j5) {
                            AbDialog.seekTo(mediaPlayer, zArr, jArr[0]);
                        }
                    }
                    try {
                        zIsPlaying = mediaPlayer.isPlaying();
                    } catch (IllegalStateException e) {
                    }
                    Ui.setIcon(imageViewRoundBtn, zIsPlaying ? 2 : 1, Ui.ONACC);
                    imageViewRoundBtn.setContentDescription(zIsPlaying ? "Pause" : "Play");
                }
                handler.postDelayed(this, 200L);
            }
        };
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.riola.player.AbDialog.13
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i, boolean z) {
                if (z) {
                    AbDialog.seekTo(mediaPlayer, zArr, i);
                }
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
            }
        });
        alertDialogCreate.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: com.riola.player.AbDialog.14
            @Override // android.content.DialogInterface.OnDismissListener
            public void onDismiss(DialogInterface dialogInterface) {
                handler.removeCallbacks(runnable);
                try {
                    mediaPlayer.reset();
                } catch (Exception e) {
                }
                try {
                    mediaPlayer.release();
                } catch (Exception e2) {
                }
            }
        });
        try {
            mediaPlayer.setAudioAttributes(new AudioAttributes.Builder().setUsage(1).setContentType(2).build());
            mediaPlayer.setDataSource(activity, track.toUri());
            mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() { // from class: com.riola.player.AbDialog.15
                @Override // android.media.MediaPlayer.OnPreparedListener
                public void onPrepared(MediaPlayer mediaPlayer2) {
                    zArr[0] = true;
                    seekBar.setMax(Math.max(1, mediaPlayer2.getDuration()));
                    textViewMono.setText("0:00 / " + Fmt.ms(mediaPlayer2.getDuration()));
                    AbDialog.seekTo(mediaPlayer, zArr, jArr[0]);
                }
            });
            mediaPlayer.setOnErrorListener(new MediaPlayer.OnErrorListener() { // from class: com.riola.player.AbDialog.16
                @Override // android.media.MediaPlayer.OnErrorListener
                public boolean onError(MediaPlayer mediaPlayer2, int i, int i2) {
                    Ui.toast(activity, "Cannot play this file");
                    return true;
                }
            });
            mediaPlayer.prepareAsync();
        } catch (Exception e) {
            Ui.toast(activity, "Cannot open this file");
        }
        alertDialogCreate.show();
        handler.postDelayed(runnable, 200L);
    }

    private static View markRow(Activity activity, TextView textView, View.OnClickListener onClickListener, final Nudge nudge) {
        LinearLayout linearLayoutRow = Ui.row(activity);
        Ui.margin(activity, linearLayoutRow, 0.0f, 4.0f, 0.0f, 4.0f);
        textView.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(textView);
        linearLayoutRow.addView(nudge(activity, "-1s", new View.OnClickListener() { // from class: com.riola.player.AbDialog.17
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                nudge.by(-1000);
            }
        }));
        linearLayoutRow.addView(nudge(activity, "+1s", new View.OnClickListener() { // from class: com.riola.player.AbDialog.18
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                nudge.by(1000);
            }
        }));
        LinearLayout linearLayoutBtn = Ui.btn(activity, "set", 0, 1, onClickListener);
        Ui.margin(activity, linearLayoutBtn, 6.0f, 0.0f, 0.0f, 0.0f);
        linearLayoutRow.addView(linearLayoutBtn);
        return linearLayoutRow;
    }

    private static View nudge(Activity activity, String str, View.OnClickListener onClickListener) {
        TextView textViewTv = Ui.tv(activity, str, 12.0f, Ui.ACC_TXT, true);
        textViewTv.setPadding(Ui.dp(activity, 10.0f), Ui.dp(activity, 8.0f), Ui.dp(activity, 10.0f), Ui.dp(activity, 8.0f));
        textViewTv.setBackground(Ui.ripple(Ui.rrs(activity, Ui.SURF2, Ui.LINE, 10.0f, 1.0f)));
        textViewTv.setOnClickListener(onClickListener);
        LinearLayout.LayoutParams layoutParamsLp = Ui.lp(-2, -2);
        layoutParamsLp.setMargins(Ui.dp(activity, 4.0f), 0, Ui.dp(activity, 4.0f), 0);
        textViewTv.setLayoutParams(layoutParamsLp);
        return textViewTv;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void seekBy(MediaPlayer mediaPlayer, boolean[] zArr, int i) {
        if (zArr[0]) {
            try {
                mediaPlayer.seekTo(Math.max(0, mediaPlayer.getCurrentPosition() + i));
            } catch (IllegalStateException e) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void seekTo(MediaPlayer mediaPlayer, boolean[] zArr, long j) {
        if (zArr[0]) {
            try {
                mediaPlayer.seekTo((int) Math.max(0L, j));
            } catch (IllegalStateException e) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static int position(MediaPlayer mediaPlayer, boolean[] zArr) {
        if (!zArr[0]) {
            return 0;
        }
        try {
            return Math.max(0, mediaPlayer.getCurrentPosition());
        } catch (IllegalStateException e) {
            return 0;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static int duration(MediaPlayer mediaPlayer, boolean[] zArr) {
        if (!zArr[0]) {
            return 0;
        }
        try {
            return Math.max(0, mediaPlayer.getDuration());
        } catch (IllegalStateException e) {
            return 0;
        }
    }
}
