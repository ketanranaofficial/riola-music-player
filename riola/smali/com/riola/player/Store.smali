.class public final Lcom/riola/player/Store;
.super Ljava/lang/Object;
.source "Store.java"


# static fields
.field public static final LIB:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/riola/player/Track;",
            ">;"
        }
    .end annotation
.end field

.field public static final MISSING:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/riola/player/Program;",
            ">;"
        }
    .end annotation
.end field

.field public static final SORTS:[Ljava/lang/String;

.field private static loaded:Z


# direct methods
.method static constructor <clinit>()V
    .locals 10

    .line 20
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 21
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 29
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    .line 31
    const/4 v0, 0x0

    sput-boolean v0, Lcom/riola/player/Store;->loaded:Z

    .line 178
    const-string v1, "Manual order"

    const-string v2, "Name A to Z"

    const-string v3, "Name Z to A"

    const-string v4, "Recently added"

    const-string v5, "Oldest added"

    const-string v6, "Newest file"

    const-string v7, "Oldest file"

    const-string v8, "Longest first"

    const-string v9, "Shortest first"

    filled-new-array/range {v1 .. v9}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Store;->SORTS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(JJ)I
    .locals 0

    .line 17
    invoke-static {p0, p1, p2, p3}, Lcom/riola/player/Store;->cmp(JJ)I

    move-result p0

    return p0
.end method

.method public static byKey(Ljava/lang/String;)Lcom/riola/player/Track;
    .locals 3

    .line 82
    sget-object v0, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/riola/player/Track;

    invoke-virtual {v1}, Lcom/riola/player/Track;->key()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    .line 83
    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static byUri(Ljava/lang/String;)Lcom/riola/player/Track;
    .locals 4

    .line 87
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 88
    :cond_0
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    iget-object v3, v2, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v2

    .line 89
    :cond_2
    return-object v0

    .line 87
    :cond_3
    :goto_0
    return-object v0
.end method

.method private static cmp(JJ)I
    .locals 0

    .line 213
    cmp-long p0, p0, p2

    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    if-gez p0, :cond_1

    const/4 p0, -0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x1

    :goto_0
    return p0
.end method

.method public static dedupe()V
    .locals 5

    .line 72
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 73
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 74
    sget-object v2, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Track;

    invoke-virtual {v3}, Lcom/riola/player/Track;->key()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 75
    :cond_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    sget-object v2, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    if-ne v0, v3, :cond_2

    return-void

    .line 76
    :cond_2
    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 77
    invoke-virtual {v2, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->addAll(Ljava/util/Collection;)Z

    .line 78
    return-void
.end method

.method public static delete(Landroid/content/Context;Lcom/riola/player/Program;)V
    .locals 1

    .line 163
    sget-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 164
    invoke-static {p0}, Lcom/riola/player/Store;->savePrograms(Landroid/content/Context;)V

    .line 165
    return-void
.end method

.method public static indexOf(Ljava/lang/String;)I
    .locals 3

    .line 93
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_1

    invoke-virtual {v1, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/riola/player/Track;

    iget-object v1, v1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 94
    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method public static declared-synchronized load(Landroid/content/Context;)V
    .locals 13

    const-class v0, Lcom/riola/player/Store;

    monitor-enter v0

    .line 40
    :try_start_0
    sget-boolean v1, Lcom/riola/player/Store;->loaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    .line 41
    :cond_0
    const/4 v1, 0x1

    :try_start_1
    sput-boolean v1, Lcom/riola/player/Store;->loaded:Z

    .line 42
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 43
    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 45
    const/4 v1, 0x0

    :try_start_2
    new-instance v2, Lorg/json/JSONArray;

    invoke-static {p0}, Lcom/riola/player/Store;->sp(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    const-string v4, "lib"

    const-string v5, "[]"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 46
    move v3, v1

    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v3, v4, :cond_1

    .line 47
    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 48
    new-instance v5, Lcom/riola/player/Track;

    const-string v6, "u"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "t"

    const-string v8, "track"

    invoke-virtual {v4, v7, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "d"

    const-wide/16 v9, 0x0

    invoke-virtual {v4, v8, v9, v10}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v11

    invoke-direct {v5, v6, v7, v11, v12}, Lcom/riola/player/Track;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 49
    const-string v6, "a"

    const/4 v7, -0x1

    invoke-virtual {v4, v6, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    iput v6, v5, Lcom/riola/player/Track;->audioTrack:I

    .line 50
    const-string v6, "ad"

    invoke-virtual {v4, v6, v9, v10}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v6

    iput-wide v6, v5, Lcom/riola/player/Track;->addedAt:J

    .line 51
    const-string v6, "md"

    invoke-virtual {v4, v6, v9, v10}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v6

    iput-wide v6, v5, Lcom/riola/player/Track;->modifiedAt:J

    .line 52
    sget-object v4, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4, v5}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 46
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 54
    :catch_0
    move-exception v2

    :try_start_3
    sget-object v2, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    :cond_1
    nop

    .line 55
    invoke-static {}, Lcom/riola/player/Store;->dedupe()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 57
    :try_start_4
    new-instance v2, Lorg/json/JSONArray;

    invoke-static {p0}, Lcom/riola/player/Store;->sp(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v3, "programs"

    const-string v4, "[]"

    invoke-interface {p0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 58
    nop

    :goto_1
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result p0

    if-ge v1, p0, :cond_3

    .line 59
    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object p0

    .line 60
    if-eqz p0, :cond_2

    sget-object v3, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-static {p0}, Lcom/riola/player/Program;->fromJson(Lorg/json/JSONObject;)Lcom/riola/player/Program;

    move-result-object p0

    invoke-virtual {v3, p0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 58
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 62
    :catch_1
    move-exception p0

    :try_start_5
    sget-object p0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {p0}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    :cond_3
    nop

    .line 63
    invoke-static {}, Lcom/riola/player/Store;->sortPrograms()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 64
    monitor-exit v0

    return-void

    .line 39
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static program(Ljava/lang/String;)Lcom/riola/player/Program;
    .locals 4

    .line 151
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 152
    :cond_0
    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Program;

    iget-object v3, v2, Lcom/riola/player/Program;->id:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v2

    .line 153
    :cond_2
    return-object v0
.end method

.method public static put(Landroid/content/Context;Lcom/riola/player/Program;)V
    .locals 2

    .line 157
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lcom/riola/player/Program;->updated:J

    .line 158
    iget-object v0, p1, Lcom/riola/player/Program;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/riola/player/Store;->program(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 159
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Store;->savePrograms(Landroid/content/Context;)V

    .line 160
    return-void
.end method

.method public static readable(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .line 103
    invoke-static {p1}, Lcom/riola/player/Store;->byUri(Ljava/lang/String;)Lcom/riola/player/Track;

    move-result-object v0

    .line 104
    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 105
    :cond_0
    nop

    .line 107
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    invoke-virtual {v0}, Lcom/riola/player/Track;->toUri()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v2

    .line 108
    if-eqz v2, :cond_1

    const/4 p0, 0x1

    goto :goto_0

    :cond_1
    move p0, v1

    .line 109
    :goto_0
    if-eqz p0, :cond_2

    sget-object v0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_1

    .line 110
    :cond_2
    sget-object v0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 111
    :goto_1
    nop

    .line 116
    if-eqz v2, :cond_3

    :try_start_1
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    .line 111
    :cond_3
    :goto_2
    return p0

    .line 116
    :catchall_0
    move-exception p0

    goto :goto_4

    .line 112
    :catch_1
    move-exception p0

    .line 113
    :try_start_2
    sget-object p0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    invoke-interface {p0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 114
    nop

    .line 116
    if-eqz v2, :cond_4

    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_3

    :catch_2
    move-exception p0

    .line 114
    :cond_4
    :goto_3
    return v1

    .line 116
    :goto_4
    if-eqz v2, :cond_5

    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_5

    :catch_3
    move-exception p1

    .line 117
    :cond_5
    :goto_5
    throw p0
.end method

.method public static sample()Lcom/riola/player/Program;
    .locals 6

    .line 217
    const-string v0, "My first program"

    invoke-static {v0}, Lcom/riola/player/Program;->blank(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object v0

    .line 218
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v2

    if-lez v2, :cond_1

    .line 219
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/riola/player/Track;

    .line 220
    invoke-static {v1}, Lcom/riola/player/Step;->play(Lcom/riola/player/Track;)Lcom/riola/player/Step;

    move-result-object v2

    .line 221
    iget-object v3, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 222
    iget-object v2, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    const-wide/32 v3, 0xea60

    invoke-static {v3, v4}, Lcom/riola/player/Step;->silence(J)Lcom/riola/player/Step;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 223
    iget-wide v2, v1, Lcom/riola/player/Track;->durMs:J

    const-wide/32 v4, 0x15f90

    cmp-long v2, v2, v4

    if-lez v2, :cond_0

    goto :goto_0

    :cond_0
    iget-wide v2, v1, Lcom/riola/player/Track;->durMs:J

    const-wide/16 v4, 0x2

    div-long/2addr v2, v4

    const-wide/16 v4, 0x4e20

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v4

    .line 224
    :goto_0
    const-wide/16 v2, 0x7530

    invoke-static {v1, v2, v3, v4, v5}, Lcom/riola/player/Step;->section(Lcom/riola/player/Track;JJ)Lcom/riola/player/Step;

    move-result-object v1

    .line 225
    const/4 v2, 0x4

    iput v2, v1, Lcom/riola/player/Step;->times:I

    .line 226
    const-wide/16 v2, 0xbb8

    iput-wide v2, v1, Lcom/riola/player/Step;->gapMs:J

    .line 227
    iget-object v2, v0, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 229
    :cond_1
    return-object v0
.end method

.method public static saveLib(Landroid/content/Context;)V
    .locals 7

    .line 121
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 122
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    .line 124
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 125
    const-string v4, "u"

    iget-object v5, v2, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 126
    const-string v4, "t"

    iget-object v5, v2, Lcom/riola/player/Track;->title:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 127
    const-string v4, "d"

    iget-wide v5, v2, Lcom/riola/player/Track;->durMs:J

    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 128
    const-string v4, "a"

    iget v5, v2, Lcom/riola/player/Track;->audioTrack:I

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 129
    const-string v4, "ad"

    iget-wide v5, v2, Lcom/riola/player/Track;->addedAt:J

    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 130
    const-string v4, "md"

    iget-wide v5, v2, Lcom/riola/player/Track;->modifiedAt:J

    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 131
    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 132
    :catch_0
    move-exception v2

    :goto_1
    nop

    .line 133
    goto :goto_0

    .line 134
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Store;->sp(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "lib"

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 135
    return-void
.end method

.method public static savePrograms(Landroid/content/Context;)V
    .locals 3

    .line 168
    invoke-static {}, Lcom/riola/player/Store;->sortPrograms()V

    .line 169
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 170
    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Program;

    .line 171
    :try_start_0
    invoke-virtual {v2}, Lcom/riola/player/Program;->toJson()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v2

    .line 172
    :goto_1
    goto :goto_0

    .line 173
    :cond_0
    invoke-static {p0}, Lcom/riola/player/Store;->sp(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "programs"

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 174
    return-void
.end method

.method public static sortPrograms()V
    .locals 3

    .line 139
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 140
    new-instance v2, Lcom/riola/player/Store$1;

    invoke-direct {v2}, Lcom/riola/player/Store$1;-><init>()V

    invoke-static {v0, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 146
    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 147
    invoke-virtual {v1, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->addAll(Ljava/util/Collection;)Z

    .line 148
    return-void
.end method

.method private static sp(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    .line 36
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "riola.prefs"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    return-object p0
.end method

.method public static view(ILjava/lang/String;)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/riola/player/Track;",
            ">;"
        }
    .end annotation

    .line 189
    if-nez p1, :cond_0

    const-string p1, ""

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    .line 190
    :goto_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 191
    sget-object v1, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Track;

    .line 192
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v2}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 193
    :cond_2
    goto :goto_1

    .line 194
    :cond_3
    if-gtz p0, :cond_4

    return-object v0

    .line 195
    :cond_4
    nop

    .line 196
    new-instance p1, Lcom/riola/player/Store$2;

    invoke-direct {p1, p0}, Lcom/riola/player/Store$2;-><init>(I)V

    invoke-static {v0, p1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 210
    return-object v0
.end method
