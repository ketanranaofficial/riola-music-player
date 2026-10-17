.class Lcom/riola/player/StepSheet$16;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Ui$OnPick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet;->fill(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$again:Ljava/lang/Runnable;

.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Lcom/riola/player/Step;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 224
    iput-object p1, p0, Lcom/riola/player/StepSheet$16;->val$step:Lcom/riola/player/Step;

    iput-object p2, p0, Lcom/riola/player/StepSheet$16;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 4

    .line 226
    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$16;->val$step:Lcom/riola/player/Step;

    const/4 v0, 0x1

    iput v0, p1, Lcom/riola/player/Step;->times:I

    goto :goto_0

    .line 227
    :cond_0
    iget-object p1, p0, Lcom/riola/player/StepSheet$16;->val$step:Lcom/riola/player/Step;

    const/4 v0, -0x1

    iput v0, p1, Lcom/riola/player/Step;->times:I

    iget-object p1, p0, Lcom/riola/player/StepSheet$16;->val$step:Lcom/riola/player/Step;

    iget-wide v0, p1, Lcom/riola/player/Step;->durMs:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-gtz p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/StepSheet$16;->val$step:Lcom/riola/player/Step;

    const-wide/32 v0, 0x927c0

    iput-wide v0, p1, Lcom/riola/player/Step;->durMs:J

    .line 228
    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/riola/player/StepSheet$16;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 229
    return-void
.end method
