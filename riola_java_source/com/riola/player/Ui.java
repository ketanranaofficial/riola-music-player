package com.riola.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.text.TextUtils;
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

/* JADX INFO: loaded from: classes.dex */
public final class Ui {
    public static int ACC = 0;
    public static int ACC2 = 0;
    public static int ACC_SOFT = 0;
    public static int ACC_TXT = 0;
    public static int AMBER = 0;
    public static int BG = 0;
    public static boolean CAPS_HEADINGS = false;
    public static final int DANGER = 2;
    public static int DIM = 0;
    public static int FIELD = 0;
    public static Typeface FONT = null;
    public static Typeface FONT_BOLD = null;
    public static final int GHOST = 3;
    public static int GREEN = 0;
    public static float ICON_W = 0.0f;
    public static int LINE = 0;
    public static final int MATCH = -1;
    public static int ONACC = 0;
    public static float PAD = 0.0f;
    public static final int PRIMARY = 0;
    public static float RAD_BTN = 0.0f;
    public static float RAD_CARD = 0.0f;
    public static float RAD_CHIP = 0.0f;
    public static int RED = 0;
    public static int RIPPLE = 0;
    public static final int SECONDARY = 1;
    public static boolean SQUARE_ICONS = false;
    public static float STROKE_W = 0.0f;
    public static final int STYLE_98 = 4;
    public static final int STYLE_BRUTAL = 8;
    public static final int STYLE_CODER = 3;
    public static final int STYLE_ELEGANT = 1;
    public static final int STYLE_FUTURE = 5;
    public static final int STYLE_MATERIAL = 0;
    public static final int STYLE_MINIMAL = 9;
    public static final int STYLE_NEON = 6;
    public static final int STYLE_PASTEL = 7;
    public static final int STYLE_RETRO = 2;
    public static int SURF = 0;
    public static int SURF2 = 0;
    public static float TRACK_SP = 0.0f;
    public static int TXT = 0;
    public static final int WRAP = -2;
    public static boolean dark = true;
    public static final int[] ACCENTS = {-11746561, -14298952, -41054, -6587137, -19712, -8464041, -36797, -10707457};
    public static final String[] ACCENT_NAMES = {"Aqua", "Teal", "Magenta", "Violet", "Amber", "Lime", "Coral", "Sky"};
    public static final String[] STYLE_NAMES = {"Material", "Elegant", "Retro", "Coder", "98", "Futuristic", "Neon", "Pastel", "Brutalist", "Minimal"};
    public static final String[] STYLE_NOTES = {"Soft corners and quiet lines. The default.", "Serif type, thin rules, room to breathe.", "Warm paper, heavy borders, chunky type.", "Monospace everything and square corners.", "Grey panels and hard edges, like an old desktop.", "Wide letter spacing and very round shapes.", "Deep night, bright edges, everything glowing.", "Soft and quiet. Easy on the eyes late at night.", "Stark and heavy. Thick black rules, nothing soft.", "No borders at all. Space does the work."};
    public static int style = 0;

    public static class Bar {
        public TextView sub;
        public TextView title;
        public LinearLayout titles;
        public LinearLayout view;
    }

    public interface OnPick {
        void set(int i);
    }

    public interface OnSlide {
        void set(int i);
    }

    public interface OnToggle {
        void set(boolean z);
    }

    public interface OnValue {
        void set(int i);
    }

    private Ui() {
    }

    public static void theme(Prefs prefs) {
        theme(prefs.dark(), prefs.accent(), prefs.style());
    }

    public static void theme(boolean z, int i, int i2) {
        int i3 = i2;
        dark = z;
        if (i3 < 0 || i3 >= STYLE_NAMES.length) {
            i3 = 0;
        }
        style = i3;
        if (z) {
            BG = -15855338;
            SURF = -15328220;
            SURF2 = -14801360;
            LINE = -13879998;
            TXT = -1511949;
            DIM = -7102032;
            RED = -38037;
            GREEN = -12723049;
            AMBER = -14756;
            RIPPLE = 872415231;
            FIELD = -16052460;
        } else {
            BG = -723206;
            SURF = -1;
            SURF2 = -1183241;
            LINE = -2695448;
            TXT = -15591393;
            DIM = -10852749;
            RED = -3130822;
            GREEN = -15693990;
            AMBER = -5671936;
            RIPPLE = 570425344;
            FIELD = -460036;
        }
        int i4 = i == 0 ? ACCENTS[0] : i;
        ACC = i4;
        ACC2 = shift(i4, z);
        ONACC = luminance(ACC) > 0.55f ? -15723496 : -1;
        RAD_CARD = 18.0f;
        RAD_BTN = 12.0f;
        RAD_CHIP = 20.0f;
        STROKE_W = 1.0f;
        TRACK_SP = 0.12f;
        ICON_W = 1.9f;
        PAD = 1.0f;
        FONT = Typeface.DEFAULT;
        FONT_BOLD = Typeface.DEFAULT_BOLD;
        CAPS_HEADINGS = true;
        SQUARE_ICONS = false;
        switch (style) {
            case 1:
                RAD_CARD = 6.0f;
                RAD_BTN = 4.0f;
                RAD_CHIP = 14.0f;
                STROKE_W = 0.8f;
                TRACK_SP = 0.05f;
                ICON_W = 1.5f;
                PAD = 1.15f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, 1);
                CAPS_HEADINGS = false;
                break;
            case 2:
                RAD_CARD = 10.0f;
                RAD_BTN = 8.0f;
                RAD_CHIP = 12.0f;
                STROKE_W = 2.2f;
                TRACK_SP = 0.08f;
                ICON_W = 2.4f;
                PAD = 1.05f;
                FONT = Typeface.SERIF;
                FONT_BOLD = Typeface.create(Typeface.SERIF, 1);
                if (z) {
                    BG = -15265266;
                    SURF = -14476781;
                    SURF2 = -13753574;
                    LINE = -11912920;
                    TXT = -792618;
                    DIM = -4610937;
                    FIELD = -15593974;
                } else {
                    BG = -593950;
                    SURF = -1554;
                    SURF2 = -1055534;
                    LINE = -3426668;
                    TXT = -13885164;
                    DIM = -8755632;
                    FIELD = -1037;
                }
                break;
            case 3:
                RAD_CARD = 2.0f;
                RAD_BTN = 2.0f;
                RAD_CHIP = 2.0f;
                STROKE_W = 1.4f;
                TRACK_SP = 0.02f;
                ICON_W = 2.0f;
                PAD = 0.95f;
                FONT = Typeface.MONOSPACE;
                FONT_BOLD = Typeface.create(Typeface.MONOSPACE, 1);
                CAPS_HEADINGS = false;
                SQUARE_ICONS = true;
                if (z) {
                    BG = -16316149;
                    SURF = -15920874;
                    SURF2 = -15459807;
                    LINE = -14405568;
                    TXT = -2628393;
                    DIM = -8614788;
                    FIELD = -16447734;
                } else {
                    BG = -526091;
                    SURF = -1;
                    SURF2 = -1183510;
                    LINE = -3550524;
                    TXT = -15523814;
                    DIM = -10851489;
                    FIELD = -262918;
                }
                break;
            case 4:
                RAD_CARD = 0.0f;
                RAD_BTN = 0.0f;
                RAD_CHIP = 0.0f;
                STROKE_W = 2.4f;
                TRACK_SP = 0.0f;
                ICON_W = 2.2f;
                PAD = 0.9f;
                CAPS_HEADINGS = false;
                SQUARE_ICONS = true;
                if (z) {
                    BG = -13948117;
                    SURF = -12829636;
                    SURF2 = -11908534;
                    LINE = -8750470;
                    TXT = -986896;
                    DIM = -4934476;
                    FIELD = -14277082;
                } else {
                    BG = -4210753;
                    SURF = -2565928;
                    SURF2 = -3355444;
                    LINE = -9539986;
                    TXT = -15724528;
                    DIM = -11908534;
                    FIELD = -1;
                }
                break;
            case 5:
                RAD_CARD = 26.0f;
                RAD_BTN = 22.0f;
                RAD_CHIP = 24.0f;
                STROKE_W = 1.0f;
                TRACK_SP = 0.22f;
                ICON_W = 1.4f;
                PAD = 1.1f;
                if (z) {
                    BG = -16250092;
                    SURF = -15723224;
                    SURF2 = -15262154;
                    LINE = -14011560;
                    TXT = -1183233;
                    DIM = -7431482;
                    FIELD = -16315886;
                } else {
                    BG = -854785;
                    SURF = -1;
                    SURF2 = -1380869;
                    LINE = -3550992;
                    TXT = -15460301;
                    DIM = -10524784;
                    FIELD = -460289;
                }
                break;
            case 6:
                RAD_CARD = 20.0f;
                RAD_BTN = 16.0f;
                RAD_CHIP = 22.0f;
                STROKE_W = 1.3f;
                TRACK_SP = 0.14f;
                ICON_W = 1.7f;
                PAD = 1.0f;
                if (z) {
                    BG = -16447988;
                    SURF = -16052452;
                    SURF2 = -15590866;
                    LINE = -13878162;
                    TXT = -1445377;
                    DIM = -8614716;
                    FIELD = -16513782;
                } else {
                    BG = -15658212;
                    SURF = -15065556;
                    SURF2 = -14473160;
                    LINE = -12825992;
                    TXT = -986113;
                    DIM = -6774080;
                    FIELD = -15789798;
                }
                break;
            case 7:
                RAD_CARD = 22.0f;
                RAD_BTN = 18.0f;
                RAD_CHIP = 24.0f;
                STROKE_W = 0.9f;
                TRACK_SP = 0.03f;
                ICON_W = 1.6f;
                PAD = 1.15f;
                CAPS_HEADINGS = false;
                if (z) {
                    BG = -15133147;
                    SURF = -14541263;
                    SURF2 = -13883584;
                    LINE = -12634025;
                    TXT = -1185798;
                    DIM = -5792572;
                    FIELD = -15396321;
                } else {
                    BG = -329729;
                    SURF = -1;
                    SURF2 = -791045;
                    LINE = -1844750;
                    TXT = -12897456;
                    DIM = -7634266;
                    FIELD = -132097;
                }
                break;
            case 8:
                RAD_CARD = 0.0f;
                RAD_BTN = 0.0f;
                RAD_CHIP = 0.0f;
                STROKE_W = 3.2f;
                TRACK_SP = 0.02f;
                ICON_W = 2.8f;
                PAD = 1.0f;
                SQUARE_ICONS = true;
                FONT_BOLD = Typeface.DEFAULT_BOLD;
                if (z) {
                    BG = -16777216;
                    SURF = -16053493;
                    SURF2 = -15461356;
                    LINE = -1;
                    TXT = -1;
                    DIM = -5723992;
                    FIELD = -16777216;
                } else {
                    BG = -1;
                    SURF = -1;
                    SURF2 = -855310;
                    LINE = -16777216;
                    TXT = -16777216;
                    DIM = -12303292;
                    FIELD = -1;
                }
                break;
            case 9:
                RAD_CARD = 10.0f;
                RAD_BTN = 8.0f;
                RAD_CHIP = 12.0f;
                STROKE_W = 0.0f;
                TRACK_SP = 0.06f;
                ICON_W = 1.4f;
                PAD = 1.25f;
                CAPS_HEADINGS = false;
                if (z) {
                    BG = -15724011;
                    SURF = -15328995;
                    SURF2 = -14933979;
                    LINE = -14275791;
                    TXT = -1644052;
                    DIM = -7630183;
                    FIELD = -15921390;
                } else {
                    BG = -263172;
                    SURF = -1;
                    SURF2 = -723465;
                    LINE = -1512723;
                    TXT = -15000030;
                    DIM = -9735560;
                    FIELD = -1;
                }
                break;
        }
        ACC_TXT = readable(ACC, SURF, z);
        ACC_SOFT = blend(ACC, SURF, z ? 0.2f : 0.14f);
    }

    private static int readable(int i, int i2, boolean z) {
        float[] fArr = new float[3];
        Color.colorToHSV(i, fArr);
        for (int i3 = 0; i3 < 30 && contrast(i, i2) < 3.4f; i3++) {
            fArr[2] = z ? Math.min(1.0f, fArr[2] + 0.035f) : Math.max(0.12f, fArr[2] - 0.035f);
            if (z) {
                float f = fArr[1];
                if (f > 0.18f) {
                    fArr[1] = Math.max(0.18f, f - 0.012f);
                }
            }
            i = Color.HSVToColor(fArr);
        }
        return i;
    }

    private static float contrast(int i, int i2) {
        float fLuminance = luminance(i);
        float fLuminance2 = luminance(i2);
        return (Math.max(fLuminance, fLuminance2) + 0.05f) / (Math.min(fLuminance, fLuminance2) + 0.05f);
    }

    public static int blend(int i, int i2, float f) {
        float f2 = 1.0f - f;
        return ((int) (((i & 255) * f) + ((i2 & 255) * f2))) | (-16777216) | (((int) ((((i >> 16) & 255) * f) + (((i2 >> 16) & 255) * f2))) << 16) | (((int) ((((i >> 8) & 255) * f) + (((i2 >> 8) & 255) * f2))) << 8);
    }

    private static int shift(int i, boolean z) {
        float[] fArr = new float[3];
        Color.colorToHSV(i, fArr);
        fArr[0] = (fArr[0] + 38.0f) % 360.0f;
        fArr[1] = Math.min(1.0f, fArr[1] * 0.95f);
        fArr[2] = z ? Math.min(1.0f, fArr[2] * 1.05f) : fArr[2] * 0.9f;
        return Color.HSVToColor(fArr);
    }

    public static float luminance(int i) {
        return (((((i >> 16) & 255) * 0.299f) + (((i >> 8) & 255) * 0.587f)) + ((i & 255) * 0.114f)) / 255.0f;
    }

    public static int dp(Context context, float f) {
        return Math.round(f * context.getResources().getDisplayMetrics().density);
    }

    public static void applyWindow(Activity activity) {
        activity.getWindow().setStatusBarColor(BG);
        activity.getWindow().setNavigationBarColor(BG);
        activity.getWindow().getDecorView().setSystemUiVisibility(dark ? 0 : 8208);
    }

    public static int themeRes(boolean z) {
        return z ? android.R.style.Theme.Material.NoActionBar : android.R.style.Theme.Material.Light.NoActionBar;
    }

    public static AlertDialog.Builder dialog(Activity activity) {
        return new AlertDialog.Builder(activity, dark ? R.style.RiolaDialog : R.style.RiolaDialogLight);
    }

    public static void toast(Context context, String str) {
        Toast.makeText(context, str, 0).show();
    }

    public static void buzz(View view) {
        try {
            view.performHapticFeedback(1);
        } catch (Exception e) {
        }
    }

    public static GradientDrawable rr(Context context, int i, float f) {
        GradientDrawable gradientDrawable = new GradientDrawable();
        gradientDrawable.setColor(i);
        gradientDrawable.setCornerRadius(dp(context, f));
        return gradientDrawable;
    }

    public static GradientDrawable rrs(Context context, int i, int i2, float f, float f2) {
        GradientDrawable gradientDrawableRr = rr(context, i, f);
        if (f2 > 0.0f) {
            gradientDrawableRr.setStroke(Math.max(1, dp(context, f2)), i2);
        }
        return gradientDrawableRr;
    }

    public static Drawable ripple(Drawable drawable) {
        return new RippleDrawable(ColorStateList.valueOf(RIPPLE), drawable, null);
    }

    public static LinearLayout.LayoutParams lp(int i, int i2) {
        return new LinearLayout.LayoutParams(i, i2);
    }

    public static LinearLayout.LayoutParams lpw(int i, int i2, float f) {
        return new LinearLayout.LayoutParams(i, i2, f);
    }

    public static View margin(Context context, View view, float f, float f2, float f3, float f4) {
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        LinearLayout.LayoutParams layoutParams2 = layoutParams instanceof LinearLayout.LayoutParams ? (LinearLayout.LayoutParams) layoutParams : new LinearLayout.LayoutParams(-1, -2);
        layoutParams2.setMargins(dp(context, f), dp(context, f2), dp(context, f3), dp(context, f4));
        view.setLayoutParams(layoutParams2);
        return view;
    }

    public static View weight(View view, float f) {
        view.setLayoutParams(lpw(0, -2, f));
        return view;
    }

    public static LinearLayout col(Context context) {
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(1);
        linearLayout.setLayoutParams(lp(-1, -2));
        return linearLayout;
    }

    public static LinearLayout row(Context context) {
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(0);
        linearLayout.setGravity(16);
        linearLayout.setLayoutParams(lp(-1, -2));
        return linearLayout;
    }

    public static LinearLayout card(Context context) {
        LinearLayout linearLayoutCol = col(context);
        linearLayoutCol.setBackground(rrs(context, SURF, LINE, RAD_CARD, STROKE_W));
        int iDp = dp(context, PAD * 14.0f);
        linearLayoutCol.setPadding(iDp, dp(context, PAD * 12.0f), iDp, dp(context, PAD * 12.0f));
        margin(context, linearLayoutCol, 12.0f, 0.0f, 12.0f, 10.0f);
        return linearLayoutCol;
    }

    public static ScrollView scroller(Context context, LinearLayout linearLayout) {
        ScrollView scrollView = new ScrollView(context);
        scrollView.setLayoutParams(lpw(-1, 0, 1.0f));
        scrollView.setFillViewport(true);
        scrollView.addView(linearLayout, new FrameLayout.LayoutParams(-1, -2));
        return scrollView;
    }

    public static View gap(Context context, float f) {
        View view = new View(context);
        view.setLayoutParams(lp(-1, dp(context, f)));
        return view;
    }

    public static View hgap(Context context, float f) {
        View view = new View(context);
        view.setLayoutParams(lp(dp(context, f), 1));
        return view;
    }

    public static View spring(Context context) {
        View view = new View(context);
        view.setLayoutParams(lpw(0, 1, 1.0f));
        return view;
    }

    public static View divider(Context context) {
        View view = new View(context);
        view.setBackgroundColor(LINE);
        LinearLayout.LayoutParams layoutParamsLp = lp(-1, Math.max(1, dp(context, 0.7f)));
        layoutParamsLp.setMargins(0, dp(context, 8.0f), 0, dp(context, 8.0f));
        view.setLayoutParams(layoutParamsLp);
        return view;
    }

    public static TextView tv(Context context, String str, float f, int i, boolean z) {
        TextView textView = new TextView(context);
        textView.setText(str);
        textView.setTextSize(f);
        textView.setTextColor(i);
        textView.setTypeface(z ? FONT_BOLD : FONT);
        textView.setLayoutParams(lp(-2, -2));
        return textView;
    }

    public static TextView mono(Context context, String str, float f, int i) {
        TextView textViewTv = tv(context, str, f, i, false);
        textViewTv.setTypeface(Typeface.MONOSPACE);
        return textViewTv;
    }

    public static LinearLayout heading(Context context, int i, String str) {
        LinearLayout linearLayoutRow = row(context);
        if (i > 0) {
            linearLayoutRow.addView(icon(context, i, ACC_TXT, 16));
            linearLayoutRow.addView(hgap(context, 8.0f));
        }
        if (CAPS_HEADINGS) {
            str = str.toUpperCase();
        }
        TextView textViewTv = tv(context, str, 12.0f, DIM, true);
        textViewTv.setLetterSpacing(TRACK_SP);
        linearLayoutRow.addView(textViewTv);
        margin(context, linearLayoutRow, 0.0f, 0.0f, 0.0f, 8.0f);
        return linearLayoutRow;
    }

    public static TextView badge(Context context, String str, int i, int i2) {
        TextView textViewTv = tv(context, str, 10.0f, i, true);
        textViewTv.setBackground(rr(context, i2, 20.0f));
        textViewTv.setPadding(dp(context, 8.0f), dp(context, 3.0f), dp(context, 8.0f), dp(context, 3.0f));
        textViewTv.setLetterSpacing(0.06f);
        return textViewTv;
    }

    public static void ellipsize(TextView textView) {
        textView.setSingleLine(true);
        textView.setEllipsize(TextUtils.TruncateAt.END);
    }

    public static ImageView icon(Context context, int i, int i2, int i3) {
        ImageView imageView = new ImageView(context);
        imageView.setImageDrawable(new Ico(i, i2));
        float f = i3;
        imageView.setLayoutParams(lp(dp(context, f), dp(context, f)));
        return imageView;
    }

    public static ImageView iconBtn(Context context, int i, int i2, int i3, String str, View.OnClickListener onClickListener) {
        return iconBtn(context, i, i2, i3, 9, str, onClickListener);
    }

    public static ImageView iconBtn(Context context, int i, int i2, int i3, int i4, String str, View.OnClickListener onClickListener) {
        ImageView imageView = new ImageView(context);
        imageView.setImageDrawable(new Ico(i, i2));
        int iDp = dp(context, i4);
        imageView.setPadding(iDp, iDp, iDp, iDp);
        int iDp2 = dp(context, i3) + (iDp * 2);
        imageView.setLayoutParams(lp(iDp2, iDp2));
        imageView.setBackground(ripple(rr(context, 0, 40.0f)));
        imageView.setContentDescription(str);
        imageView.setOnClickListener(onClickListener);
        return imageView;
    }

    public static ImageView roundBtn(Context context, int i, int i2, boolean z, String str, View.OnClickListener onClickListener) {
        ImageView imageView = new ImageView(context);
        imageView.setImageDrawable(new Ico(i, z ? ONACC : TXT));
        int iDp = dp(context, z ? 15.0f : 12.0f);
        imageView.setPadding(iDp, iDp, iDp, iDp);
        int iDp2 = dp(context, i2) + (iDp * 2);
        imageView.setLayoutParams(lp(iDp2, iDp2));
        GradientDrawable gradientDrawable = new GradientDrawable();
        gradientDrawable.setShape(1);
        gradientDrawable.setColor(z ? ACC : SURF2);
        if (!z) {
            gradientDrawable.setStroke(Math.max(1, dp(context, 1.0f)), LINE);
        }
        imageView.setBackground(ripple(gradientDrawable));
        imageView.setContentDescription(str);
        imageView.setOnClickListener(onClickListener);
        return imageView;
    }

    public static void setIcon(ImageView imageView, int i, int i2) {
        imageView.setImageDrawable(new Ico(i, i2));
    }

    public static LinearLayout btn(Context context, String str, int i, int i2, View.OnClickListener onClickListener) {
        int i3;
        int i4;
        int i5;
        switch (i2) {
            case 0:
                i3 = ACC;
                i4 = ONACC;
                i5 = i3;
                break;
            case 1:
            default:
                i3 = SURF2;
                i4 = TXT;
                i5 = LINE;
                break;
            case 2:
                i3 = SURF2;
                i4 = RED;
                i5 = i4;
                break;
            case 3:
                i4 = DIM;
                i3 = 0;
                i5 = 0;
                break;
        }
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(0);
        linearLayout.setGravity(17);
        linearLayout.setPadding(dp(context, PAD * 14.0f), dp(context, PAD * 11.0f), dp(context, PAD * 14.0f), dp(context, PAD * 11.0f));
        linearLayout.setBackground(ripple(rrs(context, i3, i5, RAD_BTN, STROKE_W)));
        linearLayout.setClickable(true);
        linearLayout.setOnClickListener(onClickListener);
        linearLayout.setLayoutParams(lp(-2, -2));
        if (i > 0) {
            ImageView imageViewIcon = icon(context, i, i4, 16);
            margin(context, imageViewIcon, 0.0f, 0.0f, 8.0f, 0.0f);
            linearLayout.addView(imageViewIcon);
        }
        if (str != null && str.length() > 0) {
            TextView textViewTv = tv(context, str, 13.0f, i4, true);
            textViewTv.setSingleLine(true);
            linearLayout.addView(textViewTv);
        }
        if (str != null) {
            linearLayout.setContentDescription(str);
        }
        return linearLayout;
    }

    public static TextView chip(Context context, String str, boolean z, View.OnClickListener onClickListener) {
        TextView textViewTv = tv(context, str, 12.0f, z ? ONACC : DIM, true);
        textViewTv.setPadding(dp(context, 13.0f), dp(context, 8.0f), dp(context, 13.0f), dp(context, 8.0f));
        textViewTv.setBackground(ripple(rrs(context, z ? ACC : SURF2, z ? ACC : LINE, RAD_CHIP, STROKE_W)));
        textViewTv.setOnClickListener(onClickListener);
        textViewTv.setSingleLine(true);
        LinearLayout.LayoutParams layoutParamsLp = lp(-2, -2);
        layoutParamsLp.setMargins(0, 0, dp(context, 6.0f), dp(context, 6.0f));
        textViewTv.setLayoutParams(layoutParamsLp);
        return textViewTv;
    }

    public static Bar appBar(final Activity activity, int i, String str, String str2, boolean z, View[] viewArr) {
        Bar bar = new Bar();
        LinearLayout linearLayoutRow = row(activity);
        linearLayoutRow.setPadding(dp(activity, z ? 4.0f : 16.0f), dp(activity, 12.0f), dp(activity, 8.0f), dp(activity, 8.0f));
        if (z) {
            linearLayoutRow.addView(iconBtn(activity, 26, TXT, 20, "Back", new View.OnClickListener() { // from class: com.riola.player.Ui.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    activity.finish();
                }
            }));
        } else if (i > 0) {
            ImageView imageViewIcon = icon(activity, i, ACC, 20);
            int iDp = dp(activity, 7.0f);
            imageViewIcon.setPadding(iDp, iDp, iDp, iDp);
            imageViewIcon.setLayoutParams(lp(dp(activity, 34.0f), dp(activity, 34.0f)));
            imageViewIcon.setBackground(rr(activity, SURF2, 10.0f));
            linearLayoutRow.addView(imageViewIcon);
            linearLayoutRow.addView(hgap(activity, 10.0f));
        }
        LinearLayout linearLayoutCol = col(activity);
        linearLayoutCol.setLayoutParams(lpw(0, -2, 1.0f));
        TextView textViewTv = tv(activity, str, z ? 17.0f : 20.0f, TXT, true);
        ellipsize(textViewTv);
        linearLayoutCol.addView(textViewTv);
        TextView textViewTv2 = tv(activity, str2 == null ? "" : str2, 11.0f, DIM, false);
        ellipsize(textViewTv2);
        linearLayoutCol.addView(textViewTv2);
        linearLayoutRow.addView(linearLayoutCol);
        if (viewArr != null) {
            for (View view : viewArr) {
                if (view != null) {
                    linearLayoutRow.addView(view);
                }
            }
        }
        bar.view = linearLayoutRow;
        bar.titles = linearLayoutCol;
        bar.title = textViewTv;
        bar.sub = textViewTv2;
        return bar;
    }

    public static LinearLayout emptyState(Context context, int i, String str, String str2) {
        LinearLayout linearLayoutCol = col(context);
        linearLayoutCol.setGravity(1);
        linearLayoutCol.setPadding(dp(context, 24.0f), dp(context, 26.0f), dp(context, 24.0f), dp(context, 26.0f));
        linearLayoutCol.addView(icon(context, i, LINE, 42));
        TextView textViewTv = tv(context, str, 15.0f, TXT, true);
        margin(context, textViewTv, 0.0f, 12.0f, 0.0f, 0.0f);
        textViewTv.setGravity(17);
        linearLayoutCol.addView(textViewTv);
        TextView textViewTv2 = tv(context, str2, 12.5f, DIM, false);
        textViewTv2.setGravity(17);
        margin(context, textViewTv2, 0.0f, 6.0f, 0.0f, 0.0f);
        linearLayoutCol.addView(textViewTv2);
        return linearLayoutCol;
    }

    public static View switchRow(Context context, String str, String str2, boolean z, final OnToggle onToggle) {
        LinearLayout linearLayoutRow = row(context);
        margin(context, linearLayoutRow, 0.0f, 4.0f, 0.0f, 4.0f);
        int iDp = dp(context, 6.0f);
        linearLayoutRow.setPadding(iDp, iDp, iDp, iDp);
        LinearLayout linearLayoutCol = col(context);
        linearLayoutCol.setLayoutParams(lpw(0, -2, 1.0f));
        linearLayoutCol.addView(tv(context, str, 14.0f, TXT, false));
        if (str2 != null && str2.length() > 0) {
            linearLayoutCol.addView(tv(context, str2, 11.5f, DIM, false));
        }
        linearLayoutRow.addView(linearLayoutCol);
        final Switch r9 = new Switch(context);
        r9.setChecked(z);
        r9.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() { // from class: com.riola.player.Ui.2
            @Override // android.widget.CompoundButton.OnCheckedChangeListener
            public void onCheckedChanged(CompoundButton compoundButton, boolean z2) {
                onToggle.set(z2);
            }
        });
        linearLayoutRow.addView(r9);
        linearLayoutRow.setBackground(ripple(rr(context, 0, 10.0f)));
        linearLayoutRow.setClickable(true);
        linearLayoutRow.setContentDescription(str);
        linearLayoutRow.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Ui.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                Ui.buzz(view);
                r9.toggle();
            }
        });
        return linearLayoutRow;
    }

    public static View sliderRow(Context context, String str, int i, int i2, int i3, String str2, OnSlide onSlide) {
        return sliderRow(context, str, i, i2, i3, str2, Integer.MIN_VALUE, onSlide);
    }

    public static View sliderRow(Context context, String str, final int i, int i2, int i3, final String str2, final int i4, final OnSlide onSlide) {
        LinearLayout linearLayoutCol = col(context);
        margin(context, linearLayoutCol, 0.0f, 6.0f, 0.0f, 2.0f);
        LinearLayout linearLayoutRow = row(context);
        TextView textViewTv = tv(context, str, 14.0f, TXT, false);
        textViewTv.setLayoutParams(lpw(0, -2, 1.0f));
        linearLayoutRow.addView(textViewTv);
        final TextView textViewMono = mono(context, i3 + str2, 12.0f, ACC_TXT);
        linearLayoutRow.addView(textViewMono);
        final SeekBar seekBar = new SeekBar(context);
        final ImageView imageViewIconBtn = iconBtn(context, 34, DIM, 15, 6, "Reset " + str, null);
        boolean z = i4 != Integer.MIN_VALUE;
        if (z) {
            imageViewIconBtn.setVisibility(i3 == i4 ? 4 : 0);
            imageViewIconBtn.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Ui.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.buzz(view);
                    seekBar.setProgress(i4 - i);
                    textViewMono.setText(i4 + str2);
                    imageViewIconBtn.setVisibility(4);
                    onSlide.set(i4);
                }
            });
            linearLayoutRow.addView(imageViewIconBtn);
        }
        linearLayoutCol.addView(linearLayoutRow);
        r7.setMax(i2 - i);
        r7.setProgress(Math.max(0, i3 - i));
        r7.setProgressTintList(ColorStateList.valueOf(ACC));
        r7.setThumbTintList(ColorStateList.valueOf(ACC));
        r7.setLayoutParams(lp(-1, -2));
        final boolean z2 = z;
        r7.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.riola.player.Ui.5
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i5, boolean z3) {
                textViewMono.setText((i + i5) + str2);
                if (z2) {
                    imageViewIconBtn.setVisibility(i + i5 == i4 ? 4 : 0);
                }
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
                onSlide.set(i + seekBar2.getProgress());
            }
        });
        linearLayoutCol.addView(seekBar);
        return linearLayoutCol;
    }

    public static LinearLayout seg(Context context, String[] strArr, int i, final OnPick onPick) {
        LinearLayout linearLayoutRow = row(context);
        linearLayoutRow.setBackground(rr(context, SURF2, RAD_BTN));
        int iDp = dp(context, 3.0f);
        linearLayoutRow.setPadding(iDp, iDp, iDp, iDp);
        final int i2 = 0;
        while (i2 < strArr.length) {
            TextView textViewTv = tv(context, strArr[i2], 12.5f, i2 == i ? ONACC : DIM, true);
            textViewTv.setGravity(17);
            textViewTv.setPadding(dp(context, 10.0f), dp(context, 9.0f), dp(context, 10.0f), dp(context, 9.0f));
            textViewTv.setLayoutParams(lpw(0, -2, 1.0f));
            if (i2 != i) {
                textViewTv.setBackground(ripple(rr(context, 0, Math.max(2.0f, RAD_BTN - 2.0f))));
            } else {
                textViewTv.setBackground(rr(context, ACC, Math.max(2.0f, RAD_BTN - 2.0f)));
            }
            textViewTv.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Ui.6
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    Ui.buzz(view);
                    onPick.set(i2);
                }
            });
            linearLayoutRow.addView(textViewTv);
            i2++;
        }
        return linearLayoutRow;
    }

    public static LinearLayout stepper(Context context, int i, final int i2, final int i3, final int i4, final String str, final OnValue onValue) {
        final int[] iArr = {i};
        LinearLayout linearLayoutRow = row(context);
        final TextView textViewTv = tv(context, i + str, 15.0f, TXT, true);
        textViewTv.setGravity(17);
        textViewTv.setLayoutParams(lpw(0, -2, 1.0f));
        ImageView imageViewIconBtn = iconBtn(context, 30, TXT, 16, "less", null);
        ImageView imageViewIconBtn2 = iconBtn(context, 6, TXT, 16, "more", null);
        imageViewIconBtn.setBackground(ripple(rrs(context, SURF2, LINE, 10.0f, 1.0f)));
        imageViewIconBtn2.setBackground(ripple(rrs(context, SURF2, LINE, 10.0f, 1.0f)));
        imageViewIconBtn.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Ui.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                int[] iArr2 = iArr;
                iArr2[0] = Math.max(i2, iArr2[0] - i4);
                textViewTv.setText(iArr[0] + str);
                Ui.buzz(view);
                onValue.set(iArr[0]);
            }
        });
        imageViewIconBtn2.setOnClickListener(new View.OnClickListener() { // from class: com.riola.player.Ui.8
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                int[] iArr2 = iArr;
                iArr2[0] = Math.min(i3, iArr2[0] + i4);
                textViewTv.setText(iArr[0] + str);
                Ui.buzz(view);
                onValue.set(iArr[0]);
            }
        });
        linearLayoutRow.addView(imageViewIconBtn);
        linearLayoutRow.addView(textViewTv);
        linearLayoutRow.addView(imageViewIconBtn2);
        return linearLayoutRow;
    }

    public static LinearLayout field(Context context, String str, String str2, int i, View.OnClickListener onClickListener) {
        LinearLayout linearLayoutRow = row(context);
        linearLayoutRow.setBackground(ripple(rrs(context, FIELD, LINE, RAD_BTN, STROKE_W)));
        linearLayoutRow.setPadding(dp(context, 12.0f), dp(context, 11.0f), dp(context, 10.0f), dp(context, 11.0f));
        margin(context, linearLayoutRow, 0.0f, 6.0f, 0.0f, 0.0f);
        linearLayoutRow.setOnClickListener(onClickListener);
        if (i > 0) {
            linearLayoutRow.addView(icon(context, i, DIM, 16));
            linearLayoutRow.addView(hgap(context, 10.0f));
        }
        LinearLayout linearLayoutCol = col(context);
        linearLayoutCol.setLayoutParams(lpw(0, -2, 1.0f));
        linearLayoutCol.addView(tv(context, str, 11.0f, DIM, false));
        TextView textViewTv = tv(context, str2, 14.5f, TXT, false);
        ellipsize(textViewTv);
        linearLayoutCol.addView(textViewTv);
        linearLayoutRow.addView(linearLayoutCol);
        linearLayoutRow.addView(icon(context, 27, DIM, 14));
        return linearLayoutRow;
    }
}
