.class public final Lcom/riola/player/Backup;
.super Ljava/lang/Object;
.source "Backup.java"


# static fields
.field private static final MAX_BYTES:I = 0x400000

.field private static pending:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 27
    const-string v0, ""

    sput-object v0, Lcom/riola/player/Backup;->pending:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static ask(Landroid/app/Activity;ILjava/lang/String;)V
    .locals 2

    .line 50
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 51
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 52
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 53
    const-string v1, "android.intent.extra.TITLE"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    .line 54
    :try_start_0
    invoke-virtual {p0, p2, p1}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    goto :goto_0

    :catch_0
    move-exception p1

    const-string p1, "No file picker on this device"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 56
    :goto_0
    return-void
.end method

.method public static exportAll(Landroid/app/Activity;I)V
    .locals 2

    .line 33
    sget-object v0, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 34
    const-string p1, "There are no programs to export"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 35
    return-void

    .line 37
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/riola/player/Backup;->json(Ljava/util/List;Z)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Backup;->pending:Ljava/lang/String;

    .line 38
    const-string v0, "riola-programs.json"

    invoke-static {p0, p1, v0}, Lcom/riola/player/Backup;->ask(Landroid/app/Activity;ILjava/lang/String;)V

    .line 39
    return-void
.end method

.method public static exportOne(Landroid/app/Activity;Lcom/riola/player/Program;I)V
    .locals 2

    .line 42
    if-nez p1, :cond_0

    return-void

    .line 43
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 44
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 45
    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/riola/player/Backup;->json(Ljava/util/List;Z)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/riola/player/Backup;->pending:Ljava/lang/String;

    .line 46
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "riola-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object p1, p1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-static {p1}, Lcom/riola/player/Backup;->safe(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ".json"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p2, p1}, Lcom/riola/player/Backup;->ask(Landroid/app/Activity;ILjava/lang/String;)V

    .line 47
    return-void
.end method

.method private static fail(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 1

    .line 253
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    const-string v0, "Could not import"

    invoke-virtual {p0, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 254
    const-string p1, "OK"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 255
    return-void
.end method

.method private static json(Ljava/util/List;Z)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/riola/player/Program;",
            ">;Z)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 90
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 91
    const-string v1, "riola"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 92
    const-string v1, "saved"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 94
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 95
    const/4 v2, 0x0

    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_0

    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Program;

    invoke-virtual {v3}, Lcom/riola/player/Program;->toJson()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 96
    :cond_0
    const-string v2, "programs"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 100
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 101
    sget-object v2, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/riola/player/Track;

    .line 102
    if-nez p1, :cond_1

    iget-object v4, v3, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-static {p0, v4}, Lcom/riola/player/Backup;->usedBy(Ljava/util/List;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    goto :goto_1

    .line 103
    :cond_1
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 104
    const-string v5, "u"

    iget-object v6, v3, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 105
    const-string v5, "t"

    iget-object v6, v3, Lcom/riola/player/Track;->title:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 106
    const-string v5, "d"

    iget-wide v6, v3, Lcom/riola/player/Track;->durMs:J

    invoke-virtual {v4, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 107
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 108
    goto :goto_1

    .line 109
    :cond_2
    const-string p0, "lib"

    invoke-virtual {v0, p0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 110
    const/4 p0, 0x2

    invoke-virtual {v0, p0}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 111
    :catch_0
    move-exception p0

    .line 112
    const-string p0, ""

    return-object p0
.end method

.method public static pickToImport(Landroid/app/Activity;I)V
    .locals 2

    .line 59
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 60
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 61
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 62
    :try_start_0
    invoke-virtual {p0, v0, p1}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 63
    goto :goto_0

    :catch_0
    move-exception p1

    const-string p1, "No file picker on this device"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 64
    :goto_0
    return-void
.end method

.method public static read(Landroid/app/Activity;Landroid/net/Uri;)V
    .locals 12

    .line 139
    if-nez p1, :cond_0

    return-void

    .line 141
    :cond_0
    nop

    .line 142
    nop

    .line 144
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 145
    if-nez p1, :cond_2

    :try_start_1
    const-string v0, "Riola could not open that file."

    invoke-static {p0, v0}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_5
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 162
    if-eqz p1, :cond_1

    :try_start_2
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 145
    :cond_1
    :goto_0
    return-void

    .line 146
    :cond_2
    :try_start_3
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 147
    const/16 v2, 0x2000

    new-array v2, v2, [B

    .line 148
    const/4 v3, 0x0

    move v4, v3

    .line 149
    :goto_1
    invoke-virtual {p1, v2}, Ljava/io/InputStream;->read([B)I

    move-result v5

    if-lez v5, :cond_5

    .line 150
    add-int/2addr v4, v5

    .line 151
    const/high16 v6, 0x400000

    if-le v4, v6, :cond_4

    .line 152
    const-string v0, "That file is far too large to be a Riola export."

    invoke-static {p0, v0}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 162
    if-eqz p1, :cond_3

    :try_start_4
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    :catch_1
    move-exception p0

    .line 153
    :cond_3
    :goto_2
    return-void

    .line 155
    :cond_4
    :try_start_5
    invoke-virtual {v1, v2, v3, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1

    .line 157
    :cond_5
    new-instance v2, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    const-string v4, "UTF-8"

    invoke-direct {v2, v1, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 162
    if-eqz p1, :cond_6

    :try_start_6
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_3

    :catch_2
    move-exception p1

    .line 165
    :cond_6
    :goto_3
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    if-nez p1, :cond_7

    .line 166
    const-string p1, "That file is empty."

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V

    .line 167
    return-void

    .line 172
    :cond_7
    :try_start_7
    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4

    .line 176
    nop

    .line 178
    const-string v1, "programs"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    .line 179
    if-eqz v1, :cond_1c

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-nez v2, :cond_8

    goto/16 :goto_d

    .line 186
    :cond_8
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 187
    const-string v4, "lib"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    .line 188
    if-eqz p1, :cond_c

    .line 189
    move v4, v3

    :goto_4
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v4, v5, :cond_c

    .line 190
    invoke-virtual {p1, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 191
    if-nez v5, :cond_9

    goto :goto_5

    .line 192
    :cond_9
    const-string v6, "u"

    const-string v7, ""

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 193
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v7

    if-eqz v7, :cond_b

    invoke-static {v6}, Lcom/riola/player/Store;->byUri(Ljava/lang/String;)Lcom/riola/player/Track;

    move-result-object v7

    if-eqz v7, :cond_a

    goto :goto_5

    .line 194
    :cond_a
    new-instance v7, Lcom/riola/player/Track;

    const-string v8, "t"

    const-string v9, "track"

    invoke-virtual {v5, v8, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "d"

    const-wide/16 v10, 0x0

    invoke-virtual {v5, v9, v10, v11}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v9

    invoke-direct {v7, v6, v8, v9, v10}, Lcom/riola/player/Track;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 189
    :cond_b
    :goto_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_4

    .line 198
    :cond_c
    nop

    .line 199
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 200
    move v4, v3

    move v5, v4

    move v6, v5

    :goto_6
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v7

    if-ge v4, v7, :cond_12

    .line 201
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    .line 202
    if-nez v7, :cond_d

    add-int/lit8 v6, v6, 0x1

    goto :goto_7

    .line 204
    :cond_d
    :try_start_8
    invoke-static {v7}, Lcom/riola/player/Program;->fromJson(Lorg/json/JSONObject;)Lcom/riola/player/Program;

    move-result-object v8

    .line 205
    iget-object v9, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    if-eqz v9, :cond_e

    iget-object v9, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    if-nez v9, :cond_f

    :cond_e
    const-string v9, "Imported program"

    iput-object v9, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    .line 206
    :cond_f
    iget-object v9, v8, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v9}, Ljava/util/List;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_10

    const-string v9, "st"

    invoke-virtual {v7, v9}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v7

    if-nez v7, :cond_10

    add-int/lit8 v6, v6, 0x1

    goto :goto_7

    .line 207
    :cond_10
    iget-object v7, v8, Lcom/riola/player/Program;->id:Ljava/lang/String;

    invoke-static {v7}, Lcom/riola/player/Store;->program(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object v7

    if-eqz v7, :cond_11

    .line 208
    iget-object v7, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-static {v7}, Lcom/riola/player/Program;->blank(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object v7

    iget-object v7, v7, Lcom/riola/player/Program;->id:Ljava/lang/String;

    iput-object v7, v8, Lcom/riola/player/Program;->id:Ljava/lang/String;

    .line 209
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v9, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, " (imported)"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v8, Lcom/riola/player/Program;->name:Ljava/lang/String;

    .line 211
    :cond_11
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    iput-wide v9, v8, Lcom/riola/player/Program;->updated:J

    .line 212
    sget-object v7, Lcom/riola/player/Store;->PROGRAMS:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v7, v8}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 213
    invoke-interface {p1, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_3

    .line 214
    add-int/lit8 v5, v5, 0x1

    .line 217
    goto :goto_7

    .line 215
    :catch_3
    move-exception v7

    .line 216
    add-int/lit8 v6, v6, 0x1

    .line 200
    :goto_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_6

    .line 220
    :cond_12
    if-nez v5, :cond_13

    .line 221
    const-string p1, "Nothing in that file could be read as a program."

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V

    .line 222
    return-void

    .line 225
    :cond_13
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    .line 226
    sget-object v4, Lcom/riola/player/Store;->LIB:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4, v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->addAll(Ljava/util/Collection;)Z

    .line 227
    invoke-static {p0}, Lcom/riola/player/Store;->saveLib(Landroid/content/Context;)V

    .line 228
    invoke-static {p0}, Lcom/riola/player/Store;->savePrograms(Landroid/content/Context;)V

    .line 231
    nop

    .line 232
    move v2, v3

    :goto_8
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    const/4 v7, 0x1

    if-ge v2, v4, :cond_15

    .line 233
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/riola/player/Program;

    invoke-virtual {v4}, Lcom/riola/player/Program;->hasMissing()Z

    move-result v4

    if-eqz v4, :cond_14

    move v3, v7

    goto :goto_9

    .line 232
    :cond_14
    add-int/lit8 v2, v2, 0x1

    goto :goto_8

    .line 236
    :cond_15
    :goto_9
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    .line 237
    const-string v2, "Added "

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    if-ne v5, v7, :cond_16

    const-string v4, " program"

    goto :goto_a

    :cond_16
    const-string v4, " programs"

    :goto_a
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 238
    if-lez v1, :cond_18

    const-string v2, " and "

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    if-ne v1, v7, :cond_17

    const-string v1, " track"

    goto :goto_b

    :cond_17
    const-string v1, " tracks"

    :goto_b
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 239
    :cond_18
    const-string v1, "."

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 240
    if-lez v6, :cond_1a

    .line 241
    const-string v1, "\n\n"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    if-ne v6, v7, :cond_19

    const-string v2, " entry was"

    goto :goto_c

    :cond_19
    const-string v2, " entries were"

    :goto_c
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 242
    const-string v2, " skipped because they could not be read."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 244
    :cond_1a
    if-eqz v3, :cond_1b

    .line 245
    const-string v1, "\n\nSome steps point at files this phone cannot open, so they are marked missing. Add those tracks again and the steps will reconnect on their own."

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 248
    :cond_1b
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    const-string v1, "Imported"

    invoke-virtual {p0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 249
    const-string p1, "Done"

    invoke-virtual {p0, p1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 250
    return-void

    .line 180
    :cond_1c
    :goto_d
    const-string p1, "That file is readable, but there are no Riola programs inside it."

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V

    .line 181
    return-void

    .line 173
    :catch_4
    move-exception p1

    .line 174
    const-string p1, "That is not a Riola export. Pick the .json file that Riola wrote."

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V

    .line 175
    return-void

    .line 162
    :catchall_0
    move-exception p0

    move-object v0, p1

    goto :goto_10

    .line 158
    :catch_5
    move-exception v0

    move-object v0, p1

    goto :goto_e

    .line 162
    :catchall_1
    move-exception p0

    goto :goto_10

    .line 158
    :catch_6
    move-exception p1

    .line 159
    :goto_e
    :try_start_9
    const-string p1, "Riola could not read that file."

    invoke-static {p0, p1}, Lcom/riola/player/Backup;->fail(Landroid/app/Activity;Ljava/lang/String;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 162
    if-eqz v0, :cond_1d

    :try_start_a
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_7

    goto :goto_f

    :catch_7
    move-exception p0

    .line 160
    :cond_1d
    :goto_f
    return-void

    .line 162
    :goto_10
    if-eqz v0, :cond_1e

    :try_start_b
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_8

    goto :goto_11

    :catch_8
    move-exception p1

    .line 163
    :cond_1e
    :goto_11
    throw p0
.end method

.method private static safe(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .line 127
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 128
    if-nez p0, :cond_0

    const-string p0, ""

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 129
    :goto_0
    const/4 v1, 0x0

    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_4

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    const/16 v3, 0x28

    if-ge v2, v3, :cond_4

    .line 130
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 131
    invoke-static {v2}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 132
    :cond_1
    const/16 v3, 0x20

    const/16 v4, 0x2d

    if-eq v2, v3, :cond_2

    if-eq v2, v4, :cond_2

    const/16 v3, 0x5f

    if-ne v2, v3, :cond_3

    :cond_2
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 129
    :cond_3
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 134
    :cond_4
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result p0

    if-nez p0, :cond_5

    const-string p0, "program"

    goto :goto_3

    :cond_5
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :goto_3
    return-object p0
.end method

.method private static usedBy(Ljava/util/List;Ljava/lang/String;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/riola/player/Program;",
            ">;",
            "Ljava/lang/String;",
            ")Z"
        }
    .end annotation

    .line 117
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 118
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/riola/player/Program;

    iget-object v2, v2, Lcom/riola/player/Program;->steps:Ljava/util/List;

    .line 119
    move v3, v0

    :goto_1
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_1

    .line 120
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/riola/player/Step;

    iget-object v4, v4, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 p0, 0x1

    return p0

    .line 119
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 117
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 123
    :cond_2
    return v0
.end method

.method public static write(Landroid/app/Activity;Landroid/net/Uri;)V
    .locals 4

    .line 68
    const-string v0, "Could not write that file"

    sget-object v1, Lcom/riola/player/Backup;->pending:Ljava/lang/String;

    .line 69
    const-string v2, ""

    sput-object v2, Lcom/riola/player/Backup;->pending:Ljava/lang/String;

    .line 70
    if-eqz p1, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_4

    .line 74
    :cond_0
    nop

    .line 76
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, p1}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v2

    .line 77
    if-nez v2, :cond_2

    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 84
    if-eqz v2, :cond_1

    :try_start_1
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 77
    :cond_1
    :goto_0
    return-void

    .line 78
    :cond_2
    :try_start_2
    const-string p1, "UTF-8"

    invoke-virtual {v1, p1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/io/OutputStream;->write([B)V

    .line 79
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 80
    const-string p1, "Exported"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 84
    if-eqz v2, :cond_3

    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    move-exception p0

    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_2

    .line 81
    :catch_2
    move-exception p1

    .line 82
    :try_start_4
    invoke-static {p0, v0}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 84
    if-eqz v2, :cond_3

    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    .line 86
    :cond_3
    :goto_1
    return-void

    .line 84
    :goto_2
    if-eqz v2, :cond_4

    :try_start_6
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_3

    :catch_3
    move-exception p1

    .line 85
    :cond_4
    :goto_3
    throw p0

    .line 71
    :cond_5
    :goto_4
    const-string p1, "Nothing to write"

    invoke-static {p0, p1}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 72
    return-void
.end method
