.class public Lcom/riola/player/PlayerBar;
.super Ljava/lang/Object;
.source "PlayerBar.java"

# interfaces
.implements Lcom/riola/player/Engine$Listener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/PlayerBar$Host;
    }
.end annotation


# instance fields
.field private final act:Landroid/app/Activity;

.field private final badge:Landroid/widget/TextView;

.field private final detail:Landroid/widget/TextView;

.field private dragging:Z

.field private final eng:Lcom/riola/player/Engine;

.field private final host:Lcom/riola/player/PlayerBar$Host;

.field private final play:Landroid/widget/ImageView;

.field private final remain:Landroid/widget/TextView;

.field private final seek:Landroid/widget/SeekBar;

.field private shuffle:Landroid/widget/ImageView;

.field private final time:Landroid/widget/TextView;

.field private final title:Landroid/widget/TextView;

.field public final view:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V
    .locals 11

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/riola/player/PlayerBar;->act:Landroid/app/Activity;

    .line 34
    iput-object p2, p0, Lcom/riola/player/PlayerBar;->host:Lcom/riola/player/PlayerBar$Host;

    .line 35
    invoke-static {p1}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    .line 37
    invoke-static {p1}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    .line 38
    sget v1, Lcom/riola/player/Ui;->SURF:I

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 39
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 42
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 43
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setFocusable(Z)V

    .line 45
    new-instance v2, Landroid/view/View;

    invoke-direct {v2, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 46
    const v3, 0x3f333333    # 0.7f

    invoke-static {p1, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    const/4 v4, -0x1

    invoke-static {v4, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 47
    sget v3, Lcom/riola/player/Ui;->LINE:I

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackgroundColor(I)V

    .line 48
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 50
    invoke-static {p1}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 51
    const/high16 v2, 0x41600000    # 14.0f

    invoke-static {p1, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    const/high16 v7, 0x41200000    # 10.0f

    invoke-static {p1, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {p1, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v8, 0x41400000    # 12.0f

    invoke-static {p1, v8}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v9

    invoke-virtual {v6, v3, v5, v2, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 52
    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 54
    invoke-static {p1}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 56
    const/4 v9, 0x0

    invoke-static {p1, v9, v7}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-static {v2}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 57
    new-instance v2, Lcom/riola/player/PlayerBar$1;

    invoke-direct {v2, p0, p1}, Lcom/riola/player/PlayerBar$1;-><init>(Lcom/riola/player/PlayerBar;Landroid/app/Activity;)V

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 63
    const/high16 v2, 0x41680000    # 14.5f

    sget v3, Lcom/riola/player/Ui;->TXT:I

    const-string v10, ""

    invoke-static {p1, v10, v2, v3, v1}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/PlayerBar;->title:Landroid/widget/TextView;

    .line 64
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 65
    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, -0x2

    invoke-static {v9, v3, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 66
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 67
    sget v1, Lcom/riola/player/Ui;->ONACC:I

    sget v2, Lcom/riola/player/Ui;->ACC:I

    invoke-static {p1, v10, v1, v2}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/PlayerBar;->badge:Landroid/widget/TextView;

    .line 68
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 69
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 71
    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p1, v10, v8, v1, v9}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/PlayerBar;->detail:Landroid/widget/TextView;

    .line 72
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 73
    invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 74
    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/16 v2, 0xe

    const/16 v5, 0x12

    invoke-static {p1, v5, v1, v2}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 76
    new-instance v8, Landroid/widget/SeekBar;

    invoke-direct {v8, p1}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v8, p0, Lcom/riola/player/PlayerBar;->seek:Landroid/widget/SeekBar;

    .line 77
    invoke-static {v4, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 78
    sget v0, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v0}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 79
    sget v0, Lcom/riola/player/Ui;->ACC:I

    invoke-static {v0}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 80
    sget v0, Lcom/riola/player/Ui;->LINE:I

    invoke-static {v0}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/SeekBar;->setProgressBackgroundTintList(Landroid/content/res/ColorStateList;)V

    .line 81
    new-instance v0, Lcom/riola/player/PlayerBar$2;

    invoke-direct {v0, p0}, Lcom/riola/player/PlayerBar$2;-><init>(Lcom/riola/player/PlayerBar;)V

    invoke-virtual {v8, v0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 86
    const/4 v2, 0x0

    const/high16 v3, 0x40000000    # 2.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p1

    move-object v1, v8

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 87
    invoke-virtual {v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 89
    invoke-static {p1}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 90
    sget v1, Lcom/riola/player/Ui;->DIM:I

    const-string v2, "0:00 / 0:00"

    const/high16 v3, 0x41300000    # 11.0f

    invoke-static {p1, v2, v3, v1}, Lcom/riola/player/Ui;->mono(Landroid/content/Context;Ljava/lang/String;FI)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/PlayerBar;->time:Landroid/widget/TextView;

    .line 91
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 92
    invoke-static {p1}, Lcom/riola/player/Ui;->spring(Landroid/content/Context;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 93
    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p1, v10, v3, v1, v9}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/PlayerBar;->remain:Landroid/widget/TextView;

    .line 94
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 95
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 97
    invoke-static {p1}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 98
    const/16 v0, 0x11

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 99
    const/4 v2, 0x0

    const/high16 v3, 0x40c00000    # 6.0f

    move-object v0, p1

    move-object v1, v8

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 100
    const/16 v1, 0x24

    const/16 v2, 0x12

    const/4 v3, 0x0

    const-string v4, "Shuffle"

    new-instance v5, Lcom/riola/player/PlayerBar$3;

    invoke-direct {v5, p0, p1}, Lcom/riola/player/PlayerBar$3;-><init>(Lcom/riola/player/PlayerBar;Landroid/app/Activity;)V

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerBar;->shuffle:Landroid/widget/ImageView;

    .line 103
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 104
    invoke-static {p1, v7}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 105
    const/4 v1, 0x5

    const/16 v2, 0x14

    const-string v4, "Previous step"

    new-instance v5, Lcom/riola/player/PlayerBar$4;

    invoke-direct {v5, p0}, Lcom/riola/player/PlayerBar$4;-><init>(Lcom/riola/player/PlayerBar;)V

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 108
    invoke-static {p1, v7}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 109
    const/4 v1, 0x2

    const/16 v2, 0x16

    const/4 v3, 0x1

    const-string v4, "Pause"

    new-instance v5, Lcom/riola/player/PlayerBar$5;

    invoke-direct {v5, p0}, Lcom/riola/player/PlayerBar$5;-><init>(Lcom/riola/player/PlayerBar;)V

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerBar;->play:Landroid/widget/ImageView;

    .line 112
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 113
    invoke-static {p1, v7}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    const/4 v1, 0x3

    const/16 v2, 0x14

    const/4 v3, 0x0

    const-string v4, "Stop"

    new-instance v5, Lcom/riola/player/PlayerBar$6;

    invoke-direct {v5, p0}, Lcom/riola/player/PlayerBar$6;-><init>(Lcom/riola/player/PlayerBar;)V

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 117
    invoke-static {p1, v7}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    const/4 v1, 0x4

    const-string v4, "Next step"

    new-instance v5, Lcom/riola/player/PlayerBar$7;

    invoke-direct {v5, p0}, Lcom/riola/player/PlayerBar$7;-><init>(Lcom/riola/player/PlayerBar;)V

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 121
    invoke-virtual {v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 122
    return-void
.end method

.method static synthetic access$002(Lcom/riola/player/PlayerBar;Z)Z
    .locals 0

    .line 14
    iput-boolean p1, p0, Lcom/riola/player/PlayerBar;->dragging:Z

    return p1
.end method

.method static synthetic access$100(Lcom/riola/player/PlayerBar;)Lcom/riola/player/Engine;
    .locals 0

    .line 14
    iget-object p0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    return-object p0
.end method

.method private append(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 181
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  .  "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :goto_0
    return-object p2
.end method

.method static askShuffle(Landroid/app/Activity;Lcom/riola/player/Engine;)V
    .locals 3

    .line 189
    invoke-virtual {p1}, Lcom/riola/player/Engine;->isShuffled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 190
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->setShuffle(Z)V

    .line 191
    const-string p1, "Back to the order you built"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 192
    return-void

    .line 194
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Shuffle the steps?"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 195
    const-string v1, "The steps will play in a random order instead of the order you built, and a new order is drawn each time the program repeats.\n\nYour program is not changed, and you can switch back at any time."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 198
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/PlayerBar$8;

    invoke-direct {v1, p1, p0}, Lcom/riola/player/PlayerBar$8;-><init>(Lcom/riola/player/Engine;Landroid/app/Activity;)V

    .line 199
    const-string p0, "Shuffle"

    invoke-virtual {v0, p0, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 204
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 205
    return-void
.end method

.method public static startService(Landroid/app/Activity;)V
    .locals 2

    .line 139
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/riola/player/PlayerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "riola.attach"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 140
    :try_start_0
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 142
    goto :goto_0

    .line 140
    :catch_0
    move-exception v1

    .line 141
    :try_start_1
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception p0

    .line 143
    :goto_0
    return-void
.end method


# virtual methods
.method public attach()V
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->addListener(Lcom/riola/player/Engine$Listener;)V

    .line 126
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 127
    return-void
.end method

.method public detach()V
    .locals 1

    .line 129
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->removeListener(Lcom/riola/player/Engine$Listener;)V

    return-void
.end method

.method public onFinished(Z)V
    .locals 1

    .line 216
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 217
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->host:Lcom/riola/player/PlayerBar$Host;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/riola/player/PlayerBar$Host;->onEngineFinished(Z)V

    .line 218
    :cond_0
    return-void
.end method

.method public onLog(Ljava/lang/String;)V
    .locals 0

    .line 213
    return-void
.end method

.method public onState(Lcom/riola/player/Engine$St;)V
    .locals 1

    .line 209
    invoke-virtual {p0, p1}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 210
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->host:Lcom/riola/player/PlayerBar$Host;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/riola/player/PlayerBar$Host;->onEngineState(Lcom/riola/player/Engine$St;)V

    .line 211
    :cond_0
    return-void
.end method

.method public render(Lcom/riola/player/Engine$St;)V
    .locals 7

    .line 146
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->running:Z

    if-nez v0, :cond_0

    .line 147
    iget-object p1, p0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 148
    return-void

    .line 150
    :cond_0
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 151
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->title:Landroid/widget/TextView;

    iget-object v1, p1, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 152
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->detail:Landroid/widget/TextView;

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

    .line 154
    iget v0, p1, Lcom/riola/player/Engine$St;->countIn:I

    const-string v1, "/"

    const/4 v2, 0x1

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/riola/player/PlayerBar;->badge:Landroid/widget/TextView;

    const-string v3, "READY"

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 155
    :cond_2
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->preview:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/riola/player/PlayerBar;->badge:Landroid/widget/TextView;

    const-string v3, "PREVIEW"

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 156
    :cond_3
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->badge:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "STEP "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Lcom/riola/player/Engine$St;->step:I

    add-int/2addr v4, v2

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Lcom/riola/player/Engine$St;->steps:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 158
    :goto_1
    iget v0, p1, Lcom/riola/player/Engine$St;->durMs:I

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 159
    iget-boolean v3, p0, Lcom/riola/player/PlayerBar;->dragging:Z

    if-nez v3, :cond_4

    .line 160
    iget-object v3, p0, Lcom/riola/player/PlayerBar;->seek:Landroid/widget/SeekBar;

    invoke-virtual {v3, v0}, Landroid/widget/SeekBar;->setMax(I)V

    .line 161
    iget-object v3, p0, Lcom/riola/player/PlayerBar;->seek:Landroid/widget/SeekBar;

    iget v4, p1, Lcom/riola/player/Engine$St;->posMs:I

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-virtual {v3, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 163
    :cond_4
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->time:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p1, Lcom/riola/player/Engine$St;->posMs:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " / "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Lcom/riola/player/Engine$St;->durMs:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 165
    nop

    .line 166
    iget-wide v3, p1, Lcom/riola/player/Engine$St;->stepRemainMs:J

    const-wide/16 v5, 0x0

    cmp-long v0, v3, v5

    if-ltz v0, :cond_5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v3, p1, Lcom/riola/player/Engine$St;->stepRemainMs:J

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " left"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 167
    :cond_5
    iget v0, p1, Lcom/riola/player/Engine$St;->repTotal:I

    if-le v0, v2, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "pass "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v3, p1, Lcom/riola/player/Engine$St;->repDone:I

    add-int/2addr v3, v2

    iget v4, p1, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " of "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v3, p1, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_6
    const-string v0, ""

    .line 168
    :goto_2
    iget v3, p1, Lcom/riola/player/Engine$St;->loopTotal:I

    const-string v4, "loop "

    if-gez v3, :cond_7

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v3, p1, Lcom/riola/player/Engine$St;->loopDone:I

    add-int/2addr v3, v2

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/riola/player/PlayerBar;->append(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 169
    :cond_7
    iget v3, p1, Lcom/riola/player/Engine$St;->loopTotal:I

    if-le v3, v2, :cond_8

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Lcom/riola/player/Engine$St;->loopDone:I

    add-int/2addr v4, v2

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v3, p1, Lcom/riola/player/Engine$St;->loopTotal:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/riola/player/PlayerBar;->append(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 170
    :cond_8
    :goto_3
    iget-wide v3, p1, Lcom/riola/player/Engine$St;->progRemainMs:J

    cmp-long v1, v3, v5

    if-lez v1, :cond_9

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "~"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v3, p1, Lcom/riola/player/Engine$St;->progRemainMs:J

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " to go"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/riola/player/PlayerBar;->append(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 171
    :cond_9
    iget-object v1, p0, Lcom/riola/player/PlayerBar;->remain:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 173
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->play:Landroid/widget/ImageView;

    iget-boolean v1, p1, Lcom/riola/player/Engine$St;->paused:Z

    if-eqz v1, :cond_a

    goto :goto_4

    :cond_a
    const/4 v2, 0x2

    :goto_4
    sget v1, Lcom/riola/player/Ui;->ONACC:I

    invoke-static {v0, v2, v1}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 174
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->play:Landroid/widget/ImageView;

    iget-boolean v1, p1, Lcom/riola/player/Engine$St;->paused:Z

    if-eqz v1, :cond_b

    const-string v1, "Resume"

    goto :goto_5

    :cond_b
    const-string v1, "Pause"

    :goto_5
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 175
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->shuffle:Landroid/widget/ImageView;

    if-eqz v0, :cond_e

    .line 176
    iget-boolean v1, p1, Lcom/riola/player/Engine$St;->shuffled:Z

    if-eqz v1, :cond_c

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    goto :goto_6

    :cond_c
    sget v1, Lcom/riola/player/Ui;->TXT:I

    :goto_6
    const/16 v2, 0x24

    invoke-static {v0, v2, v1}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 177
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->shuffle:Landroid/widget/ImageView;

    iget-boolean p1, p1, Lcom/riola/player/Engine$St;->shuffled:Z

    if-eqz p1, :cond_d

    const-string p1, "Shuffling, tap to stop"

    goto :goto_7

    :cond_d
    const-string p1, "Shuffle"

    :goto_7
    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 179
    :cond_e
    return-void
.end method

.method public stop()V
    .locals 4

    .line 132
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0}, Lcom/riola/player/Engine;->stop()V

    .line 133
    :try_start_0
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->act:Landroid/app/Activity;

    new-instance v1, Landroid/content/Intent;

    iget-object v2, p0, Lcom/riola/player/PlayerBar;->act:Landroid/app/Activity;

    const-class v3, Lcom/riola/player/PlayerService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->stopService(Landroid/content/Intent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 134
    :goto_0
    iget-object v0, p0, Lcom/riola/player/PlayerBar;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 135
    return-void
.end method
