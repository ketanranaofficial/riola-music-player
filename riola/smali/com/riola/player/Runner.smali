.class public final Lcom/riola/player/Runner;
.super Ljava/lang/Object;
.source "Runner.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/Runner$OnStarted;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V
    .locals 0

    .line 23
    invoke-static {p0, p1, p2, p3}, Lcom/riola/player/Runner;->go(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    return-void
.end method

.method static synthetic access$100(Landroid/app/Activity;Lcom/riola/player/Program;ILjava/util/List;ILcom/riola/player/Runner$OnStarted;)V
    .locals 0

    .line 23
    invoke-static/range {p0 .. p5}, Lcom/riola/player/Runner;->warn(Landroid/app/Activity;Lcom/riola/player/Program;ILjava/util/List;ILcom/riola/player/Runner$OnStarted;)V

    return-void
.end method

.method public static askNotificationPermission(Landroid/app/Activity;)V
    .locals 2

    .line 151
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_0

    .line 152
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Landroid/app/Activity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 154
    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x67

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V

    .line 156
    :cond_0
    return-void
.end method

.method private static explainSilentNotifications(Landroid/app/Activity;)V
    .locals 5

    .line 120
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    .line 121
    invoke-virtual {v0}, Lcom/riola/player/Prefs;->notifNagged()Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    .line 122
    :cond_0
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/riola/player/Runner$4;

    invoke-direct {v2, p0, v0}, Lcom/riola/player/Runner$4;-><init>(Landroid/app/Activity;Lcom/riola/player/Prefs;)V

    const-wide/16 v3, 0xfa0

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 148
    return-void
.end method

.method private static go(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V
    .locals 2

    .line 103
    invoke-static {p0}, Lcom/riola/player/Runner;->askNotificationPermission(Landroid/app/Activity;)V

    .line 104
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lcom/riola/player/Program;->lastRun:J

    .line 105
    invoke-static {p0}, Lcom/riola/player/Store;->savePrograms(Landroid/content/Context;)V

    .line 106
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/riola/player/Engine;->start(Lcom/riola/player/Program;I)V

    .line 107
    invoke-static {p0}, Lcom/riola/player/PlayerBar;->startService(Landroid/app/Activity;)V

    .line 108
    if-eqz p3, :cond_0

    invoke-interface {p3}, Lcom/riola/player/Runner$OnStarted;->started()V

    .line 109
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Runner;->explainSilentNotifications(Landroid/app/Activity;)V

    .line 110
    return-void
.end method

.method public static play(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V
    .locals 2

    .line 30
    if-nez p1, :cond_0

    return-void

    .line 31
    :cond_0
    invoke-virtual {p1}, Lcom/riola/player/Program;->enabledCount()I

    move-result v0

    if-nez v0, :cond_1

    .line 32
    const-string p1, "Add a step first"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 33
    return-void

    .line 35
    :cond_1
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/Runner$1;

    invoke-direct {v1, p1, p0, p2, p3}, Lcom/riola/player/Runner$1;-><init>(Lcom/riola/player/Program;Landroid/app/Activity;ILcom/riola/player/Runner$OnStarted;)V

    const-string p0, "riola-precheck"

    invoke-direct {v0, v1, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 68
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 69
    return-void
.end method

.method private static warn(Landroid/app/Activity;Lcom/riola/player/Program;ILjava/util/List;ILcom/riola/player/Runner$OnStarted;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/riola/player/Program;",
            "I",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;I",
            "Lcom/riola/player/Runner$OnStarted;",
            ")V"
        }
    .end annotation

    .line 73
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 74
    if-nez p4, :cond_0

    .line 75
    const-string v1, "Nothing in this program can play right now:\n\n"

    goto :goto_0

    .line 76
    :cond_0
    const-string v1, "These steps cannot play, so they will be skipped:\n\n"

    .line 74
    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 77
    const/4 v1, 0x0

    :goto_1
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x6

    if-ge v1, v2, :cond_1

    if-ge v1, v3, :cond_1

    const-string v2, "    "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-interface {p3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 78
    :cond_1
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v1

    if-le v1, v3, :cond_2

    const-string v1, "    ...and "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v2

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " more\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 79
    :cond_2
    const-string v1, "\nThe file may have been deleted or moved, or it lives on storage that is not available. Open the program and point those steps at a file again."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 82
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 83
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    const-string p3, "1 step cannot play"

    goto :goto_2

    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result p3

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v2, " steps cannot play"

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    :goto_2
    invoke-virtual {v1, p3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p3

    .line 84
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p3

    .line 85
    const-string v0, "Cancel"

    const/4 v1, 0x0

    invoke-virtual {p3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p3

    .line 87
    instance-of v0, p0, Lcom/riola/player/EditorActivity;

    if-nez v0, :cond_4

    .line 88
    new-instance v0, Lcom/riola/player/Runner$2;

    invoke-direct {v0, p0, p1}, Lcom/riola/player/Runner$2;-><init>(Landroid/app/Activity;Lcom/riola/player/Program;)V

    const-string v1, "Open program"

    invoke-virtual {p3, v1, v0}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 94
    :cond_4
    if-lez p4, :cond_5

    .line 95
    new-instance p4, Lcom/riola/player/Runner$3;

    invoke-direct {p4, p0, p1, p2, p5}, Lcom/riola/player/Runner$3;-><init>(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V

    const-string p0, "Play anyway"

    invoke-virtual {p3, p0, p4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 99
    :cond_5
    invoke-virtual {p3}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 100
    return-void
.end method
