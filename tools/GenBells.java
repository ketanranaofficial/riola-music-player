package com.riola.player;

import java.io.FileOutputStream;
import java.io.IOException;

/** Writes the four bell voices as mono 16 bit 44.1 kHz wav files. Run through tools/gen-bells.sh. */
public class GenBells {
    public static void main(String[] args) throws IOException {
        String dir = args[0];
        String[] names = { "low", "warm", "bright", "desk" };
        for (int tone = 0; tone < 4; tone++) {
            short[] pcm = Bell.synthesize(tone);
            int bytes = pcm.length * 2;
            byte[] out = new byte[44 + bytes];
            put(out, 0, "RIFF"); le32(out, 4, 36 + bytes); put(out, 8, "WAVE");
            put(out, 12, "fmt "); le32(out, 16, 16); le16(out, 20, 1); le16(out, 22, 1);
            le32(out, 24, 44100); le32(out, 28, 44100 * 2); le16(out, 32, 2); le16(out, 34, 16);
            put(out, 36, "data"); le32(out, 40, bytes);
            for (int i = 0; i < pcm.length; i++) le16(out, 44 + 2 * i, pcm[i]);
            FileOutputStream f = new FileOutputStream(dir + "/bell_" + names[tone] + ".wav");
            f.write(out);
            f.close();
            System.out.println("bell_" + names[tone] + ".wav  " + out.length + " bytes");
        }
    }

    private static void put(byte[] b, int at, String s) { for (int i = 0; i < s.length(); i++) b[at + i] = (byte) s.charAt(i); }
    private static void le16(byte[] b, int at, int v) { b[at] = (byte) v; b[at + 1] = (byte) (v >> 8); }
    private static void le32(byte[] b, int at, int v) { le16(b, at, v); le16(b, at + 2, v >> 16); }
}
