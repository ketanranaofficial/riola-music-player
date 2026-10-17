.class public Lcom/riola/player/Engine;
.super Ljava/lang/Object;
.source "Engine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/Engine$St;,
        Lcom/riola/player/Engine$Listener;
    }
.end annotation


# static fields
.field private static I:Lcom/riola/player/Engine;


# instance fields
.field private final bell:Lcom/riola/player/Bell;

.field private volatile completed:Z

.field private final ctx:Landroid/content/Context;

.field private volatile deadline:J

.field private volatile duck:F

.field private volatile fadeMs:J

.field private volatile gain:F

.field private volatile gen:I

.field private volatile idx:I

.field private volatile jump:I

.field private final listeners:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/riola/player/Engine$Listener;",
            ">;"
        }
    .end annotation
.end field

.field private loadedUri:Ljava/lang/String;

.field private final lock:Ljava/lang/Object;

.field private final logBuf:Ljava/lang/StringBuilder;

.field private loops:I

.field private final main:Landroid/os/Handler;

.field private mp:Landroid/media/MediaPlayer;

.field private volatile order:[I

.field private volatile paused:Z

.field private final prefs:Lcom/riola/player/Prefs;

.field private volatile pushPending:Z

.field private volatile running:Z

.field private volatile shuffled:Z

.field private volatile skip:I

.field private volatile speed:F

.field public final st:Lcom/riola/player/Engine$St;

.field private volatile stepSpeed:F

.field private volatile stepVol:F

.field private final steps:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/riola/player/Step;",
            ">;"
        }
    .end annotation
.end field

.field private volatile stopReq:Z

.field private volatile vol:F

.field private worker:Ljava/lang/Thread;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/riola/player/Engine;->main:Landroid/os/Handler;

    .line 58
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->lock:Ljava/lang/Object;

    .line 59
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->listeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 60
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    .line 62
    new-instance v0, Lcom/riola/player/Engine$St;

    invoke-direct {v0}, Lcom/riola/player/Engine$St;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    .line 65
    new-instance v0, Lcom/riola/player/Bell;

    invoke-direct {v0}, Lcom/riola/player/Bell;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    .line 66
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/Engine;->loadedUri:Ljava/lang/String;

    .line 68
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    .line 69
    const/4 v0, 0x1

    iput v0, p0, Lcom/riola/player/Engine;->loops:I

    .line 73
    const/4 v0, -0x1

    iput v0, p0, Lcom/riola/player/Engine;->jump:I

    .line 78
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/riola/player/Engine;->duck:F

    .line 79
    iput v0, p0, Lcom/riola/player/Engine;->gain:F

    .line 80
    iput v0, p0, Lcom/riola/player/Engine;->vol:F

    .line 81
    iput v0, p0, Lcom/riola/player/Engine;->speed:F

    .line 82
    iput v0, p0, Lcom/riola/player/Engine;->stepVol:F

    iput v0, p0, Lcom/riola/player/Engine;->stepSpeed:F

    .line 83
    const-wide/16 v0, 0x96

    iput-wide v0, p0, Lcom/riola/player/Engine;->fadeMs:J

    .line 84
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/riola/player/Engine;->deadline:J

    .line 87
    iput-object p1, p0, Lcom/riola/player/Engine;->ctx:Landroid/content/Context;

    .line 88
    new-instance v0, Lcom/riola/player/Prefs;

    invoke-direct {v0, p1}, Lcom/riola/player/Prefs;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    .line 89
    return-void
.end method

.method static synthetic access$000(Lcom/riola/player/Engine;I)V
    .locals 0

    .line 21
    invoke-direct {p0, p1}, Lcom/riola/player/Engine;->loop(I)V

    return-void
.end method

.method static synthetic access$100(Lcom/riola/player/Engine;)I
    .locals 0

    .line 21
    iget p0, p0, Lcom/riola/player/Engine;->gen:I

    return p0
.end method

.method static synthetic access$200(Lcom/riola/player/Engine;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 0

    .line 21
    iget-object p0, p0, Lcom/riola/player/Engine;->listeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object p0
.end method

.method static synthetic access$302(Lcom/riola/player/Engine;Z)Z
    .locals 0

    .line 21
    iput-boolean p1, p0, Lcom/riola/player/Engine;->completed:Z

    return p1
.end method

.method static synthetic access$400(Lcom/riola/player/Engine;)V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    return-void
.end method

.method static synthetic access$502(Lcom/riola/player/Engine;Z)Z
    .locals 0

    .line 21
    iput-boolean p1, p0, Lcom/riola/player/Engine;->pushPending:Z

    return p1
.end method

.method private applySpeed()V
    .locals 4

    .line 690
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 691
    if-nez v0, :cond_0

    return-void

    .line 693
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v1

    if-nez v1, :cond_1

    return-void

    .line 694
    :cond_1
    iget v1, p0, Lcom/riola/player/Engine;->speed:F

    iget v2, p0, Lcom/riola/player/Engine;->stepSpeed:F

    mul-float/2addr v1, v2

    .line 695
    const/high16 v2, 0x3e800000    # 0.25f

    cmpg-float v3, v1, v2

    if-gez v3, :cond_2

    move v1, v2

    .line 696
    :cond_2
    const/high16 v2, 0x40400000    # 3.0f

    cmpl-float v3, v1, v2

    if-lez v3, :cond_3

    move v1, v2

    .line 697
    :cond_3
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getPlaybackParams()Landroid/media/PlaybackParams;

    move-result-object v2

    .line 698
    invoke-virtual {v2, v1}, Landroid/media/PlaybackParams;->setSpeed(F)Landroid/media/PlaybackParams;

    .line 699
    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setPlaybackParams(Landroid/media/PlaybackParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 700
    :catch_0
    move-exception v0

    :goto_0
    nop

    .line 701
    return-void
.end method

.method private applyVol()V
    .locals 4

    .line 681
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 682
    if-nez v0, :cond_0

    return-void

    .line 683
    :cond_0
    iget v1, p0, Lcom/riola/player/Engine;->vol:F

    iget v2, p0, Lcom/riola/player/Engine;->stepVol:F

    mul-float/2addr v1, v2

    iget v2, p0, Lcom/riola/player/Engine;->duck:F

    mul-float/2addr v1, v2

    iget v2, p0, Lcom/riola/player/Engine;->gain:F

    mul-float/2addr v1, v2

    .line 684
    const/4 v2, 0x0

    cmpg-float v3, v1, v2

    if-gez v3, :cond_1

    move v1, v2

    .line 685
    :cond_1
    const/high16 v2, 0x3f800000    # 1.0f

    cmpl-float v3, v1, v2

    if-lez v3, :cond_2

    move v1, v2

    .line 686
    :cond_2
    :try_start_0
    invoke-virtual {v0, v1, v1}, Landroid/media/MediaPlayer;->setVolume(FF)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 687
    :goto_0
    return-void
.end method

.method private begin(I)V
    .locals 6

    .line 135
    iget-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->volume()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    iput v0, p0, Lcom/riola/player/Engine;->vol:F

    .line 136
    iget-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->speed()F

    move-result v0

    iput v0, p0, Lcom/riola/player/Engine;->speed:F

    .line 137
    iget-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->fadeMs()I

    move-result v0

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/riola/player/Engine;->fadeMs:J

    .line 138
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/riola/player/Engine;->duck:F

    .line 139
    iput v0, p0, Lcom/riola/player/Engine;->gain:F

    .line 140
    iput v0, p0, Lcom/riola/player/Engine;->stepVol:F

    .line 141
    iput v0, p0, Lcom/riola/player/Engine;->stepSpeed:F

    .line 142
    iget-boolean v0, p0, Lcom/riola/player/Engine;->shuffled:Z

    const/4 v1, -0x1

    invoke-direct {p0, v0, v1}, Lcom/riola/player/Engine;->buildOrder(ZI)V

    .line 143
    iput p1, p0, Lcom/riola/player/Engine;->idx:I

    .line 144
    iget-boolean v0, p0, Lcom/riola/player/Engine;->shuffled:Z

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    .line 145
    move v0, v2

    :goto_0
    iget-object v3, p0, Lcom/riola/player/Engine;->order:[I

    array-length v3, v3

    if-ge v0, v3, :cond_1

    iget-object v3, p0, Lcom/riola/player/Engine;->order:[I

    aget v3, v3, v0

    if-ne v3, p1, :cond_0

    iput v0, p0, Lcom/riola/player/Engine;->idx:I

    goto :goto_1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 147
    :cond_1
    :goto_1
    iget-object p1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-boolean v0, p0, Lcom/riola/player/Engine;->shuffled:Z

    iput-boolean v0, p1, Lcom/riola/player/Engine$St;->shuffled:Z

    .line 148
    iput-boolean v2, p0, Lcom/riola/player/Engine;->stopReq:Z

    .line 149
    iput-boolean v2, p0, Lcom/riola/player/Engine;->paused:Z

    .line 150
    iput v2, p0, Lcom/riola/player/Engine;->skip:I

    .line 151
    iput v1, p0, Lcom/riola/player/Engine;->jump:I

    .line 152
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/riola/player/Engine;->running:Z

    .line 153
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean p1, v0, Lcom/riola/player/Engine$St;->running:Z

    .line 154
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v2, v0, Lcom/riola/player/Engine$St;->paused:Z

    .line 155
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v3, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    iput v3, v0, Lcom/riola/player/Engine$St;->steps:I

    .line 156
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v3, p0, Lcom/riola/player/Engine;->idx:I

    iput v3, v0, Lcom/riola/player/Engine$St;->step:I

    .line 157
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v2, v0, Lcom/riola/player/Engine$St;->loopDone:I

    .line 158
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v3, p0, Lcom/riola/player/Engine;->loops:I

    iput v3, v0, Lcom/riola/player/Engine$St;->loopTotal:I

    .line 159
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v1, v0, Lcom/riola/player/Engine$St;->countIn:I

    .line 160
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v2, v0, Lcom/riola/player/Engine$St;->skipped:I

    .line 161
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-boolean v0, v0, Lcom/riola/player/Engine$St;->preview:Z

    if-eqz v0, :cond_2

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->autoStopMin()I

    move-result v2

    .line 162
    :goto_2
    if-lez v2, :cond_3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    int-to-long v2, v2

    const-wide/32 v4, 0xea60

    mul-long/2addr v2, v4

    add-long/2addr v0, v2

    goto :goto_3

    :cond_3
    const-wide/16 v0, -0x1

    :goto_3
    iput-wide v0, p0, Lcom/riola/player/Engine;->deadline:J

    .line 163
    iget v0, p0, Lcom/riola/player/Engine;->gen:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/riola/player/Engine;->gen:I

    .line 164
    new-instance p1, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/Engine$1;

    invoke-direct {v1, p0, v0}, Lcom/riola/player/Engine$1;-><init>(Lcom/riola/player/Engine;I)V

    const-string v0, "riola-engine"

    invoke-direct {p1, v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 165
    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 166
    iput-object p1, p0, Lcom/riola/player/Engine;->worker:Ljava/lang/Thread;

    .line 167
    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    .line 168
    return-void
.end method

.method private bellStep(Lcom/riola/player/Step;J)V
    .locals 18

    .line 419
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    iget v0, v7, Lcom/riola/player/Step;->times:I

    const/4 v8, 0x1

    invoke-static {v8, v0}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 420
    iget v0, v7, Lcom/riola/player/Step;->tone:I

    invoke-static {v0}, Lcom/riola/player/Bell;->lengthMs(I)J

    move-result-wide v10

    .line 421
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v9, v0, Lcom/riola/player/Engine$St;->repTotal:I

    .line 422
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    long-to-int v1, v10

    iput v1, v0, Lcom/riola/player/Engine$St;->durMs:I

    .line 424
    const/4 v13, 0x0

    :goto_0
    if-ge v13, v9, :cond_c

    .line 425
    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_b

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-nez v0, :cond_b

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->expired()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_5

    .line 426
    :cond_0
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v13, v0, Lcom/riola/player/Engine$St;->repDone:I

    .line 427
    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    iget v1, v7, Lcom/riola/player/Step;->tone:I

    iget v2, v6, Lcom/riola/player/Engine;->vol:F

    iget v3, v6, Lcom/riola/player/Engine;->stepVol:F

    mul-float/2addr v2, v3

    iget v3, v6, Lcom/riola/player/Engine;->duck:F

    mul-float/2addr v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/riola/player/Bell;->ring(IF)V

    .line 429
    nop

    .line 430
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    move-wide v2, v10

    .line 431
    :goto_1
    const-wide/16 v4, 0x0

    cmp-long v14, v2, v4

    if-lez v14, :cond_7

    .line 432
    iget-boolean v14, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v14, :cond_6

    iget v14, v6, Lcom/riola/player/Engine;->skip:I

    if-nez v14, :cond_6

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->expired()Z

    move-result v14

    if-eqz v14, :cond_1

    goto/16 :goto_4

    .line 433
    :cond_1
    const-wide/16 v14, 0x64

    invoke-direct {v6, v14, v15}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 434
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v14

    .line 435
    sub-long v0, v14, v0

    .line 436
    nop

    .line 437
    iget-boolean v12, v6, Lcom/riola/player/Engine;->paused:Z

    if-eqz v12, :cond_5

    .line 439
    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    .line 440
    :goto_2
    iget-boolean v0, v6, Lcom/riola/player/Engine;->paused:Z

    if-eqz v0, :cond_2

    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_2

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-nez v0, :cond_2

    const-wide/16 v0, 0x96

    invoke-direct {v6, v0, v1}, Lcom/riola/player/Engine;->waitLock(J)V

    goto :goto_2

    .line 441
    :cond_2
    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_4

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-eqz v0, :cond_3

    goto :goto_3

    .line 442
    :cond_3
    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    iget v1, v7, Lcom/riola/player/Step;->tone:I

    iget v2, v6, Lcom/riola/player/Engine;->vol:F

    iget v3, v6, Lcom/riola/player/Engine;->stepVol:F

    mul-float/2addr v2, v3

    iget v3, v6, Lcom/riola/player/Engine;->duck:F

    mul-float/2addr v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/riola/player/Bell;->ring(IF)V

    .line 443
    nop

    .line 444
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 445
    move-wide v2, v10

    goto :goto_1

    .line 441
    :cond_4
    :goto_3
    return-void

    .line 447
    :cond_5
    sub-long/2addr v2, v0

    .line 448
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    move/from16 v16, v9

    sub-long v8, v10, v2

    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v8

    long-to-int v1, v8

    iput v1, v0, Lcom/riola/player/Engine$St;->posMs:I

    .line 449
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v4

    add-int/lit8 v9, v16, -0x1

    sub-int/2addr v9, v13

    int-to-long v8, v9

    move/from16 v17, v13

    iget-wide v12, v7, Lcom/riola/player/Step;->gapMs:J

    add-long/2addr v12, v10

    mul-long/2addr v8, v12

    add-long/2addr v4, v8

    iput-wide v4, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 450
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-wide v4, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    add-long v4, p2, v4

    iput-wide v4, v0, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 451
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 452
    move-wide v0, v14

    move/from16 v9, v16

    move/from16 v13, v17

    const/4 v8, 0x1

    goto/16 :goto_1

    .line 432
    :cond_6
    :goto_4
    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    return-void

    .line 453
    :cond_7
    move/from16 v16, v9

    move/from16 v17, v13

    add-int/lit8 v9, v16, -0x1

    move/from16 v12, v17

    if-ge v12, v9, :cond_9

    iget-wide v2, v7, Lcom/riola/player/Step;->gapMs:J

    cmp-long v0, v2, v4

    if-lez v0, :cond_9

    .line 454
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v8, 0x1

    iput-boolean v8, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 455
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 456
    iget-wide v1, v7, Lcom/riola/player/Step;->gapMs:J

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-wide/from16 v3, p2

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/Engine;->silence(JJZ)V

    .line 457
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 458
    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_8

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-eqz v0, :cond_a

    :cond_8
    return-void

    .line 453
    :cond_9
    const/4 v1, 0x0

    const/4 v8, 0x1

    .line 424
    :cond_a
    add-int/lit8 v13, v12, 0x1

    move/from16 v9, v16

    goto/16 :goto_0

    .line 425
    :cond_b
    :goto_5
    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    return-void

    .line 461
    :cond_c
    move/from16 v16, v9

    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    move/from16 v1, v16

    iput v1, v0, Lcom/riola/player/Engine$St;->repDone:I

    .line 462
    return-void
.end method

.method private buildOrder(ZI)V
    .locals 7

    .line 253
    iget-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 254
    new-array v1, v0, [I

    .line 255
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v0, :cond_0

    aput v3, v1, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 256
    :cond_0
    if-eqz p1, :cond_3

    const/4 p1, 0x1

    if-le v0, p1, :cond_3

    .line 257
    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    .line 258
    add-int/lit8 v3, v0, -0x1

    :goto_1
    if-lez v3, :cond_1

    .line 259
    add-int/lit8 v4, v3, 0x1

    invoke-virtual {p1, v4}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    .line 260
    aget v5, v1, v3

    aget v6, v1, v4

    aput v6, v1, v3

    aput v5, v1, v4

    .line 258
    add-int/lit8 v3, v3, -0x1

    goto :goto_1

    .line 262
    :cond_1
    if-ltz p2, :cond_3

    .line 263
    move p1, v2

    :goto_2
    if-ge p1, v0, :cond_3

    .line 264
    aget v3, v1, p1

    if-ne v3, p2, :cond_2

    aget p2, v1, v2

    aput v3, v1, v2

    aput p2, v1, p1

    goto :goto_3

    .line 263
    :cond_2
    add-int/lit8 p1, p1, 0x1

    goto :goto_2

    .line 268
    :cond_3
    :goto_3
    iput-object v1, p0, Lcom/riola/player/Engine;->order:[I

    .line 269
    return-void
.end method

.method private countIn()V
    .locals 4

    .line 377
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-boolean v0, v0, Lcom/riola/player/Engine$St;->preview:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/riola/player/Engine;->prefs:Lcom/riola/player/Prefs;

    invoke-virtual {v0}, Lcom/riola/player/Prefs;->countIn()I

    move-result v0

    .line 378
    :goto_0
    if-gtz v0, :cond_1

    return-void

    .line 379
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "starting in "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "s"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 380
    nop

    :goto_1
    if-lez v0, :cond_2

    iget-boolean v1, p0, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v1, :cond_2

    iget v1, p0, Lcom/riola/player/Engine;->skip:I

    if-nez v1, :cond_2

    .line 381
    iget-object v1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v0, v1, Lcom/riola/player/Engine$St;->countIn:I

    .line 382
    iget-object v1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Starting in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    .line 383
    iget-object v1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const-string v2, "get ready"

    iput-object v2, v1, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    .line 384
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    .line 385
    const-wide/16 v1, 0x3e8

    invoke-direct {p0, v1, v2}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 380
    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    .line 387
    :cond_2
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v1, -0x1

    iput v1, v0, Lcom/riola/player/Engine$St;->countIn:I

    .line 388
    return-void
.end method

.method private duration()J
    .locals 4

    .line 673
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 674
    const-wide/16 v1, 0x0

    if-nez v0, :cond_0

    return-wide v1

    .line 675
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v0

    const/4 v3, 0x0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long v0, v0

    return-wide v0

    :catch_0
    move-exception v0

    return-wide v1
.end method

.method private expired()Z
    .locals 4

    .line 368
    iget-wide v0, p0, Lcom/riola/player/Engine;->deadline:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/riola/player/Engine;->deadline:J

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    .line 369
    const-string v0, "stop timer reached"

    invoke-virtual {p0, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 370
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/riola/player/Engine;->stopReq:Z

    .line 371
    return v0

    .line 373
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private fadeOut(J)V
    .locals 4

    .line 642
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-lez v0, :cond_3

    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    if-nez v0, :cond_0

    goto :goto_2

    .line 643
    :cond_0
    nop

    .line 644
    const/4 v0, 0x7

    :goto_0
    if-ltz v0, :cond_2

    .line 645
    int-to-float v1, v0

    const/16 v2, 0x8

    int-to-float v3, v2

    div-float/2addr v1, v3

    const v3, 0x3ca3d70a    # 0.02f

    invoke-static {v3, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-direct {p0, v1}, Lcom/riola/player/Engine;->setGain(F)V

    .line 646
    int-to-long v1, v2

    div-long v1, p1, v1

    invoke-direct {p0, v1, v2}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 647
    iget-boolean v1, p0, Lcom/riola/player/Engine;->stopReq:Z

    if-eqz v1, :cond_1

    goto :goto_1

    .line 644
    :cond_1
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 649
    :cond_2
    :goto_1
    return-void

    .line 642
    :cond_3
    :goto_2
    return-void
.end method

.method public static declared-synchronized get(Landroid/content/Context;)Lcom/riola/player/Engine;
    .locals 2

    const-class v0, Lcom/riola/player/Engine;

    monitor-enter v0

    .line 51
    :try_start_0
    sget-object v1, Lcom/riola/player/Engine;->I:Lcom/riola/player/Engine;

    if-nez v1, :cond_0

    new-instance v1, Lcom/riola/player/Engine;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-direct {v1, p0}, Lcom/riola/player/Engine;-><init>(Landroid/content/Context;)V

    sput-object v1, Lcom/riola/player/Engine;->I:Lcom/riola/player/Engine;

    .line 52
    :cond_0
    sget-object p0, Lcom/riola/player/Engine;->I:Lcom/riola/player/Engine;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    .line 50
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private loop(I)V
    .locals 16

    .line 277
    move-object/from16 v6, p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "started: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v1, v1, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 278
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->countIn()V

    .line 280
    nop

    .line 281
    const/4 v7, 0x0

    move v0, v7

    move v8, v0

    .line 282
    :goto_0
    iget-boolean v1, v6, Lcom/riola/player/Engine;->stopReq:Z

    const-string v9, ""

    const/4 v11, -0x1

    const/4 v12, 0x1

    if-nez v1, :cond_13

    .line 283
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->expired()Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_9

    .line 284
    :cond_0
    iget-object v1, v6, Lcom/riola/player/Engine;->order:[I

    if-eqz v1, :cond_e

    iget v1, v6, Lcom/riola/player/Engine;->idx:I

    iget-object v2, v6, Lcom/riola/player/Engine;->order:[I

    array-length v2, v2

    if-lt v1, v2, :cond_1

    goto/16 :goto_7

    .line 296
    :cond_1
    iget v1, v6, Lcom/riola/player/Engine;->idx:I

    if-gez v1, :cond_2

    iput v7, v6, Lcom/riola/player/Engine;->idx:I

    .line 297
    :cond_2
    iget-object v1, v6, Lcom/riola/player/Engine;->order:[I

    iget v2, v6, Lcom/riola/player/Engine;->idx:I

    aget v1, v1, v2

    .line 298
    iget-object v2, v6, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    move-object v13, v2

    check-cast v13, Lcom/riola/player/Step;

    .line 299
    iget-boolean v2, v13, Lcom/riola/player/Step;->enabled:Z

    if-nez v2, :cond_3

    iget v1, v6, Lcom/riola/player/Engine;->idx:I

    add-int/2addr v1, v12

    iput v1, v6, Lcom/riola/player/Engine;->idx:I

    goto :goto_0

    .line 301
    :cond_3
    add-int/lit8 v14, v0, 0x1

    .line 302
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v1, v0, Lcom/riola/player/Engine$St;->step:I

    .line 303
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v1, v6, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    iput v1, v0, Lcom/riola/player/Engine$St;->steps:I

    .line 304
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v13}, Lcom/riola/player/Step;->title()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    .line 305
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v13}, Lcom/riola/player/Step;->detail()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    .line 306
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v13}, Lcom/riola/player/Step;->needsTrack()Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v1, v13, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    goto :goto_1

    :cond_4
    move-object v1, v9

    :goto_1
    iput-object v1, v0, Lcom/riola/player/Engine$St;->trackUri:Ljava/lang/String;

    .line 307
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v7, v0, Lcom/riola/player/Engine$St;->repDone:I

    .line 309
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v7, v0, Lcom/riola/player/Engine$St;->posMs:I

    .line 310
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v7, v0, Lcom/riola/player/Engine$St;->durMs:I

    .line 311
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v13}, Lcom/riola/player/Step;->timed()Z

    move-result v1

    if-eqz v1, :cond_5

    move v1, v11

    goto :goto_2

    :cond_5
    iget v1, v13, Lcom/riola/player/Step;->times:I

    invoke-static {v12, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    :goto_2
    iput v1, v0, Lcom/riola/player/Engine$St;->repTotal:I

    .line 312
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-virtual {v13}, Lcom/riola/player/Step;->timed()Z

    move-result v1

    if-eqz v1, :cond_6

    iget-wide v1, v13, Lcom/riola/player/Step;->durMs:J

    goto :goto_3

    :cond_6
    const-wide/16 v1, -0x1

    :goto_3
    iput-wide v1, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 313
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v1, v13, Lcom/riola/player/Step;->type:I

    const/4 v5, 0x2

    if-ne v1, v5, :cond_7

    move v1, v12

    goto :goto_4

    :cond_7
    move v1, v7

    :goto_4
    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 314
    iget v0, v13, Lcom/riola/player/Step;->volumePct:I

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    const/4 v2, 0x0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, v6, Lcom/riola/player/Engine;->stepVol:F

    .line 315
    iget v0, v13, Lcom/riola/player/Step;->speedPct:I

    int-to-float v0, v0

    div-float/2addr v0, v1

    const/high16 v1, 0x3e800000    # 0.25f

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, v6, Lcom/riola/player/Engine;->stepSpeed:F

    .line 316
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 317
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "step "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, v6, Lcom/riola/player/Engine;->idx:I

    add-int/2addr v1, v12

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, v6, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v13}, Lcom/riola/player/Step;->title()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " - "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v13}, Lcom/riola/player/Step;->detail()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 319
    iget v0, v6, Lcom/riola/player/Engine;->idx:I

    add-int/2addr v0, v12

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->restEst(I)J

    move-result-wide v3

    .line 320
    iget v0, v13, Lcom/riola/player/Step;->type:I

    if-ne v0, v5, :cond_8

    .line 321
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 322
    iget-wide v1, v13, Lcom/riola/player/Step;->durMs:J

    const/4 v15, 0x1

    move-object/from16 v0, p0

    move v10, v5

    move v5, v15

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/Engine;->silence(JJZ)V

    .line 325
    iget-boolean v0, v13, Lcom/riola/player/Step;->endBell:Z

    if-eqz v0, :cond_a

    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_a

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-nez v0, :cond_a

    iget-object v0, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    iget v1, v13, Lcom/riola/player/Step;->tone:I

    iget v2, v6, Lcom/riola/player/Engine;->vol:F

    iget v3, v6, Lcom/riola/player/Engine;->stepVol:F

    mul-float/2addr v2, v3

    iget v3, v6, Lcom/riola/player/Engine;->duck:F

    mul-float/2addr v2, v3

    invoke-virtual {v0, v1, v2}, Lcom/riola/player/Bell;->ring(IF)V

    goto :goto_5

    .line 326
    :cond_8
    move v10, v5

    iget v0, v13, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_9

    .line 327
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 328
    invoke-direct {v6, v13, v3, v4}, Lcom/riola/player/Engine;->bellStep(Lcom/riola/player/Step;J)V

    goto :goto_5

    .line 330
    :cond_9
    invoke-direct {v6, v13, v3, v4}, Lcom/riola/player/Engine;->segment(Lcom/riola/player/Step;J)V

    .line 333
    :cond_a
    :goto_5
    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    .line 334
    iput v7, v6, Lcom/riola/player/Engine;->skip:I

    .line 335
    iget-boolean v1, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-eqz v1, :cond_b

    goto/16 :goto_9

    .line 336
    :cond_b
    if-ne v0, v10, :cond_c

    iget v0, v6, Lcom/riola/player/Engine;->jump:I

    iput v0, v6, Lcom/riola/player/Engine;->idx:I

    iput v11, v6, Lcom/riola/player/Engine;->jump:I

    goto :goto_6

    .line 337
    :cond_c
    if-ne v0, v11, :cond_d

    iget v0, v6, Lcom/riola/player/Engine;->idx:I

    sub-int/2addr v0, v12

    iput v0, v6, Lcom/riola/player/Engine;->idx:I

    goto :goto_6

    .line 338
    :cond_d
    iget v0, v6, Lcom/riola/player/Engine;->idx:I

    add-int/2addr v0, v12

    iput v0, v6, Lcom/riola/player/Engine;->idx:I

    .line 339
    :goto_6
    move v0, v14

    goto/16 :goto_0

    .line 285
    :cond_e
    :goto_7
    add-int/lit8 v8, v8, 0x1

    .line 286
    if-nez v0, :cond_f

    goto :goto_9

    .line 287
    :cond_f
    iget v0, v6, Lcom/riola/player/Engine;->loops:I

    if-ltz v0, :cond_10

    invoke-static {v12, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    if-lt v8, v0, :cond_10

    goto :goto_9

    .line 289
    :cond_10
    iget-boolean v0, v6, Lcom/riola/player/Engine;->shuffled:Z

    if-eqz v0, :cond_11

    invoke-direct {v6, v12, v11}, Lcom/riola/player/Engine;->buildOrder(ZI)V

    .line 290
    :cond_11
    iput v7, v6, Lcom/riola/player/Engine;->idx:I

    .line 291
    nop

    .line 292
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v8, v0, Lcom/riola/player/Engine$St;->loopDone:I

    .line 293
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "loop "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    add-int/lit8 v1, v8, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, v6, Lcom/riola/player/Engine;->loops:I

    if-gez v1, :cond_12

    goto :goto_8

    :cond_12
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v6, Lcom/riola/player/Engine;->loops:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    :goto_8
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 294
    move v0, v7

    goto/16 :goto_0

    .line 341
    :cond_13
    :goto_9
    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    .line 342
    xor-int/2addr v0, v12

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 343
    iget-object v1, v6, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v1}, Lcom/riola/player/Bell;->stop()V

    .line 344
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->releasePlayer()V

    .line 345
    iput-boolean v7, v6, Lcom/riola/player/Engine;->running:Z

    .line 346
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v7, v1, Lcom/riola/player/Engine$St;->running:Z

    .line 347
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v7, v1, Lcom/riola/player/Engine$St;->paused:Z

    .line 348
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v7, v1, Lcom/riola/player/Engine$St;->resting:Z

    .line 349
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v7, v1, Lcom/riola/player/Engine$St;->posMs:I

    .line 350
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v7, v1, Lcom/riola/player/Engine$St;->durMs:I

    .line 351
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const-wide/16 v2, -0x1

    iput-wide v2, v1, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 352
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-wide v2, v1, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 353
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v11, v1, Lcom/riola/player/Engine$St;->countIn:I

    .line 354
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    if-eqz v0, :cond_14

    const-string v2, "Finished"

    goto :goto_a

    :cond_14
    const-string v2, "Stopped"

    :goto_a
    iput-object v2, v1, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    .line 355
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-object v9, v1, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    .line 356
    if-eqz v0, :cond_15

    const-string v1, "finished"

    goto :goto_b

    :cond_15
    const-string v1, "stopped"

    :goto_b
    invoke-virtual {v6, v1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 357
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 358
    nop

    .line 359
    iget-object v1, v6, Lcom/riola/player/Engine;->main:Landroid/os/Handler;

    new-instance v2, Lcom/riola/player/Engine$2;

    move/from16 v3, p1

    invoke-direct {v2, v6, v3, v0}, Lcom/riola/player/Engine$2;-><init>(Lcom/riola/player/Engine;IZ)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 365
    return-void
.end method

.method private open(Lcom/riola/player/Track;)Z
    .locals 4

    .line 577
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 578
    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iget-object v2, p0, Lcom/riola/player/Engine;->loadedUri:Ljava/lang/String;

    iget-object v3, p1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 579
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 580
    :cond_0
    :goto_0
    return v1

    .line 582
    :cond_1
    invoke-direct {p0}, Lcom/riola/player/Engine;->releasePlayer()V

    .line 584
    :try_start_1
    new-instance v2, Landroid/media/MediaPlayer;

    invoke-direct {v2}, Landroid/media/MediaPlayer;-><init>()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3

    .line 585
    :try_start_2
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    .line 586
    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 587
    const/4 v3, 0x2

    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 588
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 585
    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 589
    new-instance v0, Lcom/riola/player/Engine$3;

    invoke-direct {v0, p0}, Lcom/riola/player/Engine$3;-><init>(Lcom/riola/player/Engine;)V

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 592
    new-instance v0, Lcom/riola/player/Engine$4;

    invoke-direct {v0, p0}, Lcom/riola/player/Engine$4;-><init>(Lcom/riola/player/Engine;)V

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 600
    iget-object v0, p0, Lcom/riola/player/Engine;->ctx:Landroid/content/Context;

    invoke-virtual {v2, v0, v1}, Landroid/media/MediaPlayer;->setWakeMode(Landroid/content/Context;I)V

    .line 601
    iget-object v0, p0, Lcom/riola/player/Engine;->ctx:Landroid/content/Context;

    invoke-virtual {p1}, Lcom/riola/player/Track;->toUri()Landroid/net/Uri;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 602
    invoke-virtual {v2}, Landroid/media/MediaPlayer;->prepare()V

    .line 606
    iget v0, p1, Lcom/riola/player/Track;->audioTrack:I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    if-ltz v0, :cond_2

    .line 607
    :try_start_3
    iget v0, p1, Lcom/riola/player/Track;->audioTrack:I

    invoke-virtual {v2, v0}, Landroid/media/MediaPlayer;->selectTrack(I)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 609
    goto :goto_1

    .line 607
    :catch_1
    move-exception v0

    .line 608
    :try_start_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "  ! could not switch to audio stream "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v3, p1, Lcom/riola/player/Track;->audioTrack:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 611
    :cond_2
    :goto_1
    iput-object v2, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 612
    iget-object v0, p1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    iput-object v0, p0, Lcom/riola/player/Engine;->loadedUri:Ljava/lang/String;

    .line 613
    invoke-direct {p0}, Lcom/riola/player/Engine;->applyVol()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    .line 614
    return v1

    .line 615
    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    .line 616
    :goto_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "  ! cannot open "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " ("

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ")"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 617
    if-eqz v2, :cond_3

    :try_start_5
    invoke-virtual {v2}, Landroid/media/MediaPlayer;->release()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    goto :goto_3

    :catch_4
    move-exception p1

    .line 618
    :cond_3
    :goto_3
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 619
    const-string p1, ""

    iput-object p1, p0, Lcom/riola/player/Engine;->loadedUri:Ljava/lang/String;

    .line 620
    const/4 p1, 0x0

    return p1
.end method

.method private pausePlayer()V
    .locals 2

    .line 652
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 653
    if-nez v0, :cond_0

    return-void

    .line 654
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 655
    :cond_1
    :goto_0
    return-void
.end method

.method private position()I
    .locals 2

    .line 667
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 668
    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 669
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    return v1
.end method

.method private push()V
    .locals 2

    .line 716
    iget-boolean v0, p0, Lcom/riola/player/Engine;->pushPending:Z

    if-eqz v0, :cond_0

    return-void

    .line 717
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/riola/player/Engine;->pushPending:Z

    .line 718
    iget-object v0, p0, Lcom/riola/player/Engine;->main:Landroid/os/Handler;

    new-instance v1, Lcom/riola/player/Engine$5;

    invoke-direct {v1, p0}, Lcom/riola/player/Engine$5;-><init>(Lcom/riola/player/Engine;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 724
    return-void
.end method

.method private releasePlayer()V
    .locals 2

    .line 658
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 659
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 660
    const-string v1, ""

    iput-object v1, p0, Lcom/riola/player/Engine;->loadedUri:Ljava/lang/String;

    .line 661
    if-nez v0, :cond_0

    return-void

    .line 662
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 663
    :goto_0
    :try_start_1
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 664
    :goto_1
    return-void
.end method

.method private restEst(I)J
    .locals 4

    .line 391
    nop

    .line 392
    const-wide/16 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge p1, v2, :cond_0

    iget-object v2, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Step;

    invoke-virtual {v2}, Lcom/riola/player/Step;->estMs()J

    move-result-wide v2

    add-long/2addr v0, v2

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 393
    :cond_0
    return-wide v0
.end method

.method private segment(Lcom/riola/player/Step;J)V
    .locals 37

    .line 466
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v0

    .line 467
    const-wide/16 v8, 0x190

    const/4 v10, 0x1

    if-nez v0, :cond_0

    .line 468
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v1, v0, Lcom/riola/player/Engine$St;->skipped:I

    add-int/2addr v1, v10

    iput v1, v0, Lcom/riola/player/Engine$St;->skipped:I

    .line 469
    const-string v0, "  ! that track is not in the library any more - skipped"

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 470
    invoke-direct {v6, v8, v9}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 471
    return-void

    .line 473
    :cond_0
    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->open(Lcom/riola/player/Track;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 474
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget v2, v1, Lcom/riola/player/Engine$St;->skipped:I

    add-int/2addr v2, v10

    iput v2, v1, Lcom/riola/player/Engine$St;->skipped:I

    .line 475
    sget-object v1, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    iget-object v0, v0, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 476
    return-void

    .line 478
    :cond_1
    sget-object v1, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    iget-object v0, v0, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 480
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->duration()J

    move-result-wide v11

    .line 481
    const-wide/16 v13, 0x0

    cmp-long v0, v11, v13

    if-lez v0, :cond_2

    move/from16 v16, v10

    goto :goto_0

    :cond_2
    const/16 v16, 0x0

    .line 483
    :goto_0
    iget v0, v7, Lcom/riola/player/Step;->type:I

    if-ne v0, v10, :cond_4

    iget-wide v0, v7, Lcom/riola/player/Step;->b:J

    cmp-long v0, v0, v13

    if-lez v0, :cond_4

    iget-wide v0, v7, Lcom/riola/player/Step;->b:J

    if-eqz v16, :cond_3

    invoke-static {v0, v1, v11, v12}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    :cond_3
    move-wide/from16 v17, v0

    goto :goto_2

    .line 484
    :cond_4
    if-eqz v16, :cond_5

    move-wide v0, v11

    goto :goto_1

    :cond_5
    const-wide v0, 0x1fffffffffffffffL

    :goto_1
    move-wide/from16 v17, v0

    .line 485
    :goto_2
    iget v0, v7, Lcom/riola/player/Step;->type:I

    if-ne v0, v10, :cond_6

    iget-wide v0, v7, Lcom/riola/player/Step;->a:J

    invoke-static {v13, v14, v0, v1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    move-wide v3, v0

    goto :goto_3

    :cond_6
    move-wide v3, v13

    .line 486
    :goto_3
    if-eqz v16, :cond_7

    const-wide/16 v0, 0x96

    sub-long v0, v17, v0

    cmp-long v0, v3, v0

    if-ltz v0, :cond_7

    .line 487
    const-string v0, "  ! that section falls outside the track - skipped"

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 488
    return-void

    .line 491
    :cond_7
    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Step;->timed()Z

    move-result v0

    if-eqz v0, :cond_8

    iget-wide v0, v7, Lcom/riola/player/Step;->durMs:J

    goto :goto_4

    :cond_8
    const-wide/16 v0, -0x1

    :goto_4
    move-wide/from16 v19, v0

    .line 492
    nop

    .line 493
    iget-wide v0, v6, Lcom/riola/player/Engine;->fadeMs:J

    sub-long v21, v17, v3

    const-wide/16 v23, 0x4

    move-wide/from16 v26, v11

    div-long v10, v21, v23

    invoke-static {v13, v14, v10, v11}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v10

    invoke-static {v0, v1, v10, v11}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v10

    .line 494
    nop

    .line 496
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->applySpeed()V

    .line 497
    invoke-direct {v6, v3, v4}, Lcom/riola/player/Engine;->startAt(J)V

    .line 498
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    add-long/2addr v0, v8

    .line 499
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v23

    move-wide/from16 v28, v19

    const/4 v2, 0x0

    .line 502
    :goto_5
    iget-boolean v5, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v5, :cond_1b

    iget v5, v6, Lcom/riola/player/Engine;->skip:I

    if-nez v5, :cond_1b

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->expired()Z

    move-result v5

    if-eqz v5, :cond_9

    goto/16 :goto_10

    .line 504
    :cond_9
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->position()I

    move-result v5

    .line 505
    int-to-long v8, v5

    sub-long v8, v17, v8

    const-wide/16 v30, 0x1f4

    cmp-long v5, v8, v30

    if-gez v5, :cond_a

    const-wide/16 v8, 0x14

    goto :goto_6

    :cond_a
    const-wide/16 v8, 0x78

    :goto_6
    invoke-direct {v6, v8, v9}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 507
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v8

    .line 508
    sub-long v23, v8, v23

    .line 509
    nop

    .line 510
    iget-boolean v5, v6, Lcom/riola/player/Engine;->paused:Z

    if-eqz v5, :cond_b

    add-long v0, v0, v23

    move-wide/from16 v23, v8

    const-wide/16 v8, 0x190

    goto :goto_5

    .line 512
    :cond_b
    cmp-long v5, v19, v13

    if-lez v5, :cond_d

    .line 513
    sub-long v12, v28, v23

    .line 514
    iget-object v14, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    move-wide/from16 v32, v0

    move-wide/from16 v34, v8

    const-wide/16 v0, 0x0

    invoke-static {v0, v1, v12, v13}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v8

    iput-wide v8, v14, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 515
    iget-object v8, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-static {v0, v1, v12, v13}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v28

    add-long v0, p2, v28

    iput-wide v0, v8, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 516
    const-wide/16 v0, 0x0

    cmp-long v8, v12, v0

    if-gtz v8, :cond_c

    .line 517
    const-wide/16 v0, 0xa0

    invoke-direct {v6, v0, v1}, Lcom/riola/player/Engine;->fadeOut(J)V

    .line 518
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 519
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->setGain(F)V

    .line 520
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  time is up after "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x1

    add-int/2addr v2, v1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " pass(es)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 521
    return-void

    .line 516
    :cond_c
    move-wide/from16 v28, v12

    goto :goto_7

    .line 524
    :cond_d
    move-wide/from16 v32, v0

    move-wide/from16 v34, v8

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->position()I

    move-result v0

    int-to-long v0, v0

    sub-long v0, v17, v0

    const-wide/16 v8, 0x0

    invoke-static {v8, v9, v0, v1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    .line 525
    iget v12, v7, Lcom/riola/player/Step;->times:I

    const/4 v13, 0x1

    invoke-static {v13, v12}, Ljava/lang/Math;->max(II)I

    move-result v12

    sub-int/2addr v12, v13

    sub-int/2addr v12, v2

    int-to-long v12, v12

    invoke-static {v8, v9, v12, v13}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v12

    mul-long v12, v12, v21

    .line 526
    iget-object v8, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    add-long v0, p2, v0

    add-long/2addr v0, v12

    iput-wide v0, v8, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 529
    :goto_7
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->position()I

    move-result v0

    .line 530
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v0, v1, Lcom/riola/player/Engine$St;->posMs:I

    .line 531
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    if-eqz v16, :cond_e

    move-wide/from16 v8, v26

    long-to-int v12, v8

    goto :goto_8

    :cond_e
    move-wide/from16 v8, v26

    move v12, v0

    :goto_8
    iput v12, v1, Lcom/riola/player/Engine$St;->durMs:I

    .line 532
    iget-object v1, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v2, v1, Lcom/riola/player/Engine$St;->repDone:I

    .line 534
    const-wide/16 v12, 0x0

    cmp-long v23, v10, v12

    if-lez v23, :cond_11

    .line 535
    nop

    .line 536
    int-to-long v14, v0

    move/from16 v27, v2

    sub-long v1, v14, v3

    .line 537
    sub-long v14, v17, v14

    .line 538
    cmp-long v36, v1, v12

    if-ltz v36, :cond_f

    cmp-long v12, v1, v10

    if-gez v12, :cond_f

    long-to-float v1, v1

    long-to-float v2, v10

    div-float/2addr v1, v2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    move-wide v12, v14

    goto :goto_9

    :cond_f
    move-wide v12, v14

    .line 539
    const/high16 v1, 0x3f800000    # 1.0f

    :goto_9
    const-wide/16 v30, 0x0

    cmp-long v2, v12, v30

    if-ltz v2, :cond_10

    cmp-long v2, v12, v10

    if-gez v2, :cond_10

    long-to-float v2, v12

    long-to-float v12, v10

    div-float/2addr v2, v12

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 540
    :cond_10
    const v2, 0x3ca3d70a    # 0.02f

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-direct {v6, v1}, Lcom/riola/player/Engine;->setGain(F)V

    goto :goto_a

    .line 534
    :cond_11
    move/from16 v27, v2

    const v2, 0x3ca3d70a    # 0.02f

    .line 542
    :goto_a
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 544
    iget-boolean v1, v6, Lcom/riola/player/Engine;->completed:Z

    if-nez v1, :cond_13

    cmp-long v1, v34, v32

    if-lez v1, :cond_12

    if-eqz v16, :cond_12

    int-to-long v0, v0

    const-wide/16 v12, 0x1e

    sub-long v12, v17, v12

    cmp-long v0, v0, v12

    if-ltz v0, :cond_12

    goto :goto_b

    :cond_12
    const/4 v0, 0x0

    goto :goto_c

    :cond_13
    :goto_b
    const/4 v0, 0x1

    .line 545
    :goto_c
    if-nez v0, :cond_14

    move/from16 v2, v27

    move-wide/from16 v0, v32

    move-wide/from16 v23, v34

    const-wide/16 v13, 0x0

    move-wide/from16 v26, v8

    const-wide/16 v8, 0x190

    goto/16 :goto_5

    .line 547
    :cond_14
    const/4 v0, 0x0

    iput-boolean v0, v6, Lcom/riola/player/Engine;->completed:Z

    .line 548
    add-int/lit8 v12, v27, 0x1

    .line 549
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v12, v0, Lcom/riola/player/Engine$St;->repDone:I

    .line 550
    invoke-virtual/range {p1 .. p1}, Lcom/riola/player/Step;->timed()Z

    move-result v0

    if-nez v0, :cond_15

    iget v0, v7, Lcom/riola/player/Step;->times:I

    const/4 v1, 0x1

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    if-lt v12, v0, :cond_15

    .line 551
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 552
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->setGain(F)V

    .line 553
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  played "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " time(s)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 554
    return-void

    .line 556
    :cond_15
    if-lez v5, :cond_16

    const-wide/16 v0, 0x0

    cmp-long v5, v28, v0

    if-gtz v5, :cond_16

    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->setGain(F)V

    return-void

    .line 558
    :cond_16
    iget-wide v0, v7, Lcom/riola/player/Step;->gapMs:J

    const-wide/16 v30, 0x0

    cmp-long v0, v0, v30

    if-lez v0, :cond_19

    .line 559
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    .line 560
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->setGain(F)V

    .line 561
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v13, 0x1

    iput-boolean v13, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 562
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->push()V

    .line 563
    iget-wide v0, v7, Lcom/riola/player/Step;->gapMs:J

    const/4 v5, 0x0

    move-wide/from16 v24, v0

    move-object/from16 v0, p0

    move v15, v2

    move-wide/from16 v1, v24

    move-wide v13, v3

    move-wide/from16 v3, p2

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/Engine;->silence(JJZ)V

    .line 564
    iget-object v0, v6, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 565
    iget-boolean v0, v6, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v0, :cond_18

    iget v0, v6, Lcom/riola/player/Engine;->skip:I

    if-eqz v0, :cond_17

    goto :goto_d

    .line 566
    :cond_17
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    goto :goto_e

    .line 565
    :cond_18
    :goto_d
    return-void

    .line 558
    :cond_19
    move v15, v2

    move-wide v13, v3

    const/4 v1, 0x0

    .line 568
    :goto_e
    if-lez v23, :cond_1a

    goto :goto_f

    :cond_1a
    const/high16 v15, 0x3f800000    # 1.0f

    :goto_f
    invoke-direct {v6, v15}, Lcom/riola/player/Engine;->setGain(F)V

    .line 569
    invoke-direct {v6, v13, v14}, Lcom/riola/player/Engine;->startAt(J)V

    .line 570
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x190

    add-long/2addr v2, v4

    .line 571
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v23

    .line 572
    move-wide v0, v2

    move-wide/from16 v26, v8

    move v2, v12

    move-wide v8, v4

    move-wide v3, v13

    move-wide/from16 v13, v30

    goto/16 :goto_5

    .line 502
    :cond_1b
    :goto_10
    invoke-direct/range {p0 .. p0}, Lcom/riola/player/Engine;->pausePlayer()V

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {v6, v0}, Lcom/riola/player/Engine;->setGain(F)V

    return-void
.end method

.method private setGain(F)V
    .locals 0

    .line 678
    iput p1, p0, Lcom/riola/player/Engine;->gain:F

    invoke-direct {p0}, Lcom/riola/player/Engine;->applyVol()V

    return-void
.end method

.method private silence(JJZ)V
    .locals 15

    .line 398
    move-object v0, p0

    move-wide/from16 v1, p1

    .line 399
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    move-wide v5, v1

    .line 400
    :goto_0
    const-wide/16 v7, 0x0

    cmp-long v9, v5, v7

    if-lez v9, :cond_4

    .line 401
    iget-boolean v9, v0, Lcom/riola/player/Engine;->stopReq:Z

    if-nez v9, :cond_3

    iget v9, v0, Lcom/riola/player/Engine;->skip:I

    if-nez v9, :cond_3

    invoke-direct {p0}, Lcom/riola/player/Engine;->expired()Z

    move-result v9

    if-eqz v9, :cond_0

    goto :goto_1

    .line 402
    :cond_0
    const-wide/16 v9, 0xc8

    invoke-direct {p0, v9, v10}, Lcom/riola/player/Engine;->waitLock(J)V

    .line 403
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v9

    .line 404
    sub-long v3, v9, v3

    .line 405
    nop

    .line 406
    iget-boolean v11, v0, Lcom/riola/player/Engine;->paused:Z

    if-nez v11, :cond_1

    sub-long/2addr v5, v3

    .line 407
    :cond_1
    if-eqz p5, :cond_2

    .line 408
    iget-object v3, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    sub-long v11, v1, v5

    const-wide/32 v13, 0x7fffffff

    invoke-static {v13, v14, v11, v12}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v11

    long-to-int v4, v11

    iput v4, v3, Lcom/riola/player/Engine$St;->posMs:I

    .line 409
    iget-object v3, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-static {v13, v14, v1, v2}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v11

    long-to-int v4, v11

    iput v4, v3, Lcom/riola/player/Engine$St;->durMs:I

    .line 410
    iget-object v3, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v11

    iput-wide v11, v3, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 411
    iget-object v3, v0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v7

    add-long v7, p3, v7

    iput-wide v7, v3, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 412
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    .line 414
    :cond_2
    move-wide v3, v9

    goto :goto_0

    .line 401
    :cond_3
    :goto_1
    return-void

    .line 415
    :cond_4
    return-void
.end method

.method private startAt(J)V
    .locals 3

    .line 625
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 626
    if-nez v0, :cond_0

    return-void

    .line 627
    :cond_0
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/riola/player/Engine;->completed:Z

    .line 629
    long-to-int p1, p1

    int-to-long v1, p1

    const/4 p2, 0x3

    :try_start_0
    invoke-virtual {v0, v1, v2, p2}, Landroid/media/MediaPlayer;->seekTo(JI)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 630
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p2

    :try_start_1
    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V

    goto :goto_0

    .line 631
    :goto_1
    iget-boolean p1, p0, Lcom/riola/player/Engine;->paused:Z

    if-nez p1, :cond_1

    .line 632
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    .line 633
    invoke-direct {p0}, Lcom/riola/player/Engine;->applySpeed()V

    .line 635
    :cond_1
    invoke-direct {p0}, Lcom/riola/player/Engine;->applyVol()V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0

    .line 638
    goto :goto_2

    .line 636
    :catch_0
    move-exception p1

    .line 637
    const-string p1, "  ! could not start playback"

    invoke-virtual {p0, p1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 639
    :goto_2
    return-void
.end method

.method private waitLock(J)V
    .locals 2

    .line 705
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const-wide/16 p1, 0x1

    .line 706
    :cond_0
    iget-object v0, p0, Lcom/riola/player/Engine;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 707
    :try_start_0
    iget-object v1, p0, Lcom/riola/player/Engine;->lock:Ljava/lang/Object;

    invoke-virtual {v1, p1, p2}, Ljava/lang/Object;->wait(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 708
    :catchall_0
    move-exception p1

    goto :goto_1

    .line 707
    :catch_0
    move-exception p1

    :try_start_1
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Thread;->interrupt()V

    .line 708
    :goto_0
    monitor-exit v0

    .line 709
    return-void

    .line 708
    :goto_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private wake()V
    .locals 2

    .line 712
    iget-object v0, p0, Lcom/riola/player/Engine;->lock:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/riola/player/Engine;->lock:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    monitor-exit v0

    .line 713
    return-void

    .line 712
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method


# virtual methods
.method public addListener(Lcom/riola/player/Engine$Listener;)V
    .locals 1

    .line 92
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/riola/player/Engine;->listeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/riola/player/Engine;->listeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public clearLog()V
    .locals 3

    .line 98
    iget-object v0, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->setLength(I)V

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public isPaused()Z
    .locals 1

    .line 96
    iget-boolean v0, p0, Lcom/riola/player/Engine;->paused:Z

    return v0
.end method

.method public isPlaying(Lcom/riola/player/Program;)Z
    .locals 1

    .line 102
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object p1, p1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v0, v0, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public isRunning()Z
    .locals 1

    .line 95
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    return v0
.end method

.method public isShuffled()Z
    .locals 1

    .line 234
    iget-boolean v0, p0, Lcom/riola/player/Engine;->shuffled:Z

    return v0
.end method

.method public jumpTo(I)V
    .locals 3

    .line 217
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_3

    if-ltz p1, :cond_3

    iget-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p1, v0, :cond_0

    goto :goto_2

    .line 218
    :cond_0
    nop

    .line 219
    iget-object v0, p0, Lcom/riola/player/Engine;->order:[I

    .line 220
    if-eqz v0, :cond_2

    .line 221
    const/4 v1, 0x0

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_2

    aget v2, v0, v1

    if-ne v2, p1, :cond_1

    move p1, v1

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 223
    :cond_2
    :goto_1
    iput p1, p0, Lcom/riola/player/Engine;->jump:I

    .line 224
    const/4 p1, 0x2

    iput p1, p0, Lcom/riola/player/Engine;->skip:I

    .line 225
    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    .line 226
    return-void

    .line 217
    :cond_3
    :goto_2
    return-void
.end method

.method public log(Ljava/lang/String;)V
    .locals 5

    .line 727
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/32 v3, 0x36ee80

    rem-long/2addr v1, v3

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 728
    iget-object v0, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    monitor-enter v0

    .line 729
    :try_start_0
    iget-object v1, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 730
    iget-object v1, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    const/16 v2, 0x5dc0

    if-le v1, v2, :cond_0

    iget-object v1, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    add-int/lit16 v2, v2, -0x3e80

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/StringBuilder;->delete(II)Ljava/lang/StringBuilder;

    .line 731
    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 732
    iget-object v0, p0, Lcom/riola/player/Engine;->main:Landroid/os/Handler;

    new-instance v1, Lcom/riola/player/Engine$6;

    invoke-direct {v1, p0, p1}, Lcom/riola/player/Engine$6;-><init>(Lcom/riola/player/Engine;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 737
    return-void

    .line 731
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public logText()Ljava/lang/String;
    .locals 2

    .line 97
    iget-object v0, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/riola/player/Engine;->logBuf:Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public next()V
    .locals 1

    .line 212
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iput v0, p0, Lcom/riola/player/Engine;->skip:I

    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    :cond_0
    return-void
.end method

.method public prev()V
    .locals 1

    .line 213
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_0

    const/4 v0, -0x1

    iput v0, p0, Lcom/riola/player/Engine;->skip:I

    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    :cond_0
    return-void
.end method

.method public previewTrack(Lcom/riola/player/Track;)V
    .locals 2

    .line 123
    if-nez p1, :cond_0

    return-void

    .line 124
    :cond_0
    invoke-virtual {p0}, Lcom/riola/player/Engine;->stop()V

    .line 125
    iget-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 126
    iget-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-static {p1}, Lcom/riola/player/Step;->play(Lcom/riola/player/Track;)Lcom/riola/player/Step;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 127
    const/4 p1, 0x1

    iput p1, p0, Lcom/riola/player/Engine;->loops:I

    .line 128
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const-string v1, ""

    iput-object v1, v0, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    .line 129
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const-string v1, "Preview"

    iput-object v1, v0, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    .line 130
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean p1, v0, Lcom/riola/player/Engine$St;->preview:Z

    .line 131
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/riola/player/Engine;->begin(I)V

    .line 132
    return-void
.end method

.method public removeListener(Lcom/riola/player/Engine$Listener;)V
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/riola/player/Engine;->listeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public seekTo(I)V
    .locals 1

    .line 229
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 230
    if-nez v0, :cond_0

    return-void

    .line 231
    :cond_0
    :try_start_0
    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 232
    :goto_0
    return-void
.end method

.method public setDuck(F)V
    .locals 0

    .line 271
    iput p1, p0, Lcom/riola/player/Engine;->duck:F

    invoke-direct {p0}, Lcom/riola/player/Engine;->applyVol()V

    return-void
.end method

.method public setMasterSpeed(I)V
    .locals 1

    .line 273
    int-to-float p1, p1

    const/high16 v0, 0x42c80000    # 100.0f

    div-float/2addr p1, v0

    iput p1, p0, Lcom/riola/player/Engine;->speed:F

    invoke-direct {p0}, Lcom/riola/player/Engine;->applySpeed()V

    return-void
.end method

.method public setMasterVolume(I)V
    .locals 1

    .line 272
    int-to-float p1, p1

    const/high16 v0, 0x42c80000    # 100.0f

    div-float/2addr p1, v0

    iput p1, p0, Lcom/riola/player/Engine;->vol:F

    invoke-direct {p0}, Lcom/riola/player/Engine;->applyVol()V

    return-void
.end method

.method public setPaused(Z)V
    .locals 2

    .line 195
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_6

    iget-boolean v0, p0, Lcom/riola/player/Engine;->paused:Z

    if-ne v0, p1, :cond_0

    goto :goto_2

    .line 196
    :cond_0
    iput-boolean p1, p0, Lcom/riola/player/Engine;->paused:Z

    .line 197
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean p1, v0, Lcom/riola/player/Engine$St;->paused:Z

    .line 198
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    .line 199
    :cond_1
    iget-object v0, p0, Lcom/riola/player/Engine;->mp:Landroid/media/MediaPlayer;

    .line 200
    if-eqz v0, :cond_4

    .line 202
    if-eqz p1, :cond_2

    :try_start_0
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V

    goto :goto_0

    .line 203
    :cond_2
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    invoke-direct {p0}, Lcom/riola/player/Engine;->applySpeed()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 204
    :catch_0
    move-exception v0

    :cond_3
    :goto_0
    nop

    .line 206
    :cond_4
    if-eqz p1, :cond_5

    const-string p1, "paused"

    goto :goto_1

    :cond_5
    const-string p1, "resumed"

    :goto_1
    invoke-virtual {p0, p1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 207
    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    .line 208
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    .line 209
    return-void

    .line 195
    :cond_6
    :goto_2
    return-void
.end method

.method public setShuffle(Z)V
    .locals 3

    .line 242
    iput-boolean p1, p0, Lcom/riola/player/Engine;->shuffled:Z

    .line 243
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean p1, v0, Lcom/riola/player/Engine$St;->shuffled:Z

    .line 244
    iget-boolean v0, p0, Lcom/riola/player/Engine;->running:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/riola/player/Engine;->order:[I

    if-nez v0, :cond_0

    goto :goto_3

    .line 245
    :cond_0
    iget v0, p0, Lcom/riola/player/Engine;->idx:I

    const/4 v1, 0x0

    if-ltz v0, :cond_1

    iget v0, p0, Lcom/riola/player/Engine;->idx:I

    iget-object v2, p0, Lcom/riola/player/Engine;->order:[I

    array-length v2, v2

    if-ge v0, v2, :cond_1

    iget-object v0, p0, Lcom/riola/player/Engine;->order:[I

    iget v2, p0, Lcom/riola/player/Engine;->idx:I

    aget v0, v0, v2

    goto :goto_0

    :cond_1
    move v0, v1

    .line 246
    :goto_0
    invoke-direct {p0, p1, v0}, Lcom/riola/player/Engine;->buildOrder(ZI)V

    .line 247
    if-eqz p1, :cond_2

    goto :goto_1

    :cond_2
    move v1, v0

    :goto_1
    iput v1, p0, Lcom/riola/player/Engine;->idx:I

    .line 248
    if-eqz p1, :cond_3

    const-string p1, "shuffled"

    goto :goto_2

    :cond_3
    const-string p1, "back to the written order"

    :goto_2
    invoke-virtual {p0, p1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 249
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    .line 250
    return-void

    .line 244
    :cond_4
    :goto_3
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    return-void
.end method

.method public start(Lcom/riola/player/Program;I)V
    .locals 4

    .line 107
    if-nez p1, :cond_0

    return-void

    .line 108
    :cond_0
    invoke-virtual {p1}, Lcom/riola/player/Program;->enabledCount()I

    move-result v0

    if-nez v0, :cond_1

    .line 109
    const-string p1, "nothing to play - every step is switched off"

    invoke-virtual {p0, p1}, Lcom/riola/player/Engine;->log(Ljava/lang/String;)V

    .line 110
    return-void

    .line 112
    :cond_1
    invoke-virtual {p0}, Lcom/riola/player/Engine;->stop()V

    .line 113
    iget-object v0, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 114
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v2, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    iget-object v3, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Step;

    invoke-virtual {v3}, Lcom/riola/player/Step;->copy()Lcom/riola/player/Step;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 115
    :cond_2
    iget v1, p1, Lcom/riola/player/Program;->loops:I

    iput v1, p0, Lcom/riola/player/Engine;->loops:I

    .line 116
    iget-object v1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object v2, p1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iput-object v2, v1, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    .line 117
    iget-object v1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iget-object p1, p1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    iput-object p1, v1, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    .line 118
    iget-object p1, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v0, p1, Lcom/riola/player/Engine$St;->preview:Z

    .line 119
    iget-object p1, p0, Lcom/riola/player/Engine;->steps:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    add-int/lit8 p1, p1, -0x1

    invoke-static {p2, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-direct {p0, p1}, Lcom/riola/player/Engine;->begin(I)V

    .line 120
    return-void
.end method

.method public stop()V
    .locals 4

    .line 171
    iget-object v0, p0, Lcom/riola/player/Engine;->worker:Ljava/lang/Thread;

    .line 172
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/riola/player/Engine;->stopReq:Z

    .line 173
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/riola/player/Engine;->paused:Z

    .line 174
    invoke-direct {p0}, Lcom/riola/player/Engine;->wake()V

    .line 175
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Thread;->isAlive()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    if-eq v2, v0, :cond_0

    .line 176
    const-wide/16 v2, 0x7d0

    :try_start_0
    invoke-virtual {v0, v2, v3}, Ljava/lang/Thread;->join(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 178
    :cond_0
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/riola/player/Engine;->worker:Ljava/lang/Thread;

    .line 179
    iput-boolean v1, p0, Lcom/riola/player/Engine;->running:Z

    .line 180
    iget-object v0, p0, Lcom/riola/player/Engine;->bell:Lcom/riola/player/Bell;

    invoke-virtual {v0}, Lcom/riola/player/Bell;->stop()V

    .line 181
    invoke-direct {p0}, Lcom/riola/player/Engine;->releasePlayer()V

    .line 182
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->running:Z

    .line 183
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->paused:Z

    .line 184
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-boolean v1, v0, Lcom/riola/player/Engine$St;->resting:Z

    .line 185
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v1, v0, Lcom/riola/player/Engine$St;->posMs:I

    .line 186
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v1, v0, Lcom/riola/player/Engine$St;->durMs:I

    .line 187
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const-wide/16 v1, -0x1

    iput-wide v1, v0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 188
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput-wide v1, v0, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 189
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    const/4 v1, -0x1

    iput v1, v0, Lcom/riola/player/Engine$St;->repTotal:I

    .line 190
    iget-object v0, p0, Lcom/riola/player/Engine;->st:Lcom/riola/player/Engine$St;

    iput v1, v0, Lcom/riola/player/Engine$St;->countIn:I

    .line 191
    invoke-direct {p0}, Lcom/riola/player/Engine;->push()V

    .line 192
    return-void
.end method

.method public togglePause()V
    .locals 1

    .line 211
    iget-boolean v0, p0, Lcom/riola/player/Engine;->paused:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, v0}, Lcom/riola/player/Engine;->setPaused(Z)V

    return-void
.end method
