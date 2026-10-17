.class Lcom/riola/player/MainActivity$8;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->refresh()V
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

    .line 181
    iput-object p1, p0, Lcom/riola/player/MainActivity$8;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 183
    invoke-static {}, Lcom/riola/player/Store;->sample()Lcom/riola/player/Program;

    move-result-object p1

    .line 184
    iget-object v0, p0, Lcom/riola/player/MainActivity$8;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0, p1}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 185
    iget-object v0, p0, Lcom/riola/player/MainActivity$8;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 186
    iget-object v0, p0, Lcom/riola/player/MainActivity$8;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0, p1}, Lcom/riola/player/MainActivity;->access$500(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    .line 187
    return-void
.end method
