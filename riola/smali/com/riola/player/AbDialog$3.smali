.class Lcom/riola/player/AbDialog$3;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$play:Landroid/widget/ImageView;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>([ZLandroid/media/MediaPlayer;Landroid/widget/ImageView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 71
    iput-object p1, p0, Lcom/riola/player/AbDialog$3;->val$ready:[Z

    iput-object p2, p0, Lcom/riola/player/AbDialog$3;->val$mp:Landroid/media/MediaPlayer;

    iput-object p3, p0, Lcom/riola/player/AbDialog$3;->val$play:Landroid/widget/ImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 73
    iget-object v0, p0, Lcom/riola/player/AbDialog$3;->val$ready:[Z

    const/4 v1, 0x0

    aget-boolean v0, v0, v1

    if-nez v0, :cond_0

    return-void

    .line 74
    :cond_0
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 76
    :try_start_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$3;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result p1

    .line 77
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/riola/player/AbDialog$3;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/riola/player/AbDialog$3;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    .line 78
    :goto_0
    iget-object v0, p0, Lcom/riola/player/AbDialog$3;->val$play:Landroid/widget/ImageView;

    if-eqz p1, :cond_2

    const/4 v1, 0x1

    goto :goto_1

    :cond_2
    const/4 v1, 0x2

    :goto_1
    sget v2, Lcom/riola/player/Ui;->ONACC:I

    invoke-static {v0, v1, v2}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 79
    iget-object v0, p0, Lcom/riola/player/AbDialog$3;->val$play:Landroid/widget/ImageView;

    if-eqz p1, :cond_3

    const-string p1, "Play"

    goto :goto_2

    :cond_3
    const-string p1, "Pause"

    :goto_2
    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 80
    :catch_0
    move-exception p1

    :goto_3
    nop

    .line 81
    return-void
.end method
