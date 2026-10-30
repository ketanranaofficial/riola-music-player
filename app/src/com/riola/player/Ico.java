package com.riola.player;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;

/**
 * Every icon is drawn here on a 24x24 grid, so the apk needs no bitmap assets
 * and no icon font.
 */
public class Ico extends Drawable {

    public static final int PLAY = 1, PAUSE = 2, STOP = 3, NEXT = 4, PREV = 5, PLUS = 6,
            FOLDER = 7, TRASH = 8, SAVE = 9, OPEN = 10, HELP = 11, GEAR = 12, LOOP = 13,
            NOTE = 14, AB = 15, CHECK = 16, CLOSE = 17, UP = 18, DOWN = 19, CLOCK = 20,
            LIST = 21, WAVE = 22, EDIT = 23, SCISSOR = 24, MORE = 25, BACK = 26, RIGHT = 27,
            SEARCH = 28, COPY = 29, MINUS = 30, DRAG = 31, PROGRAM = 32, MOON = 33,
            RESET = 34, BELL = 35, SHUFFLE = 36;

    private final int id;
    private int color;
    private final Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Path path = new Path();
    private final RectF r = new RectF();

    public Ico(int id, int color) {
        this.id = id;
        this.color = color;
    }

    @Override
    public void draw(Canvas cv) {
        Rect b = getBounds();
        float s = Math.min(b.width(), b.height());
        if (s <= 0) return;
        float u = s / 24f;
        float ox = b.exactCenterX() - 12f * u;
        float oy = b.exactCenterY() - 12f * u;

        p.setColor(color);
        p.setStrokeWidth(Ui.ICON_W * u);
        p.setStrokeCap(Ui.SQUARE_ICONS ? Paint.Cap.BUTT : Paint.Cap.ROUND);
        p.setStrokeJoin(Ui.SQUARE_ICONS ? Paint.Join.MITER : Paint.Join.ROUND);
        p.setStyle(Paint.Style.STROKE);
        p.setTextAlign(Paint.Align.CENTER);

        switch (id) {
            case PLAY:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 6.5f, 4f, 19.5f, 12f, 6.5f, 20f);
                break;
            case PAUSE:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 6.5f, 4f, 10.5f, 20f, 1.4f);
                box(cv, ox, oy, u, 13.5f, 4f, 17.5f, 20f, 1.4f);
                break;
            case STOP:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 5.5f, 5.5f, 18.5f, 18.5f, 2.4f);
                break;
            case NEXT:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 5f, 4f, 15.5f, 12f, 5f, 20f);
                box(cv, ox, oy, u, 16.5f, 4f, 19.5f, 20f, 1.2f);
                break;
            case PREV:
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 19f, 4f, 8.5f, 12f, 19f, 20f);
                box(cv, ox, oy, u, 4.5f, 4f, 7.5f, 20f, 1.2f);
                break;
            case PLUS:
                line(cv, ox, oy, u, 12f, 5f, 12f, 19f);
                line(cv, ox, oy, u, 5f, 12f, 19f, 12f);
                break;
            case MINUS:
                line(cv, ox, oy, u, 5f, 12f, 19f, 12f);
                break;
            case FOLDER:
                poly(cv, ox, oy, u, true, 3f, 19f, 3f, 5.5f, 9f, 5.5f, 11f, 8.5f, 21f, 8.5f, 21f, 19f);
                break;
            case TRASH:
                box(cv, ox, oy, u, 6f, 7.5f, 18f, 20.5f, 2f);
                line(cv, ox, oy, u, 3.5f, 7.5f, 20.5f, 7.5f);
                poly(cv, ox, oy, u, false, 9f, 7.5f, 9f, 4f, 15f, 4f, 15f, 7.5f);
                break;
            case SAVE:
                line(cv, ox, oy, u, 12f, 3.5f, 12f, 15f);
                poly(cv, ox, oy, u, false, 7f, 10.5f, 12f, 15.5f, 17f, 10.5f);
                line(cv, ox, oy, u, 4.5f, 20f, 19.5f, 20f);
                break;
            case OPEN:
                line(cv, ox, oy, u, 12f, 15.5f, 12f, 4f);
                poly(cv, ox, oy, u, false, 7f, 9f, 12f, 4f, 17f, 9f);
                line(cv, ox, oy, u, 4.5f, 20f, 19.5f, 20f);
                break;
            case HELP:
                cv.drawCircle(ox + 12f * u, oy + 12f * u, 8.8f * u, p);
                p.setStyle(Paint.Style.FILL);
                p.setTextSize(13f * u);
                cv.drawText("?", ox + 12f * u, oy + 16.6f * u, p);
                break;
            case GEAR: {
                float cx = ox + 12f * u, cy = oy + 12f * u;
                for (int i = 0; i < 8; i++) {
                    cv.save();
                    cv.rotate(i * 45f, cx, cy);
                    r.set(cx - 1.9f * u, cy - 11f * u, cx + 1.9f * u, cy - 6.4f * u);
                    p.setStyle(Paint.Style.FILL);
                    cv.drawRoundRect(r, 0.8f * u, 0.8f * u, p);
                    cv.restore();
                }
                p.setStyle(Paint.Style.STROKE);
                p.setStrokeWidth(2.6f * u);
                cv.drawCircle(cx, cy, 6.4f * u, p);
                p.setStrokeWidth(1.9f * u);
                p.setColor(0x00000000);
                p.setStyle(Paint.Style.FILL);
                p.setColor(color);
                p.setStyle(Paint.Style.STROKE);
                cv.drawCircle(cx, cy, 3.1f * u, p);
                break;
            }
            case LOOP:
                r.set(ox + 3.5f * u, oy + 6.5f * u, ox + 20.5f * u, oy + 17.5f * u);
                cv.drawRoundRect(r, 5.5f * u, 5.5f * u, p);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 13f, 3.6f, 17.5f, 6.5f, 13f, 9.4f);
                break;
            case NOTE:
                p.setStyle(Paint.Style.FILL);
                box(cv, ox, oy, u, 11.6f, 3.5f, 14.2f, 17f, 1f);
                poly(cv, ox, oy, u, true, 14.2f, 3.5f, 20.5f, 6f, 20.5f, 10.2f, 14.2f, 7.6f);
                r.set(ox + 5.4f * u, oy + 13.6f * u, ox + 13.4f * u, oy + 20.4f * u);
                cv.drawOval(r, p);
                break;
            case AB:
                p.setStyle(Paint.Style.FILL);
                p.setTextSize(11.5f * u);
                cv.drawText("AB", ox + 12f * u, oy + 16.2f * u, p);
                break;
            case CHECK:
                poly(cv, ox, oy, u, false, 4.5f, 12.8f, 9.8f, 18f, 19.5f, 6f);
                break;
            case CLOSE:
                line(cv, ox, oy, u, 6f, 6f, 18f, 18f);
                line(cv, ox, oy, u, 18f, 6f, 6f, 18f);
                break;
            case UP:
                poly(cv, ox, oy, u, false, 5.5f, 15f, 12f, 8.5f, 18.5f, 15f);
                break;
            case DOWN:
                poly(cv, ox, oy, u, false, 5.5f, 9f, 12f, 15.5f, 18.5f, 9f);
                break;
            case BACK:
                poly(cv, ox, oy, u, false, 15f, 5f, 8f, 12f, 15f, 19f);
                break;
            case RIGHT:
                poly(cv, ox, oy, u, false, 9.5f, 5f, 16.5f, 12f, 9.5f, 19f);
                break;
            case CLOCK:
                cv.drawCircle(ox + 12f * u, oy + 12f * u, 8.8f * u, p);
                line(cv, ox, oy, u, 12f, 12f, 12f, 6.6f);
                line(cv, ox, oy, u, 12f, 12f, 16f, 14f);
                break;
            case LIST:
                for (int i = 0; i < 3; i++) {
                    float y = 6.5f + i * 5.5f;
                    line(cv, ox, oy, u, 8.5f, y, 20f, y);
                    p.setStyle(Paint.Style.FILL);
                    cv.drawCircle(ox + 4.5f * u, oy + y * u, 1.5f * u, p);
                    p.setStyle(Paint.Style.STROKE);
                }
                break;
            case PROGRAM:
                for (int i = 0; i < 3; i++) {
                    float y = 6.5f + i * 5.5f;
                    line(cv, ox, oy, u, 4f, y, 14f, y);
                }
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 17f, 8f, 22f, 12f, 17f, 16f);
                break;
            case WAVE: {
                p.setStyle(Paint.Style.FILL);
                float[] h = { 7f, 13f, 20f, 11f, 6f };
                for (int i = 0; i < 5; i++) {
                    float x = 2.6f + i * 4.4f;
                    box(cv, ox, oy, u, x, 12f - h[i] / 2f, x + 2.8f, 12f + h[i] / 2f, 1.3f);
                }
                break;
            }
            case EDIT:
                poly(cv, ox, oy, u, true, 4f, 20f, 5.2f, 15.6f, 15.6f, 5.2f, 18.8f, 8.4f, 8.4f, 18.8f);
                break;
            case SCISSOR:
                line(cv, ox, oy, u, 6f, 4f, 18f, 18f);
                line(cv, ox, oy, u, 18f, 4f, 6f, 18f);
                cv.drawCircle(ox + 5.5f * u, oy + 19f * u, 2.6f * u, p);
                cv.drawCircle(ox + 18.5f * u, oy + 19f * u, 2.6f * u, p);
                break;
            case MORE:
                p.setStyle(Paint.Style.FILL);
                for (int i = 0; i < 3; i++) cv.drawCircle(ox + 12f * u, oy + (5.5f + i * 6.5f) * u, 1.7f * u, p);
                break;
            case DRAG:
                p.setStyle(Paint.Style.FILL);
                for (int i = 0; i < 3; i++) {
                    cv.drawCircle(ox + 9f * u, oy + (6f + i * 6f) * u, 1.5f * u, p);
                    cv.drawCircle(ox + 15f * u, oy + (6f + i * 6f) * u, 1.5f * u, p);
                }
                break;
            case SEARCH:
                cv.drawCircle(ox + 10.5f * u, oy + 10.5f * u, 6.2f * u, p);
                line(cv, ox, oy, u, 15.2f, 15.2f, 20f, 20f);
                break;
            case COPY:
                box(cv, ox, oy, u, 8f, 8f, 20f, 20f, 2.4f);
                poly(cv, ox, oy, u, false, 16f, 5f, 4.5f, 5f, 4.5f, 16f);
                break;
            case SHUFFLE:
                poly(cv, ox, oy, u, false, 3f, 7f, 8f, 7f, 16f, 17f, 21f, 17f);
                poly(cv, ox, oy, u, false, 3f, 17f, 8f, 17f, 16f, 7f, 21f, 7f);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 18f, 4f, 22f, 7f, 18f, 10f);
                poly(cv, ox, oy, u, true, 18f, 14f, 22f, 17f, 18f, 20f);
                break;
            case RESET:
                r.set(ox + 4.5f * u, oy + 4.5f * u, ox + 19.5f * u, oy + 19.5f * u);
                cv.drawArc(r, -60f, 300f, false, p);
                p.setStyle(Paint.Style.FILL);
                poly(cv, ox, oy, u, true, 11.2f, 2.8f, 6.0f, 3.4f, 8.8f, 8.2f);
                break;
            case BELL:
                path.reset();
                path.moveTo(ox + 6.2f * u, oy + 16.8f * u);
                path.cubicTo(ox + 6.2f * u, oy + 10.4f * u, ox + 8.2f * u, oy + 7.6f * u,
                             ox + 12f * u, oy + 7.6f * u);
                path.cubicTo(ox + 15.8f * u, oy + 7.6f * u, ox + 17.8f * u, oy + 10.4f * u,
                             ox + 17.8f * u, oy + 16.8f * u);
                cv.drawPath(path, p);
                line(cv, ox, oy, u, 4.6f, 16.8f, 19.4f, 16.8f);
                line(cv, ox, oy, u, 12f, 4.8f, 12f, 7.6f);
                p.setStyle(Paint.Style.FILL);
                cv.drawCircle(ox + 12f * u, oy + 19.8f * u, 1.8f * u, p);
                break;
            case MOON:
                path.reset();
                path.moveTo(ox + 19f * u, oy + 15.5f * u);
                path.cubicTo(ox + 13f * u, oy + 17.5f * u, ox + 7f * u, oy + 13f * u,
                             ox + 9.5f * u, oy + 5.5f * u);
                path.cubicTo(ox + 3f * u, oy + 8f * u, ox + 4f * u, oy + 20f * u,
                             ox + 13f * u, oy + 20.5f * u);
                path.cubicTo(ox + 16.5f * u, oy + 20.5f * u, ox + 18.5f * u, oy + 18f * u,
                             ox + 19f * u, oy + 15.5f * u);
                path.close();
                p.setStyle(Paint.Style.FILL);
                cv.drawPath(path, p);
                break;
            default:
                break;
        }
    }

    private void poly(Canvas cv, float ox, float oy, float u, boolean close, float... pts) {
        path.reset();
        for (int i = 0; i + 1 < pts.length; i += 2) {
            if (i == 0) path.moveTo(ox + pts[i] * u, oy + pts[i + 1] * u);
            else path.lineTo(ox + pts[i] * u, oy + pts[i + 1] * u);
        }
        if (close) path.close();
        cv.drawPath(path, p);
    }

    private void box(Canvas cv, float ox, float oy, float u, float l, float t, float rr, float bb, float rad) {
        r.set(ox + l * u, oy + t * u, ox + rr * u, oy + bb * u);
        cv.drawRoundRect(r, rad * u, rad * u, p);
    }

    private void line(Canvas cv, float ox, float oy, float u, float x1, float y1, float x2, float y2) {
        cv.drawLine(ox + x1 * u, oy + y1 * u, ox + x2 * u, oy + y2 * u, p);
    }

    @Override public void setAlpha(int alpha) { p.setAlpha(alpha); invalidateSelf(); }
    @Override public void setColorFilter(ColorFilter cf) { p.setColorFilter(cf); invalidateSelf(); }
    @Override public int getOpacity() { return PixelFormat.TRANSLUCENT; }
    @Override public int getIntrinsicWidth() { return -1; }
    @Override public int getIntrinsicHeight() { return -1; }

    public void setColor(int c) { color = c; invalidateSelf(); }
}
