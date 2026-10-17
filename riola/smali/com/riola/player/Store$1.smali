.class Lcom/riola/player/Store$1;
.super Ljava/lang/Object;
.source "Store.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Store;->sortPrograms()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/riola/player/Program;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 140
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/riola/player/Program;Lcom/riola/player/Program;)I
    .locals 4

    .line 142
    iget-wide v0, p1, Lcom/riola/player/Program;->updated:J

    iget-wide v2, p1, Lcom/riola/player/Program;->lastRun:J

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    iget-wide v2, p2, Lcom/riola/player/Program;->updated:J

    iget-wide p1, p2, Lcom/riola/player/Program;->lastRun:J

    invoke-static {v2, v3, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    .line 143
    cmp-long p1, v0, p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    if-lez p1, :cond_1

    const/4 p1, -0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x1

    :goto_0
    return p1
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 140
    check-cast p1, Lcom/riola/player/Program;

    check-cast p2, Lcom/riola/player/Program;

    invoke-virtual {p0, p1, p2}, Lcom/riola/player/Store$1;->compare(Lcom/riola/player/Program;Lcom/riola/player/Program;)I

    move-result p1

    return p1
.end method
