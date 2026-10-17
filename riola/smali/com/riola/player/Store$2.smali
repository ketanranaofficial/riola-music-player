.class Lcom/riola/player/Store$2;
.super Ljava/lang/Object;
.source "Store.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Store;->view(ILjava/lang/String;)Ljava/util/List;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/riola/player/Track;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic val$m:I


# direct methods
.method constructor <init>(I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 196
    iput p1, p0, Lcom/riola/player/Store$2;->val$m:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/riola/player/Track;Lcom/riola/player/Track;)I
    .locals 2

    .line 198
    iget v0, p0, Lcom/riola/player/Store$2;->val$m:I

    packed-switch v0, :pswitch_data_0

    .line 206
    iget-wide v0, p1, Lcom/riola/player/Track;->durMs:J

    iget-wide p1, p2, Lcom/riola/player/Track;->durMs:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 205
    :pswitch_0
    iget-wide v0, p2, Lcom/riola/player/Track;->durMs:J

    iget-wide p1, p1, Lcom/riola/player/Track;->durMs:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 204
    :pswitch_1
    iget-wide v0, p1, Lcom/riola/player/Track;->modifiedAt:J

    iget-wide p1, p2, Lcom/riola/player/Track;->modifiedAt:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 203
    :pswitch_2
    iget-wide v0, p2, Lcom/riola/player/Track;->modifiedAt:J

    iget-wide p1, p1, Lcom/riola/player/Track;->modifiedAt:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 202
    :pswitch_3
    iget-wide v0, p1, Lcom/riola/player/Track;->addedAt:J

    iget-wide p1, p2, Lcom/riola/player/Track;->addedAt:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 201
    :pswitch_4
    iget-wide v0, p2, Lcom/riola/player/Track;->addedAt:J

    iget-wide p1, p1, Lcom/riola/player/Track;->addedAt:J

    invoke-static {v0, v1, p1, p2}, Lcom/riola/player/Store;->access$000(JJ)I

    move-result p1

    return p1

    .line 200
    :pswitch_5
    invoke-virtual {p2}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result p1

    return p1

    .line 199
    :pswitch_6
    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result p1

    return p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 196
    check-cast p1, Lcom/riola/player/Track;

    check-cast p2, Lcom/riola/player/Track;

    invoke-virtual {p0, p1, p2}, Lcom/riola/player/Store$2;->compare(Lcom/riola/player/Track;Lcom/riola/player/Track;)I

    move-result p1

    return p1
.end method
