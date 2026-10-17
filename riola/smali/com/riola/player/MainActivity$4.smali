.class Lcom/riola/player/MainActivity$4;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->build()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 117
    iput-object p1, p0, Lcom/riola/player/MainActivity$4;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 119
    iget-object p1, p0, Lcom/riola/player/MainActivity$4;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/MainActivity$4;->this$0:Lcom/riola/player/MainActivity;

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/riola/player/MainActivity$4;->this$0:Lcom/riola/player/MainActivity;

    const-class v2, Lcom/riola/player/NowPlayingActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v0}, Lcom/riola/player/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 120
    :cond_0
    return-void
.end method
