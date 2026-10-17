.class Lcom/riola/player/Engine$1;
.super Ljava/lang/Object;
.source "Engine.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Engine;->begin(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Engine;

.field final synthetic val$myGen:I


# direct methods
.method constructor <init>(Lcom/riola/player/Engine;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 164
    iput-object p1, p0, Lcom/riola/player/Engine$1;->this$0:Lcom/riola/player/Engine;

    iput p2, p0, Lcom/riola/player/Engine$1;->val$myGen:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 164
    iget-object v0, p0, Lcom/riola/player/Engine$1;->this$0:Lcom/riola/player/Engine;

    iget v1, p0, Lcom/riola/player/Engine$1;->val$myGen:I

    invoke-static {v0, v1}, Lcom/riola/player/Engine;->access$000(Lcom/riola/player/Engine;I)V

    return-void
.end method
