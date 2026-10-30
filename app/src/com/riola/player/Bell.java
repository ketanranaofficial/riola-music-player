package com.riola.player;

import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Handler;
import android.os.Looper;

/**
 * A soft struck bell, synthesised at runtime so the apk carries no audio files.
 *
 * The gentleness comes from the envelope, not the volume: the bright partials
 * die away in well under a second while the low ones ring on for seconds, and
 * the attack is ramped over 8 ms so there is no click. That is roughly what a
 * singing bowl does, and it is why this does not sound like a beep.
 */
public class Bell {

    public static final int LOW = 0, WARM = 1, BRIGHT = 2, DESK = 3;

    private static final int RATE = 44100;
    private static final float[] F0    = { 174.6f, 261.6f, 392.0f, 1480.0f };  // F3, C4, G4, F#6
    private static final long[]  LEN   = { 6000, 5000, 4000, 900 };
    private static final String[] NAMES = { "low", "warm", "bright", "desk" };

    private static final short[][] CACHE = new short[4][];

    private AudioTrack track;

    public static int clamp(int tone) { return tone < 0 ? 0 : (tone > 3 ? 3 : tone); }
    public static long lengthMs(int tone) { return LEN[clamp(tone)]; }
    public static String toneName(int tone) { return NAMES[clamp(tone)]; }

    /** Build the samples ahead of time so the first ring is not late. */
    public static void warm() {
        new Thread(new Runnable() {
            public void run() {
                try { pcm(WARM); } catch (Throwable t) { /* not important */ }
            }
        }, "riola-bell-warm").start();
    }

    private static synchronized short[] pcm(int tone) {
        tone = clamp(tone);
        if (CACHE[tone] != null) return CACHE[tone];

        int n = (int) (RATE * LEN[tone] / 1000L);
        short[] out = new short[n];
        float f0 = F0[tone];

        // partial: ratio to the fundamental, starting level, seconds to decay
        float[] ratio, amp, decay;
        float attack, tail, scale, shimmer;
        if (tone == DESK) {
            // a little metal dome struck once: high, inharmonic, and gone in
            // about a second. Short decays are what make it read as a "ting"
            // rather than a chime.
            ratio = new float[]{ 1.00f, 2.71f, 5.18f, 8.16f, 9.42f };
            amp   = new float[]{ 1.00f, 0.58f, 0.32f, 0.16f, 0.08f };
            decay = new float[]{ 0.42f, 0.26f, 0.16f, 0.10f, 0.06f };
            attack = 0.0015f;
            tail = 0.08f;
            scale = 9000f;
            shimmer = 0f;
        } else {
            ratio = new float[]{ 0.5f,  1.0f,  2.0f,  2.97f, 4.06f, 5.43f };
            amp   = new float[]{ 0.32f, 1.00f, 0.40f, 0.18f, 0.09f, 0.05f };
            decay = new float[]{ 6.5f,  4.5f,  2.4f,  1.3f,  0.8f,  0.45f };
            attack = 0.008f;
            tail = 0.35f;
            scale = 11000f;
            shimmer = 0.22f;
        }

        double w = 2.0 * Math.PI / RATE;

        for (int i = 0; i < n; i++) {
            float t = i / (float) RATE;
            float s = 0f;
            for (int k = 0; k < ratio.length; k++) {
                // a partial above the nyquist limit does not disappear, it folds
                // back down as an out of tune whine - so it never gets written
                if (f0 * ratio[k] > RATE * 0.45f) continue;
                s += amp[k] * (float) Math.exp(-t / decay[k]) * (float) Math.sin(w * f0 * ratio[k] * i);
            }
            // a second prime a hair sharp gives the tone a slow, warm shimmer
            if (shimmer > 0f) {
                s += shimmer * (float) Math.exp(-t / 4.0f) * (float) Math.sin(w * f0 * 1.003f * i);
            }

            if (t < attack) s *= 0.5f - 0.5f * (float) Math.cos(Math.PI * t / attack);
            float left = (n - i) / (float) RATE;
            if (left < tail) s *= left / tail;

            int v = (int) (s * scale);
            if (v > 32000) v = 32000;
            if (v < -32000) v = -32000;
            out[i] = (short) v;
        }
        CACHE[tone] = out;
        return out;
    }

    /** Strike it. Returns straight away; the tone rings on by itself. */
    public void ring(int tone, float volume) {
        stop();
        try {
            short[] data = pcm(tone);
            AudioTrack t = new AudioTrack.Builder()
                    .setAudioAttributes(new AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_MEDIA)
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            .build())
                    .setAudioFormat(new AudioFormat.Builder()
                            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                            .setSampleRate(RATE)
                            .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                            .build())
                    .setBufferSizeInBytes(data.length * 2)
                    .setTransferMode(AudioTrack.MODE_STATIC)
                    .build();
            t.write(data, 0, data.length);
            float v = volume < 0f ? 0f : (volume > 1f ? 1f : volume);
            t.setVolume(v);
            t.play();
            track = t;
        } catch (Throwable e) {
            track = null;
        }
    }

    public void stop() {
        AudioTrack t = track;
        track = null;
        if (t == null) return;
        try { t.setVolume(0f); } catch (Exception e) { /* ignore */ }
        try { t.pause(); } catch (Exception e) { /* ignore */ }
        try { t.flush(); } catch (Exception e) { /* ignore */ }
        try { t.stop(); } catch (Exception e) { /* ignore */ }
        try { t.release(); } catch (Exception e) { /* ignore */ }
    }

    /** One strike that cleans up after itself, for the editor preview. */
    public static void preview(int tone, float volume) {
        final Bell b = new Bell();
        b.ring(tone, volume);
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            public void run() { b.stop(); }
        }, lengthMs(tone) + 250);
    }
}
