.class Lcom/riola/player/AbDialog$9;
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

    .line 119
    iput-object p1, p0, Lcom/riola/player/AbDialog$9;->val$mp:Landroid/media/MediaPlayer;

    iput-object p2, p0, Lcom/riola/player/AbDialog$9;->val$ready:[Z

    iput-object p3, p0, Lcom/riola/player/AbDialog$9;->val$a:[J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .line 120
    iget-object p1, p0, Lcom/riola/player/AbDialog$9;->val$mp:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/riola/player/AbDialog$9;->val$ready:[Z

    iget-object v1, p0, Lcom/riola/player/AbDialog$9;->val$a:[J

    const/4 v2, 0x0

    aget-wide v2, v1, v2

    invoke-static {p1, v0, v2, v3}, Lcom/riola/player/AbDialog;->access$200(Landroid/media/MediaPlayer;[ZJ)V

    return-void
.end method
