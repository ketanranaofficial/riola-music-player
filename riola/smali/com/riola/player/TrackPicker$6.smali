.class Lcom/riola/player/TrackPicker$6;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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

.field final synthetic val$cb:Lcom/riola/player/TrackPicker$OnPicked;

.field final synthetic val$chosen:Ljava/util/Set;


# direct methods
.method constructor <init>(Ljava/util/Set;Landroid/app/Activity;Lcom/riola/player/TrackPicker$OnPicked;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 144
    iput-object p1, p0, Lcom/riola/player/TrackPicker$6;->val$chosen:Ljava/util/Set;

    iput-object p2, p0, Lcom/riola/player/TrackPicker$6;->val$a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/riola/player/TrackPicker$6;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .line 146
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 147
    iget-object p2, p0, Lcom/riola/player/TrackPicker$6;->val$chosen:Ljava/util/Set;

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 148
    invoke-static {v0}, Lcom/riola/player/Store;->byKey(Ljava/lang/String;)Lcom/riola/player/Track;

    move-result-object v0

    .line 149
    if-eqz v0, :cond_0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 150
    :cond_0
    goto :goto_0

    .line 151
    :cond_1
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lcom/riola/player/TrackPicker$6;->val$a:Landroid/app/Activity;

    const-string p2, "Nothing was selected"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    .line 152
    :cond_2
    iget-object p2, p0, Lcom/riola/player/TrackPicker$6;->val$cb:Lcom/riola/player/TrackPicker$OnPicked;

    invoke-interface {p2, p1}, Lcom/riola/player/TrackPicker$OnPicked;->picked(Ljava/util/List;)V

    .line 153
    :goto_1
    return-void
.end method
