.class public Lcom/riola/player/NowPlayingActivity;
.super Landroid/app/Activity;
.source "NowPlayingActivity.java"

# interfaces
.implements Lcom/riola/player/Engine$Listener;


# instance fields
.field private badge:Landroid/widget/TextView;

.field private clock:Landroid/widget/TextView;

.field private dimmed:Z

.field private dragging:Z

.field private eng:Lcom/riola/player/Engine;

.field private play:Landroid/widget/ImageView;

.field private prefs:Lcom/riola/player/Prefs;

.field private programName:Landroid/widget/TextView;

.field private remain:Landroid/widget/TextView;

.field private root:Landroid/widget/LinearLayout;

.field private seek:Landroid/widget/SeekBar;

.field private shuffle:Landroid/widget/ImageView;

.field private stepDetail:Landroid/widget/TextView;

.field private stepTitle:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/NowPlayingActivity;)Lcom/riola/player/Engine;
    .locals 0

    .line 18
    iget-object p0, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    return-object p0
.end method

.method static synthetic access$100(Lcom/riola/player/NowPlayingActivity;)Z
    .locals 0

    .line 18
    iget-boolean p0, p0, Lcom/riola/player/NowPlayingActivity;->dimmed:Z

    return p0
.end method

.method static synthetic access$200(Lcom/riola/player/NowPlayingActivity;Z)V
    .locals 0

    .line 18
    invoke-direct {p0, p1}, Lcom/riola/player/NowPlayingActivity;->setDim(Z)V

    return-void
.end method

.method static synthetic access$302(Lcom/riola/player/NowPlayingActivity;Z)Z
    .locals 0

    .line 18
    iput-boolean p1, p0, Lcom/riola/player/NowPlayingActivity;->dragging:Z

    return p1
.end method

.method private build()Landroid/view/View;
    .locals 14

    .line 48
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    .line 49
    sget v1, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 50
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    const/4 v6, 0x1

    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->setFitsSystemWindows(Z)V

    .line 52
    const/16 v1, 0x24

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0x14

    const-string v4, "Shuffle"

    new-instance v5, Lcom/riola/player/NowPlayingActivity$1;

    invoke-direct {v5, p0}, Lcom/riola/player/NowPlayingActivity$1;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->shuffle:Landroid/widget/ImageView;

    .line 55
    const/4 v1, 0x2

    new-array v7, v1, [Landroid/view/View;

    const/4 v8, 0x0

    aput-object v0, v7, v8

    const/16 v1, 0x21

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const-string v4, "Dim the screen"

    new-instance v5, Lcom/riola/player/NowPlayingActivity$2;

    invoke-direct {v5, p0}, Lcom/riola/player/NowPlayingActivity$2;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    .line 57
    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    aput-object v0, v7, v6

    .line 61
    const/4 v1, 0x0

    const-string v2, "Now playing"

    const-string v3, ""

    const/4 v4, 0x1

    move-object v0, p0

    move-object v5, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->appBar(Landroid/app/Activity;ILjava/lang/String;Ljava/lang/String;Z[Landroid/view/View;)Lcom/riola/player/Ui$Bar;

    move-result-object v0

    .line 62
    iget-object v1, v0, Lcom/riola/player/Ui$Bar;->sub:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/riola/player/NowPlayingActivity;->programName:Landroid/widget/TextView;

    .line 63
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    iget-object v0, v0, Lcom/riola/player/Ui$Bar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 65
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 66
    const/high16 v0, 0x3f800000    # 1.0f

    const/4 v9, -0x1

    invoke-static {v9, v8, v0}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 67
    const/16 v10, 0x11

    invoke-virtual {v7, v10}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 68
    const/high16 v0, 0x41d00000    # 26.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 69
    invoke-virtual {v7, v0, v0, v0, v0}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 71
    sget v0, Lcom/riola/player/Ui;->ONACC:I

    sget v1, Lcom/riola/player/Ui;->ACC:I

    const-string v11, ""

    invoke-static {p0, v11, v0, v1}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->badge:Landroid/widget/TextView;

    .line 72
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 73
    invoke-virtual {v0, v10}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 74
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->badge:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 75
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 77
    const/high16 v0, 0x41c00000    # 24.0f

    sget v1, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, v11, v0, v1, v6}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    .line 78
    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 79
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    const/4 v12, -0x2

    invoke-static {v9, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 80
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    const/4 v13, 0x3

    invoke-virtual {v0, v13}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 81
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    const/4 v2, 0x0

    const/high16 v3, 0x41900000    # 18.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 82
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 84
    const/high16 v0, 0x41600000    # 14.0f

    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v11, v0, v1, v8}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepDetail:Landroid/widget/TextView;

    .line 85
    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 86
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepDetail:Landroid/widget/TextView;

    invoke-static {v9, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 87
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->stepDetail:Landroid/widget/TextView;

    const/high16 v3, 0x41000000    # 8.0f

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 88
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepDetail:Landroid/widget/TextView;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 90
    const/high16 v0, 0x42200000    # 40.0f

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    const-string v2, "0:00"

    invoke-static {p0, v2, v0, v1}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->clock:Landroid/widget/TextView;

    .line 91
    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 92
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->clock:Landroid/widget/TextView;

    invoke-static {v9, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 93
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->clock:Landroid/widget/TextView;

    const/4 v2, 0x0

    const/high16 v3, 0x41d00000    # 26.0f

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 94
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->clock:Landroid/widget/TextView;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 96
    const/high16 v0, 0x41500000    # 13.0f

    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v11, v0, v1, v8}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->remain:Landroid/widget/TextView;

    .line 97
    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 98
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->remain:Landroid/widget/TextView;

    invoke-static {v9, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 99
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->remain:Landroid/widget/TextView;

    const/high16 v3, 0x40c00000    # 6.0f

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 100
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->remain:Landroid/widget/TextView;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 102
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    .line 103
    invoke-static {v9, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 104
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    sget v1, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 105
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    sget v1, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 106
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    sget v1, Lcom/riola/player/Ui;->LINE:I

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgressBackgroundTintList(Landroid/content/res/ColorStateList;)V

    .line 107
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    new-instance v1, Lcom/riola/player/NowPlayingActivity$3;

    invoke-direct {v1, p0}, Lcom/riola/player/NowPlayingActivity$3;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 112
    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    const/high16 v3, 0x41a00000    # 20.0f

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 113
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 117
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 118
    invoke-virtual {v7, v10}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 119
    const/4 v3, 0x0

    const/high16 v5, 0x41f00000    # 30.0f

    move-object v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 120
    const/4 v1, 0x5

    const/16 v2, 0x1a

    const/4 v3, 0x0

    const-string v4, "Previous step"

    new-instance v5, Lcom/riola/player/NowPlayingActivity$4;

    invoke-direct {v5, p0}, Lcom/riola/player/NowPlayingActivity$4;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    const/high16 v8, 0x41800000    # 16.0f

    invoke-static {p0, v8}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 124
    const/4 v1, 0x2

    const/16 v2, 0x28

    const/4 v3, 0x1

    const-string v4, "Pause"

    new-instance v5, Lcom/riola/player/NowPlayingActivity$5;

    invoke-direct {v5, p0}, Lcom/riola/player/NowPlayingActivity$5;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->play:Landroid/widget/ImageView;

    .line 127
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 128
    invoke-static {p0, v8}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 129
    const/4 v1, 0x4

    const/16 v2, 0x1a

    const/4 v3, 0x0

    const-string v4, "Next step"

    new-instance v5, Lcom/riola/player/NowPlayingActivity$6;

    invoke-direct {v5, p0}, Lcom/riola/player/NowPlayingActivity$6;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 132
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 134
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 135
    invoke-virtual {v7, v10}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 136
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x41c00000    # 24.0f

    move-object v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 137
    new-instance v0, Lcom/riola/player/NowPlayingActivity$7;

    invoke-direct {v0, p0}, Lcom/riola/player/NowPlayingActivity$7;-><init>(Lcom/riola/player/NowPlayingActivity;)V

    const-string v1, "Stop the program"

    invoke-static {p0, v1, v13, v6, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 146
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 147
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 148
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->root:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private render(Lcom/riola/player/Engine$St;)V
    .locals 8

    .line 170
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->running:Z

    if-nez v0, :cond_0

    .line 171
    invoke-virtual {p0}, Lcom/riola/player/NowPlayingActivity;->finish()V

    .line 172
    return-void

    .line 174
    :cond_0
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->programName:Landroid/widget/TextView;

    iget-object v1, p1, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 175
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepTitle:Landroid/widget/TextView;

    iget-object v1, p1, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 176
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->stepDetail:Landroid/widget/TextView;

    iget-boolean v1, p1, Lcom/riola/player/Engine$St;->resting:Z

    if-eqz v1, :cond_1

    iget-object v1, p1, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "resting"

    goto :goto_0

    :cond_1
    iget-object v1, p1, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 178
    iget v0, p1, Lcom/riola/player/Engine$St;->countIn:I

    const/4 v1, 0x1

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->badge:Landroid/widget/TextView;

    const-string v2, "READY"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 179
    :cond_2
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->preview:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->badge:Landroid/widget/TextView;

    const-string v2, "PREVIEW"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 180
    :cond_3
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->badge:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "STEP "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Lcom/riola/player/Engine$St;->step:I

    add-int/2addr v3, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " OF "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Lcom/riola/player/Engine$St;->steps:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 182
    :goto_1
    iget v0, p1, Lcom/riola/player/Engine$St;->durMs:I

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 183
    iget-boolean v2, p0, Lcom/riola/player/NowPlayingActivity;->dragging:Z

    if-nez v2, :cond_4

    .line 184
    iget-object v2, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    invoke-virtual {v2, v0}, Landroid/widget/SeekBar;->setMax(I)V

    .line 185
    iget-object v2, p0, Lcom/riola/player/NowPlayingActivity;->seek:Landroid/widget/SeekBar;

    iget v3, p1, Lcom/riola/player/Engine$St;->posMs:I

    invoke-static {v3, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-virtual {v2, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 187
    :cond_4
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->clock:Landroid/widget/TextView;

    iget v2, p1, Lcom/riola/player/Engine$St;->posMs:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 189
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 190
    iget v2, p1, Lcom/riola/player/Engine$St;->durMs:I

    if-lez v2, :cond_5

    const-string v2, "of "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Lcom/riola/player/Engine$St;->durMs:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 191
    :cond_5
    iget-wide v2, p1, Lcom/riola/player/Engine$St;->stepRemainMs:J

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    const-string v3, "   .   "

    if-ltz v2, :cond_7

    .line 192
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_6

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 193
    :cond_6
    iget-wide v6, p1, Lcom/riola/player/Engine$St;->stepRemainMs:J

    invoke-static {v6, v7}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, " left in this step"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 194
    :cond_7
    iget v2, p1, Lcom/riola/player/Engine$St;->repTotal:I

    if-le v2, v1, :cond_9

    .line 195
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_8

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 196
    :cond_8
    const-string v2, "pass "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v6, p1, Lcom/riola/player/Engine$St;->repDone:I

    add-int/2addr v6, v1

    iget v7, p1, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, " of "

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v6, p1, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 198
    :cond_9
    :goto_2
    iget-wide v6, p1, Lcom/riola/player/Engine$St;->progRemainMs:J

    cmp-long v2, v6, v4

    if-lez v2, :cond_b

    .line 199
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_a

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    :cond_a
    const-string v2, "~"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p1, Lcom/riola/player/Engine$St;->progRemainMs:J

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " to go"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 202
    :cond_b
    iget-object v2, p0, Lcom/riola/player/NowPlayingActivity;->remain:Landroid/widget/TextView;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 204
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->play:Landroid/widget/ImageView;

    iget-boolean v2, p1, Lcom/riola/player/Engine$St;->paused:Z

    if-eqz v2, :cond_c

    goto :goto_3

    :cond_c
    const/4 v1, 0x2

    :goto_3
    sget v2, Lcom/riola/player/Ui;->ONACC:I

    invoke-static {v0, v1, v2}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 205
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->play:Landroid/widget/ImageView;

    iget-boolean v1, p1, Lcom/riola/player/Engine$St;->paused:Z

    if-eqz v1, :cond_d

    const-string v1, "Resume"

    goto :goto_4

    :cond_d
    const-string v1, "Pause"

    :goto_4
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 206
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->shuffle:Landroid/widget/ImageView;

    if-eqz v0, :cond_f

    iget-boolean p1, p1, Lcom/riola/player/Engine$St;->shuffled:Z

    if-eqz p1, :cond_e

    sget p1, Lcom/riola/player/Ui;->ACC_TXT:I

    goto :goto_5

    :cond_e
    sget p1, Lcom/riola/player/Ui;->DIM:I

    :goto_5
    const/16 v1, 0x24

    invoke-static {v0, v1, p1}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 207
    :cond_f
    return-void
.end method

.method private setDim(Z)V
    .locals 2

    .line 153
    iput-boolean p1, p0, Lcom/riola/player/NowPlayingActivity;->dimmed:Z

    .line 154
    invoke-virtual {p0}, Lcom/riola/player/NowPlayingActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 155
    if-eqz p1, :cond_0

    const v1, 0x3ca3d70a    # 0.02f

    goto :goto_0

    :cond_0
    const/high16 v1, -0x40800000    # -1.0f

    :goto_0
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->screenBrightness:F

    .line 156
    invoke-virtual {p0}, Lcom/riola/player/NowPlayingActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 157
    if-eqz p1, :cond_1

    const-string p1, "Screen dimmed - tap anywhere to bring it back"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 158
    :cond_1
    return-void
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 162
    iget-boolean v0, p0, Lcom/riola/player/NowPlayingActivity;->dimmed:Z

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_0

    .line 163
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/riola/player/NowPlayingActivity;->setDim(Z)V

    .line 164
    const/4 p1, 0x1

    return p1

    .line 166
    :cond_0
    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 32
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/NowPlayingActivity;->prefs:Lcom/riola/player/Prefs;

    .line 33
    invoke-static {v0}, Lcom/riola/player/Ui;->theme(Lcom/riola/player/Prefs;)V

    .line 34
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->dark()Z

    move-result v0

    invoke-static {v0}, Lcom/riola/player/Ui;->themeRes(Z)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/riola/player/NowPlayingActivity;->setTheme(I)V

    .line 35
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 36
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    .line 37
    invoke-static {p0}, Lcom/riola/player/Store;->load(Landroid/content/Context;)V

    .line 38
    invoke-direct {p0}, Lcom/riola/player/NowPlayingActivity;->build()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/NowPlayingActivity;->setContentView(Landroid/view/View;)V

    .line 39
    invoke-static {p0}, Lcom/riola/player/Ui;->applyWindow(Landroid/app/Activity;)V

    .line 40
    invoke-virtual {p0}, Lcom/riola/player/NowPlayingActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/16 v0, 0x80

    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    .line 41
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    iget-object p1, p1, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-direct {p0, p1}, Lcom/riola/player/NowPlayingActivity;->render(Lcom/riola/player/Engine$St;)V

    .line 42
    return-void
.end method

.method public onFinished(Z)V
    .locals 0

    .line 212
    invoke-virtual {p0}, Lcom/riola/player/NowPlayingActivity;->finish()V

    return-void
.end method

.method public onLog(Ljava/lang/String;)V
    .locals 0

    .line 211
    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->removeListener(Lcom/riola/player/Engine$Listener;)V

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 44
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->addListener(Lcom/riola/player/Engine$Listener;)V

    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-direct {p0, v0}, Lcom/riola/player/NowPlayingActivity;->render(Lcom/riola/player/Engine$St;)V

    return-void
.end method

.method public onState(Lcom/riola/player/Engine$St;)V
    .locals 0

    .line 210
    invoke-direct {p0, p1}, Lcom/riola/player/NowPlayingActivity;->render(Lcom/riola/player/Engine$St;)V

    return-void
.end method
