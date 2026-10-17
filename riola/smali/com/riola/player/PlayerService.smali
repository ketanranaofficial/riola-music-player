.class public Lcom/riola/player/PlayerService;
.super Landroid/app/Service;
.source "PlayerService.java"

# interfaces
.implements Lcom/riola/player/Engine$Listener;


# static fields
.field public static final ACT_ATTACH:Ljava/lang/String; = "riola.attach"

.field public static final ACT_NEXT:Ljava/lang/String; = "riola.next"

.field public static final ACT_PREV:Ljava/lang/String; = "riola.prev"

.field public static final ACT_STOP:Ljava/lang/String; = "riola.stop"

.field public static final ACT_TOGGLE:Ljava/lang/String; = "riola.toggle"

.field private static final CHANNEL:Ljava/lang/String; = "riola.playback"

.field private static final NID:I = 0x1069


# instance fields
.field private am:Landroid/media/AudioManager;

.field private engine:Lcom/riola/player/Engine;

.field private focus:Landroid/media/AudioFocusRequest;

.field private lastKey:Ljava/lang/String;

.field private lastPost:J

.field private noisy:Landroid/content/BroadcastReceiver;

.field private pausedByFocus:Z

.field private prefs:Lcom/riola/player/Prefs;

.field private session:Landroid/media/session/MediaSession;

.field private started:Z

.field private wakeLock:Landroid/os/PowerManager$WakeLock;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 28
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 49
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/PlayerService;->lastKey:Ljava/lang/String;

    return-void
.end method

.method private abandonFocus()V
    .locals 2

    .line 267
    iget-object v0, p0, Lcom/riola/player/PlayerService;->focus:Landroid/media/AudioFocusRequest;

    if-eqz v0, :cond_0

    .line 268
    iget-object v1, p0, Lcom/riola/player/PlayerService;->am:Landroid/media/AudioManager;

    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->abandonAudioFocusRequest(Landroid/media/AudioFocusRequest;)I

    .line 269
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/riola/player/PlayerService;->focus:Landroid/media/AudioFocusRequest;

    .line 271
    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/PlayerService;)Lcom/riola/player/Engine;
    .locals 0

    .line 28
    iget-object p0, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    return-object p0
.end method

.method static synthetic access$100(Lcom/riola/player/PlayerService;)V
    .locals 0

    .line 28
    invoke-direct {p0}, Lcom/riola/player/PlayerService;->shutdown()V

    return-void
.end method

.method static synthetic access$200(Lcom/riola/player/PlayerService;)Lcom/riola/player/Prefs;
    .locals 0

    .line 28
    iget-object p0, p0, Lcom/riola/player/PlayerService;->prefs:Lcom/riola/player/Prefs;

    return-object p0
.end method

.method static synthetic access$300(Lcom/riola/player/PlayerService;)Z
    .locals 0

    .line 28
    iget-boolean p0, p0, Lcom/riola/player/PlayerService;->pausedByFocus:Z

    return p0
.end method

.method static synthetic access$302(Lcom/riola/player/PlayerService;Z)Z
    .locals 0

    .line 28
    iput-boolean p1, p0, Lcom/riola/player/PlayerService;->pausedByFocus:Z

    return p1
.end method

.method private action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;
    .locals 3

    .line 203
    invoke-virtual {p3}, Ljava/lang/String;->hashCode()I

    move-result v0

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/riola/player/PlayerService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 204
    invoke-virtual {v1, p3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p3

    .line 203
    const/high16 v1, 0xc000000

    invoke-static {p0, v0, p3, v1}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p3

    .line 206
    new-instance v0, Landroid/app/Notification$Action$Builder;

    invoke-static {p0, p1}, Landroid/graphics/drawable/Icon;->createWithResource(Landroid/content/Context;I)Landroid/graphics/drawable/Icon;

    move-result-object p1

    invoke-direct {v0, p1, p2, p3}, Landroid/app/Notification$Action$Builder;-><init>(Landroid/graphics/drawable/Icon;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    invoke-virtual {v0}, Landroid/app/Notification$Action$Builder;->build()Landroid/app/Notification$Action;

    move-result-object p1

    return-object p1
.end method

.method private build()Landroid/app/Notification;
    .locals 13

    .line 154
    iget-object v0, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    .line 155
    iget-boolean v1, v0, Lcom/riola/player/Engine$St;->running:Z

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    iget-boolean v1, v0, Lcom/riola/player/Engine$St;->paused:Z

    if-nez v1, :cond_0

    move v1, v3

    goto :goto_0

    :cond_0
    move v1, v2

    .line 157
    :goto_0
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lcom/riola/player/MainActivity;

    invoke-direct {v4, p0, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 158
    const/high16 v5, 0x30000000

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    move-result-object v4

    .line 159
    const/high16 v5, 0xc000000

    invoke-static {p0, v2, v4, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v4

    .line 162
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    .line 163
    iget-boolean v6, v0, Lcom/riola/player/Engine$St;->running:Z

    const-string v7, "Riola"

    if-eqz v6, :cond_7

    .line 164
    iget-object v6, v0, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    if-eqz v6, :cond_2

    iget-object v6, v0, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-nez v6, :cond_1

    goto :goto_1

    :cond_1
    iget-object v6, v0, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    goto :goto_2

    :cond_2
    :goto_1
    move-object v6, v7

    :goto_2
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 165
    iget-boolean v6, v0, Lcom/riola/player/Engine$St;->preview:Z

    const-string v8, " of "

    if-nez v6, :cond_3

    const-string v6, "  .  step "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->step:I

    add-int/2addr v9, v3

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->steps:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 166
    :cond_3
    iget v6, v0, Lcom/riola/player/Engine$St;->loopTotal:I

    const-string v9, "  .  loop "

    if-gez v6, :cond_4

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->loopDone:I

    add-int/2addr v9, v3

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 167
    :cond_4
    iget v6, v0, Lcom/riola/player/Engine$St;->loopTotal:I

    if-le v6, v3, :cond_5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->loopDone:I

    add-int/2addr v9, v3

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->loopTotal:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 168
    :cond_5
    :goto_3
    iget-wide v9, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    const-wide/16 v11, 0x0

    cmp-long v6, v9, v11

    if-ltz v6, :cond_6

    const-string v6, "  .  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-wide v8, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    invoke-static {v8, v9}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, " left"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 169
    :cond_6
    iget v6, v0, Lcom/riola/player/Engine$St;->repTotal:I

    if-le v6, v3, :cond_8

    const-string v6, "  .  pass "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v0, Lcom/riola/player/Engine$St;->repDone:I

    add-int/2addr v9, v3

    iget v10, v0, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 170
    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v8, v0, Lcom/riola/player/Engine$St;->repTotal:I

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 172
    :cond_7
    const-string v6, "Idle"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 175
    :cond_8
    :goto_4
    new-instance v6, Landroid/app/Notification$Builder;

    const-string v8, "riola.playback"

    invoke-direct {v6, p0, v8}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 176
    const v8, 0x7f010004

    invoke-virtual {v6, v8}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v6

    .line 177
    iget-object v8, v0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    if-eqz v8, :cond_a

    iget-object v8, v0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    if-nez v8, :cond_9

    goto :goto_5

    :cond_9
    iget-object v7, v0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    :cond_a
    :goto_5
    invoke-virtual {v6, v7}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v6

    iget-object v7, v0, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    .line 178
    invoke-virtual {v6, v7}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v6

    .line 179
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Landroid/app/Notification$Builder;->setSubText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v5

    .line 180
    invoke-virtual {v5, v4}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v4

    iget-boolean v5, v0, Lcom/riola/player/Engine$St;->running:Z

    .line 181
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 182
    invoke-virtual {v4, v3}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 183
    invoke-virtual {v4, v2}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 184
    invoke-virtual {v4, v3}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 185
    const-string v5, "transport"

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 187
    const-string v5, "Previous"

    const-string v6, "riola.prev"

    const v7, 0x7f010007

    invoke-direct {p0, v7, v5, v6}, Lcom/riola/player/PlayerService;->action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 188
    const-string v5, "riola.toggle"

    if-eqz v1, :cond_b

    const v1, 0x7f010005

    const-string v6, "Pause"

    invoke-direct {p0, v1, v6, v5}, Lcom/riola/player/PlayerService;->action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;

    move-result-object v1

    goto :goto_6

    .line 189
    :cond_b
    const v1, 0x7f010006

    const-string v6, "Play"

    invoke-direct {p0, v1, v6, v5}, Lcom/riola/player/PlayerService;->action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;

    move-result-object v1

    .line 188
    :goto_6
    invoke-virtual {v4, v1}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 190
    const-string v1, "Next"

    const-string v5, "riola.next"

    const v6, 0x7f010003

    invoke-direct {p0, v6, v1, v5}, Lcom/riola/player/PlayerService;->action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 191
    const-string v1, "Stop"

    const-string v5, "riola.stop"

    const v6, 0x7f010008

    invoke-direct {p0, v6, v1, v5}, Lcom/riola/player/PlayerService;->action(ILjava/lang/String;Ljava/lang/String;)Landroid/app/Notification$Action;

    move-result-object v1

    invoke-virtual {v4, v1}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 193
    new-instance v1, Landroid/app/Notification$MediaStyle;

    invoke-direct {v1}, Landroid/app/Notification$MediaStyle;-><init>()V

    const/4 v5, 0x2

    filled-new-array {v2, v3, v5}, [I

    move-result-object v3

    .line 194
    invoke-virtual {v1, v3}, Landroid/app/Notification$MediaStyle;->setShowActionsInCompactView([I)Landroid/app/Notification$MediaStyle;

    move-result-object v1

    .line 195
    iget-object v3, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    if-eqz v3, :cond_c

    invoke-virtual {v3}, Landroid/media/session/MediaSession;->getSessionToken()Landroid/media/session/MediaSession$Token;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/app/Notification$MediaStyle;->setMediaSession(Landroid/media/session/MediaSession$Token;)Landroid/app/Notification$MediaStyle;

    .line 196
    :cond_c
    invoke-virtual {v4, v1}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    .line 198
    iget v1, v0, Lcom/riola/player/Engine$St;->durMs:I

    if-lez v1, :cond_d

    iget v1, v0, Lcom/riola/player/Engine$St;->durMs:I

    iget v0, v0, Lcom/riola/player/Engine$St;->posMs:I

    invoke-virtual {v4, v1, v0, v2}, Landroid/app/Notification$Builder;->setProgress(IIZ)Landroid/app/Notification$Builder;

    .line 199
    :cond_d
    invoke-virtual {v4}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method private holdWakeLock(Z)V
    .locals 2

    .line 274
    if-eqz p1, :cond_2

    .line 275
    iget-object p1, p0, Lcom/riola/player/PlayerService;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {p1}, Lcom/riola/player/Prefs;->wakeLock()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz p1, :cond_0

    goto :goto_0

    .line 276
    :cond_0
    const-string p1, "power"

    invoke-virtual {p0, p1}, Lcom/riola/player/PlayerService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/PowerManager;

    .line 277
    const/4 v0, 0x1

    const-string v1, "riola:program"

    invoke-virtual {p1, v0, v1}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    .line 278
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/os/PowerManager$WakeLock;->setReferenceCounted(Z)V

    .line 279
    iget-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    const-wide/32 v0, 0x1499700

    invoke-virtual {p1, v0, v1}, Landroid/os/PowerManager$WakeLock;->acquire(J)V

    goto :goto_2

    .line 275
    :cond_1
    :goto_0
    return-void

    .line 280
    :cond_2
    iget-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz p1, :cond_4

    .line 281
    :try_start_0
    invoke-virtual {p1}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {p1}, Landroid/os/PowerManager$WakeLock;->release()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    .line 282
    :cond_3
    :goto_1
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/riola/player/PlayerService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    goto :goto_3

    .line 280
    :cond_4
    :goto_2
    nop

    .line 284
    :goto_3
    return-void
.end method

.method private post(Z)V
    .locals 8

    .line 141
    iget-boolean v0, p0, Lcom/riola/player/PlayerService;->started:Z

    if-nez v0, :cond_0

    return-void

    .line 142
    :cond_0
    iget-object v0, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    iget-object v0, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    .line 143
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, v0, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v3, v0, Lcom/riola/player/Engine$St;->paused:Z

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v3, v0, Lcom/riola/player/Engine$St;->running:Z

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v0, Lcom/riola/player/Engine$St;->step:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 144
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    .line 145
    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/riola/player/PlayerService;->lastKey:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-wide v4, p0, Lcom/riola/player/PlayerService;->lastPost:J

    sub-long v4, v2, v4

    const-wide/16 v6, 0x3e8

    cmp-long p1, v4, v6

    if-gez p1, :cond_1

    return-void

    .line 146
    :cond_1
    iput-object v1, p0, Lcom/riola/player/PlayerService;->lastKey:Ljava/lang/String;

    .line 147
    iput-wide v2, p0, Lcom/riola/player/PlayerService;->lastPost:J

    .line 148
    const-string p1, "notification"

    invoke-virtual {p0, p1}, Lcom/riola/player/PlayerService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    .line 149
    const/16 v1, 0x1069

    invoke-direct {p0}, Lcom/riola/player/PlayerService;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 150
    invoke-direct {p0, v0}, Lcom/riola/player/PlayerService;->updateSession(Lcom/riola/player/Engine$St;)V

    .line 151
    return-void
.end method

.method private requestFocus()V
    .locals 4

    .line 232
    iget-object v0, p0, Lcom/riola/player/PlayerService;->focus:Landroid/media/AudioFocusRequest;

    if-eqz v0, :cond_0

    return-void

    .line 233
    :cond_0
    new-instance v0, Lcom/riola/player/PlayerService$3;

    invoke-direct {v0, p0}, Lcom/riola/player/PlayerService$3;-><init>(Lcom/riola/player/PlayerService;)V

    .line 256
    new-instance v1, Landroid/media/AudioFocusRequest$Builder;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Landroid/media/AudioFocusRequest$Builder;-><init>(I)V

    new-instance v3, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v3}, Landroid/media/AudioAttributes$Builder;-><init>()V

    .line 258
    invoke-virtual {v3, v2}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v2

    .line 259
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v2

    .line 257
    invoke-virtual {v1, v2}, Landroid/media/AudioFocusRequest$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v1

    .line 260
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/media/AudioFocusRequest$Builder;->setWillPauseWhenDucked(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v1

    .line 261
    invoke-virtual {v1, v0}, Landroid/media/AudioFocusRequest$Builder;->setOnAudioFocusChangeListener(Landroid/media/AudioManager$OnAudioFocusChangeListener;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v0

    .line 262
    invoke-virtual {v0}, Landroid/media/AudioFocusRequest$Builder;->build()Landroid/media/AudioFocusRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerService;->focus:Landroid/media/AudioFocusRequest;

    .line 263
    iget-object v1, p0, Lcom/riola/player/PlayerService;->am:Landroid/media/AudioManager;

    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioFocusRequest;)I

    .line 264
    return-void
.end method

.method private shutdown()V
    .locals 1

    .line 132
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/riola/player/PlayerService;->holdWakeLock(Z)V

    .line 133
    invoke-direct {p0}, Lcom/riola/player/PlayerService;->abandonFocus()V

    .line 134
    iput-boolean v0, p0, Lcom/riola/player/PlayerService;->started:Z

    .line 135
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerService;->stopForeground(I)V

    .line 136
    invoke-virtual {p0}, Lcom/riola/player/PlayerService;->stopSelf()V

    .line 137
    return-void
.end method

.method private updateSession(Lcom/riola/player/Engine$St;)V
    .locals 6

    .line 210
    iget-object v0, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    if-nez v0, :cond_0

    return-void

    .line 212
    :cond_0
    :try_start_0
    new-instance v1, Landroid/media/MediaMetadata$Builder;

    invoke-direct {v1}, Landroid/media/MediaMetadata$Builder;-><init>()V

    const-string v2, "android.media.metadata.TITLE"

    iget-object v3, p1, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    .line 213
    invoke-virtual {v1, v2, v3}, Landroid/media/MediaMetadata$Builder;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/media/MediaMetadata$Builder;

    move-result-object v1

    const-string v2, "android.media.metadata.ARTIST"

    iget-object v3, p1, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    .line 214
    invoke-virtual {v1, v2, v3}, Landroid/media/MediaMetadata$Builder;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/media/MediaMetadata$Builder;

    move-result-object v1

    const-string v2, "android.media.metadata.ALBUM"

    const-string v3, "Riola"

    .line 215
    invoke-virtual {v1, v2, v3}, Landroid/media/MediaMetadata$Builder;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/media/MediaMetadata$Builder;

    move-result-object v1

    const-string v2, "android.media.metadata.DURATION"

    iget v3, p1, Lcom/riola/player/Engine$St;->durMs:I

    int-to-long v3, v3

    .line 216
    invoke-virtual {v1, v2, v3, v4}, Landroid/media/MediaMetadata$Builder;->putLong(Ljava/lang/String;J)Landroid/media/MediaMetadata$Builder;

    move-result-object v1

    .line 217
    invoke-virtual {v1}, Landroid/media/MediaMetadata$Builder;->build()Landroid/media/MediaMetadata;

    move-result-object v1

    .line 212
    invoke-virtual {v0, v1}, Landroid/media/session/MediaSession;->setMetadata(Landroid/media/MediaMetadata;)V

    .line 218
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->running:Z

    const/4 v1, 0x3

    if-nez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    .line 219
    :cond_1
    iget-boolean v0, p1, Lcom/riola/player/Engine$St;->paused:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    goto :goto_0

    :cond_2
    move v0, v1

    .line 220
    :goto_0
    iget-object v2, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    new-instance v3, Landroid/media/session/PlaybackState$Builder;

    invoke-direct {v3}, Landroid/media/session/PlaybackState$Builder;-><init>()V

    .line 221
    const-wide/16 v4, 0x337

    invoke-virtual {v3, v4, v5}, Landroid/media/session/PlaybackState$Builder;->setActions(J)Landroid/media/session/PlaybackState$Builder;

    move-result-object v3

    iget p1, p1, Lcom/riola/player/Engine$St;->posMs:I

    int-to-long v4, p1

    .line 225
    if-ne v0, v1, :cond_3

    const/high16 p1, 0x3f800000    # 1.0f

    goto :goto_1

    :cond_3
    const/4 p1, 0x0

    :goto_1
    invoke-virtual {v3, v0, v4, v5, p1}, Landroid/media/session/PlaybackState$Builder;->setState(IJF)Landroid/media/session/PlaybackState$Builder;

    move-result-object p1

    .line 226
    invoke-virtual {p1}, Landroid/media/session/PlaybackState$Builder;->build()Landroid/media/session/PlaybackState;

    move-result-object p1

    .line 220
    invoke-virtual {v2, p1}, Landroid/media/session/MediaSession;->setPlaybackState(Landroid/media/session/PlaybackState;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 227
    :catch_0
    move-exception p1

    :goto_2
    nop

    .line 228
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    .line 113
    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 5

    .line 53
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 54
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p0}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/PlayerService;->prefs:Lcom/riola/player/Prefs;

    .line 55
    invoke-static {p0}, Lcom/riola/player/Engine;->get(Landroid/content/Context;)Lcom/riola/player/Engine;

    move-result-object v0

    iput-object v0, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    .line 56
    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->addListener(Lcom/riola/player/Engine$Listener;)V

    .line 57
    const-string v0, "audio"

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    iput-object v0, p0, Lcom/riola/player/PlayerService;->am:Landroid/media/AudioManager;

    .line 59
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/riola/player/PlayerService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 60
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "Playback"

    const/4 v3, 0x2

    const-string v4, "riola.playback"

    invoke-direct {v1, v4, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 61
    const-string v2, "Shows the running Riola program"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 62
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    .line 63
    const/4 v3, 0x0

    invoke-virtual {v1, v3, v3}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    .line 64
    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    .line 65
    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 67
    new-instance v0, Landroid/media/session/MediaSession;

    const-string v1, "Riola"

    invoke-direct {v0, p0, v1}, Landroid/media/session/MediaSession;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    .line 68
    new-instance v1, Lcom/riola/player/PlayerService$1;

    invoke-direct {v1, p0}, Lcom/riola/player/PlayerService$1;-><init>(Lcom/riola/player/PlayerService;)V

    invoke-virtual {v0, v1}, Landroid/media/session/MediaSession;->setCallback(Landroid/media/session/MediaSession$Callback;)V

    .line 76
    iget-object v0, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/session/MediaSession;->setActive(Z)V

    .line 78
    new-instance v0, Lcom/riola/player/PlayerService$2;

    invoke-direct {v0, p0}, Lcom/riola/player/PlayerService$2;-><init>(Lcom/riola/player/PlayerService;)V

    iput-object v0, p0, Lcom/riola/player/PlayerService;->noisy:Landroid/content/BroadcastReceiver;

    .line 86
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.media.AUDIO_BECOMING_NOISY"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 87
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/riola/player/PlayerService;->noisy:Landroid/content/BroadcastReceiver;

    const/4 v2, 0x4

    invoke-virtual {p0, v1, v0, v2}, Lcom/riola/player/PlayerService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    goto :goto_0

    .line 88
    :cond_0
    iget-object v1, p0, Lcom/riola/player/PlayerService;->noisy:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/riola/player/PlayerService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 89
    :goto_0
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 117
    iget-object v0, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {v0, p0}, Lcom/riola/player/Engine;->removeListener(Lcom/riola/player/Engine$Listener;)V

    .line 118
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/riola/player/PlayerService;->holdWakeLock(Z)V

    .line 119
    invoke-direct {p0}, Lcom/riola/player/PlayerService;->abandonFocus()V

    .line 120
    :try_start_0
    iget-object v1, p0, Lcom/riola/player/PlayerService;->noisy:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1}, Lcom/riola/player/PlayerService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 121
    :goto_0
    iget-object v1, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    if-eqz v1, :cond_0

    invoke-virtual {v1, v0}, Landroid/media/session/MediaSession;->setActive(Z)V

    iget-object v1, p0, Lcom/riola/player/PlayerService;->session:Landroid/media/session/MediaSession;

    invoke-virtual {v1}, Landroid/media/session/MediaSession;->release()V

    .line 122
    :cond_0
    iput-boolean v0, p0, Lcom/riola/player/PlayerService;->started:Z

    .line 123
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 124
    return-void
.end method

.method public onFinished(Z)V
    .locals 0

    .line 129
    invoke-direct {p0}, Lcom/riola/player/PlayerService;->shutdown()V

    return-void
.end method

.method public onLog(Ljava/lang/String;)V
    .locals 0

    .line 128
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 2

    .line 93
    const-string p2, "riola.attach"

    if-nez p1, :cond_0

    move-object p1, p2

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    .line 94
    :goto_0
    if-nez p1, :cond_1

    move-object p1, p2

    .line 96
    :cond_1
    iget-boolean p3, p0, Lcom/riola/player/PlayerService;->started:Z

    const/4 v0, 0x1

    if-nez p3, :cond_2

    .line 97
    const/16 p3, 0x1069

    invoke-direct {p0}, Lcom/riola/player/PlayerService;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, p3, v1}, Lcom/riola/player/PlayerService;->startForeground(ILandroid/app/Notification;)V

    .line 98
    iput-boolean v0, p0, Lcom/riola/player/PlayerService;->started:Z

    .line 99
    invoke-direct {p0}, Lcom/riola/player/PlayerService;->requestFocus()V

    .line 100
    invoke-direct {p0, v0}, Lcom/riola/player/PlayerService;->holdWakeLock(Z)V

    .line 103
    :cond_2
    const-string p3, "riola.toggle"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    const/4 v1, 0x2

    if-eqz p3, :cond_3

    iget-object p3, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {p3}, Lcom/riola/player/Engine;->togglePause()V

    goto :goto_1

    .line 104
    :cond_3
    const-string p3, "riola.next"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_4

    iget-object p3, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {p3}, Lcom/riola/player/Engine;->next()V

    goto :goto_1

    .line 105
    :cond_4
    const-string p3, "riola.prev"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_5

    iget-object p3, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {p3}, Lcom/riola/player/Engine;->prev()V

    goto :goto_1

    .line 106
    :cond_5
    const-string p3, "riola.stop"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_6

    iget-object p1, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {p1}, Lcom/riola/player/Engine;->stop()V

    invoke-direct {p0}, Lcom/riola/player/PlayerService;->shutdown()V

    return v1

    .line 108
    :cond_6
    :goto_1
    invoke-direct {p0, v0}, Lcom/riola/player/PlayerService;->post(Z)V

    .line 109
    iget-object p3, p0, Lcom/riola/player/PlayerService;->engine:Lcom/riola/player/Engine;

    invoke-virtual {p3}, Lcom/riola/player/Engine;->isRunning()Z

    move-result p3

    if-nez p3, :cond_7

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_7

    invoke-direct {p0}, Lcom/riola/player/PlayerService;->shutdown()V

    .line 110
    :cond_7
    return v1
.end method

.method public onState(Lcom/riola/player/Engine$St;)V
    .locals 0

    .line 127
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/riola/player/PlayerService;->post(Z)V

    return-void
.end method
