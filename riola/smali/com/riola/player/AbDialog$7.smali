.class Lcom/riola/player/AbDialog$7;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Lcom/riola/player/AbDialog$Nudge;


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

.field final synthetic val$bTv:Landroid/widget/TextView;

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>([JLandroid/media/MediaPlayer;[Z[JLandroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 106
    iput-object p1, p0, Lcom/riola/player/AbDialog$7;->val$b:[J

    iput-object p2, p0, Lcom/riola/player/AbDialog$7;->val$mp:Landroid/media/MediaPlayer;

    iput-object p3, p0, Lcom/riola/player/AbDialog$7;->val$ready:[Z

    iput-object p4, p0, Lcom/riola/player/AbDialog$7;->val$a:[J

    iput-object p5, p0, Lcom/riola/player/AbDialog$7;->val$bTv:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public by(I)V
    .locals 9

    .line 108
    iget-object v0, p0, Lcom/riola/player/AbDialog$7;->val$b:[J

    const/4 v1, 0x0

    aget-wide v2, v0, v1

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-gez v2, :cond_0

    iget-object v2, p0, Lcom/riola/player/AbDialog$7;->val$mp:Landroid/media/MediaPlayer;

    iget-object v3, p0, Lcom/riola/player/AbDialog$7;->val$ready:[Z

    invoke-static {v2, v3}, Lcom/riola/player/AbDialog;->access$100(Landroid/media/MediaPlayer;[Z)I

    move-result v2

    int-to-long v2, v2

    aput-wide v2, v0, v1

    .line 109
    :cond_0
    iget-object v0, p0, Lcom/riola/player/AbDialog$7;->val$b:[J

    iget-object v2, p0, Lcom/riola/player/AbDialog$7;->val$a:[J

    aget-wide v3, v2, v1

    const-wide/16 v5, 0x3e8

    add-long/2addr v3, v5

    aget-wide v5, v0, v1

    int-to-long v7, p1

    add-long/2addr v5, v7

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 110
    iget-object p1, p0, Lcom/riola/player/AbDialog$7;->val$bTv:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "B   "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/riola/player/AbDialog$7;->val$b:[J

    aget-wide v1, v2, v1

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 111
    return-void
.end method
