.class Lcom/riola/player/StepSheet$7;
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

.field final synthetic val$t:Lcom/riola/player/Track;


# direct methods
.method constructor <init>(Lcom/riola/player/Track;Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 114
    iput-object p1, p0, Lcom/riola/player/StepSheet$7;->val$t:Lcom/riola/player/Track;

    iput-object p2, p0, Lcom/riola/player/StepSheet$7;->val$a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/riola/player/StepSheet$7;->val$step:Lcom/riola/player/Step;

    iput-object p4, p0, Lcom/riola/player/StepSheet$7;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .line 116
    iget-object v1, p0, Lcom/riola/player/StepSheet$7;->val$t:Lcom/riola/player/Track;

    if-nez v1, :cond_0

    iget-object p1, p0, Lcom/riola/player/StepSheet$7;->val$a:Landroid/app/Activity;

    const-string v0, "Pick a track first"

    invoke-static {p1, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    .line 117
    :cond_0
    iget-object v0, p0, Lcom/riola/player/StepSheet$7;->val$a:Landroid/app/Activity;

    iget-object p1, p0, Lcom/riola/player/StepSheet$7;->val$step:Lcom/riola/player/Step;

    iget-wide v2, p1, Lcom/riola/player/Step;->a:J

    iget-object p1, p0, Lcom/riola/player/StepSheet$7;->val$step:Lcom/riola/player/Step;

    iget-wide v4, p1, Lcom/riola/player/Step;->b:J

    new-instance v6, Lcom/riola/player/StepSheet$7$1;

    invoke-direct {v6, p0}, Lcom/riola/player/StepSheet$7$1;-><init>(Lcom/riola/player/StepSheet$7;)V

    invoke-static/range {v0 .. v6}, Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V

    .line 124
    return-void
.end method
