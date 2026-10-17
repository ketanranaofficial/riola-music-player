package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class Pickers {

    public interface OnMs {
        void picked(long j);
    }

    public interface OnText {
        void picked(String str);
    }

    public interface OnTrack {
        void picked(Track track);
    }

    private Pickers() {
    }

    public static void track(Activity activity, String str, final OnTrack onTrack) {
        TrackPicker.show(activity, str, false, new TrackPicker.OnPicked() { // from class: com.riola.player.Pickers.1
            @Override // com.riola.player.TrackPicker.OnPicked
            public void picked(List<Track> list) {
                if (!list.isEmpty()) {
                    onTrack.picked(list.get(0));
                }
            }
        });
    }

    public static void duration(final Activity activity, String str, long j, final OnMs onMs) {
        final long[] jArr = {Math.max(0L, j)};
        final LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 8.0f), iDp, 0);
        final Runnable[] runnableArr = new Runnable[1];
        runnableArr[0] = new Runnable() { // from class: com.riola.player.Pickers.2
            @Override // java.lang.Runnable
            public void run() {
                Pickers.fillDuration(activity, linearLayoutCol, jArr, runnableArr[0]);
            }
        };
        runnableArr[0].run();
        ScrollView scrollView = new ScrollView(activity);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        Ui.dialog(activity).setTitle(str).setView(scrollView).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Set", new DialogInterface.OnClickListener() { // from class: com.riola.player.Pickers.3
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                onMs.picked(jArr[0]);
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void fillDuration(Activity activity, LinearLayout linearLayout, final long[] jArr, final Runnable runnable) {
        StringBuilder sbAppend;
        String str;
        linearLayout.removeAllViews();
        final TextView textViewTv = Ui.tv(activity, Fmt.ms(jArr[0]), 30.0f, Ui.ACC_TXT, true);
        textViewTv.setGravity(17);
        textViewTv.setLayoutParams(Ui.lp(-1, -2));
        linearLayout.addView(textViewTv);
        LinearLayout linearLayoutRow = Ui.row(activity);
        int[] iArr = {15, 30, 60, 120, 300, 600, 1200};
        int i = 0;
        for (int i2 = 7; i < i2; i2 = 7) {
            final int i3 = iArr[i];
            if (i3 < 60) {
                sbAppend = new StringBuilder().append(i3);
                str = "s";
            } else {
                sbAppend = new StringBuilder().append(i3 / 60);
                str = "m";
            }
            linearLayoutRow.addView(Ui.chip(activity, sbAppend.append(str).toString(), jArr[0] == ((long) i3) * 1000, new View.OnClickListener() { // from class: com.riola.player.Pickers.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    jArr[0] = ((long) i3) * 1000;
                    runnable.run();
                }
            }));
            i++;
        }
        HorizontalScrollView horizontalScrollView = new HorizontalScrollView(activity);
        horizontalScrollView.setHorizontalScrollBarEnabled(false);
        horizontalScrollView.addView(linearLayoutRow, new FrameLayout.LayoutParams(-2, -2));
        Ui.margin(activity, horizontalScrollView, 0.0f, 8.0f, 0.0f, 4.0f);
        linearLayout.addView(horizontalScrollView);
        linearLayout.addView(labelled(activity, "Minutes", Ui.stepper(activity, (int) (jArr[0] / 60000), 0, 600, 1, "", new Ui.OnValue() { // from class: com.riola.player.Pickers.5
            @Override // com.riola.player.Ui.OnValue
            public void set(int i4) {
                long[] jArr2 = jArr;
                long j = (((long) i4) * 60000) + (jArr2[0] % 60000);
                jArr2[0] = j;
                textViewTv.setText(Fmt.ms(j));
            }
        })));
        linearLayout.addView(labelled(activity, "Seconds", Ui.stepper(activity, (int) ((jArr[0] % 60000) / 1000), 0, 55, 5, "", new Ui.OnValue() { // from class: com.riola.player.Pickers.6
            @Override // com.riola.player.Ui.OnValue
            public void set(int i4) {
                long[] jArr2 = jArr;
                long j = ((jArr2[0] / 60000) * 60000) + (((long) i4) * 1000);
                jArr2[0] = j;
                textViewTv.setText(Fmt.ms(j));
            }
        })));
        linearLayout.addView(Ui.gap(activity, 6.0f));
    }

    public static void position(Activity activity, String str, long j, long j2, final OnMs onMs) {
        final long[] jArr = {Math.max(0L, j)};
        final long j3 = j2 > 0 ? j2 : 86400000L;
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 8.0f), iDp, 0);
        final TextView textViewTv = Ui.tv(activity, Fmt.ms(jArr[0]), 30.0f, Ui.ACC_TXT, true);
        textViewTv.setGravity(17);
        textViewTv.setLayoutParams(Ui.lp(-1, -2));
        linearLayoutCol.addView(textViewTv);
        if (j2 > 0) {
            TextView textViewTv2 = Ui.tv(activity, "track is " + Fmt.ms(j2) + " long", 11.5f, Ui.DIM, false);
            textViewTv2.setGravity(17);
            textViewTv2.setLayoutParams(Ui.lp(-1, -2));
            linearLayoutCol.addView(textViewTv2);
        }
        linearLayoutCol.addView(labelled(activity, "Minutes", Ui.stepper(activity, (int) (jArr[0] / 60000), 0, ((int) (j3 / 60000)) + 1, 1, "", new Ui.OnValue() { // from class: com.riola.player.Pickers.7
            @Override // com.riola.player.Ui.OnValue
            public void set(int i) {
                long[] jArr2 = jArr;
                jArr2[0] = Math.min(j3, (((long) i) * 60000) + (jArr2[0] % 60000));
                textViewTv.setText(Fmt.ms(jArr[0]));
            }
        })));
        linearLayoutCol.addView(labelled(activity, "Seconds", Ui.stepper(activity, (int) ((jArr[0] % 60000) / 1000), 0, 59, 1, "", new Ui.OnValue() { // from class: com.riola.player.Pickers.8
            @Override // com.riola.player.Ui.OnValue
            public void set(int i) {
                long[] jArr2 = jArr;
                jArr2[0] = Math.min(j3, ((jArr2[0] / 60000) * 60000) + (((long) i) * 1000));
                textViewTv.setText(Fmt.ms(jArr[0]));
            }
        })));
        linearLayoutCol.addView(Ui.gap(activity, 6.0f));
        Ui.dialog(activity).setTitle(str).setView(linearLayoutCol).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Set", new DialogInterface.OnClickListener() { // from class: com.riola.player.Pickers.9
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                onMs.picked(jArr[0]);
            }
        }).show();
    }

    public static void text(final Activity activity, String str, String str2, String str3, final OnText onText) {
        final EditText editText = new EditText(activity);
        editText.setSingleLine(true);
        editText.setHint(str3);
        if (str2 == null) {
            str2 = "";
        }
        editText.setText(str2);
        editText.setSelectAllOnFocus(true);
        editText.selectAll();
        editText.setTextColor(Ui.TXT);
        editText.setHintTextColor(Ui.DIM);
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 20.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 8.0f), iDp, 0);
        linearLayoutCol.addView(editText);
        Ui.dialog(activity).setTitle(str).setView(linearLayoutCol).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Save", new DialogInterface.OnClickListener() { // from class: com.riola.player.Pickers.10
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                String strTrim = editText.getText().toString().trim();
                if (strTrim.length() == 0) {
                    Ui.toast(activity, "Give it a name");
                } else {
                    onText.picked(strTrim);
                }
            }
        }).show();
    }

    private static View labelled(Activity activity, String str, View view) {
        LinearLayout linearLayoutRow = Ui.row(activity);
        Ui.margin(activity, linearLayoutRow, 0.0f, 6.0f, 0.0f, 0.0f);
        TextView textViewTv = Ui.tv(activity, str, 13.5f, Ui.DIM, false);
        textViewTv.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        linearLayoutRow.addView(textViewTv);
        view.setLayoutParams(Ui.lp(Ui.dp(activity, 170.0f), -2));
        linearLayoutRow.addView(view);
        return linearLayoutRow;
    }
}
