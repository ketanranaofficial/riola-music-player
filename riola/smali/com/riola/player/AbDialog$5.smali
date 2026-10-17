.class Lcom/riola/player/AbDialog$5;
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

.field final synthetic val$aTv:Landroid/widget/TextView;

.field final synthetic val$b:[J


# direct methods
.method constructor <init>([J[JLandroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 91
    iput-object p1, p0, Lcom/riola/player/AbDialog$5;->val$a:[J

    iput-object p2, p0, Lcom/riola/player/AbDialog$5;->val$b:[J

    iput-object p3, p0, Lcom/riola/player/AbDialog$5;->val$aTv:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public by(I)V
    .locals 8

    .line 93
    iget-object v0, p0, Lcom/riola/player/AbDialog$5;->val$a:[J

    const/4 v1, 0x0

    aget-wide v2, v0, v1

    int-to-long v4, p1

    add-long/2addr v2, v4

    const-wide/16 v4, 0x0

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 94
    iget-object p1, p0, Lcom/riola/player/AbDialog$5;->val$b:[J

    aget-wide v2, p1, v1

    cmp-long p1, v2, v4

    if-ltz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/AbDialog$5;->val$a:[J

    aget-wide v6, p1, v1

    cmp-long v0, v6, v2

    if-ltz v0, :cond_0

    const-wide/16 v6, 0x3e8

    sub-long/2addr v2, v6

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    aput-wide v2, p1, v1

    .line 95
    :cond_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$5;->val$aTv:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "A   "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/riola/player/AbDialog$5;->val$a:[J

    aget-wide v1, v2, v1

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 96
    return-void
.end method
