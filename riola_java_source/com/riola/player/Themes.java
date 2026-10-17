package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.drawable.GradientDrawable;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public final class Themes {

    public interface OnChosen {
        void chosen();
    }

    private Themes() {
    }

    public static void colour(final Activity activity, final Prefs prefs, final OnChosen onChosen) {
        int iAccent = prefs.accent();
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 8.0f), iDp, 0);
        final AlertDialog[] alertDialogArr = new AlertDialog[1];
        LinearLayout linearLayoutRow = Ui.row(activity);
        for (int i = 0; i < Ui.ACCENTS.length; i++) {
            final int i2 = Ui.ACCENTS[i];
            if (i == 4) {
                linearLayoutCol.addView(linearLayoutRow);
                LinearLayout linearLayoutRow2 = Ui.row(activity);
                Ui.margin(activity, linearLayoutRow2, 0.0f, 8.0f, 0.0f, 0.0f);
                linearLayoutRow = linearLayoutRow2;
            }
            View viewSwatch = swatch(activity, i2, i2 == iAccent);
            viewSwatch.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Themes.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.buzz(view);
                    prefs.accent(i2);
                    AlertDialog alertDialog = alertDialogArr[0];
                    if (alertDialog != null) {
                        alertDialog.dismiss();
                    }
                    onChosen.chosen();
                }
            });
            linearLayoutRow.addView(viewSwatch);
        }
        linearLayoutCol.addView(linearLayoutRow);
        TextView textViewTv = Ui.tv(activity, "The colour is used for buttons, highlights and the playing step.", 11.5f, Ui.DIM, false);
        Ui.margin(activity, textViewTv, 2.0f, 12.0f, 0.0f, 0.0f);
        linearLayoutCol.addView(textViewTv);
        linearLayoutCol.addView(Ui.gap(activity, 6.0f));
        AlertDialog alertDialogCreate = Ui.dialog(activity).setTitle("Colour").setView(linearLayoutCol).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setNeutralButton("Mix your own", new DialogInterface.OnClickListener() { // from class: com.riola.player.Themes.2
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i3) {
                Themes.custom(activity, prefs, onChosen);
            }
        }).create();
        alertDialogArr[0] = alertDialogCreate;
        alertDialogCreate.show();
    }

    private static View swatch(Activity activity, int i, boolean z) {
        GradientDrawable gradientDrawable = new GradientDrawable();
        gradientDrawable.setShape(1);
        gradientDrawable.setColor(i);
        if (z) {
            gradientDrawable.setStroke(Ui.dp(activity, 3.0f), Ui.TXT);
        }
        View view = new View(activity);
        view.setBackground(gradientDrawable);
        LinearLayout.LayoutParams layoutParamsLp = Ui.lp(Ui.dp(activity, 52.0f), Ui.dp(activity, 52.0f));
        layoutParamsLp.setMargins(Ui.dp(activity, 6.0f), 0, Ui.dp(activity, 6.0f), 0);
        view.setLayoutParams(layoutParamsLp);
        view.setContentDescription(z ? "colour, selected" : "colour");
        return view;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void custom(final Activity activity, final Prefs prefs, final OnChosen onChosen) {
        int iAccent = prefs.accent();
        final int[] iArr = {(iAccent >> 16) & 255, (iAccent >> 8) & 255, iAccent & 255};
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 18.0f);
        linearLayoutCol.setPadding(iDp, Ui.dp(activity, 10.0f), iDp, 0);
        final View view = new View(activity);
        view.setLayoutParams(Ui.lp(-1, Ui.dp(activity, 64.0f)));
        linearLayoutCol.addView(view);
        final TextView textViewMono = Ui.mono(activity, "", 13.0f, Ui.DIM);
        textViewMono.setGravity(17);
        textViewMono.setLayoutParams(Ui.lp(-1, -2));
        Ui.margin(activity, textViewMono, 0.0f, 8.0f, 0.0f, 4.0f);
        linearLayoutCol.addView(textViewMono);
        final Runnable runnable = new Runnable() { // from class: com.riola.player.Themes.3
            @Override // java.lang.Runnable
            public void run() {
                int[] iArr2 = iArr;
                int i = iArr2[2] | (iArr2[0] << 16) | (-16777216) | (iArr2[1] << 8);
                GradientDrawable gradientDrawable = new GradientDrawable();
                gradientDrawable.setColor(i);
                gradientDrawable.setCornerRadius(Ui.dp(activity, Ui.RAD_BTN));
                gradientDrawable.setStroke(Math.max(1, Ui.dp(activity, 1.0f)), Ui.LINE);
                view.setBackground(gradientDrawable);
                textViewMono.setText(String.format("#%02X%02X%02X", Integer.valueOf(iArr[0]), Integer.valueOf(iArr[1]), Integer.valueOf(iArr[2])));
            }
        };
        runnable.run();
        String[] strArr = {"Red", "Green", "Blue"};
        for (final int i = 0; i < 3; i++) {
            LinearLayout linearLayoutRow = Ui.row(activity);
            Ui.margin(activity, linearLayoutRow, 0.0f, 4.0f, 0.0f, 0.0f);
            TextView textViewTv = Ui.tv(activity, strArr[i], 13.0f, Ui.DIM, false);
            textViewTv.setWidth(Ui.dp(activity, 56.0f));
            linearLayoutRow.addView(textViewTv);
            SeekBar seekBar = new SeekBar(activity);
            seekBar.setMax(255);
            seekBar.setProgress(iArr[i]);
            seekBar.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            seekBar.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
            seekBar.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
            seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.riola.player.Themes.4
                @Override // android.widget.SeekBar.OnSeekBarChangeListener
                public void onProgressChanged(SeekBar seekBar2, int i2, boolean z) {
                    iArr[i] = i2;
                    runnable.run();
                }

                @Override // android.widget.SeekBar.OnSeekBarChangeListener
                public void onStartTrackingTouch(SeekBar seekBar2) {
                }

                @Override // android.widget.SeekBar.OnSeekBarChangeListener
                public void onStopTrackingTouch(SeekBar seekBar2) {
                }
            });
            linearLayoutRow.addView(seekBar);
            linearLayoutCol.addView(linearLayoutRow);
        }
        linearLayoutCol.addView(Ui.gap(activity, 8.0f));
        Ui.dialog(activity).setTitle("Mix a colour").setView(linearLayoutCol).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setPositiveButton("Use it", new DialogInterface.OnClickListener() { // from class: com.riola.player.Themes.5
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                Prefs prefs2 = prefs;
                int[] iArr2 = iArr;
                prefs2.accent(iArr2[2] | (iArr2[0] << 16) | (-16777216) | (iArr2[1] << 8));
                onChosen.chosen();
            }
        }).show();
    }

    public static void look(Activity activity, final Prefs prefs, final OnChosen onChosen) {
        int iStyle = prefs.style();
        LinearLayout linearLayoutCol = Ui.col(activity);
        int iDp = Ui.dp(activity, 12.0f);
        linearLayoutCol.setPadding(iDp, iDp, iDp, 0);
        final AlertDialog[] alertDialogArr = new AlertDialog[1];
        final int i = 0;
        while (i < Ui.STYLE_NAMES.length) {
            LinearLayout linearLayoutRow = Ui.row(activity);
            linearLayoutRow.setPadding(Ui.dp(activity, 12.0f), Ui.dp(activity, 11.0f), Ui.dp(activity, 12.0f), Ui.dp(activity, 11.0f));
            linearLayoutRow.setBackground(Ui.ripple(i == iStyle ? Ui.rrs(activity, Ui.SURF2, Ui.ACC_TXT, Ui.RAD_BTN, 1.4f) : Ui.rr(activity, Ui.SURF2, Ui.RAD_BTN)));
            Ui.margin(activity, linearLayoutRow, 0.0f, 0.0f, 0.0f, 6.0f);
            LinearLayout linearLayoutCol2 = Ui.col(activity);
            linearLayoutCol2.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutCol2.addView(Ui.tv(activity, Ui.STYLE_NAMES[i], 15.0f, Ui.TXT, true));
            linearLayoutCol2.addView(Ui.tv(activity, Ui.STYLE_NOTES[i], 11.5f, Ui.DIM, false));
            linearLayoutRow.addView(linearLayoutCol2);
            if (i == iStyle) {
                linearLayoutRow.addView(Ui.icon(activity, 16, Ui.ACC_TXT, 18));
            }
            linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Themes.6
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.buzz(view);
                    prefs.style(i);
                    AlertDialog alertDialog = alertDialogArr[0];
                    if (alertDialog != null) {
                        alertDialog.dismiss();
                    }
                    onChosen.chosen();
                }
            });
            linearLayoutCol.addView(linearLayoutRow);
            i++;
        }
        ScrollView scrollView = new ScrollView(activity);
        scrollView.addView(linearLayoutCol, new FrameLayout.LayoutParams(-1, -2));
        AlertDialog alertDialogCreate = Ui.dialog(activity).setTitle("Look").setView(scrollView).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).create();
        alertDialogArr[0] = alertDialogCreate;
        alertDialogCreate.show();
    }
}
