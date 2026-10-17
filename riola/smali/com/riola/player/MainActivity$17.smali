.class Lcom/riola/player/MainActivity$17;
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

.field final synthetic val$holder:[Landroid/app/AlertDialog;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 470
    iput-object p1, p0, Lcom/riola/player/MainActivity$17;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$17;->val$holder:[Landroid/app/AlertDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(Z)V
    .locals 1

    .line 472
    iget-object v0, p0, Lcom/riola/player/MainActivity$17;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/riola/player/Prefs;->dark(Z)V

    .line 475
    iget-object p1, p0, Lcom/riola/player/MainActivity$17;->val$holder:[Landroid/app/AlertDialog;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 476
    :cond_0
    const/4 p1, 0x1

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$1202(Z)Z

    .line 477
    iget-object p1, p0, Lcom/riola/player/MainActivity$17;->this$0:Lcom/riola/player/MainActivity;

    invoke-virtual {p1}, Lcom/riola/player/MainActivity;->recreate()V

    .line 478
    return-void
.end method
