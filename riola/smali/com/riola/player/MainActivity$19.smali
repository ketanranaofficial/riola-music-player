.class Lcom/riola/player/MainActivity$19;
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

.field final synthetic val$restyle:Lcom/riola/player/Themes$OnChosen;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 489
    iput-object p1, p0, Lcom/riola/player/MainActivity$19;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$19;->val$holder:[Landroid/app/AlertDialog;

    iput-object p3, p0, Lcom/riola/player/MainActivity$19;->val$restyle:Lcom/riola/player/Themes$OnChosen;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 491
    iget-object p1, p0, Lcom/riola/player/MainActivity$19;->val$holder:[Landroid/app/AlertDialog;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 492
    :cond_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$19;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;

    move-result-object v0

    iget-object v1, p0, Lcom/riola/player/MainActivity$19;->val$restyle:Lcom/riola/player/Themes$OnChosen;

    invoke-static {p1, v0, v1}, Lcom/riola/player/Themes;->colour(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V

    .line 493
    return-void
.end method
