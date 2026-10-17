.class Lcom/riola/player/MainActivity$18;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Themes$OnChosen;


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

    .line 481
    iput-object p1, p0, Lcom/riola/player/MainActivity$18;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$18;->val$holder:[Landroid/app/AlertDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public chosen()V
    .locals 2

    .line 483
    iget-object v0, p0, Lcom/riola/player/MainActivity$18;->val$holder:[Landroid/app/AlertDialog;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 484
    :cond_0
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$1202(Z)Z

    .line 485
    iget-object v0, p0, Lcom/riola/player/MainActivity$18;->this$0:Lcom/riola/player/MainActivity;

    invoke-virtual {v0}, Lcom/riola/player/MainActivity;->recreate()V

    .line 486
    return-void
.end method
