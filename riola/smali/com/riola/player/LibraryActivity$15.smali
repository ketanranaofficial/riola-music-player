.class Lcom/riola/player/LibraryActivity$15;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->scanFolder(Landroid/net/Uri;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;

.field final synthetic val$tree:Landroid/net/Uri;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 449
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$15;->this$0:Lcom/riola/player/LibraryActivity;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$15;->val$tree:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 451
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 452
    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/riola/player/LibraryActivity$15;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object v3, p0, Lcom/riola/player/LibraryActivity$15;->val$tree:Landroid/net/Uri;

    invoke-static {v3}, Landroid/provider/DocumentsContract;->getTreeDocumentId(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v3, v4, v0, v1}, Lcom/riola/player/LibraryActivity;->access$1400(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;Ljava/lang/String;Ljava/util/List;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 453
    :catch_0
    move-exception v2

    :goto_0
    nop

    .line 454
    new-instance v2, Lcom/riola/player/LibraryActivity$15$1;

    invoke-direct {v2, p0}, Lcom/riola/player/LibraryActivity$15$1;-><init>(Lcom/riola/player/LibraryActivity$15;)V

    invoke-static {v0, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 457
    filled-new-array {v1}, [I

    move-result-object v2

    .line 458
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Track;

    iget-object v4, p0, Lcom/riola/player/LibraryActivity$15;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object v5, v3, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    iget-object v6, v3, Lcom/riola/player/Track;->title:Ljava/lang/String;

    iget-wide v7, v3, Lcom/riola/player/Track;->modifiedAt:J

    invoke-static {v4, v5, v6, v7, v8}, Lcom/riola/player/LibraryActivity;->access$1500(Lcom/riola/player/LibraryActivity;Landroid/net/Uri;Ljava/lang/String;J)Z

    move-result v3

    if-eqz v3, :cond_0

    aget v3, v2, v1

    add-int/lit8 v3, v3, 0x1

    aput v3, v2, v1

    goto :goto_1

    .line 459
    :cond_1
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$15;->this$0:Lcom/riola/player/LibraryActivity;

    new-instance v1, Lcom/riola/player/LibraryActivity$15$2;

    invoke-direct {v1, p0, v2}, Lcom/riola/player/LibraryActivity$15$2;-><init>(Lcom/riola/player/LibraryActivity$15;[I)V

    invoke-virtual {v0, v1}, Lcom/riola/player/LibraryActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 462
    return-void
.end method
