.class Lcom/riola/player/Pickers$7;
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

    .line 123
    iput-object p1, p0, Lcom/riola/player/Pickers$7;->val$value:[J

    iput-wide p2, p0, Lcom/riola/player/Pickers$7;->val$cap:J

    iput-object p4, p0, Lcom/riola/player/Pickers$7;->val$shown:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 9

    .line 125
    iget-object v0, p0, Lcom/riola/player/Pickers$7;->val$value:[J

    iget-wide v1, p0, Lcom/riola/player/Pickers$7;->val$cap:J

    int-to-long v3, p1

    const-wide/32 v5, 0xea60

    mul-long/2addr v3, v5

    const/4 p1, 0x0

    aget-wide v7, v0, p1

    rem-long/2addr v7, v5

    add-long/2addr v3, v7

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v1

    aput-wide v1, v0, p1

    .line 126
    iget-object v0, p0, Lcom/riola/player/Pickers$7;->val$shown:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/riola/player/Pickers$7;->val$value:[J

    aget-wide v2, v1, p1

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 127
    return-void
.end method
