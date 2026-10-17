.class public Lcom/riola/player/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/PlayerBar$Host;


# static fields
.field private static final REQ_EXPORT:I = 0xc9

.field private static final REQ_IMPORT:I = 0xca

.field private static final REQ_NOTIF:I = 0x67

.field private static reopenSettings:Z


# instance fields
.field private bar:Lcom/riola/player/PlayerBar;

.field private emptyBox:Landroid/widget/LinearLayout;

.field private eng:Lcom/riola/player/Engine;

.field private liveCard:Landroid/widget/LinearLayout;

.field private liveProgramId:Ljava/lang/String;

.field private final liveRows:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private liveSteps:Landroid/widget/LinearLayout;

.field private liveTitle:Landroid/widget/TextView;

.field private prefs:Lcom/riola/player/Prefs;

.field private programsBox:Landroid/widget/LinearLayout;

.field private tracksLine:Landroid/widget/TextView;

.field private wasRunning:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 29
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/MainActivity;->liveProgramId:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->help()V

    return-void
.end method

.method static synthetic access$100(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->settings()V

    return-void
.end method

.method static synthetic access$1000(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->buildLive()V

    return-void
.end method

.method static synthetic access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    return-object p0
.end method

.method static synthetic access$1202(Z)Z
    .locals 0

    .line 19
    sput-boolean p0, Lcom/riola/player/MainActivity;->reopenSettings:Z

    return p0
.end method

.method static synthetic access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    return-object p0
.end method

.method static synthetic access$300(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->newProgram()V

    return-void
.end method

.method static synthetic access$400(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->refresh()V

    return-void
.end method

.method static synthetic access$500(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V
    .locals 0

    .line 19
    invoke-direct {p0, p1}, Lcom/riola/player/MainActivity;->open(Lcom/riola/player/Program;)V

    return-void
.end method

.method static synthetic access$600(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V
    .locals 0

    .line 19
    invoke-direct {p0, p1}, Lcom/riola/player/MainActivity;->menu(Lcom/riola/player/Program;)V

    return-void
.end method

.method static synthetic access$700(Lcom/riola/player/MainActivity;)Lcom/riola/player/PlayerBar;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/riola/player/MainActivity;->bar:Lcom/riola/player/PlayerBar;

    return-object p0
.end method

.method static synthetic access$800(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;I)V
    .locals 0

    .line 19
    invoke-direct {p0, p1, p2}, Lcom/riola/player/MainActivity;->run(Lcom/riola/player/Program;I)V

    return-void
.end method

.method static synthetic access$902(Lcom/riola/player/MainActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 19
    iput-object p1, p0, Lcom/riola/player/MainActivity;->liveProgramId:Ljava/lang/String;

    return-object p1
.end method

.method private build()Landroid/view/View;
    .locals 16

    .line 71
    move-object/from16 v6, p0

    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 72
    sget v0, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 73
    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->setFitsSystemWindows(Z)V

    .line 75
    const/4 v0, 0x2

    new-array v9, v0, [Landroid/view/View;

    const/16 v1, 0xb

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0x14

    const-string v4, "Help"

    new-instance v5, Lcom/riola/player/MainActivity$1;

    invoke-direct {v5, v6}, Lcom/riola/player/MainActivity$1;-><init>(Lcom/riola/player/MainActivity;)V

    .line 76
    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    const/4 v10, 0x0

    aput-object v0, v9, v10

    const/16 v1, 0xc

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const-string v4, "Settings"

    new-instance v5, Lcom/riola/player/MainActivity$2;

    invoke-direct {v5, v6}, Lcom/riola/player/MainActivity$2;-><init>(Lcom/riola/player/MainActivity;)V

    .line 79
    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    aput-object v0, v9, v8

    .line 83
    const/16 v1, 0xe

    const-string v2, "Riola"

    const-string v3, "programmable music player"

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object v5, v9

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->appBar(Landroid/app/Activity;ILjava/lang/String;Ljava/lang/String;Z[Landroid/view/View;)Lcom/riola/player/Ui$Bar;

    move-result-object v0

    iget-object v0, v0, Lcom/riola/player/Ui$Bar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 85
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 88
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 89
    const/high16 v1, 0x41600000    # 14.0f

    invoke-static {v6, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x40800000    # 4.0f

    invoke-static {v6, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    const/high16 v4, 0x41200000    # 10.0f

    invoke-static {v6, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {v6, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v0, v1, v3, v5, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 90
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 91
    const/high16 v2, 0x41400000    # 12.0f

    invoke-static {v6, v10, v2}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-static {v3}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 92
    invoke-static {v6, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {v6, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-virtual {v1, v10, v3, v10, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 93
    sget v3, Lcom/riola/player/Ui;->ACC_TXT:I

    const/16 v5, 0x12

    const/16 v11, 0xe

    invoke-static {v6, v11, v3, v5}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 94
    invoke-static {v6, v2}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 95
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 96
    const/4 v12, -0x2

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-static {v10, v12, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 97
    const/high16 v5, 0x41700000    # 15.0f

    sget v14, Lcom/riola/player/Ui;->TXT:I

    const-string v15, "Tracks"

    invoke-static {v6, v15, v5, v14, v8}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 98
    sget v5, Lcom/riola/player/Ui;->DIM:I

    const-string v8, ""

    invoke-static {v6, v8, v2, v5, v10}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, v6, Lcom/riola/player/MainActivity;->tracksLine:Landroid/widget/TextView;

    .line 99
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 101
    const/16 v2, 0x1b

    sget v3, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v6, v2, v3, v11}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 102
    new-instance v2, Lcom/riola/player/MainActivity$3;

    invoke-direct {v2, v6}, Lcom/riola/player/MainActivity$3;-><init>(Lcom/riola/player/MainActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 105
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 106
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 109
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, v6, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    .line 110
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 111
    const/16 v1, 0x16

    const-string v2, "Now playing"

    invoke-static {v6, v1, v2}, Lcom/riola/player/Ui;->heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 112
    invoke-static {v10, v12, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 113
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    sget v1, Lcom/riola/player/Ui;->ONACC:I

    sget v2, Lcom/riola/player/Ui;->ACC2:I

    invoke-static {v6, v8, v1, v2}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, v6, Lcom/riola/player/MainActivity;->liveTitle:Landroid/widget/TextView;

    .line 115
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 116
    invoke-static {v6, v10, v4}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-static {v1}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 117
    new-instance v1, Lcom/riola/player/MainActivity$4;

    invoke-direct {v1, v6}, Lcom/riola/player/MainActivity$4;-><init>(Lcom/riola/player/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 122
    iget-object v1, v6, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, v6, Lcom/riola/player/MainActivity;->liveSteps:Landroid/widget/LinearLayout;

    .line 124
    iget-object v1, v6, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 125
    iget-object v0, v6, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 126
    iget-object v0, v6, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 129
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 130
    const/16 v0, 0x20

    const-string v1, "Programs"

    invoke-static {v6, v0, v1}, Lcom/riola/player/Ui;->heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 131
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, v6, Lcom/riola/player/MainActivity;->programsBox:Landroid/widget/LinearLayout;

    .line 132
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 133
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, v6, Lcom/riola/player/MainActivity;->emptyBox:Landroid/widget/LinearLayout;

    .line 134
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 135
    new-instance v0, Lcom/riola/player/MainActivity$5;

    invoke-direct {v0, v6}, Lcom/riola/player/MainActivity$5;-><init>(Lcom/riola/player/MainActivity;)V

    const-string v1, "New program"

    const/4 v2, 0x6

    invoke-static {v6, v1, v2, v10, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 138
    const/4 v0, -0x1

    invoke-static {v0, v12}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 139
    const/4 v2, 0x0

    const/high16 v3, 0x41200000    # 10.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v11

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 140
    invoke-virtual {v8, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 142
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 143
    const/high16 v3, 0x40800000    # 4.0f

    move-object v1, v11

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 144
    new-instance v0, Lcom/riola/player/MainActivity$6;

    invoke-direct {v0, v6}, Lcom/riola/player/MainActivity$6;-><init>(Lcom/riola/player/MainActivity;)V

    const-string v1, "Export all"

    const/16 v2, 0x9

    const/4 v3, 0x3

    invoke-static {v6, v1, v2, v3, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 147
    invoke-static {v10, v12, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 148
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 149
    new-instance v0, Lcom/riola/player/MainActivity$7;

    invoke-direct {v0, v6}, Lcom/riola/player/MainActivity$7;-><init>(Lcom/riola/player/MainActivity;)V

    const-string v1, "Import"

    const/16 v2, 0xa

    invoke-static {v6, v1, v2, v3, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 152
    invoke-static {v10, v12, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 153
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 154
    invoke-virtual {v8, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 156
    invoke-virtual {v9, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 158
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 159
    invoke-static {v6, v9}, Lcom/riola/player/Ui;->scroller(Landroid/content/Context;Landroid/widget/LinearLayout;)Landroid/widget/ScrollView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 161
    new-instance v0, Lcom/riola/player/PlayerBar;

    invoke-direct {v0, v6, v6}, Lcom/riola/player/PlayerBar;-><init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V

    iput-object v0, v6, Lcom/riola/player/MainActivity;->bar:Lcom/riola/player/PlayerBar;

    .line 162
    iget-object v0, v0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 163
    return-object v7
.end method

.method private buildLive()V
    .locals 12

    .line 335
    iget-object v0, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    .line 336
    iget-object v1, v0, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    invoke-static {v1}, Lcom/riola/player/Store;->program(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object v1

    .line 337
    iget-boolean v2, v0, Lcom/riola/player/Engine$St;->running:Z

    if-eqz v2, :cond_5

    if-nez v1, :cond_0

    goto/16 :goto_3

    .line 344
    :cond_0
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 345
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveTitle:Landroid/widget/TextView;

    iget-object v4, v1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 346
    iget-object v2, v1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iget-object v4, p0, Lcom/riola/player/MainActivity;->liveProgramId:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    iget-object v4, v1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ne v2, v4, :cond_1

    .line 347
    iget v0, v0, Lcom/riola/player/Engine$St;->step:I

    invoke-direct {p0, v0}, Lcom/riola/player/MainActivity;->highlight(I)V

    .line 348
    return-void

    .line 350
    :cond_1
    iget-object v2, v1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iput-object v2, p0, Lcom/riola/player/MainActivity;->liveProgramId:Ljava/lang/String;

    .line 351
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveSteps:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 352
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->clear()V

    .line 353
    move v2, v3

    :goto_0
    iget-object v4, v1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ge v2, v4, :cond_4

    .line 354
    nop

    .line 355
    iget-object v4, v1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/riola/player/Step;

    .line 356
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 357
    const/high16 v5, 0x41000000    # 8.0f

    invoke-static {p0, v5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v6

    const/high16 v7, 0x40e00000    # 7.0f

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v8

    invoke-static {p0, v5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {p0, v7}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-virtual {v11, v6, v8, v5, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 358
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/high16 v10, 0x40000000    # 2.0f

    move-object v5, p0

    move-object v6, v11

    invoke-static/range {v5 .. v10}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 359
    invoke-static {v4}, Lcom/riola/player/MainActivity;->stepIcon(Lcom/riola/player/Step;)I

    move-result v5

    iget-boolean v6, v4, Lcom/riola/player/Step;->enabled:Z

    if-eqz v6, :cond_2

    sget v6, Lcom/riola/player/Ui;->DIM:I

    goto :goto_1

    :cond_2
    sget v6, Lcom/riola/player/Ui;->LINE:I

    :goto_1
    const/16 v7, 0xf

    invoke-static {p0, v5, v6, v7}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v5

    invoke-virtual {v11, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 360
    const/high16 v5, 0x41200000    # 10.0f

    invoke-static {p0, v5}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v11, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 361
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v5

    .line 362
    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-static {v3, v6, v7}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 363
    invoke-virtual {v4}, Lcom/riola/player/Step;->title()Ljava/lang/String;

    move-result-object v6

    iget-boolean v7, v4, Lcom/riola/player/Step;->enabled:Z

    if-eqz v7, :cond_3

    sget v7, Lcom/riola/player/Ui;->TXT:I

    goto :goto_2

    :cond_3
    sget v7, Lcom/riola/player/Ui;->DIM:I

    :goto_2
    const/high16 v8, 0x41500000    # 13.0f

    invoke-static {p0, v6, v8, v7, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    .line 364
    invoke-static {v6}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 365
    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 366
    invoke-virtual {v4}, Lcom/riola/player/Step;->detail()Ljava/lang/String;

    move-result-object v4

    const/high16 v6, 0x41300000    # 11.0f

    sget v7, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v4, v6, v7, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 367
    invoke-static {v4}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 368
    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 369
    invoke-virtual {v11, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 370
    new-instance v4, Lcom/riola/player/MainActivity$16;

    invoke-direct {v4, p0, v2}, Lcom/riola/player/MainActivity$16;-><init>(Lcom/riola/player/MainActivity;I)V

    invoke-virtual {v11, v4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 373
    iget-object v4, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v4, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 374
    iget-object v4, p0, Lcom/riola/player/MainActivity;->liveSteps:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 353
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    .line 376
    :cond_4
    iget v0, v0, Lcom/riola/player/Engine$St;->step:I

    invoke-direct {p0, v0}, Lcom/riola/player/MainActivity;->highlight(I)V

    .line 377
    return-void

    .line 338
    :cond_5
    :goto_3
    iget-object v0, p0, Lcom/riola/player/MainActivity;->liveCard:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 339
    iget-object v0, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 340
    iget-object v0, p0, Lcom/riola/player/MainActivity;->liveSteps:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 341
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/MainActivity;->liveProgramId:Ljava/lang/String;

    .line 342
    return-void
.end method

.method private colourName(I)Ljava/lang/String;
    .locals 2

    .line 457
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lcom/riola/player/Ui;->ACCENTS:[I

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 458
    sget-object v1, Lcom/riola/player/Ui;->ACCENTS:[I

    aget v1, v1, v0

    if-ne v1, p1, :cond_0

    sget-object p1, Lcom/riola/player/Ui;->ACCENT_NAMES:[Ljava/lang/String;

    aget-object p1, p1, v0

    return-object p1

    .line 457
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 460
    :cond_1
    const v0, 0xffffff

    and-int/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "Custom  #%06X"

    invoke-static {v0, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private help()V
    .locals 14

    .line 437
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 438
    const/high16 v0, 0x41a00000    # 20.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 439
    const/high16 v1, 0x40800000    # 4.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v7, 0x0

    invoke-virtual {v6, v0, v1, v0, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 440
    move v8, v7

    :goto_0
    sget-object v0, Lcom/riola/player/HelpText;->SECTIONS:[[Ljava/lang/String;

    array-length v0, v0

    const/4 v9, -0x2

    const/4 v10, -0x1

    if-ge v8, v0, :cond_1

    .line 441
    sget-object v0, Lcom/riola/player/HelpText;->SECTIONS:[[Ljava/lang/String;

    aget-object v11, v0, v8

    .line 442
    aget-object v0, v11, v7

    const/high16 v1, 0x41600000    # 14.0f

    sget v2, Lcom/riola/player/Ui;->ACC_TXT:I

    const/4 v12, 0x1

    invoke-static {p0, v0, v1, v2, v12}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v13

    .line 443
    const/4 v2, 0x0

    if-nez v8, :cond_0

    const/4 v0, 0x0

    goto :goto_1

    :cond_0
    const/high16 v0, 0x41900000    # 18.0f

    :goto_1
    move v3, v0

    const/4 v4, 0x0

    const/high16 v5, 0x40c00000    # 6.0f

    move-object v0, p0

    move-object v1, v13

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 444
    invoke-virtual {v6, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 445
    aget-object v0, v11, v12

    const/high16 v1, 0x41580000    # 13.5f

    sget v2, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, v0, v1, v2, v7}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 446
    const/high16 v1, 0x40400000    # 3.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 447
    invoke-static {v10, v9}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 448
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 440
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 450
    :cond_1
    const/high16 v0, 0x41400000    # 12.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 451
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 452
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v1, v10, v9}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v6, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 453
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "How Riola works"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Close"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 454
    return-void
.end method

.method private highlight(I)V
    .locals 7

    .line 387
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 388
    iget-object v2, p0, Lcom/riola/player/MainActivity;->liveRows:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 389
    const/high16 v3, 0x41200000    # 10.0f

    if-ne v1, p1, :cond_0

    sget v4, Lcom/riola/player/Ui;->ACC_SOFT:I

    sget v5, Lcom/riola/player/Ui;->ACC_TXT:I

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-static {p0, v4, v5, v3, v6}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    .line 390
    :cond_0
    invoke-static {p0, v0, v3}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-static {v3}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 387
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 392
    :cond_1
    return-void
.end method

.method private menu(Lcom/riola/player/Program;)V
    .locals 6

    .line 260
    const-string v0, "Play"

    const-string v1, "Edit"

    const-string v2, "Rename"

    const-string v3, "Duplicate"

    const-string v4, "Export to a file"

    const-string v5, "Delete"

    filled-new-array/range {v0 .. v5}, [Ljava/lang/String;

    move-result-object v0

    .line 261
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/riola/player/MainActivity$13;

    invoke-direct {v2, p0, p1}, Lcom/riola/player/MainActivity$13;-><init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 298
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 299
    return-void
.end method

.method private newProgram()V
    .locals 4

    .line 302
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Program "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/riola/player/MainActivity$14;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$14;-><init>(Lcom/riola/player/MainActivity;)V

    const-string v2, "New program"

    const-string v3, "name"

    invoke-static {p0, v2, v0, v3, v1}, Lcom/riola/player/Pickers;->text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V

    .line 310
    return-void
.end method

.method private open(Lcom/riola/player/Program;)V
    .locals 2

    .line 313
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/riola/player/EditorActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "id"

    iget-object p1, p1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 314
    return-void
.end method

.method private programRow(Lcom/riola/player/Program;)Landroid/view/View;
    .locals 10

    .line 203
    iget-object v0, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0, p1}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result v6

    .line 205
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 206
    const/high16 v0, 0x41600000    # 14.0f

    if-eqz v6, :cond_0

    sget v1, Lcom/riola/player/Ui;->SURF2:I

    sget v2, Lcom/riola/player/Ui;->ACC_TXT:I

    const v3, 0x3fb33333    # 1.4f

    invoke-static {p0, v1, v2, v0, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0

    .line 207
    :cond_0
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    invoke-static {p0, v1, v0}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 206
    :goto_0
    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 208
    const/high16 v0, 0x41200000    # 10.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v3, 0x40800000    # 4.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-virtual {v7, v1, v2, v3, v0}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 209
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x41000000    # 8.0f

    move-object v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 210
    new-instance v0, Lcom/riola/player/MainActivity$9;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/MainActivity$9;-><init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 213
    new-instance v0, Lcom/riola/player/MainActivity$10;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/MainActivity$10;-><init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 217
    const/4 v8, 0x1

    if-eqz v6, :cond_1

    const/4 v0, 0x3

    move v1, v0

    goto :goto_1

    :cond_1
    move v1, v8

    :goto_1
    const/16 v2, 0x14

    const/4 v3, 0x1

    .line 218
    if-eqz v6, :cond_2

    const-string v0, "Stop"

    goto :goto_2

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Play "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v4, p1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_2
    move-object v4, v0

    new-instance v5, Lcom/riola/player/MainActivity$11;

    invoke-direct {v5, p0, p1}, Lcom/riola/player/MainActivity$11;-><init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    .line 217
    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    .line 226
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 227
    const/high16 v0, 0x41400000    # 12.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v7, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 229
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 230
    const/4 v1, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    invoke-static {v3, v1, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 231
    iget-object v1, p1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    const/high16 v2, 0x41780000    # 15.5f

    sget v4, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, v1, v2, v4, v8}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 232
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 233
    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 234
    invoke-virtual {p1}, Lcom/riola/player/Program;->summary()Ljava/lang/String;

    move-result-object v1

    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v1, v0, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 235
    invoke-static {v0}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 236
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 237
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 238
    const/high16 v0, 0x40c00000    # 6.0f

    if-eqz v6, :cond_3

    .line 239
    sget v1, Lcom/riola/player/Ui;->ONACC:I

    sget v2, Lcom/riola/player/Ui;->GREEN:I

    const-string v4, "PLAYING"

    invoke-static {p0, v4, v1, v2}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 240
    invoke-static {p0, v0}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 242
    :cond_3
    invoke-virtual {p1}, Lcom/riola/player/Program;->hasMissing()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 243
    sget v1, Lcom/riola/player/Ui;->ONACC:I

    sget v2, Lcom/riola/player/Ui;->AMBER:I

    const-string v4, "MISSING TRACK"

    invoke-static {p0, v4, v1, v2}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 244
    invoke-static {p0, v0}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 246
    :cond_4
    iget-wide v0, p1, Lcom/riola/player/Program;->lastRun:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "last run "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p1, Lcom/riola/player/Program;->lastRun:J

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ago(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/high16 v1, 0x41300000    # 11.0f

    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v0, v1, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 247
    :cond_5
    invoke-virtual {v8}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_6

    .line 248
    const/4 v2, 0x0

    const/high16 v3, 0x40800000    # 4.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, v8

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 249
    invoke-virtual {v9, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 251
    :cond_6
    invoke-virtual {v7, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 253
    const/16 v1, 0x19

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0x10

    const-string v4, "More options"

    new-instance v5, Lcom/riola/player/MainActivity$12;

    invoke-direct {v5, p0, p1}, Lcom/riola/player/MainActivity$12;-><init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 256
    return-object v7
.end method

.method private refresh()V
    .locals 5

    .line 170
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    .line 171
    iget-object v1, p0, Lcom/riola/player/MainActivity;->tracksLine:Landroid/widget/TextView;

    const/4 v2, 0x1

    if-nez v0, :cond_0

    const-string v0, "none yet - tap to add music"

    goto :goto_1

    .line 172
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    if-ne v0, v2, :cond_1

    const-string v0, " track"

    goto :goto_0

    :cond_1
    const-string v0, " tracks"

    :goto_0
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " - tap to manage"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 171
    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 174
    iget-object v0, p0, Lcom/riola/player/MainActivity;->programsBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 175
    iget-object v0, p0, Lcom/riola/player/MainActivity;->emptyBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 176
    sget-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 177
    iget-object v0, p0, Lcom/riola/player/MainActivity;->emptyBox:Landroid/widget/LinearLayout;

    const-string v1, "No programs yet"

    const-string v3, "A program is a list of steps: play a track, loop a section, rest, repeat."

    const/16 v4, 0x20

    invoke-static {p0, v4, v1, v3}, Lcom/riola/player/Ui;->emptyState(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 179
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 180
    new-instance v0, Lcom/riola/player/MainActivity$8;

    invoke-direct {v0, p0}, Lcom/riola/player/MainActivity$8;-><init>(Lcom/riola/player/MainActivity;)V

    const-string v1, "Create an example program"

    const/16 v3, 0x1d

    invoke-static {p0, v1, v3, v2, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 189
    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-static {v1, v2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 190
    iget-object v1, p0, Lcom/riola/player/MainActivity;->emptyBox:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 191
    goto :goto_3

    .line 193
    :cond_2
    const/4 v0, 0x0

    :goto_2
    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_3

    .line 194
    iget-object v1, p0, Lcom/riola/player/MainActivity;->programsBox:Landroid/widget/LinearLayout;

    sget-object v2, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Program;

    invoke-direct {p0, v2}, Lcom/riola/player/MainActivity;->programRow(Lcom/riola/player/Program;)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 193
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 197
    :cond_3
    :goto_3
    iget-object v0, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    invoke-virtual {v0}, Lcom/riola/player/Engine;->isRunning()Z

    move-result v0

    iput-boolean v0, p0, Lcom/riola/player/MainActivity;->wasRunning:Z

    .line 198
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->buildLive()V

    .line 199
    iget-object v0, p0, Lcom/riola/player/MainActivity;->bar:Lcom/riola/player/PlayerBar;

    iget-object v1, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    iget-object v1, v1, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v0, v1}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 200
    return-void
.end method

.method private run(Lcom/riola/player/Program;I)V
    .locals 1

    .line 317
    invoke-virtual {p1}, Lcom/riola/player/Program;->enabledCount()I

    move-result v0

    if-nez v0, :cond_0

    .line 318
    const-string p2, "Add a step first"

    invoke-static {p0, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 319
    invoke-direct {p0, p1}, Lcom/riola/player/MainActivity;->open(Lcom/riola/player/Program;)V

    .line 320
    return-void

    .line 322
    :cond_0
    new-instance v0, Lcom/riola/player/MainActivity$15;

    invoke-direct {v0, p0}, Lcom/riola/player/MainActivity$15;-><init>(Lcom/riola/player/MainActivity;)V

    invoke-static {p0, p1, p2, v0}, Lcom/riola/player/Runner;->play(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    .line 329
    return-void
.end method

.method private settings()V
    .locals 13

    .line 464
    const/4 v0, 0x1

    new-array v8, v0, [Landroid/app/AlertDialog;

    .line 466
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 467
    const/high16 v1, 0x41900000    # 18.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 468
    const/high16 v10, 0x40c00000    # 6.0f

    invoke-static {p0, v10}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/4 v11, 0x0

    invoke-virtual {v9, v1, v2, v1, v11}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 470
    iget-object v1, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v1}, Lcom/riola/player/Prefs;->dark()Z

    move-result v1

    new-instance v2, Lcom/riola/player/MainActivity$17;

    invoke-direct {v2, p0, v8}, Lcom/riola/player/MainActivity$17;-><init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;)V

    const-string v3, "Dark theme"

    const/4 v12, 0x0

    invoke-static {p0, v3, v12, v1, v2}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 481
    new-instance v1, Lcom/riola/player/MainActivity$18;

    invoke-direct {v1, p0, v8}, Lcom/riola/player/MainActivity$18;-><init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;)V

    .line 488
    iget-object v2, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v2}, Lcom/riola/player/Prefs;->accent()I

    move-result v2

    invoke-direct {p0, v2}, Lcom/riola/player/MainActivity;->colourName(I)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/riola/player/MainActivity$19;

    invoke-direct {v3, p0, v8, v1}, Lcom/riola/player/MainActivity$19;-><init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V

    const-string v4, "Colour"

    const/16 v5, 0x16

    invoke-static {p0, v4, v2, v5, v3}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v2

    invoke-virtual {v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 495
    sget-object v2, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    iget-object v3, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v3}, Lcom/riola/player/Prefs;->style()I

    move-result v3

    sget-object v4, Lcom/riola/player/Ui;->STYLE_NAMES:[Ljava/lang/String;

    array-length v4, v4

    sub-int/2addr v4, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v11, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    aget-object v0, v2, v0

    new-instance v2, Lcom/riola/player/MainActivity$20;

    invoke-direct {v2, p0, v8, v1}, Lcom/riola/player/MainActivity$20;-><init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V

    const-string v1, "Look"

    const/16 v3, 0x17

    invoke-static {p0, v1, v0, v3, v2}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 502
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 503
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->keepScreenOn()Z

    move-result v0

    new-instance v1, Lcom/riola/player/MainActivity$21;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$21;-><init>(Lcom/riola/player/MainActivity;)V

    .line 502
    const-string v2, "Keep the screen on"

    const-string v3, "while the app is open"

    invoke-static {p0, v2, v3, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 510
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 511
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->wakeLock()Z

    move-result v0

    new-instance v1, Lcom/riola/player/MainActivity$22;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$22;-><init>(Lcom/riola/player/MainActivity;)V

    .line 510
    const-string v2, "Keep the CPU awake"

    const-string v3, "so long rests stay exact"

    invoke-static {p0, v2, v3, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 514
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 515
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->pauseUnplug()Z

    move-result v0

    new-instance v1, Lcom/riola/player/MainActivity$23;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$23;-><init>(Lcom/riola/player/MainActivity;)V

    .line 514
    const-string v2, "Pause when headphones unplug"

    invoke-static {p0, v2, v12, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 518
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 519
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->pauseOnFocus()Z

    move-result v0

    new-instance v1, Lcom/riola/player/MainActivity$24;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$24;-><init>(Lcom/riola/player/MainActivity;)V

    .line 518
    const-string v2, "Pause for calls and other apps"

    invoke-static {p0, v2, v12, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 522
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 523
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->haptics()Z

    move-result v0

    new-instance v1, Lcom/riola/player/MainActivity$25;

    invoke-direct {v1, p0}, Lcom/riola/player/MainActivity$25;-><init>(Lcom/riola/player/MainActivity;)V

    .line 522
    const-string v2, "Vibrate on button taps"

    invoke-static {p0, v2, v12, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 527
    invoke-static {p0}, Lcom/riola/player/Ui;->divider(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 528
    const-string v1, "Master volume"

    const/4 v2, 0x0

    const/16 v3, 0x64

    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->volume()I

    move-result v4

    const-string v5, "%"

    const/16 v6, 0x64

    new-instance v7, Lcom/riola/player/MainActivity$26;

    invoke-direct {v7, p0}, Lcom/riola/player/MainActivity$26;-><init>(Lcom/riola/player/MainActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 531
    const-string v1, "Playback speed"

    const/16 v2, 0x32

    const/16 v3, 0xc8

    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->speedPct()I

    move-result v4

    const-string v5, "%"

    new-instance v7, Lcom/riola/player/MainActivity$27;

    invoke-direct {v7, p0}, Lcom/riola/player/MainActivity$27;-><init>(Lcom/riola/player/MainActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 534
    const-string v1, "Fade at loop edges"

    const/4 v2, 0x0

    const/16 v3, 0x3e8

    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->fadeMs()I

    move-result v4

    const-string v5, " ms"

    const/16 v6, 0x96

    new-instance v7, Lcom/riola/player/MainActivity$28;

    invoke-direct {v7, p0}, Lcom/riola/player/MainActivity$28;-><init>(Lcom/riola/player/MainActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 537
    const-string v1, "Count in before starting"

    const/16 v3, 0xf

    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->countIn()I

    move-result v4

    const-string v5, " s"

    const/4 v6, 0x0

    new-instance v7, Lcom/riola/player/MainActivity$29;

    invoke-direct {v7, p0}, Lcom/riola/player/MainActivity$29;-><init>(Lcom/riola/player/MainActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 540
    const-string v1, "Stop everything after"

    const/16 v3, 0xb4

    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->autoStopMin()I

    move-result v4

    const-string v5, " min"

    new-instance v7, Lcom/riola/player/MainActivity$30;

    invoke-direct {v7, p0}, Lcom/riola/player/MainActivity$30;-><init>(Lcom/riola/player/MainActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 543
    sget v0, Lcom/riola/player/Ui;->DIM:I

    const-string v1, "Set the stop timer to 0 to switch it off."

    const/high16 v2, 0x41300000    # 11.0f

    invoke-static {p0, v1, v2, v0, v11}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 544
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 546
    invoke-static {p0}, Lcom/riola/player/Ui;->divider(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 547
    new-instance v0, Lcom/riola/player/MainActivity$31;

    invoke-direct {v0, p0, v8}, Lcom/riola/player/MainActivity$31;-><init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;)V

    const-string v1, "Reset settings to defaults"

    const/4 v3, 0x2

    invoke-static {p0, v1, v11, v3, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 556
    invoke-static {p0, v10}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 557
    const-string v0, "Riola  -  no ads, no network, no accounts."

    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v0, v2, v1, v11}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 558
    const/high16 v0, 0x41a00000    # 20.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 560
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 561
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v9, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 562
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "Settings"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 563
    const-string v1, "Done"

    invoke-virtual {v0, v1, v12}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    aput-object v0, v8, v11

    .line 564
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 565
    return-void
.end method

.method static stepIcon(Lcom/riola/player/Step;)I
    .locals 2

    .line 380
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/16 p0, 0x14

    return p0

    .line 381
    :cond_0
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    const/16 p0, 0x23

    return p0

    .line 382
    :cond_1
    iget p0, p0, Lcom/riola/player/Step;->type:I

    const/4 v0, 0x1

    if-ne p0, v0, :cond_2

    const/16 p0, 0xf

    return p0

    .line 383
    :cond_2
    const/16 p0, 0xe

    return p0
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 423
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 424
    const/4 v0, -0x1

    if-ne p2, v0, :cond_3

    if-eqz p3, :cond_3

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    if-nez p2, :cond_0

    goto :goto_1

    .line 425
    :cond_0
    const/16 p2, 0xc9

    if-ne p1, p2, :cond_1

    .line 426
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->write(Landroid/app/Activity;Landroid/net/Uri;)V

    goto :goto_0

    .line 427
    :cond_1
    const/16 p2, 0xca

    if-ne p1, p2, :cond_2

    .line 428
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->read(Landroid/app/Activity;Landroid/net/Uri;)V

    .line 429
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->refresh()V

    .line 431
    :cond_2
    :goto_0
    return-void

    .line 424
    :cond_3
    :goto_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 37
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    .line 38
    invoke-static {v0}, Lcom/riola/player/Ui;->theme(Lcom/riola/player/Prefs;)V

    .line 39
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->dark()Z

    move-result v0

    invoke-static {v0}, Lcom/riola/player/Ui;->themeRes(Z)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/riola/player/MainActivity;->setTheme(I)V

    .line 40
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 41
    invoke-static {p0}, Lcom/riola/player/Store;->load(Landroid/content/Context;)V

    .line 42
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    .line 43
    invoke-static {}, Lcom/riola/player/Bell;->warm()V

    .line 44
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->build()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/MainActivity;->setContentView(Landroid/view/View;)V

    .line 45
    invoke-static {p0}, Lcom/riola/player/Ui;->applyWindow(Landroid/app/Activity;)V

    .line 46
    sget-boolean p1, Lcom/riola/player/MainActivity;->reopenSettings:Z

    if-eqz p1, :cond_0

    .line 47
    const/4 p1, 0x0

    sput-boolean p1, Lcom/riola/player/MainActivity;->reopenSettings:Z

    .line 48
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->settings()V

    .line 50
    :cond_0
    return-void
.end method

.method public onEngineFinished(Z)V
    .locals 2

    .line 407
    iget-object v0, p0, Lcom/riola/player/MainActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v0, v0, Lcom/riola/player/Engine$St;->skipped:I

    .line 408
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->refresh()V

    .line 409
    if-lez v0, :cond_2

    .line 410
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p1, :cond_0

    const-string p1, "Finished, but "

    goto :goto_0

    :cond_0
    const-string p1, "Stopped. "

    :goto_0
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 411
    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-string v0, " step was skipped - its track is missing"

    goto :goto_1

    .line 412
    :cond_1
    const-string v0, " steps were skipped - their tracks are missing"

    :goto_1
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 410
    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_3

    .line 414
    :cond_2
    if-eqz p1, :cond_3

    const-string p1, "Program finished"

    goto :goto_2

    :cond_3
    const-string p1, "Stopped"

    :goto_2
    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 416
    :goto_3
    return-void
.end method

.method public onEngineState(Lcom/riola/player/Engine$St;)V
    .locals 2

    .line 398
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->running:Z

    iget-boolean v1, p0, Lcom/riola/player/MainActivity;->wasRunning:Z

    if-eq v0, v1, :cond_0

    .line 399
    iget-boolean p1, p1, Lcom/riola/player/Engine$St;->running:Z

    iput-boolean p1, p0, Lcom/riola/player/MainActivity;->wasRunning:Z

    .line 400
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->refresh()V

    .line 401
    return-void

    .line 403
    :cond_0
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->buildLive()V

    .line 404
    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 63
    iget-object v0, p0, Lcom/riola/player/MainActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->detach()V

    .line 64
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 65
    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 54
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 55
    iget-object v0, p0, Lcom/riola/player/MainActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->attach()V

    .line 56
    iget-object v0, p0, Lcom/riola/player/MainActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->keepScreenOn()Z

    move-result v0

    const/16 v1, 0x80

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/riola/player/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    .line 57
    :cond_0
    invoke-virtual {p0}, Lcom/riola/player/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 58
    :goto_0
    invoke-direct {p0}, Lcom/riola/player/MainActivity;->refresh()V

    .line 59
    return-void
.end method
