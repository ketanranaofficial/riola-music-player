.class Lcom/riola/player/StepSheet$12;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet;->fill(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Lcom/riola/player/Step;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 183
    iput-object p1, p0, Lcom/riola/player/StepSheet$12;->val$step:Lcom/riola/player/Step;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 184
    iget-object p1, p0, Lcom/riola/player/StepSheet$12;->val$step:Lcom/riola/player/Step;

    iget p1, p1, Lcom/riola/player/Step;->tone:I

    iget-object v0, p0, Lcom/riola/player/StepSheet$12;->val$step:Lcom/riola/player/Step;

    iget v0, v0, Lcom/riola/player/Step;->volumePct:I

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    invoke-static {p1, v0}, Lcom/riola/player/Bell;->preview(IF)V

    return-void
.end method
