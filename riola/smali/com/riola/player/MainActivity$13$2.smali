.class Lcom/riola/player/MainActivity$13$2;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity$13;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/MainActivity$13;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity$13;)V
    .locals 0

    .line 289
    iput-object p1, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 291
    iget-object p1, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget-object p2, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p2, p2, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$700(Lcom/riola/player/MainActivity;)Lcom/riola/player/PlayerBar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/PlayerBar;->stop()V

    .line 292
    :cond_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object p2, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p2, p2, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    invoke-static {p1, p2}, Lcom/riola/player/Store;->delete(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 293
    iget-object p1, p0, Lcom/riola/player/MainActivity$13$2;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 294
    return-void
.end method
