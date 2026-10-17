package com.riola.player;

import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Handler;
import android.os.Looper;

/* JADX INFO: loaded from: classes.dex */
public class Bell {
    public static final int BRIGHT = 2;
    public static final int DESK = 3;
    public static final int LOW = 0;
    private static final int RATE = 44100;
    public static final int WARM = 1;
    private AudioTrack track;
    private static final float[] F0 = {174.6f, 261.6f, 392.0f, 1480.0f};
    private static final long[] LEN = {6000, 5000, 4000, 900};
    private static final String[] NAMES = {"low", "warm", "bright", "desk"};
    private static final short[][] CACHE = new short[4][];

    public static int clamp(int i) {
        if (i < 0) {
            return 0;
        }
        if (i > 3) {
            return 3;
        }
        return i;
    }

    public static long lengthMs(int i) {
        return LEN[clamp(i)];
    }

    public static String toneName(int i) {
        return NAMES[clamp(i)];
    }

    public static void warm() {
        new Thread(new Runnable() { // from class: com.riola.player.Bell.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Bell.pcm(1);
                } catch (Throwable th) {
                }
            }
        }, "riola-bell-warm").start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static synchronized short[] pcm(int i) throws Throwable {
        short[] sArr;
        float[] fArr;
        float[] fArr2;
        float[] fArr3;
        float f;
        float f2;
        float f3;
        float f4;
        Class<Bell> cls = Bell.class;
        synchronized (cls) {
            try {
                int iClamp = clamp(i);
                sArr = CACHE[iClamp];
                if (sArr == null) {
                    int i2 = (int) ((LEN[iClamp] * 44100) / 1000);
                    short[] sArr2 = new short[i2];
                    float f5 = F0[iClamp];
                    if (iClamp == 3) {
                        fArr = new float[]{1.0f, 2.71f, 5.18f, 8.16f, 9.42f};
                        fArr2 = new float[]{1.0f, 0.58f, 0.32f, 0.16f, 0.08f};
                        fArr3 = new float[]{0.42f, 0.26f, 0.16f, 0.1f, 0.06f};
                        f = 0.0015f;
                        f2 = 0.08f;
                        f3 = 9000.0f;
                        f4 = 0.0f;
                    } else {
                        fArr = new float[]{0.5f, 1.0f, 2.0f, 2.97f, 4.06f, 5.43f};
                        fArr2 = new float[]{0.32f, 1.0f, 0.4f, 0.18f, 0.09f, 0.05f};
                        fArr3 = new float[]{6.5f, 4.5f, 2.4f, 1.3f, 0.8f, 0.45f};
                        f = 0.008f;
                        f2 = 0.35f;
                        f3 = 11000.0f;
                        f4 = 0.22f;
                    }
                    int i3 = 0;
                    while (i3 < i2) {
                        float f6 = i3 / 44100.0f;
                        int i4 = 0;
                        float fCos = 0.0f;
                        while (i4 < fArr.length) {
                            if (fArr[i4] * f5 <= 19845.0f) {
                                fCos += fArr2[i4] * ((float) Math.exp((-f6) / fArr3[i4])) * ((float) Math.sin(1.4247585730565955E-4d * ((double) f5) * ((double) fArr[i4]) * ((double) i3)));
                            }
                            try {
                                i4++;
                                fArr2 = fArr2;
                                cls = cls;
                                iClamp = iClamp;
                            } catch (Throwable th) {
                                th = th;
                            }
                        }
                        int i5 = iClamp;
                        Class<Bell> cls2 = cls;
                        float[] fArr4 = fArr2;
                        if (f4 > 0.0f) {
                            fCos += ((float) Math.exp((-f6) / 4.0f)) * f4 * ((float) Math.sin(1.4247585730565955E-4d * ((double) f5) * 1.003000020980835d * ((double) i3)));
                        }
                        if (f6 < f) {
                            fCos *= 0.5f - (((float) Math.cos((((double) f6) * 3.141592653589793d) / ((double) f))) * 0.5f);
                        }
                        float f7 = (i2 - i3) / 44100.0f;
                        if (f7 < f2) {
                            fCos *= f7 / f2;
                        }
                        int i6 = (int) (fCos * f3);
                        if (i6 > 32000) {
                            i6 = 32000;
                        }
                        if (i6 < -32000) {
                            i6 = -32000;
                        }
                        sArr2[i3] = (short) i6;
                        i3++;
                        fArr3 = fArr3;
                        fArr2 = fArr4;
                        cls = cls2;
                        iClamp = i5;
                    }
                    cls = cls;
                    CACHE[iClamp] = sArr2;
                    return sArr2;
                }
            } catch (Throwable th2) {
                th = th2;
                cls = cls;
            }
            throw th;
        }
        return sArr;
    }

    public void ring(int i, float f) {
        stop();
        try {
            short[] sArrPcm = pcm(i);
            AudioTrack audioTrackBuild = new AudioTrack.Builder().setAudioAttributes(new AudioAttributes.Builder().setUsage(1).setContentType(2).build()).setAudioFormat(new AudioFormat.Builder().setEncoding(2).setSampleRate(RATE).setChannelMask(4).build()).setBufferSizeInBytes(sArrPcm.length * 2).setTransferMode(0).build();
            audioTrackBuild.write(sArrPcm, 0, sArrPcm.length);
            float f2 = 0.0f;
            if (f < 0.0f) {
                f = f2;
            } else {
                f2 = 1.0f;
                if (f > 1.0f) {
                    f = f2;
                }
            }
            audioTrackBuild.setVolume(f);
            audioTrackBuild.play();
            this.track = audioTrackBuild;
        } catch (Throwable th) {
            this.track = null;
        }
    }

    public void stop() {
        AudioTrack audioTrack = this.track;
        this.track = null;
        if (audioTrack == null) {
            return;
        }
        try {
            audioTrack.setVolume(0.0f);
        } catch (Exception e) {
        }
        try {
            audioTrack.pause();
        } catch (Exception e2) {
        }
        try {
            audioTrack.flush();
        } catch (Exception e3) {
        }
        try {
            audioTrack.stop();
        } catch (Exception e4) {
        }
        try {
            audioTrack.release();
        } catch (Exception e5) {
        }
    }

    public static void preview(int i, float f) {
        Bell bell = new Bell();
        bell.ring(i, f);
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() { // from class: com.riola.player.Bell.2
            @Override // java.lang.Runnable
            public void run() {
                Bell.this.stop();
            }
        }, lengthMs(i) + 250);
    }
}
