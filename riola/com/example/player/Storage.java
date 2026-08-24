package com.example.player;

import android.content.Context;
import android.net.Uri;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

public class Storage {

    static final String FILE_NAME = "programs.dat";

    static List<Program> loadPrograms(Context ctx) {
        try {
            InputStream is = ctx.openFileInput(FILE_NAME);
            String data = readAll(is);
            is.close();
            return ProgramCodec.decode(data);
        } catch (FileNotFoundException fnf) {
            return new ArrayList<Program>();
        } catch (Exception e) {
            return new ArrayList<Program>();
        }
    }

    static void savePrograms(Context ctx, List<Program> progs) {
        try {
            String data = ProgramCodec.encode(progs);
            FileOutputStream fos = ctx.openFileOutput(FILE_NAME, Context.MODE_PRIVATE);
            fos.write(data.getBytes("UTF-8"));
            fos.close();
        } catch (Exception e) {
            // best effort
        }
    }

    static String readUri(Context ctx, Uri uri) throws IOException {
        InputStream is = ctx.getContentResolver().openInputStream(uri);
        if (is == null) throw new IOException("cannot open input: " + uri);
        String data = readAll(is);
        is.close();
        return data;
    }

    static void writeUri(Context ctx, Uri uri, String data) throws IOException {
        OutputStream os = ctx.getContentResolver().openOutputStream(uri);
        if (os == null) throw new IOException("cannot open output: " + uri);
        os.write(data.getBytes("UTF-8"));
        os.flush();
        os.close();
    }

    private static String readAll(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buf = new byte[4096];
        int n;
        while ((n = is.read(buf)) > 0) {
            baos.write(buf, 0, n);
        }
        return new String(baos.toByteArray(), "UTF-8");
    }
}
