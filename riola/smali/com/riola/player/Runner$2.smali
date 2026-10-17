.class Lcom/riola/player/Runner$2;
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

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Program;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 88
    iput-object p1, p0, Lcom/riola/player/Runner$2;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/Runner$2;->val$p:Lcom/riola/player/Program;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 90
    iget-object p1, p0, Lcom/riola/player/Runner$2;->val$a:Landroid/app/Activity;

    new-instance p2, Landroid/content/Intent;

    iget-object v0, p0, Lcom/riola/player/Runner$2;->val$a:Landroid/app/Activity;

    const-class v1, Lcom/riola/player/EditorActivity;

    invoke-direct {p2, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    iget-object v0, p0, Lcom/riola/player/Runner$2;->val$p:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->id:Ljava/lang/String;

    const-string v1, "id"

    invoke-virtual {p2, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 91
    return-void
.end method
