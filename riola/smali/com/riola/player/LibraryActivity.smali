.class public Lcom/riola/player/LibraryActivity;
.super Landroid/app/Activity;
.source "LibraryActivity.java"

# interfaces
.implements Lcom/riola/player/PlayerBar$Host;


# static fields
.field private static final REQ_FILES:I = 0x65

.field private static final REQ_TREE:I = 0x66


# instance fields
.field private bar:Lcom/riola/player/PlayerBar;

.field private eng:Lcom/riola/player/Engine;

.field private filter:Ljava/lang/String;

.field private listBox:Landroid/widget/LinearLayout;

.field private prefs:Lcom/riola/player/Prefs;

.field private search:Landroid/widget/EditText;

.field private subtitle:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 23
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/LibraryActivity;->filter:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->pickFiles()V

    return-void
.end method

.method static synthetic access$100(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->pickFolder()V

    return-void
.end method

.method static synthetic access$1000(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V
    .locals 0

    .line 23
    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->chooseAudioStream(Lcom/riola/player/Track;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/riola/player/LibraryActivity;II)V
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2}, Lcom/riola/player/LibraryActivity;->move(II)V

    return-void
.end method

.method static synthetic access$1200(Lcom/riola/player/LibraryActivity;ILcom/riola/player/Track;)V
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2}, Lcom/riola/player/LibraryActivity;->remove(ILcom/riola/player/Track;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;Ljava/util/List;Ljava/util/List;)V
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2, p3}, Lcom/riola/player/LibraryActivity;->showStreams(Lcom/riola/player/Track;Ljava/util/List;Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;Ljava/lang/String;Ljava/util/List;I)V
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/riola/player/LibraryActivity;->collect(Landroid/net/Uri;Ljava/lang/String;Ljava/util/List;I)V

    return-void
.end method

.method static synthetic access$1500(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;Ljava/lang/String;J)Z
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/riola/player/LibraryActivity;->add(Landroid/net/Uri;Ljava/lang/String;J)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1600(Lcom/riola/player/LibraryActivity;I)V
    .locals 0

    .line 23
    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->finishAdding(I)V

    return-void
.end method

.method static synthetic access$200(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->sortMenu()V

    return-void
.end method

.method static synthetic access$300(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->clearAll()V

    return-void
.end method

.method static synthetic access$402(Lcom/riola/player/LibraryActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 23
    iput-object p1, p0, Lcom/riola/player/LibraryActivity;->filter:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    return-void
.end method

.method static synthetic access$600(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Prefs;
    .locals 0

    .line 23
    iget-object p0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    return-object p0
.end method

.method static synthetic access$700(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Engine;
    .locals 0

    .line 23
    iget-object p0, p0, Lcom/riola/player/LibraryActivity;->eng:Lcom/riola/player/Engine;

    return-object p0
.end method

.method static synthetic access$800(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/PlayerBar;
    .locals 0

    .line 23
    iget-object p0, p0, Lcom/riola/player/LibraryActivity;->bar:Lcom/riola/player/PlayerBar;

    return-object p0
.end method

.method static synthetic access$900(Lcom/riola/player/LibraryActivity;I)V
    .locals 0

    .line 23
    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->menu(I)V

    return-void
.end method

.method private add(Landroid/net/Uri;Ljava/lang/String;)Z
    .locals 2

    .line 396
    const-wide/16 v0, 0x0

    invoke-direct {p0, p1, p2, v0, v1}, Lcom/riola/player/LibraryActivity;->add(Landroid/net/Uri;Ljava/lang/String;J)Z

    move-result p1

    return p1
.end method

.method private add(Landroid/net/Uri;Ljava/lang/String;J)Z
    .locals 3

    .line 404
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    .line 405
    sget-object v0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 406
    new-instance v0, Lcom/riola/player/Track;

    const-wide/16 v1, 0x0

    invoke-direct {v0, p1, p2, v1, v2}, Lcom/riola/player/Track;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 407
    invoke-virtual {v0}, Lcom/riola/player/Track;->key()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/riola/player/Store;->byKey(Ljava/lang/String;)Lcom/riola/player/Track;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    return p1

    .line 408
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, v0, Lcom/riola/player/Track;->addedAt:J

    .line 409
    iput-wide p3, v0, Lcom/riola/player/Track;->modifiedAt:J

    .line 410
    sget-object p1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {p1, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 411
    const/4 p1, 0x1

    return p1
.end method

.method private build()Landroid/view/View;
    .locals 16

    .line 52
    move-object/from16 v6, p0

    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 53
    sget v0, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 54
    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->setFitsSystemWindows(Z)V

    .line 56
    const/4 v1, 0x0

    const-string v2, "Tracks"

    const-string v3, ""

    const/4 v4, 0x1

    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->appBar(Landroid/app/Activity;ILjava/lang/String;Ljava/lang/String;Z[Landroid/view/View;)Lcom/riola/player/Ui$Bar;

    move-result-object v0

    .line 57
    iget-object v1, v0, Lcom/riola/player/Ui$Bar;->sub:Landroid/widget/TextView;

    iput-object v1, v6, Lcom/riola/player/LibraryActivity;->subtitle:Landroid/widget/TextView;

    .line 58
    iget-object v0, v0, Lcom/riola/player/Ui$Bar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 60
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 62
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v10

    .line 63
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 64
    new-instance v0, Lcom/riola/player/LibraryActivity$1;

    invoke-direct {v0, v6}, Lcom/riola/player/LibraryActivity$1;-><init>(Lcom/riola/player/LibraryActivity;)V

    const-string v1, "Add files"

    const/4 v2, 0x6

    const/4 v12, 0x0

    invoke-static {v6, v1, v2, v12, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v13

    .line 67
    const/4 v14, -0x2

    const/high16 v15, 0x3f800000    # 1.0f

    invoke-static {v12, v14, v15}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v13, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 68
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/high16 v4, 0x41000000    # 8.0f

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v13

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 69
    invoke-virtual {v11, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 70
    new-instance v0, Lcom/riola/player/LibraryActivity$2;

    invoke-direct {v0, v6}, Lcom/riola/player/LibraryActivity$2;-><init>(Lcom/riola/player/LibraryActivity;)V

    const-string v1, "Add folder"

    const/4 v2, 0x7

    invoke-static {v6, v1, v2, v8, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 73
    invoke-static {v12, v14, v15}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 74
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 75
    invoke-virtual {v10, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 76
    const/high16 v0, 0x41380000    # 11.5f

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const-string v2, "Riola only reads your files - nothing is copied, moved or changed. Video files work too: only their sound is played."

    invoke-static {v6, v2, v0, v1, v12}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v11

    .line 79
    const/high16 v2, 0x40000000    # 2.0f

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object v1, v11

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 80
    invoke-virtual {v10, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 81
    invoke-virtual {v9, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 83
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v10

    .line 84
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 85
    const/16 v0, 0x15

    const-string v1, "In the library"

    invoke-static {v6, v0, v1}, Lcom/riola/player/Ui;->heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 86
    invoke-static {v12, v14, v15}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 87
    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 88
    const/16 v1, 0x15

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0x10

    const-string v4, "Sort the library"

    new-instance v5, Lcom/riola/player/LibraryActivity$3;

    invoke-direct {v5, v6}, Lcom/riola/player/LibraryActivity$3;-><init>(Lcom/riola/player/LibraryActivity;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 91
    const/16 v1, 0x8

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const-string v4, "Remove all tracks"

    new-instance v5, Lcom/riola/player/LibraryActivity$4;

    invoke-direct {v5, v6}, Lcom/riola/player/LibraryActivity$4;-><init>(Lcom/riola/player/LibraryActivity;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 94
    invoke-virtual {v10, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 96
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, v6}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    iput-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    .line 97
    const-string v1, "Search the library"

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 98
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 99
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    const/high16 v1, 0x41500000    # 13.0f

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextSize(F)V

    .line 100
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    sget v1, Lcom/riola/player/Ui;->TXT:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 101
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    sget v1, Lcom/riola/player/Ui;->DIM:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 102
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    sget v1, Lcom/riola/player/Ui;->FIELD:I

    sget v2, Lcom/riola/player/Ui;->LINE:I

    sget v3, Lcom/riola/player/Ui;->RAD_BTN:F

    sget v4, Lcom/riola/player/Ui;->STROKE_W:F

    invoke-static {v6, v1, v2, v3, v4}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 103
    const/high16 v0, 0x41200000    # 10.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    .line 104
    iget-object v1, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    invoke-virtual {v1, v0, v0, v0, v0}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 105
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    const/4 v1, -0x1

    invoke-static {v1, v14}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 106
    iget-object v1, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 107
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    new-instance v1, Lcom/riola/player/LibraryActivity$5;

    invoke-direct {v1, v6}, Lcom/riola/player/LibraryActivity$5;-><init>(Lcom/riola/player/LibraryActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 115
    iget-object v0, v6, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 117
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, v6, Lcom/riola/player/LibraryActivity;->listBox:Landroid/widget/LinearLayout;

    .line 118
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 119
    invoke-virtual {v9, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 121
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {v6, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 122
    invoke-static {v6, v9}, Lcom/riola/player/Ui;->scroller(Landroid/content/Context;Landroid/widget/LinearLayout;)Landroid/widget/ScrollView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 124
    new-instance v0, Lcom/riola/player/PlayerBar;

    invoke-direct {v0, v6, v6}, Lcom/riola/player/PlayerBar;-><init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V

    iput-object v0, v6, Lcom/riola/player/LibraryActivity;->bar:Lcom/riola/player/PlayerBar;

    .line 125
    iget-object v0, v0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 126
    return-object v7
.end method

.method private chooseAudioStream(Lcom/riola/player/Track;)V
    .locals 2

    .line 245
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Reading "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "..."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 246
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/LibraryActivity$11;

    invoke-direct {v1, p0, p1}, Lcom/riola/player/LibraryActivity$11;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V

    const-string p1, "riola-streams"

    invoke-direct {v0, v1, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 273
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 274
    return-void
.end method

.method private clearAll()V
    .locals 3

    .line 331
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 332
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Remove every track?"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 333
    const-string v1, "Programs keep their steps but they will have nothing to play. Your files are untouched."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 334
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/LibraryActivity$14;

    invoke-direct {v1, p0}, Lcom/riola/player/LibraryActivity$14;-><init>(Lcom/riola/player/LibraryActivity;)V

    .line 335
    const-string v2, "Remove all"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 341
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 342
    return-void
.end method

.method private collect(Landroid/net/Uri;Ljava/lang/String;Ljava/util/List;I)V
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/riola/player/Track;",
            ">;I)V"
        }
    .end annotation

    .line 467
    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move-object/from16 v2, p3

    move/from16 v3, p4

    const/4 v4, 0x6

    if-gt v3, v4, :cond_9

    invoke-interface/range {p3 .. p3}, Ljava/util/List;->size()I

    move-result v4

    const/16 v5, 0x1f4

    if-le v4, v5, :cond_0

    goto/16 :goto_4

    .line 468
    :cond_0
    invoke-static/range {p1 .. p2}, Landroid/provider/DocumentsContract;->buildChildDocumentsUriUsingTree(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v7

    .line 469
    nop

    .line 471
    const/4 v4, 0x0

    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lcom/riola/player/LibraryActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    const/4 v5, 0x4

    new-array v8, v5, [Ljava/lang/String;

    const-string v5, "document_id"

    const/4 v12, 0x0

    aput-object v5, v8, v12

    const-string v5, "_display_name"

    const/4 v13, 0x1

    aput-object v5, v8, v13

    const-string v5, "mime_type"

    const/4 v14, 0x2

    aput-object v5, v8, v14

    const-string v5, "last_modified"

    const/4 v15, 0x3

    aput-object v5, v8, v15

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual/range {v6 .. v11}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 476
    if-nez v4, :cond_2

    .line 490
    if-eqz v4, :cond_1

    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 476
    :cond_1
    return-void

    .line 477
    :cond_2
    :goto_0
    :try_start_1
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v5

    if-eqz v5, :cond_6

    .line 478
    invoke-interface {v4, v12}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v13}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-interface {v4, v14}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 479
    invoke-interface {v4, v15}, Landroid/database/Cursor;->isNull(I)Z

    move-result v8

    const-wide/16 v9, 0x0

    if-eqz v8, :cond_3

    move-wide v14, v9

    goto :goto_1

    :cond_3
    invoke-interface {v4, v15}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v16

    move-wide/from16 v14, v16

    .line 480
    :goto_1
    const-string v11, "vnd.android.document/directory"

    invoke-virtual {v11, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_4

    .line 481
    add-int/lit8 v6, v3, 0x1

    invoke-direct {v1, v0, v5, v2, v6}, Lcom/riola/player/LibraryActivity;->collect(Landroid/net/Uri;Ljava/lang/String;Ljava/util/List;I)V

    goto :goto_2

    .line 482
    :cond_4
    invoke-direct {v1, v6, v7}, Lcom/riola/player/LibraryActivity;->isPlayable(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_5

    .line 483
    new-instance v7, Lcom/riola/player/Track;

    invoke-static {v0, v5}, Landroid/provider/DocumentsContract;->buildDocumentUriUsingTree(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    invoke-virtual {v5}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v7, v5, v6, v9, v10}, Lcom/riola/player/Track;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 485
    iput-wide v14, v7, Lcom/riola/player/Track;->modifiedAt:J

    .line 486
    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 488
    :cond_5
    :goto_2
    const/4 v14, 0x2

    const/4 v15, 0x3

    goto :goto_0

    .line 490
    :cond_6
    if-eqz v4, :cond_8

    goto :goto_3

    :catchall_0
    move-exception v0

    if-eqz v4, :cond_7

    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    :cond_7
    throw v0

    .line 489
    :catch_0
    move-exception v0

    .line 490
    if-eqz v4, :cond_8

    :goto_3
    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 491
    :cond_8
    return-void

    .line 467
    :cond_9
    :goto_4
    return-void
.end method

.method private displayName(Landroid/net/Uri;)Ljava/lang/String;
    .locals 9

    .line 434
    nop

    .line 436
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/riola/player/LibraryActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    new-array v4, v0, [Ljava/lang/String;

    const-string v3, "_display_name"

    const/4 v8, 0x0

    aput-object v3, v4, v8

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v3, p1

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 437
    if-eqz v1, :cond_1

    invoke-interface {v1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 438
    invoke-interface {v1, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 439
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lez v3, :cond_1

    .line 442
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 439
    :cond_0
    return-object v2

    .line 442
    :cond_1
    if-eqz v1, :cond_3

    goto :goto_0

    :catchall_0
    move-exception p1

    if-eqz v1, :cond_2

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    :cond_2
    throw p1

    .line 441
    :catch_0
    move-exception v2

    .line 442
    if-eqz v1, :cond_3

    :goto_0
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 443
    :cond_3
    invoke-virtual {p1}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object p1

    .line 444
    if-nez p1, :cond_4

    const-string p1, "track"

    goto :goto_1

    :cond_4
    const/16 v1, 0x2f

    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    add-int/2addr v1, v0

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    :goto_1
    return-object p1
.end method

.method private finishAdding(I)V
    .locals 2

    .line 415
    invoke-static {p0}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 416
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    .line 417
    if-nez p1, :cond_0

    const-string p1, "Nothing new was added"

    goto :goto_1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_1

    const-string p1, " track added"

    goto :goto_0

    :cond_1
    const-string p1, " tracks added"

    :goto_0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_1
    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 418
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->readDurations()V

    .line 419
    return-void
.end method

.method private isPlayable(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 28

    .line 495
    move-object/from16 v0, p2

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    const-string v2, "audio/"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "video/"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    return v1

    .line 496
    :cond_1
    const/4 v0, 0x0

    if-nez p1, :cond_2

    return v0

    .line 497
    :cond_2
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    .line 498
    const-string v3, ".mp3"

    const-string v4, ".m4a"

    const-string v5, ".aac"

    const-string v6, ".wav"

    const-string v7, ".ogg"

    const-string v8, ".oga"

    const-string v9, ".opus"

    const-string v10, ".flac"

    const-string v11, ".mka"

    const-string v12, ".wma"

    const-string v13, ".aif"

    const-string v14, ".aiff"

    const-string v15, ".amr"

    const-string v16, ".mp4"

    const-string v17, ".mkv"

    const-string v18, ".avi"

    const-string v19, ".mov"

    const-string v20, ".webm"

    const-string v21, ".m4v"

    const-string v22, ".3gp"

    const-string v23, ".ts"

    const-string v24, ".flv"

    const-string v25, ".wmv"

    const-string v26, ".mpg"

    const-string v27, ".mpeg"

    filled-new-array/range {v3 .. v27}, [Ljava/lang/String;

    move-result-object v3

    .line 502
    move v4, v0

    :goto_0
    const/16 v5, 0x19

    if-ge v4, v5, :cond_4

    aget-object v5, v3, v4

    invoke-virtual {v2, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    return v1

    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 503
    :cond_4
    return v0
.end method

.method private lastModified(Landroid/net/Uri;)J
    .locals 8

    .line 422
    nop

    .line 424
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/riola/player/LibraryActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/String;

    const-string v2, "last_modified"

    const/4 v7, 0x0

    aput-object v2, v3, v7

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v2, p1

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    .line 427
    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/database/Cursor;->moveToFirst()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-interface {v0, v7}, Landroid/database/Cursor;->isNull(I)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-interface {v0, v7}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 429
    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 427
    :cond_0
    return-wide v1

    .line 429
    :cond_1
    if-eqz v0, :cond_3

    goto :goto_0

    :catchall_0
    move-exception p1

    if-eqz v0, :cond_2

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_2
    throw p1

    .line 428
    :catch_0
    move-exception p1

    .line 429
    if-eqz v0, :cond_3

    :goto_0
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 430
    :cond_3
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method private menu(I)V
    .locals 7

    .line 209
    if-ltz p1, :cond_1

    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    goto :goto_0

    .line 210
    :cond_0
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/riola/player/Track;

    .line 211
    const-string v1, "Preview"

    const-string v2, "Rename"

    const-string v3, "Choose audio stream"

    const-string v4, "Move up"

    const-string v5, "Move down"

    const-string v6, "Remove from library"

    filled-new-array/range {v1 .. v6}, [Ljava/lang/String;

    move-result-object v1

    .line 213
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v0}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Lcom/riola/player/LibraryActivity$10;

    invoke-direct {v3, p0, v0, p1}, Lcom/riola/player/LibraryActivity$10;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;I)V

    invoke-virtual {v2, v1, v3}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 237
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 238
    return-void

    .line 209
    :cond_1
    :goto_0
    return-void
.end method

.method private move(II)V
    .locals 3

    .line 300
    add-int/2addr p2, p1

    .line 301
    if-ltz p2, :cond_2

    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    if-lt p2, v0, :cond_0

    goto :goto_0

    .line 302
    :cond_0
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->librarySort()I

    move-result v0

    if-eqz v0, :cond_1

    .line 303
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/riola/player/Prefs;->librarySort(I)V

    .line 304
    const-string v0, "Switched back to manual order"

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 306
    :cond_1
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/riola/player/Track;

    .line 307
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    sget-object v2, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2, p2}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    invoke-virtual {v1, p1, v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 308
    sget-object p1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {p1, p2, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 309
    invoke-static {p0}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 310
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    .line 311
    return-void

    .line 301
    :cond_2
    :goto_0
    return-void
.end method

.method private persist(Landroid/net/Uri;)V
    .locals 2

    .line 392
    :try_start_0
    invoke-virtual {p0}, Lcom/riola/player/LibraryActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroid/content/ContentResolver;->takePersistableUriPermission(Landroid/net/Uri;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 393
    :catch_0
    move-exception p1

    :goto_0
    nop

    .line 394
    return-void
.end method

.method private pickFiles()V
    .locals 5

    .line 348
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 349
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 350
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 351
    const-string v1, "android.intent.extra.ALLOW_MULTIPLE"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 352
    const-string v1, "application/ogg"

    const-string v2, "application/x-ogg"

    const-string v3, "audio/*"

    const-string v4, "video/*"

    filled-new-array {v3, v4, v1, v2}, [Ljava/lang/String;

    move-result-object v1

    const-string v2, "android.intent.extra.MIME_TYPES"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    .line 354
    const/16 v1, 0x41

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 355
    const/16 v1, 0x65

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/riola/player/LibraryActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 356
    goto :goto_0

    :catch_0
    move-exception v0

    const-string v0, "No file picker on this device"

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 357
    :goto_0
    return-void
.end method

.method private pickFolder()V
    .locals 2

    .line 360
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT_TREE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 361
    const/16 v1, 0x41

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 362
    const/16 v1, 0x66

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/riola/player/LibraryActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 363
    goto :goto_0

    :catch_0
    move-exception v0

    const-string v0, "No folder picker on this device"

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 364
    :goto_0
    return-void
.end method

.method private readDurations()V
    .locals 2

    .line 507
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/LibraryActivity$16;

    invoke-direct {v1, p0}, Lcom/riola/player/LibraryActivity$16;-><init>(Lcom/riola/player/LibraryActivity;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 526
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 527
    return-void
.end method

.method private refresh()V
    .locals 6

    .line 130
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    .line 131
    sget-object v1, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    iget-object v2, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v2}, Lcom/riola/player/Prefs;->librarySort()I

    move-result v2

    sget-object v3, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    array-length v3, v3

    const/4 v4, 0x1

    sub-int/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    const/4 v3, 0x0

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    aget-object v1, v1, v2

    .line 132
    iget-object v2, p0, Lcom/riola/player/LibraryActivity;->subtitle:Landroid/widget/TextView;

    if-nez v0, :cond_0

    const-string v1, "nothing added yet"

    goto :goto_1

    .line 133
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    if-ne v0, v4, :cond_1

    const-string v4, " track"

    goto :goto_0

    :cond_1
    const-string v4, " tracks"

    :goto_0
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "  .  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 132
    :goto_1
    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 134
    iget-object v1, p0, Lcom/riola/player/LibraryActivity;->search:Landroid/widget/EditText;

    if-eqz v1, :cond_3

    const/16 v2, 0x8

    if-le v0, v2, :cond_2

    move v2, v3

    :cond_2
    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setVisibility(I)V

    .line 136
    :cond_3
    iget-object v1, p0, Lcom/riola/player/LibraryActivity;->listBox:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 137
    if-nez v0, :cond_4

    .line 138
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->listBox:Landroid/widget/LinearLayout;

    const-string v1, "No tracks yet"

    const-string v2, "Add single files, or point Riola at a folder and it will find the audio inside."

    const/16 v3, 0xe

    invoke-static {p0, v3, v1, v2}, Lcom/riola/player/Ui;->emptyState(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 140
    return-void

    .line 143
    :cond_4
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->librarySort()I

    move-result v0

    iget-object v1, p0, Lcom/riola/player/LibraryActivity;->filter:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/riola/player/Store;->view(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 144
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 145
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->listBox:Landroid/widget/LinearLayout;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Nothing matches \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/riola/player/LibraryActivity;->filter:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41500000    # 13.0f

    sget v4, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v1, v2, v4, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 146
    return-void

    .line 148
    :cond_5
    nop

    :goto_2
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-ge v3, v1, :cond_6

    iget-object v1, p0, Lcom/riola/player/LibraryActivity;->listBox:Landroid/widget/LinearLayout;

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    invoke-direct {p0, v2}, Lcom/riola/player/LibraryActivity;->row(Lcom/riola/player/Track;)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 149
    :cond_6
    return-void
.end method

.method private remove(ILcom/riola/player/Track;)V
    .locals 4

    .line 314
    invoke-direct {p0, p2}, Lcom/riola/player/LibraryActivity;->usage(Lcom/riola/player/Track;)Ljava/lang/String;

    move-result-object v0

    .line 315
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Remove "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p2}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v2, "?"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    .line 316
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    .line 317
    const-string v0, "The file on your phone is not touched."

    goto :goto_0

    .line 318
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "This track is"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  .  used"

    const-string v3, " used"

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ". Those steps will be marked missing and skipped.\n\nThe file itself is not touched."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 316
    :goto_0
    invoke-virtual {p2, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    .line 320
    const-string v0, "Cancel"

    const/4 v1, 0x0

    invoke-virtual {p2, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    new-instance v0, Lcom/riola/player/LibraryActivity$13;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/LibraryActivity$13;-><init>(Lcom/riola/player/LibraryActivity;I)V

    .line 321
    const-string p1, "Remove"

    invoke-virtual {p2, p1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 327
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 328
    return-void
.end method

.method private row(Lcom/riola/player/Track;)Landroid/view/View;
    .locals 11

    .line 162
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-boolean v0, v0, Lcom/riola/player/Engine$St;->running:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-boolean v0, v0, Lcom/riola/player/Engine$St;->preview:Z

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    iget-object v3, p0, Lcom/riola/player/LibraryActivity;->eng:Lcom/riola/player/Engine;

    iget-object v3, v3, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v3, v3, Lcom/riola/player/Engine$St;->trackUri:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    .line 164
    :goto_0
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 165
    sget v3, Lcom/riola/player/Ui;->SURF2:I

    const/high16 v4, 0x41400000    # 12.0f

    invoke-static {p0, v3, v4}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-static {v3}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v9, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 166
    const/high16 v10, 0x40c00000    # 6.0f

    invoke-static {p0, v10}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    const/high16 v4, 0x41000000    # 8.0f

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v5

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {p0, v6}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v9, v3, v5, v6, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 167
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/high16 v8, 0x40c00000    # 6.0f

    move-object v3, p0

    move-object v4, v9

    invoke-static/range {v3 .. v8}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 169
    if-eqz v0, :cond_1

    const/4 v1, 0x3

    :cond_1
    move v4, v1

    const/16 v5, 0x10

    const/4 v6, 0x0

    const-string v7, "Preview"

    new-instance v8, Lcom/riola/player/LibraryActivity$7;

    invoke-direct {v8, p0, p1}, Lcom/riola/player/LibraryActivity$7;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V

    move-object v3, p0

    invoke-static/range {v3 .. v8}, Lcom/riola/player/Ui;->roundBtn(Landroid/content/Context;IIZLjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 177
    invoke-static {p0, v10}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 179
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 180
    const/4 v1, -0x2

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v2, v1, v3}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 181
    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v1

    const/high16 v3, 0x41600000    # 14.0f

    sget v4, Lcom/riola/player/Ui;->TXT:I

    invoke-static {p0, v1, v3, v4, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 182
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 183
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 184
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-wide v3, p1, Lcom/riola/player/Track;->durMs:J

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-lez v3, :cond_2

    iget-wide v3, p1, Lcom/riola/player/Track;->durMs:J

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    const-string v3, "length unknown"

    :goto_1
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 185
    invoke-virtual {p1}, Lcom/riola/player/Track;->isVideo()Z

    move-result v3

    if-eqz v3, :cond_3

    const-string v3, "  .  video, audio only"

    goto :goto_2

    :cond_3
    const-string v3, ""

    :goto_2
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->usage(Lcom/riola/player/Track;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget v3, Lcom/riola/player/Ui;->DIM:I

    .line 184
    const/high16 v4, 0x41300000    # 11.0f

    invoke-static {p0, v1, v4, v3, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 187
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 189
    const/16 v3, 0x19

    sget v4, Lcom/riola/player/Ui;->DIM:I

    const/16 v5, 0x10

    const-string v6, "Track options"

    new-instance v7, Lcom/riola/player/LibraryActivity$8;

    invoke-direct {v7, p0, p1}, Lcom/riola/player/LibraryActivity$8;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V

    move-object v2, p0

    invoke-static/range {v2 .. v7}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 192
    new-instance v0, Lcom/riola/player/LibraryActivity$9;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/LibraryActivity$9;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 195
    return-object v9
.end method

.method private scanFolder(Landroid/net/Uri;)V
    .locals 2

    .line 448
    const-string v0, "Scanning folder..."

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 449
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/LibraryActivity$15;

    invoke-direct {v1, p0, p1}, Lcom/riola/player/LibraryActivity$15;-><init>(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 463
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 464
    return-void
.end method

.method private showStreams(Lcom/riola/player/Track;Ljava/util/List;Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/riola/player/Track;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .line 278
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 279
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string p2, "No choice to make"

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 280
    const-string p2, "Riola could not read the audio streams in this file, or there is only one. It will play whichever the file provides."

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 282
    const-string p2, "OK"

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 283
    return-void

    .line 285
    :cond_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    .line 286
    const-string v1, "Whatever the file defaults to"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 287
    nop

    :goto_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v1

    if-ge v2, v1, :cond_1

    add-int/lit8 v1, v2, 0x1

    invoke-interface {p2, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    aput-object v2, v0, v1

    move v2, v1

    goto :goto_0

    .line 288
    :cond_1
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    new-instance v1, Lcom/riola/player/LibraryActivity$12;

    invoke-direct {v1, p0, p1, p3, v0}, Lcom/riola/player/LibraryActivity$12;-><init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;Ljava/util/List;[Ljava/lang/String;)V

    invoke-virtual {p2, v0, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 296
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 297
    return-void
.end method

.method private sortMenu()V
    .locals 3

    .line 152
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "Sort the library"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    sget-object v1, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    new-instance v2, Lcom/riola/player/LibraryActivity$6;

    invoke-direct {v2, p0}, Lcom/riola/player/LibraryActivity$6;-><init>(Lcom/riola/player/LibraryActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 158
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 159
    return-void
.end method

.method private usage(Lcom/riola/player/Track;)Ljava/lang/String;
    .locals 7

    .line 199
    nop

    .line 200
    sget-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Program;

    .line 201
    move v4, v1

    :goto_1
    iget-object v5, v3, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-ge v4, v5, :cond_1

    .line 202
    iget-object v5, p1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    iget-object v6, v3, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/riola/player/Step;

    iget-object v6, v6, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 201
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 204
    :cond_1
    :goto_2
    goto :goto_0

    .line 205
    :cond_2
    if-nez v2, :cond_3

    const-string p1, ""

    goto :goto_4

    :cond_3
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "  .  used in "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const/4 v0, 0x1

    if-ne v2, v0, :cond_4

    const-string v0, " program"

    goto :goto_3

    :cond_4
    const-string v0, " programs"

    :goto_3
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_4
    return-object p1
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    .line 368
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 369
    const/4 v0, -0x1

    if-ne p2, v0, :cond_8

    if-nez p3, :cond_0

    goto/16 :goto_4

    .line 371
    :cond_0
    const/16 p2, 0x65

    if-ne p1, p2, :cond_5

    .line 372
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 373
    invoke-virtual {p3}, Landroid/content/Intent;->getClipData()Landroid/content/ClipData;

    move-result-object p2

    .line 374
    const/4 v0, 0x0

    if-eqz p2, :cond_1

    move p3, v0

    :goto_0
    invoke-virtual {p2}, Landroid/content/ClipData;->getItemCount()I

    move-result v1

    if-ge p3, v1, :cond_2

    invoke-virtual {p2, p3}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getUri()Landroid/net/Uri;

    move-result-object v1

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    .line 375
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    if-eqz p2, :cond_2

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 376
    :cond_2
    nop

    .line 377
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/net/Uri;

    .line 378
    invoke-direct {p0, p2}, Lcom/riola/player/LibraryActivity;->persist(Landroid/net/Uri;)V

    .line 379
    invoke-direct {p0, p2}, Lcom/riola/player/LibraryActivity;->displayName(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object p3

    invoke-direct {p0, p2}, Lcom/riola/player/LibraryActivity;->lastModified(Landroid/net/Uri;)J

    move-result-wide v1

    invoke-direct {p0, p2, p3, v1, v2}, Lcom/riola/player/LibraryActivity;->add(Landroid/net/Uri;Ljava/lang/String;J)Z

    move-result p2

    if-eqz p2, :cond_3

    add-int/lit8 v0, v0, 0x1

    .line 380
    :cond_3
    goto :goto_1

    .line 381
    :cond_4
    invoke-direct {p0, v0}, Lcom/riola/player/LibraryActivity;->finishAdding(I)V

    goto :goto_2

    .line 383
    :cond_5
    const/16 p2, 0x66

    if-ne p1, p2, :cond_7

    .line 384
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    .line 385
    if-nez p1, :cond_6

    return-void

    .line 386
    :cond_6
    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->persist(Landroid/net/Uri;)V

    .line 387
    invoke-direct {p0, p1}, Lcom/riola/player/LibraryActivity;->scanFolder(Landroid/net/Uri;)V

    goto :goto_3

    .line 383
    :cond_7
    :goto_2
    nop

    .line 389
    :goto_3
    return-void

    .line 369
    :cond_8
    :goto_4
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 37
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    .line 38
    invoke-static {v0}, Lcom/riola/player/Ui;->theme(Lcom/riola/player/Prefs;)V

    .line 39
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->dark()Z

    move-result v0

    invoke-static {v0}, Lcom/riola/player/Ui;->themeRes(Z)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/riola/player/LibraryActivity;->setTheme(I)V

    .line 40
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 41
    invoke-static {p0}, Lcom/riola/player/Store;->load(Landroid/content/Context;)V

    .line 42
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/LibraryActivity;->eng:Lcom/riola/player/Engine;

    .line 43
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->build()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/LibraryActivity;->setContentView(Landroid/view/View;)V

    .line 44
    invoke-static {p0}, Lcom/riola/player/Ui;->applyWindow(Landroid/app/Activity;)V

    .line 45
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    .line 46
    return-void
.end method

.method public onEngineFinished(Z)V
    .locals 0

    .line 532
    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    return-void
.end method

.method public onEngineState(Lcom/riola/player/Engine$St;)V
    .locals 0

    .line 530
    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 49
    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->detach()V

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 48
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-object v0, p0, Lcom/riola/player/LibraryActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->attach()V

    invoke-direct {p0}, Lcom/riola/player/LibraryActivity;->refresh()V

    return-void
.end method
