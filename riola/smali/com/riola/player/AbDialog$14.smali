.class Lcom/riola/player/AbDialog$14;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$h:Landroid/os/Handler;

.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$tick:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Landroid/os/Handler;Ljava/lang/Runnable;Landroid/media/MediaPlayer;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 167
    iput-object p1, p0, Lcom/riola/player/AbDialog$14;->val$h:Landroid/os/Handler;

    iput-object p2, p0, Lcom/riola/player/AbDialog$14;->val$tick:Ljava/lang/Runnable;

    iput-object p3, p0, Lcom/riola/player/AbDialog$14;->val$mp:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    .line 169
    iget-object p1, p0, Lcom/riola/player/AbDialog$14;->val$h:Landroid/os/Handler;

    iget-object v0, p0, Lcom/riola/player/AbDialog$14;->val$tick:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 170
    :try_start_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$14;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->reset()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 171
    :goto_0
    :try_start_1
    iget-object p1, p0, Lcom/riola/player/AbDialog$14;->val$mp:Landroid/media/MediaPlayer;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception p1

    .line 172
    :goto_1
    return-void
.end method
