.class Lcom/riola/player/AbDialog$13;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

    .line 159
    iput-object p1, p0, Lcom/riola/player/AbDialog$13;->val$mp:Landroid/media/MediaPlayer;

    iput-object p2, p0, Lcom/riola/player/AbDialog$13;->val$ready:[Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 2

    .line 161
    if-eqz p3, :cond_0

    iget-object p1, p0, Lcom/riola/player/AbDialog$13;->val$mp:Landroid/media/MediaPlayer;

    iget-object p3, p0, Lcom/riola/player/AbDialog$13;->val$ready:[Z

    int-to-long v0, p2

    invoke-static {p1, p3, v0, v1}, Lcom/riola/player/AbDialog;->access$200(Landroid/media/MediaPlayer;[ZJ)V

    .line 162
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 163
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 164
    return-void
.end method
