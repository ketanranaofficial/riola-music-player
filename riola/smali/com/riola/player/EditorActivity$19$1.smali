.class Lcom/riola/player/EditorActivity$19$1;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity$19;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/EditorActivity$19;


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity$19;)V
    .locals 0

    .line 459
    iput-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 461
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1600(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget-object p2, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p2, p2, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$2300(Lcom/riola/player/EditorActivity;)Lcom/riola/player/PlayerBar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/PlayerBar;->stop()V

    .line 462
    :cond_0
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    iget-object p2, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p2, p2, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/riola/player/Store;->delete(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 463
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lcom/riola/player/EditorActivity;->access$1102(Lcom/riola/player/EditorActivity;Lcom/riola/player/Program;)Lcom/riola/player/Program;

    .line 464
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19$1;->this$1:Lcom/riola/player/EditorActivity$19;

    iget-object p1, p1, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-virtual {p1}, Lcom/riola/player/EditorActivity;->finish()V

    .line 465
    return-void
.end method
