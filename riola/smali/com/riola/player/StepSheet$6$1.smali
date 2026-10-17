.class Lcom/riola/player/StepSheet$6$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnMs;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet$6;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/StepSheet$6;


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$6;)V
    .locals 0

    .line 102
    iput-object p1, p0, Lcom/riola/player/StepSheet$6$1;->this$0:Lcom/riola/player/StepSheet$6;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(J)V
    .locals 3

    .line 104
    iget-object v0, p0, Lcom/riola/player/StepSheet$6$1;->this$0:Lcom/riola/player/StepSheet$6;

    iget-object v0, v0, Lcom/riola/player/StepSheet$6;->val$step:Lcom/riola/player/Step;

    iget-object v1, p0, Lcom/riola/player/StepSheet$6$1;->this$0:Lcom/riola/player/StepSheet$6;

    iget-object v1, v1, Lcom/riola/player/StepSheet$6;->val$step:Lcom/riola/player/Step;

    iget-wide v1, v1, Lcom/riola/player/Step;->a:J

    cmp-long v1, p1, v1

    if-gtz v1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$6$1;->this$0:Lcom/riola/player/StepSheet$6;

    iget-object p1, p1, Lcom/riola/player/StepSheet$6;->val$step:Lcom/riola/player/Step;

    iget-wide p1, p1, Lcom/riola/player/Step;->a:J

    const-wide/16 v1, 0x3a98

    add-long/2addr p1, v1

    :cond_0
    iput-wide p1, v0, Lcom/riola/player/Step;->b:J

    .line 105
    iget-object p1, p0, Lcom/riola/player/StepSheet$6$1;->this$0:Lcom/riola/player/StepSheet$6;

    iget-object p1, p1, Lcom/riola/player/StepSheet$6;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 106
    return-void
.end method
