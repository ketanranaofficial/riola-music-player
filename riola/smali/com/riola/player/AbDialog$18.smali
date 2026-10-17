.class Lcom/riola/player/AbDialog$18;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->markRow(Landroid/app/Activity;Landroid/widget/TextView;Landroid/view/View$OnClickListener;Lcom/riola/player/AbDialog$Nudge;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$n:Lcom/riola/player/AbDialog$Nudge;


# direct methods
.method constructor <init>(Lcom/riola/player/AbDialog$Nudge;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 213
    iput-object p1, p0, Lcom/riola/player/AbDialog$18;->val$n:Lcom/riola/player/AbDialog$Nudge;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 214
    iget-object p1, p0, Lcom/riola/player/AbDialog$18;->val$n:Lcom/riola/player/AbDialog$Nudge;

    const/16 v0, 0x3e8

    invoke-interface {p1, v0}, Lcom/riola/player/AbDialog$Nudge;->by(I)V

    return-void
.end method
