.class Lcom/riola/player/Themes$3;
.super Ljava/lang/Object;
.source "Themes.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Themes;->custom(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$hex:Landroid/widget/TextView;

.field final synthetic val$preview:Landroid/view/View;

.field final synthetic val$rgb:[I


# direct methods
.method constructor <init>([ILandroid/app/Activity;Landroid/view/View;Landroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 100
    iput-object p1, p0, Lcom/riola/player/Themes$3;->val$rgb:[I

    iput-object p2, p0, Lcom/riola/player/Themes$3;->val$a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/riola/player/Themes$3;->val$preview:Landroid/view/View;

    iput-object p4, p0, Lcom/riola/player/Themes$3;->val$hex:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 102
    iget-object v0, p0, Lcom/riola/player/Themes$3;->val$rgb:[I

    const/4 v1, 0x0

    aget v2, v0, v1

    shl-int/lit8 v2, v2, 0x10

    const/high16 v3, -0x1000000

    or-int/2addr v2, v3

    const/4 v3, 0x1

    aget v4, v0, v3

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v2, v4

    const/4 v4, 0x2

    aget v0, v0, v4

    or-int/2addr v0, v2

    .line 103
    new-instance v2, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v2}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 104
    invoke-virtual {v2, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 105
    iget-object v0, p0, Lcom/riola/player/Themes$3;->val$a:Landroid/app/Activity;

    sget v5, Lcom/riola/player/Ui;->RAD_BTN:F

    invoke-static {v0, v5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v2, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 106
    iget-object v0, p0, Lcom/riola/player/Themes$3;->val$a:Landroid/app/Activity;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v0, v5}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    sget v5, Lcom/riola/player/Ui;->LINE:I

    invoke-virtual {v2, v0, v5}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 107
    iget-object v0, p0, Lcom/riola/player/Themes$3;->val$preview:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 108
    iget-object v0, p0, Lcom/riola/player/Themes$3;->val$hex:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/riola/player/Themes$3;->val$rgb:[I

    aget v1, v2, v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lcom/riola/player/Themes$3;->val$rgb:[I

    aget v2, v2, v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-object v3, p0, Lcom/riola/player/Themes$3;->val$rgb:[I

    aget v3, v3, v4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "#%02X%02X%02X"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 109
    return-void
.end method
