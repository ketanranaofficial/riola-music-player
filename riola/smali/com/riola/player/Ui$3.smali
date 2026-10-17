.class Lcom/riola/player/Ui$3;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$sw:Landroid/widget/Switch;


# direct methods
.method constructor <init>(Landroid/widget/Switch;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 624
    iput-object p1, p0, Lcom/riola/player/Ui$3;->val$sw:Landroid/widget/Switch;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .line 625
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    iget-object p1, p0, Lcom/riola/player/Ui$3;->val$sw:Landroid/widget/Switch;

    invoke-virtual {p1}, Landroid/widget/Switch;->toggle()V

    return-void
.end method
