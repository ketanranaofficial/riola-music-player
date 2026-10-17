.class Lcom/riola/player/EditorActivity$13;
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

    .line 326
    iput-object p1, p0, Lcom/riola/player/EditorActivity$13;->this$0:Lcom/riola/player/EditorActivity;

    iput p2, p0, Lcom/riola/player/EditorActivity$13;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 327
    iget-object p1, p0, Lcom/riola/player/EditorActivity$13;->this$0:Lcom/riola/player/EditorActivity;

    iget v0, p0, Lcom/riola/player/EditorActivity$13;->val$index:I

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lcom/riola/player/EditorActivity;->access$1900(Lcom/riola/player/EditorActivity;II)V

    return-void
.end method
