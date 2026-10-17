.class Lcom/riola/player/Bell$2;
.super Ljava/lang/Object;
.source "Bell.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Bell;->preview(IF)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$b:Lcom/riola/player/Bell;


# direct methods
.method constructor <init>(Lcom/riola/player/Bell;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 147
    iput-object p1, p0, Lcom/riola/player/Bell$2;->val$b:Lcom/riola/player/Bell;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 148
    iget-object v0, p0, Lcom/riola/player/Bell$2;->val$b:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    return-void
.end method
