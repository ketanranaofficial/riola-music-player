.class Lcom/riola/player/LibraryActivity$10$1;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnText;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity$10;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/LibraryActivity$10;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity$10;)V
    .locals 0

    .line 223
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$10$1;->this$1:Lcom/riola/player/LibraryActivity$10;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/lang/String;)V
    .locals 1

    .line 225
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$10$1;->this$1:Lcom/riola/player/LibraryActivity$10;

    iget-object v0, v0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    iput-object p1, v0, Lcom/riola/player/Track;->title:Ljava/lang/String;

    .line 226
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10$1;->this$1:Lcom/riola/player/LibraryActivity$10;

    iget-object p1, p1, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 227
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10$1;->this$1:Lcom/riola/player/LibraryActivity$10;

    iget-object p1, p1, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 228
    return-void
.end method
