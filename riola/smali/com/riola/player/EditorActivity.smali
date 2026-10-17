.class public Lcom/riola/player/EditorActivity;
.super Landroid/app/Activity;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/PlayerBar$Host;


# static fields
.field private static final REQ_EXPORT:I = 0x12d

.field private static final UNDO_SECONDS:I = 0x14


# instance fields
.field private bar:Lcom/riola/player/PlayerBar;

.field private dirty:Z

.field private eng:Lcom/riola/player/Engine;

.field private liveRow:I

.field private loopBox:Landroid/widget/LinearLayout;

.field private prefs:Lcom/riola/player/Prefs;

.field private prog:Lcom/riola/player/Program;

.field private final rows:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private scroller:Landroid/widget/ScrollView;

.field private stepsBox:Landroid/widget/LinearLayout;

.field private subView:Landroid/widget/TextView;

.field private titleView:Landroid/widget/TextView;

.field private totalBadge:Landroid/widget/TextView;

.field private final ui:Landroid/os/Handler;

.field private undoAt:I

.field private undoLabel:Landroid/widget/TextView;

.field private undoLeft:I

.field private undoStep:Lcom/riola/player/Step;

.field private final undoTick:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 17
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 28
    const/4 v0, -0x1

    iput v0, p0, Lcom/riola/player/EditorActivity;->liveRow:I

    .line 30
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    .line 33
    iput v0, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    .line 37
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    .line 38
    new-instance v0, Lcom/riola/player/EditorActivity$1;

    invoke-direct {v0, p0}, Lcom/riola/player/EditorActivity$1;-><init>(Lcom/riola/player/EditorActivity;)V

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->undoTick:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Step;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    return-object p0
.end method

.method static synthetic access$002(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;)Lcom/riola/player/Step;
    .locals 0

    .line 17
    iput-object p1, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    return-object p1
.end method

.method static synthetic access$100(Lcom/riola/player/EditorActivity;)I
    .locals 0

    .line 17
    iget p0, p0, Lcom/riola/player/EditorActivity;->undoLeft:I

    return p0
.end method

.method static synthetic access$1000(Lcom/riola/player/EditorActivity;)Landroid/widget/ScrollView;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->scroller:Landroid/widget/ScrollView;

    return-object p0
.end method

.method static synthetic access$110(Lcom/riola/player/EditorActivity;)I
    .locals 2

    .line 17
    iget v0, p0, Lcom/riola/player/EditorActivity;->undoLeft:I

    add-int/lit8 v1, v0, -0x1

    iput v1, p0, Lcom/riola/player/EditorActivity;->undoLeft:I

    return v0
.end method

.method static synthetic access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    return-object p0
.end method

.method static synthetic access$1102(Lcom/riola/player/EditorActivity;Lcom/riola/player/Program;)Lcom/riola/player/Program;
    .locals 0

    .line 17
    iput-object p1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    return-object p1
.end method

.method static synthetic access$1200(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->save()V

    return-void
.end method

.method static synthetic access$1300(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->subView:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$1400(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->totalBadge:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$1500(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->restoreStep()V

    return-void
.end method

.method static synthetic access$1600(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Engine;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->eng:Lcom/riola/player/Engine;

    return-object p0
.end method

.method static synthetic access$1700(Lcom/riola/player/EditorActivity;I)V
    .locals 0

    .line 17
    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->edit(I)V

    return-void
.end method

.method static synthetic access$1800(Lcom/riola/player/EditorActivity;I)V
    .locals 0

    .line 17
    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->stepMenu(I)V

    return-void
.end method

.method static synthetic access$1900(Lcom/riola/player/EditorActivity;II)V
    .locals 0

    .line 17
    invoke-direct {p0, p1, p2}, Lcom/riola/player/EditorActivity;->move(II)V

    return-void
.end method

.method static synthetic access$2000(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;I)I
    .locals 0

    .line 17
    invoke-direct {p0, p1, p2}, Lcom/riola/player/EditorActivity;->place(Lcom/riola/player/Step;I)I

    move-result p0

    return p0
.end method

.method static synthetic access$202(Lcom/riola/player/EditorActivity;I)I
    .locals 0

    .line 17
    iput p1, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    return p1
.end method

.method static synthetic access$2100(Lcom/riola/player/EditorActivity;I)V
    .locals 0

    .line 17
    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->removeStep(I)V

    return-void
.end method

.method static synthetic access$2200(Lcom/riola/player/EditorActivity;I)V
    .locals 0

    .line 17
    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->addStep(I)V

    return-void
.end method

.method static synthetic access$2300(Lcom/riola/player/EditorActivity;)Lcom/riola/player/PlayerBar;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->bar:Lcom/riola/player/PlayerBar;

    return-object p0
.end method

.method static synthetic access$300(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    return-void
.end method

.method static synthetic access$400(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->undoLabel:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$500(Lcom/riola/player/EditorActivity;)Landroid/os/Handler;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$600(Lcom/riola/player/EditorActivity;I)V
    .locals 0

    .line 17
    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->run(I)V

    return-void
.end method

.method static synthetic access$700(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->menu()V

    return-void
.end method

.method static synthetic access$800(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->rename()V

    return-void
.end method

.method static synthetic access$900(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->addStep()V

    return-void
.end method

.method private addStep()V
    .locals 1

    .line 341
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/riola/player/EditorActivity;->addStep(I)V

    return-void
.end method

.method private addStep(I)V
    .locals 4

    .line 345
    const-string v0, "Silence"

    const-string v1, "Bell"

    const-string v2, "Whole track"

    const-string v3, "Section of a track"

    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    .line 346
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    if-gez p1, :cond_0

    const-string v2, "Add step"

    goto :goto_0

    :cond_0
    const-string v2, "Insert step"

    :goto_0
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/riola/player/EditorActivity$15;

    invoke-direct {v2, p0, p1}, Lcom/riola/player/EditorActivity$15;-><init>(Lcom/riola/player/EditorActivity;I)V

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 389
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 390
    return-void
.end method

.method private build()Landroid/view/View;
    .locals 10

    .line 97
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 98
    sget v0, Lcom/riola/player/Ui;->BG:I

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 99
    const/4 v7, 0x1

    invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->setFitsSystemWindows(Z)V

    .line 101
    const/4 v0, 0x2

    new-array v8, v0, [Landroid/view/View;

    const/4 v1, 0x1

    sget v2, Lcom/riola/player/Ui;->ACC_TXT:I

    const/16 v3, 0x14

    const-string v4, "Run this program"

    new-instance v5, Lcom/riola/player/EditorActivity$2;

    invoke-direct {v5, p0}, Lcom/riola/player/EditorActivity$2;-><init>(Lcom/riola/player/EditorActivity;)V

    .line 102
    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    const/4 v9, 0x0

    aput-object v0, v8, v9

    const/16 v1, 0x19

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const-string v4, "More options"

    new-instance v5, Lcom/riola/player/EditorActivity$3;

    invoke-direct {v5, p0}, Lcom/riola/player/EditorActivity$3;-><init>(Lcom/riola/player/EditorActivity;)V

    .line 105
    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    aput-object v0, v8, v7

    .line 109
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v2, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-virtual {v0}, Lcom/riola/player/Program;->summary()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    move-object v0, p0

    move-object v5, v8

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->appBar(Landroid/app/Activity;ILjava/lang/String;Ljava/lang/String;Z[Landroid/view/View;)Lcom/riola/player/Ui$Bar;

    move-result-object v0

    .line 110
    iget-object v1, v0, Lcom/riola/player/Ui$Bar;->title:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/riola/player/EditorActivity;->titleView:Landroid/widget/TextView;

    .line 111
    iget-object v1, v0, Lcom/riola/player/Ui$Bar;->sub:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/riola/player/EditorActivity;->subView:Landroid/widget/TextView;

    .line 112
    iget-object v1, v0, Lcom/riola/player/Ui$Bar;->titles:Landroid/widget/LinearLayout;

    new-instance v2, Lcom/riola/player/EditorActivity$4;

    invoke-direct {v2, p0}, Lcom/riola/player/EditorActivity$4;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 115
    iget-object v0, v0, Lcom/riola/player/Ui$Bar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 117
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 119
    invoke-static {p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 120
    const/16 v1, 0xd

    const-string v2, "Repeat program"

    invoke-static {p0, v1, v2}, Lcom/riola/player/Ui;->heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 121
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/EditorActivity;->loopBox:Landroid/widget/LinearLayout;

    .line 122
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 125
    invoke-static {p0}, Lcom/riola/player/Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 126
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 127
    const/16 v1, 0x15

    const-string v2, "Steps"

    invoke-static {p0, v1, v2}, Lcom/riola/player/Ui;->heading(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 128
    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, -0x2

    invoke-static {v9, v3, v2}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 129
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 130
    sget v1, Lcom/riola/player/Ui;->DIM:I

    sget v2, Lcom/riola/player/Ui;->SURF2:I

    const-string v4, ""

    invoke-static {p0, v4, v1, v2}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/riola/player/EditorActivity;->totalBadge:Landroid/widget/TextView;

    .line 131
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 132
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 134
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->stepsBox:Landroid/widget/LinearLayout;

    .line 135
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 137
    new-instance v0, Lcom/riola/player/EditorActivity$5;

    invoke-direct {v0, p0}, Lcom/riola/player/EditorActivity$5;-><init>(Lcom/riola/player/EditorActivity;)V

    const-string v1, "Add step"

    const/4 v2, 0x6

    invoke-static {p0, v1, v2, v9, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v9

    .line 140
    const/4 v0, -0x1

    invoke-static {v0, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 141
    const/4 v2, 0x0

    const/high16 v3, 0x41200000    # 10.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, v9

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 142
    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 143
    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 145
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 146
    invoke-static {p0, v7}, Lcom/riola/player/Ui;->scroller(Landroid/content/Context;Landroid/widget/LinearLayout;)Landroid/widget/ScrollView;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->scroller:Landroid/widget/ScrollView;

    .line 147
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 149
    new-instance v0, Lcom/riola/player/PlayerBar;

    invoke-direct {v0, p0, p0}, Lcom/riola/player/PlayerBar;-><init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->bar:Lcom/riola/player/PlayerBar;

    .line 150
    iget-object v0, v0, Lcom/riola/player/PlayerBar;->view:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 151
    return-object v6
.end method

.method private edit(I)V
    .locals 2

    .line 402
    if-ltz p1, :cond_1

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    goto :goto_0

    .line 403
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    new-instance v1, Lcom/riola/player/EditorActivity$16;

    invoke-direct {v1, p0}, Lcom/riola/player/EditorActivity$16;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-static {p0, v0, p1, v1}, Lcom/riola/player/StepSheet;->show(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/StepSheet$OnDone;)V

    .line 407
    return-void

    .line 402
    :cond_1
    :goto_0
    return-void
.end method

.method private menu()V
    .locals 4

    .line 446
    const-string v0, "Export to a file"

    const-string v1, "Delete program"

    const-string v2, "Rename"

    const-string v3, "Duplicate"

    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    .line 447
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v2, v2, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/riola/player/EditorActivity$19;

    invoke-direct {v2, p0}, Lcom/riola/player/EditorActivity$19;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 469
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 470
    return-void
.end method

.method private move(II)V
    .locals 1

    .line 431
    add-int/2addr p2, p1

    .line 432
    if-ltz p2, :cond_1

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :cond_0

    goto :goto_0

    .line 433
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/riola/player/Step;

    .line 434
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 435
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->save()V

    .line 436
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 437
    return-void

    .line 432
    :cond_1
    :goto_0
    return-void
.end method

.method private place(Lcom/riola/player/Step;I)I
    .locals 1

    .line 393
    if-ltz p2, :cond_1

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-le p2, v0, :cond_0

    goto :goto_0

    .line 397
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 398
    return p2

    .line 394
    :cond_1
    :goto_0
    iget-object p2, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object p2, p2, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 395
    iget-object p1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object p1, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    add-int/lit8 p1, p1, -0x1

    return p1
.end method

.method private refresh()V
    .locals 13

    .line 172
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-nez v0, :cond_0

    return-void

    .line 173
    :cond_0
    iget-object v1, p0, Lcom/riola/player/EditorActivity;->titleView:Landroid/widget/TextView;

    iget-object v0, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 174
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->subView:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-virtual {v1}, Lcom/riola/player/Program;->summary()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 175
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->totalBadge:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v1, v1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "empty"

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-virtual {v1}, Lcom/riola/player/Program;->estMs()J

    move-result-wide v1

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 177
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->loopBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 178
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget v0, v0, Lcom/riola/player/Program;->loops:I

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-gez v0, :cond_2

    move v0, v1

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget v0, v0, Lcom/riola/player/Program;->loops:I

    if-gt v0, v3, :cond_3

    move v0, v2

    goto :goto_1

    :cond_3
    move v0, v3

    .line 179
    :goto_1
    iget-object v4, p0, Lcom/riola/player/EditorActivity;->loopBox:Landroid/widget/LinearLayout;

    const-string v5, "A few times"

    const-string v6, "Forever"

    const-string v7, "Once"

    filled-new-array {v7, v5, v6}, [Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/riola/player/EditorActivity$7;

    invoke-direct {v6, p0}, Lcom/riola/player/EditorActivity$7;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-static {p0, v5, v0, v6}, Lcom/riola/player/Ui;->seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 186
    if-ne v0, v3, :cond_4

    .line 187
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 188
    const/4 v8, 0x0

    const/high16 v9, 0x41000000    # 8.0f

    const/4 v10, 0x0

    const/4 v11, 0x0

    move-object v6, p0

    move-object v7, v0

    invoke-static/range {v6 .. v11}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 189
    const/high16 v3, 0x41580000    # 13.5f

    sget v4, Lcom/riola/player/Ui;->DIM:I

    const-string v5, "Run the whole list"

    invoke-static {p0, v5, v3, v4, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    .line 190
    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v5, -0x2

    invoke-static {v2, v5, v4}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 191
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 192
    iget-object v3, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget v3, v3, Lcom/riola/player/Program;->loops:I

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v7

    const/4 v8, 0x2

    const/16 v9, 0x63

    const/4 v10, 0x1

    const-string v11, "x"

    new-instance v12, Lcom/riola/player/EditorActivity$8;

    invoke-direct {v12, p0}, Lcom/riola/player/EditorActivity$8;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-static/range {v6 .. v12}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 200
    const/high16 v3, 0x43200000    # 160.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {v3, v5}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 201
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 202
    iget-object v1, p0, Lcom/riola/player/EditorActivity;->loopBox:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 205
    :cond_4
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->stepsBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 206
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 207
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->stepsBox:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->undoBar()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 208
    :cond_5
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 209
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->stepsBox:Landroid/widget/LinearLayout;

    const-string v1, "No steps yet"

    const-string v2, "Add a whole track, a section of a track, or a stretch of silence."

    const/16 v3, 0x15

    invoke-static {p0, v3, v1, v2}, Lcom/riola/player/Ui;->emptyState(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3

    .line 212
    :cond_6
    nop

    :goto_2
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_7

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->stepsBox:Landroid/widget/LinearLayout;

    invoke-direct {p0, v2}, Lcom/riola/player/EditorActivity;->stepRow(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 214
    :cond_7
    :goto_3
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->bar:Lcom/riola/player/PlayerBar;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->eng:Lcom/riola/player/Engine;

    iget-object v1, v1, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v0, v1}, Lcom/riola/player/PlayerBar;->render(Lcom/riola/player/Engine$St;)V

    .line 215
    return-void
.end method

.method private removeStep(I)V
    .locals 3

    .line 260
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/riola/player/Step;

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    .line 261
    iput p1, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    .line 262
    const/16 p1, 0x14

    iput p1, p0, Lcom/riola/player/EditorActivity;->undoLeft:I

    .line 263
    iget-object p1, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->undoTick:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 264
    iget-object p1, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->undoTick:Ljava/lang/Runnable;

    const-wide/16 v1, 0x3e8

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 265
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->save()V

    .line 266
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 267
    return-void
.end method

.method private rename()V
    .locals 4

    .line 440
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    new-instance v1, Lcom/riola/player/EditorActivity$18;

    invoke-direct {v1, p0}, Lcom/riola/player/EditorActivity$18;-><init>(Lcom/riola/player/EditorActivity;)V

    const-string v2, "Rename program"

    const-string v3, "name"

    invoke-static {p0, v2, v0, v3, v1}, Lcom/riola/player/Pickers;->text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V

    .line 443
    return-void
.end method

.method private restoreStep()V
    .locals 4

    .line 243
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->undoTick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 244
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    .line 245
    iget v1, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    .line 246
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    .line 247
    const/4 v2, -0x1

    iput v2, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    .line 248
    if-eqz v0, :cond_1

    iget-object v2, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-nez v2, :cond_0

    goto :goto_0

    .line 253
    :cond_0
    iget-object v2, v2, Lcom/riola/player/Program;->steps:Ljava/util/List;

    iget-object v3, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v3, v3, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/4 v3, 0x0

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-interface {v2, v1, v0}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 254
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->save()V

    .line 255
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 256
    const-string v0, "Step restored"

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 257
    return-void

    .line 249
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 250
    const-string v0, "Too late to undo"

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 251
    return-void
.end method

.method private run(I)V
    .locals 2

    .line 473
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-virtual {v0}, Lcom/riola/player/Program;->enabledCount()I

    move-result v0

    if-nez v0, :cond_0

    const-string p1, "Add a step first"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    .line 474
    :cond_0
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->save()V

    .line 475
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    new-instance v1, Lcom/riola/player/EditorActivity$20;

    invoke-direct {v1, p0}, Lcom/riola/player/EditorActivity$20;-><init>(Lcom/riola/player/EditorActivity;)V

    invoke-static {p0, v0, p1, v1}, Lcom/riola/player/Runner;->play(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    .line 478
    return-void
.end method

.method private save()V
    .locals 2

    .line 481
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-nez v0, :cond_0

    return-void

    .line 482
    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/riola/player/EditorActivity;->dirty:Z

    .line 483
    invoke-static {p0, v0}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 484
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/riola/player/EditorActivity;->dirty:Z

    .line 485
    return-void
.end method

.method private scrollToRow(Landroid/view/View;)V
    .locals 2

    .line 156
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->scroller:Landroid/widget/ScrollView;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    .line 157
    :cond_0
    new-instance v1, Lcom/riola/player/EditorActivity$6;

    invoke-direct {v1, p0, p1}, Lcom/riola/player/EditorActivity$6;-><init>(Lcom/riola/player/EditorActivity;Landroid/view/View;)V

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    .line 169
    return-void

    .line 156
    :cond_1
    :goto_0
    return-void
.end method

.method private stepMenu(I)V
    .locals 4

    .line 410
    if-ltz p1, :cond_2

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    goto :goto_1

    .line 411
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/riola/player/Step;

    .line 412
    const/16 v1, 0x8

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "Edit"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "Play from here"

    aput-object v3, v1, v2

    iget-boolean v2, v0, Lcom/riola/player/Step;->enabled:Z

    if-eqz v2, :cond_1

    const-string v2, "Turn off"

    goto :goto_0

    :cond_1
    const-string v2, "Turn on"

    :goto_0
    const/4 v3, 0x2

    aput-object v2, v1, v3

    const/4 v2, 0x3

    const-string v3, "Insert a step below"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "Duplicate"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "Move up"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "Move down"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "Delete"

    aput-object v3, v1, v2

    .line 414
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v0}, Lcom/riola/player/Step;->title()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Lcom/riola/player/EditorActivity$17;

    invoke-direct {v3, p0, p1, v0}, Lcom/riola/player/EditorActivity$17;-><init>(Lcom/riola/player/EditorActivity;ILcom/riola/player/Step;)V

    invoke-virtual {v2, v1, v3}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 427
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 428
    return-void

    .line 410
    :cond_2
    :goto_1
    return-void
.end method

.method private stepRow(I)Landroid/view/View;
    .locals 12

    .line 270
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lcom/riola/player/Step;

    .line 271
    iget-boolean v7, v6, Lcom/riola/player/Step;->enabled:Z

    .line 272
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->eng:Lcom/riola/player/Engine;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-virtual {v0, v1}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result v0

    const/4 v8, 0x0

    const/4 v9, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->eng:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v0, v0, Lcom/riola/player/Engine$St;->step:I

    if-ne v0, p1, :cond_0

    move v0, v9

    goto :goto_0

    :cond_0
    move v0, v8

    .line 274
    :goto_0
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v10

    .line 275
    if-eqz v0, :cond_1

    sget v0, Lcom/riola/player/Ui;->ACC_SOFT:I

    sget v1, Lcom/riola/player/Ui;->ACC_TXT:I

    sget v2, Lcom/riola/player/Ui;->RAD_CARD:F

    const v3, 0x3fb33333    # 1.4f

    invoke-static {p0, v0, v1, v2, v3}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1

    .line 276
    :cond_1
    sget v0, Lcom/riola/player/Ui;->SURF2:I

    sget v1, Lcom/riola/player/Ui;->RAD_CARD:F

    invoke-static {p0, v0, v1}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v0}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 275
    :goto_1
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 277
    const/high16 v11, 0x41000000    # 8.0f

    invoke-static {p0, v11}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v1, 0x41100000    # 9.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v3, 0x40000000    # 2.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {v10, v0, v2, v3, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 278
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/high16 v5, 0x41000000    # 8.0f

    move-object v0, p0

    move-object v1, v10

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 279
    new-instance v0, Lcom/riola/player/EditorActivity$10;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/EditorActivity$10;-><init>(Lcom/riola/player/EditorActivity;I)V

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 287
    new-instance v0, Lcom/riola/player/EditorActivity$11;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/EditorActivity$11;-><init>(Lcom/riola/player/EditorActivity;I)V

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 291
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 292
    const/high16 v1, 0x41e00000    # 28.0f

    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/4 v3, -0x2

    invoke-static {v2, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 293
    add-int/lit8 v2, p1, 0x1

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    if-eqz v7, :cond_2

    sget v4, Lcom/riola/player/Ui;->DIM:I

    goto :goto_2

    :cond_2
    sget v4, Lcom/riola/player/Ui;->LINE:I

    :goto_2
    const/high16 v5, 0x41400000    # 12.0f

    invoke-static {p0, v2, v5, v4, v9}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 294
    const/16 v4, 0x11

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 295
    const/4 v4, -0x1

    invoke-static {v4, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 296
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 297
    invoke-static {v6}, Lcom/riola/player/MainActivity;->stepIcon(Lcom/riola/player/Step;)I

    move-result v2

    if-eqz v7, :cond_3

    sget v4, Lcom/riola/player/Ui;->ACC:I

    goto :goto_3

    :cond_3
    sget v4, Lcom/riola/player/Ui;->LINE:I

    :goto_3
    const/16 v5, 0xf

    invoke-static {p0, v2, v4, v5}, Lcom/riola/player/Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v2

    .line 298
    invoke-static {p0, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v4, 0x41900000    # 18.0f

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {v1, v4}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 299
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 300
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 301
    invoke-static {p0, v11}, Lcom/riola/player/Ui;->hgap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 303
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 304
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v8, v3, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 305
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 306
    invoke-virtual {v6}, Lcom/riola/player/Step;->title()Ljava/lang/String;

    move-result-object v4

    if-eqz v7, :cond_4

    sget v5, Lcom/riola/player/Ui;->TXT:I

    goto :goto_4

    :cond_4
    sget v5, Lcom/riola/player/Ui;->DIM:I

    :goto_4
    const/high16 v11, 0x41680000    # 14.5f

    invoke-static {p0, v4, v11, v5, v9}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 307
    invoke-static {v4}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 308
    invoke-static {v8, v3, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 309
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 310
    if-nez v7, :cond_5

    sget v1, Lcom/riola/player/Ui;->DIM:I

    sget v4, Lcom/riola/player/Ui;->SURF:I

    const-string v5, "OFF"

    invoke-static {p0, v5, v1, v4}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_5

    .line 311
    :cond_5
    invoke-virtual {v6}, Lcom/riola/player/Step;->missing()Z

    move-result v1

    if-eqz v1, :cond_6

    sget v1, Lcom/riola/player/Ui;->ONACC:I

    sget v4, Lcom/riola/player/Ui;->AMBER:I

    const-string v5, "MISSING"

    invoke-static {p0, v5, v1, v4}, Lcom/riola/player/Ui;->badge(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 312
    :cond_6
    :goto_5
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 313
    invoke-virtual {v6}, Lcom/riola/player/Step;->detail()Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41380000    # 11.5f

    sget v4, Lcom/riola/player/Ui;->DIM:I

    invoke-static {p0, v1, v2, v4, v8}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 314
    invoke-static {v1}, Lcom/riola/player/Ui;->ellipsize(Landroid/widget/TextView;)V

    .line 315
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 316
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 319
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 320
    invoke-static {v3, v3}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 321
    const/16 v1, 0x12

    if-nez p1, :cond_7

    sget v0, Lcom/riola/player/Ui;->LINE:I

    goto :goto_6

    :cond_7
    sget v0, Lcom/riola/player/Ui;->DIM:I

    :goto_6
    move v2, v0

    const/16 v3, 0xe

    const/4 v4, 0x6

    const-string v5, "Move up"

    new-instance v6, Lcom/riola/player/EditorActivity$12;

    invoke-direct {v6, p0, p1}, Lcom/riola/player/EditorActivity$12;-><init>(Lcom/riola/player/EditorActivity;I)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 325
    const/16 v1, 0x13

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    sub-int/2addr v0, v9

    if-ne p1, v0, :cond_8

    sget v0, Lcom/riola/player/Ui;->LINE:I

    goto :goto_7

    :cond_8
    sget v0, Lcom/riola/player/Ui;->DIM:I

    :goto_7
    move v2, v0

    const/16 v3, 0xe

    const/4 v4, 0x6

    const-string v5, "Move down"

    new-instance v6, Lcom/riola/player/EditorActivity$13;

    invoke-direct {v6, p0, p1}, Lcom/riola/player/EditorActivity$13;-><init>(Lcom/riola/player/EditorActivity;I)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 329
    invoke-virtual {v10, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 331
    const/16 v1, 0x19

    sget v2, Lcom/riola/player/Ui;->DIM:I

    const/16 v3, 0x10

    const-string v4, "Step options"

    new-instance v5, Lcom/riola/player/EditorActivity$14;

    invoke-direct {v5, p0, p1}, Lcom/riola/player/EditorActivity$14;-><init>(Lcom/riola/player/EditorActivity;I)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->iconBtn(Landroid/content/Context;IIILjava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 334
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    invoke-interface {v0, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 335
    return-object v10
.end method

.method private undoBar()Landroid/view/View;
    .locals 9

    .line 219
    new-instance v0, Lcom/riola/player/EditorActivity$9;

    invoke-direct {v0, p0}, Lcom/riola/player/EditorActivity$9;-><init>(Lcom/riola/player/EditorActivity;)V

    .line 225
    invoke-static {p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 226
    sget v1, Lcom/riola/player/Ui;->SURF2:I

    sget v2, Lcom/riola/player/Ui;->AMBER:I

    const/high16 v3, 0x41400000    # 12.0f

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-static {p0, v1, v2, v3, v8}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-static {v1}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v7, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 227
    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v4, 0x41000000    # 8.0f

    invoke-static {p0, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v7, v1, v2, v4, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 228
    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/high16 v6, 0x41000000    # 8.0f

    move-object v1, p0

    move-object v2, v7

    invoke-static/range {v1 .. v6}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 231
    const/4 v1, 0x1

    invoke-virtual {v7, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 232
    const-string v2, "Undo removing the step"

    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 233
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 234
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Step removed  .  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/riola/player/EditorActivity;->undoLeft:I

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "s"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget v3, Lcom/riola/player/Ui;->TXT:I

    const/high16 v4, 0x41500000    # 13.0f

    const/4 v5, 0x0

    invoke-static {p0, v2, v4, v3, v5}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/riola/player/EditorActivity;->undoLabel:Landroid/widget/TextView;

    .line 235
    const/4 v3, -0x2

    invoke-static {v5, v3, v8}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 236
    iget-object v2, p0, Lcom/riola/player/EditorActivity;->undoLabel:Landroid/widget/TextView;

    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 237
    const-string v2, "Undo"

    const/16 v3, 0x22

    invoke-static {p0, v2, v3, v1, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 238
    return-object v7
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 489
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 490
    const/16 v0, 0x12d

    if-ne p1, v0, :cond_0

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    if-eqz p3, :cond_0

    .line 491
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->write(Landroid/app/Activity;Landroid/net/Uri;)V

    .line 493
    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 55
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->prefs:Lcom/riola/player/Prefs;

    .line 56
    invoke-static {v0}, Lcom/riola/player/Ui;->theme(Lcom/riola/player/Prefs;)V

    .line 57
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->dark()Z

    move-result v0

    invoke-static {v0}, Lcom/riola/player/Ui;->themeRes(Z)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/riola/player/EditorActivity;->setTheme(I)V

    .line 58
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 59
    invoke-static {p0}, Lcom/riola/player/Store;->load(Landroid/content/Context;)V

    .line 60
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/EditorActivity;->eng:Lcom/riola/player/Engine;

    .line 61
    invoke-virtual {p0}, Lcom/riola/player/EditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/riola/player/Store;->program(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    .line 62
    if-nez p1, :cond_0

    invoke-virtual {p0}, Lcom/riola/player/EditorActivity;->finish()V

    return-void

    .line 63
    :cond_0
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->build()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/EditorActivity;->setContentView(Landroid/view/View;)V

    .line 64
    invoke-static {p0}, Lcom/riola/player/Ui;->applyWindow(Landroid/app/Activity;)V

    .line 65
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 66
    return-void
.end method

.method public onEngineFinished(Z)V
    .locals 0

    .line 515
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    return-void
.end method

.method public onEngineState(Lcom/riola/player/Engine$St;)V
    .locals 9

    .line 499
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-nez v0, :cond_0

    return-void

    .line 500
    :cond_0
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->running:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iget-object v3, p1, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    move v0, v2

    .line 501
    :goto_0
    move v3, v2

    :goto_1
    iget-object v4, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 502
    if-eqz v0, :cond_2

    iget v4, p1, Lcom/riola/player/Engine$St;->step:I

    if-ne v4, v3, :cond_2

    move v4, v1

    goto :goto_2

    :cond_2
    move v4, v2

    .line 503
    :goto_2
    iget-object v5, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    invoke-interface {v5, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/view/View;

    if-eqz v4, :cond_3

    .line 504
    sget v4, Lcom/riola/player/Ui;->ACC_SOFT:I

    sget v6, Lcom/riola/player/Ui;->ACC_TXT:I

    sget v7, Lcom/riola/player/Ui;->RAD_CARD:F

    const v8, 0x3fb33333    # 1.4f

    invoke-static {p0, v4, v6, v7, v8}, Lcom/riola/player/Ui;->rrs(Landroid/content/Context;IIFF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    goto :goto_3

    .line 505
    :cond_3
    sget v4, Lcom/riola/player/Ui;->SURF2:I

    sget v6, Lcom/riola/player/Ui;->RAD_CARD:F

    invoke-static {p0, v4, v6}, Lcom/riola/player/Ui;->rr(Landroid/content/Context;IF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-static {v4}, Lcom/riola/player/Ui;->ripple(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    .line 503
    :goto_3
    invoke-virtual {v5, v4}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 501
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 507
    :cond_4
    if-eqz v0, :cond_5

    iget v1, p1, Lcom/riola/player/Engine$St;->step:I

    iget v2, p0, Lcom/riola/player/EditorActivity;->liveRow:I

    if-eq v1, v2, :cond_5

    .line 508
    iget v0, p1, Lcom/riola/player/Engine$St;->step:I

    iput v0, p0, Lcom/riola/player/EditorActivity;->liveRow:I

    .line 509
    iget v0, p1, Lcom/riola/player/Engine$St;->step:I

    if-ltz v0, :cond_6

    iget v0, p1, Lcom/riola/player/Engine$St;->step:I

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_6

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->rows:Ljava/util/List;

    iget p1, p1, Lcom/riola/player/Engine$St;->step:I

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    invoke-direct {p0, p1}, Lcom/riola/player/EditorActivity;->scrollToRow(Landroid/view/View;)V

    goto :goto_4

    .line 510
    :cond_5
    if-nez v0, :cond_6

    .line 511
    const/4 p1, -0x1

    iput p1, p0, Lcom/riola/player/EditorActivity;->liveRow:I

    .line 513
    :cond_6
    :goto_4
    return-void
.end method

.method protected onPause()V
    .locals 2

    .line 79
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->ui:Landroid/os/Handler;

    iget-object v1, p0, Lcom/riola/player/EditorActivity;->undoTick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 80
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/riola/player/EditorActivity;->undoStep:Lcom/riola/player/Step;

    .line 81
    const/4 v1, -0x1

    iput v1, p0, Lcom/riola/player/EditorActivity;->undoAt:I

    .line 82
    iput-object v0, p0, Lcom/riola/player/EditorActivity;->undoLabel:Landroid/widget/TextView;

    .line 83
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-eqz v0, :cond_0

    .line 84
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->detach()V

    .line 88
    iget-boolean v0, p0, Lcom/riola/player/EditorActivity;->dirty:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    invoke-static {p0, v0}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/riola/player/EditorActivity;->dirty:Z

    .line 90
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 91
    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 70
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 71
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prog:Lcom/riola/player/Program;

    if-nez v0, :cond_0

    return-void

    .line 72
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->bar:Lcom/riola/player/PlayerBar;

    invoke-virtual {v0}, Lcom/riola/player/PlayerBar;->attach()V

    .line 73
    iget-object v0, p0, Lcom/riola/player/EditorActivity;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->keepScreenOn()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/riola/player/EditorActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x80

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 74
    :cond_1
    invoke-direct {p0}, Lcom/riola/player/EditorActivity;->refresh()V

    .line 75
    return-void
.end method
