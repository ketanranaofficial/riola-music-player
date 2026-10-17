.class Lcom/riola/player/Ui$2;
.super Ljava/lang/Object;
.source "Ui.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Ui$OnToggle;


# direct methods
.method constructor <init>(Lcom/riola/player/Ui$OnToggle;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 614
    iput-object p1, p0, Lcom/riola/player/Ui$2;->val$cb:Lcom/riola/player/Ui$OnToggle;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 0

    .line 615
    iget-object p1, p0, Lcom/riola/player/Ui$2;->val$cb:Lcom/riola/player/Ui$OnToggle;

    invoke-interface {p1, p2}, Lcom/riola/player/Ui$OnToggle;->set(Z)V

    return-void
.end method
