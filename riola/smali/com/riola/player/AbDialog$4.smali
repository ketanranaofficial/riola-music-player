.class Lcom/riola/player/AbDialog$4;
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
.field final synthetic val$a:[J

.field final synthetic val$aTv:Landroid/widget/TextView;

.field final synthetic val$b:[J

.field final synthetic val$bTv:Landroid/widget/TextView;

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>([JLandroid/media/MediaPlayer;[Z[JLandroid/widget/TextView;Landroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 84
    iput-object p1, p0, Lcom/riola/player/AbDialog$4;->val$a:[J

    iput-object p2, p0, Lcom/riola/player/AbDialog$4;->val$mp:Landroid/media/MediaPlayer;

    iput-object p3, p0, Lcom/riola/player/AbDialog$4;->val$ready:[Z

    iput-object p4, p0, Lcom/riola/player/AbDialog$4;->val$b:[J

    iput-object p5, p0, Lcom/riola/player/AbDialog$4;->val$aTv:Landroid/widget/TextView;

    iput-object p6, p0, Lcom/riola/player/AbDialog$4;->val$bTv:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 8

    .line 86
    iget-object p1, p0, Lcom/riola/player/AbDialog$4;->val$a:[J

    iget-object v0, p0, Lcom/riola/player/AbDialog$4;->val$mp:Landroid/media/MediaPlayer;

    iget-object v1, p0, Lcom/riola/player/AbDialog$4;->val$ready:[Z

    invoke-static {v0, v1}, Lcom/riola/player/AbDialog;->access$100(Landroid/media/MediaPlayer;[Z)I

    move-result v0

    int-to-long v0, v0

    const/4 v2, 0x0

    aput-wide v0, p1, v2

    .line 87
    iget-object p1, p0, Lcom/riola/player/AbDialog$4;->val$b:[J

    aget-wide v0, p1, v2

    const-wide/16 v3, 0x0

    cmp-long v5, v0, v3

    if-ltz v5, :cond_0

    iget-object v5, p0, Lcom/riola/player/AbDialog$4;->val$a:[J

    aget-wide v6, v5, v2

    cmp-long v0, v0, v6

    if-gtz v0, :cond_0

    const-wide/16 v0, -0x1

    aput-wide v0, p1, v2

    .line 88
    :cond_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$4;->val$aTv:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "A   "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/AbDialog$4;->val$a:[J

    aget-wide v5, v1, v2

    invoke-static {v5, v6}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 89
    iget-object p1, p0, Lcom/riola/player/AbDialog$4;->val$bTv:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "B   "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/AbDialog$4;->val$b:[J

    aget-wide v5, v1, v2

    cmp-long v1, v5, v3

    if-gez v1, :cond_1

    const-string v1, "end"

    goto :goto_0

    :cond_1
    invoke-static {v5, v6}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 90
    return-void
.end method
