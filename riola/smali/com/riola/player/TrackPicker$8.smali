.class Lcom/riola/player/TrackPicker$8;
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

.field final synthetic val$cb:Lcom/riola/player/TrackPicker$OnPicked;

.field final synthetic val$choosing:[Z

.field final synthetic val$chosen:Ljava/util/Set;

.field final synthetic val$holder:[Landroid/app/AlertDialog;

.field final synthetic val$key:Ljava/lang/String;

.field final synthetic val$t:Lcom/riola/player/Track;


# direct methods
.method constructor <init>(Z[ZLjava/util/Set;Ljava/lang/String;Ljava/lang/Runnable;Lcom/riola/player/Track;[Landroid/app/AlertDialog;Lcom/riola/player/TrackPicker$OnPicked;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 196
    iput-boolean p1, p0, Lcom/riola/player/TrackPicker$8;->val$allowMultiple:Z

    iput-object p2, p0, Lcom/riola/player/TrackPicker$8;->val$choosing:[Z

    iput-object p3, p0, Lcom/riola/player/TrackPicker$8;->val$chosen:Ljava/util/Set;

    iput-object p4, p0, Lcom/riola/player/TrackPicker$8;->val$key:Ljava/lang/String;

    iput-object p5, p0, Lcom/riola/player/TrackPicker$8;->val$again:Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/riola/player/TrackPicker$8;->val$t:Lcom/riola/player/Track;

    iput-object p7, p0, Lcom/riola/player/TrackPicker$8;->val$holder:[Landroid/app/AlertDialog;

    iput-object p8, p0, Lcom/riola/player/TrackPicker$8;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 198
    iget-boolean p1, p0, Lcom/riola/player/TrackPicker$8;->val$allowMultiple:Z

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/TrackPicker$8;->val$choosing:[Z

    aget-boolean p1, p1, v0

    if-eqz p1, :cond_1

    .line 199
    iget-object p1, p0, Lcom/riola/player/TrackPicker$8;->val$chosen:Ljava/util/Set;

    iget-object v0, p0, Lcom/riola/player/TrackPicker$8;->val$key:Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/TrackPicker$8;->val$chosen:Ljava/util/Set;

    iget-object v0, p0, Lcom/riola/player/TrackPicker$8;->val$key:Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 200
    :cond_0
    iget-object p1, p0, Lcom/riola/player/TrackPicker$8;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 201
    return-void

    .line 203
    :cond_1
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 204
    iget-object v1, p0, Lcom/riola/player/TrackPicker$8;->val$t:Lcom/riola/player/Track;

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 205
    iget-object v1, p0, Lcom/riola/player/TrackPicker$8;->val$holder:[Landroid/app/AlertDialog;

    aget-object v0, v1, v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 206
    :cond_2
    iget-object v0, p0, Lcom/riola/player/TrackPicker$8;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    invoke-interface {v0, p1}, Lcom/riola/player/TrackPicker$OnPicked;->picked(Ljava/util/List;)V

    .line 207
    return-void
.end method
