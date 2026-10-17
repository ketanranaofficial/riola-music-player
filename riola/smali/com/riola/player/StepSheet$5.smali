.class Lcom/riola/player/StepSheet$5;
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

.field final synthetic val$cap:J

.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Step;JLjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 85
    iput-object p1, p0, Lcom/riola/player/StepSheet$5;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iput-wide p3, p0, Lcom/riola/player/StepSheet$5;->val$cap:J

    iput-object p5, p0, Lcom/riola/player/StepSheet$5;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .line 87
    iget-object v0, p0, Lcom/riola/player/StepSheet$5;->val$a:Landroid/app/Activity;

    const-string v1, "Section starts at"

    iget-object p1, p0, Lcom/riola/player/StepSheet$5;->val$step:Lcom/riola/player/Step;

    iget-wide v2, p1, Lcom/riola/player/Step;->a:J

    iget-wide v4, p0, Lcom/riola/player/StepSheet$5;->val$cap:J

    new-instance v6, Lcom/riola/player/StepSheet$5$1;

    invoke-direct {v6, p0}, Lcom/riola/player/StepSheet$5$1;-><init>(Lcom/riola/player/StepSheet$5;)V

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Pickers;->position(Landroid/app/Activity;Ljava/lang/String;JJLcom/riola/player/Pickers$OnMs;)V

    .line 94
    return-void
.end method
