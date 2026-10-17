.class Lcom/riola/player/Ui$4;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Ui$OnSlide;

.field final synthetic val$min:I

.field final synthetic val$normal:I

.field final synthetic val$reset:Landroid/widget/ImageView;

.field final synthetic val$s:Landroid/widget/SeekBar;

.field final synthetic val$unit:Ljava/lang/String;

.field final synthetic val$val:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/widget/SeekBar;IILandroid/widget/TextView;Ljava/lang/String;Landroid/widget/ImageView;Lcom/riola/player/Ui$OnSlide;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 656
    iput-object p1, p0, Lcom/riola/player/Ui$4;->val$s:Landroid/widget/SeekBar;

    iput p2, p0, Lcom/riola/player/Ui$4;->val$normal:I

    iput p3, p0, Lcom/riola/player/Ui$4;->val$min:I

    iput-object p4, p0, Lcom/riola/player/Ui$4;->val$val:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/riola/player/Ui$4;->val$unit:Ljava/lang/String;

    iput-object p6, p0, Lcom/riola/player/Ui$4;->val$reset:Landroid/widget/ImageView;

    iput-object p7, p0, Lcom/riola/player/Ui$4;->val$cb:Lcom/riola/player/Ui$OnSlide;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 658
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 659
    iget-object p1, p0, Lcom/riola/player/Ui$4;->val$s:Landroid/widget/SeekBar;

    iget v0, p0, Lcom/riola/player/Ui$4;->val$normal:I

    iget v1, p0, Lcom/riola/player/Ui$4;->val$min:I

    sub-int/2addr v0, v1

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 660
    iget-object p1, p0, Lcom/riola/player/Ui$4;->val$val:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p0, Lcom/riola/player/Ui$4;->val$normal:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/Ui$4;->val$unit:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 661
    iget-object p1, p0, Lcom/riola/player/Ui$4;->val$reset:Landroid/widget/ImageView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 662
    iget-object p1, p0, Lcom/riola/player/Ui$4;->val$cb:Lcom/riola/player/Ui$OnSlide;

    iget v0, p0, Lcom/riola/player/Ui$4;->val$normal:I

    invoke-interface {p1, v0}, Lcom/riola/player/Ui$OnSlide;->set(I)V

    .line 663
    return-void
.end method
