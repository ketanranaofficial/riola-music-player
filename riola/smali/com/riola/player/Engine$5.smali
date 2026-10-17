.class Lcom/riola/player/Engine$5;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Engine;->push()V
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

    .line 718
    iput-object p1, p0, Lcom/riola/player/Engine$5;->this$0:Lcom/riola/player/Engine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 720
    iget-object v0, p0, Lcom/riola/player/Engine$5;->this$0:Lcom/riola/player/Engine;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/riola/player/Engine;->access$502(Lcom/riola/player/Engine;Z)Z

    .line 721
    iget-object v0, p0, Lcom/riola/player/Engine$5;->this$0:Lcom/riola/player/Engine;

    invoke-static {v0}, Lcom/riola/player/Engine;->access$200(Lcom/riola/player/Engine;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/riola/player/Engine$Listener;

    iget-object v2, p0, Lcom/riola/player/Engine$5;->this$0:Lcom/riola/player/Engine;

    iget-object v2, v2, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-interface {v1, v2}, Lcom/riola/player/Engine$Listener;->onState(Lcom/riola/player/Engine$St;)V

    goto :goto_0

    .line 722
    :cond_0
    return-void
.end method
