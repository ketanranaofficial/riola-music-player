.class Lcom/riola/player/Pickers$10;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$cb:Lcom/riola/player/Pickers$OnText;

.field final synthetic val$in:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Landroid/widget/EditText;Landroid/app/Activity;Lcom/riola/player/Pickers$OnText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 160
    iput-object p1, p0, Lcom/riola/player/Pickers$10;->val$in:Landroid/widget/EditText;

    iput-object p2, p0, Lcom/riola/player/Pickers$10;->val$a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/riola/player/Pickers$10;->val$cb:Lcom/riola/player/Pickers$OnText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 162
    iget-object p1, p0, Lcom/riola/player/Pickers$10;->val$in:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    .line 163
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    if-nez p2, :cond_0

    iget-object p1, p0, Lcom/riola/player/Pickers$10;->val$a:Landroid/app/Activity;

    const-string p2, "Give it a name"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    .line 164
    :cond_0
    iget-object p2, p0, Lcom/riola/player/Pickers$10;->val$cb:Lcom/riola/player/Pickers$OnText;

    invoke-interface {p2, p1}, Lcom/riola/player/Pickers$OnText;->picked(Ljava/lang/String;)V

    .line 165
    return-void
.end method
