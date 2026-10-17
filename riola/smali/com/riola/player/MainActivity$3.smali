.class Lcom/riola/player/MainActivity$3;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->build()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 102
    iput-object p1, p0, Lcom/riola/player/MainActivity$3;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 103
    iget-object p1, p0, Lcom/riola/player/MainActivity$3;->this$0:Lcom/riola/player/MainActivity;

    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/riola/player/MainActivity$3;->this$0:Lcom/riola/player/MainActivity;

    const-class v2, Lcom/riola/player/LibraryActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, v0}, Lcom/riola/player/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
