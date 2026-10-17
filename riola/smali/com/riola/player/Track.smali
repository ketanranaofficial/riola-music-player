.class public Lcom/riola/player/Track;
.super Ljava/lang/Object;
.source "Track.java"


# static fields
.field private static final EXTS:[Ljava/lang/String;

.field private static final VIDEO:[Ljava/lang/String;


# instance fields
.field public addedAt:J

.field public audioTrack:I

.field public durMs:J

.field public modifiedAt:J

.field public title:Ljava/lang/String;

.field public uri:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 27

    .line 29
    const-string v0, ".mp4"

    const-string v1, ".mkv"

    const-string v2, ".avi"

    const-string v3, ".mov"

    const-string v4, ".webm"

    const-string v5, ".m4v"

    const-string v6, ".3gp"

    const-string v7, ".ts"

    const-string v8, ".flv"

    const-string v9, ".wmv"

    const-string v10, ".mpg"

    const-string v11, ".mpeg"

    filled-new-array/range {v0 .. v11}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Track;->VIDEO:[Ljava/lang/String;

    .line 64
    const-string v1, ".mp3"

    const-string v2, ".m4a"

    const-string v3, ".aac"

    const-string v4, ".wav"

    const-string v5, ".ogg"

    const-string v6, ".oga"

    const-string v7, ".opus"

    const-string v8, ".flac"

    const-string v9, ".mp4"

    const-string v10, ".mka"

    const-string v11, ".wma"

    const-string v12, ".aif"

    const-string v13, ".aiff"

    const-string v14, ".mid"

    const-string v15, ".amr"

    const-string v16, ".3gp"

    const-string v17, ".mkv"

    const-string v18, ".avi"

    const-string v19, ".mov"

    const-string v20, ".webm"

    const-string v21, ".m4v"

    const-string v22, ".ts"

    const-string v23, ".flv"

    const-string v24, ".wmv"

    const-string v25, ".mpg"

    const-string v26, ".mpeg"

    filled-new-array/range {v1 .. v26}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Track;->EXTS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    const/4 v0, -0x1

    iput v0, p0, Lcom/riola/player/Track;->audioTrack:I

    .line 17
    iput-object p1, p0, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    .line 18
    iput-object p2, p0, Lcom/riola/player/Track;->title:Ljava/lang/String;

    .line 19
    iput-wide p3, p0, Lcom/riola/player/Track;->durMs:J

    .line 20
    return-void
.end method


# virtual methods
.method public isVideo()Z
    .locals 5

    .line 24
    iget-object v0, p0, Lcom/riola/player/Track;->title:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 25
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    sget-object v3, Lcom/riola/player/Track;->VIDEO:[Ljava/lang/String;

    array-length v4, v3

    if-ge v2, v4, :cond_2

    aget-object v3, v3, v2

    invoke-virtual {v0, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 26
    :cond_2
    return v1
.end method

.method public key()Ljava/lang/String;
    .locals 3

    .line 41
    :try_start_0
    invoke-virtual {p0}, Lcom/riola/player/Track;->toUri()Landroid/net/Uri;

    move-result-object v0

    .line 42
    invoke-static {v0}, Landroid/provider/DocumentsContract;->getDocumentId(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v1

    .line 43
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "|"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 44
    :catch_0
    move-exception v0

    :cond_0
    nop

    .line 45
    iget-object v0, p0, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    return-object v0
.end method

.method public shortTitle()Ljava/lang/String;
    .locals 7

    .line 54
    iget-object v0, p0, Lcom/riola/player/Track;->title:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    .line 55
    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    .line 56
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    sget-object v4, Lcom/riola/player/Track;->EXTS:[Ljava/lang/String;

    array-length v5, v4

    if-ge v3, v5, :cond_2

    .line 57
    aget-object v5, v4, v3

    invoke-virtual {v1, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    aget-object v6, v4, v3

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-le v5, v6, :cond_1

    .line 58
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    aget-object v3, v4, v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v1, v3

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 56
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 61
    :cond_2
    return-object v0
.end method

.method public toUri()Landroid/net/Uri;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    return-object v0
.end method
