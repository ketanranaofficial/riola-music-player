.class Lcom/riola/player/Engine$6;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Engine;->log(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Engine;

.field final synthetic val$entry:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/riola/player/Engine;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 732
    iput-object p1, p0, Lcom/riola/player/Engine$6;->this$0:Lcom/riola/player/Engine;

    iput-object p2, p0, Lcom/riola/player/Engine$6;->val$entry:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 734
    iget-object v0, p0, Lcom/riola/player/Engine$6;->this$0:Lcom/riola/player/Engine;

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

    iget-object v2, p0, Lcom/riola/player/Engine$6;->val$entry:Ljava/lang/String;

    invoke-interface {v1, v2}, Lcom/riola/player/Engine$Listener;->onLog(Ljava/lang/String;)V

    goto :goto_0

    .line 735
    :cond_0
    return-void
.end method
