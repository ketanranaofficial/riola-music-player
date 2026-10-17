.class Lcom/riola/player/EditorActivity$15;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->addStep(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;

.field final synthetic val$at:I


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 347
    iput-object p1, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    iput p2, p0, Lcom/riola/player/EditorActivity$15;->val$at:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .line 349
    const/4 p1, 0x2

    if-eq p2, p1, :cond_3

    const/4 v0, 0x3

    if-ne p2, v0, :cond_0

    goto :goto_2

    .line 356
    :cond_0
    const/4 p1, 0x1

    if-ne p2, p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    .line 359
    :goto_0
    iget-object p2, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    .line 360
    if-eqz p1, :cond_2

    const-string v0, "Section of which track?"

    goto :goto_1

    :cond_2
    const-string v0, "Which tracks?"

    :goto_1
    xor-int/lit8 v1, p1, 0x1

    new-instance v2, Lcom/riola/player/EditorActivity$15$1;

    invoke-direct {v2, p0, p1}, Lcom/riola/player/EditorActivity$15$1;-><init>(Lcom/riola/player/EditorActivity$15;Z)V

    .line 359
    invoke-static {p2, v0, v1, v2}, Lcom/riola/player/TrackPicker;->show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V

    .line 388
    return-void

    .line 350
    :cond_3
    :goto_2
    iget-object v0, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    if-ne p2, p1, :cond_4

    const-wide/32 p1, 0xea60

    invoke-static {p1, p2}, Lcom/riola/player/Step;->silence(J)Lcom/riola/player/Step;

    move-result-object p1

    goto :goto_3

    :cond_4
    invoke-static {}, Lcom/riola/player/Step;->bell()Lcom/riola/player/Step;

    move-result-object p1

    :goto_3
    iget p2, p0, Lcom/riola/player/EditorActivity$15;->val$at:I

    invoke-static {v0, p1, p2}, Lcom/riola/player/EditorActivity;->access$2000(Lcom/riola/player/EditorActivity;Lcom/riola/player/Step;I)I

    move-result p1

    .line 351
    iget-object p2, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    .line 352
    iget-object p2, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    .line 353
    iget-object p2, p0, Lcom/riola/player/EditorActivity$15;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p2, p1}, Lcom/riola/player/EditorActivity;->access$1700(Lcom/riola/player/EditorActivity;I)V

    .line 354
    return-void
.end method
