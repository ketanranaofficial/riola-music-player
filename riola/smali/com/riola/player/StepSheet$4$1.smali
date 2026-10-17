.class Lcom/riola/player/StepSheet$4$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnTrack;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet$4;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/StepSheet$4;


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$4;)V
    .locals 0

    .line 65
    iput-object p1, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Lcom/riola/player/Track;)V
    .locals 4

    .line 67
    iget-object v0, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    iget-object v0, v0, Lcom/riola/player/StepSheet$4;->val$step:Lcom/riola/player/Step;

    invoke-virtual {v0, p1}, Lcom/riola/player/Step;->bind(Lcom/riola/player/Track;)V

    .line 68
    iget-object v0, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    iget-object v0, v0, Lcom/riola/player/StepSheet$4;->val$step:Lcom/riola/player/Step;

    iget v0, v0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-wide v0, p1, Lcom/riola/player/Track;->durMs:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    iget-object v0, v0, Lcom/riola/player/StepSheet$4;->val$step:Lcom/riola/player/Step;

    iget-wide v0, v0, Lcom/riola/player/Step;->b:J

    iget-wide v2, p1, Lcom/riola/player/Track;->durMs:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 69
    iget-object v0, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    iget-object v0, v0, Lcom/riola/player/StepSheet$4;->val$step:Lcom/riola/player/Step;

    iget-wide v1, p1, Lcom/riola/player/Track;->durMs:J

    iput-wide v1, v0, Lcom/riola/player/Step;->b:J

    .line 71
    :cond_0
    iget-object p1, p0, Lcom/riola/player/StepSheet$4$1;->this$0:Lcom/riola/player/StepSheet$4;

    iget-object p1, p1, Lcom/riola/player/StepSheet$4;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 72
    return-void
.end method
