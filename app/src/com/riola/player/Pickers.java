package com.riola.player;

import android.app.Activity;
import android.content.DialogInterface;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/** Small reusable dialogs: pick a track, a length, a position, or type a name. */
public final class Pickers {

    public interface OnTrack { void picked(Track t); }
    public interface OnMs    { void picked(long ms); }
    public interface OnText  { void picked(String s); }

    private Pickers() { }

    // ---- track -----------------------------------------------------------
    public static void track(final Activity a, String title, final OnTrack cb) {
        TrackPicker.show(a, title, false, new TrackPicker.OnPicked() {
            public void picked(java.util.List<Track> picked) {
                if (!picked.isEmpty()) cb.picked(picked.get(0));
            }
        });
    }

    // ---- length ----------------------------------------------------------
    public static void duration(final Activity a, String title, long ms, final OnMs cb) {
        final long[] value = { Math.max(0, ms) };

        final LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final Runnable[] render = new Runnable[1];
        render[0] = new Runnable() {
            public void run() { fillDuration(a, box, value, render[0]); }
        };
        render[0].run();

        ScrollView sv = new ScrollView(a);
        sv.addView(box, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));

        Ui.dialog(a).setTitle(title).setView(sv)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Set", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.picked(value[0]); }
                }).show();
    }

    /**
     * Rebuilt whenever a preset is tapped. The steppers keep their own internal
     * counter, so redrawing is the only way to stop them showing a stale number.
     */
    private static void fillDuration(final Activity a, final LinearLayout box,
                                     final long[] value, final Runnable again) {
        box.removeAllViews();

        final TextView shown = Ui.tv(a, Fmt.ms(value[0]), 30, Ui.ACC_TXT, true);
        shown.setGravity(Gravity.CENTER);
        shown.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(shown);

        LinearLayout quick = Ui.row(a);
        final int[] presets = { 15, 30, 60, 120, 300, 600, 1200 };
        for (int i = 0; i < presets.length; i++) {
            final int secs = presets[i];
            quick.addView(Ui.chip(a, secs < 60 ? (secs + "s") : ((secs / 60) + "m"),
                    value[0] == secs * 1000L, new View.OnClickListener() {
                public void onClick(View v) {
                    value[0] = secs * 1000L;
                    again.run();
                }
            }));
        }
        android.widget.HorizontalScrollView row = new android.widget.HorizontalScrollView(a);
        row.setHorizontalScrollBarEnabled(false);
        row.addView(quick, new FrameLayout.LayoutParams(Ui.WRAP, Ui.WRAP));
        Ui.margin(a, row, 0, 8, 0, 4);
        box.addView(row);

        box.addView(labelled(a, "Minutes", Ui.stepper(a, (int) (value[0] / 60000L), 0, 600, 1, "",
                new Ui.OnValue() {
            public void set(int v) {
                value[0] = v * 60000L + (value[0] % 60000L);
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(labelled(a, "Seconds", Ui.stepper(a, (int) ((value[0] % 60000L) / 1000L), 0, 55, 5, "",
                new Ui.OnValue() {
            public void set(int v) {
                value[0] = (value[0] / 60000L) * 60000L + v * 1000L;
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(Ui.gap(a, 6));
    }

    // ---- position inside a track ----------------------------------------
    public static void position(final Activity a, String title, long ms, long maxMs, final OnMs cb) {
        final long[] value = { Math.max(0, ms) };
        final long cap = maxMs > 0 ? maxMs : 24L * 3600000L;

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 18);
        box.setPadding(p, Ui.dp(a, 8), p, 0);

        final TextView shown = Ui.tv(a, Fmt.ms(value[0]), 30, Ui.ACC_TXT, true);
        shown.setGravity(Gravity.CENTER);
        shown.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
        box.addView(shown);
        if (maxMs > 0) {
            TextView cap2 = Ui.tv(a, "track is " + Fmt.ms(maxMs) + " long", 11.5f, Ui.DIM, false);
            cap2.setGravity(Gravity.CENTER);
            cap2.setLayoutParams(Ui.lp(Ui.MATCH, Ui.WRAP));
            box.addView(cap2);
        }

        box.addView(labelled(a, "Minutes", Ui.stepper(a, (int) (value[0] / 60000L), 0, (int) (cap / 60000L) + 1, 1, "", new Ui.OnValue() {
            public void set(int v) {
                value[0] = Math.min(cap, v * 60000L + (value[0] % 60000L));
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(labelled(a, "Seconds", Ui.stepper(a, (int) ((value[0] % 60000L) / 1000L), 0, 59, 1, "", new Ui.OnValue() {
            public void set(int v) {
                value[0] = Math.min(cap, (value[0] / 60000L) * 60000L + v * 1000L);
                shown.setText(Fmt.ms(value[0]));
            }
        })));
        box.addView(Ui.gap(a, 6));

        Ui.dialog(a).setTitle(title).setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Set", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) { cb.picked(value[0]); }
                }).show();
    }

    // ---- text ------------------------------------------------------------
    public static void text(final Activity a, String title, String value, String hint, final OnText cb) {
        final EditText in = new EditText(a);
        in.setSingleLine(true);
        in.setHint(hint);
        in.setText(value == null ? "" : value);
        in.setSelectAllOnFocus(true);
        in.selectAll();          // typing replaces the suggestion instead of appending
        in.setTextColor(Ui.TXT);
        in.setHintTextColor(Ui.DIM);
        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 20);
        box.setPadding(p, Ui.dp(a, 8), p, 0);
        box.addView(in);
        Ui.dialog(a).setTitle(title).setView(box)
                .setNegativeButton("Cancel", null)
                .setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        String s = in.getText().toString().trim();
                        if (s.length() == 0) { Ui.toast(a, "Give it a name"); return; }
                        cb.picked(s);
                    }
                }).show();
    }

    private static View labelled(Activity a, String label, View control) {
        LinearLayout r = Ui.row(a);
        Ui.margin(a, r, 0, 6, 0, 0);
        TextView t = Ui.tv(a, label, 13.5f, Ui.DIM, false);
        t.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        r.addView(t);
        control.setLayoutParams(Ui.lp(Ui.dp(a, 170), Ui.WRAP));
        r.addView(control);
        return r;
    }
}
