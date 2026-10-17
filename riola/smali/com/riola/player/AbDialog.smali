.class public final Lcom/riola/player/AbDialog;
.super Ljava/lang/Object;
.source "AbDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/AbDialog$Nudge;,
        Lcom/riola/player/AbDialog$OnPick;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/media/MediaPlayer;[ZI)V
    .locals 0

    .line 21
    invoke-static {p0, p1, p2}, Lcom/riola/player/AbDialog;->seekBy(Landroid/media/MediaPlayer;[ZI)V

    return-void
.end method

.method static synthetic access$100(Landroid/media/MediaPlayer;[Z)I
    .locals 0

    .line 21
    invoke-static {p0, p1}, Lcom/riola/player/AbDialog;->position(Landroid/media/MediaPlayer;[Z)I

    move-result p0

    return p0
.end method

.method static synthetic access$200(Landroid/media/MediaPlayer;[ZJ)V
    .locals 0

    .line 21
    invoke-static {p0, p1, p2, p3}, Lcom/riola/player/AbDialog;->seekTo(Landroid/media/MediaPlayer;[ZJ)V

    return-void
.end method

.method static synthetic access$300(Landroid/media/MediaPlayer;[Z)I
    .locals 0

    .line 21
    invoke-static {p0, p1}, Lcom/riola/player/AbDialog;->duration(Landroid/media/MediaPlayer;[Z)I

    move-result p0

    return p0
.end method

.method private static duration(Landroid/media/MediaPlayer;[Z)I
    .locals 1

    .line 250
    const/4 v0, 0x0

    aget-boolean p1, p1, v0

    if-nez p1, :cond_0

    return v0

    .line 251
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/media/MediaPlayer;->getDuration()I

    move-result p0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    move-exception p0

    return v0
.end method

.method private static markRow(Landroid/app/Activity;Landroid/widget/TextView;Landroid/view/View$OnClickListener;Lcom/riola/player/AbDialog$Nudge;)Landroid/view/View;
    .locals 8

    .line 206
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 207
    const/4 v2, 0x0

    const/high16 v3, 0x40800000    # 4.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40800000    # 4.0f

    move-object v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 208
    const/4 v0, -0x2

    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    invoke-static {v2, v0, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 209
    invoke-virtual {v7, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 210
    new-instance v0, Lcom/riola/player/AbDialog$17;

    invoke-direct {v0, p3}, Lcom/riola/player/AbDialog$17;-><init>(Lcom/riola/player/AbDialog$Nudge;)V

    const-string v1, "-1s"

    invoke-static {p0, v1, v0}, Lcom/riola/player/AbDialog;->nudge(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 213
    new-instance v0, Lcom/riola/player/AbDialog$18;

    invoke-direct {v0, p3}, Lcom/riola/player/AbDialog$18;-><init>(Lcom/riola/player/AbDialog$Nudge;)V

    const-string v1, "+1s"

    invoke-static {p0, v1, v0}, Lcom/riola/player/AbDialog;->nudge(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 216
    const-string v0, "set"

    const/4 v1, 0x1

    invoke-static {p0, v0, v2, v1, p2}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 217
    const/high16 v2, 0x40c00000    # 6.0f

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 218
    invoke-virtual {v7, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 219
    return-object v7
.end method

.method private static nudge(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;
    .locals 5

    .line 223
    sget v0, Lcom/riola/player/Ui;->ACC_TXT:I

    const/4 v1, 0x1

    const/high16 v2, 0x41400000    # 12.0f

    invoke-static {p0, p1, v2, v0, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 224
    const/high16 v0, 0x41200000    # 10.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x41000000    # 8.0f

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {p1, v1, v3, v4, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 225
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    sget v2, Lcom/riola/player/Ui;->LINE:I

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {p0, v1, v2, v0, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 226
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 227
    const/4 p2, -0x2

    invoke-static {p2, p2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p2

    .line 228
    const/high16 v0, 0x40800000    # 4.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x0

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-virtual {p2, v1, v2, p0, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 229
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 230
    return-object p1
.end method

.method private static position(Landroid/media/MediaPlayer;[Z)I
    .locals 1

    .line 245
    const/4 v0, 0x0

    aget-boolean p1, p1, v0

    if-nez p1, :cond_0

    return v0

    .line 246
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result p0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    move-exception p0

    return v0
.end method

.method private static seekBy(Landroid/media/MediaPlayer;[ZI)V
    .locals 1

    .line 234
    const/4 v0, 0x0

    aget-boolean p1, p1, v0

    if-nez p1, :cond_0

    return-void

    .line 235
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result p1

    add-int/2addr p1, p2

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-virtual {p0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 236
    :catch_0
    move-exception p0

    :goto_0
    nop

    .line 237
    return-void
.end method

.method private static seekTo(Landroid/media/MediaPlayer;[ZJ)V
    .locals 2

    .line 240
    const/4 v0, 0x0

    aget-boolean p1, p1, v0

    if-nez p1, :cond_0

    return-void

    .line 241
    :cond_0
    const-wide/16 v0, 0x0

    :try_start_0
    invoke-static {v0, v1, p2, p3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    long-to-int p1, p1

    invoke-virtual {p0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 242
    :goto_0
    return-void
.end method

.method public static show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
    .locals 21

    .line 28
    move-object/from16 v8, p0

    if-nez p1, :cond_0

    return-void

    .line 30
    :cond_0
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object v0

    .line 31
    invoke-virtual {v0}, Lcom/riola/player/Engine;->isRunning()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lcom/riola/player/Engine;->stop()V

    .line 33
    :cond_1
    const/4 v0, 0x1

    new-array v15, v0, [J

    const-wide/16 v1, 0x0

    move-wide/from16 v3, p2

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    const/4 v9, 0x0

    aput-wide v3, v15, v9

    .line 34
    new-array v14, v0, [J

    aput-wide p4, v14, v9

    .line 35
    new-array v13, v0, [Z

    aput-boolean v9, v13, v9

    .line 36
    new-array v12, v0, [Z

    aput-boolean v0, v12, v9

    .line 37
    new-instance v11, Landroid/media/MediaPlayer;

    invoke-direct {v11}, Landroid/media/MediaPlayer;-><init>()V

    .line 38
    new-instance v10, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v10, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 40
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 41
    const/high16 v3, 0x41900000    # 18.0f

    invoke-static {v8, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    .line 42
    const/high16 v4, 0x40c00000    # 6.0f

    invoke-static {v8, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v7, v3, v4, v3, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 44
    const/high16 v3, 0x41700000    # 15.0f

    sget v4, Lcom/riola/player/Ui;->ACC_TXT:I

    const-string v5, "0:00 / 0:00"

    invoke-static {v8, v5, v3, v4}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v6

    .line 45
    const/16 v3, 0x11

    invoke-virtual {v6, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 46
    const/4 v5, -0x1

    const/4 v4, -0x2

    invoke-static {v5, v4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 47
    invoke-virtual {v7, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 49
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, v8}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 50
    invoke-static {v5, v4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 51
    sget v3, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v3}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 52
    sget v3, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v3}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 53
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 55
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "A   "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-wide v16, v15, v9

    invoke-static/range {v16 .. v17}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget v4, Lcom/riola/player/Ui;->TXT:I

    const/high16 v5, 0x41600000    # 14.0f

    invoke-static {v8, v3, v5, v4}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v4

    .line 56
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "B   "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-wide v16, v14, v9

    cmp-long v1, v16, v1

    if-gez v1, :cond_2

    const-string v1, "end"

    goto :goto_0

    :cond_2
    invoke-static/range {v16 .. v17}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget v2, Lcom/riola/player/Ui;->TXT:I

    const/high16 v3, 0x41600000    # 14.0f

    invoke-static {v8, v1, v3, v2}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v5

    .line 58
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 59
    const/16 v1, 0x11

    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 60
    const/4 v2, 0x1

    const/16 v16, 0x14

    const/16 v17, 0x1

    const-string v18, "Play"

    const/16 v19, 0x0

    move-object/from16 v1, p0

    move-object v9, v3

    move/from16 v3, v16

    move-object/from16 p5, v4

    move/from16 v4, v17

    move-object/from16 p3, v5

    move-object/from16 v5, v18

    move-object/from16 v20, v6

    move-object/from16 v6, v19

    invoke-static/range {v1 .. v6}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v6

    .line 61
    new-instance v1, Lcom/riola/player/AbDialog$1;

    invoke-direct {v1, v11, v13}, Lcom/riola/player/AbDialog$1;-><init>(Landroid/media/MediaPlayer;[Z)V

    const-string v2, "-5s"

    invoke-static {v8, v2, v1}, Lcom/riola/player/AbDialog;->nudge(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 64
    invoke-virtual {v9, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 65
    new-instance v1, Lcom/riola/player/AbDialog$2;

    invoke-direct {v1, v11, v13}, Lcom/riola/player/AbDialog$2;-><init>(Landroid/media/MediaPlayer;[Z)V

    const-string v2, "+5s"

    invoke-static {v8, v2, v1}, Lcom/riola/player/AbDialog;->nudge(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 68
    const/4 v3, 0x0

    const/high16 v4, 0x41000000    # 8.0f

    const/4 v5, 0x0

    const/high16 v16, 0x40c00000    # 6.0f

    move-object/from16 v1, p0

    move-object v2, v9

    move-object/from16 p4, v0

    move-object v0, v6

    move/from16 v6, v16

    invoke-static/range {v1 .. v6}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 69
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 71
    new-instance v1, Lcom/riola/player/AbDialog$3;

    invoke-direct {v1, v13, v11, v0}, Lcom/riola/player/AbDialog$3;-><init>([ZLandroid/media/MediaPlayer;Landroid/widget/ImageView;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 84
    new-instance v9, Lcom/riola/player/AbDialog$4;

    move-object v1, v9

    move-object v2, v15

    move-object v3, v11

    move-object v4, v13

    move-object v5, v14

    move-object/from16 v6, p5

    move-object/from16 v16, v10

    move-object v10, v7

    move-object/from16 v7, p3

    invoke-direct/range {v1 .. v7}, Lcom/riola/player/AbDialog$4;-><init>([JLandroid/media/MediaPlayer;[Z[JLandroid/widget/TextView;Landroid/widget/TextView;)V

    new-instance v1, Lcom/riola/player/AbDialog$5;

    move-object/from16 v2, p5

    invoke-direct {v1, v15, v14, v2}, Lcom/riola/player/AbDialog$5;-><init>([J[JLandroid/widget/TextView;)V

    invoke-static {v8, v2, v9, v1}, Lcom/riola/player/AbDialog;->markRow(Landroid/app/Activity;Landroid/widget/TextView;Landroid/view/View$OnClickListener;Lcom/riola/player/AbDialog$Nudge;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 99
    new-instance v9, Lcom/riola/player/AbDialog$6;

    move-object v1, v9

    move-object v2, v11

    move-object v3, v13

    move-object v4, v15

    move-object/from16 v5, p0

    move-object v6, v14

    invoke-direct/range {v1 .. v7}, Lcom/riola/player/AbDialog$6;-><init>(Landroid/media/MediaPlayer;[Z[JLandroid/app/Activity;[JLandroid/widget/TextView;)V

    new-instance v7, Lcom/riola/player/AbDialog$7;

    move-object v1, v7

    move-object v2, v14

    move-object v3, v11

    move-object v4, v13

    move-object v5, v15

    move-object/from16 v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/riola/player/AbDialog$7;-><init>([JLandroid/media/MediaPlayer;[Z[JLandroid/widget/TextView;)V

    move-object/from16 v1, p3

    invoke-static {v8, v1, v9, v7}, Lcom/riola/player/AbDialog;->markRow(Landroid/app/Activity;Landroid/widget/TextView;Landroid/view/View$OnClickListener;Lcom/riola/player/AbDialog$Nudge;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    new-instance v1, Lcom/riola/player/AbDialog$8;

    invoke-direct {v1, v12}, Lcom/riola/player/AbDialog$8;-><init>([Z)V

    const-string v2, "Loop A-B while listening"

    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-static {v8, v2, v3, v4, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 119
    new-instance v2, Lcom/riola/player/AbDialog$9;

    invoke-direct {v2, v11, v13, v15}, Lcom/riola/player/AbDialog$9;-><init>(Landroid/media/MediaPlayer;[Z[J)V

    const-string v4, "jump to A"

    const/4 v5, 0x0

    invoke-static {v8, v4, v5, v2}, Lcom/riola/player/Ui;->chip(Landroid/content/Context;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 122
    new-instance v2, Lcom/riola/player/AbDialog$10;

    invoke-direct {v2, v11, v13, v14}, Lcom/riola/player/AbDialog$10;-><init>(Landroid/media/MediaPlayer;[Z[J)V

    const-string v4, "jump to B"

    invoke-static {v8, v4, v5, v2}, Lcom/riola/player/Ui;->chip(Landroid/content/Context;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 125
    invoke-virtual {v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 126
    const/high16 v1, 0x40800000    # 4.0f

    invoke-static {v8, v1}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 128
    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, v8}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 129
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x2

    const/4 v5, -0x1

    invoke-direct {v2, v5, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v10, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 131
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 132
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 133
    const-string v2, "Cancel"

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/riola/player/AbDialog$11;

    move-object/from16 v3, p6

    invoke-direct {v2, v14, v15, v3}, Lcom/riola/player/AbDialog$11;-><init>([J[JLcom/riola/player/AbDialog$OnPick;)V

    .line 134
    const-string v3, "Use this section"

    invoke-virtual {v1, v3, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 140
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 142
    new-instance v2, Lcom/riola/player/AbDialog$12;

    move-object v9, v2

    move-object/from16 v3, v16

    move-object v10, v13

    move-object v4, v11

    move-object v5, v12

    move-object/from16 v12, p4

    move-object v6, v13

    move-object/from16 v13, v20

    move-object v7, v14

    move-object v14, v5

    move-object v5, v15

    move-object v15, v7

    move-object/from16 v16, v5

    move-object/from16 v17, v0

    move-object/from16 v18, v3

    invoke-direct/range {v9 .. v18}, Lcom/riola/player/AbDialog$12;-><init>([ZLandroid/media/MediaPlayer;Landroid/widget/SeekBar;Landroid/widget/TextView;[Z[J[JLandroid/widget/ImageView;Landroid/os/Handler;)V

    .line 159
    new-instance v0, Lcom/riola/player/AbDialog$13;

    invoke-direct {v0, v4, v6}, Lcom/riola/player/AbDialog$13;-><init>(Landroid/media/MediaPlayer;[Z)V

    move-object/from16 v7, p4

    invoke-virtual {v7, v0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 167
    new-instance v0, Lcom/riola/player/AbDialog$14;

    invoke-direct {v0, v3, v2, v4}, Lcom/riola/player/AbDialog$14;-><init>(Landroid/os/Handler;Ljava/lang/Runnable;Landroid/media/MediaPlayer;)V

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 176
    :try_start_0
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    .line 177
    const/4 v9, 0x1

    invoke-virtual {v0, v9}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 178
    const/4 v9, 0x2

    invoke-virtual {v0, v9}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 176
    invoke-virtual {v4, v0}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 179
    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Track;->toUri()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v4, v8, v0}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 180
    new-instance v0, Lcom/riola/player/AbDialog$15;

    move-object/from16 p1, v0

    move-object/from16 p2, v6

    move-object/from16 p3, v7

    move-object/from16 p4, v20

    move-object/from16 p5, v4

    move-object/from16 p6, v5

    invoke-direct/range {p1 .. p6}, Lcom/riola/player/AbDialog$15;-><init>([ZLandroid/widget/SeekBar;Landroid/widget/TextView;Landroid/media/MediaPlayer;[J)V

    invoke-virtual {v4, v0}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 188
    new-instance v0, Lcom/riola/player/AbDialog$16;

    invoke-direct {v0, v8}, Lcom/riola/player/AbDialog$16;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v4, v0}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 194
    invoke-virtual {v4}, Landroid/media/MediaPlayer;->prepareAsync()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 197
    goto :goto_1

    .line 195
    :catch_0
    move-exception v0

    .line 196
    const-string v0, "Cannot open this file"

    invoke-static {v8, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 199
    :goto_1
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 200
    const-wide/16 v0, 0xc8

    invoke-virtual {v3, v2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 201
    return-void
.end method
