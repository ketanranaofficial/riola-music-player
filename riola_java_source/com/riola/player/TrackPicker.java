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
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public final class TrackPicker {

    public interface OnPicked {
        void picked(List<Track> list);
    }

    private TrackPicker() {
    }

    public static void show(final Activity activity, String str, final boolean z, final OnPicked onPicked) {
        if (!Store.LIB.isEmpty()) {
            final Prefs prefs = new Prefs(activity);
            final String[] strArr = {""};
            final boolean[] zArr = {false};
            final LinkedHashSet linkedHashSet = new LinkedHashSet();
            final AlertDialog[] alertDialogArr = new AlertDialog[1];
            LinearLayout linearLayoutCol = Ui.col(activity);
            int iDp = Ui.dp(activity, 14.0f);
            linearLayoutCol.setPadding(iDp, Ui.dp(activity, 6.0f), iDp, 0);
            LinearLayout linearLayoutRow = Ui.row(activity);
            EditText editText = new EditText(activity);
            editText.setHint("Search");
            editText.setSingleLine(true);
            editText.setTextSize(13.0f);
            editText.setTextColor(Ui.TXT);
            editText.setHintTextColor(Ui.DIM);
            editText.setBackground(Ui.rrs(activity, Ui.FIELD, Ui.LINE, Ui.RAD_BTN, Ui.STROKE_W));
            int iDp2 = Ui.dp(activity, 10.0f);
            editText.setPadding(iDp2, iDp2, iDp2, iDp2);
            editText.setLayoutParams(Ui.lpw(0, -2, 1.0f));
            linearLayoutRow.addView(editText);
            final LinearLayout linearLayoutCol2 = Ui.col(activity);
            final TextView textViewTv = Ui.tv(activity, "", 11.5f, Ui.DIM, false);
            final Runnable[] runnableArr = new Runnable[1];
            linearLayoutRow.addView(Ui.iconBtn(activity, 21, Ui.DIM, 16, "Sort", new View.OnClickListener() { // from class: com.riola.player.TrackPicker.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.dialog(activity).setTitle("Sort").setItems(Store.SORTS, new DialogInterface.OnClickListener() { // from class: com.riola.player.TrackPicker.2.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            prefs.librarySort(i);
                            runnableArr[0].run();
                        }
                    }).show();
                }
            }));
            linearLayoutCol.addView(linearLayoutRow);
            Ui.margin(activity, textViewTv, 2.0f, 6.0f, 0.0f, 6.0f);
            linearLayoutCol.addView(textViewTv);
            ScrollView scrollView = new ScrollView(activity);
            scrollView.setLayoutParams(Ui.lp(-1, (int) (activity.getResources().getDisplayMetrics().heightPixels * 0.52f)));
            scrollView.addView(linearLayoutCol2, new FrameLayout.LayoutParams(-1, -2));
            linearLayoutCol.addView(scrollView);
            linearLayoutCol.addView(Ui.gap(activity, 8.0f));
            runnableArr[0] = new Runnable() { // from class: com.riola.player.TrackPicker.3
                @Override // java.lang.Runnable
                public void run() {
                    linearLayoutCol2.removeAllViews();
                    List<Track> listView = Store.view(prefs.librarySort(), strArr[0]);
                    String lowerCase = Store.SORTS[Math.max(0, Math.min(prefs.librarySort(), Store.SORTS.length - 1))].toLowerCase();
                    if (zArr[0]) {
                        textViewTv.setText(linkedHashSet.size() + " selected  .  tap to add or remove");
                    } else if (z) {
                        textViewTv.setText(listView.size() + " of " + Store.LIB.size() + "  .  " + lowerCase + "  .  hold a row to pick several");
                    } else {
                        textViewTv.setText(listView.size() + " of " + Store.LIB.size() + "  .  " + lowerCase);
                    }
                    if (listView.isEmpty()) {
                        linearLayoutCol2.addView(Ui.tv(activity, "Nothing matches that.", 13.0f, Ui.DIM, false));
                        return;
                    }
                    for (int i = 0; i < listView.size(); i++) {
                        linearLayoutCol2.addView(TrackPicker.row(activity, listView.get(i), z, zArr, linkedHashSet, alertDialogArr, onPicked, runnableArr[0]));
                    }
                }
            };
            editText.addTextChangedListener(new TextWatcher() { // from class: com.riola.player.TrackPicker.4
                @Override // android.text.TextWatcher
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }

                @Override // android.text.TextWatcher
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }

                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    strArr[0] = editable.toString();
                    runnableArr[0].run();
                }
            });
            runnableArr[0].run();
            AlertDialog.Builder neutralButton = Ui.dialog(activity).setTitle(str).setView(linearLayoutCol).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null).setNeutralButton("Manage tracks", new DialogInterface.OnClickListener() { // from class: com.riola.player.TrackPicker.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    activity.startActivity(new Intent(activity, (Class<?>) LibraryActivity.class));
                }
            });
            if (z) {
                neutralButton.setPositiveButton("Add selected", new DialogInterface.OnClickListener() { // from class: com.riola.player.TrackPicker.6
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        ArrayList arrayList = new ArrayList();
                        Iterator it = linkedHashSet.iterator();
                        while (it.hasNext()) {
                            Track trackByKey = Store.byKey((String) it.next());
                            if (trackByKey != null) {
                                arrayList.add(trackByKey);
                            }
                        }
                        if (!arrayList.isEmpty()) {
                            onPicked.picked(arrayList);
                        } else {
                            Ui.toast(activity, "Nothing was selected");
                        }
                    }
                });
            }
            AlertDialog alertDialogCreate = neutralButton.create();
            alertDialogArr[0] = alertDialogCreate;
            alertDialogCreate.show();
            return;
        }
        Ui.dialog(activity).setTitle("No tracks yet").setMessage("Add some audio first and it will show up here.").setNegativeButton("Not now", (DialogInterface.OnClickListener) null).setPositiveButton("Add tracks", new DialogInterface.OnClickListener() { // from class: com.riola.player.TrackPicker.1
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                activity.startActivity(new Intent(activity, (Class<?>) LibraryActivity.class));
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static View row(Activity activity, final Track track, final boolean z, final boolean[] zArr, final Set<String> set, final AlertDialog[] alertDialogArr, final OnPicked onPicked, final Runnable runnable) {
        final String strKey = track.key();
        boolean zContains = set.contains(strKey);
        LinearLayout linearLayoutRow = Ui.row(activity);
        linearLayoutRow.setBackground(Ui.ripple(zContains ? Ui.rrs(activity, Ui.ACC_SOFT, Ui.ACC_TXT, Ui.RAD_BTN, 1.2f) : Ui.rr(activity, Ui.SURF2, Ui.RAD_BTN)));
        linearLayoutRow.setPadding(Ui.dp(activity, 6.0f), Ui.dp(activity, 9.0f), Ui.dp(activity, 12.0f), Ui.dp(activity, 9.0f));
        Ui.margin(activity, linearLayoutRow, 0.0f, 0.0f, 0.0f, 6.0f);
        linearLayoutRow.addView(Ui.iconBtn(activity, zContains ? 16 : 14, zContains ? Ui.ACC_TXT : Ui.DIM, 16, zContains ? "Selected" : "Select this track", new View.OnClickListener() { // from class: com.riola.player.TrackPicker.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (z) {
                    Ui.buzz(view);
                    zArr[0] = true;
                    if (!set.remove(strKey)) {
                        set.add(strKey);
                    }
                    runnable.run();
                }
            }
        }));
        LinearLayout linearLayoutCol = Ui.col(activity);
        linearLayoutCol.setLayoutParams(Ui.lpw(0, -2, 1.0f));
        TextView textViewTv = Ui.tv(activity, track.shortTitle(), 14.0f, Ui.TXT, false);
        Ui.ellipsize(textViewTv);
        linearLayoutCol.addView(textViewTv);
        linearLayoutCol.addView(Ui.tv(activity, (track.durMs > 0 ? Fmt.ms(track.durMs) : "length unknown") + (track.isVideo() ? "  .  video, audio only" : ""), 11.0f, Ui.DIM, false));
        linearLayoutRow.addView(linearLayoutCol);
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.TrackPicker.8
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (z && zArr[0]) {
                    if (!set.remove(strKey)) {
                        set.add(strKey);
                    }
                    runnable.run();
                } else {
                    ArrayList arrayList = new ArrayList();
                    arrayList.add(track);
                    AlertDialog alertDialog = alertDialogArr[0];
                    if (alertDialog != null) {
                        alertDialog.dismiss();
                    }
                    onPicked.picked(arrayList);
                }
            }
        });
        linearLayoutRow.setOnLongClickListener(new View.OnLongClickListener() { // from class: com.riola.player.TrackPicker.9
            @Override // android.view.View.OnLongClickListener
            public boolean onLongClick(View view) {
                if (!z) {
                    return false;
                }
                Ui.buzz(view);
                zArr[0] = true;
                if (!set.remove(strKey)) {
                    set.add(strKey);
                }
                runnable.run();
                return true;
            }
        });
        return linearLayoutRow;
    }
}
