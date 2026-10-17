.class Lcom/riola/player/Pickers$5;
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

    .line 87
    iput-object p1, p0, Lcom/riola/player/Pickers$5;->val$value:[J

    iput-object p2, p0, Lcom/riola/player/Pickers$5;->val$shown:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 7

    .line 89
    iget-object v0, p0, Lcom/riola/player/Pickers$5;->val$value:[J

    int-to-long v1, p1

    const-wide/32 v3, 0xea60

    mul-long/2addr v1, v3

    const/4 p1, 0x0

    aget-wide v5, v0, p1

    rem-long/2addr v5, v3

    add-long/2addr v1, v5

    aput-wide v1, v0, p1

    .line 90
    iget-object p1, p0, Lcom/riola/player/Pickers$5;->val$shown:Landroid/widget/TextView;

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 91
    return-void
.end method
