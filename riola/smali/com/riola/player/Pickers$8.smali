.class Lcom/riola/player/Pickers$8;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Lcom/riola/player/Ui$OnValue;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->position(Landroid/app/Activity;Ljava/lang/String;JJLcom/riola/player/Pickers$OnMs;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cap:J

.field final synthetic val$shown:Landroid/widget/TextView;

.field final synthetic val$value:[J


# direct methods
.method constructor <init>([JJLandroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 129
    iput-object p1, p0, Lcom/riola/player/Pickers$8;->val$value:[J

    iput-wide p2, p0, Lcom/riola/player/Pickers$8;->val$cap:J

    iput-object p4, p0, Lcom/riola/player/Pickers$8;->val$shown:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 10

    .line 131
    iget-object v0, p0, Lcom/riola/player/Pickers$8;->val$value:[J

    iget-wide v1, p0, Lcom/riola/player/Pickers$8;->val$cap:J

    const/4 v3, 0x0

    aget-wide v4, v0, v3

    const-wide/32 v6, 0xea60

    div-long/2addr v4, v6

    mul-long/2addr v4, v6

    int-to-long v6, p1

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    add-long/2addr v4, v6

    invoke-static {v1, v2, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v1

    aput-wide v1, v0, v3

    .line 132
    iget-object p1, p0, Lcom/riola/player/Pickers$8;->val$shown:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/riola/player/Pickers$8;->val$value:[J

    aget-wide v1, v0, v3

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 133
    return-void
.end method
