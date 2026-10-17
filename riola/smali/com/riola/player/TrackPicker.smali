.class public final Lcom/riola/player/TrackPicker;
.super Ljava/lang/Object;
.source "TrackPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/TrackPicker$OnPicked;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Lcom/riola/player/Track;Z[ZLjava/util/Set;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;Ljava/lang/Runnable;)Landroid/view/View;
    .locals 0

    .line 29
    invoke-static/range {p0 .. p7}, Lcom/riola/player/TrackPicker;->row(Landroid/app/Activity;Lcom/riola/player/Track;Z[ZLjava/util/Set;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;Ljava/lang/Runnable;)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method private static row(Landroid/app/Activity;Lcom/riola/player/Track;Z[ZLjava/util/Set;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;Ljava/lang/Runnable;)Landroid/view/View;
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/riola/player/Track;",
            "Z[Z",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;[",
            "Landroid/app/AlertDialog;",
            "Lcom/riola/player/TrackPicker$OnPicked;",
            "Ljava/lang/Runnable;",
            ")",
            "Landroid/view/View;"
        }
    .end annotation

    .line 163
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Track;->key()Ljava/lang/String;

    move-result-object v9

    .line 164
    move-object/from16 v10, p4

    invoke-interface {v10, v9}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v8

    .line 166
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 167
    if-eqz v8, :cond_0

    .line 168
    sget v0, Lcom/riola/player/Ui;->ACC_SOFT:I

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    sget v2, Lcom/riola/player/Ui;->RAD_BTN:F

    const v3, 0x3f99999a    # 1.2f

    invoke-static {v6, v0, v1, v2, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0

    .line 169
    :cond_0
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->RAD_BTN:F

    invoke-static {v6, v0, v1}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 167
    :goto_0
    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 170
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v1, 0x41100000    # 9.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v3, 0x41400000    # 12.0f

    invoke-static {v6, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {v11, v0, v2, v3, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 171
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    move-object v1, v11

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 174
    if-eqz v8, :cond_1

    const/16 v0, 0x10

    goto :goto_1

    :cond_1
    const/16 v0, 0xe

    :goto_1
    move v12, v0

    .line 175
    if-eqz v8, :cond_2

    sget v0, Lcom/riola/player/Ui;->ACC_TXT:I

    goto :goto_2

    :cond_2
    sget v0, Lcom/riola/player/Ui;->DIM:I

    :goto_2
    move v13, v0

    const/16 v14, 0x10

    .line 176
    if-eqz v8, :cond_3

    const-string v0, "Selected"

    goto :goto_3

    :cond_3
    const-string v0, "Select this track"

    :goto_3
    move-object v8, v0

    new-instance v15, Lcom/riola/player/TrackPicker$7;

    move-object v0, v15

    move/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object v4, v9

    move-object/from16 v5, p7

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/TrackPicker$7;-><init>(Z[ZLjava/util/Set;Ljava/lang/String;Ljava/lang/Runnable;)V

    .line 174
    move-object/from16 v0, p0

    move v1, v12

    move v2, v13

    move v3, v14

    move-object v4, v8

    move-object v5, v15

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    .line 185
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 187
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 188
    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    invoke-static {v3, v1, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 189
    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41600000    # 14.0f

    sget v4, Lcom/riola/player/Ui;->TXT:I

    invoke-static {v6, v1, v2, v4, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 190
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 191
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 192
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v4, v7, Lcom/riola/player/Track;->durMs:J

    const-wide/16 v12, 0x0

    cmp-long v2, v4, v12

    if-lez v2, :cond_4

    iget-wide v4, v7, Lcom/riola/player/Track;->durMs:J

    invoke-static {v4, v5}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v2

    goto :goto_4

    :cond_4
    const-string v2, "length unknown"

    :goto_4
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 193
    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Track;->isVideo()Z

    move-result v2

    if-eqz v2, :cond_5

    const-string v2, "  .  video, audio only"

    goto :goto_5

    :cond_5
    const-string v2, ""

    :goto_5
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget v2, Lcom/riola/player/Ui;->DIM:I

    .line 192
    const/high16 v4, 0x41300000    # 11.0f

    invoke-static {v6, v1, v4, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 194
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 196
    new-instance v12, Lcom/riola/player/TrackPicker$8;

    move-object v0, v12

    move/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object v4, v9

    move-object/from16 v5, p7

    move-object/from16 v6, p1

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/TrackPicker$8;-><init>(Z[ZLjava/util/Set;Ljava/lang/String;Ljava/lang/Runnable;Lcom/riola/player/Track;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;)V

    invoke-virtual {v11, v12}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 209
    new-instance v6, Lcom/riola/player/TrackPicker$9;

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/TrackPicker$9;-><init>(Z[ZLjava/util/Set;Ljava/lang/String;Ljava/lang/Runnable;)V

    invoke-virtual {v11, v6}, Landroid/widget/LinearLayout;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 219
    return-object v11
.end method

.method public static show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V
    .locals 23

    .line 37
    move-object/from16 v12, p0

    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    const/4 v13, 0x0

    if-eqz v0, :cond_0

    .line 38
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "No tracks yet"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 39
    const-string v1, "Add some audio first and it will show up here."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 40
    const-string v1, "Not now"

    invoke-virtual {v0, v1, v13}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/TrackPicker$1;

    invoke-direct {v1, v12}, Lcom/riola/player/TrackPicker$1;-><init>(Landroid/app/Activity;)V

    .line 41
    const-string v2, "Add tracks"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 45
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 46
    return-void

    .line 49
    :cond_0
    new-instance v6, Lcom/riola/player/Prefs;

    invoke-direct {v6, v12}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    .line 50
    const-string v0, ""

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v14

    .line 51
    const/4 v1, 0x1

    new-array v7, v1, [Z

    const/4 v15, 0x0

    aput-boolean v15, v7, v15

    .line 52
    new-instance v11, Ljava/util/LinkedHashSet;

    invoke-direct {v11}, Ljava/util/LinkedHashSet;-><init>()V

    .line 53
    new-array v10, v1, [Landroid/app/AlertDialog;

    .line 55
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 56
    const/high16 v2, 0x41600000    # 14.0f

    invoke-static {v12, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 57
    const/high16 v3, 0x40c00000    # 6.0f

    invoke-static {v12, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v9, v2, v3, v2, v15}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 60
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 61
    new-instance v5, Landroid/widget/EditText;

    invoke-direct {v5, v12}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 62
    const-string v2, "Search"

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 63
    invoke-virtual {v5, v1}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 64
    const/high16 v2, 0x41500000    # 13.0f

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setTextSize(F)V

    .line 65
    sget v2, Lcom/riola/player/Ui;->TXT:I

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setTextColor(I)V

    .line 66
    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 67
    sget v2, Lcom/riola/player/Ui;->FIELD:I

    sget v3, Lcom/riola/player/Ui;->LINE:I

    sget v4, Lcom/riola/player/Ui;->RAD_BTN:F

    sget v13, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {v12, v2, v3, v4, v13}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 68
    const/high16 v2, 0x41200000    # 10.0f

    invoke-static {v12, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 69
    invoke-virtual {v5, v2, v2, v2, v2}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 70
    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v13, -0x2

    invoke-static {v15, v13, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 71
    invoke-virtual {v8, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 73
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v4

    .line 74
    const/high16 v2, 0x41380000    # 11.5f

    sget v3, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v12, v0, v2, v3, v15}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    .line 76
    new-array v2, v1, [Ljava/lang/Runnable;

    .line 78
    const/16 v1, 0x15

    sget v16, Lcom/riola/player/Ui;->DIM:I

    const/16 v17, 0x10

    const-string v18, "Sort"

    new-instance v0, Lcom/riola/player/TrackPicker$2;

    invoke-direct {v0, v12, v6, v2}, Lcom/riola/player/TrackPicker$2;-><init>(Landroid/app/Activity;Lcom/riola/player/Prefs;[Ljava/lang/Runnable;)V

    move-object/from16 v19, v0

    move-object/from16 v0, p0

    move-object/from16 v20, v2

    move/from16 v2, v16

    move-object/from16 v16, v3

    move/from16 v3, v17

    move-object v15, v4

    move-object/from16 v4, v18

    move-object/from16 v21, v5

    move-object/from16 v5, v19

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 88
    invoke-virtual {v9, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 90
    const/high16 v2, 0x40000000    # 2.0f

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/high16 v5, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 91
    move-object/from16 v5, v16

    invoke-virtual {v9, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 93
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, v12}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 94
    invoke-virtual/range {p0 .. p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v1, v1

    const v2, 0x3f051eb8    # 0.52f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    .line 95
    const/4 v2, -0x1

    invoke-static {v2, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 96
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v1, v2, v13}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v15, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 97
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 98
    const/high16 v0, 0x41000000    # 8.0f

    invoke-static {v12, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    new-instance v13, Lcom/riola/player/TrackPicker$3;

    move-object v0, v13

    move-object v1, v15

    move-object v2, v6

    move-object v3, v14

    move-object v4, v7

    move-object v6, v11

    move/from16 v7, p2

    move-object/from16 v8, p0

    move-object v15, v9

    move-object v9, v10

    move-object/from16 v16, v10

    move-object/from16 v10, p3

    move-object/from16 v22, v11

    move-object/from16 v11, v20

    invoke-direct/range {v0 .. v11}, Lcom/riola/player/TrackPicker$3;-><init>(Landroid/widget/LinearLayout;Lcom/riola/player/Prefs;[Ljava/lang/String;[ZLandroid/widget/TextView;Ljava/util/Set;ZLandroid/app/Activity;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;[Ljava/lang/Runnable;)V

    move-object/from16 v0, v20

    const/4 v1, 0x0

    aput-object v13, v0, v1

    .line 126
    new-instance v2, Lcom/riola/player/TrackPicker$4;

    invoke-direct {v2, v14, v0}, Lcom/riola/player/TrackPicker$4;-><init>([Ljava/lang/String;[Ljava/lang/Runnable;)V

    move-object/from16 v3, v21

    invoke-virtual {v3, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 134
    aget-object v0, v0, v1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 136
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v15}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 137
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/TrackPicker$5;

    invoke-direct {v1, v12}, Lcom/riola/player/TrackPicker$5;-><init>(Landroid/app/Activity;)V

    .line 138
    const-string v2, "Manage tracks"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 143
    if-eqz p2, :cond_1

    .line 144
    new-instance v1, Lcom/riola/player/TrackPicker$6;

    move-object/from16 v2, p3

    move-object/from16 v3, v22

    invoke-direct {v1, v3, v12, v2}, Lcom/riola/player/TrackPicker$6;-><init>(Ljava/util/Set;Landroid/app/Activity;Lcom/riola/player/TrackPicker$OnPicked;)V

    const-string v2, "Add selected"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 156
    :cond_1
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    const/4 v1, 0x0

    aput-object v0, v16, v1

    .line 157
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 158
    return-void
.end method
