.class Lcom/riola/player/MainActivity$10;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->programRow(Lcom/riola/player/Program;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 213
    iput-object p1, p0, Lcom/riola/player/MainActivity$10;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$10;->val$p:Lcom/riola/player/Program;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 1

    .line 214
    iget-object p1, p0, Lcom/riola/player/MainActivity$10;->this$0:Lcom/riola/player/MainActivity;

    iget-object v0, p0, Lcom/riola/player/MainActivity$10;->val$p:Lcom/riola/player/Program;

    invoke-static {p1, v0}, Lcom/riola/player/MainActivity;->access$600(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    const/4 p1, 0x1

    return p1
.end method
