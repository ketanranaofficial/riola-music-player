.class Lcom/riola/player/Ui$5;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

.field final synthetic val$hasNormal:Z

.field final synthetic val$min:I

.field final synthetic val$normal:I

.field final synthetic val$reset:Landroid/widget/ImageView;

.field final synthetic val$unit:Ljava/lang/String;

.field final synthetic val$val:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/widget/TextView;ILjava/lang/String;ZLandroid/widget/ImageView;ILcom/riola/player/Ui$OnSlide;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 674
    iput-object p1, p0, Lcom/riola/player/Ui$5;->val$val:Landroid/widget/TextView;

    iput p2, p0, Lcom/riola/player/Ui$5;->val$min:I

    iput-object p3, p0, Lcom/riola/player/Ui$5;->val$unit:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/riola/player/Ui$5;->val$hasNormal:Z

    iput-object p5, p0, Lcom/riola/player/Ui$5;->val$reset:Landroid/widget/ImageView;

    iput p6, p0, Lcom/riola/player/Ui$5;->val$normal:I

    iput-object p7, p0, Lcom/riola/player/Ui$5;->val$cb:Lcom/riola/player/Ui$OnSlide;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    .line 676
    iget-object p1, p0, Lcom/riola/player/Ui$5;->val$val:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    iget v0, p0, Lcom/riola/player/Ui$5;->val$min:I

    add-int/2addr v0, p2

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p3

    iget-object v0, p0, Lcom/riola/player/Ui$5;->val$unit:Ljava/lang/String;

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 677
    iget-boolean p1, p0, Lcom/riola/player/Ui$5;->val$hasNormal:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/Ui$5;->val$reset:Landroid/widget/ImageView;

    iget p3, p0, Lcom/riola/player/Ui$5;->val$min:I

    add-int/2addr p3, p2

    iget p2, p0, Lcom/riola/player/Ui$5;->val$normal:I

    if-ne p3, p2, :cond_0

    const/4 p2, 0x4

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 678
    :cond_1
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 679
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 2

    .line 680
    iget-object v0, p0, Lcom/riola/player/Ui$5;->val$cb:Lcom/riola/player/Ui$OnSlide;

    iget v1, p0, Lcom/riola/player/Ui$5;->val$min:I

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result p1

    add-int/2addr v1, p1

    invoke-interface {v0, v1}, Lcom/riola/player/Ui$OnSlide;->set(I)V

    return-void
.end method
