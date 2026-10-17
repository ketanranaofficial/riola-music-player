.class Lcom/riola/player/AbDialog$12;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


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

.field final synthetic val$b:[J

.field final synthetic val$bar:Landroid/widget/SeekBar;

.field final synthetic val$clock:Landroid/widget/TextView;

.field final synthetic val$h:Landroid/os/Handler;

.field final synthetic val$loopAb:[Z

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$play:Landroid/widget/ImageView;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>([ZLandroid/media/MediaPlayer;Landroid/widget/SeekBar;Landroid/widget/TextView;[Z[J[JLandroid/widget/ImageView;Landroid/os/Handler;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 142
    iput-object p1, p0, Lcom/riola/player/AbDialog$12;->val$ready:[Z

    iput-object p2, p0, Lcom/riola/player/AbDialog$12;->val$mp:Landroid/media/MediaPlayer;

    iput-object p3, p0, Lcom/riola/player/AbDialog$12;->val$bar:Landroid/widget/SeekBar;

    iput-object p4, p0, Lcom/riola/player/AbDialog$12;->val$clock:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/riola/player/AbDialog$12;->val$loopAb:[Z

    iput-object p6, p0, Lcom/riola/player/AbDialog$12;->val$b:[J

    iput-object p7, p0, Lcom/riola/player/AbDialog$12;->val$a:[J

    iput-object p8, p0, Lcom/riola/player/AbDialog$12;->val$play:Landroid/widget/ImageView;

    iput-object p9, p0, Lcom/riola/player/AbDialog$12;->val$h:Landroid/os/Handler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 144
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$ready:[Z

    const/4 v1, 0x0

    aget-boolean v2, v0, v1

    if-eqz v2, :cond_4

    .line 145
    iget-object v2, p0, Lcom/riola/player/AbDialog$12;->val$mp:Landroid/media/MediaPlayer;

    invoke-static {v2, v0}, Lcom/riola/player/AbDialog;->access$100(Landroid/media/MediaPlayer;[Z)I

    move-result v0

    .line 146
    iget-object v2, p0, Lcom/riola/player/AbDialog$12;->val$mp:Landroid/media/MediaPlayer;

    iget-object v3, p0, Lcom/riola/player/AbDialog$12;->val$ready:[Z

    invoke-static {v2, v3}, Lcom/riola/player/AbDialog;->access$300(Landroid/media/MediaPlayer;[Z)I

    move-result v2

    .line 147
    iget-object v3, p0, Lcom/riola/player/AbDialog$12;->val$bar:Landroid/widget/SeekBar;

    invoke-virtual {v3}, Landroid/widget/SeekBar;->isPressed()Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/riola/player/AbDialog$12;->val$bar:Landroid/widget/SeekBar;

    invoke-virtual {v3, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 148
    :cond_0
    iget-object v3, p0, Lcom/riola/player/AbDialog$12;->val$clock:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v5, v0

    invoke-static {v5, v6}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " / "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    int-to-long v7, v2

    invoke-static {v7, v8}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 149
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$loopAb:[Z

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$b:[J

    aget-wide v2, v0, v1

    const-wide/16 v7, 0x0

    cmp-long v0, v2, v7

    if-lez v0, :cond_1

    cmp-long v0, v5, v2

    if-ltz v0, :cond_1

    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$mp:Landroid/media/MediaPlayer;

    iget-object v2, p0, Lcom/riola/player/AbDialog$12;->val$ready:[Z

    iget-object v3, p0, Lcom/riola/player/AbDialog$12;->val$a:[J

    aget-wide v4, v3, v1

    invoke-static {v0, v2, v4, v5}, Lcom/riola/player/AbDialog;->access$200(Landroid/media/MediaPlayer;[ZJ)V

    .line 150
    :cond_1
    nop

    .line 151
    :try_start_0
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 152
    :goto_0
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$play:Landroid/widget/ImageView;

    if-eqz v1, :cond_2

    const/4 v2, 0x2

    goto :goto_1

    :cond_2
    const/4 v2, 0x1

    :goto_1
    sget v3, Lcom/riola/player/Ui;->ONACC:I

    invoke-static {v0, v2, v3}, Lcom/riola/player/Ui;->setIcon(Landroid/widget/ImageView;II)V

    .line 153
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$play:Landroid/widget/ImageView;

    if-eqz v1, :cond_3

    const-string v1, "Pause"

    goto :goto_2

    :cond_3
    const-string v1, "Play"

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 155
    :cond_4
    iget-object v0, p0, Lcom/riola/player/AbDialog$12;->val$h:Landroid/os/Handler;

    const-wide/16 v1, 0xc8

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 156
    return-void
.end method
