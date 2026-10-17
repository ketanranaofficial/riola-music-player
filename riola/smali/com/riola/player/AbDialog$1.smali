.class Lcom/riola/player/AbDialog$1;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$mp:Landroid/media/MediaPlayer;

.field final synthetic val$ready:[Z


# direct methods
.method constructor <init>(Landroid/media/MediaPlayer;[Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 61
    iput-object p1, p0, Lcom/riola/player/AbDialog$1;->val$mp:Landroid/media/MediaPlayer;

    iput-object p2, p0, Lcom/riola/player/AbDialog$1;->val$ready:[Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 62
    iget-object p1, p0, Lcom/riola/player/AbDialog$1;->val$mp:Landroid/media/MediaPlayer;

    iget-object v0, p0, Lcom/riola/player/AbDialog$1;->val$ready:[Z

    const/16 v1, -0x1388

    invoke-static {p1, v0, v1}, Lcom/riola/player/AbDialog;->access$000(Landroid/media/MediaPlayer;[ZI)V

    return-void
.end method
