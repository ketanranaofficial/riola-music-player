.class Lcom/riola/player/MainActivity$21;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Ui$OnToggle;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->settings()V
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

    .line 503
    iput-object p1, p0, Lcom/riola/player/MainActivity$21;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(Z)V
    .locals 1

    .line 505
    iget-object v0, p0, Lcom/riola/player/MainActivity$21;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/riola/player/Prefs;->keepScreenOn(Z)V

    .line 506
    const/16 v0, 0x80

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/MainActivity$21;->this$0:Lcom/riola/player/MainActivity;

    invoke-virtual {p1}, Lcom/riola/player/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    .line 507
    :cond_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$21;->this$0:Lcom/riola/player/MainActivity;

    invoke-virtual {p1}, Lcom/riola/player/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/Window;->clearFlags(I)V

    .line 508
    :goto_0
    return-void
.end method
