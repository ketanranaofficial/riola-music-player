.class Lcom/riola/player/Pickers$4;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->fillDuration(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$again:Ljava/lang/Runnable;

.field final synthetic val$secs:I

.field final synthetic val$value:[J


# direct methods
.method constructor <init>([JILjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 73
    iput-object p1, p0, Lcom/riola/player/Pickers$4;->val$value:[J

    iput p2, p0, Lcom/riola/player/Pickers$4;->val$secs:I

    iput-object p3, p0, Lcom/riola/player/Pickers$4;->val$again:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .line 75
    iget-object p1, p0, Lcom/riola/player/Pickers$4;->val$value:[J

    iget v0, p0, Lcom/riola/player/Pickers$4;->val$secs:I

    int-to-long v0, v0

    const-wide/16 v2, 0x3e8

    mul-long/2addr v0, v2

    const/4 v2, 0x0

    aput-wide v0, p1, v2

    .line 76
    iget-object p1, p0, Lcom/riola/player/Pickers$4;->val$again:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 77
    return-void
.end method
