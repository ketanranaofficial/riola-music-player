.class Lcom/riola/player/AbDialog$6;
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

.field final synthetic val$act:Landroid/app/Activity;

.field final synthetic val$b:[J

.field final synthetic val$bTv:Landroid/widget/TextView;

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>(Landroid/media/MediaPlayer;[Z[JLandroid/app/Activity;[JLandroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 99
    iput-object p1, p0, Lcom/riola/player/AbDialog$6;->val$mp:Landroid/media/MediaPlayer;

    iput-object p2, p0, Lcom/riola/player/AbDialog$6;->val$ready:[Z

    iput-object p3, p0, Lcom/riola/player/AbDialog$6;->val$a:[J

    iput-object p4, p0, Lcom/riola/player/AbDialog$6;->val$act:Landroid/app/Activity;

    iput-object p5, p0, Lcom/riola/player/AbDialog$6;->val$b:[J

    iput-object p6, p0, Lcom/riola/player/AbDialog$6;->val$bTv:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .line 101
    iget-object p1, p0, Lcom/riola/player/AbDialog$6;->val$mp:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/riola/player/AbDialog$6;->val$ready:[Z

    invoke-static {p1, v0}, Lcom/riola/player/AbDialog;->access$100(Landroid/media/MediaPlayer;[Z)I

    move-result p1

    int-to-long v0, p1

    .line 102
    iget-object p1, p0, Lcom/riola/player/AbDialog$6;->val$a:[J

    const/4 v2, 0x0

    aget-wide v3, p1, v2

    cmp-long p1, v0, v3

    if-gtz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/AbDialog$6;->val$act:Landroid/app/Activity;

    const-string v0, "B has to come after A"

    invoke-static {p1, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    .line 103
    :cond_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$6;->val$b:[J

    aput-wide v0, p1, v2

    .line 104
    iget-object p1, p0, Lcom/riola/player/AbDialog$6;->val$bTv:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "B   "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/AbDialog$6;->val$b:[J

    aget-wide v2, v1, v2

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 105
    return-void
.end method
