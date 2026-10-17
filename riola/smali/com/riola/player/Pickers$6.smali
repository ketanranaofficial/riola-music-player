.class Lcom/riola/player/Pickers$6;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Lcom/riola/player/Ui$OnValue;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->fillDuration(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$shown:Landroid/widget/TextView;

.field final synthetic val$value:[J


# direct methods
.method constructor <init>([JLandroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 94
    iput-object p1, p0, Lcom/riola/player/Pickers$6;->val$value:[J

    iput-object p2, p0, Lcom/riola/player/Pickers$6;->val$shown:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 8

    .line 96
    iget-object v0, p0, Lcom/riola/player/Pickers$6;->val$value:[J

    const/4 v1, 0x0

    aget-wide v2, v0, v1

    const-wide/32 v4, 0xea60

    div-long/2addr v2, v4

    mul-long/2addr v2, v4

    int-to-long v4, p1

    const-wide/16 v6, 0x3e8

    mul-long/2addr v4, v6

    add-long/2addr v2, v4

    aput-wide v2, v0, v1

    .line 97
    iget-object p1, p0, Lcom/riola/player/Pickers$6;->val$shown:Landroid/widget/TextView;

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 98
    return-void
.end method
