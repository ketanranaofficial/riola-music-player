.class Lcom/riola/player/Engine$4;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Engine;->open(Lcom/riola/player/Track;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Engine;


# direct methods
.method constructor <init>(Lcom/riola/player/Engine;)V
    .locals 0

    .line 592
    iput-object p1, p0, Lcom/riola/player/Engine$4;->this$0:Lcom/riola/player/Engine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 2

    .line 594
    iget-object p1, p0, Lcom/riola/player/Engine$4;->this$0:Lcom/riola/player/Engine;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  ! player error "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, "/"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 595
    iget-object p1, p0, Lcom/riola/player/Engine$4;->this$0:Lcom/riola/player/Engine;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lcom/riola/player/Engine;->access$302(Lcom/riola/player/Engine;Z)Z

    .line 596
    iget-object p1, p0, Lcom/riola/player/Engine$4;->this$0:Lcom/riola/player/Engine;

    invoke-static {p1}, Lcom/riola/player/Engine;->access$400(Lcom/riola/player/Engine;)V

    .line 597
    return p2
.end method
