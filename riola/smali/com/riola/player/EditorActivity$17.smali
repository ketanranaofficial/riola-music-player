.class Lcom/riola/player/EditorActivity$17;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->stepMenu(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;

.field final synthetic val$index:I

.field final synthetic val$s:Lcom/riola/player/Step;


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;ILcom/riola/player/Step;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 414
    iput-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iput p2, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    iput-object p3, p0, Lcom/riola/player/EditorActivity$17;->val$s:Lcom/riola/player/Step;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .line 416
    const/4 p1, 0x1

    packed-switch p2, :pswitch_data_0

    .line 424
    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget p2, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    invoke-static {p1, p2}, Lcom/riola/player/EditorActivity;->access$2100(Lcom/riola/player/EditorActivity;I)V

    goto :goto_0

    .line 423
    :pswitch_0
    iget-object p2, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget v0, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    invoke-static {p2, v0, p1}, Lcom/riola/player/EditorActivity;->access$1900(Lcom/riola/player/EditorActivity;II)V

    goto :goto_0

    .line 422
    :pswitch_1
    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget p2, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    const/4 v0, -0x1

    invoke-static {p1, p2, v0}, Lcom/riola/player/EditorActivity;->access$1900(Lcom/riola/player/EditorActivity;II)V

    goto :goto_0

    .line 421
    :pswitch_2
    iget-object p2, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object p2

    iget-object p2, p2, Lcom/riola/player/Program;->steps:Ljava/util/List;

    iget v0, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    add-int/2addr v0, p1

    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->val$s:Lcom/riola/player/Step;

    invoke-virtual {p1}, Lcom/riola/player/Step;->copy()Lcom/riola/player/Step;

    move-result-object p1

    invoke-interface {p2, v0, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    goto :goto_0

    .line 420
    :pswitch_3
    iget-object p2, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget v0, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    add-int/2addr v0, p1

    invoke-static {p2, v0}, Lcom/riola/player/EditorActivity;->access$2200(Lcom/riola/player/EditorActivity;I)V

    goto :goto_0

    .line 419
    :pswitch_4
    iget-object p2, p0, Lcom/riola/player/EditorActivity$17;->val$s:Lcom/riola/player/Step;

    iget-boolean v0, p2, Lcom/riola/player/Step;->enabled:Z

    xor-int/2addr p1, v0

    iput-boolean p1, p2, Lcom/riola/player/Step;->enabled:Z

    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    goto :goto_0

    .line 418
    :pswitch_5
    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget p2, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    invoke-static {p1, p2}, Lcom/riola/player/EditorActivity;->access$600(Lcom/riola/player/EditorActivity;I)V

    goto :goto_0

    .line 417
    :pswitch_6
    iget-object p1, p0, Lcom/riola/player/EditorActivity$17;->this$0:Lcom/riola/player/EditorActivity;

    iget p2, p0, Lcom/riola/player/EditorActivity$17;->val$index:I

    invoke-static {p1, p2}, Lcom/riola/player/EditorActivity;->access$1700(Lcom/riola/player/EditorActivity;I)V

    .line 426
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
