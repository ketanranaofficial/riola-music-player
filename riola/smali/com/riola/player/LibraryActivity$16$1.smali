.class Lcom/riola/player/LibraryActivity$16$1;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity$16;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/LibraryActivity$16;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity$16;)V
    .locals 0

    .line 522
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$16$1;->this$1:Lcom/riola/player/LibraryActivity$16;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 523
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$16$1;->this$1:Lcom/riola/player/LibraryActivity$16;

    iget-object v0, v0, Lcom/riola/player/LibraryActivity$16;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {v0}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    return-void
.end method
