package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.NotificationManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class Runner {

    public interface OnStarted {
        void started();
    }

    private Runner() {
    }

    public static void play(final Activity activity, final Program program, final int i, final OnStarted onStarted) {
        if (program == null) {
            return;
        }
        if (program.enabledCount() == 0) {
            Ui.toast(activity, "Add a step first");
        } else {
            new Thread(new Runnable() { // from class: com.riola.player.Runner.1
                @Override // java.lang.Runnable
                public void run() {
                    final ArrayList arrayList = new ArrayList();
                    HashMap map = new HashMap();
                    final int i2 = 0;
                    for (int i3 = 0; i3 < program.steps.size(); i3++) {
                        Step step = program.steps.get(i3);
                        if (step.enabled) {
                            if (step.needsTrack()) {
                                Boolean boolValueOf = (Boolean) map.get(step.trackUri);
                                if (boolValueOf == null) {
                                    boolValueOf = Boolean.valueOf(step.track() != null && Store.readable(activity, step.trackUri));
                                    map.put(step.trackUri, boolValueOf);
                                }
                                if (!boolValueOf.booleanValue()) {
                                    arrayList.add("Step " + (i3 + 1) + "  -  " + ((step.trackName == null || step.trackName.length() == 0) ? "unknown track" : step.trackName));
                                } else {
                                    i2++;
                                }
                            } else {
                                i2++;
                            }
                        }
                    }
                    new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.riola.player.Runner.1.1
                        @Override // java.lang.Runnable
                        public void run() {
                            if (activity.isFinishing() || activity.isDestroyed()) {
                                return;
                            }
                            if (arrayList.isEmpty()) {
                                Runner.go(activity, program, i, onStarted);
                            } else {
                                Runner.warn(activity, program, i, arrayList, i2, onStarted);
                            }
                        }
                    });
                }
            }, "riola-precheck").start();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void warn(final Activity activity, final Program program, final int i, List<String> list, int i2, final OnStarted onStarted) {
        String str;
        StringBuilder sb = new StringBuilder();
        if (i2 == 0) {
            str = "Nothing in this program can play right now:\n\n";
        } else {
            str = "These steps cannot play, so they will be skipped:\n\n";
        }
        sb.append(str);
        for (int i3 = 0; i3 < list.size() && i3 < 6; i3++) {
            sb.append("    ").append(list.get(i3)).append('\n');
        }
        if (list.size() > 6) {
            sb.append("    ...and ").append(list.size() - 6).append(" more\n");
        }
        sb.append("\nThe file may have been deleted or moved, or it lives on storage that is not available. Open the program and point those steps at a file again.");
        AlertDialog.Builder negativeButton = Ui.dialog(activity).setTitle(list.size() == 1 ? "1 step cannot play" : list.size() + " steps cannot play").setMessage(sb.toString()).setNegativeButton("Cancel", (DialogInterface.OnClickListener) null);
        if (!(activity instanceof EditorActivity)) {
            negativeButton.setNeutralButton("Open program", new DialogInterface.OnClickListener() { // from class: com.riola.player.Runner.2
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i4) {
                    activity.startActivity(new Intent(activity, (Class<?>) EditorActivity.class).putExtra("id", program.id));
                }
            });
        }
        if (i2 > 0) {
            negativeButton.setPositiveButton("Play anyway", new DialogInterface.OnClickListener() { // from class: com.riola.player.Runner.3
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i4) {
                    Runner.go(activity, program, i, onStarted);
                }
            });
        }
        negativeButton.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void go(Activity activity, Program program, int i, OnStarted onStarted) {
        askNotificationPermission(activity);
        program.lastRun = System.currentTimeMillis();
        Store.savePrograms(activity);
        Engine.get(activity).start(program, i);
        PlayerBar.startService(activity);
        if (onStarted != null) {
            onStarted.started();
        }
        explainSilentNotifications(activity);
    }

    private static void explainSilentNotifications(final Activity activity) {
        final Prefs prefs = new Prefs(activity);
        if (prefs.notifNagged()) {
            return;
        }
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() { // from class: com.riola.player.Runner.4
            @Override // java.lang.Runnable
            public void run() {
                NotificationManager notificationManager;
                if (activity.isFinishing() || activity.isDestroyed() || (notificationManager = (NotificationManager) activity.getSystemService("notification")) == null || notificationManager.areNotificationsEnabled()) {
                    return;
                }
                prefs.notifNagged(true);
                Ui.dialog(activity).setTitle("Notifications are off").setMessage("Riola cannot show its playback notification, so its controls will not appear in the notification shade. The program still plays normally, and your phone's own media controls may still work. Some phones switch notifications off for apps installed outside the store. You can turn them back on in Android settings.").setNegativeButton("Not now", (DialogInterface.OnClickListener) null).setPositiveButton("Open settings", new DialogInterface.OnClickListener() { // from class: com.riola.player.Runner.4.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        try {
                            activity.startActivity(new Intent("android.settings.APP_NOTIFICATION_SETTINGS").putExtra("android.provider.extra.APP_PACKAGE", activity.getPackageName()));
                        } catch (Exception e) {
                            Ui.toast(activity, "Could not open notification settings");
                        }
                    }
                }).show();
            }
        }, 4000L);
    }

    public static void askNotificationPermission(Activity activity) {
        if (Build.VERSION.SDK_INT >= 33 && activity.checkSelfPermission("android.permission.POST_NOTIFICATIONS") != 0) {
            activity.requestPermissions(new String[]{"android.permission.POST_NOTIFICATIONS"}, 103);
        }
    }
}
