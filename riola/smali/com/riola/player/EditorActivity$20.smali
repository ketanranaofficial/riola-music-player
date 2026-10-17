.class Lcom/riola/player/EditorActivity$20;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/Runner$OnStarted;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->run(I)V
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

    .line 475
    iput-object p1, p0, Lcom/riola/player/EditorActivity$20;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public started()V
    .locals 1

    .line 476
    iget-object v0, p0, Lcom/riola/player/EditorActivity$20;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$300(Lcom/riola/player/EditorActivity;)V

    return-void
.end method
