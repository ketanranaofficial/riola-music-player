.class Lcom/riola/player/EditorActivity$16;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/StepSheet$OnDone;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->edit(I)V
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

    .line 403
    iput-object p1, p0, Lcom/riola/player/EditorActivity$16;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public changed()V
    .locals 1

    .line 404
    iget-object v0, p0, Lcom/riola/player/EditorActivity$16;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    iget-object v0, p0, Lcom/riola/player/EditorActivity$16;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    return-void
.end method

.method public deleted(I)V
    .locals 1

    .line 405
    iget-object v0, p0, Lcom/riola/player/EditorActivity$16;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0, p1}, Lcom/riola/player/EditorActivity;->access$2100(Lcom/riola/player/EditorActivity;I)V

    return-void
.end method
