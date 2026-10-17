.class Lcom/riola/player/PlayerBar$1;
.super Ljava/lang/Object;
.source "PlayerBar.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/PlayerBar;-><init>(Landroid/app/Activity;Lcom/riola/player/PlayerBar$Host;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/PlayerBar;

.field final synthetic val$a:Landroid/app/Activity;


# direct methods
.method constructor <init>(Lcom/riola/player/PlayerBar;Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 57
    iput-object p1, p0, Lcom/riola/player/PlayerBar$1;->this$0:Lcom/riola/player/PlayerBar;

    iput-object p2, p0, Lcom/riola/player/PlayerBar$1;->val$a:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 59
    :try_start_0
    iget-object p1, p0, Lcom/riola/player/PlayerBar$1;->val$a:Landroid/app/Activity;

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/riola/player/PlayerBar$1;->val$a:Landroid/app/Activity;

    const-class v2, Lcom/riola/player/NowPlayingActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 60
    :catch_0
    move-exception p1

    :goto_0
    nop

    .line 61
    return-void
.end method
