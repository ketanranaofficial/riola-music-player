.class Lcom/riola/player/PlayerService$2;
.super Landroid/content/BroadcastReceiver;
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

    .line 78
    iput-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 80
    iget-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$200(Lcom/riola/player/PlayerService;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->pauseUnplug()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isPaused()Z

    move-result p1

    if-nez p1, :cond_0

    .line 81
    iget-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->setPaused(Z)V

    .line 82
    iget-object p1, p0, Lcom/riola/player/PlayerService$2;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    const-string p2, "output disconnected - paused"

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 84
    :cond_0
    return-void
.end method
