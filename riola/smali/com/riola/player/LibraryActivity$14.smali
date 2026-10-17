.class Lcom/riola/player/LibraryActivity$14;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->clearAll()V
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

    .line 335
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$14;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 337
    sget-object p1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 338
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$14;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 339
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$14;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 340
    return-void
.end method
