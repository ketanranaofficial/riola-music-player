.class Lcom/riola/player/Pickers$2;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->duration(Landroid/app/Activity;Ljava/lang/String;JLcom/riola/player/Pickers$OnMs;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$box:Landroid/widget/LinearLayout;

.field final synthetic val$render:[Ljava/lang/Runnable;

.field final synthetic val$value:[J


# direct methods
.method constructor <init>(Landroid/app/Activity;Landroid/widget/LinearLayout;[J[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 40
    iput-object p1, p0, Lcom/riola/player/Pickers$2;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/Pickers$2;->val$box:Landroid/widget/LinearLayout;

    iput-object p3, p0, Lcom/riola/player/Pickers$2;->val$value:[J

    iput-object p4, p0, Lcom/riola/player/Pickers$2;->val$render:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 41
    iget-object v0, p0, Lcom/riola/player/Pickers$2;->val$a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/riola/player/Pickers$2;->val$box:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/riola/player/Pickers$2;->val$value:[J

    iget-object v3, p0, Lcom/riola/player/Pickers$2;->val$render:[Ljava/lang/Runnable;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    invoke-static {v0, v1, v2, v3}, Lcom/riola/player/Pickers;->access$000(Landroid/app/Activity;Landroid/widget/LinearLayout;[JLjava/lang/Runnable;)V

    return-void
.end method
