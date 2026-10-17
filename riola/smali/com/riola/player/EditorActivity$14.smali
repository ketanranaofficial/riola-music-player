.class Lcom/riola/player/EditorActivity$14;
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

    .line 331
    iput-object p1, p0, Lcom/riola/player/EditorActivity$14;->this$0:Lcom/riola/player/EditorActivity;

    iput p2, p0, Lcom/riola/player/EditorActivity$14;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 332
    iget-object p1, p0, Lcom/riola/player/EditorActivity$14;->this$0:Lcom/riola/player/EditorActivity;

    iget v0, p0, Lcom/riola/player/EditorActivity$14;->val$index:I

    invoke-static {p1, v0}, Lcom/riola/player/EditorActivity;->access$1800(Lcom/riola/player/EditorActivity;I)V

    return-void
.end method
