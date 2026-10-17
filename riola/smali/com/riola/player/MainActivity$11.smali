.class Lcom/riola/player/MainActivity$11;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->programRow(Lcom/riola/player/Program;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 218
    iput-object p1, p0, Lcom/riola/player/MainActivity$11;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$11;->val$p:Lcom/riola/player/Program;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 220
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 221
    iget-object p1, p0, Lcom/riola/player/MainActivity$11;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget-object v0, p0, Lcom/riola/player/MainActivity$11;->val$p:Lcom/riola/player/Program;

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/MainActivity$11;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$700(Lcom/riola/player/MainActivity;)Lcom/riola/player/PlayerBar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/PlayerBar;->stop()V

    goto :goto_0

    .line 222
    :cond_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$11;->this$0:Lcom/riola/player/MainActivity;

    iget-object v0, p0, Lcom/riola/player/MainActivity$11;->val$p:Lcom/riola/player/Program;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/riola/player/MainActivity;->access$800(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;I)V

    .line 223
    :goto_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$11;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 224
    return-void
.end method
