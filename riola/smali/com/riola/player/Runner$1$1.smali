.class Lcom/riola/player/Runner$1$1;
.super Ljava/lang/Object;
.source "Runner.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Runner$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Runner$1;

.field final synthetic val$bad:Ljava/util/List;

.field final synthetic val$ok:I


# direct methods
.method constructor <init>(Lcom/riola/player/Runner$1;Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 60
    iput-object p1, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iput-object p2, p0, Lcom/riola/player/Runner$1$1;->val$bad:Ljava/util/List;

    iput p3, p0, Lcom/riola/player/Runner$1$1;->val$ok:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 62
    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v0, v0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v0, v0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 63
    :cond_0
    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->val$bad:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v0, v0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v1, v1, Lcom/riola/player/Runner$1;->val$p:Lcom/riola/player/Program;

    iget-object v2, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget v2, v2, Lcom/riola/player/Runner$1;->val$from:I

    iget-object v3, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v3, v3, Lcom/riola/player/Runner$1;->val$cb:Lcom/riola/player/Runner$OnStarted;

    invoke-static {v0, v1, v2, v3}, Lcom/riola/player/Runner;->access$000(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    goto :goto_0

    .line 64
    :cond_1
    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v1, v0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v2, v0, Lcom/riola/player/Runner$1;->val$p:Lcom/riola/player/Program;

    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget v3, v0, Lcom/riola/player/Runner$1;->val$from:I

    iget-object v4, p0, Lcom/riola/player/Runner$1$1;->val$bad:Ljava/util/List;

    iget v5, p0, Lcom/riola/player/Runner$1$1;->val$ok:I

    iget-object v0, p0, Lcom/riola/player/Runner$1$1;->this$0:Lcom/riola/player/Runner$1;

    iget-object v6, v0, Lcom/riola/player/Runner$1;->val$cb:Lcom/riola/player/Runner$OnStarted;

    invoke-static/range {v1 .. v6}, Lcom/riola/player/Runner;->access$100(Landroid/app/Activity;Lcom/riola/player/Program;ILjava/util/List;ILcom/riola/player/Runner$OnStarted;)V

    .line 65
    :goto_0
    return-void

    .line 62
    :cond_2
    :goto_1
    return-void
.end method
