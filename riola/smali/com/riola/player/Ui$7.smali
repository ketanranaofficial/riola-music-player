.class Lcom/riola/player/Ui$7;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$by:I

.field final synthetic val$cb:Lcom/riola/player/Ui$OnValue;

.field final synthetic val$min:I

.field final synthetic val$unit:Ljava/lang/String;

.field final synthetic val$val:Landroid/widget/TextView;

.field final synthetic val$value:[I


# direct methods
.method constructor <init>([IIILandroid/widget/TextView;Ljava/lang/String;Lcom/riola/player/Ui$OnValue;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 721
    iput-object p1, p0, Lcom/riola/player/Ui$7;->val$value:[I

    iput p2, p0, Lcom/riola/player/Ui$7;->val$min:I

    iput p3, p0, Lcom/riola/player/Ui$7;->val$by:I

    iput-object p4, p0, Lcom/riola/player/Ui$7;->val$val:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/riola/player/Ui$7;->val$unit:Ljava/lang/String;

    iput-object p6, p0, Lcom/riola/player/Ui$7;->val$cb:Lcom/riola/player/Ui$OnValue;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .line 723
    iget-object v0, p0, Lcom/riola/player/Ui$7;->val$value:[I

    iget v1, p0, Lcom/riola/player/Ui$7;->val$min:I

    const/4 v2, 0x0

    aget v3, v0, v2

    iget v4, p0, Lcom/riola/player/Ui$7;->val$by:I

    sub-int/2addr v3, v4

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    aput v1, v0, v2

    .line 724
    iget-object v0, p0, Lcom/riola/player/Ui$7;->val$val:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/riola/player/Ui$7;->val$value:[I

    aget v3, v3, v2

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/riola/player/Ui$7;->val$unit:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 725
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 726
    iget-object p1, p0, Lcom/riola/player/Ui$7;->val$cb:Lcom/riola/player/Ui$OnValue;

    iget-object v0, p0, Lcom/riola/player/Ui$7;->val$value:[I

    aget v0, v0, v2

    invoke-interface {p1, v0}, Lcom/riola/player/Ui$OnValue;->set(I)V

    .line 727
    return-void
.end method
