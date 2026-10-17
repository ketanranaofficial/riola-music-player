.class Lcom/riola/player/StepSheet$17$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnMs;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet$17;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/StepSheet$17;


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$17;)V
    .locals 0

    .line 235
    iput-object p1, p0, Lcom/riola/player/StepSheet$17$1;->this$0:Lcom/riola/player/StepSheet$17;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(J)V
    .locals 3

    .line 236
    iget-object v0, p0, Lcom/riola/player/StepSheet$17$1;->this$0:Lcom/riola/player/StepSheet$17;

    iget-object v0, v0, Lcom/riola/player/StepSheet$17;->val$step:Lcom/riola/player/Step;

    const-wide/16 v1, 0x1388

    invoke-static {v1, v2, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    iput-wide p1, v0, Lcom/riola/player/Step;->durMs:J

    iget-object p1, p0, Lcom/riola/player/StepSheet$17$1;->this$0:Lcom/riola/player/StepSheet$17;

    iget-object p1, p1, Lcom/riola/player/StepSheet$17;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void
.end method
