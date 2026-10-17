.class Lcom/riola/player/LibraryActivity$15$2;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity$15;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/LibraryActivity$15;

.field final synthetic val$added:[I


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity$15;[I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 459
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$15$2;->this$1:Lcom/riola/player/LibraryActivity$15;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$15$2;->val$added:[I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 460
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$15$2;->this$1:Lcom/riola/player/LibraryActivity$15;

    iget-object v0, v0, Lcom/riola/player/LibraryActivity$15;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object v1, p0, Lcom/riola/player/LibraryActivity$15$2;->val$added:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    invoke-static {v0, v1}, Lcom/riola/player/LibraryActivity;->access$1600(Lcom/riola/player/LibraryActivity;I)V

    return-void
.end method
