.class Lcom/riola/player/LibraryActivity$12;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->showStreams(Lcom/riola/player/Track;Ljava/util/List;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;

.field final synthetic val$indexes:Ljava/util/List;

.field final synthetic val$items:[Ljava/lang/String;

.field final synthetic val$t:Lcom/riola/player/Track;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;Ljava/util/List;[Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 288
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$12;->this$0:Lcom/riola/player/LibraryActivity;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$12;->val$t:Lcom/riola/player/Track;

    iput-object p3, p0, Lcom/riola/player/LibraryActivity$12;->val$indexes:Ljava/util/List;

    iput-object p4, p0, Lcom/riola/player/LibraryActivity$12;->val$items:[Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 290
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$12;->val$t:Lcom/riola/player/Track;

    if-nez p2, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$12;->val$indexes:Ljava/util/List;

    add-int/lit8 v1, p2, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    iput v0, p1, Lcom/riola/player/Track;->audioTrack:I

    .line 291
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$12;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 292
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$12;->this$0:Lcom/riola/player/LibraryActivity;

    if-nez p2, :cond_1

    const-string p2, "Using the file\'s own choice"

    goto :goto_1

    .line 293
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Using "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/LibraryActivity$12;->val$items:[Ljava/lang/String;

    aget-object p2, v1, p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 292
    :goto_1
    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 294
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$12;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 295
    return-void
.end method
