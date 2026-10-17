.class Lcom/riola/player/TrackPicker$2;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/TrackPicker;->show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$fill:[Ljava/lang/Runnable;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Prefs;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 78
    iput-object p1, p0, Lcom/riola/player/TrackPicker$2;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/TrackPicker$2;->val$prefs:Lcom/riola/player/Prefs;

    iput-object p3, p0, Lcom/riola/player/TrackPicker$2;->val$fill:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 80
    iget-object p1, p0, Lcom/riola/player/TrackPicker$2;->val$a:Landroid/app/Activity;

    invoke-static {p1}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string v0, "Sort"

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    sget-object v0, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    new-instance v1, Lcom/riola/player/TrackPicker$2$1;

    invoke-direct {v1, p0}, Lcom/riola/player/TrackPicker$2$1;-><init>(Lcom/riola/player/TrackPicker$2;)V

    invoke-virtual {p1, v0, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 85
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 86
    return-void
.end method
