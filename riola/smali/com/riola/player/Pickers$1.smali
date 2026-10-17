.class Lcom/riola/player/Pickers$1;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Lcom/riola/player/TrackPicker$OnPicked;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->track(Landroid/app/Activity;Ljava/lang/String;Lcom/riola/player/Pickers$OnTrack;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Pickers$OnTrack;


# direct methods
.method constructor <init>(Lcom/riola/player/Pickers$OnTrack;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 24
    iput-object p1, p0, Lcom/riola/player/Pickers$1;->val$cb:Lcom/riola/player/Pickers$OnTrack;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/riola/player/Track;",
            ">;)V"
        }
    .end annotation

    .line 26
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/Pickers$1;->val$cb:Lcom/riola/player/Pickers$OnTrack;

    const/4 v1, 0x0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/riola/player/Track;

    invoke-interface {v0, p1}, Lcom/riola/player/Pickers$OnTrack;->picked(Lcom/riola/player/Track;)V

    .line 27
    :cond_0
    return-void
.end method
