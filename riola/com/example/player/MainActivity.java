package com.example.player;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.OpenableColumns;
import android.text.InputType;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class MainActivity extends Activity {

    private static final int REQ_PICK_TRACKS = 41;
    private static final int REQ_EXPORT = 42;
    private static final int REQ_IMPORT = 43;
    private static final int REQ_POST_NOTIFICATIONS = 44;

    private final List<Uri> tracks = new ArrayList<Uri>();
    private final List<String> trackNames = new ArrayList<String>();
    private List<Program> programs = new ArrayList<Program>();
    private int currentProgramIndex = 0;
    private boolean ignoreSpinner = false;
    private boolean running = false;

    private TextView trackListView;
    private TextView programListView;
    private TextView statusView;
    private TextView positionView;
    private SeekBar volumeSeekBar;

    private Spinner programSpinner;
    private Spinner cmdSpinner;
    private Spinner trackSpinner;
    private Spinner sectionModeSpinner;
    private CheckBox shuffleCheck;
    private LinearLayout sectionTimeRow;
    private LinearLayout sectionModeRow;
    private EditText nEdit;
    private EditText repeatEdit;
    private EditText sleepEdit;
    private EditText startMinEdit;
    private EditText startSecEdit;
    private EditText endMinEdit;
    private EditText endSecEdit;
    private Button runButton;
    private Button stopButton;
    private Button addButton;
    private Button clearButton;
    private Button newButton;
    private Button deleteButton;
    private Button exportButton;
    private Button importButton;
    private Button settingsButton;
    private Button shuffleAllButton;

    private AudioManager audio;

    private final BroadcastReceiver statusReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context ctx, Intent i) {
            String a = i.getAction();
            if (PlayerService.BROADCAST_STATUS.equals(a)) {
                statusView.setText(i.getStringExtra("status"));
                boolean playing = i.getBooleanExtra("playing", false);
                int pos = i.getIntExtra("pos", 0);
                int dur = i.getIntExtra("dur", 0);
                positionView.setText(playing ? (fmtTime(pos) + " / " + fmtTime(dur)) : "");
            } else if (PlayerService.BROADCAST_FINISHED.equals(a)) {
                running = false;
                runButton.setEnabled(true);
                stopButton.setEnabled(false);
                setBuilderEnabled(true);
                positionView.setText("");
                statusView.setText("Idle.");
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        audio = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        if (SettingsActivity.keepScreenOn(this)) {
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
        float density = getResources().getDisplayMetrics().density;
        int pad = Math.round(16f * density);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setPadding(pad, pad, pad, pad);
        ScrollView scroller = new ScrollView(this);
        scroller.addView(root);
        setContentView(scroller);

        TextView title = new TextView(this);
        title.setText("Programmable Player");
        title.setTextSize(20f);
        title.setGravity(Gravity.CENTER);
        title.setPadding(0, 0, 0, Math.round(8f * density));
        root.addView(title);

        Button pickButton = new Button(this);
        pickButton.setText("Select Tracks");
        pickButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                launchPicker();
            }
        });
        root.addView(pickButton);

        trackListView = new TextView(this);
        trackListView.setText("No tracks loaded.\n");
        ScrollView trackScroller = new ScrollView(this);
        trackScroller.addView(trackListView);
        root.addView(trackScroller, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(120f * density)));

        LinearLayout progBar = new LinearLayout(this);
        progBar.setOrientation(LinearLayout.HORIZONTAL);
        programSpinner = new Spinner(this);
        programSpinner.setPrompt("Programs");
        programSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                if (!ignoreSpinner) switchProgram(pos);
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        LinearLayout.LayoutParams half = new LinearLayout.LayoutParams(0,
                ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        progBar.addView(programSpinner, half);
        newButton = new Button(this);
        newButton.setText("New");
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                newProgram();
            }
        });
        progBar.addView(newButton, half);
        deleteButton = new Button(this);
        deleteButton.setText("Delete");
        deleteButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteProgram();
            }
        });
        progBar.addView(deleteButton, half);
        root.addView(progBar);

        LinearLayout progActions = new LinearLayout(this);
        progActions.setOrientation(LinearLayout.HORIZONTAL);
        exportButton = new Button(this);
        exportButton.setText("Export");
        exportButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                exportProgram();
            }
        });
        importButton = new Button(this);
        importButton.setText("Import");
        importButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                importProgram();
            }
        });
        settingsButton = new Button(this);
        settingsButton.setText("Settings");
        settingsButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, SettingsActivity.class));
            }
        });
        progActions.addView(exportButton, half);
        progActions.addView(importButton, half);
        progActions.addView(settingsButton, half);
        root.addView(progActions);

        TextView builderTitle = new TextView(this);
        builderTitle.setText("Build program (visual):");
        builderTitle.setTextSize(15f);
        root.addView(builderTitle);

        LinearLayout cmdRow = new LinearLayout(this);
        cmdRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView cmdLabel = new TextView(this);
        cmdLabel.setText("Command");
        cmdSpinner = new Spinner(this);
        ArrayAdapter<String> cmdAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item,
                new ArrayList<String>(Arrays.asList("PLAY", "PAUSE", "LOOP", "SECTION")));
        cmdAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        cmdSpinner.setAdapter(cmdAdapter);
        cmdSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                applyFieldVisibility(pos);
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        cmdRow.addView(cmdLabel, half);
        cmdRow.addView(cmdSpinner, half);
        trackSpinner = new Spinner(this);
        refreshTrackSpinner();
        cmdRow.addView(trackSpinner, half);
        root.addView(cmdRow);

        LinearLayout nRow = new LinearLayout(this);
        nRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView nLabel = new TextView(this);
        nLabel.setText("N");
        nEdit = new EditText(this);
        nEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        nEdit.setText("1");
        nRow.addView(nLabel, half);
        nRow.addView(nEdit, half);
        root.addView(nRow);

        sectionTimeRow = new LinearLayout(this);
        sectionTimeRow.setOrientation(LinearLayout.VERTICAL);
        startMinEdit = newNumberEdit("0");
        startSecEdit = newNumberEdit("0");
        endMinEdit = newNumberEdit("0");
        endSecEdit = newNumberEdit("30");
        sectionTimeRow.addView(timeRow("Start", startMinEdit, startSecEdit, density));
        sectionTimeRow.addView(timeRow("End", endMinEdit, endSecEdit, density));
        root.addView(sectionTimeRow);

        sectionModeRow = new LinearLayout(this);
        sectionModeRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView modeLabel = new TextView(this);
        modeLabel.setText("Repeat mode");
        sectionModeSpinner = new Spinner(this);
        ArrayAdapter<String> modeAdapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item,
                new ArrayList<String>(Arrays.asList("FOR MINUTES", "N TIMES")));
        modeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sectionModeSpinner.setAdapter(modeAdapter);
        sectionModeRow.addView(modeLabel, half);
        sectionModeRow.addView(sectionModeSpinner, half);
        root.addView(sectionModeRow);

        LinearLayout repRow = new LinearLayout(this);
        repRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView repLabel = new TextView(this);
        repLabel.setText("Repeat program (0 = forever)");
        repeatEdit = new EditText(this);
        repeatEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        repeatEdit.setText("0");
        repRow.addView(repLabel, half);
        repRow.addView(repeatEdit, half);
        root.addView(repRow);

        LinearLayout optRow = new LinearLayout(this);
        optRow.setOrientation(LinearLayout.HORIZONTAL);
        TextView sleepLabel = new TextView(this);
        sleepLabel.setText("Sleep timer (min)");
        sleepEdit = new EditText(this);
        sleepEdit.setInputType(InputType.TYPE_CLASS_NUMBER);
        sleepEdit.setText(String.valueOf(SettingsActivity.defaultSleepMin(this)));
        shuffleCheck = new CheckBox(this);
        shuffleCheck.setText("Shuffle order");
        optRow.addView(sleepLabel, half);
        optRow.addView(sleepEdit, half);
        optRow.addView(shuffleCheck);
        root.addView(optRow);

        LinearLayout actionRow = new LinearLayout(this);
        actionRow.setOrientation(LinearLayout.HORIZONTAL);
        addButton = new Button(this);
        addButton.setText("Add to program");
        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addStep();
            }
        });
        clearButton = new Button(this);
        clearButton.setText("Clear program");
        clearButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                currentProgram().cmds.clear();
                refreshProgramList();
                setStatus("Program cleared.");
                autoSave();
            }
        });
        actionRow.addView(addButton, half);
        actionRow.addView(clearButton, half);
        root.addView(actionRow);

        shuffleAllButton = new Button(this);
        shuffleAllButton.setText("Shuffle program");
        shuffleAllButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                java.util.Collections.shuffle(currentProgram().cmds);
                refreshProgramList();
                setStatus("Shuffled.");
                autoSave();
            }
        });
        root.addView(shuffleAllButton);

        programListView = new TextView(this);
        programListView.setText("(no steps yet)\n");
        ScrollView programScroller = new ScrollView(this);
        programScroller.addView(programListView);
        root.addView(programScroller, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.round(180f * density)));

        TextView volLabel = new TextView(this);
        volLabel.setText("Media volume");
        root.addView(volLabel);
        volumeSeekBar = new SeekBar(this);
        int maxVol = audio.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
        volumeSeekBar.setMax(maxVol);
        volumeSeekBar.setProgress(audio.getStreamVolume(AudioManager.STREAM_MUSIC));
        volumeSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser) {
                    audio.setStreamVolume(AudioManager.STREAM_MUSIC, progress, AudioManager.FLAG_SHOW_UI);
                }
            }
            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });
        root.addView(volumeSeekBar, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        positionView = new TextView(this);
        positionView.setText("");
        positionView.setTextSize(13f);
        positionView.setTextColor(0xFF666666);
        root.addView(positionView);

        LinearLayout runRow = new LinearLayout(this);
        runRow.setOrientation(LinearLayout.HORIZONTAL);
        runButton = new Button(this);
        runButton.setText("Run Program");
        runButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                runProgram();
            }
        });
        stopButton = new Button(this);
        stopButton.setText("Stop");
        stopButton.setEnabled(false);
        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                stopProgram();
            }
        });
        runRow.addView(runButton, half);
        runRow.addView(stopButton, half);
        root.addView(runRow);

        statusView = new TextView(this);
        statusView.setText("Idle.");
        statusView.setTextSize(13f);
        root.addView(statusView);

        programs = Storage.loadPrograms(this);
        if (programs.isEmpty()) {
            programs.add(new Program("Program 1"));
        }
        currentProgramIndex = 0;
        refreshProgramSpinner();
        applyFieldVisibility(cmdSpinner.getSelectedItemPosition());
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
            audio.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_RAISE, AudioManager.FLAG_SHOW_UI);
            return true;
        }
        if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
            audio.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_LOWER, AudioManager.FLAG_SHOW_UI);
            return true;
        }
        if (keyCode == KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE) {
            togglePlayback();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onResume() {
        super.onResume();
        registerReceiver(statusReceiver, new IntentFilter(PlayerService.BROADCAST_STATUS));
        registerReceiver(statusReceiver, new IntentFilter(PlayerService.BROADCAST_FINISHED));
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            unregisterReceiver(statusReceiver);
        } catch (Exception ignored) {
        }
    }

    @Override
    protected void onDestroy() {
        if (running) {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_STOP);
            startService(si);
        }
        super.onDestroy();
    }

    private void togglePlayback() {
        if (running) {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_PAUSE);
            startService(si);
            setStatus("Pausing...");
        } else {
            Intent si = new Intent(this, PlayerService.class);
            si.setAction(PlayerService.ACTION_RESUME);
            startService(si);
        }
    }

    private void runProgram() {
        if (tracks.isEmpty()) {
            toastLong("Load at least one track first.");
            return;
        }
        if (currentProgram().cmds.isEmpty()) {
            toastShort("Add commands to the program first.");
            return;
        }
        requestNotificationPermissionIfNeeded();
        Intent si = new Intent(this, PlayerService.class);
        si.setAction(PlayerService.ACTION_PLAY);
        ArrayList<String> uris = new ArrayList<String>();
        for (Uri u : tracks) uris.add(u.toString());
        si.putStringArrayListExtra(PlayerService.EXTRA_TRACK_URIS, uris);
        si.putStringArrayListExtra(PlayerService.EXTRA_TRACK_NAMES, new ArrayList<String>(trackNames));
        si.putExtra(PlayerService.EXTRA_PROGRAM, CmdCodec.encodeProgram(currentProgram().cmds));
        si.putExtra(PlayerService.EXTRA_REPEAT, parseInt(repeatEdit, 0));
        si.putExtra(PlayerService.EXTRA_SLEEP_MIN, parseInt(sleepEdit, 0));
        si.putExtra(PlayerService.EXTRA_SHUFFLE, shuffleCheck.isChecked());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(si);
        } else {
            startService(si);
        }
        setBuilderEnabled(false);
        runButton.setEnabled(false);
        stopButton.setEnabled(true);
        running = true;
        setStatus("Starting playback...");
    }

    private void stopProgram() {
        Intent si = new Intent(this, PlayerService.class);
        si.setAction(PlayerService.ACTION_STOP);
        startService(si);
        running = false;
        runButton.setEnabled(true);
        stopButton.setEnabled(false);
        setBuilderEnabled(true);
        setStatus("Stopping...");
    }

    private void requestNotificationPermissionIfNeeded() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (checkSelfPermission(android.Manifest.permission.POST_NOTIFICATIONS)
                    != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{android.Manifest.permission.POST_NOTIFICATIONS},
                        REQ_POST_NOTIFICATIONS);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions,
                                           int[] grantResults) {
        if (requestCode == REQ_POST_NOTIFICATIONS) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                toastShort("Notifications enabled.");
            } else {
                toastShort("Enable notifications in system settings to see playback.");
            }
        }
    }

    private void exportProgram() {
        Intent share = new Intent(Intent.ACTION_CREATE_DOCUMENT);
        share.addCategory(Intent.CATEGORY_OPENABLE);
        share.setType("text/plain");
        share.putExtra(Intent.EXTRA_TITLE, currentProgram().name + ".pmp");
        startActivityForResult(share, REQ_EXPORT);
    }

    private void importProgram() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("text/plain");
        startActivityForResult(i, REQ_IMPORT);
    }

    private EditText newNumberEdit(String value) {
        EditText e = new EditText(this);
        e.setInputType(InputType.TYPE_CLASS_NUMBER);
        e.setGravity(Gravity.CENTER);
        e.setText(value);
        return e;
    }

    private LinearLayout timeRow(String label, EditText min, EditText sec, float density) {
        LinearLayout r = new LinearLayout(this);
        r.setOrientation(LinearLayout.HORIZONTAL);
        TextView l = new TextView(this);
        l.setText(label);
        TextView sep = new TextView(this);
        sep.setText(" : ");
        int fieldW = Math.round(56f * density);
        r.addView(l, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        r.addView(min, new LinearLayout.LayoutParams(fieldW, ViewGroup.LayoutParams.WRAP_CONTENT));
        r.addView(sep, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT));
        r.addView(sec, new LinearLayout.LayoutParams(fieldW, ViewGroup.LayoutParams.WRAP_CONTENT));
        return r;
    }

    private void applyFieldVisibility(int cmdIdx) {
        if (sectionTimeRow == null || sectionModeRow == null) {
            return;
        }
        boolean section = cmdIdx == 3;
        sectionTimeRow.setVisibility(section ? View.VISIBLE : View.GONE);
        sectionModeRow.setVisibility(section ? View.VISIBLE : View.GONE);
    }

    private Program currentProgram() {
        return programs.get(currentProgramIndex);
    }

    private void refreshProgramSpinner() {
        List<String> names = new ArrayList<String>();
        for (Program p : programs) {
            names.add(p.name);
        }
        ArrayAdapter<String> a = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, names);
        a.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        programSpinner.setAdapter(a);
        ignoreSpinner = true;
        programSpinner.setSelection(Math.min(currentProgramIndex, programs.size() - 1));
        ignoreSpinner = false;
        refreshProgramList();
    }

    private void setBuilderEnabled(boolean enabled) {
        cmdSpinner.setEnabled(enabled);
        trackSpinner.setEnabled(enabled);
        nEdit.setEnabled(enabled);
        repeatEdit.setEnabled(enabled);
        sleepEdit.setEnabled(enabled);
        shuffleCheck.setEnabled(enabled);
        shuffleAllButton.setEnabled(enabled);
        startMinEdit.setEnabled(enabled);
        startSecEdit.setEnabled(enabled);
        endMinEdit.setEnabled(enabled);
        endSecEdit.setEnabled(enabled);
        addButton.setEnabled(enabled);
        clearButton.setEnabled(enabled);
        newButton.setEnabled(enabled);
        deleteButton.setEnabled(enabled);
        exportButton.setEnabled(enabled);
        importButton.setEnabled(enabled);
    }

    private void switchProgram(int pos) {
        if (pos < 0 || pos >= programs.size()) return;
        currentProgramIndex = pos;
        refreshProgramList();
        setStatus("Switched to '" + programs.get(pos).name + "'.");
    }

    private void newProgram() {
        String base = "Program";
        String name = base + " " + (programs.size() + 1);
        int n = programs.size() + 1;
        while (programNameExists(name)) {
            n++;
            name = base + " " + n;
        }
        programs.add(new Program(name));
        currentProgramIndex = programs.size() - 1;
        autoSave();
        refreshProgramSpinner();
        applyFieldVisibility(cmdSpinner.getSelectedItemPosition());
        setStatus("Created new program.");
    }

    private boolean programNameExists(String name) {
        for (Program p : programs) {
            if (p.name != null && p.name.equals(name)) return true;
        }
        return false;
    }

    private void deleteProgram() {
        if (programs.size() <= 1) {
            toastShort("Keep at least one program.");
            return;
        }
        String removed = currentProgram().name;
        programs.remove(currentProgramIndex);
        if (currentProgramIndex >= programs.size()) currentProgramIndex = programs.size() - 1;
        autoSave();
        refreshProgramSpinner();
        setStatus("Deleted '" + removed + "'.");
    }

    private void refreshProgramList() {
        StringBuilder sb = new StringBuilder();
        List<Cmd> cmds = currentProgram().cmds;
        if (cmds.isEmpty()) {
            sb.append("(no steps yet)\n");
        } else {
            for (int i = 0; i < cmds.size(); i++) {
                sb.append(i + 1).append(". ").append(cmds.get(i).text).append('\n');
            }
        }
        programListView.setText(sb.toString());
    }

    private void addStep() {
        int cmdIdx = cmdSpinner.getSelectedItemPosition();
        int trackIdx = tracks.isEmpty() ? -1 : trackSpinner.getSelectedItemPosition();
        int n = parseInt(nEdit, 0);
        if (n < 0) n = 0;

        Cmd c;
        if (cmdIdx == 0) {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            if (n < 1) { toastShort("N must be >= 1."); return; }
            PlayCmd p = new PlayCmd();
            p.keyword = "PLAY";
            p.track = trackIdx;
            p.times = n;
            c = p;
        } else if (cmdIdx == 1) {
            PauseCmd p = new PauseCmd();
            p.keyword = "PAUSE";
            p.minutes = n;
            c = p;
        } else if (cmdIdx == 2) {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            if (n < 1) { toastShort("N must be >= 1."); return; }
            LoopCmd p = new LoopCmd();
            p.keyword = "LOOP";
            p.track = trackIdx;
            p.minutes = n;
            c = p;
        } else {
            if (trackIdx < 0) { toastShort("Pick a track first."); return; }
            int sm = clamp09(parseInt(startMinEdit, 0), 0, 59);
            int ss = clamp09(parseInt(startSecEdit, 0), 0, 59);
            int em = clamp09(parseInt(endMinEdit, 0), 0, 59);
            int es = clamp09(parseInt(endSecEdit, 0), 0, 59);
            long startMs = (sm * 60L + ss) * 1000L;
            long endMs = (em * 60L + es) * 1000L;
            if (endMs <= startMs) {
                toastShort("End must be after start.");
                return;
            }
            int mode = sectionModeSpinner.getSelectedItemPosition();
            SectionCmd p = new SectionCmd();
            p.keyword = "SECTION";
            p.track = trackIdx;
            p.startMs = startMs;
            p.endMs = endMs;
            if (mode == 0) {
                p.timed = true;
                p.minutes = n;
            } else {
                p.timed = false;
                p.times = n;
            }
            c = p;
        }
        c.text = CmdCodec.describe(c);
        currentProgram().cmds.add(c);
        refreshProgramList();
        setStatus("Added step " + currentProgram().cmds.size() + ".");
        autoSave();
    }

    private void launchPicker() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("audio/*");
        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        startActivityForResult(intent, REQ_PICK_TRACKS);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null) {
            return;
        }
        if (requestCode == REQ_PICK_TRACKS) {
            int before = tracks.size();
            if (data.getData() != null) {
                addTrack(data.getData());
            }
            ClipData clip = data.getClipData();
            if (clip != null) {
                for (int i = 0; i < clip.getItemCount(); i++) {
                    Uri uri = clip.getItemAt(i).getUri();
                    if (uri != null) {
                        addTrack(uri);
                    }
                }
            }
            if (tracks.size() != before) {
                refreshTrackList();
                refreshTrackSpinner();
                Toast.makeText(this, "Loaded " + (tracks.size() - before) + " track(s).",
                        Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "No new tracks selected.", Toast.LENGTH_SHORT).show();
            }
        } else if (requestCode == REQ_EXPORT) {
            Uri doc = data.getData();
            if (doc == null) return;
            try {
                String enc = CmdCodec.encodeProgram(currentProgram().cmds);
                Storage.writeUri(this, doc, enc);
                toastShort("Exported " + currentProgram().name + ".");
            } catch (Exception e) {
                toastLong("Export failed: " + e.getMessage());
            }
        } else if (requestCode == REQ_IMPORT) {
            Uri doc = data.getData();
            if (doc == null) return;
            try {
                String text = Storage.readUri(this, doc);
                List<Cmd> cmds = CmdCodec.decodeProgram(text);
                if (cmds.isEmpty()) {
                    toastShort("No commands found in file.");
                    return;
                }
                StringBuilder sb = new StringBuilder();
                for (Cmd c : cmds) sb.append(c.text).append('\n');
                String name = "Imported";
                int n = 1;
                while (programNameExists(name + " " + n)) n++;
                name = name + " " + n;
                Program p = new Program(name);
                p.cmds = cmds;
                programs.add(p);
                currentProgramIndex = programs.size() - 1;
                autoSave();
                refreshProgramSpinner();
                toastShort("Imported " + cmds.size() + " commands as '" + name + "'.");
            } catch (Exception e) {
                toastLong("Import failed: " + e.getMessage());
            }
        }
    }

    private void addTrack(Uri uri) {
        try {
            getContentResolver().takePersistableUriPermission(uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION);
        } catch (Exception ignored) {
        }
        tracks.add(uri);
        trackNames.add(queryDisplayName(uri));
    }

    private String queryDisplayName(Uri uri) {
        Cursor cursor = null;
        try {
            cursor = getContentResolver().query(uri, null, null, null, null);
            if (cursor != null && cursor.moveToFirst()) {
                int idx = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);
                if (idx >= 0) {
                    String name = cursor.getString(idx);
                    if (name != null && name.length() > 0) {
                        return name;
                    }
                }
            }
        } catch (Exception ignored) {
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        String last = uri.getLastPathSegment();
        if (last != null) {
            int slash = last.lastIndexOf('/');
            if (slash >= 0) last = last.substring(slash + 1);
        }
        return last != null && last.length() > 0 ? last : "track";
    }

    private void refreshTrackList() {
        StringBuilder sb = new StringBuilder();
        if (tracks.isEmpty()) {
            sb.append("No tracks loaded.\n");
        } else {
            for (int i = 0; i < tracks.size(); i++) {
                sb.append(i).append(". ").append(trackNames.get(i)).append('\n');
            }
        }
        trackListView.setText(sb.toString());
    }

    private void refreshTrackSpinner() {
        List<String> entries = new ArrayList<String>();
        if (tracks.isEmpty()) {
            entries.add("No tracks");
        } else {
            for (int i = 0; i < tracks.size(); i++) {
                entries.add(i + ": " + trackNames.get(i));
            }
        }
        ArrayAdapter<String> a = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, entries);
        a.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        trackSpinner.setAdapter(a);
        if (!tracks.isEmpty()) {
            trackSpinner.setSelection(0);
        }
    }

    private void autoSave() {
        if (SettingsActivity.autoSave(this)) {
            Storage.savePrograms(this, programs);
        }
    }

    private void setStatus(final String text) {
        statusView.setText(text);
    }

    private void toastShort(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }

    private void toastLong(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_LONG).show();
    }

    private static int parseInt(EditText et, int def) {
        return parseInt(et.getText().toString(), def);
    }

    private static int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    private static int clamp09(int v, int lo, int hi) {
        if (v < lo) v = lo;
        if (v > hi) v = hi;
        return v;
    }

    private static String fmtTime(int ms) {
        if (ms < 0) ms = 0;
        int total = ms / 1000;
        return String.format(Locale.US, "%d:%02d", total / 60, total % 60);
    }
}
