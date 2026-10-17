.class Lcom/riola/player/EditorActivity$6;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->scrollToRow(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;

.field final synthetic val$row:Landroid/view/View;


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;Landroid/view/View;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 157
    iput-object p1, p0, Lcom/riola/player/EditorActivity$6;->this$0:Lcom/riola/player/EditorActivity;

    iput-object p2, p0, Lcom/riola/player/EditorActivity$6;->val$row:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 159
    nop

    .line 160
    iget-object v0, p0, Lcom/riola/player/EditorActivity$6;->val$row:Landroid/view/View;

    const/4 v1, 0x0

    move v2, v1

    .line 161
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    instance-of v3, v3, Landroid/view/View;

    if-eqz v3, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    iget-object v4, p0, Lcom/riola/player/EditorActivity$6;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v4}, Lcom/riola/player/EditorActivity;->access$1000(Lcom/riola/player/EditorActivity;)Landroid/widget/ScrollView;

    move-result-object v4

    if-eq v3, v4, :cond_0

    .line 162
    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v3

    add-int/2addr v2, v3

    .line 163
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    goto :goto_0

    .line 165
    :cond_0
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v0

    add-int/2addr v2, v0

    .line 166
    :cond_1
    iget-object v0, p0, Lcom/riola/player/EditorActivity$6;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1000(Lcom/riola/player/EditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    iget-object v3, p0, Lcom/riola/player/EditorActivity$6;->this$0:Lcom/riola/player/EditorActivity;

    const/high16 v4, 0x43160000    # 150.0f

    invoke-static {v3, v4}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    sub-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->smoothScrollTo(II)V

    .line 167
    return-void
.end method
