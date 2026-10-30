package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;

import java.util.ArrayList;
import java.util.List;

/**
 * Starts a program. Before any sound comes out it checks that every track the
 * program needs can still be opened, so a file that vanished is reported now
 * rather than silently skipped twenty minutes into a session.
 */
public final class Runner {

    public interface OnStarted { void started(); }

    private Runner() { }

    public static void play(final Activity a, final Program p, final int from, final OnStarted cb) {
        if (p == null) return;
        if (p.enabledCount() == 0) {
            Ui.toast(a, "Add a step first");
            return;
        }
        new Thread(new Runnable() {
            public void run() {
                final List<String> bad = new ArrayList<String>();
                // a program often uses the same file many times over; opening it
                // once per step would be pointless io
                java.util.HashMap<String, Boolean> seen = new java.util.HashMap<String, Boolean>();
                int playable = 0;
                for (int i = 0; i < p.steps.size(); i++) {
                    Step s = p.steps.get(i);
                    if (!s.enabled) continue;
                    if (!s.needsTrack()) { playable++; continue; }
                    Boolean known = seen.get(s.trackUri);
                    if (known == null) {
                        known = Boolean.valueOf(s.track() != null && Store.readable(a, s.trackUri));
                        seen.put(s.trackUri, known);
                    }
                    if (!known.booleanValue()) {
                        String name = s.trackName == null || s.trackName.length() == 0
                                ? "unknown track" : s.trackName;
                        bad.add("Step " + (i + 1) + "  -  " + name);
                    } else {
                        playable++;
                    }
                }
                final int ok = playable;
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    public void run() {
                        if (a.isFinishing() || a.isDestroyed()) return;
                        if (bad.isEmpty()) go(a, p, from, cb);
                        else warn(a, p, from, bad, ok, cb);
                    }
                });
            }
        }, "riola-precheck").start();
    }

    private static void warn(final Activity a, final Program p, final int from,
                             List<String> bad, int playable, final OnStarted cb) {
        StringBuilder sb = new StringBuilder();
        sb.append(playable == 0
                ? "Nothing in this program can play right now:\n\n"
                : "These steps cannot play, so they will be skipped:\n\n");
        for (int i = 0; i < bad.size() && i < 6; i++) sb.append("    ").append(bad.get(i)).append('\n');
        if (bad.size() > 6) sb.append("    ...and ").append(bad.size() - 6).append(" more\n");
        sb.append("\nThe file may have been deleted or moved, or it lives on storage that is not available. "
                + "Open the program and point those steps at a file again.");

        AlertDialog.Builder b = Ui.dialog(a)
                .setTitle(bad.size() == 1 ? "1 step cannot play" : (bad.size() + " steps cannot play"))
                .setMessage(sb.toString())
                .setNegativeButton("Cancel", null);

        if (!(a instanceof EditorActivity)) {
            b.setNeutralButton("Open program", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface d, int w) {
                    a.startActivity(new Intent(a, EditorActivity.class).putExtra("id", p.id));
                }
            });
        }
        if (playable > 0) {
            b.setPositiveButton("Play anyway", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface d, int w) { go(a, p, from, cb); }
            });
        }
        b.show();
    }

    private static void go(Activity a, Program p, int from, OnStarted cb) {
        askNotificationPermission(a);
        p.lastRun = System.currentTimeMillis();
        Store.savePrograms(a);
        Engine.get(a).start(p, from);
        PlayerBar.startService(a);
        if (cb != null) cb.started();
        explainSilentNotifications(a);
    }

    /**
     * On some phones the runtime prompt never appears, because notifications
     * are already switched off for the app - several skins do that to
     * sideloaded apps. Playback still works, but there would be no
     * notification and no lock screen controls and no hint as to why, so say
     * it once and offer the settings page.
     */
    private static void explainSilentNotifications(final Activity a) {
        final Prefs prefs = new Prefs(a);
        if (prefs.notifNagged()) return;
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            public void run() {
                if (a.isFinishing() || a.isDestroyed()) return;
                NotificationManager nm = (NotificationManager) a.getSystemService(Context.NOTIFICATION_SERVICE);
                if (nm == null || nm.areNotificationsEnabled()) return;
                prefs.notifNagged(true);
                Ui.dialog(a)
                        .setTitle("Notifications are off")
                        .setMessage("Riola cannot show its playback notification, so its controls will "
                                + "not appear in the notification shade. The program still plays "
                                + "normally, and your phone's own media controls may still work. "
                                + "Some phones switch notifications off for apps installed outside "
                                + "the store. You can turn them back on in Android settings.")
                        .setNegativeButton("Not now", null)
                        .setPositiveButton("Open settings", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface d, int w) {
                                try {
                                    a.startActivity(new Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                                            .putExtra(Settings.EXTRA_APP_PACKAGE, a.getPackageName()));
                                } catch (Exception e) {
                                    Ui.toast(a, "Could not open notification settings");
                                }
                            }
                        }).show();
            }
        }, 4000);
    }

    public static void askNotificationPermission(Activity a) {
        if (Build.VERSION.SDK_INT >= 33
                && a.checkSelfPermission("android.permission.POST_NOTIFICATIONS")
                   != PackageManager.PERMISSION_GRANTED) {
            a.requestPermissions(new String[]{ "android.permission.POST_NOTIFICATIONS" }, 103);
        }
    }
}
