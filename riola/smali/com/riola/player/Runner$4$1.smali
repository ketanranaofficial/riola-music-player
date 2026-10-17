.class Lcom/riola/player/Runner$4$1;
.super Ljava/lang/Object;
.source "Runner.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Runner$4;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/Runner$4;


# direct methods
.method constructor <init>(Lcom/riola/player/Runner$4;)V
    .locals 0

    .line 136
    iput-object p1, p0, Lcom/riola/player/Runner$4$1;->this$0:Lcom/riola/player/Runner$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 139
    :try_start_0
    iget-object p1, p0, Lcom/riola/player/Runner$4$1;->this$0:Lcom/riola/player/Runner$4;

    iget-object p1, p1, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    new-instance p2, Landroid/content/Intent;

    const-string v0, "android.settings.APP_NOTIFICATION_SETTINGS"

    invoke-direct {p2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v0, "android.provider.extra.APP_PACKAGE"

    iget-object v1, p0, Lcom/riola/player/Runner$4$1;->this$0:Lcom/riola/player/Runner$4;

    iget-object v1, v1, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    .line 140
    invoke-virtual {v1}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    .line 139
    invoke-virtual {p1, p2}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 143
    goto :goto_0

    .line 141
    :catch_0
    move-exception p1

    .line 142
    iget-object p1, p0, Lcom/riola/player/Runner$4$1;->this$0:Lcom/riola/player/Runner$4;

    iget-object p1, p1, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    const-string p2, "Could not open notification settings"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 144
    :goto_0
    return-void
.end method
