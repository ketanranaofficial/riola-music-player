.class Lcom/riola/player/StepSheet$2;
.super Ljava/lang/Object;
.source "StepSheet.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/StepSheet;->show(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/StepSheet$OnDone;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/StepSheet$OnDone;

.field final synthetic val$index:I

.field final synthetic val$prog:Lcom/riola/player/Program;

.field final synthetic val$step:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Lcom/riola/player/Program;ILcom/riola/player/Step;Lcom/riola/player/StepSheet$OnDone;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 48
    iput-object p1, p0, Lcom/riola/player/StepSheet$2;->val$prog:Lcom/riola/player/Program;

    iput p2, p0, Lcom/riola/player/StepSheet$2;->val$index:I

    iput-object p3, p0, Lcom/riola/player/StepSheet$2;->val$step:Lcom/riola/player/Step;

    iput-object p4, p0, Lcom/riola/player/StepSheet$2;->val$cb:Lcom/riola/player/StepSheet$OnDone;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .line 50
    iget-object p1, p0, Lcom/riola/player/StepSheet$2;->val$prog:Lcom/riola/player/Program;

    iget-object p1, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    iget p2, p0, Lcom/riola/player/StepSheet$2;->val$index:I

    iget-object v0, p0, Lcom/riola/player/StepSheet$2;->val$step:Lcom/riola/player/Step;

    invoke-interface {p1, p2, v0}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 51
    iget-object p1, p0, Lcom/riola/player/StepSheet$2;->val$cb:Lcom/riola/player/StepSheet$OnDone;

    invoke-interface {p1}, Lcom/riola/player/StepSheet$OnDone;->changed()V

    .line 52
    return-void
.end method
