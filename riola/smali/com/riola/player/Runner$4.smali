.class Lcom/riola/player/Runner$4;
.super Ljava/lang/Object;
.source "Runner.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Runner;->explainSilentNotifications(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Prefs;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 122
    iput-object p1, p0, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/Runner$4;->val$prefs:Lcom/riola/player/Prefs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 124
    iget-object v0, p0, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 125
    :cond_0
    iget-object v0, p0, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    const-string v1, "notification"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 126
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/app/NotificationManager;->areNotificationsEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    .line 127
    :cond_1
    iget-object v0, p0, Lcom/riola/player/Runner$4;->val$prefs:Lcom/riola/player/Prefs;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/riola/player/Prefs;->notifNagged(Z)V

    .line 128
    iget-object v0, p0, Lcom/riola/player/Runner$4;->val$a:Landroid/app/Activity;

    invoke-static {v0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 129
    const-string v1, "Notifications are off"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 130
    const-string v1, "Riola cannot show its playback notification, so its controls will not appear in the notification shade. The program still plays normally, and your phone\'s own media controls may still work. Some phones switch notifications off for apps installed outside the store. You can turn them back on in Android settings."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 135
    const-string v1, "Not now"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/riola/player/Runner$4$1;

    invoke-direct {v1, p0}, Lcom/riola/player/Runner$4$1;-><init>(Lcom/riola/player/Runner$4;)V

    .line 136
    const-string v2, "Open settings"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 145
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 146
    return-void

    .line 126
    :cond_2
    :goto_0
    return-void

    .line 124
    :cond_3
    :goto_1
    return-void
.end method
