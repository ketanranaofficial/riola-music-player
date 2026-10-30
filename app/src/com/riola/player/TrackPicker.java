package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Choosing tracks with the same handles the library screen has - search and
 * sort - because a list that is fine at five tracks is useless at three
 * hundred.
 *
 * Tap the icon at the left of a row, or hold a row, to start picking several
 * at once.
 */
public final class TrackPicker {

    public interface OnPicked { void picked(List<Track> tracks); }

    private TrackPicker() { }

    public static void show(final Activity a, String title, final boolean allowMultiple,
                            final OnPicked cb) {
        if (Store.LIB.isEmpty()) {
            Ui.dialog(a).setTitle("No tracks yet")
                    .setMessage("Add some audio first and it will show up here.")
                    .setNegativeButton("Not now", null)
                    .setPositiveButton("Add tracks", new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface d, int w) {
                            a.startActivity(new Intent(a, LibraryActivity.class));
                        }
                    }).show();
            return;
        }

        final Prefs prefs = new Prefs(a);
        final String[] filter = { "" };
        final boolean[] choosing = { false };
        final Set<String> chosen = new LinkedHashSet<String>();   // keys, in the order tapped
        final AlertDialog[] holder = new AlertDialog[1];

        LinearLayout box = Ui.col(a);
        int p = Ui.dp(a, 14);
        box.setPadding(p, Ui.dp(a, 6), p, 0);

        // search and sort, side by side
        LinearLayout tools = Ui.row(a);
        final EditText search = new EditText(a);
        search.setHint("Search");
        search.setSingleLine(true);
        search.setTextSize(13);
        search.setTextColor(Ui.TXT);
        search.setHintTextColor(Ui.DIM);
        search.setBackground(Ui.rrs(a, Ui.FIELD, Ui.LINE, Ui.RAD_BTN, Ui.STROKE_W));
        int sp = Ui.dp(a, 10);
        search.setPadding(sp, sp, sp, sp);
        search.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        tools.addView(search);

        final LinearLayout list = Ui.col(a);
        final TextView countLabel = Ui.tv(a, "", 11.5f, Ui.DIM, false);

        final Runnable[] fill = new Runnable[1];

        tools.addView(Ui.iconBtn(a, Ico.LIST, Ui.DIM, 16, "Sort", new View.OnClickListener() {
            public void onClick(View v) {
                Ui.dialog(a).setTitle("Sort").setItems(Store.SORTS, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int which) {
                        prefs.librarySort(which);
                        fill[0].run();
                    }
                }).show();
            }
        }));
        box.addView(tools);

        Ui.margin(a, countLabel, 2, 6, 0, 6);
        box.addView(countLabel);

        ScrollView scroll = new ScrollView(a);
        int height = (int) (a.getResources().getDisplayMetrics().heightPixels * 0.52f);
        scroll.setLayoutParams(Ui.lp(Ui.MATCH, height));
        scroll.addView(list, new FrameLayout.LayoutParams(Ui.MATCH, Ui.WRAP));
        box.addView(scroll);
        box.addView(Ui.gap(a, 8));

        fill[0] = new Runnable() {
            public void run() {
                list.removeAllViews();
                List<Track> view = Store.view(prefs.librarySort(), filter[0]);

                String sortName = Store.SORTS[Math.max(0, Math.min(prefs.librarySort(),
                        Store.SORTS.length - 1))].toLowerCase();
                if (choosing[0]) {
                    countLabel.setText(chosen.size() + " selected  .  tap to add or remove");
                } else if (allowMultiple) {
                    countLabel.setText(view.size() + " of " + Store.LIB.size() + "  .  " + sortName
                            + "  .  hold a row to pick several");
                } else {
                    countLabel.setText(view.size() + " of " + Store.LIB.size() + "  .  " + sortName);
                }

                if (view.isEmpty()) {
                    list.addView(Ui.tv(a, "Nothing matches that.", 13, Ui.DIM, false));
                    return;
                }
                for (int i = 0; i < view.size(); i++) {
                    list.addView(row(a, view.get(i), allowMultiple, choosing, chosen, holder, cb, fill[0]));
                }
            }
        };

        search.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int x, int y, int z) { }
            public void onTextChanged(CharSequence s, int x, int y, int z) { }
            public void afterTextChanged(Editable e) {
                filter[0] = e.toString();
                fill[0].run();
            }
        });
        fill[0].run();

        AlertDialog.Builder b = Ui.dialog(a).setTitle(title).setView(box)
                .setNegativeButton("Cancel", null)
                .setNeutralButton("Manage tracks", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int w) {
                        a.startActivity(new Intent(a, LibraryActivity.class));
                    }
                });
        if (allowMultiple) {
            b.setPositiveButton("Add selected", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface d, int w) {
                    List<Track> out = new ArrayList<Track>();
                    for (String key : chosen) {
                        Track t = Store.byKey(key);
                        if (t != null) out.add(t);
                    }
                    if (out.isEmpty()) Ui.toast(a, "Nothing was selected");
                    else cb.picked(out);
                }
            });
        }
        holder[0] = b.create();
        holder[0].show();
    }

    private static View row(final Activity a, final Track t, final boolean allowMultiple,
                            final boolean[] choosing, final Set<String> chosen,
                            final AlertDialog[] holder, final OnPicked cb, final Runnable again) {
        final String key = t.key();
        final boolean selected = chosen.contains(key);

        LinearLayout r = Ui.row(a);
        r.setBackground(Ui.ripple(selected
                ? Ui.rrs(a, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_BTN, 1.2f)
                : Ui.rr(a, Ui.SURF2, Ui.RAD_BTN)));
        r.setPadding(Ui.dp(a, 6), Ui.dp(a, 9), Ui.dp(a, 12), Ui.dp(a, 9));
        Ui.margin(a, r, 0, 0, 0, 6);

        // the icon is its own target: tapping it starts a multiple selection
        View mark = Ui.iconBtn(a, selected ? Ico.CHECK : Ico.NOTE,
                selected ? Ui.ACC_TXT : Ui.DIM, 16,
                selected ? "Selected" : "Select this track", new View.OnClickListener() {
            public void onClick(View v) {
                if (!allowMultiple) return;
                Ui.buzz(v);
                choosing[0] = true;
                if (!chosen.remove(key)) chosen.add(key);
                again.run();
            }
        });
        r.addView(mark);

        LinearLayout col = Ui.col(a);
        col.setLayoutParams(Ui.lpw(0, Ui.WRAP, 1f));
        TextView name = Ui.tv(a, t.shortTitle(), 14, Ui.TXT, false);
        Ui.ellipsize(name);
        col.addView(name);
        col.addView(Ui.tv(a, (t.durMs > 0 ? Fmt.ms(t.durMs) : "length unknown")
                + (t.isVideo() ? "  .  video, audio only" : ""), 11, Ui.DIM, false));
        r.addView(col);

        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (allowMultiple && choosing[0]) {
                    if (!chosen.remove(key)) chosen.add(key);
                    again.run();
                    return;
                }
                List<Track> one = new ArrayList<Track>();
                one.add(t);
                if (holder[0] != null) holder[0].dismiss();
                cb.picked(one);
            }
        });
        r.setOnLongClickListener(new View.OnLongClickListener() {
            public boolean onLongClick(View v) {
                if (!allowMultiple) return false;
                Ui.buzz(v);
                choosing[0] = true;
                if (!chosen.remove(key)) chosen.add(key);
                again.run();
                return true;
            }
        });
        return r;
    }
}
