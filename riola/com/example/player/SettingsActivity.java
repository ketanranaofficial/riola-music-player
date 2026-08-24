package com.example.player;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class SettingsActivity extends Activity {

    static final String PREFS = "player_prefs";
    static final String K_AUTO_SAVE = "auto_save";
    static final String K_KEEP_SCREEN = "keep_screen_on";
    static final String K_NOTIFS = "notifications";
    static final String K_SLEEP_MIN = "default_sleep_min";

    static SharedPreferences sp(Context ctx) {
        return ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    static boolean autoSave(Context ctx) {
        return sp(ctx).getBoolean(K_AUTO_SAVE, true);
    }

    static boolean keepScreenOn(Context ctx) {
        return sp(ctx).getBoolean(K_KEEP_SCREEN, true);
    }

    static boolean notificationsEnabled(Context ctx) {
        return sp(ctx).getBoolean(K_NOTIFS, true);
    }

    static int defaultSleepMin(Context ctx) {
        return sp(ctx).getInt(K_SLEEP_MIN, 0);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        float density = getResources().getDisplayMetrics().density;
        int pad = Math.round(16f * density);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);

        addCheck(root, "Auto-save programs", K_AUTO_SAVE);
        addCheck(root, "Keep screen on during playback", K_KEEP_SCREEN);
        addCheck(root, "Show playback notification", K_NOTIFS);

        LinearLayout sleepRow = new LinearLayout(this);
        sleepRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView sl = new TextView(this);
        sl.setText("Default sleep timer (minutes, 0 = none):");
        final EditText sleepEdit = new EditText(this);
        sleepEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        sleepEdit.setText(String.valueOf(defaultSleepMin(this)));
        sleepRow.addView(sl, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        sleepRow.addView(sleepEdit, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        root.addView(sleepRow);

        Button applySleep = new Button(this);
        applySleep.setText("Apply default sleep timer");
        applySleep.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int m = parseInt(sleepEdit.getText().toString(), 0);
                if (m < 0) m = 0;
                sp(SettingsActivity.this).edit().putInt(K_SLEEP_MIN, m).apply();
                Toast.makeText(SettingsActivity.this, "Default sleep: " + m + " min", Toast.LENGTH_SHORT).show();
            }
        });
        root.addView(applySleep);

        Button back = new Button(this);
        back.setText("Back");
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        root.addView(back);

        setContentView(root);
    }

    private void addCheck(LinearLayout root, String label, String key) {
        CheckBox cb = new CheckBox(this);
        cb.setText(label);
        cb.setTag(key);
        cb.setChecked(sp(this).getBoolean(key, true));
        cb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                sp(SettingsActivity.this).edit()
                        .putBoolean((String) buttonView.getTag(), isChecked).apply();
            }
        });
        root.addView(cb);
    }

    private static int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }
}
