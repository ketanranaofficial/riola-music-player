.class public Lcom/riola/player/Bell;
.super Ljava/lang/Object;
.source "Bell.java"


# static fields
.field public static final BRIGHT:I = 0x2

.field private static final CACHE:[[S

.field public static final DESK:I = 0x3

.field private static final F0:[F

.field private static final LEN:[J

.field public static final LOW:I = 0x0

.field private static final NAMES:[Ljava/lang/String;

.field private static final RATE:I = 0xac44

.field public static final WARM:I = 0x1


# instance fields
.field private track:Landroid/media/AudioTrack;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 22
    const/4 v0, 0x4

    new-array v1, v0, [F

    fill-array-data v1, :array_0

    sput-object v1, Lcom/riola/player/Bell;->F0:[F

    .line 23
    new-array v1, v0, [J

    fill-array-data v1, :array_1

    sput-object v1, Lcom/riola/player/Bell;->LEN:[J

    .line 24
    const-string v1, "bright"

    const-string v2, "desk"

    const-string v3, "low"

    const-string v4, "warm"

    filled-new-array {v3, v4, v1, v2}, [Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/riola/player/Bell;->NAMES:[Ljava/lang/String;

    .line 26
    new-array v0, v0, [[S

    sput-object v0, Lcom/riola/player/Bell;->CACHE:[[S

    return-void

    :array_0
    .array-data 4
        0x432e999a    # 174.6f
        0x4382cccd    # 261.6f
        0x43c40000    # 392.0f
        0x44b90000    # 1480.0f
    .end array-data

    :array_1
    .array-data 8
        0x1770
        0x1388
        0xfa0
        0x384
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(I)[S
    .locals 0

    .line 17
    invoke-static {p0}, Lcom/riola/player/Bell;->pcm(I)[S

    move-result-object p0

    return-object p0
.end method

.method public static clamp(I)I
    .locals 1

    .line 30
    if-gez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    if-le p0, v0, :cond_1

    move p0, v0

    :cond_1
    :goto_0
    return p0
.end method

.method public static lengthMs(I)J
    .locals 3

    .line 31
    sget-object v0, Lcom/riola/player/Bell;->LEN:[J

    invoke-static {p0}, Lcom/riola/player/Bell;->clamp(I)I

    move-result p0

    aget-wide v1, v0, p0

    return-wide v1
.end method

.method private static declared-synchronized pcm(I)[S
    .locals 23

    const-class v1, Lcom/riola/player/Bell;

    monitor-enter v1

    .line 44
    :try_start_0
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Bell;->clamp(I)I

    move-result v0

    .line 45
    sget-object v2, Lcom/riola/player/Bell;->CACHE:[[S

    aget-object v2, v2, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v2, :cond_0

    monitor-exit v1

    return-object v2

    .line 47
    :cond_0
    :try_start_1
    sget-object v2, Lcom/riola/player/Bell;->LEN:[J

    aget-wide v3, v2, v0

    const-wide/32 v5, 0xac44

    mul-long/2addr v3, v5

    const-wide/16 v5, 0x3e8

    div-long/2addr v3, v5

    long-to-int v2, v3

    .line 48
    new-array v3, v2, [S

    .line 49
    sget-object v4, Lcom/riola/player/Bell;->F0:[F

    aget v4, v4, v0

    .line 54
    const/4 v5, 0x3

    if-ne v0, v5, :cond_1

    .line 58
    const/4 v5, 0x5

    new-array v7, v5, [F

    fill-array-data v7, :array_0

    .line 59
    new-array v8, v5, [F

    fill-array-data v8, :array_1

    .line 60
    new-array v5, v5, [F

    fill-array-data v5, :array_2

    .line 61
    nop

    .line 62
    nop

    .line 63
    nop

    .line 64
    const v9, 0x3ac49ba6    # 0.0015f

    const v10, 0x3da3d70a    # 0.08f

    const v11, 0x460ca000    # 9000.0f

    const/4 v12, 0x0

    goto :goto_0

    .line 66
    :cond_1
    const/4 v5, 0x6

    new-array v7, v5, [F

    fill-array-data v7, :array_3

    .line 67
    new-array v8, v5, [F

    fill-array-data v8, :array_4

    .line 68
    new-array v5, v5, [F

    fill-array-data v5, :array_5

    .line 69
    nop

    .line 70
    nop

    .line 71
    nop

    .line 72
    const v9, 0x3c03126f    # 0.008f

    const v10, 0x3eb33333    # 0.35f

    const v11, 0x462be000    # 11000.0f

    const v12, 0x3e6147ae    # 0.22f

    .line 75
    :goto_0
    nop

    .line 77
    const/4 v14, 0x0

    :goto_1
    if-ge v14, v2, :cond_9

    .line 78
    int-to-float v15, v14

    const v16, 0x472c4400    # 44100.0f

    div-float v15, v15, v16

    .line 79
    nop

    .line 80
    const/4 v13, 0x0

    const/16 v17, 0x0

    :goto_2
    array-length v6, v7

    const-wide v18, 0x3f22acb24b91e1eeL    # 1.4247585730565955E-4

    if-ge v13, v6, :cond_3

    .line 83
    aget v6, v7, v13

    mul-float/2addr v6, v4

    const v20, 0x469b0a00    # 19845.0f

    cmpl-float v6, v6, v20

    if-lez v6, :cond_2

    move/from16 v22, v0

    move-object/from16 v21, v1

    move-object/from16 v20, v8

    goto :goto_3

    .line 84
    :cond_2
    aget v6, v8, v13

    move-object/from16 v20, v8

    neg-float v8, v15

    aget v21, v5, v13
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    div-float v8, v8, v21

    move/from16 v22, v0

    move-object/from16 v21, v1

    float-to-double v0, v8

    :try_start_2
    invoke-static {v0, v1}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float v0, v0

    mul-float/2addr v6, v0

    float-to-double v0, v4

    mul-double v18, v18, v0

    aget v0, v7, v13

    float-to-double v0, v0

    mul-double v18, v18, v0

    int-to-double v0, v14

    mul-double v18, v18, v0

    invoke-static/range {v18 .. v19}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    double-to-float v0, v0

    mul-float/2addr v6, v0

    add-float v17, v17, v6

    .line 80
    :goto_3
    add-int/lit8 v13, v13, 0x1

    move-object/from16 v8, v20

    move-object/from16 v1, v21

    move/from16 v0, v22

    goto :goto_2

    .line 87
    :cond_3
    move/from16 v22, v0

    move-object/from16 v21, v1

    move-object/from16 v20, v8

    const/4 v0, 0x0

    cmpl-float v1, v12, v0

    if-lez v1, :cond_4

    .line 88
    neg-float v1, v15

    const/high16 v6, 0x40800000    # 4.0f

    div-float/2addr v1, v6

    float-to-double v0, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float v0, v0

    mul-float/2addr v0, v12

    move-object v1, v5

    float-to-double v5, v4

    mul-double v18, v18, v5

    const-wide v5, 0x3ff00c49c0000000L    # 1.003000020980835

    mul-double v18, v18, v5

    int-to-double v5, v14

    mul-double v18, v18, v5

    invoke-static/range {v18 .. v19}, Ljava/lang/Math;->sin(D)D

    move-result-wide v5

    double-to-float v5, v5

    mul-float/2addr v0, v5

    add-float v17, v17, v0

    goto :goto_4

    .line 87
    :cond_4
    move-object v1, v5

    .line 91
    :goto_4
    cmpg-float v0, v15, v9

    if-gez v0, :cond_5

    const-wide v5, 0x400921fb54442d18L    # Math.PI

    move-object v8, v1

    float-to-double v0, v15

    mul-double/2addr v0, v5

    float-to-double v5, v9

    div-double/2addr v0, v5

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    double-to-float v0, v0

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float/2addr v0, v1

    sub-float/2addr v1, v0

    mul-float v17, v17, v1

    goto :goto_5

    :cond_5
    move-object v8, v1

    .line 92
    :goto_5
    sub-int v0, v2, v14

    int-to-float v0, v0

    div-float v0, v0, v16

    .line 93
    cmpg-float v1, v0, v10

    if-gez v1, :cond_6

    div-float/2addr v0, v10

    mul-float v17, v17, v0

    .line 95
    :cond_6
    mul-float v0, v17, v11

    float-to-int v0, v0

    .line 96
    const/16 v1, 0x7d00

    if-le v0, v1, :cond_7

    move v0, v1

    .line 97
    :cond_7
    const/16 v1, -0x7d00

    if-ge v0, v1, :cond_8

    move v0, v1

    .line 98
    :cond_8
    int-to-short v0, v0

    aput-short v0, v3, v14

    .line 77
    add-int/lit8 v14, v14, 0x1

    move-object v5, v8

    move-object/from16 v8, v20

    move-object/from16 v1, v21

    move/from16 v0, v22

    goto/16 :goto_1

    .line 100
    :cond_9
    move/from16 v22, v0

    move-object/from16 v21, v1

    sget-object v0, Lcom/riola/player/Bell;->CACHE:[[S

    aput-object v3, v0, v22
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 101
    monitor-exit v21

    return-object v3

    .line 43
    :catchall_0
    move-exception v0

    goto :goto_6

    :catchall_1
    move-exception v0

    move-object/from16 v21, v1

    :goto_6
    monitor-exit v21

    throw v0

    nop

    :array_0
    .array-data 4
        0x3f800000    # 1.0f
        0x402d70a4    # 2.71f
        0x40a5c28f    # 5.18f
        0x41028f5c    # 8.16f
        0x4116b852    # 9.42f
    .end array-data

    :array_1
    .array-data 4
        0x3f800000    # 1.0f
        0x3f147ae1    # 0.58f
        0x3ea3d70a    # 0.32f
        0x3e23d70a    # 0.16f
        0x3da3d70a    # 0.08f
    .end array-data

    :array_2
    .array-data 4
        0x3ed70a3d    # 0.42f
        0x3e851eb8    # 0.26f
        0x3e23d70a    # 0.16f
        0x3dcccccd    # 0.1f
        0x3d75c28f    # 0.06f
    .end array-data

    :array_3
    .array-data 4
        0x3f000000    # 0.5f
        0x3f800000    # 1.0f
        0x40000000    # 2.0f
        0x403e147b    # 2.97f
        0x4081eb85    # 4.06f
        0x40adc28f    # 5.43f
    .end array-data

    :array_4
    .array-data 4
        0x3ea3d70a    # 0.32f
        0x3f800000    # 1.0f
        0x3ecccccd    # 0.4f
        0x3e3851ec    # 0.18f
        0x3db851ec    # 0.09f
        0x3d4ccccd    # 0.05f
    .end array-data

    :array_5
    .array-data 4
        0x40d00000    # 6.5f
        0x40900000    # 4.5f
        0x4019999a    # 2.4f
        0x3fa66666    # 1.3f
        0x3f4ccccd    # 0.8f
        0x3ee66666    # 0.45f
    .end array-data
.end method

.method public static preview(IF)V
    .locals 6

    .line 145
    new-instance v0, Lcom/riola/player/Bell;

    invoke-direct {v0}, Lcom/riola/player/Bell;-><init>()V

    .line 146
    invoke-virtual {v0, p0, p1}, Lcom/riola/player/Bell;->ring(IF)V

    .line 147
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {p1, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/riola/player/Bell$2;

    invoke-direct {v1, v0}, Lcom/riola/player/Bell$2;-><init>(Lcom/riola/player/Bell;)V

    .line 149
    invoke-static {p0}, Lcom/riola/player/Bell;->lengthMs(I)J

    move-result-wide v2

    const-wide/16 v4, 0xfa

    add-long/2addr v2, v4

    .line 147
    invoke-virtual {p1, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 150
    return-void
.end method

.method public static toneName(I)Ljava/lang/String;
    .locals 1

    .line 32
    sget-object v0, Lcom/riola/player/Bell;->NAMES:[Ljava/lang/String;

    invoke-static {p0}, Lcom/riola/player/Bell;->clamp(I)I

    move-result p0

    aget-object p0, v0, p0

    return-object p0
.end method

.method public static warm()V
    .locals 3

    .line 36
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/riola/player/Bell$1;

    invoke-direct {v1}, Lcom/riola/player/Bell$1;-><init>()V

    const-string v2, "riola-bell-warm"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 40
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 41
    return-void
.end method


# virtual methods
.method public ring(IF)V
    .locals 4

    .line 106
    invoke-virtual {p0}, Lcom/riola/player/Bell;->stop()V

    .line 108
    :try_start_0
    invoke-static {p1}, Lcom/riola/player/Bell;->pcm(I)[S

    move-result-object p1

    .line 109
    new-instance v0, Landroid/media/AudioTrack$Builder;

    invoke-direct {v0}, Landroid/media/AudioTrack$Builder;-><init>()V

    new-instance v1, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v1}, Landroid/media/AudioAttributes$Builder;-><init>()V

    .line 111
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v1

    .line 112
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v1

    .line 113
    invoke-virtual {v1}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v1

    .line 110
    invoke-virtual {v0, v1}, Landroid/media/AudioTrack$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioTrack$Builder;

    move-result-object v0

    new-instance v1, Landroid/media/AudioFormat$Builder;

    invoke-direct {v1}, Landroid/media/AudioFormat$Builder;-><init>()V

    .line 115
    invoke-virtual {v1, v2}, Landroid/media/AudioFormat$Builder;->setEncoding(I)Landroid/media/AudioFormat$Builder;

    move-result-object v1

    .line 116
    const v3, 0xac44

    invoke-virtual {v1, v3}, Landroid/media/AudioFormat$Builder;->setSampleRate(I)Landroid/media/AudioFormat$Builder;

    move-result-object v1

    .line 117
    const/4 v3, 0x4

    invoke-virtual {v1, v3}, Landroid/media/AudioFormat$Builder;->setChannelMask(I)Landroid/media/AudioFormat$Builder;

    move-result-object v1

    .line 118
    invoke-virtual {v1}, Landroid/media/AudioFormat$Builder;->build()Landroid/media/AudioFormat;

    move-result-object v1

    .line 114
    invoke-virtual {v0, v1}, Landroid/media/AudioTrack$Builder;->setAudioFormat(Landroid/media/AudioFormat;)Landroid/media/AudioTrack$Builder;

    move-result-object v0

    array-length v1, p1

    mul-int/2addr v1, v2

    .line 119
    invoke-virtual {v0, v1}, Landroid/media/AudioTrack$Builder;->setBufferSizeInBytes(I)Landroid/media/AudioTrack$Builder;

    move-result-object v0

    .line 120
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/media/AudioTrack$Builder;->setTransferMode(I)Landroid/media/AudioTrack$Builder;

    move-result-object v0

    .line 121
    invoke-virtual {v0}, Landroid/media/AudioTrack$Builder;->build()Landroid/media/AudioTrack;

    move-result-object v0

    .line 122
    array-length v2, p1

    invoke-virtual {v0, p1, v1, v2}, Landroid/media/AudioTrack;->write([SII)I

    .line 123
    const/4 p1, 0x0

    cmpg-float v1, p2, p1

    if-gez v1, :cond_0

    :goto_0
    move p2, p1

    goto :goto_1

    :cond_0
    const/high16 p1, 0x3f800000    # 1.0f

    cmpl-float v1, p2, p1

    if-lez v1, :cond_1

    goto :goto_0

    .line 124
    :cond_1
    :goto_1
    invoke-virtual {v0, p2}, Landroid/media/AudioTrack;->setVolume(F)I

    .line 125
    invoke-virtual {v0}, Landroid/media/AudioTrack;->play()V

    .line 126
    iput-object v0, p0, Lcom/riola/player/Bell;->track:Landroid/media/AudioTrack;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 129
    goto :goto_2

    .line 127
    :catchall_0
    move-exception p1

    .line 128
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/riola/player/Bell;->track:Landroid/media/AudioTrack;

    .line 130
    :goto_2
    return-void
.end method

.method public stop()V
    .locals 2

    .line 133
    iget-object v0, p0, Lcom/riola/player/Bell;->track:Landroid/media/AudioTrack;

    .line 134
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/riola/player/Bell;->track:Landroid/media/AudioTrack;

    .line 135
    if-nez v0, :cond_0

    return-void

    .line 136
    :cond_0
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {v0, v1}, Landroid/media/AudioTrack;->setVolume(F)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 137
    :goto_0
    :try_start_1
    invoke-virtual {v0}, Landroid/media/AudioTrack;->pause()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v1

    .line 138
    :goto_1
    :try_start_2
    invoke-virtual {v0}, Landroid/media/AudioTrack;->flush()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    :catch_2
    move-exception v1

    .line 139
    :goto_2
    :try_start_3
    invoke-virtual {v0}, Landroid/media/AudioTrack;->stop()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_3

    :catch_3
    move-exception v1

    .line 140
    :goto_3
    :try_start_4
    invoke-virtual {v0}, Landroid/media/AudioTrack;->release()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_4

    :catch_4
    move-exception v0

    .line 141
    :goto_4
    return-void
.end method
