package com.riola.player;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;

/* JADX INFO: loaded from: classes.dex */
public class Ico extends Drawable {
    public static final int AB = 15;
    public static final int BACK = 26;
    public static final int BELL = 35;
    public static final int CHECK = 16;
    public static final int CLOCK = 20;
    public static final int CLOSE = 17;
    public static final int COPY = 29;
    public static final int DOWN = 19;
    public static final int DRAG = 31;
    public static final int EDIT = 23;
    public static final int FOLDER = 7;
    public static final int GEAR = 12;
    public static final int HELP = 11;
    public static final int LIST = 21;
    public static final int LOOP = 13;
    public static final int MINUS = 30;
    public static final int MOON = 33;
    public static final int MORE = 25;
    public static final int NEXT = 4;
    public static final int NOTE = 14;
    public static final int OPEN = 10;
    public static final int PAUSE = 2;
    public static final int PLAY = 1;
    public static final int PLUS = 6;
    public static final int PREV = 5;
    public static final int PROGRAM = 32;
    public static final int RESET = 34;
    public static final int RIGHT = 27;
    public static final int SAVE = 9;
    public static final int SCISSOR = 24;
    public static final int SEARCH = 28;
    public static final int SHUFFLE = 36;
    public static final int STOP = 3;
    public static final int TRASH = 8;
    public static final int UP = 18;
    public static final int WAVE = 22;
    private int color;
    private final int id;
    private final Paint p = new Paint(1);
    private final Path path = new Path();
    private final RectF r = new RectF();

    public Ico(int i, int i2) {
        this.id = i;
        this.color = i2;
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        Rect bounds = getBounds();
        float fMin = Math.min(bounds.width(), bounds.height());
        if (fMin <= 0.0f) {
        }
        float f = fMin / 24.0f;
        float f2 = f * 12.0f;
        float fExactCenterX = bounds.exactCenterX() - f2;
        float fExactCenterY = bounds.exactCenterY() - f2;
        this.p.setColor(this.color);
        this.p.setStrokeWidth(Ui.ICON_W * f);
        this.p.setStrokeCap(Ui.SQUARE_ICONS ? Paint.Cap.BUTT : Paint.Cap.ROUND);
        this.p.setStrokeJoin(Ui.SQUARE_ICONS ? Paint.Join.MITER : Paint.Join.ROUND);
        this.p.setStyle(Paint.Style.STROKE);
        this.p.setTextAlign(Paint.Align.CENTER);
        int i = 0;
        switch (this.id) {
            case 1:
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 6.5f, 4.0f, 19.5f, 12.0f, 6.5f, 20.0f);
                break;
            case 2:
                this.p.setStyle(Paint.Style.FILL);
                box(canvas, fExactCenterX, fExactCenterY, f, 6.5f, 4.0f, 10.5f, 20.0f, 1.4f);
                box(canvas, fExactCenterX, fExactCenterY, f, 13.5f, 4.0f, 17.5f, 20.0f, 1.4f);
                break;
            case 3:
                this.p.setStyle(Paint.Style.FILL);
                box(canvas, fExactCenterX, fExactCenterY, f, 5.5f, 5.5f, 18.5f, 18.5f, 2.4f);
                break;
            case 4:
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 5.0f, 4.0f, 15.5f, 12.0f, 5.0f, 20.0f);
                box(canvas, fExactCenterX, fExactCenterY, f, 16.5f, 4.0f, 19.5f, 20.0f, 1.2f);
                break;
            case 5:
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 19.0f, 4.0f, 8.5f, 12.0f, 19.0f, 20.0f);
                box(canvas, fExactCenterX, fExactCenterY, f, 4.5f, 4.0f, 7.5f, 20.0f, 1.2f);
                break;
            case 6:
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 5.0f, 12.0f, 19.0f);
                line(canvas, fExactCenterX, fExactCenterY, f, 5.0f, 12.0f, 19.0f, 12.0f);
                break;
            case 7:
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 3.0f, 19.0f, 3.0f, 5.5f, 9.0f, 5.5f, 11.0f, 8.5f, 21.0f, 8.5f, 21.0f, 19.0f);
                break;
            case 8:
                box(canvas, fExactCenterX, fExactCenterY, f, 6.0f, 7.5f, 18.0f, 20.5f, 2.0f);
                line(canvas, fExactCenterX, fExactCenterY, f, 3.5f, 7.5f, 20.5f, 7.5f);
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 9.0f, 7.5f, 9.0f, 4.0f, 15.0f, 4.0f, 15.0f, 7.5f);
                break;
            case 9:
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 3.5f, 12.0f, 15.0f);
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 7.0f, 10.5f, 12.0f, 15.5f, 17.0f, 10.5f);
                line(canvas, fExactCenterX, fExactCenterY, f, 4.5f, 20.0f, 19.5f, 20.0f);
                break;
            case OPEN /* 10 */:
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 15.5f, 12.0f, 4.0f);
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 7.0f, 9.0f, 12.0f, 4.0f, 17.0f, 9.0f);
                line(canvas, fExactCenterX, fExactCenterY, f, 4.5f, 20.0f, 19.5f, 20.0f);
                break;
            case HELP /* 11 */:
                float f3 = fExactCenterX + f2;
                canvas.drawCircle(f3, f2 + fExactCenterY, f * 8.8f, this.p);
                this.p.setStyle(Paint.Style.FILL);
                this.p.setTextSize(13.0f * f);
                canvas.drawText("?", f3, fExactCenterY + (f * 16.6f), this.p);
                break;
            case GEAR /* 12 */:
                float f4 = fExactCenterX + f2;
                float f5 = fExactCenterY + f2;
                for (int i2 = 0; i2 < 8; i2++) {
                    canvas.save();
                    canvas.rotate(i2 * 45.0f, f4, f5);
                    float f6 = 1.9f * f;
                    this.r.set(f4 - f6, f5 - (11.0f * f), f6 + f4, f5 - (6.4f * f));
                    this.p.setStyle(Paint.Style.FILL);
                    float f7 = 0.8f * f;
                    canvas.drawRoundRect(this.r, f7, f7, this.p);
                    canvas.restore();
                }
                this.p.setStyle(Paint.Style.STROKE);
                this.p.setStrokeWidth(f * 2.6f);
                canvas.drawCircle(f4, f5, 6.4f * f, this.p);
                this.p.setStrokeWidth(1.9f * f);
                this.p.setColor(0);
                this.p.setStyle(Paint.Style.FILL);
                this.p.setColor(this.color);
                this.p.setStyle(Paint.Style.STROKE);
                canvas.drawCircle(f4, f5, f * 3.1f, this.p);
                break;
            case LOOP /* 13 */:
                this.r.set((3.5f * f) + fExactCenterX, fExactCenterY + (6.5f * f), (20.5f * f) + fExactCenterX, (17.5f * f) + fExactCenterY);
                float f8 = f * 5.5f;
                canvas.drawRoundRect(this.r, f8, f8, this.p);
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 13.0f, 3.6f, 17.5f, 6.5f, 13.0f, 9.4f);
                break;
            case NOTE /* 14 */:
                this.p.setStyle(Paint.Style.FILL);
                box(canvas, fExactCenterX, fExactCenterY, f, 11.6f, 3.5f, 14.2f, 17.0f, 1.0f);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 14.2f, 3.5f, 20.5f, 6.0f, 20.5f, 10.2f, 14.2f, 7.6f);
                this.r.set((5.4f * f) + fExactCenterX, (13.6f * f) + fExactCenterY, fExactCenterX + (13.4f * f), fExactCenterY + (f * 20.4f));
                canvas.drawOval(this.r, this.p);
                break;
            case AB /* 15 */:
                this.p.setStyle(Paint.Style.FILL);
                this.p.setTextSize(11.5f * f);
                canvas.drawText("AB", fExactCenterX + f2, fExactCenterY + (f * 16.2f), this.p);
                break;
            case CHECK /* 16 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 4.5f, 12.8f, 9.8f, 18.0f, 19.5f, 6.0f);
                break;
            case CLOSE /* 17 */:
                line(canvas, fExactCenterX, fExactCenterY, f, 6.0f, 6.0f, 18.0f, 18.0f);
                line(canvas, fExactCenterX, fExactCenterY, f, 18.0f, 6.0f, 6.0f, 18.0f);
                break;
            case UP /* 18 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 5.5f, 15.0f, 12.0f, 8.5f, 18.5f, 15.0f);
                break;
            case DOWN /* 19 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 5.5f, 9.0f, 12.0f, 15.5f, 18.5f, 9.0f);
                break;
            case CLOCK /* 20 */:
                canvas.drawCircle(fExactCenterX + f2, f2 + fExactCenterY, f * 8.8f, this.p);
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 12.0f, 12.0f, 6.6f);
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 12.0f, 16.0f, 14.0f);
                break;
            case LIST /* 21 */:
                for (int i3 = 0; i3 < 3; i3++) {
                    float f9 = (i3 * 5.5f) + 6.5f;
                    line(canvas, fExactCenterX, fExactCenterY, f, 8.5f, f9, 20.0f, f9);
                    this.p.setStyle(Paint.Style.FILL);
                    canvas.drawCircle((f * 4.5f) + fExactCenterX, fExactCenterY + (f9 * f), f * 1.5f, this.p);
                    this.p.setStyle(Paint.Style.STROKE);
                }
                break;
            case WAVE /* 22 */:
                this.p.setStyle(Paint.Style.FILL);
                float[] fArr = {7.0f, 13.0f, 20.0f, 11.0f, 6.0f};
                int i4 = 0;
                while (i4 < 5) {
                    float f10 = (i4 * 4.4f) + 2.6f;
                    float f11 = fArr[i4];
                    box(canvas, fExactCenterX, fExactCenterY, f, f10, 12.0f - (f11 / 2.0f), f10 + 2.8f, (f11 / 2.0f) + 12.0f, 1.3f);
                    i4++;
                    fArr = fArr;
                }
                break;
            case EDIT /* 23 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 4.0f, 20.0f, 5.2f, 15.6f, 15.6f, 5.2f, 18.8f, 8.4f, 8.4f, 18.8f);
                break;
            case SCISSOR /* 24 */:
                line(canvas, fExactCenterX, fExactCenterY, f, 6.0f, 4.0f, 18.0f, 18.0f);
                line(canvas, fExactCenterX, fExactCenterY, f, 18.0f, 4.0f, 6.0f, 18.0f);
                float f12 = fExactCenterY + (19.0f * f);
                float f13 = f * 2.6f;
                canvas.drawCircle(fExactCenterX + (5.5f * f), f12, f13, this.p);
                canvas.drawCircle(fExactCenterX + (f * 18.5f), f12, f13, this.p);
                break;
            case MORE /* 25 */:
                this.p.setStyle(Paint.Style.FILL);
                while (i < 3) {
                    canvas.drawCircle(fExactCenterX + f2, (((i * 6.5f) + 5.5f) * f) + fExactCenterY, 1.7f * f, this.p);
                    i++;
                }
                break;
            case BACK /* 26 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 15.0f, 5.0f, 8.0f, 12.0f, 15.0f, 19.0f);
                break;
            case RIGHT /* 27 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 9.5f, 5.0f, 16.5f, 12.0f, 9.5f, 19.0f);
                break;
            case SEARCH /* 28 */:
                float f14 = 10.5f * f;
                canvas.drawCircle(fExactCenterX + f14, f14 + fExactCenterY, 6.2f * f, this.p);
                line(canvas, fExactCenterX, fExactCenterY, f, 15.2f, 15.2f, 20.0f, 20.0f);
                break;
            case COPY /* 29 */:
                box(canvas, fExactCenterX, fExactCenterY, f, 8.0f, 8.0f, 20.0f, 20.0f, 2.4f);
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 16.0f, 5.0f, 4.5f, 5.0f, 4.5f, 16.0f);
                break;
            case MINUS /* 30 */:
                line(canvas, fExactCenterX, fExactCenterY, f, 5.0f, 12.0f, 19.0f, 12.0f);
                break;
            case DRAG /* 31 */:
                this.p.setStyle(Paint.Style.FILL);
                while (i < 3) {
                    float f15 = (((i * 6.0f) + 6.0f) * f) + fExactCenterY;
                    float f16 = f * 1.5f;
                    canvas.drawCircle((9.0f * f) + fExactCenterX, f15, f16, this.p);
                    canvas.drawCircle((15.0f * f) + fExactCenterX, f15, f16, this.p);
                    i++;
                }
                break;
            case PROGRAM /* 32 */:
                int i5 = 0;
                for (int i6 = 3; i5 < i6; i6 = 3) {
                    float f17 = (i5 * 5.5f) + 6.5f;
                    line(canvas, fExactCenterX, fExactCenterY, f, 4.0f, f17, 14.0f, f17);
                    i5++;
                }
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 17.0f, 8.0f, 22.0f, 12.0f, 17.0f, 16.0f);
                break;
            case MOON /* 33 */:
                this.path.reset();
                float f18 = fExactCenterX + (19.0f * f);
                float f19 = (15.5f * f) + fExactCenterY;
                this.path.moveTo(f18, f19);
                float f20 = 13.0f * f;
                float f21 = fExactCenterX + f20;
                this.path.cubicTo(f21, fExactCenterY + (17.5f * f), fExactCenterX + (7.0f * f), fExactCenterY + f20, fExactCenterX + (9.5f * f), fExactCenterY + (5.5f * f));
                float f22 = fExactCenterY + (20.5f * f);
                this.path.cubicTo(fExactCenterX + (3.0f * f), fExactCenterY + (8.0f * f), fExactCenterX + (4.0f * f), fExactCenterY + (20.0f * f), f21, f22);
                this.path.cubicTo(fExactCenterX + (16.5f * f), f22, fExactCenterX + (18.5f * f), fExactCenterY + (f * 18.0f), f18, f19);
                this.path.close();
                this.p.setStyle(Paint.Style.FILL);
                canvas.drawPath(this.path, this.p);
                break;
            case RESET /* 34 */:
                float f23 = 4.5f * f;
                float f24 = 19.5f * f;
                this.r.set(fExactCenterX + f23, fExactCenterY + f23, fExactCenterX + f24, f24 + fExactCenterY);
                canvas.drawArc(this.r, -60.0f, 300.0f, false, this.p);
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 11.2f, 2.8f, 6.0f, 3.4f, 8.8f, 8.2f);
                break;
            case BELL /* 35 */:
                this.path.reset();
                float f25 = fExactCenterX + (6.2f * f);
                float f26 = (16.8f * f) + fExactCenterY;
                this.path.moveTo(f25, f26);
                float f27 = fExactCenterY + (10.4f * f);
                float f28 = fExactCenterY + (7.6f * f);
                float f29 = fExactCenterX + f2;
                this.path.cubicTo(f25, f27, fExactCenterX + (8.2f * f), f28, f29, f28);
                float f30 = fExactCenterX + (17.8f * f);
                this.path.cubicTo(fExactCenterX + (15.8f * f), f28, f30, f27, f30, f26);
                canvas.drawPath(this.path, this.p);
                line(canvas, fExactCenterX, fExactCenterY, f, 4.6f, 16.8f, 19.4f, 16.8f);
                line(canvas, fExactCenterX, fExactCenterY, f, 12.0f, 4.8f, 12.0f, 7.6f);
                this.p.setStyle(Paint.Style.FILL);
                canvas.drawCircle(f29, fExactCenterY + (19.8f * f), f * 1.8f, this.p);
                break;
            case SHUFFLE /* 36 */:
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 3.0f, 7.0f, 8.0f, 7.0f, 16.0f, 17.0f, 21.0f, 17.0f);
                poly(canvas, fExactCenterX, fExactCenterY, f, false, 3.0f, 17.0f, 8.0f, 17.0f, 16.0f, 7.0f, 21.0f, 7.0f);
                this.p.setStyle(Paint.Style.FILL);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 18.0f, 4.0f, 22.0f, 7.0f, 18.0f, 10.0f);
                poly(canvas, fExactCenterX, fExactCenterY, f, true, 18.0f, 14.0f, 22.0f, 17.0f, 18.0f, 20.0f);
                break;
        }
    }

    private void poly(Canvas canvas, float f, float f2, float f3, boolean z, float... fArr) {
        this.path.reset();
        int i = 0;
        while (true) {
            int i2 = i + 1;
            if (i2 >= fArr.length) {
                break;
            }
            if (i == 0) {
                this.path.moveTo((fArr[i] * f3) + f, (fArr[i2] * f3) + f2);
            } else {
                this.path.lineTo((fArr[i] * f3) + f, (fArr[i2] * f3) + f2);
            }
            i += 2;
        }
        if (z) {
            this.path.close();
        }
        canvas.drawPath(this.path, this.p);
    }

    private void box(Canvas canvas, float f, float f2, float f3, float f4, float f5, float f6, float f7, float f8) {
        this.r.set((f4 * f3) + f, (f5 * f3) + f2, f + (f6 * f3), f2 + (f7 * f3));
        float f9 = f8 * f3;
        canvas.drawRoundRect(this.r, f9, f9, this.p);
    }

    private void line(Canvas canvas, float f, float f2, float f3, float f4, float f5, float f6, float f7) {
        canvas.drawLine(f + (f4 * f3), f2 + (f5 * f3), f + (f6 * f3), f2 + (f7 * f3), this.p);
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        this.p.setAlpha(i);
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        this.p.setColorFilter(colorFilter);
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        return -3;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        return -1;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        return -1;
    }

    public void setColor(int i) {
        this.color = i;
        invalidateSelf();
    }
}
