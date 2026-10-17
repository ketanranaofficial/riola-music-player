.class Lcom/riola/player/MainActivity$16;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->buildLive()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 370
    iput-object p1, p0, Lcom/riola/player/MainActivity$16;->this$0:Lcom/riola/player/MainActivity;

    iput p2, p0, Lcom/riola/player/MainActivity$16;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 371
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/MainActivity$16;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget v0, p0, Lcom/riola/player/MainActivity$16;->val$index:I

    invoke-virtual {p1, v0}, Lcom/riola/player/Engine;->jumpTo(I)V

    return-void
.end method
