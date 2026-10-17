.class Lcom/riola/player/LibraryActivity$13;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->remove(ILcom/riola/player/Track;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 321
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$13;->this$0:Lcom/riola/player/LibraryActivity;

    iput p2, p0, Lcom/riola/player/LibraryActivity$13;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 323
    sget-object p1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    iget p2, p0, Lcom/riola/player/LibraryActivity$13;->val$index:I

    invoke-virtual {p1, p2}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(I)Ljava/lang/Object;

    .line 324
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$13;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 325
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$13;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 326
    return-void
.end method
