.class Lcom/riola/player/PlayerBar$2;
.super Ljava/lang/Object;
.source "PlayerBar.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/PlayerBar;-><init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/PlayerBar;


# direct methods
.method constructor <init>(Lcom/riola/player/PlayerBar;)V
    .locals 0

    .line 81
    iput-object p1, p0, Lcom/riola/player/PlayerBar$2;->this$0:Lcom/riola/player/PlayerBar;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 0

    .line 82
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1

    .line 83
    iget-object p1, p0, Lcom/riola/player/PlayerBar$2;->this$0:Lcom/riola/player/PlayerBar;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/riola/player/PlayerBar;->access$002(Lcom/riola/player/PlayerBar;Z)Z

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 2

    .line 84
    iget-object v0, p0, Lcom/riola/player/PlayerBar$2;->this$0:Lcom/riola/player/PlayerBar;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/riola/player/PlayerBar;->access$002(Lcom/riola/player/PlayerBar;Z)Z

    iget-object v0, p0, Lcom/riola/player/PlayerBar$2;->this$0:Lcom/riola/player/PlayerBar;

    invoke-static {v0}, Lcom/riola/player/PlayerBar;->access$100(Lcom/riola/player/PlayerBar;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/riola/player/Engine;->seekTo(I)V

    return-void
.end method
