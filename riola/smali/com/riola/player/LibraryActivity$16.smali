.class Lcom/riola/player/LibraryActivity$16;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->readDurations()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 507
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$16;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 509
    nop

    .line 510
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    .line 511
    iget-wide v3, v2, Lcom/riola/player/Track;->durMs:J

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-lez v3, :cond_0

    goto :goto_0

    .line 512
    :cond_0
    new-instance v3, Landroid/media/MediaMetadataRetriever;

    invoke-direct {v3}, Landroid/media/MediaMetadataRetriever;-><init>()V

    .line 514
    :try_start_0
    iget-object v4, p0, Lcom/riola/player/LibraryActivity$16;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-virtual {v2}, Lcom/riola/player/Track;->toUri()Landroid/net/Uri;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaMetadataRetriever;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 515
    const/16 v4, 0x9

    invoke-virtual {v3, v4}, Landroid/media/MediaMetadataRetriever;->extractMetadata(I)Ljava/lang/String;

    move-result-object v4

    .line 516
    if-eqz v4, :cond_1

    invoke-static {v4}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    iput-wide v4, v2, Lcom/riola/player/Track;->durMs:J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x1

    .line 518
    :cond_1
    :try_start_1
    invoke-virtual {v3}, Landroid/media/MediaMetadataRetriever;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v2

    goto :goto_2

    :catchall_0
    move-exception v0

    :try_start_2
    invoke-virtual {v3}, Landroid/media/MediaMetadataRetriever;->release()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    move-exception v1

    :goto_1
    throw v0

    .line 517
    :catch_2
    move-exception v2

    .line 518
    :try_start_3
    invoke-virtual {v3}, Landroid/media/MediaMetadataRetriever;->release()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 519
    :goto_2
    goto :goto_0

    .line 520
    :cond_2
    if-nez v1, :cond_3

    return-void

    .line 521
    :cond_3
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$16;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {v0}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 522
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$16;->this$0:Lcom/riola/player/LibraryActivity;

    new-instance v1, Lcom/riola/player/LibraryActivity$16$1;

    invoke-direct {v1, p0}, Lcom/riola/player/LibraryActivity$16$1;-><init>(Lcom/riola/player/LibraryActivity$16;)V

    invoke-virtual {v0, v1}, Lcom/riola/player/LibraryActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 525
    return-void
.end method
