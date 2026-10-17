.class Lcom/riola/player/AbDialog$10;
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
.field final synthetic val$b:[J

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>(Landroid/media/MediaPlayer;[Z[J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 122
    iput-object p1, p0, Lcom/riola/player/AbDialog$10;->val$mp:Landroid/media/MediaPlayer;

    iput-object p2, p0, Lcom/riola/player/AbDialog$10;->val$ready:[Z

    iput-object p3, p0, Lcom/riola/player/AbDialog$10;->val$b:[J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 8

    .line 123
    iget-object p1, p0, Lcom/riola/player/AbDialog$10;->val$mp:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/riola/player/AbDialog$10;->val$ready:[Z

    iget-object v1, p0, Lcom/riola/player/AbDialog$10;->val$b:[J

    const/4 v2, 0x0

    aget-wide v2, v1, v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gez v1, :cond_0

    invoke-static {p1, v0}, Lcom/riola/player/AbDialog;->access$300(Landroid/media/MediaPlayer;[Z)I

    move-result v1

    int-to-long v2, v1

    :cond_0
    const-wide/16 v6, 0xbb8

    sub-long/2addr v2, v6

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v1

    invoke-static {p1, v0, v1, v2}, Lcom/riola/player/AbDialog;->access$200(Landroid/media/MediaPlayer;[ZJ)V

    return-void
.end method
