.class Lcom/riola/player/StepSheet$1;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet;->show(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/StepSheet$OnDone;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$content:Landroid/widget/LinearLayout;

.field final synthetic val$render:[Ljava/lang/Runnable;

.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 33
    iput-object p1, p0, Lcom/riola/player/StepSheet$1;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/StepSheet$1;->val$content:Landroid/widget/LinearLayout;

    iput-object p3, p0, Lcom/riola/player/StepSheet$1;->val$step:Lcom/riola/player/Step;

    iput-object p4, p0, Lcom/riola/player/StepSheet$1;->val$render:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 34
    iget-object v0, p0, Lcom/riola/player/StepSheet$1;->val$a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/riola/player/StepSheet$1;->val$content:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/riola/player/StepSheet$1;->val$step:Lcom/riola/player/Step;

    iget-object v3, p0, Lcom/riola/player/StepSheet$1;->val$render:[Ljava/lang/Runnable;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    invoke-static {v0, v1, v2, v3}, Lcom/riola/player/StepSheet;->access$000(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    return-void
.end method
