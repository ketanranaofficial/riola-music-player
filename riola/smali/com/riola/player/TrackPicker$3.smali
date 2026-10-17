.class Lcom/riola/player/TrackPicker$3;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/TrackPicker;->show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$allowMultiple:Z

.field final synthetic val$cb:Lcom/riola/player/TrackPicker$OnPicked;

.field final synthetic val$choosing:[Z

.field final synthetic val$chosen:Ljava/util/Set;

.field final synthetic val$countLabel:Landroid/widget/TextView;

.field final synthetic val$fill:[Ljava/lang/Runnable;

.field final synthetic val$filter:[Ljava/lang/String;

.field final synthetic val$holder:[Landroid/app/AlertDialog;

.field final synthetic val$list:Landroid/widget/LinearLayout;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;


# direct methods
.method constructor <init>(Landroid/widget/LinearLayout;Lcom/riola/player/Prefs;[Ljava/lang/String;[ZLandroid/widget/TextView;Ljava/util/Set;ZLandroid/app/Activity;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 100
    iput-object p1, p0, Lcom/riola/player/TrackPicker$3;->val$list:Landroid/widget/LinearLayout;

    iput-object p2, p0, Lcom/riola/player/TrackPicker$3;->val$prefs:Lcom/riola/player/Prefs;

    iput-object p3, p0, Lcom/riola/player/TrackPicker$3;->val$filter:[Ljava/lang/String;

    iput-object p4, p0, Lcom/riola/player/TrackPicker$3;->val$choosing:[Z

    iput-object p5, p0, Lcom/riola/player/TrackPicker$3;->val$countLabel:Landroid/widget/TextView;

    iput-object p6, p0, Lcom/riola/player/TrackPicker$3;->val$chosen:Ljava/util/Set;

    iput-boolean p7, p0, Lcom/riola/player/TrackPicker$3;->val$allowMultiple:Z

    iput-object p8, p0, Lcom/riola/player/TrackPicker$3;->val$a:Landroid/app/Activity;

    iput-object p9, p0, Lcom/riola/player/TrackPicker$3;->val$holder:[Landroid/app/AlertDialog;

    iput-object p10, p0, Lcom/riola/player/TrackPicker$3;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    iput-object p11, p0, Lcom/riola/player/TrackPicker$3;->val$fill:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 12

    .line 102
    iget-object v0, p0, Lcom/riola/player/TrackPicker$3;->val$list:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 103
    iget-object v0, p0, Lcom/riola/player/TrackPicker$3;->val$prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->librarySort()I

    move-result v0

    iget-object v1, p0, Lcom/riola/player/TrackPicker$3;->val$filter:[Ljava/lang/String;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    invoke-static {v0, v1}, Lcom/riola/player/Store;->view(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 105
    sget-object v1, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    iget-object v3, p0, Lcom/riola/player/TrackPicker$3;->val$prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v3}, Lcom/riola/player/Prefs;->librarySort()I

    move-result v3

    sget-object v4, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    array-length v4, v4

    add-int/lit8 v4, v4, -0x1

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    aget-object v1, v1, v3

    .line 106
    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    .line 107
    iget-object v3, p0, Lcom/riola/player/TrackPicker$3;->val$choosing:[Z

    aget-boolean v3, v3, v2

    if-eqz v3, :cond_0

    .line 108
    iget-object v1, p0, Lcom/riola/player/TrackPicker$3;->val$countLabel:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/riola/player/TrackPicker$3;->val$chosen:Ljava/util/Set;

    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " selected  .  tap to add or remove"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 109
    :cond_0
    iget-boolean v3, p0, Lcom/riola/player/TrackPicker$3;->val$allowMultiple:Z

    const-string v4, "  .  "

    const-string v5, " of "

    if-eqz v3, :cond_1

    .line 110
    iget-object v3, p0, Lcom/riola/player/TrackPicker$3;->val$countLabel:Landroid/widget/TextView;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v6}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "  .  hold a row to pick several"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 113
    :cond_1
    iget-object v3, p0, Lcom/riola/player/TrackPicker$3;->val$countLabel:Landroid/widget/TextView;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v6}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 116
    :goto_0
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 117
    iget-object v0, p0, Lcom/riola/player/TrackPicker$3;->val$list:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/riola/player/TrackPicker$3;->val$a:Landroid/app/Activity;

    const/high16 v3, 0x41500000    # 13.0f

    sget v4, Lcom/riola/player/Ui;->DIM:I

    const-string v5, "Nothing matches that."

    invoke-static {v1, v5, v3, v4, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    return-void

    .line 120
    :cond_2
    move v1, v2

    :goto_1
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-ge v1, v3, :cond_3

    .line 121
    iget-object v3, p0, Lcom/riola/player/TrackPicker$3;->val$list:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/riola/player/TrackPicker$3;->val$a:Landroid/app/Activity;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/riola/player/Track;

    iget-boolean v6, p0, Lcom/riola/player/TrackPicker$3;->val$allowMultiple:Z

    iget-object v7, p0, Lcom/riola/player/TrackPicker$3;->val$choosing:[Z

    iget-object v8, p0, Lcom/riola/player/TrackPicker$3;->val$chosen:Ljava/util/Set;

    iget-object v9, p0, Lcom/riola/player/TrackPicker$3;->val$holder:[Landroid/app/AlertDialog;

    iget-object v10, p0, Lcom/riola/player/TrackPicker$3;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    iget-object v11, p0, Lcom/riola/player/TrackPicker$3;->val$fill:[Ljava/lang/Runnable;

    aget-object v11, v11, v2

    invoke-static/range {v4 .. v11}, Lcom/riola/player/TrackPicker;->access$000(Landroid/app/Activity;Lcom/riola/player/Track;Z[ZLjava/util/Set;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;Ljava/lang/Runnable;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 120
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 123
    :cond_3
    return-void
.end method
