.class Lcom/riola/player/EditorActivity$1;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/riola/player/EditorActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 38
    iput-object p1, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 40
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$000(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Step;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 41
    :cond_0
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$110(Lcom/riola/player/EditorActivity;)I

    .line 42
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$100(Lcom/riola/player/EditorActivity;)I

    move-result v0

    if-gtz v0, :cond_1

    .line 43
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/riola/player/EditorActivity;->access$002(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;)Lcom/riola/player/Step;

    .line 44
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    const/4 v1, -0x1

    invoke-static {v0, v1}, Lcom/riola/player/EditorActivity;->access$202(Lcom/riola/player/EditorActivity;I)I

    .line 45
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    .line 46
    return-void

    .line 48
    :cond_1
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$400(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$400(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Step removed  .  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v2}, Lcom/riola/player/EditorActivity;->access$100(Lcom/riola/player/EditorActivity;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "s"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 49
    :cond_2
    iget-object v0, p0, Lcom/riola/player/EditorActivity$1;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$500(Lcom/riola/player/EditorActivity;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x3e8

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 50
    return-void
.end method
