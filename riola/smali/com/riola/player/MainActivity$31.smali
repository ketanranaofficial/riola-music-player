.class Lcom/riola/player/MainActivity$31;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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

.field final synthetic val$holder:[Landroid/app/AlertDialog;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 547
    iput-object p1, p0, Lcom/riola/player/MainActivity$31;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$31;->val$holder:[Landroid/app/AlertDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 549
    iget-object p1, p0, Lcom/riola/player/MainActivity$31;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->resetAll()V

    .line 550
    iget-object p1, p0, Lcom/riola/player/MainActivity$31;->this$0:Lcom/riola/player/MainActivity;

    const-string v0, "Settings reset"

    invoke-static {p1, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 551
    iget-object p1, p0, Lcom/riola/player/MainActivity$31;->val$holder:[Landroid/app/AlertDialog;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 552
    :cond_0
    const/4 p1, 0x1

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$1202(Z)Z

    .line 553
    iget-object p1, p0, Lcom/riola/player/MainActivity$31;->this$0:Lcom/riola/player/MainActivity;

    invoke-virtual {p1}, Lcom/riola/player/MainActivity;->recreate()V

    .line 554
    return-void
.end method
