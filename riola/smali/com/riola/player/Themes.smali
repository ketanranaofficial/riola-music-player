.class public final Lcom/riola/player/Themes;
.super Ljava/lang/Object;
.source "Themes.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/Themes$OnChosen;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
    .locals 0

    .line 16
    invoke-static {p0, p1, p2}, Lcom/riola/player/Themes;->custom(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V

    return-void
.end method

.method public static colour(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
    .locals 17

    .line 24
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move-object/from16 v8, p2

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Prefs;->accent()I

    move-result v9

    .line 26
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v10

    .line 27
    const/high16 v0, 0x41900000    # 18.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 28
    const/high16 v1, 0x41000000    # 8.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v11, 0x0

    invoke-virtual {v10, v0, v1, v0, v11}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 30
    const/4 v12, 0x1

    new-array v13, v12, [Landroid/app/AlertDialog;

    .line 32
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 33
    move v14, v11

    :goto_0
    sget-object v1, Lcom/riola/player/Ui;->ACCENTS:[I

    array-length v1, v1

    if-ge v14, v1, :cond_2

    .line 34
    sget-object v1, Lcom/riola/player/Ui;->ACCENTS:[I

    aget v15, v1, v14

    .line 35
    const/4 v1, 0x4

    if-ne v14, v1, :cond_0

    .line 36
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 37
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v16

    .line 38
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    move-object/from16 v0, v16

    .line 40
    :cond_0
    if-ne v15, v9, :cond_1

    move v1, v12

    goto :goto_1

    :cond_1
    move v1, v11

    :goto_1
    invoke-static {v6, v15, v1}, Lcom/riola/player/Themes;->swatch(Landroid/app/Activity;IZ)Landroid/view/View;

    move-result-object v1

    .line 41
    new-instance v2, Lcom/riola/player/Themes$1;

    invoke-direct {v2, v7, v15, v13, v8}, Lcom/riola/player/Themes$1;-><init>(Lcom/riola/player/Prefs;I[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 49
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 33
    add-int/lit8 v14, v14, 0x1

    goto :goto_0

    .line 51
    :cond_2
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 53
    const/high16 v0, 0x41380000    # 11.5f

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const-string v2, "The colour is used for buttons, highlights and the playing step."

    invoke-static {v6, v2, v0, v1, v11}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v9

    .line 55
    const/high16 v2, 0x40000000    # 2.0f

    const/high16 v3, 0x41400000    # 12.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v9

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 56
    invoke-virtual {v10, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 57
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 59
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Colour"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v10}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 60
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/Themes$2;

    invoke-direct {v1, v6, v7, v8}, Lcom/riola/player/Themes$2;-><init>(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V

    .line 61
    const-string v2, "Mix your own"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 63
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    aput-object v0, v13, v11

    .line 64
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 65
    return-void
.end method

.method private static custom(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
    .locals 17

    .line 83
    move-object/from16 v6, p0

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Prefs;->accent()I

    move-result v0

    .line 84
    shr-int/lit8 v1, v0, 0x10

    const/16 v7, 0xff

    and-int/2addr v1, v7

    shr-int/lit8 v2, v0, 0x8

    and-int/2addr v2, v7

    and-int/2addr v0, v7

    filled-new-array {v1, v2, v0}, [I

    move-result-object v8

    .line 86
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 87
    const/high16 v0, 0x41900000    # 18.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 88
    const/high16 v1, 0x41200000    # 10.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v10, 0x0

    invoke-virtual {v9, v0, v1, v0, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 90
    new-instance v11, Landroid/view/View;

    invoke-direct {v11, v6}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 91
    const/high16 v0, 0x42800000    # 64.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    const/4 v1, -0x1

    invoke-static {v1, v0}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 92
    invoke-virtual {v9, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 94
    sget v0, Lcom/riola/player/Ui;->DIM:I

    const-string v2, ""

    const/high16 v12, 0x41500000    # 13.0f

    invoke-static {v6, v2, v12, v0}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v13

    .line 95
    const/16 v0, 0x11

    invoke-virtual {v13, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 96
    const/4 v14, -0x2

    invoke-static {v1, v14}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v13, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 97
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    move-object v1, v13

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 98
    invoke-virtual {v9, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    new-instance v15, Lcom/riola/player/Themes$3;

    invoke-direct {v15, v8, v6, v11, v13}, Lcom/riola/player/Themes$3;-><init>([ILandroid/app/Activity;Landroid/view/View;Landroid/widget/TextView;)V

    .line 111
    invoke-interface {v15}, Ljava/lang/Runnable;->run()V

    .line 113
    const-string v0, "Green"

    const-string v1, "Blue"

    const-string v2, "Red"

    filled-new-array {v2, v0, v1}, [Ljava/lang/String;

    move-result-object v11

    .line 114
    move v13, v10

    :goto_0
    const/4 v0, 0x3

    if-ge v13, v0, :cond_0

    .line 115
    nop

    .line 116
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v5

    .line 117
    const/4 v2, 0x0

    const/high16 v3, 0x40800000    # 4.0f

    const/4 v4, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p0

    move-object v1, v5

    move-object v14, v5

    move/from16 v5, v16

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 118
    aget-object v0, v11, v13

    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v6, v0, v12, v1, v10}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 119
    const/high16 v1, 0x42600000    # 56.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setWidth(I)V

    .line 120
    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 121
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, v6}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 122
    invoke-virtual {v0, v7}, Landroid/widget/SeekBar;->setMax(I)V

    .line 123
    aget v1, v8, v13

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 124
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, -0x2

    invoke-static {v10, v2, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 125
    sget v1, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 126
    sget v1, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 127
    new-instance v1, Lcom/riola/player/Themes$4;

    invoke-direct {v1, v8, v13, v15}, Lcom/riola/player/Themes$4;-><init>([IILjava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 135
    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 136
    invoke-virtual {v9, v14}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    add-int/lit8 v13, v13, 0x1

    move v14, v2

    goto :goto_0

    .line 138
    :cond_0
    const/high16 v0, 0x41000000    # 8.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 140
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Mix a colour"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v9}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 141
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/Themes$5;

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    invoke-direct {v1, v2, v8, v3}, Lcom/riola/player/Themes$5;-><init>(Lcom/riola/player/Prefs;[ILcom/riola/player/Themes$OnChosen;)V

    .line 142
    const-string v2, "Use it"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 147
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 148
    return-void
.end method

.method public static look(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
    .locals 16

    .line 152
    move-object/from16 v6, p0

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Prefs;->style()I

    move-result v7

    .line 154
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 155
    const/high16 v9, 0x41400000    # 12.0f

    invoke-static {v6, v9}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 156
    const/4 v10, 0x0

    invoke-virtual {v8, v0, v0, v0, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 158
    const/4 v11, 0x1

    new-array v12, v11, [Landroid/app/AlertDialog;

    .line 160
    move v13, v10

    :goto_0
    sget-object v0, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    array-length v0, v0

    const/4 v14, -0x2

    if-ge v13, v0, :cond_2

    .line 161
    nop

    .line 162
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v15

    .line 163
    invoke-static {v6, v9}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v1, 0x41300000    # 11.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-static {v6, v9}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {v15, v0, v2, v3, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 164
    if-ne v13, v7, :cond_0

    .line 165
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    sget v2, Lcom/riola/player/Ui;->RAD_BTN:F

    const v3, 0x3fb33333    # 1.4f

    invoke-static {v6, v0, v1, v2, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1

    .line 166
    :cond_0
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->RAD_BTN:F

    invoke-static {v6, v0, v1}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 164
    :goto_1
    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v15, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 167
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    move-object v1, v15

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 168
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 169
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v10, v14, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 170
    sget-object v1, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    aget-object v1, v1, v13

    const/high16 v2, 0x41700000    # 15.0f

    sget v3, Lcom/riola/player/Ui;->TXT:I

    invoke-static {v6, v1, v2, v3, v11}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 171
    sget-object v1, Lcom/riola/player/Ui;->STYLE_NOTES:[Ljava/lang/String;

    aget-object v1, v1, v13

    const/high16 v2, 0x41380000    # 11.5f

    sget v3, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v6, v1, v2, v3, v10}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 172
    invoke-virtual {v15, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 173
    if-ne v13, v7, :cond_1

    sget v0, Lcom/riola/player/Ui;->ACC_TXT:I

    const/16 v1, 0x12

    const/16 v2, 0x10

    invoke-static {v6, v2, v0, v1}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v15, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 174
    :cond_1
    new-instance v0, Lcom/riola/player/Themes$6;

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-direct {v0, v1, v13, v12, v2}, Lcom/riola/player/Themes$6;-><init>(Lcom/riola/player/Prefs;I[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V

    invoke-virtual {v15, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 182
    invoke-virtual {v8, v15}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 160
    add-int/lit8 v13, v13, 0x1

    goto/16 :goto_0

    .line 185
    :cond_2
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, v6}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 186
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x1

    invoke-direct {v1, v2, v14}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v8, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 187
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "Look"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 188
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    aput-object v0, v12, v10

    .line 189
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 190
    return-void
.end method

.method private static swatch(Landroid/app/Activity;IZ)Landroid/view/View;
    .locals 3

    .line 68
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 69
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 70
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 71
    if-eqz p2, :cond_0

    const/high16 p1, 0x40400000    # 3.0f

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p1

    sget v1, Lcom/riola/player/Ui;->TXT:I

    invoke-virtual {v0, p1, v1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 72
    :cond_0
    new-instance p1, Landroid/view/View;

    invoke-direct {p1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 73
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 74
    const/high16 v0, 0x42500000    # 52.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {v1, v0}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    .line 75
    const/high16 v1, 0x40c00000    # 6.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 v1, 0x0

    invoke-virtual {v0, v2, v1, p0, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 76
    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 77
    if-eqz p2, :cond_1

    const-string p0, "colour, selected"

    goto :goto_0

    :cond_1
    const-string p0, "colour"

    :goto_0
    invoke-virtual {p1, p0}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 78
    return-object p1
.end method
