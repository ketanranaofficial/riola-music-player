.class Lcom/riola/player/NowPlayingActivity$6;
.super Ljava/lang/Object;
.source "NowPlayingActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/NowPlayingActivity;->build()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/NowPlayingActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/NowPlayingActivity;)V
    .locals 0

    .line 129
    iput-object p1, p0, Lcom/riola/player/NowPlayingActivity$6;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .line 130
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$6;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-static {p1}, Lcom/riola/player/NowPlayingActivity;->access$000(Lcom/riola/player/NowPlayingActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->next()V

    return-void
.end method
