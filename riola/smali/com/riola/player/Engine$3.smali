.class Lcom/riola/player/Engine$3;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;


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

    .line 589
    iput-object p1, p0, Lcom/riola/player/Engine$3;->this$0:Lcom/riola/player/Engine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 1

    .line 590
    iget-object p1, p0, Lcom/riola/player/Engine$3;->this$0:Lcom/riola/player/Engine;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/riola/player/Engine;->access$302(Lcom/riola/player/Engine;Z)Z

    iget-object p1, p0, Lcom/riola/player/Engine$3;->this$0:Lcom/riola/player/Engine;

    invoke-static {p1}, Lcom/riola/player/Engine;->access$400(Lcom/riola/player/Engine;)V

    return-void
.end method
