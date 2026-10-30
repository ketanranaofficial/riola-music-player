package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.HapticFeedbackConstants;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

/**
 * A very small design system: one palette plus factory methods for the widgets
 * the app needs. No AndroidX, no XML layouts.
 */
public final class Ui {

    public static final int PRIMARY = 0, SECONDARY = 1, DANGER = 2, GHOST = 3;
    public static final int MATCH = ViewGroup.LayoutParams.MATCH_PARENT;
    public static final int WRAP  = ViewGroup.LayoutParams.WRAP_CONTENT;

    public interface OnToggle { void set(boolean v); }
    public interface OnSlide  { void set(int v); }
    public interface OnValue  { void set(int v); }
    public interface OnPick   { void set(int index); }

    public static boolean dark = true;
    public static int BG, SURF, SURF2, LINE, TXT, DIM, ACC, ACC2, RED, GREEN, AMBER, RIPPLE, ONACC, FIELD;
    /** The accent, nudged until it is legible as text on a card. */
    public static int ACC_TXT;
    /** The accent at a whisper, for the highlight behind the playing step. */
    public static int ACC_SOFT;

    /** Colours offered in settings. Any other colour can be mixed by hand. */
    public static final int[] ACCENTS = {
        0xFF4CC2FF, 0xFF25D0B8, 0xFFFF5FA2, 0xFF9B7CFF,
        0xFFFFB300, 0xFF7ED957, 0xFFFF7043, 0xFF5C9DFF
    };
    public static final String[] ACCENT_NAMES = {
        "Aqua", "Teal", "Magenta", "Violet",
        "Amber", "Lime", "Coral", "Sky"
    };

    public static final int STYLE_MATERIAL = 0, STYLE_ELEGANT = 1, STYLE_RETRO = 2,
                            STYLE_CODER = 3, STYLE_98 = 4, STYLE_FUTURE = 5,
                            STYLE_NEON = 6, STYLE_PASTEL = 7, STYLE_BRUTAL = 8,
                            STYLE_MINIMAL = 9;
    public static final String[] STYLE_NAMES = {
        "Material", "Elegant", "Retro", "Coder", "98", "Futuristic",
        "Neon", "Pastel", "Brutalist", "Minimal"
    };
    public static final String[] STYLE_NOTES = {
        "Soft corners and quiet lines. The default.",
        "Serif type, thin rules, room to breathe.",
        "Warm paper, heavy borders, chunky type.",
        "Monospace everything and square corners.",
        "Grey panels and hard edges, like an old desktop.",
        "Wide letter spacing and very round shapes.",
        "Deep night, bright edges, everything glowing.",
        "Soft and quiet. Easy on the eyes late at night.",
        "Stark and heavy. Thick black rules, nothing soft.",
        "No borders at all. Space does the work."
    };

    // metrics the look controls
    public static float RAD_CARD, RAD_BTN, RAD_CHIP, STROKE_W, TRACK_SP, ICON_W, PAD;
    public static Typeface FONT, FONT_BOLD;
    public static boolean CAPS_HEADINGS, SQUARE_ICONS;
    public static int style = STYLE_MATERIAL;

    private Ui() { }

    public static void theme(Prefs p) {
        theme(p.dark(), p.accent(), p.style());
    }

    public static void theme(boolean isDark, int accent, int look) {
        dark = isDark;
        style = look < 0 || look >= STYLE_NAMES.length ? STYLE_MATERIAL : look;

        if (isDark) {
            BG    = 0xFF0E1116; SURF  = 0xFF161C24; SURF2 = 0xFF1E2630; LINE  = 0xFF2C3542;
            TXT   = 0xFFE8EDF3; DIM   = 0xFF93A1B0;
            RED   = 0xFFFF6B6B; GREEN = 0xFF3DDC97; AMBER = 0xFFFFC65C;
            RIPPLE = 0x33FFFFFF; FIELD = 0xFF0B0F14;
        } else {
            BG    = 0xFFF4F6FA; SURF  = 0xFFFFFFFF; SURF2 = 0xFFEDF1F7; LINE  = 0xFFD6DEE8;
            TXT   = 0xFF12181F; DIM   = 0xFF5A6673;
            RED   = 0xFFD03A3A; GREEN = 0xFF10875A; AMBER = 0xFFA97400;
            RIPPLE = 0x22000000; FIELD = 0xFFF8FAFC;
        }

        ACC = accent == 0 ? ACCENTS[0] : accent;
        ACC2 = shift(ACC, isDark);
        ONACC = luminance(ACC) > 0.55f ? 0xFF101418 : 0xFFFFFFFF;

        // defaults, then the look adjusts them
        RAD_CARD = 18; RAD_BTN = 12; RAD_CHIP = 20; STROKE_W = 1f;
        TRACK_SP = 0.12f; ICON_W = 1.9f; PAD = 1f;
        FONT = Typeface.DEFAULT; FONT_BOLD = Typeface.DEFAULT_BOLD;
        CAPS_HEADINGS = true; SQUARE_ICONS = false;

        switch (style) {
            case STYLE_ELEGANT:
                RAD_CARD = 6; RAD_BTN = 4; RAD_CHIP = 14; STROKE_W = 0.8f;
                TRACK_SP = 0.05f; ICON_W = 1.5f; PAD = 1.15f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, Typeface.BOLD);
                CAPS_HEADINGS = false;
                break;
            case STYLE_RETRO:
                RAD_CARD = 10; RAD_BTN = 8; RAD_CHIP = 12; STROKE_W = 2.2f;
                TRACK_SP = 0.08f; ICON_W = 2.4f; PAD = 1.05f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, Typeface.BOLD);
                if (isDark) {
                    BG = 0xFF17120E; SURF = 0xFF231A13; SURF2 = 0xFF2E231A; LINE = 0xFF4A3928;
                    TXT = 0xFFF3E7D6; DIM = 0xFFB9A487; FIELD = 0xFF120E0A;
                } else {
                    BG = 0xFFF6EFE2; SURF = 0xFFFFF9EE; SURF2 = 0xFFEFE4D2; LINE = 0xFFCBB694;
                    TXT = 0xFF2C2114; DIM = 0xFF7A6650; FIELD = 0xFFFFFBF3;
                }
                break;
            case STYLE_CODER:
                RAD_CARD = 2; RAD_BTN = 2; RAD_CHIP = 2; STROKE_W = 1.4f;
                TRACK_SP = 0.02f; ICON_W = 2f; PAD = 0.95f;
                FONT = Typeface.MONOSPACE;
                FONT_BOLD = Typeface.create(Typeface.MONOSPACE, Typeface.BOLD);
                CAPS_HEADINGS = false; SQUARE_ICONS = true;
                if (isDark) {
                    BG = 0xFF07090B; SURF = 0xFF0D1116; SURF2 = 0xFF141A21; LINE = 0xFF243040;
                    TXT = 0xFFD7E4D7; DIM = 0xFF7C8C7C; FIELD = 0xFF05070A;
                } else {
                    BG = 0xFFF7F8F5; SURF = 0xFFFFFFFF; SURF2 = 0xFFEDF0EA; LINE = 0xFFC9D2C4;
                    TXT = 0xFF13201A; DIM = 0xFF5A6B5F; FIELD = 0xFFFBFCFA;
                }
                break;
            case STYLE_98:
                RAD_CARD = 0; RAD_BTN = 0; RAD_CHIP = 0; STROKE_W = 2.4f;
                TRACK_SP = 0f; ICON_W = 2.2f; PAD = 0.9f;
                CAPS_HEADINGS = false; SQUARE_ICONS = true;
                if (isDark) {
                    BG = 0xFF2B2B2B; SURF = 0xFF3C3C3C; SURF2 = 0xFF4A4A4A; LINE = 0xFF7A7A7A;
                    TXT = 0xFFF0F0F0; DIM = 0xFFB4B4B4; FIELD = 0xFF262626;
                } else {
                    BG = 0xFFBFBFBF; SURF = 0xFFD8D8D8; SURF2 = 0xFFCCCCCC; LINE = 0xFF6E6E6E;
                    TXT = 0xFF101010; DIM = 0xFF4A4A4A; FIELD = 0xFFFFFFFF;
                }
                break;
            case STYLE_FUTURE:
                RAD_CARD = 26; RAD_BTN = 22; RAD_CHIP = 24; STROKE_W = 1f;
                TRACK_SP = 0.22f; ICON_W = 1.4f; PAD = 1.1f;
                if (isDark) {
                    BG = 0xFF080B14; SURF = 0xFF101528; SURF2 = 0xFF171E36; LINE = 0xFF2A3358;
                    TXT = 0xFFEDF1FF; DIM = 0xFF8E9AC6; FIELD = 0xFF070A12;
                } else {
                    BG = 0xFFF2F4FF; SURF = 0xFFFFFFFF; SURF2 = 0xFFEAEDFB; LINE = 0xFFC9D0F0;
                    TXT = 0xFF141833; DIM = 0xFF5F6790; FIELD = 0xFFF8F9FF;
                }
                break;
            case STYLE_NEON:
                RAD_CARD = 20; RAD_BTN = 16; RAD_CHIP = 22; STROKE_W = 1.3f;
                TRACK_SP = 0.14f; ICON_W = 1.7f; PAD = 1f;
                if (isDark) {
                    BG = 0xFF05060C; SURF = 0xFF0B0F1C; SURF2 = 0xFF121A2E; LINE = 0xFF2C3C6E;
                    TXT = 0xFFE9F1FF; DIM = 0xFF7C8CC4; FIELD = 0xFF04050A;
                } else {
                    BG = 0xFF11131C; SURF = 0xFF1A1E2C; SURF2 = 0xFF232838; LINE = 0xFF3C4A78;
                    TXT = 0xFFF0F3FF; DIM = 0xFF98A2C0; FIELD = 0xFF0F111A;
                }
                break;
            case STYLE_PASTEL:
                RAD_CARD = 22; RAD_BTN = 18; RAD_CHIP = 24; STROKE_W = 0.9f;
                TRACK_SP = 0.03f; ICON_W = 1.6f; PAD = 1.15f;
                CAPS_HEADINGS = false;
                if (isDark) {
                    BG = 0xFF191625; SURF = 0xFF221E31; SURF2 = 0xFF2C2740; LINE = 0xFF3F3857;
                    TXT = 0xFFEDE7FA; DIM = 0xFFA79CC4; FIELD = 0xFF15121F;
                } else {
                    BG = 0xFFFAF7FF; SURF = 0xFFFFFFFF; SURF2 = 0xFFF3EDFB; LINE = 0xFFE3D9F2;
                    TXT = 0xFF3B3350; DIM = 0xFF8B82A6; FIELD = 0xFFFDFBFF;
                }
                break;
            case STYLE_BRUTAL:
                RAD_CARD = 0; RAD_BTN = 0; RAD_CHIP = 0; STROKE_W = 3.2f;
                TRACK_SP = 0.02f; ICON_W = 2.8f; PAD = 1f;
                SQUARE_ICONS = true;
                FONT_BOLD = Typeface.DEFAULT_BOLD;
                if (isDark) {
                    BG = 0xFF000000; SURF = 0xFF0B0B0B; SURF2 = 0xFF141414; LINE = 0xFFFFFFFF;
                    TXT = 0xFFFFFFFF; DIM = 0xFFA8A8A8; FIELD = 0xFF000000;
                } else {
                    BG = 0xFFFFFFFF; SURF = 0xFFFFFFFF; SURF2 = 0xFFF2F2F2; LINE = 0xFF000000;
                    TXT = 0xFF000000; DIM = 0xFF444444; FIELD = 0xFFFFFFFF;
                }
                break;
            case STYLE_MINIMAL:
                RAD_CARD = 10; RAD_BTN = 8; RAD_CHIP = 12; STROKE_W = 0f;
                TRACK_SP = 0.06f; ICON_W = 1.4f; PAD = 1.25f;
                CAPS_HEADINGS = false;
                if (isDark) {
                    BG = 0xFF101215; SURF = 0xFF16191D; SURF2 = 0xFF1C2025; LINE = 0xFF262B31;
                    TXT = 0xFFE6E9EC; DIM = 0xFF8B9299; FIELD = 0xFF0D0F12;
                } else {
                    BG = 0xFFFBFBFC; SURF = 0xFFFFFFFF; SURF2 = 0xFFF4F5F7; LINE = 0xFFE8EAED;
                    TXT = 0xFF1B1E22; DIM = 0xFF6B7278; FIELD = 0xFFFFFFFF;
                }
                break;
            default:
                break;
        }

        // Only now are the surfaces final, so the legible accent has to be
        // worked out here rather than above: a pale accent is invisible on a
        // white card, and a dark one vanishes on a black one.
        ACC_TXT = readable(ACC, SURF, isDark);
        ACC_SOFT = blend(ACC, SURF, isDark ? 0.20f : 0.14f);
    }

    /** Lighten or darken the accent until it stands off the surface behind it. */
    private static int readable(int accent, int surface, boolean isDark) {
        float[] hsv = new float[3];
        android.graphics.Color.colorToHSV(accent, hsv);
        int c = accent;
        for (int i = 0; i < 30 && contrast(c, surface) < 3.4f; i++) {
            hsv[2] = isDark ? Math.min(1f, hsv[2] + 0.035f) : Math.max(0.12f, hsv[2] - 0.035f);
            if (isDark && hsv[1] > 0.18f) hsv[1] = Math.max(0.18f, hsv[1] - 0.012f);
            c = android.graphics.Color.HSVToColor(hsv);
        }
        return c;
    }

    private static float contrast(int a, int b) {
        float la = luminance(a), lb = luminance(b);
        float hi = Math.max(la, lb), lo = Math.min(la, lb);
        return (hi + 0.05f) / (lo + 0.05f);
    }

    public static int blend(int fg, int bg, float amount) {
        int r = (int) (((fg >> 16) & 0xFF) * amount + ((bg >> 16) & 0xFF) * (1 - amount));
        int g = (int) (((fg >> 8) & 0xFF) * amount + ((bg >> 8) & 0xFF) * (1 - amount));
        int b = (int) ((fg & 0xFF) * amount + (bg & 0xFF) * (1 - amount));
        return 0xFF000000 | (r << 16) | (g << 8) | b;
    }

    /** A companion colour for the accent, used for small marks. */
    private static int shift(int c, boolean isDark) {
        float[] hsv = new float[3];
        android.graphics.Color.colorToHSV(c, hsv);
        hsv[0] = (hsv[0] + 38f) % 360f;
        hsv[1] = Math.min(1f, hsv[1] * 0.95f);
        hsv[2] = isDark ? Math.min(1f, hsv[2] * 1.05f) : hsv[2] * 0.9f;
        return android.graphics.Color.HSVToColor(hsv);
    }

    /** Rough perceived brightness, for deciding what reads on top of the accent. */
    public static float luminance(int c) {
        int r = (c >> 16) & 0xFF, g = (c >> 8) & 0xFF, b = c & 0xFF;
        return (0.299f * r + 0.587f * g + 0.114f * b) / 255f;
    }

    public static int dp(Context c, float v) {
        return Math.round(v * c.getResources().getDisplayMetrics().density);
    }

    public static void applyWindow(Activity a) {
        a.getWindow().setStatusBarColor(BG);
        a.getWindow().setNavigationBarColor(BG);
        int flags = dark ? 0 : (View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR | View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR);
        a.getWindow().getDecorView().setSystemUiVisibility(flags);
    }

    public static int themeRes(boolean isDark) {
        return isDark ? android.R.style.Theme_Material_NoActionBar
                      : android.R.style.Theme_Material_Light_NoActionBar;
    }

    public static AlertDialog.Builder dialog(Activity a) {
        return new AlertDialog.Builder(a, dark ? R.style.RiolaDialog : R.style.RiolaDialogLight);
    }

    public static void toast(Context c, String s) { Toast.makeText(c, s, Toast.LENGTH_SHORT).show(); }

    public static void buzz(View v) {
        try { v.performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY); } catch (Exception e) { }
    }

    // ---- drawables -------------------------------------------------------
    public static GradientDrawable rr(Context c, int fill, float radDp) {
        GradientDrawable g = new GradientDrawable();
        g.setColor(fill);
        g.setCornerRadius(dp(c, radDp));
        return g;
    }

    public static GradientDrawable rrs(Context c, int fill, int stroke, float radDp, float wDp) {
        GradientDrawable g = rr(c, fill, radDp);
        if (wDp > 0f) g.setStroke(Math.max(1, dp(c, wDp)), stroke);
        return g;
    }

    public static Drawable ripple(Drawable content) {
        return new RippleDrawable(ColorStateList.valueOf(RIPPLE), content, null);
    }

    // ---- layout params ---------------------------------------------------
    public static LinearLayout.LayoutParams lp(int w, int h) {
        return new LinearLayout.LayoutParams(w, h);
    }

    public static LinearLayout.LayoutParams lpw(int w, int h, float weight) {
        return new LinearLayout.LayoutParams(w, h, weight);
    }

    public static View margin(Context c, View v, float l, float t, float r, float b) {
        ViewGroup.LayoutParams p = v.getLayoutParams();
        LinearLayout.LayoutParams lp = (p instanceof LinearLayout.LayoutParams)
                ? (LinearLayout.LayoutParams) p : new LinearLayout.LayoutParams(MATCH, WRAP);
        lp.setMargins(dp(c, l), dp(c, t), dp(c, r), dp(c, b));
        v.setLayoutParams(lp);
        return v;
    }

    public static View weight(View v, float w) {
        v.setLayoutParams(lpw(0, WRAP, w));
        return v;
    }

    // ---- containers ------------------------------------------------------
    public static LinearLayout col(Context c) {
        LinearLayout l = new LinearLayout(c);
        l.setOrientation(LinearLayout.VERTICAL);
        l.setLayoutParams(lp(MATCH, WRAP));
        return l;
    }

    public static LinearLayout row(Context c) {
        LinearLayout l = new LinearLayout(c);
        l.setOrientation(LinearLayout.HORIZONTAL);
        l.setGravity(Gravity.CENTER_VERTICAL);
        l.setLayoutParams(lp(MATCH, WRAP));
        return l;
    }

    public static LinearLayout card(Context c) {
        LinearLayout l = col(c);
        l.setBackground(rrs(c, SURF, LINE, RAD_CARD, STROKE_W));
        int p = dp(c, 14 * PAD);
        l.setPadding(p, dp(c, 12 * PAD), p, dp(c, 12 * PAD));
        margin(c, l, 12, 0, 12, 10);
        return l;
    }

    /** A scrolling body that stretches between the header and whatever is pinned below. */
    public static ScrollView scroller(Context c, LinearLayout body) {
        ScrollView sv = new ScrollView(c);
        sv.setLayoutParams(lpw(MATCH, 0, 1f));
        sv.setFillViewport(true);
        sv.addView(body, new FrameLayout.LayoutParams(MATCH, WRAP));
        return sv;
    }

    public static View gap(Context c, float h) {
        View v = new View(c);
        v.setLayoutParams(lp(MATCH, dp(c, h)));
        return v;
    }

    public static View hgap(Context c, float w) {
        View v = new View(c);
        v.setLayoutParams(lp(dp(c, w), 1));
        return v;
    }

    public static View spring(Context c) {
        View v = new View(c);
        v.setLayoutParams(lpw(0, 1, 1f));
        return v;
    }

    public static View divider(Context c) {
        View v = new View(c);
        v.setBackgroundColor(LINE);
        LinearLayout.LayoutParams p = lp(MATCH, Math.max(1, dp(c, 0.7f)));
        p.setMargins(0, dp(c, 8), 0, dp(c, 8));
        v.setLayoutParams(p);
        return v;
    }

    // ---- text ------------------------------------------------------------
    public static TextView tv(Context c, String s, float sp, int color, boolean bold) {
        TextView t = new TextView(c);
        t.setText(s);
        t.setTextSize(sp);
        t.setTextColor(color);
        t.setTypeface(bold ? FONT_BOLD : FONT);
        t.setLayoutParams(lp(WRAP, WRAP));
        return t;
    }

    public static TextView mono(Context c, String s, float sp, int color) {
        TextView t = tv(c, s, sp, color, false);
        t.setTypeface(Typeface.MONOSPACE);
        return t;
    }

    public static LinearLayout heading(Context c, int icoId, String text) {
        LinearLayout r = row(c);
        if (icoId > 0) {
            r.addView(icon(c, icoId, ACC_TXT, 16));
            r.addView(hgap(c, 8));
        }
        TextView t = tv(c, CAPS_HEADINGS ? text.toUpperCase() : text, 12, DIM, true);
        t.setLetterSpacing(TRACK_SP);
        r.addView(t);
        margin(c, r, 0, 0, 0, 8);
        return r;
    }

    public static TextView badge(Context c, String s, int fg, int bg) {
        TextView t = tv(c, s, 10, fg, true);
        t.setBackground(rr(c, bg, 20));
        t.setPadding(dp(c, 8), dp(c, 3), dp(c, 8), dp(c, 3));
        t.setLetterSpacing(0.06f);
        return t;
    }

    public static void ellipsize(TextView t) {
        t.setSingleLine(true);
        t.setEllipsize(TextUtils.TruncateAt.END);
    }

    // ---- icons and buttons ----------------------------------------------
    public static ImageView icon(Context c, int icoId, int color, int sizeDp) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        v.setLayoutParams(lp(dp(c, sizeDp), dp(c, sizeDp)));
        return v;
    }

    public static ImageView iconBtn(Context c, int icoId, int color, int sizeDp, String describe, View.OnClickListener l) {
        return iconBtn(c, icoId, color, sizeDp, 9, describe, l);
    }

    public static ImageView iconBtn(Context c, int icoId, int color, int sizeDp, int padDp,
                                    String describe, View.OnClickListener l) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, color));
        int pad = dp(c, padDp);
        v.setPadding(pad, pad, pad, pad);
        int total = dp(c, sizeDp) + pad * 2;
        v.setLayoutParams(lp(total, total));
        v.setBackground(ripple(rr(c, 0x00000000, 40)));
        v.setContentDescription(describe);
        v.setOnClickListener(l);
        return v;
    }

    public static ImageView roundBtn(Context c, int icoId, int sizeDp, boolean filled, String describe, View.OnClickListener l) {
        ImageView v = new ImageView(c);
        v.setImageDrawable(new Ico(icoId, filled ? ONACC : TXT));
        int pad = dp(c, filled ? 15 : 12);
        v.setPadding(pad, pad, pad, pad);
        int total = dp(c, sizeDp) + pad * 2;
        v.setLayoutParams(lp(total, total));
        GradientDrawable g = new GradientDrawable();
        g.setShape(GradientDrawable.OVAL);
        g.setColor(filled ? ACC : SURF2);
        if (!filled) g.setStroke(Math.max(1, dp(c, 1)), LINE);
        v.setBackground(ripple(g));
        v.setContentDescription(describe);
        v.setOnClickListener(l);
        return v;
    }

    public static void setIcon(ImageView v, int icoId, int color) {
        v.setImageDrawable(new Ico(icoId, color));
    }

    public static LinearLayout btn(Context c, String text, int icoId, int kind, View.OnClickListener l) {
        int fill, fg, stroke;
        switch (kind) {
            case PRIMARY:   fill = ACC;   fg = ONACC; stroke = ACC;   break;
            case DANGER:    fill = SURF2; fg = RED;   stroke = RED;   break;
            case GHOST:     fill = 0x00000000; fg = DIM; stroke = 0x00000000; break;
            default:        fill = SURF2; fg = TXT;   stroke = LINE;  break;
        }
        LinearLayout b = new LinearLayout(c);
        b.setOrientation(LinearLayout.HORIZONTAL);
        b.setGravity(Gravity.CENTER);
        b.setPadding(dp(c, 14 * PAD), dp(c, 11 * PAD), dp(c, 14 * PAD), dp(c, 11 * PAD));
        b.setBackground(ripple(rrs(c, fill, stroke, RAD_BTN, STROKE_W)));
        b.setClickable(true);
        b.setOnClickListener(l);
        b.setLayoutParams(lp(WRAP, WRAP));
        if (icoId > 0) {
            ImageView i = icon(c, icoId, fg, 16);
            margin(c, i, 0, 0, 8, 0);
            b.addView(i);
        }
        if (text != null && text.length() > 0) {
            TextView t = tv(c, text, 13, fg, true);
            t.setSingleLine(true);
            b.addView(t);
        }
        if (text != null) b.setContentDescription(text);
        return b;
    }

    public static TextView chip(Context c, String text, boolean on, View.OnClickListener l) {
        TextView t = tv(c, text, 12, on ? ONACC : DIM, true);
        t.setPadding(dp(c, 13), dp(c, 8), dp(c, 13), dp(c, 8));
        t.setBackground(ripple(rrs(c, on ? ACC : SURF2, on ? ACC : LINE, RAD_CHIP, STROKE_W)));
        t.setOnClickListener(l);
        t.setSingleLine(true);
        LinearLayout.LayoutParams p = lp(WRAP, WRAP);
        p.setMargins(0, 0, dp(c, 6), dp(c, 6));
        t.setLayoutParams(p);
        return t;
    }

    // ---- composite rows --------------------------------------------------
    /** What appBar hands back, so callers never index into its children. */
    public static class Bar {
        public LinearLayout view;
        public LinearLayout titles;
        public TextView title;
        public TextView sub;
    }

    /** Screen header: optional back arrow, title, subtitle, trailing action views. */
    public static Bar appBar(final Activity a, int icoId, String title, String sub, boolean back, View[] actions) {
        Bar bar = new Bar();
        LinearLayout h = row(a);
        h.setPadding(dp(a, back ? 4 : 16), dp(a, 12), dp(a, 8), dp(a, 8));
        if (back) {
            h.addView(iconBtn(a, Ico.BACK, TXT, 20, "Back", new View.OnClickListener() {
                public void onClick(View v) { a.finish(); }
            }));
        } else if (icoId > 0) {
            ImageView mark = icon(a, icoId, ACC, 20);
            int p = dp(a, 7);
            mark.setPadding(p, p, p, p);
            mark.setLayoutParams(lp(dp(a, 34), dp(a, 34)));
            mark.setBackground(rr(a, SURF2, 10));
            h.addView(mark);
            h.addView(hgap(a, 10));
        }
        LinearLayout titles = col(a);
        titles.setLayoutParams(lpw(0, WRAP, 1f));
        TextView t = tv(a, title, back ? 17 : 20, TXT, true);
        ellipsize(t);
        titles.addView(t);
        // The subtitle view is always created, even when it starts empty, so a
        // screen can fill it in later.
        TextView s = tv(a, sub == null ? "" : sub, 11, DIM, false);
        ellipsize(s);
        titles.addView(s);
        h.addView(titles);
        if (actions != null) for (View v : actions) if (v != null) h.addView(v);

        bar.view = h;
        bar.titles = titles;
        bar.title = t;
        bar.sub = s;
        return bar;
    }

    public static LinearLayout emptyState(Context c, int icoId, String title, String body) {
        LinearLayout box = col(c);
        box.setGravity(Gravity.CENTER_HORIZONTAL);
        box.setPadding(dp(c, 24), dp(c, 26), dp(c, 24), dp(c, 26));
        ImageView i = icon(c, icoId, LINE, 42);
        box.addView(i);
        TextView t = tv(c, title, 15, TXT, true);
        margin(c, t, 0, 12, 0, 0);
        t.setGravity(Gravity.CENTER);
        box.addView(t);
        TextView b = tv(c, body, 12.5f, DIM, false);
        b.setGravity(Gravity.CENTER);
        margin(c, b, 0, 6, 0, 0);
        box.addView(b);
        return box;
    }

    public static View switchRow(Context c, String label, String sub, boolean value, final OnToggle cb) {
        LinearLayout r = row(c);
        margin(c, r, 0, 4, 0, 4);
        int pad = dp(c, 6);
        r.setPadding(pad, pad, pad, pad);
        LinearLayout col = col(c);
        col.setLayoutParams(lpw(0, WRAP, 1f));
        col.addView(tv(c, label, 14, TXT, false));
        if (sub != null && sub.length() > 0) {
            col.addView(tv(c, sub, 11.5f, DIM, false));
        }
        r.addView(col);
        final Switch sw = new Switch(c);
        sw.setChecked(value);
        sw.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton b, boolean v) { cb.set(v); }
        });
        r.addView(sw);

        // The label looks tappable, so it has to be tappable: hitting anywhere
        // on the row flips the switch.
        r.setBackground(ripple(rr(c, 0x00000000, 10)));
        r.setClickable(true);
        r.setContentDescription(label);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { buzz(v); sw.toggle(); }
        });
        return r;
    }

    public static View sliderRow(Context c, String label, int min, int max, int value,
                                 String unit, OnSlide cb) {
        return sliderRow(c, label, min, max, value, unit, Integer.MIN_VALUE, cb);
    }

    /**
     * A labelled slider. Pass a normal value and it grows an inline reset
     * button, shown whenever the slider is not sitting on that value.
     */
    public static View sliderRow(Context c, String label, final int min, int max, int value,
                                 final String unit, final int normal, final OnSlide cb) {
        LinearLayout box = col(c);
        margin(c, box, 0, 6, 0, 2);

        LinearLayout head = row(c);
        TextView t = tv(c, label, 14, TXT, false);
        t.setLayoutParams(lpw(0, WRAP, 1f));
        head.addView(t);
        final TextView val = mono(c, value + unit, 12, ACC_TXT);
        head.addView(val);

        final SeekBar s = new SeekBar(c);
        final ImageView reset = iconBtn(c, Ico.RESET, DIM, 15, 6, "Reset " + label, null);
        final boolean hasNormal = normal != Integer.MIN_VALUE;
        if (hasNormal) {
            reset.setVisibility(value == normal ? View.INVISIBLE : View.VISIBLE);
            reset.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    buzz(v);
                    s.setProgress(normal - min);
                    val.setText(normal + unit);
                    reset.setVisibility(View.INVISIBLE);
                    cb.set(normal);
                }
            });
            head.addView(reset);
        }
        box.addView(head);

        s.setMax(max - min);
        s.setProgress(Math.max(0, value - min));
        s.setProgressTintList(ColorStateList.valueOf(ACC));
        s.setThumbTintList(ColorStateList.valueOf(ACC));
        s.setLayoutParams(lp(MATCH, WRAP));
        s.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int p, boolean fromUser) {
                val.setText((min + p) + unit);
                if (hasNormal) reset.setVisibility((min + p) == normal ? View.INVISIBLE : View.VISIBLE);
            }
            public void onStartTrackingTouch(SeekBar b) { }
            public void onStopTrackingTouch(SeekBar b) { cb.set(min + b.getProgress()); }
        });
        box.addView(s);
        return box;
    }

    /** Two or three mutually exclusive options. */
    public static LinearLayout seg(final Context c, final String[] labels, final int selected, final OnPick cb) {
        final LinearLayout r = row(c);
        r.setBackground(rr(c, SURF2, RAD_BTN));
        int pad = dp(c, 3);
        r.setPadding(pad, pad, pad, pad);
        for (int i = 0; i < labels.length; i++) {
            final int index = i;
            TextView t = tv(c, labels[i], 12.5f, i == selected ? ONACC : DIM, true);
            t.setGravity(Gravity.CENTER);
            t.setPadding(dp(c, 10), dp(c, 9), dp(c, 10), dp(c, 9));
            t.setLayoutParams(lpw(0, WRAP, 1f));
            if (i == selected) t.setBackground(rr(c, ACC, Math.max(2f, RAD_BTN - 2f)));
            else t.setBackground(ripple(rr(c, 0x00000000, Math.max(2f, RAD_BTN - 2f))));
            t.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) { buzz(v); cb.set(index); }
            });
            r.addView(t);
        }
        return r;
    }

    /** Minus / value / plus. */
    public static LinearLayout stepper(final Context c, final int start, final int min, final int max,
                                       final int by, final String unit, final OnValue cb) {
        final int[] value = { start };
        final LinearLayout r = row(c);
        final TextView val = tv(c, start + unit, 15, TXT, true);
        val.setGravity(Gravity.CENTER);
        val.setLayoutParams(lpw(0, WRAP, 1f));

        ImageView minus = iconBtn(c, Ico.MINUS, TXT, 16, "less", null);
        ImageView plus  = iconBtn(c, Ico.PLUS, TXT, 16, "more", null);
        minus.setBackground(ripple(rrs(c, SURF2, LINE, 10, 1)));
        plus.setBackground(ripple(rrs(c, SURF2, LINE, 10, 1)));
        minus.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                value[0] = Math.max(min, value[0] - by);
                val.setText(value[0] + unit);
                buzz(v);
                cb.set(value[0]);
            }
        });
        plus.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                value[0] = Math.min(max, value[0] + by);
                val.setText(value[0] + unit);
                buzz(v);
                cb.set(value[0]);
            }
        });
        r.addView(minus);
        r.addView(val);
        r.addView(plus);
        return r;
    }

    /** A tappable "label / value >" row used for pickers. */
    public static LinearLayout field(Context c, String label, String value, int icoId, View.OnClickListener l) {
        LinearLayout r = row(c);
        r.setBackground(ripple(rrs(c, FIELD, LINE, RAD_BTN, STROKE_W)));
        r.setPadding(dp(c, 12), dp(c, 11), dp(c, 10), dp(c, 11));
        margin(c, r, 0, 6, 0, 0);
        r.setOnClickListener(l);
        if (icoId > 0) {
            r.addView(icon(c, icoId, DIM, 16));
            r.addView(hgap(c, 10));
        }
        LinearLayout box = col(c);
        box.setLayoutParams(lpw(0, WRAP, 1f));
        box.addView(tv(c, label, 11, DIM, false));
        TextView v = tv(c, value, 14.5f, TXT, false);
        ellipsize(v);
        box.addView(v);
        r.addView(box);
        r.addView(icon(c, Ico.RIGHT, DIM, 14));
        return r;
    }
}
