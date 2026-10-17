.class Lcom/riola/player/StepSheet$7$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/AbDialog$OnPick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet$7;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/StepSheet$7;


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$7;)V
    .locals 0

    .line 117
    iput-object p1, p0, Lcom/riola/player/StepSheet$7$1;->this$0:Lcom/riola/player/StepSheet$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(JJ)V
    .locals 1

    .line 119
    iget-object v0, p0, Lcom/riola/player/StepSheet$7$1;->this$0:Lcom/riola/player/StepSheet$7;

    iget-object v0, v0, Lcom/riola/player/StepSheet$7;->val$step:Lcom/riola/player/Step;

    iput-wide p1, v0, Lcom/riola/player/Step;->a:J

    .line 120
    iget-object p1, p0, Lcom/riola/player/StepSheet$7$1;->this$0:Lcom/riola/player/StepSheet$7;

    iget-object p1, p1, Lcom/riola/player/StepSheet$7;->val$step:Lcom/riola/player/Step;

    iput-wide p3, p1, Lcom/riola/player/Step;->b:J

    .line 121
    iget-object p1, p0, Lcom/riola/player/StepSheet$7$1;->this$0:Lcom/riola/player/StepSheet$7;

    iget-object p1, p1, Lcom/riola/player/StepSheet$7;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 122
    return-void
.end method
