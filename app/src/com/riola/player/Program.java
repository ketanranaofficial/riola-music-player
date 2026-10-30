package com.riola.player;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/** A named list of steps. */
public class Program {

    public String id;
    public String name;
    public final List<Step> steps = new ArrayList<Step>();
    public int loops = 1;          // -1 = keep repeating the whole program
    public long updated;
    public long lastRun;

    public Program(String id, String name) {
        this.id = id;
        this.name = name;
        this.updated = System.currentTimeMillis();
    }

    public static Program blank(String name) {
        return new Program(Long.toHexString(System.currentTimeMillis()) + Integer.toHexString((int) (Math.random() * 65536)), name);
    }

    public int enabledCount() {
        int n = 0;
        for (int i = 0; i < steps.size(); i++) if (steps.get(i).enabled) n++;
        return n;
    }

    /** One pass through the enabled steps. */
    public long passMs() {
        long t = 0;
        for (int i = 0; i < steps.size(); i++) t += steps.get(i).estMs();
        return t;
    }

    public long estMs() {
        return passMs() * (loops < 0 ? 1 : Math.max(1, loops));
    }

    public boolean hasMissing() {
        for (int i = 0; i < steps.size(); i++) if (steps.get(i).enabled && steps.get(i).missing()) return true;
        return false;
    }

    public String summary() {
        int n = enabledCount();
        if (n == 0) return "no steps yet";
        String s = n + (n == 1 ? " step" : " steps");
        long t = estMs();
        if (t > 0) s = s + "  .  " + (loops < 0 ? "repeats forever" : ("about " + Fmt.rough(t)));
        else if (loops < 0) s = s + "  .  repeats forever";
        if (loops > 1) s = s + "  .  " + loops + " loops";
        return s;
    }

    public Program copyAs(String newName) {
        Program p = Program.blank(newName);
        p.loops = loops;
        for (int i = 0; i < steps.size(); i++) p.steps.add(steps.get(i).copy());
        return p;
    }

    public JSONObject toJson() throws Exception {
        JSONObject o = new JSONObject();
        o.put("id", id);
        o.put("nm", name);
        o.put("lp", loops);
        o.put("up", updated);
        o.put("lr", lastRun);
        JSONArray arr = new JSONArray();
        for (int i = 0; i < steps.size(); i++) arr.put(steps.get(i).toJson());
        o.put("st", arr);
        return o;
    }

    public static Program fromJson(JSONObject o) {
        Program p = new Program(o.optString("id", Long.toHexString(System.nanoTime())),
                                o.optString("nm", "Program"));
        p.loops = o.optInt("lp", 1);
        p.updated = o.optLong("up", 0);
        p.lastRun = o.optLong("lr", 0);
        JSONArray arr = o.optJSONArray("st");
        if (arr != null) {
            for (int i = 0; i < arr.length(); i++) {
                JSONObject s = arr.optJSONObject(i);
                if (s != null) p.steps.add(Step.fromJson(s));
            }
        }
        return p;
    }
}
