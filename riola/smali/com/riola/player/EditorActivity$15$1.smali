.class Lcom/riola/player/EditorActivity$15$1;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/TrackPicker$OnPicked;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity$15;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/EditorActivity$15;

.field final synthetic val$section:Z


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity$15;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 361
    iput-object p1, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iput-boolean p2, p0, Lcom/riola/player/EditorActivity$15$1;->val$section:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/riola/player/Track;",
            ">;)V"
        }
    .end annotation

    .line 363
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 364
    :cond_0
    iget-boolean v0, p0, Lcom/riola/player/EditorActivity$15$1;->val$section:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 365
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/riola/player/Track;

    .line 366
    iget-wide v0, p1, Lcom/riola/player/Track;->durMs:J

    const-wide/32 v2, 0xafc8

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v0, 0x2710

    iget-wide v2, p1, Lcom/riola/player/Track;->durMs:J

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    .line 367
    :goto_0
    const-wide/16 v0, 0x4e20

    cmp-long v0, v2, v0

    if-lez v0, :cond_2

    const-wide/16 v0, 0x3a98

    goto :goto_1

    :cond_2
    const-wide/16 v0, 0x0

    .line 368
    :goto_1
    invoke-static {p1, v0, v1, v2, v3}, Lcom/riola/player/Step;->section(Lcom/riola/player/Track;JJ)Lcom/riola/player/Step;

    move-result-object p1

    .line 369
    const/4 v0, 0x4

    iput v0, p1, Lcom/riola/player/Step;->times:I

    .line 370
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    iget-object v1, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget v1, v1, Lcom/riola/player/EditorActivity$15;->val$at:I

    invoke-static {v0, p1, v1}, Lcom/riola/player/EditorActivity;->access$2000(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;I)I

    move-result p1

    .line 371
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    .line 372
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    .line 373
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0, p1}, Lcom/riola/player/EditorActivity;->access$1700(Lcom/riola/player/EditorActivity;I)V

    .line 374
    return-void

    .line 376
    :cond_3
    nop

    .line 377
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget v0, v0, Lcom/riola/player/EditorActivity$15;->val$at:I

    .line 378
    const/4 v2, -0x1

    :goto_2
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v1, v3, :cond_5

    .line 379
    iget-object v2, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v2, v2, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Track;

    invoke-static {v3}, Lcom/riola/player/Step;->play(Lcom/riola/player/Track;)Lcom/riola/player/Step;

    move-result-object v3

    invoke-static {v2, v3, v0}, Lcom/riola/player/EditorActivity;->access$2000(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;I)I

    move-result v2

    .line 380
    if-ltz v0, :cond_4

    add-int/lit8 v0, v2, 0x1

    .line 378
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 382
    :cond_5
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    .line 383
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    .line 384
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_6

    iget-object p1, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1, v2}, Lcom/riola/player/EditorActivity;->access$1700(Lcom/riola/player/EditorActivity;I)V

    goto :goto_3

    .line 385
    :cond_6
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15$1;->this$1:Lcom/riola/player/EditorActivity$15;

    iget-object v0, v0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " steps added"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 386
    :goto_3
    return-void
.end method
