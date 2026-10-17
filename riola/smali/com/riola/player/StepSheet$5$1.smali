.class Lcom/riola/player/StepSheet$5$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnMs;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet$5;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/StepSheet$5;


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$5;)V
    .locals 0

    .line 87
    iput-object p1, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(J)V
    .locals 4

    .line 89
    iget-object v0, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object v0, v0, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iput-wide p1, v0, Lcom/riola/player/Step;->a:J

    .line 90
    iget-object p1, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object p1, p1, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-wide p1, p1, Lcom/riola/player/Step;->b:J

    const-wide/16 v0, 0x0

    cmp-long p1, p1, v0

    if-ltz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object p1, p1, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-wide p1, p1, Lcom/riola/player/Step;->b:J

    iget-object v0, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object v0, v0, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-wide v0, v0, Lcom/riola/player/Step;->a:J

    cmp-long p1, p1, v0

    if-gtz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object p1, p1, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-object p2, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object p2, p2, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-wide v0, p2, Lcom/riola/player/Step;->a:J

    const-wide/16 v2, 0x3a98

    add-long/2addr v0, v2

    iput-wide v0, p1, Lcom/riola/player/Step;->b:J

    .line 91
    :cond_0
    iget-object p1, p0, Lcom/riola/player/StepSheet$5$1;->this$0:Lcom/riola/player/StepSheet$5;

    iget-object p1, p1, Lcom/riola/player/StepSheet$5;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 92
    return-void
.end method
