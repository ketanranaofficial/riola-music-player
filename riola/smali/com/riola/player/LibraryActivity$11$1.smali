.class Lcom/riola/player/LibraryActivity$11$1;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity$11;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/LibraryActivity$11;

.field final synthetic val$indexes:Ljava/util/List;

.field final synthetic val$labels:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity$11;Ljava/util/List;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 269
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$11$1;->this$1:Lcom/riola/player/LibraryActivity$11;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$11$1;->val$labels:Ljava/util/List;

    iput-object p3, p0, Lcom/riola/player/LibraryActivity$11$1;->val$indexes:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 270
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$11$1;->this$1:Lcom/riola/player/LibraryActivity$11;

    iget-object v0, v0, Lcom/riola/player/LibraryActivity$11;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object v1, p0, Lcom/riola/player/LibraryActivity$11$1;->this$1:Lcom/riola/player/LibraryActivity$11;

    iget-object v1, v1, Lcom/riola/player/LibraryActivity$11;->val$t:Lcom/riola/player/Track;

    iget-object v2, p0, Lcom/riola/player/LibraryActivity$11$1;->val$labels:Ljava/util/List;

    iget-object v3, p0, Lcom/riola/player/LibraryActivity$11$1;->val$indexes:Ljava/util/List;

    invoke-static {v0, v1, v2, v3}, Lcom/riola/player/LibraryActivity;->access$1300(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;Ljava/util/List;Ljava/util/List;)V

    return-void
.end method
