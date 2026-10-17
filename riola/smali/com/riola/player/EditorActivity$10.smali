.class Lcom/riola/player/EditorActivity$10;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->stepRow(I)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 279
    iput-object p1, p0, Lcom/riola/player/EditorActivity$10;->this$0:Lcom/riola/player/EditorActivity;

    iput p2, p0, Lcom/riola/player/EditorActivity$10;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 283
    iget-object v0, p0, Lcom/riola/player/EditorActivity$10;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1600(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Engine;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/EditorActivity$10;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v1}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/riola/player/Engine;->isPlaying(Lcom/riola/player/Program;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/EditorActivity$10;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1600(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget v0, p0, Lcom/riola/player/EditorActivity$10;->val$index:I

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->jumpTo(I)V

    goto :goto_0

    .line 284
    :cond_0
    iget-object p1, p0, Lcom/riola/player/EditorActivity$10;->this$0:Lcom/riola/player/EditorActivity;

    iget v0, p0, Lcom/riola/player/EditorActivity$10;->val$index:I

    invoke-static {p1, v0}, Lcom/riola/player/EditorActivity;->access$1700(Lcom/riola/player/EditorActivity;I)V

    .line 285
    :goto_0
    return-void
.end method
