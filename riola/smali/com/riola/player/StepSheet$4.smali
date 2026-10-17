.class Lcom/riola/player/StepSheet$4;
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
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$again:Ljava/lang/Runnable;

.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 63
    iput-object p1, p0, Lcom/riola/player/StepSheet$4;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/StepSheet$4;->val$step:Lcom/riola/player/Step;

    iput-object p3, p0, Lcom/riola/player/StepSheet$4;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 65
    iget-object p1, p0, Lcom/riola/player/StepSheet$4;->val$a:Landroid/app/Activity;

    new-instance v0, Lcom/riola/player/StepSheet$4$1;

    invoke-direct {v0, p0}, Lcom/riola/player/StepSheet$4$1;-><init>(Lcom/riola/player/StepSheet$4;)V

    const-string v1, "Which track?"

    invoke-static {p1, v1, v0}, Lcom/riola/player/Pickers;->track(Landroid/app/Activity;Ljava/lang/String;Lcom/riola/player/Pickers$OnTrack;)V

    .line 74
    return-void
.end method
