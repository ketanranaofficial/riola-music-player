.class Lcom/riola/player/AbDialog$16;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$act:Landroid/app/Activity;


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 188
    iput-object p1, p0, Lcom/riola/player/AbDialog$16;->val$act:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 0

    .line 190
    iget-object p1, p0, Lcom/riola/player/AbDialog$16;->val$act:Landroid/app/Activity;

    const-string p2, "Cannot play this file"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 191
    const/4 p1, 0x1

    return p1
.end method
