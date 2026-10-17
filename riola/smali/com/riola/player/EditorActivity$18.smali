.class Lcom/riola/player/EditorActivity$18;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnText;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->rename()V
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

    .line 440
    iput-object p1, p0, Lcom/riola/player/EditorActivity$18;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/lang/String;)V
    .locals 1

    .line 441
    iget-object v0, p0, Lcom/riola/player/EditorActivity$18;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v0

    iput-object p1, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    iget-object p1, p0, Lcom/riola/player/EditorActivity$18;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    iget-object p1, p0, Lcom/riola/player/EditorActivity$18;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    return-void
.end method
