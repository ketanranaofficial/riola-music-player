.class Lcom/riola/player/NowPlayingActivity$2;
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

    .line 57
    iput-object p1, p0, Lcom/riola/player/NowPlayingActivity$2;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 58
    iget-object p1, p0, Lcom/riola/player/NowPlayingActivity$2;->this$0:Lcom/riola/player/NowPlayingActivity;

    invoke-static {p1}, Lcom/riola/player/NowPlayingActivity;->access$100(Lcom/riola/player/NowPlayingActivity;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-static {p1, v0}, Lcom/riola/player/NowPlayingActivity;->access$200(Lcom/riola/player/NowPlayingActivity;Z)V

    return-void
.end method
