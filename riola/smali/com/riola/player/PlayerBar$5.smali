.class Lcom/riola/player/PlayerBar$5;
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


# direct methods
.method constructor <init>(Lcom/riola/player/PlayerBar;)V
    .locals 0

    .line 109
    iput-object p1, p0, Lcom/riola/player/PlayerBar$5;->this$0:Lcom/riola/player/PlayerBar;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .line 110
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/PlayerBar$5;->this$0:Lcom/riola/player/PlayerBar;

    invoke-static {p1}, Lcom/riola/player/PlayerBar;->access$100(Lcom/riola/player/PlayerBar;)Lcom/riola/player/Engine;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Engine;->togglePause()V

    return-void
.end method
