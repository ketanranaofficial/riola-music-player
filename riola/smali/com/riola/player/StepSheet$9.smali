.class Lcom/riola/player/StepSheet$9;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Ui$OnToggle;


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

    .line 149
    iput-object p1, p0, Lcom/riola/player/StepSheet$9;->val$step:Lcom/riola/player/Step;

    iput-object p2, p0, Lcom/riola/player/StepSheet$9;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(Z)V
    .locals 1

    .line 151
    iget-object v0, p0, Lcom/riola/player/StepSheet$9;->val$step:Lcom/riola/player/Step;

    iput-boolean p1, v0, Lcom/riola/player/Step;->endBell:Z

    .line 152
    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$9;->val$step:Lcom/riola/player/Step;

    iget p1, p1, Lcom/riola/player/Step;->tone:I

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p1, v0}, Lcom/riola/player/Bell;->preview(IF)V

    .line 153
    :cond_0
    iget-object p1, p0, Lcom/riola/player/StepSheet$9;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 154
    return-void
.end method
