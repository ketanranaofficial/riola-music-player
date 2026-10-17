.class Lcom/riola/player/StepSheet$3;
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


# direct methods
.method constructor <init>(Lcom/riola/player/StepSheet$OnDone;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 44
    iput-object p1, p0, Lcom/riola/player/StepSheet$3;->val$cb:Lcom/riola/player/StepSheet$OnDone;

    iput p2, p0, Lcom/riola/player/StepSheet$3;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 45
    iget-object p1, p0, Lcom/riola/player/StepSheet$3;->val$cb:Lcom/riola/player/StepSheet$OnDone;

    iget p2, p0, Lcom/riola/player/StepSheet$3;->val$index:I

    invoke-interface {p1, p2}, Lcom/riola/player/StepSheet$OnDone;->deleted(I)V

    return-void
.end method
