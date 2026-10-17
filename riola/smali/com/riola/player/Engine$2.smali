.class Lcom/riola/player/Engine$2;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Engine;->loop(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Engine;

.field final synthetic val$done:Z

.field final synthetic val$myGen:I


# direct methods
.method constructor <init>(Lcom/riola/player/Engine;IZ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 359
    iput-object p1, p0, Lcom/riola/player/Engine$2;->this$0:Lcom/riola/player/Engine;

    iput p2, p0, Lcom/riola/player/Engine$2;->val$myGen:I

    iput-boolean p3, p0, Lcom/riola/player/Engine$2;->val$done:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 361
    iget v0, p0, Lcom/riola/player/Engine$2;->val$myGen:I

    iget-object v1, p0, Lcom/riola/player/Engine$2;->this$0:Lcom/riola/player/Engine;

    invoke-static {v1}, Lcom/riola/player/Engine;->access$100(Lcom/riola/player/Engine;)I

    move-result v1

    if-eq v0, v1, :cond_0

    return-void

    .line 362
    :cond_0
    iget-object v0, p0, Lcom/riola/player/Engine$2;->this$0:Lcom/riola/player/Engine;

    invoke-static {v0}, Lcom/riola/player/Engine;->access$200(Lcom/riola/player/Engine;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/riola/player/Engine$Listener;

    iget-boolean v2, p0, Lcom/riola/player/Engine$2;->val$done:Z

    invoke-interface {v1, v2}, Lcom/riola/player/Engine$Listener;->onFinished(Z)V

    goto :goto_0

    .line 363
    :cond_1
    return-void
.end method
