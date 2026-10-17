.class Lcom/riola/player/PlayerBar$3;
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

    .line 100
    iput-object p1, p0, Lcom/riola/player/PlayerBar$3;->this$0:Lcom/riola/player/PlayerBar;

    iput-object p2, p0, Lcom/riola/player/PlayerBar$3;->val$a:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 101
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/PlayerBar$3;->val$a:Landroid/app/Activity;

    iget-object v0, p0, Lcom/riola/player/PlayerBar$3;->this$0:Lcom/riola/player/PlayerBar;

    invoke-static {v0}, Lcom/riola/player/PlayerBar;->access$100(Lcom/riola/player/PlayerBar;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/riola/player/PlayerBar;->askShuffle(Landroid/app/Activity;Lcom/riola/player/Engine;)V

    return-void
.end method
