.class Lcom/riola/player/TrackPicker$7;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/TrackPicker;->row(Landroid/app/Activity;Lcom/riola/player/Track;Z[ZLjava/util/Set;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;Ljava/lang/Runnable;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$again:Ljava/lang/Runnable;

.field final synthetic val$allowMultiple:Z

.field final synthetic val$choosing:[Z

.field final synthetic val$chosen:Ljava/util/Set;

.field final synthetic val$key:Ljava/lang/String;


# direct methods
.method constructor <init>(Z[ZLjava/util/Set;Ljava/lang/String;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 176
    iput-boolean p1, p0, Lcom/riola/player/TrackPicker$7;->val$allowMultiple:Z

    iput-object p2, p0, Lcom/riola/player/TrackPicker$7;->val$choosing:[Z

    iput-object p3, p0, Lcom/riola/player/TrackPicker$7;->val$chosen:Ljava/util/Set;

    iput-object p4, p0, Lcom/riola/player/TrackPicker$7;->val$key:Ljava/lang/String;

    iput-object p5, p0, Lcom/riola/player/TrackPicker$7;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 178
    iget-boolean v0, p0, Lcom/riola/player/TrackPicker$7;->val$allowMultiple:Z

    if-nez v0, :cond_0

    return-void

    .line 179
    :cond_0
    invoke-static {p1}, Lcom/riola/player/Ui;->buzz(Landroid/view/View;)V

    .line 180
    iget-object p1, p0, Lcom/riola/player/TrackPicker$7;->val$choosing:[Z

    const/4 v0, 0x0

    const/4 v1, 0x1

    aput-boolean v1, p1, v0

    .line 181
    iget-object p1, p0, Lcom/riola/player/TrackPicker$7;->val$chosen:Ljava/util/Set;

    iget-object v0, p0, Lcom/riola/player/TrackPicker$7;->val$key:Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/TrackPicker$7;->val$chosen:Ljava/util/Set;

    iget-object v0, p0, Lcom/riola/player/TrackPicker$7;->val$key:Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 182
    :cond_1
    iget-object p1, p0, Lcom/riola/player/TrackPicker$7;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 183
    return-void
.end method
