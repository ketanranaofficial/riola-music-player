.class Lcom/riola/player/PlayerService$1;
.super Landroid/media/session/MediaSession$Callback;
.source "PlayerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/PlayerService;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/PlayerService;


# direct methods
.method constructor <init>(Lcom/riola/player/PlayerService;)V
    .locals 0

    .line 68
    iput-object p1, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-direct {p0}, Landroid/media/session/MediaSession$Callback;-><init>()V

    return-void
.end method


# virtual methods
.method public onPause()V
    .locals 2

    .line 70
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/riola/player/Engine;->setPaused(Z)V

    return-void
.end method

.method public onPlay()V
    .locals 2

    .line 69
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/riola/player/Engine;->setPaused(Z)V

    return-void
.end method

.method public onSeekTo(J)V
    .locals 1

    .line 74
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    long-to-int p1, p1

    invoke-virtual {v0, p1}, Lcom/riola/player/Engine;->seekTo(I)V

    return-void
.end method

.method public onSkipToNext()V
    .locals 1

    .line 72
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {v0}, Lcom/riola/player/Engine;->next()V

    return-void
.end method

.method public onSkipToPrevious()V
    .locals 1

    .line 73
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {v0}, Lcom/riola/player/Engine;->prev()V

    return-void
.end method

.method public onStop()V
    .locals 1

    .line 71
    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {v0}, Lcom/riola/player/Engine;->stop()V

    iget-object v0, p0, Lcom/riola/player/PlayerService$1;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {v0}, Lcom/riola/player/PlayerService;->access$100(Lcom/riola/player/PlayerService;)V

    return-void
.end method
