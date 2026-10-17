.class Lcom/riola/player/LibraryActivity$8;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->row(Lcom/riola/player/Track;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;

.field final synthetic val$t:Lcom/riola/player/Track;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 189
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$8;->this$0:Lcom/riola/player/LibraryActivity;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$8;->val$t:Lcom/riola/player/Track;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 190
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$8;->this$0:Lcom/riola/player/LibraryActivity;

    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    iget-object v1, p0, Lcom/riola/player/LibraryActivity$8;->val$t:Lcom/riola/player/Track;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v0

    invoke-static {p1, v0}, Lcom/riola/player/LibraryActivity;->access$900(Lcom/riola/player/LibraryActivity;I)V

    return-void
.end method
