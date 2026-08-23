package com.example.player;

import android.content.Context;
import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;

public class SettingsActivity extends PreferenceActivity {

    static final String PREFS = "player_prefs";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        PreferenceManager pm = getPreferenceManager();
        pm.setSharedPreferencesName(PREFS);
        pm.setSharedPreferencesMode(MODE_PRIVATE);
        addPreferencesFromResource(R.xml.preferences);
    }

    static boolean notificationsEnabled(Context ctx) {
        return PreferenceManager.getDefaultSharedPreferences(ctx)
                .getBoolean("notifications", true);
    }

    static boolean keepScreenOn(Context ctx) {
        return PreferenceManager.getDefaultSharedPreferences(ctx)
                .getBoolean("keep_screen_on", true);
    }

    static boolean autoSave(Context ctx) {
        return PreferenceManager.getDefaultSharedPreferences(ctx)
                .getBoolean("auto_save", true);
    }
}
