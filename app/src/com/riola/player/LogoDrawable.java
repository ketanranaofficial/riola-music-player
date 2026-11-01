package com.riola.player;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;

/**
 * The Riola mark on a small dark tile, coloured from the accent the user picked.
 *
 * The launcher icon keeps the fixed azure-to-mint brand colours, because nothing there
 * can follow the app's theme. Inside the app the same shapes are painted with a gradient
 * built from the accent, so the header changes with the colour like everything else.
 */
public class LogoDrawable extends Drawable {
    private final Paint tilePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint markPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Path ringA = LogoPaths.path(LogoPaths.RING_A);
    private final Path ringB = LogoPaths.path(LogoPaths.RING_B);
    private final Path note = LogoPaths.path(LogoPaths.NOTE);
    private final int low, mid, high, tileLight, tileDark;
    private final float cornerPx;

    /** @param accent the app's accent colour; @param cornerPx corner radius of the tile, in pixels */
    public LogoDrawable(int accent, float cornerPx) {
        this.cornerPx = cornerPx;
        float[] hsv = new float[3];
        Color.colorToHSV(accent, hsv);
        float h = hsv[0];
        boolean grey = hsv[1] < 0.12f;                       // a grey or white accent stays neutral
        float s = grey ? hsv[1] : Math.max(0.45f, Math.min(0.95f, hsv[1]));
        float v = Math.max(0.85f, hsv[2]);                   // it sits on a dark tile, so keep it bright
        low = hsv(h + 32f, s, v * 0.88f);                    // deeper end, bottom left
        mid = hsv(h, s, v);
        high = hsv(h - 32f, s * 0.75f, Math.min(1f, v * 1.05f));   // lighter end, top right
        tileLight = hsv(h, grey ? 0f : Math.min(0.7f, hsv[1]), 0.19f);
        tileDark = hsv(h, grey ? 0f : Math.min(0.6f, hsv[1]), 0.07f);
    }

    private static int hsv(float h, float s, float v) {
        return Color.HSVToColor(new float[] { (h % 360f + 360f) % 360f, s, v });
    }

    @Override
    public void draw(Canvas canvas) {
        RectF b = new RectF(getBounds());
        if (b.width() <= 0 || b.height() <= 0) return;
        tilePaint.setShader(new LinearGradient(b.left, b.top, b.right, b.bottom, tileLight, tileDark, Shader.TileMode.CLAMP));
        canvas.drawRoundRect(b, cornerPx, cornerPx, tilePaint);

        float inset = Math.min(b.width(), b.height()) * 0.10f;   // a little air round the ring
        float scale = (Math.min(b.width(), b.height()) - 2 * inset) / 100f;
        canvas.save();
        canvas.translate(b.centerX() - 50f * scale, b.centerY() - 50f * scale);
        canvas.scale(scale, scale);
        markPaint.setShader(new LinearGradient(LogoPaths.GX0, LogoPaths.GY0, LogoPaths.GX1, LogoPaths.GY1,
                new int[] { low, mid, high }, new float[] { 0f, 0.5f, 1f }, Shader.TileMode.CLAMP));
        canvas.drawPath(ringA, markPaint);
        canvas.drawPath(ringB, markPaint);
        canvas.drawPath(note, markPaint);
        canvas.restore();
    }

    @Override public void setAlpha(int alpha) { tilePaint.setAlpha(alpha); markPaint.setAlpha(alpha); }
    @Override public void setColorFilter(ColorFilter cf) { tilePaint.setColorFilter(cf); markPaint.setColorFilter(cf); }
    @Override public int getOpacity() { return PixelFormat.TRANSLUCENT; }
}
