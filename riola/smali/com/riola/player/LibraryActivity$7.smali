.class Lcom/riola/player/LibraryActivity$7;
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

    .line 169
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$7;->val$t:Lcom/riola/player/Track;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 171
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 172
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$700(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$800(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/PlayerBar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/PlayerBar;->stop()V

    goto :goto_0

    .line 173
    :cond_0
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$700(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget-object v0, p0, Lcom/riola/player/LibraryActivity$7;->val$t:Lcom/riola/player/Track;

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->previewTrack(Lcom/riola/player/Track;)V

    iget-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/PlayerBar;->startService(Landroid/app/Activity;)V

    .line 174
    :goto_0
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$7;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 175
    return-void
.end method
