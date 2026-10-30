package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

/** The two dialogs behind "Colour" and "Look" in settings. */
public final class Themes {

    public interface OnChosen { void chosen(); }

    private Themes() { }

    // ---- colour ----------------------------------------------------------
    public static void colour(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int current = prefs.accent();

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final android.app.AlertDialog[] holder = new android.app.AlertDialog[1];

        LinearLayout row = Ui.row(a);
        for (int i = 0; i < Ui.ACCENTS.length; i++) {
            final int colour = Ui.ACCENTS[i];
            if (i == 4) {                       // second row of swatches
                box.addView(row);
                row = Ui.row(a);
                Ui.margin(a, row, 0, 8, 0, 0);
            }
            View sw = swatch(a, colour, colour == current);
            sw.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    Ui.buzz(v);
                    prefs.accent(colour);
                    if (holder[0] != null) holder[0].dismiss();
                    cb.chosen();
                }
            });
            row.addView(sw);
        }
        box.addView(row);

        TextView note = Ui.tv(a, "The colour is used for buttons, highlights and the playing step.",
                11.5f, Ui.DIM, false);
        Ui.margin(a, note, 2, 12, 0, 0);
        box.addView(note);
        box.addView(Ui.gap(a, 6));

        holder[0] = Ui.dialog(a).setTitle("Colour").setView(box)
                .setNegativeButton("Cancel", null)
                .setNeutralButton("Mix your own", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { custom(a, prefs, cb); }
                }).create();
        holder[0].show();
    }

    private static View swatch(Activity a, int colour, boolean selected) {
        GradientDrawable g = new GradientDrawable();
        g.setShape(GradientDrawable.OVAL);
        g.setColor(colour);
        if (selected) g.setStroke(Ui.dp(a, 3), Ui.TXT);
        View v = new View(a);
        v.setBackground(g);
        LinearLayout.LayoutParams lp = Ui.lp(Ui.dp(a, 52), Ui.dp(a, 52));
        lp.setMargins(Ui.dp(a, 6), 0, Ui.dp(a, 6), 0);
        v.setLayoutParams(lp);
        v.setContentDescription(selected ? "colour, selected" : "colour");
        return v;
    }

    /** Three sliders and a live preview - enough, and no library needed. */
    private static void custom(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int start = prefs.accent();
        final int[] rgb = { (start >> 16) & 0xFF, (start >> 8) & 0xFF, start & 0xFF };

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 10), p, 0);

        final View preview = new View(a);
        preview.setLayoutParams(Ui.lp(Ui.MATCH, Ui.dp(a, 64)));
        box.addView(preview);

        final TextView hex = Ui.mono(a, "", 13, Ui.DIM);
        hex.setGravity(Gravity.CENTER);
        hex.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        Ui.margin(a, hex, 0, 8, 0, 4);
        box.addView(hex);

        final Runnable paint = new Runnable() {
            public void run() {
                int c = 0xFF000000 | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
                GradientDrawable g = new GradientDrawable();
                g.setColor(c);
                g.setCornerRadius(Ui.dp(a, Ui.RAD_BTN));
                g.setStroke(Math.max(1, Ui.dp(a, 1)), Ui.LINE);
                preview.setBackground(g);
                hex.setText(String.format("#%02X%02X%02X", rgb[0], rgb[1], rgb[2]));
            }
        };
        paint.run();

        String[] names = { "Red", "Green", "Blue" };
        for (int i = 0; i < 3; i++) {
            final int channel = i;
            LinearLayout r = Ui.row(a);
            Ui.margin(a, r, 0, 4, 0, 0);
            TextView label = Ui.tv(a, names[i], 13, Ui.DIM, false);
            label.setWidth(Ui.dp(a, 56));
            r.addView(label);
            SeekBar s = new SeekBar(a);
            s.setMax(255);
            s.setProgress(rgb[i]);
            s.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            s.setProgressTintList(ColorStateList.valueOf(Ui.ACC));
            s.setThumbTintList(ColorStateList.valueOf(Ui.ACC));
            s.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                public void onProgressChanged(SeekBar b, int v, boolean fromUser) {
                    rgb[channel] = v;
                    paint.run();
                }
                public void onStartTrackingTouch(SeekBar b) { }
                public void onStopTrackingTouch(SeekBar b) { }
            });
            r.addView(s);
            box.addView(r);
        }
        box.addView(Ui.gap(a, 8));

        Ui.dialog(a).setTitle("Mix a colour").setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Use it", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        prefs.accent(0xFF000000 | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2]);
                        cb.chosen();
                    }
                }).show();
    }

    // ---- look ------------------------------------------------------------
    public static void look(final Activity a, final Prefs prefs, final OnChosen cb) {
        final int current = prefs.style();

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 12);
        box.setPadding(p, p, p, 0);

        final android.app.AlertDialog[] holder = new android.app.AlertDialog[1];

        for (int i = 0; i < Ui.STYLE_NAMES.length; i++) {
            final int which = i;
            LinearLayout r = Ui.row(a);
            r.setPadding(Ui.dp(a, 12), Ui.dp(a, 11), Ui.dp(a, 12), Ui.dp(a, 11));
            r.setBackground(Ui.ripple(i == current
                    ? Ui.rrs(a, Ui.SURF2, Ui.ACC_TXT, Ui.RAD_BTN, 1.4f)
                    : Ui.rr(a, Ui.SURF2, Ui.RAD_BTN)));
            Ui.margin(a, r, 0, 0, 0, 6);
            LinearLayout col = Ui.col(a);
            col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
            col.addView(Ui.tv(a, Ui.STYLE_NAMES[i], 15, Ui.TXT, true));
            col.addView(Ui.tv(a, Ui.STYLE_NOTES[i], 11.5f, Ui.DIM, false));
            r.addView(col);
            if (i == current) r.addView(Ui.icon(a, Ico.CHECK, Ui.ACC_TXT, 18));
            r.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    Ui.buzz(v);
                    prefs.style(which);
                    if (holder[0] != null) holder[0].dismiss();
                    cb.chosen();
                }
            });
            box.addView(r);
        }

        ScrollView sv = new ScrollView(a);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        holder[0] = Ui.dialog(a).setTitle("Look").setView(sv)
                .setNegativeButton("Cancel", null).create();
        holder[0].show();
    }
}
