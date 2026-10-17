.class Lcom/riola/player/AbDialog$15;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnPreparedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:[J

.field final synthetic val$bar:Landroid/widget/SeekBar;

.field final synthetic val$clock:Landroid/widget/TextView;

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>([ZLandroid/widget/SeekBar;Landroid/widget/TextView;Landroid/media/MediaPlayer;[J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 180
    iput-object p1, p0, Lcom/riola/player/AbDialog$15;->val$ready:[Z

    iput-object p2, p0, Lcom/riola/player/AbDialog$15;->val$bar:Landroid/widget/SeekBar;

    iput-object p3, p0, Lcom/riola/player/AbDialog$15;->val$clock:Landroid/widget/TextView;

    iput-object p4, p0, Lcom/riola/player/AbDialog$15;->val$mp:Landroid/media/MediaPlayer;

    iput-object p5, p0, Lcom/riola/player/AbDialog$15;->val$a:[J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 5

    .line 182
    iget-object v0, p0, Lcom/riola/player/AbDialog$15;->val$ready:[Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    aput-boolean v2, v0, v1

    .line 183
    iget-object v0, p0, Lcom/riola/player/AbDialog$15;->val$bar:Landroid/widget/SeekBar;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setMax(I)V

    .line 184
    iget-object v0, p0, Lcom/riola/player/AbDialog$15;->val$clock:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "0:00 / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getDuration()I

    move-result p1

    int-to-long v3, p1

    invoke-static {v3, v4}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 185
    iget-object p1, p0, Lcom/riola/player/AbDialog$15;->val$mp:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/riola/player/AbDialog$15;->val$ready:[Z

    iget-object v2, p0, Lcom/riola/player/AbDialog$15;->val$a:[J

    aget-wide v1, v2, v1

    invoke-static {p1, v0, v1, v2}, Lcom/riola/player/AbDialog;->access$200(Landroid/media/MediaPlayer;[ZJ)V

    .line 186
    return-void
.end method
