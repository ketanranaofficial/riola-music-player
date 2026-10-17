package com.riola.player;

import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class Program {
    public String id;
    public long lastRun;
    public String name;
    public final List<Step> steps = new ArrayList();
    public int loops = 1;
    public long updated = System.currentTimeMillis();

    public Program(String str, String str2) {
        this.id = str;
        this.name = str2;
    }

    public static Program blank(String str) {
        return new Program(Long.toHexString(System.currentTimeMillis()) + Integer.toHexString((int) (Math.random() * 65536.0d)), str);
    }

    public int enabledCount() {
        int i = 0;
        for (int i2 = 0; i2 < this.steps.size(); i2++) {
            if (this.steps.get(i2).enabled) {
                i++;
            }
        }
        return i;
    }

    public long passMs() {
        long jEstMs = 0;
        for (int i = 0; i < this.steps.size(); i++) {
            jEstMs += this.steps.get(i).estMs();
        }
        return jEstMs;
    }

    public long estMs() {
        long jPassMs = passMs();
        int i = this.loops;
        return jPassMs * ((long) (i >= 0 ? Math.max(1, i) : 1));
    }

    public boolean hasMissing() {
        for (int i = 0; i < this.steps.size(); i++) {
            if (this.steps.get(i).enabled && this.steps.get(i).missing()) {
                return true;
            }
        }
        return false;
    }

    public String summary() {
        int iEnabledCount = enabledCount();
        if (iEnabledCount == 0) {
            return "no steps yet";
        }
        String str = iEnabledCount + (iEnabledCount == 1 ? " step" : " steps");
        long jEstMs = estMs();
        if (jEstMs > 0) {
            str = str + "  .  " + (this.loops < 0 ? "repeats forever" : "about " + Fmt.rough(jEstMs));
        } else if (this.loops < 0) {
            str = str + "  .  repeats forever";
        }
        return this.loops > 1 ? str + "  .  " + this.loops + " loops" : str;
    }

    public Program copyAs(String str) {
        Program programBlank = blank(str);
        programBlank.loops = this.loops;
        for (int i = 0; i < this.steps.size(); i++) {
            programBlank.steps.add(this.steps.get(i).copy());
        }
        return programBlank;
    }

    public JSONObject toJson() throws Exception {
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("id", this.id);
        jSONObject.put("nm", this.name);
        jSONObject.put("lp", this.loops);
        jSONObject.put("up", this.updated);
        jSONObject.put("lr", this.lastRun);
        JSONArray jSONArray = new JSONArray();
        for (int i = 0; i < this.steps.size(); i++) {
            jSONArray.put(this.steps.get(i).toJson());
        }
        jSONObject.put("st", jSONArray);
        return jSONObject;
    }

    public static Program fromJson(JSONObject jSONObject) {
        Program program = new Program(jSONObject.optString("id", Long.toHexString(System.nanoTime())), jSONObject.optString("nm", "Program"));
        program.loops = jSONObject.optInt("lp", 1);
        program.updated = jSONObject.optLong("up", 0L);
        program.lastRun = jSONObject.optLong("lr", 0L);
        JSONArray jSONArrayOptJSONArray = jSONObject.optJSONArray("st");
        if (jSONArrayOptJSONArray != null) {
            for (int i = 0; i < jSONArrayOptJSONArray.length(); i++) {
                JSONObject jSONObjectOptJSONObject = jSONArrayOptJSONArray.optJSONObject(i);
                if (jSONObjectOptJSONObject != null) {
                    program.steps.add(Step.fromJson(jSONObjectOptJSONObject));
                }
            }
        }
        return program;
    }
}
