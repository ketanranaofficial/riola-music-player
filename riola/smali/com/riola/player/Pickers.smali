.class public final Lcom/riola/player/Pickers;
.super Ljava/lang/Object;
.source "Pickers.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/Pickers$OnTrack;,
        Lcom/riola/player/Pickers$OnMs;,
        Lcom/riola/player/Pickers$OnText;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V
    .locals 0

    .line 14
    invoke-static {p0, p1, p2, p3}, Lcom/riola/player/Pickers;->fillDuration(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V

    return-void
.end method

.method public static duration(Landroid/app/Activity;Ljava/lang/String;JLcom/riola/player/Pickers$OnMs;)V
    .locals 4

    .line 33
    const/4 v0, 0x1

    new-array v1, v0, [J

    const-wide/16 v2, 0x0

    invoke-static {v2, v3, p2, p3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p2

    const/4 v2, 0x0

    aput-wide p2, v1, v2

    .line 35
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object p2

    .line 36
    const/high16 p3, 0x41900000    # 18.0f

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p3

    .line 37
    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {p2, p3, v3, p3, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 39
    new-array p3, v0, [Ljava/lang/Runnable;

    .line 40
    new-instance v0, Lcom/riola/player/Pickers$2;

    invoke-direct {v0, p0, p2, v1, p3}, Lcom/riola/player/Pickers$2;-><init>(Landroid/app/Activity;Landroid/widget/LinearLayout;[J[Ljava/lang/Runnable;)V

    aput-object v0, p3, v2

    .line 43
    aget-object p3, p3, v2

    invoke-interface {p3}, Ljava/lang/Runnable;->run()V

    .line 45
    new-instance p3, Landroid/widget/ScrollView;

    invoke-direct {p3, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 46
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v0, v2, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p3, p2, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 48
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p0, p3}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 49
    const-string p1, "Cancel"

    const/4 p2, 0x0

    invoke-virtual {p0, p1, p2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    new-instance p1, Lcom/riola/player/Pickers$3;

    invoke-direct {p1, p4, v1}, Lcom/riola/player/Pickers$3;-><init>(Lcom/riola/player/Pickers$OnMs;[J)V

    .line 50
    const-string p2, "Set"

    invoke-virtual {p0, p2, p1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 52
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 53
    return-void
.end method

.method private static fillDuration(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V
    .locals 17

    .line 61
    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    invoke-virtual/range {p1 .. p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 63
    const/4 v10, 0x0

    aget-wide v0, v9, v10

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    const/high16 v2, 0x41f00000    # 30.0f

    const/4 v3, 0x1

    invoke-static {v7, v0, v2, v1, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v11

    .line 64
    const/16 v0, 0x11

    invoke-virtual {v11, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 65
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-static {v0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 66
    invoke-virtual {v8, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 68
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 69
    const/4 v2, 0x7

    new-array v4, v2, [I

    fill-array-data v4, :array_0

    .line 70
    move v5, v10

    :goto_0
    const-wide/16 v12, 0x3e8

    if-ge v5, v2, :cond_2

    .line 71
    aget v6, v4, v5

    .line 72
    const/16 v14, 0x3c

    if-ge v6, v14, :cond_0

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "s"

    goto :goto_1

    :cond_0
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    div-int/lit8 v15, v6, 0x3c

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "m"

    :goto_1
    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    aget-wide v15, v9, v10

    int-to-long v2, v6

    mul-long/2addr v2, v12

    cmp-long v2, v15, v2

    if-nez v2, :cond_1

    const/4 v2, 0x1

    goto :goto_2

    :cond_1
    move v2, v10

    :goto_2
    new-instance v3, Lcom/riola/player/Pickers$4;

    move-object/from16 v15, p3

    invoke-direct {v3, v9, v6, v15}, Lcom/riola/player/Pickers$4;-><init>([JILjava/lang/Runnable;)V

    invoke-static {v7, v14, v2, v3}, Lcom/riola/player/Ui;->chip(Landroid/content/Context;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 70
    add-int/lit8 v5, v5, 0x1

    const/4 v2, 0x7

    const/4 v3, 0x1

    goto :goto_0

    .line 80
    :cond_2
    new-instance v6, Landroid/widget/HorizontalScrollView;

    invoke-direct {v6, v7}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 81
    invoke-virtual {v6, v10}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 82
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v2, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v0, v2}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 83
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 84
    invoke-virtual {v8, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 86
    aget-wide v0, v9, v10

    const-wide/32 v14, 0xea60

    div-long/2addr v0, v14

    long-to-int v1, v0

    const/4 v2, 0x0

    const/16 v3, 0x258

    const/4 v4, 0x1

    const-string v5, ""

    new-instance v6, Lcom/riola/player/Pickers$5;

    invoke-direct {v6, v9, v11}, Lcom/riola/player/Pickers$5;-><init>([JLandroid/widget/TextView;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    const-string v1, "Minutes"

    invoke-static {v7, v1, v0}, Lcom/riola/player/Pickers;->labelled(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 93
    aget-wide v0, v9, v10

    rem-long/2addr v0, v14

    div-long/2addr v0, v12

    long-to-int v1, v0

    const/16 v3, 0x37

    const/4 v4, 0x5

    const-string v5, ""

    new-instance v6, Lcom/riola/player/Pickers$6;

    invoke-direct {v6, v9, v11}, Lcom/riola/player/Pickers$6;-><init>([JLandroid/widget/TextView;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    const-string v1, "Seconds"

    invoke-static {v7, v1, v0}, Lcom/riola/player/Pickers;->labelled(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v7, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 101
    return-void

    :array_0
    .array-data 4
        0xf
        0x1e
        0x3c
        0x78
        0x12c
        0x258
        0x4b0
    .end array-data
.end method

.method private static labelled(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View;)Landroid/view/View;
    .locals 7

    .line 170
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 171
    const/4 v2, 0x0

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 172
    sget v0, Lcom/riola/player/Ui;->DIM:I

    const/high16 v1, 0x41580000    # 13.5f

    const/4 v2, 0x0

    invoke-static {p0, p1, v1, v0, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object p1

    .line 173
    const/high16 v0, 0x3f800000    # 1.0f

    const/4 v1, -0x2

    invoke-static {v2, v1, v0}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 174
    invoke-virtual {v6, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 175
    const/high16 p1, 0x432a0000    # 170.0f

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p0

    invoke-virtual {p2, p0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 176
    invoke-virtual {v6, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 177
    return-object v6
.end method

.method public static position(Landroid/app/Activity;Ljava/lang/String;JJLcom/riola/player/Pickers$OnMs;)V
    .locals 16

    .line 105
    move-object/from16 v7, p0

    const/4 v0, 0x1

    new-array v8, v0, [J

    const-wide/16 v1, 0x0

    move-wide/from16 v3, p2

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    const/4 v9, 0x0

    aput-wide v3, v8, v9

    .line 106
    cmp-long v1, p4, v1

    if-lez v1, :cond_0

    move-wide/from16 v10, p4

    goto :goto_0

    :cond_0
    const-wide/32 v2, 0x5265c00

    move-wide v10, v2

    .line 108
    :goto_0
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v12

    .line 109
    const/high16 v2, 0x41900000    # 18.0f

    invoke-static {v7, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 110
    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {v7, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v12, v2, v3, v2, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 112
    aget-wide v2, v8, v9

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41f00000    # 30.0f

    sget v4, Lcom/riola/player/Ui;->ACC_TXT:I

    invoke-static {v7, v2, v3, v4, v0}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v13

    .line 113
    const/16 v2, 0x11

    invoke-virtual {v13, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 114
    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-static {v3, v4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v13, v5}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 115
    invoke-virtual {v12, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 116
    if-lez v1, :cond_1

    .line 117
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "track is "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static/range {p4 .. p5}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " long"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/high16 v5, 0x41380000    # 11.5f

    sget v6, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v7, v1, v5, v6, v9}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 118
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 119
    invoke-static {v3, v4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 120
    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    :cond_1
    aget-wide v1, v8, v9

    const-wide/32 v14, 0xea60

    div-long/2addr v1, v14

    long-to-int v1, v1

    const/4 v2, 0x0

    div-long v3, v10, v14

    long-to-int v3, v3

    add-int/2addr v3, v0

    const/4 v4, 0x1

    const-string v5, ""

    new-instance v6, Lcom/riola/player/Pickers$7;

    invoke-direct {v6, v8, v10, v11, v13}, Lcom/riola/player/Pickers$7;-><init>([JJLandroid/widget/TextView;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    const-string v1, "Minutes"

    invoke-static {v7, v1, v0}, Lcom/riola/player/Pickers;->labelled(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 129
    aget-wide v0, v8, v9

    rem-long/2addr v0, v14

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    long-to-int v1, v0

    const/4 v2, 0x0

    const/16 v3, 0x3b

    const-string v5, ""

    new-instance v6, Lcom/riola/player/Pickers$8;

    invoke-direct {v6, v8, v10, v11, v13}, Lcom/riola/player/Pickers$8;-><init>([JJLandroid/widget/TextView;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    const-string v1, "Seconds"

    invoke-static {v7, v1, v0}, Lcom/riola/player/Pickers;->labelled(Landroid/app/Activity;Ljava/lang/String;Landroid/view/View;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 135
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v7, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 137
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v12}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 138
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/Pickers$9;

    move-object/from16 v2, p6

    invoke-direct {v1, v2, v8}, Lcom/riola/player/Pickers$9;-><init>(Lcom/riola/player/Pickers$OnMs;[J)V

    .line 139
    const-string v2, "Set"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 141
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 142
    return-void
.end method

.method public static text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V
    .locals 3

    .line 146
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 147
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 148
    invoke-virtual {v0, p3}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 149
    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 150
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelectAllOnFocus(Z)V

    .line 151
    invoke-virtual {v0}, Landroid/widget/EditText;->selectAll()V

    .line 152
    sget p2, Lcom/riola/player/Ui;->TXT:I

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setTextColor(I)V

    .line 153
    sget p2, Lcom/riola/player/Ui;->DIM:I

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 154
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object p2

    .line 155
    const/high16 p3, 0x41a00000    # 20.0f

    invoke-static {p0, p3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result p3

    .line 156
    const/high16 v1, 0x41000000    # 8.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p2, p3, v1, p3, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 157
    invoke-virtual {p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 158
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p3

    invoke-virtual {p3, p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 159
    const-string p2, "Cancel"

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Lcom/riola/player/Pickers$10;

    invoke-direct {p2, v0, p0, p4}, Lcom/riola/player/Pickers$10;-><init>(Landroid/widget/EditText;Landroid/app/Activity;Lcom/riola/player/Pickers$OnText;)V

    .line 160
    const-string p0, "Save"

    invoke-virtual {p1, p0, p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 166
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 167
    return-void
.end method

.method public static track(Landroid/app/Activity;Ljava/lang/String;Lcom/riola/player/Pickers$OnTrack;)V
    .locals 1

    .line 24
    new-instance v0, Lcom/riola/player/Pickers$1;

    invoke-direct {v0, p2}, Lcom/riola/player/Pickers$1;-><init>(Lcom/riola/player/Pickers$OnTrack;)V

    const/4 p2, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/riola/player/TrackPicker;->show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V

    .line 29
    return-void
.end method
