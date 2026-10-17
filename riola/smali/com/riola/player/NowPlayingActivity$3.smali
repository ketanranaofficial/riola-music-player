.class Lcom/riola/player/NowPlayingActivity$3;
.super Ljava/lang/Object;
.source "NowPlayingActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

    .line 107
    iput-object p1, p0, Lcom/riola/player/NowPlayingActivity$3;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 0

    .line 108
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1

    .line 109
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$3;->this$0:Lcom/riola/player/NowPlayingActivity;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/riola/player/NowPlayingActivity;->access$302(Lcom/riola/player/NowPlayingActivity;Z)Z

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 2

    .line 110
    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity$3;->this$0:Lcom/riola/player/NowPlayingActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/riola/player/NowPlayingActivity;->access$302(Lcom/riola/player/NowPlayingActivity;Z)Z

    iget-object v0, p0, Lcom/riola/player/NowPlayingActivity$3;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-static {v0}, Lcom/riola/player/NowPlayingActivity;->access$000(Lcom/riola/player/NowPlayingActivity;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/riola/player/Engine;->seekTo(I)V

    return-void
.end method
