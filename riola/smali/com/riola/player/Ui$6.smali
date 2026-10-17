.class Lcom/riola/player/Ui$6;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Ui;->seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Ui$OnPick;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/riola/player/Ui$OnPick;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 700
    iput-object p1, p0, Lcom/riola/player/Ui$6;->val$cb:Lcom/riola/player/Ui$OnPick;

    iput p2, p0, Lcom/riola/player/Ui$6;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 701
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/Ui$6;->val$cb:Lcom/riola/player/Ui$OnPick;

    iget v0, p0, Lcom/riola/player/Ui$6;->val$index:I

    invoke-interface {p1, v0}, Lcom/riola/player/Ui$OnPick;->set(I)V

    return-void
.end method
