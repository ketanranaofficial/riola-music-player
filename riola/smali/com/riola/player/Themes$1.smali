.class Lcom/riola/player/Themes$1;
.super Ljava/lang/Object;
.source "Themes.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Themes;->colour(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Themes$OnChosen;

.field final synthetic val$colour:I

.field final synthetic val$holder:[Landroid/app/AlertDialog;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;


# direct methods
.method constructor <init>(Lcom/riola/player/Prefs;I[Landroid/app/AlertDialog;Lcom/riola/player/Themes$OnChosen;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 41
    iput-object p1, p0, Lcom/riola/player/Themes$1;->val$prefs:Lcom/riola/player/Prefs;

    iput p2, p0, Lcom/riola/player/Themes$1;->val$colour:I

    iput-object p3, p0, Lcom/riola/player/Themes$1;->val$holder:[Landroid/app/AlertDialog;

    iput-object p4, p0, Lcom/riola/player/Themes$1;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 43
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 44
    iget-object p1, p0, Lcom/riola/player/Themes$1;->val$prefs:Lcom/riola/player/Prefs;

    iget v0, p0, Lcom/riola/player/Themes$1;->val$colour:I

    invoke-virtual {p1, v0}, Lcom/riola/player/Prefs;->accent(I)V

    .line 45
    iget-object p1, p0, Lcom/riola/player/Themes$1;->val$holder:[Landroid/app/AlertDialog;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 46
    :cond_0
    iget-object p1, p0, Lcom/riola/player/Themes$1;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-interface {p1}, Lcom/riola/player/Themes$OnChosen;->chosen()V

    .line 47
    return-void
.end method
