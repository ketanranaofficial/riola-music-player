.class Lcom/riola/player/MainActivity$13$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnText;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity$13;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/MainActivity$13;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity$13;)V
    .locals 0

    .line 267
    iput-object p1, p0, Lcom/riola/player/MainActivity$13$1;->this$1:Lcom/riola/player/MainActivity$13;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/lang/String;)V
    .locals 1

    .line 269
    iget-object v0, p0, Lcom/riola/player/MainActivity$13$1;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object v0, v0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    iput-object p1, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    .line 270
    iget-object p1, p0, Lcom/riola/player/MainActivity$13$1;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object v0, p0, Lcom/riola/player/MainActivity$13$1;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object v0, v0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    invoke-static {p1, v0}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 271
    iget-object p1, p0, Lcom/riola/player/MainActivity$13$1;->this$1:Lcom/riola/player/MainActivity$13;

    iget-object p1, p1, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 272
    return-void
.end method
