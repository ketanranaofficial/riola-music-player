.class Lcom/riola/player/PlayerService$3;
.super Ljava/lang/Object;
.source "PlayerService.java"

# interfaces
.implements Landroid/media/AudioManager$OnAudioFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/PlayerService;->requestFocus()V
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

    .line 233
    iput-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioFocusChange(I)V
    .locals 2

    .line 235
    const/4 v0, -0x1

    const/4 v1, 0x1

    if-ne p1, v0, :cond_0

    .line 236
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$200(Lcom/riola/player/PlayerService;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->pauseOnFocus()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isPaused()Z

    move-result p1

    if-nez p1, :cond_3

    .line 237
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1, v1}, Lcom/riola/player/PlayerService;->access$302(Lcom/riola/player/PlayerService;Z)Z

    .line 238
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1, v1}, Lcom/riola/player/Engine;->setPaused(Z)V

    goto :goto_0

    .line 240
    :cond_0
    const/4 v0, -0x2

    if-ne p1, v0, :cond_1

    .line 241
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$200(Lcom/riola/player/PlayerService;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->pauseOnFocus()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isPaused()Z

    move-result p1

    if-nez p1, :cond_3

    .line 242
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1, v1}, Lcom/riola/player/PlayerService;->access$302(Lcom/riola/player/PlayerService;Z)Z

    .line 243
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1, v1}, Lcom/riola/player/Engine;->setPaused(Z)V

    goto :goto_0

    .line 245
    :cond_1
    const/4 v0, -0x3

    if-ne p1, v0, :cond_2

    .line 246
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$200(Lcom/riola/player/PlayerService;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->pauseOnFocus()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    const/high16 v0, 0x3e800000    # 0.25f

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->setDuck(F)V

    goto :goto_0

    .line 247
    :cond_2
    if-ne p1, v1, :cond_3

    .line 248
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->setDuck(F)V

    .line 249
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$300(Lcom/riola/player/PlayerService;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 250
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/riola/player/PlayerService;->access$302(Lcom/riola/player/PlayerService;Z)Z

    .line 251
    iget-object p1, p0, Lcom/riola/player/PlayerService$3;->this$0:Lcom/riola/player/PlayerService;

    invoke-static {p1}, Lcom/riola/player/PlayerService;->access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->setPaused(Z)V

    .line 254
    :cond_3
    :goto_0
    return-void
.end method
