.class public final Lcom/riola/player/Ui;
.super Ljava/lang/Object;
.source "Ui.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/Ui$Bar;,
        Lcom/riola/player/Ui$OnToggle;,
        Lcom/riola/player/Ui$OnSlide;,
        Lcom/riola/player/Ui$OnPick;,
        Lcom/riola/player/Ui$OnValue;
    }
.end annotation


# static fields
.field public static ACC:I = 0x0

.field public static ACC2:I = 0x0

.field public static final ACCENTS:[I

.field public static final ACCENT_NAMES:[Ljava/lang/String;

.field public static ACC_SOFT:I = 0x0

.field public static ACC_TXT:I = 0x0

.field public static AMBER:I = 0x0

.field public static BG:I = 0x0

.field public static CAPS_HEADINGS:Z = false

.field public static final DANGER:I = 0x2

.field public static DIM:I = 0x0

.field public static FIELD:I = 0x0

.field public static FONT:Landroid/graphics/Typeface; = null

.field public static FONT_BOLD:Landroid/graphics/Typeface; = null

.field public static final GHOST:I = 0x3

.field public static GREEN:I = 0x0

.field public static ICON_W:F = 0.0f

.field public static LINE:I = 0x0

.field public static final MATCH:I = -0x1

.field public static ONACC:I = 0x0

.field public static PAD:F = 0.0f

.field public static final PRIMARY:I = 0x0

.field public static RAD_BTN:F = 0.0f

.field public static RAD_CARD:F = 0.0f

.field public static RAD_CHIP:F = 0.0f

.field public static RED:I = 0x0

.field public static RIPPLE:I = 0x0

.field public static final SECONDARY:I = 0x1

.field public static SQUARE_ICONS:Z = false

.field public static STROKE_W:F = 0.0f

.field public static final STYLE_98:I = 0x4

.field public static final STYLE_BRUTAL:I = 0x8

.field public static final STYLE_CODER:I = 0x3

.field public static final STYLE_ELEGANT:I = 0x1

.field public static final STYLE_FUTURE:I = 0x5

.field public static final STYLE_MATERIAL:I = 0x0

.field public static final STYLE_MINIMAL:I = 0x9

.field public static final STYLE_NAMES:[Ljava/lang/String;

.field public static final STYLE_NEON:I = 0x6

.field public static final STYLE_NOTES:[Ljava/lang/String;

.field public static final STYLE_PASTEL:I = 0x7

.field public static final STYLE_RETRO:I = 0x2

.field public static SURF:I = 0x0

.field public static SURF2:I = 0x0

.field public static TRACK_SP:F = 0.0f

.field public static TXT:I = 0x0

.field public static final WRAP:I = -0x2

.field public static dark:Z

.field public static style:I


# direct methods
.method static constructor <clinit>()V
    .locals 11

    .line 41
    const/4 v0, 0x1

    sput-boolean v0, Lcom/riola/player/Ui;->dark:Z

    .line 49
    const/16 v0, 0x8

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/riola/player/Ui;->ACCENTS:[I

    .line 53
    const-string v1, "Aqua"

    const-string v2, "Teal"

    const-string v3, "Magenta"

    const-string v4, "Violet"

    const-string v5, "Amber"

    const-string v6, "Lime"

    const-string v7, "Coral"

    const-string v8, "Sky"

    filled-new-array/range {v1 .. v8}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Ui;->ACCENT_NAMES:[Ljava/lang/String;

    .line 62
    const-string v1, "Material"

    const-string v2, "Elegant"

    const-string v3, "Retro"

    const-string v4, "Coder"

    const-string v5, "98"

    const-string v6, "Futuristic"

    const-string v7, "Neon"

    const-string v8, "Pastel"

    const-string v9, "Brutalist"

    const-string v10, "Minimal"

    filled-new-array/range {v1 .. v10}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    .line 66
    const-string v1, "Soft corners and quiet lines. The default."

    const-string v2, "Serif type, thin rules, room to breathe."

    const-string v3, "Warm paper, heavy borders, chunky type."

    const-string v4, "Monospace everything and square corners."

    const-string v5, "Grey panels and hard edges, like an old desktop."

    const-string v6, "Wide letter spacing and very round shapes."

    const-string v7, "Deep night, bright edges, everything glowing."

    const-string v8, "Soft and quiet. Easy on the eyes late at night."

    const-string v9, "Stark and heavy. Thick black rules, nothing soft."

    const-string v10, "No borders at all. Space does the work."

    filled-new-array/range {v1 .. v10}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Ui;->STYLE_NOTES:[Ljava/lang/String;

    .line 83
    const/4 v0, 0x0

    sput v0, Lcom/riola/player/Ui;->style:I

    return-void

    :array_0
    .array-data 4
        -0xb33d01
        -0xda2f48
        -0xa05e
        -0x648301
        -0x4d00
        -0x8126a9
        -0x8fbd
        -0xa36201
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 85
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static appBar(Landroid/app/Activity;ILjava/lang/String;Ljava/lang/String;Z[Landroid/view/View;)Lcom/riola/player/Ui$Bar;
    .locals 8

    .line 547
    new-instance v6, Lcom/riola/player/Ui$Bar;

    invoke-direct {v6}, Lcom/riola/player/Ui$Bar;-><init>()V

    .line 548
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 549
    if-eqz p4, :cond_0

    const/high16 v1, 0x40800000    # 4.0f

    goto :goto_0

    :cond_0
    const/high16 v1, 0x41800000    # 16.0f

    :goto_0
    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x41400000    # 12.0f

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v7, v1, v2, v4, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 550
    if-eqz p4, :cond_1

    .line 551
    const/16 v1, 0x1a

    sget v2, Lcom/riola/player/Ui;->TXT:I

    const/16 v3, 0x14

    const-string v4, "Back"

    new-instance v5, Lcom/riola/player/Ui$1;

    invoke-direct {v5, p0}, Lcom/riola/player/Ui$1;-><init>(Landroid/app/Activity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_1

    .line 554
    :cond_1
    if-lez p1, :cond_2

    .line 555
    sget v1, Lcom/riola/player/Ui;->ACC:I

    const/16 v2, 0x14

    invoke-static {p0, p1, v1, v2}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v0

    .line 556
    const/high16 v1, 0x40e00000    # 7.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 557
    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 558
    const/high16 v1, 0x42080000    # 34.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {v2, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 559
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    const/high16 v2, 0x41200000    # 10.0f

    invoke-static {p0, v1, v2}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 560
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 561
    invoke-static {p0, v2}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 563
    :cond_2
    :goto_1
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 564
    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    invoke-static {v3, v1, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 565
    if-eqz p4, :cond_3

    const/high16 v1, 0x41880000    # 17.0f

    goto :goto_2

    :cond_3
    const/high16 v1, 0x41a00000    # 20.0f

    :goto_2
    sget v2, Lcom/riola/player/Ui;->TXT:I

    const/4 v4, 0x1

    invoke-static {p0, p2, v1, v2, v4}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 566
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 567
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 570
    if-nez p3, :cond_4

    const-string v2, ""

    goto :goto_3

    :cond_4
    move-object v2, p3

    :goto_3
    const/high16 v4, 0x41300000    # 11.0f

    sget v5, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v2, v4, v5, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 571
    invoke-static {v2}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 572
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 573
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 574
    if-eqz p5, :cond_6

    array-length v4, p5

    :goto_4
    if-ge v3, v4, :cond_6

    aget-object v5, p5, v3

    if-eqz v5, :cond_5

    invoke-virtual {v7, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 576
    :cond_6
    iput-object v7, v6, Lcom/riola/player/Ui$Bar;->view:Landroid/widget/LinearLayout;

    .line 577
    iput-object v0, v6, Lcom/riola/player/Ui$Bar;->titles:Landroid/widget/LinearLayout;

    .line 578
    iput-object v1, v6, Lcom/riola/player/Ui$Bar;->title:Landroid/widget/TextView;

    .line 579
    iput-object v2, v6, Lcom/riola/player/Ui$Bar;->sub:Landroid/widget/TextView;

    .line 580
    return-object v6
.end method

.method public static applyWindow(Landroid/app/Activity;)V
    .locals 2

    .line 281
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget v1, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 282
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget v1, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 283
    sget-boolean v0, Lcom/riola/player/Ui;->dark:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    const/16 v0, 0x2010

    .line 284
    :goto_0
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object p0

    invoke-virtual {p0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p0

    invoke-virtual {p0, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 285
    return-void
.end method

.method public static badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;
    .locals 2

    .line 435
    const/high16 v0, 0x41200000    # 10.0f

    const/4 v1, 0x1

    invoke-static {p0, p1, v0, p2, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 436
    const/high16 p2, 0x41a00000    # 20.0f

    invoke-static {p0, p3, p2}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 437
    const/high16 p2, 0x41000000    # 8.0f

    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p3

    const/high16 v0, 0x40400000    # 3.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p2

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-virtual {p1, p3, v1, p2, p0}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 438
    const p0, 0x3d75c28f    # 0.06f

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 439
    return-object p1
.end method

.method public static blend(IIF)I
    .locals 4

    .line 254
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    mul-float/2addr v0, p2

    shr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float/2addr v2, p2

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    float-to-int v0, v0

    .line 255
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    mul-float/2addr v1, p2

    shr-int/lit8 v3, p1, 0x8

    and-int/lit16 v3, v3, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, v2

    add-float/2addr v1, v3

    float-to-int v1, v1

    .line 256
    and-int/lit16 p0, p0, 0xff

    int-to-float p0, p0

    mul-float/2addr p0, p2

    and-int/lit16 p1, p1, 0xff

    int-to-float p1, p1

    mul-float/2addr p1, v2

    add-float/2addr p0, p1

    float-to-int p0, p0

    .line 257
    const/high16 p1, -0x1000000

    shl-int/lit8 p2, v0, 0x10

    or-int/2addr p1, p2

    shl-int/lit8 p2, v1, 0x8

    or-int/2addr p1, p2

    or-int/2addr p0, p1

    return p0
.end method

.method public static btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 10

    .line 496
    const/4 v0, 0x0

    packed-switch p3, :pswitch_data_0

    .line 500
    :pswitch_0
    sget p3, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->TXT:I

    sget v2, Lcom/riola/player/Ui;->LINE:I

    goto :goto_0

    .line 499
    :pswitch_1
    sget p3, Lcom/riola/player/Ui;->DIM:I

    move v1, p3

    move p3, v0

    move v2, p3

    goto :goto_0

    .line 498
    :pswitch_2
    sget p3, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->RED:I

    move v2, v1

    goto :goto_0

    .line 497
    :pswitch_3
    sget p3, Lcom/riola/player/Ui;->ACC:I

    sget v1, Lcom/riola/player/Ui;->ONACC:I

    move v2, p3

    .line 502
    :goto_0
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 503
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 504
    const/16 v0, 0x11

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 505
    sget v0, Lcom/riola/player/Ui;->PAD:F

    const/high16 v4, 0x41600000    # 14.0f

    mul-float/2addr v0, v4

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    sget v5, Lcom/riola/player/Ui;->PAD:F

    const/high16 v6, 0x41300000    # 11.0f

    mul-float/2addr v5, v6

    invoke-static {p0, v5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    sget v7, Lcom/riola/player/Ui;->PAD:F

    mul-float/2addr v7, v4

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    sget v7, Lcom/riola/player/Ui;->PAD:F

    mul-float/2addr v7, v6

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-virtual {v3, v0, v5, v4, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 506
    sget v0, Lcom/riola/player/Ui;->RAD_BTN:F

    sget v4, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {p0, p3, v2, v0, v4}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p3

    invoke-static {p3}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p3

    invoke-virtual {v3, p3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 507
    const/4 p3, 0x1

    invoke-virtual {v3, p3}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 508
    invoke-virtual {v3, p4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 509
    const/4 p4, -0x2

    invoke-static {p4, p4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p4

    invoke-virtual {v3, p4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 510
    if-lez p2, :cond_0

    .line 511
    const/16 p4, 0x10

    invoke-static {p0, p2, v1, p4}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object p2

    .line 512
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/high16 v8, 0x41000000    # 8.0f

    const/4 v9, 0x0

    move-object v4, p0

    move-object v5, p2

    invoke-static/range {v4 .. v9}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 513
    invoke-virtual {v3, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 515
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    if-lez p2, :cond_1

    .line 516
    const/high16 p2, 0x41500000    # 13.0f

    invoke-static {p0, p1, p2, v1, p3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p0

    .line 517
    invoke-virtual {p0, p3}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 518
    invoke-virtual {v3, p0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 520
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {v3, p1}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 521
    :cond_2
    return-object v3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public static buzz(Landroid/view/View;)V
    .locals 1

    .line 299
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Landroid/view/View;->performHapticFeedback(I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 300
    :goto_0
    return-void
.end method

.method public static card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .locals 7

    .line 360
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 361
    sget v0, Lcom/riola/player/Ui;->SURF:I

    sget v1, Lcom/riola/player/Ui;->LINE:I

    sget v2, Lcom/riola/player/Ui;->RAD_CARD:F

    sget v3, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {p0, v0, v1, v2, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 362
    const/high16 v0, 0x41600000    # 14.0f

    sget v1, Lcom/riola/player/Ui;->PAD:F

    mul-float/2addr v1, v0

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 363
    sget v1, Lcom/riola/player/Ui;->PAD:F

    const/high16 v2, 0x41400000    # 12.0f

    mul-float/2addr v1, v2

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    sget v3, Lcom/riola/player/Ui;->PAD:F

    mul-float/2addr v3, v2

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v6, v0, v1, v0, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 364
    const/high16 v2, 0x41400000    # 12.0f

    const/4 v3, 0x0

    const/high16 v4, 0x41400000    # 12.0f

    const/high16 v5, 0x41200000    # 10.0f

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 365
    return-object v6
.end method

.method public static chip(Landroid/content/Context;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 5

    .line 525
    if-eqz p2, :cond_0

    sget v0, Lcom/riola/player/Ui;->ONACC:I

    goto :goto_0

    :cond_0
    sget v0, Lcom/riola/player/Ui;->DIM:I

    :goto_0
    const/high16 v1, 0x41400000    # 12.0f

    const/4 v2, 0x1

    invoke-static {p0, p1, v1, v0, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 526
    const/high16 v0, 0x41500000    # 13.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {p1, v1, v4, v0, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 527
    if-eqz p2, :cond_1

    sget v0, Lcom/riola/player/Ui;->ACC:I

    goto :goto_1

    :cond_1
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    :goto_1
    if-eqz p2, :cond_2

    sget p2, Lcom/riola/player/Ui;->ACC:I

    goto :goto_2

    :cond_2
    sget p2, Lcom/riola/player/Ui;->LINE:I

    :goto_2
    sget v1, Lcom/riola/player/Ui;->RAD_CHIP:F

    sget v3, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {p0, v0, p2, v1, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p2

    invoke-static {p2}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 528
    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 529
    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 530
    const/4 p2, -0x2

    invoke-static {p2, p2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p2

    .line 531
    const/high16 p3, 0x40c00000    # 6.0f

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 p3, 0x0

    invoke-virtual {p2, p3, p3, v0, p0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 532
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 533
    return-object p1
.end method

.method public static col(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .locals 2

    .line 345
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 346
    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 347
    const/4 p0, -0x1

    const/4 v1, -0x2

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 348
    return-object v0
.end method

.method private static contrast(II)F
    .locals 1

    .line 248
    invoke-static {p0}, Lcom/riola/player/Ui;->luminance(I)F

    move-result p0

    invoke-static {p1}, Lcom/riola/player/Ui;->luminance(I)F

    move-result p1

    .line 249
    invoke-static {p0, p1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {p0, p1}, Ljava/lang/Math;->min(FF)F

    move-result p0

    .line 250
    const p1, 0x3d4ccccd    # 0.05f

    add-float/2addr v0, p1

    add-float/2addr p0, p1

    div-float/2addr v0, p0

    return v0
.end method

.method public static dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;
    .locals 2

    .line 293
    new-instance v0, Landroid/app/AlertDialog$Builder;

    sget-boolean v1, Lcom/riola/player/Ui;->dark:Z

    if-eqz v1, :cond_0

    const/high16 v1, 0x7f040000

    goto :goto_0

    :cond_0
    const v1, 0x7f040001

    :goto_0
    invoke-direct {v0, p0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    return-object v0
.end method

.method public static divider(Landroid/content/Context;)Landroid/view/View;
    .locals 4

    .line 396
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 397
    sget v1, Lcom/riola/player/Ui;->LINE:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 398
    const v1, 0x3f333333    # 0.7f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/4 v2, -0x1

    invoke-static {v2, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 399
    const/high16 v2, 0x41000000    # 8.0f

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v3, v2, p0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 400
    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 401
    return-object v0
.end method

.method public static dp(Landroid/content/Context;F)I
    .locals 0

    .line 277
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method public static ellipsize(Landroid/widget/TextView;)V
    .locals 1

    .line 443
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 444
    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 445
    return-void
.end method

.method public static emptyState(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 9

    .line 584
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 585
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 586
    const/high16 v2, 0x41c00000    # 24.0f

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    const/high16 v4, 0x41d00000    # 26.0f

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v0, v3, v5, v2, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 587
    sget v2, Lcom/riola/player/Ui;->LINE:I

    const/16 v3, 0x2a

    invoke-static {p0, p1, v2, v3}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object p1

    .line 588
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 589
    const/high16 p1, 0x41700000    # 15.0f

    sget v2, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, p2, p1, v2, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 590
    const/4 v5, 0x0

    const/high16 v6, 0x41400000    # 12.0f

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-static/range {v3 .. v8}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 591
    const/16 p2, 0x11

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setGravity(I)V

    .line 592
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 593
    sget p1, Lcom/riola/player/Ui;->DIM:I

    const/4 v1, 0x0

    const/high16 v2, 0x41480000    # 12.5f

    invoke-static {p0, p3, v2, p1, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 594
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setGravity(I)V

    .line 595
    const/high16 v6, 0x40c00000    # 6.0f

    move-object v4, p1

    invoke-static/range {v3 .. v8}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 596
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 597
    return-object v0
.end method

.method public static field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 9

    .line 745
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 746
    sget v0, Lcom/riola/player/Ui;->FIELD:I

    sget v1, Lcom/riola/player/Ui;->LINE:I

    sget v2, Lcom/riola/player/Ui;->RAD_BTN:F

    sget v3, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {p0, v0, v1, v2, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 747
    const/high16 v0, 0x41400000    # 12.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v7, 0x41300000    # 11.0f

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v8, 0x41200000    # 10.0f

    invoke-static {p0, v8}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v6, v0, v1, v2, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 748
    const/4 v2, 0x0

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 749
    invoke-virtual {v6, p4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 750
    if-lez p3, :cond_0

    .line 751
    sget p4, Lcom/riola/player/Ui;->DIM:I

    const/16 v0, 0x10

    invoke-static {p0, p3, p4, v0}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object p3

    invoke-virtual {v6, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 752
    invoke-static {p0, v8}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object p3

    invoke-virtual {v6, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 754
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object p3

    .line 755
    const/4 p4, -0x2

    const/high16 v0, 0x3f800000    # 1.0f

    const/4 v1, 0x0

    invoke-static {v1, p4, v0}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p4

    invoke-virtual {p3, p4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 756
    sget p4, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, p1, v7, p4, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p3, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 757
    const/high16 p1, 0x41680000    # 14.5f

    sget p4, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, p2, p1, p4, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 758
    invoke-static {p1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 759
    invoke-virtual {p3, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 760
    invoke-virtual {v6, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 761
    sget p1, Lcom/riola/player/Ui;->DIM:I

    const/16 p2, 0xe

    const/16 p3, 0x1b

    invoke-static {p0, p3, p1, p2}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object p0

    invoke-virtual {v6, p0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 762
    return-object v6
.end method

.method public static gap(Landroid/content/Context;F)Landroid/view/View;
    .locals 2

    .line 378
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 379
    const/4 v1, -0x1

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-static {v1, p0}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 380
    return-object v0
.end method

.method public static heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;
    .locals 7

    .line 422
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 423
    if-lez p1, :cond_0

    .line 424
    sget v0, Lcom/riola/player/Ui;->ACC_TXT:I

    const/16 v1, 0x10

    invoke-static {p0, p1, v0, v1}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object p1

    invoke-virtual {v6, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 425
    const/high16 p1, 0x41000000    # 8.0f

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object p1

    invoke-virtual {v6, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 427
    :cond_0
    sget-boolean p1, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    if-eqz p1, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object p2

    :cond_1
    sget p1, Lcom/riola/player/Ui;->DIM:I

    const/4 v0, 0x1

    const/high16 v1, 0x41400000    # 12.0f

    invoke-static {p0, p2, v1, p1, v0}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 428
    sget p2, Lcom/riola/player/Ui;->TRACK_SP:F

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 429
    invoke-virtual {v6, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 430
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x41000000    # 8.0f

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 431
    return-object v6
.end method

.method public static hgap(Landroid/content/Context;F)Landroid/view/View;
    .locals 1

    .line 384
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 385
    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 p1, 0x1

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 386
    return-object v0
.end method

.method public static icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    .locals 2

    .line 449
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 450
    new-instance v1, Lcom/riola/player/Ico;

    invoke-direct {v1, p1, p2}, Lcom/riola/player/Ico;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 451
    int-to-float p1, p3

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p2

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-static {p2, p0}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 452
    return-object v0
.end method

.method public static iconBtn(Landroid/content/Context;IIIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;
    .locals 2

    .line 461
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 462
    new-instance v1, Lcom/riola/player/Ico;

    invoke-direct {v1, p1, p2}, Lcom/riola/player/Ico;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 463
    int-to-float p1, p4

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p1

    .line 464
    invoke-virtual {v0, p1, p1, p1, p1}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 465
    int-to-float p2, p3

    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p2

    mul-int/lit8 p1, p1, 0x2

    add-int/2addr p2, p1

    .line 466
    invoke-static {p2, p2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 467
    const/4 p1, 0x0

    const/high16 p2, 0x42200000    # 40.0f

    invoke-static {p0, p1, p2}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    invoke-static {p0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 468
    invoke-virtual {v0, p5}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 469
    invoke-virtual {v0, p6}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 470
    return-object v0
.end method

.method public static iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;
    .locals 7

    .line 456
    const/16 v4, 0x9

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move-object v5, p4

    move-object v6, p5

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object p0

    return-object p0
.end method

.method public static lp(II)Landroid/widget/LinearLayout$LayoutParams;
    .locals 1

    .line 322
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, p0, p1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    return-object v0
.end method

.method public static lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;
    .locals 1

    .line 326
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, p0, p1, p2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    return-object v0
.end method

.method public static luminance(I)F
    .locals 3

    .line 272
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 p0, p0, 0xff

    .line 273
    const v2, 0x3e991687    # 0.299f

    int-to-float v0, v0

    mul-float/2addr v0, v2

    const v2, 0x3f1645a2    # 0.587f

    int-to-float v1, v1

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    const v1, 0x3de978d5    # 0.114f

    int-to-float p0, p0

    mul-float/2addr p0, v1

    add-float/2addr v0, p0

    const/high16 p0, 0x437f0000    # 255.0f

    div-float/2addr v0, p0

    return v0
.end method

.method public static margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;
    .locals 3

    .line 330
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 331
    instance-of v1, v0, Landroid/widget/LinearLayout$LayoutParams;

    if-eqz v1, :cond_0

    .line 332
    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 333
    :goto_0
    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p2

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p3

    invoke-static {p0, p4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p4

    invoke-static {p0, p5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-virtual {v0, p2, p3, p4, p0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 334
    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 335
    return-object p1
.end method

.method public static mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;
    .locals 1

    .line 416
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p0

    .line 417
    sget-object p1, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {p0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 418
    return-object p0
.end method

.method private static readable(IIZ)I
    .locals 5

    .line 236
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 237
    invoke-static {p0, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 238
    nop

    .line 239
    const/4 v1, 0x0

    :goto_0
    const/16 v2, 0x1e

    if-ge v1, v2, :cond_2

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->contrast(II)F

    move-result v2

    const v3, 0x4059999a    # 3.4f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_2

    .line 240
    const p0, 0x3d0f5c29    # 0.035f

    const/4 v2, 0x2

    if-eqz p2, :cond_0

    aget v3, v0, v2

    add-float/2addr v3, p0

    const/high16 p0, 0x3f800000    # 1.0f

    invoke-static {p0, v3}, Ljava/lang/Math;->min(FF)F

    move-result p0

    goto :goto_1

    :cond_0
    aget v3, v0, v2

    sub-float/2addr v3, p0

    const p0, 0x3df5c28f    # 0.12f

    invoke-static {p0, v3}, Ljava/lang/Math;->max(FF)F

    move-result p0

    :goto_1
    aput p0, v0, v2

    .line 241
    if-eqz p2, :cond_1

    const/4 p0, 0x1

    aget v2, v0, p0

    const v3, 0x3e3851ec    # 0.18f

    cmpl-float v4, v2, v3

    if-lez v4, :cond_1

    const v4, 0x3c449ba6    # 0.012f

    sub-float/2addr v2, v4

    invoke-static {v3, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, v0, p0

    .line 242
    :cond_1
    invoke-static {v0}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result p0

    .line 239
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 244
    :cond_2
    return p0
.end method

.method public static ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;
    .locals 3

    .line 317
    new-instance v0, Landroid/graphics/drawable/RippleDrawable;

    sget v1, Lcom/riola/player/Ui;->RIPPLE:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {v0, v1, p0, v2}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    return-object v0
.end method

.method public static roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;
    .locals 3

    .line 474
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 475
    new-instance v1, Lcom/riola/player/Ico;

    if-eqz p3, :cond_0

    sget v2, Lcom/riola/player/Ui;->ONACC:I

    goto :goto_0

    :cond_0
    sget v2, Lcom/riola/player/Ui;->TXT:I

    :goto_0
    invoke-direct {v1, p1, v2}, Lcom/riola/player/Ico;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 476
    if-eqz p3, :cond_1

    const/high16 p1, 0x41700000    # 15.0f

    goto :goto_1

    :cond_1
    const/high16 p1, 0x41400000    # 12.0f

    :goto_1
    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p1

    .line 477
    invoke-virtual {v0, p1, p1, p1, p1}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 478
    int-to-float p2, p2

    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p2

    mul-int/lit8 p1, p1, 0x2

    add-int/2addr p2, p1

    .line 479
    invoke-static {p2, p2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 480
    new-instance p1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {p1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 481
    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 482
    if-eqz p3, :cond_2

    sget v1, Lcom/riola/player/Ui;->ACC:I

    goto :goto_2

    :cond_2
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    :goto_2
    invoke-virtual {p1, v1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 483
    if-nez p3, :cond_3

    const/high16 p3, 0x3f800000    # 1.0f

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-static {p2, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    sget p2, Lcom/riola/player/Ui;->LINE:I

    invoke-virtual {p1, p0, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 484
    :cond_3
    invoke-static {p1}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 485
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 486
    invoke-virtual {v0, p5}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 487
    return-object v0
.end method

.method public static row(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .locals 2

    .line 352
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 353
    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 354
    const/16 p0, 0x10

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 355
    const/4 p0, -0x1

    const/4 v1, -0x2

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 356
    return-object v0
.end method

.method public static rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    .line 304
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 305
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 306
    invoke-static {p0, p2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    int-to-float p0, p0

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 307
    return-object v0
.end method

.method public static rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;
    .locals 0

    .line 311
    invoke-static {p0, p1, p3}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p1

    .line 312
    const/4 p3, 0x0

    cmpl-float p3, p4, p3

    if-lez p3, :cond_0

    const/4 p3, 0x1

    invoke-static {p0, p4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-static {p3, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    invoke-virtual {p1, p0, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 313
    :cond_0
    return-object p1
.end method

.method public static scroller(Landroid/content/Context;Landroid/widget/LinearLayout;)Landroid/widget/ScrollView;
    .locals 3

    .line 370
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 371
    const/4 p0, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, -0x1

    invoke-static {v2, p0, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/ScrollView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 372
    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 373
    new-instance p0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, -0x2

    invoke-direct {p0, v2, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, p0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 374
    return-object v0
.end method

.method public static seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;
    .locals 8

    .line 688
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 689
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    sget v2, Lcom/riola/player/Ui;->RAD_BTN:F

    invoke-static {p0, v1, v2}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 690
    const/high16 v1, 0x40400000    # 3.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 691
    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 692
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v3, p1

    if-ge v2, v3, :cond_2

    .line 693
    nop

    .line 694
    aget-object v3, p1, v2

    if-ne v2, p2, :cond_0

    sget v4, Lcom/riola/player/Ui;->ONACC:I

    goto :goto_1

    :cond_0
    sget v4, Lcom/riola/player/Ui;->DIM:I

    :goto_1
    const/high16 v5, 0x41480000    # 12.5f

    const/4 v6, 0x1

    invoke-static {p0, v3, v5, v4, v6}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    .line 695
    const/16 v4, 0x11

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 696
    const/high16 v4, 0x41200000    # 10.0f

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    const/high16 v6, 0x41100000    # 9.0f

    invoke-static {p0, v6}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v6}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-virtual {v3, v5, v7, v4, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 697
    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v1, v4, v5}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 698
    const/high16 v4, 0x40000000    # 2.0f

    if-ne v2, p2, :cond_1

    sget v5, Lcom/riola/player/Ui;->ACC:I

    sget v6, Lcom/riola/player/Ui;->RAD_BTN:F

    sub-float/2addr v6, v4

    invoke-static {v4, v6}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {p0, v5, v4}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_2

    .line 699
    :cond_1
    sget v5, Lcom/riola/player/Ui;->RAD_BTN:F

    sub-float/2addr v5, v4

    invoke-static {v4, v5}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {p0, v1, v4}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-static {v4}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 700
    :goto_2
    new-instance v4, Lcom/riola/player/Ui$6;

    invoke-direct {v4, p3, v2}, Lcom/riola/player/Ui$6;-><init>(Lcom/riola/player/Ui$OnPick;I)V

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 703
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 692
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 705
    :cond_2
    return-object v0
.end method

.method public static setIcon(Landroid/widget/ImageView;II)V
    .locals 1

    .line 491
    new-instance v0, Lcom/riola/player/Ico;

    invoke-direct {v0, p1, p2}, Lcom/riola/player/Ico;-><init>(II)V

    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 492
    return-void
.end method

.method private static shift(IZ)I
    .locals 3

    .line 262
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 263
    invoke-static {p0, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 264
    const/4 p0, 0x0

    aget v1, v0, p0

    const/high16 v2, 0x42180000    # 38.0f

    add-float/2addr v1, v2

    const/high16 v2, 0x43b40000    # 360.0f

    rem-float/2addr v1, v2

    aput v1, v0, p0

    .line 265
    const/4 p0, 0x1

    aget v1, v0, p0

    const v2, 0x3f733333    # 0.95f

    mul-float/2addr v1, v2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    aput v1, v0, p0

    .line 266
    const/4 p0, 0x2

    if-eqz p1, :cond_0

    aget p1, v0, p0

    const v1, 0x3f866666    # 1.05f

    mul-float/2addr p1, v1

    invoke-static {v2, p1}, Ljava/lang/Math;->min(FF)F

    move-result p1

    goto :goto_0

    :cond_0
    aget p1, v0, p0

    const v1, 0x3f666666    # 0.9f

    mul-float/2addr p1, v1

    :goto_0
    aput p1, v0, p0

    .line 267
    invoke-static {v0}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result p0

    return p0
.end method

.method public static sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;
    .locals 17

    .line 641
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move/from16 v8, p4

    move/from16 v9, p6

    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v10

    .line 642
    const/4 v2, 0x0

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    move-object v1, v10

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 644
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 645
    sget v0, Lcom/riola/player/Ui;->TXT:I

    const/high16 v1, 0x41600000    # 14.0f

    const/4 v12, 0x0

    invoke-static {v6, v7, v1, v0, v12}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 646
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v13, -0x2

    invoke-static {v12, v13, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 647
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 648
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v14, p5

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/high16 v1, 0x41400000    # 12.0f

    sget v2, Lcom/riola/player/Ui;->ACC_TXT:I

    invoke-static {v6, v0, v1, v2}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v15

    .line 649
    invoke-virtual {v11, v15}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 651
    new-instance v5, Landroid/widget/SeekBar;

    invoke-direct {v5, v6}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 652
    const/16 v1, 0x22

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0xf

    const/4 v4, 0x6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Reset "

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const/4 v13, 0x0

    move-object/from16 v0, p0

    move-object v6, v5

    move-object v5, v7

    move-object v7, v6

    move-object v6, v13

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v13

    .line 653
    const/high16 v0, -0x80000000

    if-eq v9, v0, :cond_0

    const/4 v0, 0x1

    move/from16 v16, v0

    goto :goto_0

    :cond_0
    move/from16 v16, v12

    .line 654
    :goto_0
    if-eqz v16, :cond_2

    .line 655
    if-ne v8, v9, :cond_1

    const/4 v0, 0x4

    goto :goto_1

    :cond_1
    move v0, v12

    :goto_1
    invoke-virtual {v13, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 656
    new-instance v6, Lcom/riola/player/Ui$4;

    move-object v0, v6

    move-object v1, v7

    move/from16 v2, p6

    move/from16 v3, p2

    move-object v4, v15

    move-object/from16 v5, p5

    move-object v12, v6

    move-object v6, v13

    move-object v9, v7

    move-object/from16 v7, p7

    invoke-direct/range {v0 .. v7}, Lcom/riola/player/Ui$4;-><init>(Landroid/widget/SeekBar;IILandroid/widget/TextView;Ljava/lang/String;Landroid/widget/ImageView;Lcom/riola/player/Ui$OnSlide;)V

    invoke-virtual {v13, v12}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 665
    invoke-virtual {v11, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_2

    .line 654
    :cond_2
    move-object v9, v7

    .line 667
    :goto_2
    invoke-virtual {v10, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 669
    sub-int v0, p3, p2

    invoke-virtual {v9, v0}, Landroid/widget/SeekBar;->setMax(I)V

    .line 670
    sub-int v0, v8, p2

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {v9, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 671
    sget v0, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v0}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 672
    sget v0, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v0}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 673
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-static {v0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 674
    new-instance v8, Lcom/riola/player/Ui$5;

    move-object v0, v8

    move-object v1, v15

    move/from16 v2, p2

    move-object/from16 v3, p5

    move/from16 v4, v16

    move-object v5, v13

    move/from16 v6, p6

    move-object/from16 v7, p7

    invoke-direct/range {v0 .. v7}, Lcom/riola/player/Ui$5;-><init>(Landroid/widget/TextView;ILjava/lang/String;ZLandroid/widget/ImageView;ILcom/riola/player/Ui$OnSlide;)V

    invoke-virtual {v9, v8}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 682
    invoke-virtual {v10, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 683
    return-object v10
.end method

.method public static sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;Lcom/riola/player/Ui$OnSlide;)Landroid/view/View;
    .locals 8

    .line 632
    const/high16 v6, -0x80000000

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    move-object v7, p6

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method public static spring(Landroid/content/Context;)Landroid/view/View;
    .locals 3

    .line 390
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 391
    const/4 p0, 0x1

    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    invoke-static {v2, p0, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 392
    return-object v0
.end method

.method public static stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;
    .locals 14

    .line 711
    move-object v6, p0

    filled-new-array {p1}, [I

    move-result-object v7

    .line 712
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 713
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move v1, p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v9, p5

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget v1, Lcom/riola/player/Ui;->TXT:I

    const/4 v2, 0x1

    const/high16 v3, 0x41700000    # 15.0f

    invoke-static {p0, v0, v3, v1, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v10

    .line 714
    const/16 v0, 0x11

    invoke-virtual {v10, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 715
    const/4 v0, 0x0

    const/4 v1, -0x2

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-static {v0, v1, v11}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v10, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 717
    const/16 v1, 0x1e

    sget v2, Lcom/riola/player/Ui;->TXT:I

    const/16 v3, 0x10

    const-string v4, "less"

    const/4 v5, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v12

    .line 718
    const/4 v1, 0x6

    sget v2, Lcom/riola/player/Ui;->TXT:I

    const-string v4, "more"

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v13

    .line 719
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->LINE:I

    const/high16 v2, 0x41200000    # 10.0f

    invoke-static {p0, v0, v1, v2, v11}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v12, v0}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 720
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->LINE:I

    invoke-static {p0, v0, v1, v2, v11}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v13, v0}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 721
    new-instance v11, Lcom/riola/player/Ui$7;

    move-object v0, v11

    move-object v1, v7

    move/from16 v2, p2

    move/from16 v3, p4

    move-object v4, v10

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ui$7;-><init>([IIILandroid/widget/TextView;Ljava/lang/String;Lcom/riola/player/Ui$OnValue;)V

    invoke-virtual {v12, v11}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 729
    new-instance v11, Lcom/riola/player/Ui$8;

    move-object v0, v11

    move/from16 v2, p3

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ui$8;-><init>([IIILandroid/widget/TextView;Ljava/lang/String;Lcom/riola/player/Ui$OnValue;)V

    invoke-virtual {v13, v11}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 737
    invoke-virtual {v8, v12}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 738
    invoke-virtual {v8, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 739
    invoke-virtual {v8, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 740
    return-object v8
.end method

.method public static switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;
    .locals 7

    .line 601
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 602
    const/4 v2, 0x0

    const/high16 v3, 0x40800000    # 4.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40800000    # 4.0f

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 603
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 604
    invoke-virtual {v6, v0, v0, v0, v0}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 605
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 606
    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    invoke-static {v3, v1, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 607
    const/high16 v1, 0x41600000    # 14.0f

    sget v2, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, p1, v1, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 608
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 609
    const/high16 v1, 0x41380000    # 11.5f

    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, p2, v1, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 611
    :cond_0
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 612
    new-instance p2, Landroid/widget/Switch;

    invoke-direct {p2, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V

    .line 613
    invoke-virtual {p2, p3}, Landroid/widget/Switch;->setChecked(Z)V

    .line 614
    new-instance p3, Lcom/riola/player/Ui$2;

    invoke-direct {p3, p4}, Lcom/riola/player/Ui$2;-><init>(Lcom/riola/player/Ui$OnToggle;)V

    invoke-virtual {p2, p3}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 617
    invoke-virtual {v6, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 621
    const/high16 p3, 0x41200000    # 10.0f

    invoke-static {p0, v3, p3}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    invoke-static {p0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v6, p0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 622
    const/4 p0, 0x1

    invoke-virtual {v6, p0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 623
    invoke-virtual {v6, p1}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 624
    new-instance p0, Lcom/riola/player/Ui$3;

    invoke-direct {p0, p2}, Lcom/riola/player/Ui$3;-><init>(Landroid/widget/Switch;)V

    invoke-virtual {v6, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 627
    return-object v6
.end method

.method public static theme(Lcom/riola/player/Prefs;)V
    .locals 2

    .line 88
    invoke-virtual {p0}, Lcom/riola/player/Prefs;->dark()Z

    move-result v0

    invoke-virtual {p0}, Lcom/riola/player/Prefs;->accent()I

    move-result v1

    invoke-virtual {p0}, Lcom/riola/player/Prefs;->style()I

    move-result p0

    invoke-static {v0, v1, p0}, Lcom/riola/player/Ui;->theme(ZII)V

    .line 89
    return-void
.end method

.method public static theme(ZII)V
    .locals 21

    .line 92
    move/from16 v0, p0

    move/from16 v1, p2

    sput-boolean v0, Lcom/riola/player/Ui;->dark:Z

    .line 93
    const/4 v2, 0x0

    if-ltz v1, :cond_0

    sget-object v3, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    array-length v3, v3

    if-lt v1, v3, :cond_1

    :cond_0
    move v1, v2

    :cond_1
    sput v1, Lcom/riola/player/Ui;->style:I

    .line 95
    const/4 v1, -0x1

    if-eqz v0, :cond_2

    .line 96
    const v3, -0xf1eeea

    sput v3, Lcom/riola/player/Ui;->BG:I

    const v3, -0xe9e3dc

    sput v3, Lcom/riola/player/Ui;->SURF:I

    const v3, -0xe1d9d0

    sput v3, Lcom/riola/player/Ui;->SURF2:I

    const v3, -0xd3cabe

    sput v3, Lcom/riola/player/Ui;->LINE:I

    .line 97
    const v3, -0x17120d

    sput v3, Lcom/riola/player/Ui;->TXT:I

    const v3, -0x6c5e50

    sput v3, Lcom/riola/player/Ui;->DIM:I

    .line 98
    const v3, -0x9495

    sput v3, Lcom/riola/player/Ui;->RED:I

    const v3, -0xc22369

    sput v3, Lcom/riola/player/Ui;->GREEN:I

    const/16 v3, -0x39a4

    sput v3, Lcom/riola/player/Ui;->AMBER:I

    .line 99
    const v3, 0x33ffffff

    sput v3, Lcom/riola/player/Ui;->RIPPLE:I

    const v3, -0xf4f0ec

    sput v3, Lcom/riola/player/Ui;->FIELD:I

    goto :goto_0

    .line 101
    :cond_2
    const v3, -0xb0906

    sput v3, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v3, -0x120e09

    sput v3, Lcom/riola/player/Ui;->SURF2:I

    const v3, -0x292118

    sput v3, Lcom/riola/player/Ui;->LINE:I

    .line 102
    const v3, -0xede7e1

    sput v3, Lcom/riola/player/Ui;->TXT:I

    const v3, -0xa5998d

    sput v3, Lcom/riola/player/Ui;->DIM:I

    .line 103
    const v3, -0x2fc5c6

    sput v3, Lcom/riola/player/Ui;->RED:I

    const v3, -0xef78a6

    sput v3, Lcom/riola/player/Ui;->GREEN:I

    const v3, -0x568c00

    sput v3, Lcom/riola/player/Ui;->AMBER:I

    .line 104
    const/high16 v3, 0x22000000

    sput v3, Lcom/riola/player/Ui;->RIPPLE:I

    const v3, -0x70504

    sput v3, Lcom/riola/player/Ui;->FIELD:I

    .line 107
    :goto_0
    if-nez p1, :cond_3

    sget-object v3, Lcom/riola/player/Ui;->ACCENTS:[I

    aget v3, v3, v2

    goto :goto_1

    :cond_3
    move/from16 v3, p1

    :goto_1
    sput v3, Lcom/riola/player/Ui;->ACC:I

    .line 108
    invoke-static {v3, v0}, Lcom/riola/player/Ui;->shift(IZ)I

    move-result v3

    sput v3, Lcom/riola/player/Ui;->ACC2:I

    .line 109
    sget v3, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v3}, Lcom/riola/player/Ui;->luminance(I)F

    move-result v3

    const v4, 0x3f0ccccd    # 0.55f

    cmpl-float v3, v3, v4

    if-lez v3, :cond_4

    const v3, -0xefebe8

    goto :goto_2

    :cond_4
    move v3, v1

    :goto_2
    sput v3, Lcom/riola/player/Ui;->ONACC:I

    .line 112
    const/high16 v3, 0x41900000    # 18.0f

    sput v3, Lcom/riola/player/Ui;->RAD_CARD:F

    const/high16 v4, 0x41400000    # 12.0f

    sput v4, Lcom/riola/player/Ui;->RAD_BTN:F

    const/high16 v5, 0x41a00000    # 20.0f

    sput v5, Lcom/riola/player/Ui;->RAD_CHIP:F

    const/high16 v6, 0x3f800000    # 1.0f

    sput v6, Lcom/riola/player/Ui;->STROKE_W:F

    .line 113
    const v7, 0x3df5c28f    # 0.12f

    sput v7, Lcom/riola/player/Ui;->TRACK_SP:F

    const v7, 0x3ff33333    # 1.9f

    sput v7, Lcom/riola/player/Ui;->ICON_W:F

    sput v6, Lcom/riola/player/Ui;->PAD:F

    .line 114
    sget-object v7, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    sput-object v7, Lcom/riola/player/Ui;->FONT:Landroid/graphics/Typeface;

    sget-object v7, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    sput-object v7, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    .line 115
    const/4 v7, 0x1

    sput-boolean v7, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    sput-boolean v2, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    .line 117
    sget v8, Lcom/riola/player/Ui;->style:I

    const v9, 0x3e0f5c29    # 0.14f

    const/high16 v10, 0x41c00000    # 24.0f

    const v11, 0x3f666666    # 0.9f

    const v12, 0x3ca3d70a    # 0.02f

    const v13, 0x4019999a    # 2.4f

    const v14, 0x400ccccd    # 2.2f

    const/high16 v15, 0x41000000    # 8.0f

    const/high16 v16, 0x41200000    # 10.0f

    const v17, 0x3f933333    # 1.15f

    const/high16 v18, 0x41b00000    # 22.0f

    const v19, 0x3fb33333    # 1.4f

    const/16 v20, 0x0

    packed-switch v8, :pswitch_data_0

    goto/16 :goto_3

    .line 212
    :pswitch_0
    sput v16, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v15, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v4, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v20, Lcom/riola/player/Ui;->STROKE_W:F

    .line 213
    const v3, 0x3d75c28f    # 0.06f

    sput v3, Lcom/riola/player/Ui;->TRACK_SP:F

    sput v19, Lcom/riola/player/Ui;->ICON_W:F

    const/high16 v3, 0x3fa00000    # 1.25f

    sput v3, Lcom/riola/player/Ui;->PAD:F

    .line 214
    sput-boolean v2, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    .line 215
    if-eqz v0, :cond_5

    .line 216
    const v1, -0xefedeb

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xe9e6e3

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xe3dfdb

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xd9d4cf

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 217
    const v1, -0x191614

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x746d67

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xf2f0ee

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 219
    :cond_5
    const v2, -0x40404

    sput v2, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v2, -0xb0a09

    sput v2, Lcom/riola/player/Ui;->SURF2:I

    const v2, -0x171513

    sput v2, Lcom/riola/player/Ui;->LINE:I

    .line 220
    const v2, -0xe4e1de

    sput v2, Lcom/riola/player/Ui;->TXT:I

    const v2, -0x948d88

    sput v2, Lcom/riola/player/Ui;->DIM:I

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 222
    goto/16 :goto_3

    .line 199
    :pswitch_1
    sput v20, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v20, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v20, Lcom/riola/player/Ui;->RAD_CHIP:F

    const v2, 0x404ccccd    # 3.2f

    sput v2, Lcom/riola/player/Ui;->STROKE_W:F

    .line 200
    sput v12, Lcom/riola/player/Ui;->TRACK_SP:F

    const v2, 0x40333333    # 2.8f

    sput v2, Lcom/riola/player/Ui;->ICON_W:F

    sput v6, Lcom/riola/player/Ui;->PAD:F

    .line 201
    sput-boolean v7, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    .line 202
    sget-object v2, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    sput-object v2, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    .line 203
    const/high16 v2, -0x1000000

    if-eqz v0, :cond_6

    .line 204
    sput v2, Lcom/riola/player/Ui;->BG:I

    const v3, -0xf4f4f5

    sput v3, Lcom/riola/player/Ui;->SURF:I

    const v3, -0xebebec    # -1.9683E38f

    sput v3, Lcom/riola/player/Ui;->SURF2:I

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 205
    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x575758

    sput v1, Lcom/riola/player/Ui;->DIM:I

    sput v2, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 207
    :cond_6
    sput v1, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v3, -0xd0d0e

    sput v3, Lcom/riola/player/Ui;->SURF2:I

    sput v2, Lcom/riola/player/Ui;->LINE:I

    .line 208
    sput v2, Lcom/riola/player/Ui;->TXT:I

    const v2, -0xbbbbbc

    sput v2, Lcom/riola/player/Ui;->DIM:I

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 210
    goto/16 :goto_3

    .line 187
    :pswitch_2
    sput v18, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v3, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v10, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v11, Lcom/riola/player/Ui;->STROKE_W:F

    .line 188
    const v3, 0x3cf5c28f    # 0.03f

    sput v3, Lcom/riola/player/Ui;->TRACK_SP:F

    const v3, 0x3fcccccd    # 1.6f

    sput v3, Lcom/riola/player/Ui;->ICON_W:F

    sput v17, Lcom/riola/player/Ui;->PAD:F

    .line 189
    sput-boolean v2, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    .line 190
    if-eqz v0, :cond_7

    .line 191
    const v1, -0xe6e9db

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xdde1cf

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xd3d8c0

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xc0c7a9

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 192
    const v1, -0x121806

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x58633c

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xeaede1

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 194
    :cond_7
    const v2, -0x50801

    sput v2, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xc1205

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0x1c260e

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 195
    const v1, -0xc4ccb0

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x747d5a

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0x20401

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 197
    goto/16 :goto_3

    .line 176
    :pswitch_3
    sput v5, Lcom/riola/player/Ui;->RAD_CARD:F

    const/high16 v1, 0x41800000    # 16.0f

    sput v1, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v18, Lcom/riola/player/Ui;->RAD_CHIP:F

    const v1, 0x3fa66666    # 1.3f

    sput v1, Lcom/riola/player/Ui;->STROKE_W:F

    .line 177
    sput v9, Lcom/riola/player/Ui;->TRACK_SP:F

    const v1, 0x3fd9999a    # 1.7f

    sput v1, Lcom/riola/player/Ui;->ICON_W:F

    sput v6, Lcom/riola/player/Ui;->PAD:F

    .line 178
    if-eqz v0, :cond_8

    .line 179
    const v1, -0xfaf9f4

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xf4f0e4

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xede5d2

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xd3c392

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 180
    const v1, -0x160e01

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x83733c

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xfbfaf6

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 182
    :cond_8
    const v1, -0xeeece4

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xe5e1d4

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xdcd7c8

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xc3b588

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 183
    const v1, -0xf0c01

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x675d40

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xf0eee6

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 185
    goto/16 :goto_3

    .line 165
    :pswitch_4
    const/high16 v2, 0x41d00000    # 26.0f

    sput v2, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v18, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v10, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v6, Lcom/riola/player/Ui;->STROKE_W:F

    .line 166
    const v2, 0x3e6147ae    # 0.22f

    sput v2, Lcom/riola/player/Ui;->TRACK_SP:F

    sput v19, Lcom/riola/player/Ui;->ICON_W:F

    const v2, 0x3f8ccccd    # 1.1f

    sput v2, Lcom/riola/player/Ui;->PAD:F

    .line 167
    if-eqz v0, :cond_9

    .line 168
    const v1, -0xf7f4ec

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xefead8

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xe8e1ca

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xd5cca8

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 169
    const v1, -0x120e01

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x71653a

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xf8f5ee

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 171
    :cond_9
    const v2, -0xd0b01

    sput v2, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0x151205

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0x362f10

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 172
    const v1, -0xebe7cd

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0xa09870

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0x70601

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 174
    goto/16 :goto_3

    .line 153
    :pswitch_5
    sput v20, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v20, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v20, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v13, Lcom/riola/player/Ui;->STROKE_W:F

    .line 154
    sput v20, Lcom/riola/player/Ui;->TRACK_SP:F

    sput v14, Lcom/riola/player/Ui;->ICON_W:F

    sput v11, Lcom/riola/player/Ui;->PAD:F

    .line 155
    sput-boolean v2, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    sput-boolean v7, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    .line 156
    const v2, -0xb5b5b6

    if-eqz v0, :cond_a

    .line 157
    const v1, -0xd4d4d5

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xc3c3c4

    sput v1, Lcom/riola/player/Ui;->SURF:I

    sput v2, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0x858586

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 158
    const v1, -0xf0f10

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x4b4b4c

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xd9d9da

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 160
    :cond_a
    const v3, -0x404041

    sput v3, Lcom/riola/player/Ui;->BG:I

    const v3, -0x272728

    sput v3, Lcom/riola/player/Ui;->SURF:I

    const v3, -0x333334

    sput v3, Lcom/riola/player/Ui;->SURF2:I

    const v3, -0x919192

    sput v3, Lcom/riola/player/Ui;->LINE:I

    .line 161
    const v3, -0xefeff0

    sput v3, Lcom/riola/player/Ui;->TXT:I

    sput v2, Lcom/riola/player/Ui;->DIM:I

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 163
    goto/16 :goto_3

    .line 139
    :pswitch_6
    const/high16 v3, 0x40000000    # 2.0f

    sput v3, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v3, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v3, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v19, Lcom/riola/player/Ui;->STROKE_W:F

    .line 140
    sput v12, Lcom/riola/player/Ui;->TRACK_SP:F

    sput v3, Lcom/riola/player/Ui;->ICON_W:F

    const v3, 0x3f733333    # 0.95f

    sput v3, Lcom/riola/player/Ui;->PAD:F

    .line 141
    sget-object v3, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    sput-object v3, Lcom/riola/player/Ui;->FONT:Landroid/graphics/Typeface;

    .line 142
    sget-object v3, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-static {v3, v7}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v3

    sput-object v3, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    .line 143
    sput-boolean v2, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    sput-boolean v7, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    .line 144
    if-eqz v0, :cond_b

    .line 145
    const v1, -0xf8f6f5

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xf2eeea

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xebe5df

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xdbcfc0

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 146
    const v1, -0x281b29

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x837384

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xfaf8f6

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto/16 :goto_3

    .line 148
    :cond_b
    const v2, -0x8070b

    sput v2, Lcom/riola/player/Ui;->BG:I

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0x120f16

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0x362d3c

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 149
    const v1, -0xecdfe6

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0xa594a1

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0x40306

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 151
    goto/16 :goto_3

    .line 126
    :pswitch_7
    sput v16, Lcom/riola/player/Ui;->RAD_CARD:F

    sput v15, Lcom/riola/player/Ui;->RAD_BTN:F

    sput v4, Lcom/riola/player/Ui;->RAD_CHIP:F

    sput v14, Lcom/riola/player/Ui;->STROKE_W:F

    .line 127
    const v1, 0x3da3d70a    # 0.08f

    sput v1, Lcom/riola/player/Ui;->TRACK_SP:F

    sput v13, Lcom/riola/player/Ui;->ICON_W:F

    const v1, 0x3f866666    # 1.05f

    sput v1, Lcom/riola/player/Ui;->PAD:F

    .line 128
    sget-object v1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    sput-object v1, Lcom/riola/player/Ui;->FONT:Landroid/graphics/Typeface;

    .line 129
    sget-object v1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    invoke-static {v1, v7}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v1

    sput-object v1, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    .line 130
    if-eqz v0, :cond_c

    .line 131
    const v1, -0xe8edf2

    sput v1, Lcom/riola/player/Ui;->BG:I

    const v1, -0xdce5ed

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0xd1dce6

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0xb5c6d8

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 132
    const v1, -0xc182a

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x465b79

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const v1, -0xedf1f6

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    goto :goto_3

    .line 134
    :cond_c
    const v1, -0x9101e

    sput v1, Lcom/riola/player/Ui;->BG:I

    const/16 v1, -0x612

    sput v1, Lcom/riola/player/Ui;->SURF:I

    const v1, -0x101b2e

    sput v1, Lcom/riola/player/Ui;->SURF2:I

    const v1, -0x34496c

    sput v1, Lcom/riola/player/Ui;->LINE:I

    .line 135
    const v1, -0xd3deec

    sput v1, Lcom/riola/player/Ui;->TXT:I

    const v1, -0x8599b0

    sput v1, Lcom/riola/player/Ui;->DIM:I

    const/16 v1, -0x40d

    sput v1, Lcom/riola/player/Ui;->FIELD:I

    .line 137
    goto :goto_3

    .line 119
    :pswitch_8
    const/high16 v1, 0x40c00000    # 6.0f

    sput v1, Lcom/riola/player/Ui;->RAD_CARD:F

    const/high16 v1, 0x40800000    # 4.0f

    sput v1, Lcom/riola/player/Ui;->RAD_BTN:F

    const/high16 v1, 0x41600000    # 14.0f

    sput v1, Lcom/riola/player/Ui;->RAD_CHIP:F

    const v1, 0x3f4ccccd    # 0.8f

    sput v1, Lcom/riola/player/Ui;->STROKE_W:F

    .line 120
    const v1, 0x3d4ccccd    # 0.05f

    sput v1, Lcom/riola/player/Ui;->TRACK_SP:F

    const/high16 v1, 0x3fc00000    # 1.5f

    sput v1, Lcom/riola/player/Ui;->ICON_W:F

    sput v17, Lcom/riola/player/Ui;->PAD:F

    .line 121
    sget-object v1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    sput-object v1, Lcom/riola/player/Ui;->FONT:Landroid/graphics/Typeface;

    .line 122
    sget-object v1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    invoke-static {v1, v7}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v1

    sput-object v1, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    .line 123
    sput-boolean v2, Lcom/riola/player/Ui;->CAPS_HEADINGS:Z

    .line 124
    nop

    .line 230
    :goto_3
    sget v1, Lcom/riola/player/Ui;->ACC:I

    sget v2, Lcom/riola/player/Ui;->SURF:I

    invoke-static {v1, v2, v0}, Lcom/riola/player/Ui;->readable(IIZ)I

    move-result v1

    sput v1, Lcom/riola/player/Ui;->ACC_TXT:I

    .line 231
    sget v1, Lcom/riola/player/Ui;->ACC:I

    sget v2, Lcom/riola/player/Ui;->SURF:I

    if-eqz v0, :cond_d

    const v9, 0x3e4ccccd    # 0.2f

    :cond_d
    invoke-static {v1, v2, v9}, Lcom/riola/player/Ui;->blend(IIF)I

    move-result v0

    sput v0, Lcom/riola/player/Ui;->ACC_SOFT:I

    .line 232
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static themeRes(Z)I
    .locals 0

    .line 288
    if-eqz p0, :cond_0

    const p0, 0x103022e

    goto :goto_0

    .line 289
    :cond_0
    const p0, 0x1030241

    .line 288
    :goto_0
    return p0
.end method

.method public static toast(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .line 296
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method public static tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;
    .locals 1

    .line 406
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 407
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 408
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 409
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 410
    if-eqz p4, :cond_0

    sget-object p0, Lcom/riola/player/Ui;->FONT_BOLD:Landroid/graphics/Typeface;

    goto :goto_0

    :cond_0
    sget-object p0, Lcom/riola/player/Ui;->FONT:Landroid/graphics/Typeface;

    :goto_0
    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 411
    const/4 p0, -0x2

    invoke-static {p0, p0}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 412
    return-object v0
.end method

.method public static weight(Landroid/view/View;F)Landroid/view/View;
    .locals 2

    .line 339
    const/4 v0, 0x0

    const/4 v1, -0x2

    invoke-static {v0, v1, p1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 340
    return-object p0
.end method
