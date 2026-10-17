.class Lcom/riola/player/NowPlayingActivity$7;
.super Ljava/lang/Object;
.source "NowPlayingActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/NowPlayingActivity;->build()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/NowPlayingActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/NowPlayingActivity;)V
    .locals 0

    .line 137
    iput-object p1, p0, Lcom/riola/player/NowPlayingActivity$7;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 139
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 140
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$7;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-static {p1}, Lcom/riola/player/NowPlayingActivity;->access$000(Lcom/riola/player/NowPlayingActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->stop()V

    .line 141
    :try_start_0
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$7;->this$0:Lcom/riola/player/NowPlayingActivity;

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/riola/player/NowPlayingActivity$7;->this$0:Lcom/riola/player/NowPlayingActivity;

    const-class v2, Lcom/riola/player/PlayerService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v0}, Lcom/riola/player/NowPlayingActivity;->stopService(Landroid/content/Intent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 142
    :catch_0
    move-exception p1

    :goto_0
    nop

    .line 143
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$7;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-virtual {p1}, Lcom/riola/player/NowPlayingActivity;->finish()V

    .line 144
    return-void
.end method
