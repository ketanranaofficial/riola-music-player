.class Lcom/riola/player/Runner$3;
.super Ljava/lang/Object;
.source "Runner.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Runner;->warn(Landroid/app/Activity;Lcom/riola/player/Program;ILjava/util/List;ILcom/riola/player/Runner$OnStarted;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$cb:Lcom/riola/player/Runner$OnStarted;

.field final synthetic val$from:I

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 95
    iput-object p1, p0, Lcom/riola/player/Runner$3;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/Runner$3;->val$p:Lcom/riola/player/Program;

    iput p3, p0, Lcom/riola/player/Runner$3;->val$from:I

    iput-object p4, p0, Lcom/riola/player/Runner$3;->val$cb:Lcom/riola/player/Runner$OnStarted;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 96
    iget-object p1, p0, Lcom/riola/player/Runner$3;->val$a:Landroid/app/Activity;

    iget-object p2, p0, Lcom/riola/player/Runner$3;->val$p:Lcom/riola/player/Program;

    iget v0, p0, Lcom/riola/player/Runner$3;->val$from:I

    iget-object v1, p0, Lcom/riola/player/Runner$3;->val$cb:Lcom/riola/player/Runner$OnStarted;

    invoke-static {p1, p2, v0, v1}, Lcom/riola/player/Runner;->access$000(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    return-void
.end method
