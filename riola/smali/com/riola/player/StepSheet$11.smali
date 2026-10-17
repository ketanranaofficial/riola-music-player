.class Lcom/riola/player/StepSheet$11;
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

    .line 171
    iput-object p1, p0, Lcom/riola/player/StepSheet$11;->val$step:Lcom/riola/player/Step;

    iput-object p2, p0, Lcom/riola/player/StepSheet$11;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 2

    .line 173
    iget-object v0, p0, Lcom/riola/player/StepSheet$11;->val$step:Lcom/riola/player/Step;

    iput p1, v0, Lcom/riola/player/Step;->tone:I

    .line 174
    iget-object v0, p0, Lcom/riola/player/StepSheet$11;->val$step:Lcom/riola/player/Step;

    iget v0, v0, Lcom/riola/player/Step;->volumePct:I

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    invoke-static {p1, v0}, Lcom/riola/player/Bell;->preview(IF)V

    .line 175
    iget-object p1, p0, Lcom/riola/player/StepSheet$11;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 176
    return-void
.end method
