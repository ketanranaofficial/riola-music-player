.class Lcom/riola/player/StepSheet$20;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Lcom/riola/player/Ui$OnSlide;


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

    .line 270
    iput-object p1, p0, Lcom/riola/player/StepSheet$20;->val$step:Lcom/riola/player/Step;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 1

    .line 271
    iget-object v0, p0, Lcom/riola/player/StepSheet$20;->val$step:Lcom/riola/player/Step;

    iput p1, v0, Lcom/riola/player/Step;->speedPct:I

    return-void
.end method
