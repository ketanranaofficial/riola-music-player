.class public Lcom/riola/player/Step;
.super Ljava/lang/Object;
.source "Step.java"


# static fields
.field public static final BELL:I = 0x3

.field public static final PLAY:I = 0x0

.field public static final SECTION:I = 0x1

.field public static final SILENCE:I = 0x2


# instance fields
.field public a:J

.field public b:J

.field public durMs:J

.field public enabled:Z

.field public endBell:Z

.field public gapMs:J

.field public speedPct:I

.field public times:I

.field public tone:I

.field public trackName:Ljava/lang/String;

.field public trackUri:Ljava/lang/String;

.field public type:I

.field public volumePct:I


# direct methods
.method public constructor <init>()V
    .locals 5

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const/4 v0, 0x0

    iput v0, p0, Lcom/riola/player/Step;->type:I

    .line 11
    const-string v1, ""

    iput-object v1, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    .line 12
    iput-object v1, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    .line 13
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/riola/player/Step;->a:J

    .line 14
    const-wide/16 v3, -0x1

    iput-wide v3, p0, Lcom/riola/player/Step;->b:J

    .line 15
    const/4 v3, 0x1

    iput v3, p0, Lcom/riola/player/Step;->times:I

    .line 16
    iput-wide v1, p0, Lcom/riola/player/Step;->durMs:J

    .line 17
    iput-wide v1, p0, Lcom/riola/player/Step;->gapMs:J

    .line 18
    const/16 v1, 0x64

    iput v1, p0, Lcom/riola/player/Step;->speedPct:I

    .line 19
    iput v1, p0, Lcom/riola/player/Step;->volumePct:I

    .line 20
    iput v3, p0, Lcom/riola/player/Step;->tone:I

    .line 21
    iput-boolean v0, p0, Lcom/riola/player/Step;->endBell:Z

    .line 22
    iput-boolean v3, p0, Lcom/riola/player/Step;->enabled:Z

    return-void
.end method

.method public static bell()Lcom/riola/player/Step;
    .locals 3

    .line 48
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 49
    const/4 v1, 0x3

    iput v1, v0, Lcom/riola/player/Step;->type:I

    .line 50
    const/4 v1, 0x1

    iput v1, v0, Lcom/riola/player/Step;->tone:I

    .line 51
    iput v1, v0, Lcom/riola/player/Step;->times:I

    .line 52
    const-wide/16 v1, 0xfa0

    iput-wide v1, v0, Lcom/riola/player/Step;->gapMs:J

    .line 53
    return-object v0
.end method

.method public static fromJson(Lorg/json/JSONObject;)Lcom/riola/player/Step;
    .locals 8

    .line 167
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 168
    const-string v1, "ty"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/riola/player/Step;->type:I

    .line 169
    const-string v1, "u"

    const-string v3, ""

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    .line 170
    const-string v1, "n"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    .line 171
    const-string v1, "a"

    const-wide/16 v3, 0x0

    invoke-virtual {p0, v1, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, v0, Lcom/riola/player/Step;->a:J

    .line 172
    const-string v1, "b"

    const-wide/16 v5, -0x1

    invoke-virtual {p0, v1, v5, v6}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, v0, Lcom/riola/player/Step;->b:J

    .line 173
    const-string v1, "x"

    const/4 v5, 0x1

    invoke-virtual {p0, v1, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/riola/player/Step;->times:I

    .line 174
    const-string v1, "d"

    invoke-virtual {p0, v1, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v6

    iput-wide v6, v0, Lcom/riola/player/Step;->durMs:J

    .line 175
    const-string v1, "g"

    invoke-virtual {p0, v1, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v3

    iput-wide v3, v0, Lcom/riola/player/Step;->gapMs:J

    .line 176
    const-string v1, "sp"

    const/16 v3, 0x64

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/riola/player/Step;->speedPct:I

    .line 177
    const-string v1, "vo"

    invoke-virtual {p0, v1, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/riola/player/Step;->volumePct:I

    .line 178
    const-string v1, "to"

    invoke-virtual {p0, v1, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/riola/player/Step;->tone:I

    .line 179
    const-string v1, "eb"

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/riola/player/Step;->endBell:Z

    .line 180
    const-string v1, "en"

    invoke-virtual {p0, v1, v5}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result p0

    iput-boolean p0, v0, Lcom/riola/player/Step;->enabled:Z

    .line 181
    return-object v0
.end method

.method public static play(Lcom/riola/player/Track;)Lcom/riola/player/Step;
    .locals 2

    .line 25
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 26
    const/4 v1, 0x0

    iput v1, v0, Lcom/riola/player/Step;->type:I

    .line 27
    invoke-virtual {v0, p0}, Lcom/riola/player/Step;->bind(Lcom/riola/player/Track;)V

    .line 28
    return-object v0
.end method

.method public static section(Lcom/riola/player/Track;JJ)Lcom/riola/player/Step;
    .locals 2

    .line 32
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 33
    const/4 v1, 0x1

    iput v1, v0, Lcom/riola/player/Step;->type:I

    .line 34
    invoke-virtual {v0, p0}, Lcom/riola/player/Step;->bind(Lcom/riola/player/Track;)V

    .line 35
    iput-wide p1, v0, Lcom/riola/player/Step;->a:J

    .line 36
    iput-wide p3, v0, Lcom/riola/player/Step;->b:J

    .line 37
    return-object v0
.end method

.method public static silence(J)Lcom/riola/player/Step;
    .locals 2

    .line 41
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 42
    const/4 v1, 0x2

    iput v1, v0, Lcom/riola/player/Step;->type:I

    .line 43
    iput-wide p0, v0, Lcom/riola/player/Step;->durMs:J

    .line 44
    return-object v0
.end method


# virtual methods
.method public bind(Lcom/riola/player/Track;)V
    .locals 1

    .line 57
    if-nez p1, :cond_0

    return-void

    .line 58
    :cond_0
    iget-object v0, p1, Lcom/riola/player/Track;->uri:Ljava/lang/String;

    iput-object v0, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    .line 59
    invoke-virtual {p1}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    .line 60
    return-void
.end method

.method public copy()Lcom/riola/player/Step;
    .locals 3

    .line 140
    new-instance v0, Lcom/riola/player/Step;

    invoke-direct {v0}, Lcom/riola/player/Step;-><init>()V

    .line 141
    iget v1, p0, Lcom/riola/player/Step;->type:I

    iput v1, v0, Lcom/riola/player/Step;->type:I

    iget-object v1, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    iput-object v1, v0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    iget-object v1, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    iput-object v1, v0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    .line 142
    iget-wide v1, p0, Lcom/riola/player/Step;->a:J

    iput-wide v1, v0, Lcom/riola/player/Step;->a:J

    iget-wide v1, p0, Lcom/riola/player/Step;->b:J

    iput-wide v1, v0, Lcom/riola/player/Step;->b:J

    iget v1, p0, Lcom/riola/player/Step;->times:I

    iput v1, v0, Lcom/riola/player/Step;->times:I

    iget-wide v1, p0, Lcom/riola/player/Step;->durMs:J

    iput-wide v1, v0, Lcom/riola/player/Step;->durMs:J

    iget-wide v1, p0, Lcom/riola/player/Step;->gapMs:J

    iput-wide v1, v0, Lcom/riola/player/Step;->gapMs:J

    .line 143
    iget v1, p0, Lcom/riola/player/Step;->speedPct:I

    iput v1, v0, Lcom/riola/player/Step;->speedPct:I

    iget v1, p0, Lcom/riola/player/Step;->volumePct:I

    iput v1, v0, Lcom/riola/player/Step;->volumePct:I

    iget v1, p0, Lcom/riola/player/Step;->tone:I

    iput v1, v0, Lcom/riola/player/Step;->tone:I

    .line 144
    iget-boolean v1, p0, Lcom/riola/player/Step;->endBell:Z

    iput-boolean v1, v0, Lcom/riola/player/Step;->endBell:Z

    iget-boolean v1, p0, Lcom/riola/player/Step;->enabled:Z

    iput-boolean v1, v0, Lcom/riola/player/Step;->enabled:Z

    .line 145
    return-object v0
.end method

.method public detail()Ljava/lang/String;
    .locals 12

    .line 87
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 88
    iget v1, p0, Lcom/riola/player/Step;->type:I

    const/4 v2, 0x2

    const-string v3, "  .  "

    if-ne v1, v2, :cond_1

    .line 89
    const-string v1, "rest for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v4, p0, Lcom/riola/player/Step;->durMs:J

    invoke-static {v4, v5}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 90
    iget-boolean v1, p0, Lcom/riola/player/Step;->endBell:Z

    if-eqz v1, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/riola/player/Step;->tone:I

    invoke-static {v2}, Lcom/riola/player/Bell;->toneName(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " bell at the end"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 91
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 93
    :cond_1
    const/4 v2, 0x3

    const-string v4, "%"

    const-string v5, "  .  vol "

    const/16 v6, 0x64

    const-wide/16 v7, 0x0

    const/4 v9, 0x1

    if-ne v1, v2, :cond_4

    .line 94
    iget v1, p0, Lcom/riola/player/Step;->tone:I

    invoke-static {v1}, Lcom/riola/player/Bell;->toneName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " tone"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 95
    iget v1, p0, Lcom/riola/player/Step;->times:I

    invoke-static {v9, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 96
    if-le v1, v9, :cond_2

    .line 97
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " rings"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 98
    iget-wide v1, p0, Lcom/riola/player/Step;->gapMs:J

    cmp-long v1, v1, v7

    if-lez v1, :cond_2

    const-string v1, " every "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/riola/player/Step;->gapMs:J

    invoke-static {v2, v3}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 100
    :cond_2
    iget v1, p0, Lcom/riola/player/Step;->volumePct:I

    if-eq v1, v6, :cond_3

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/riola/player/Step;->volumePct:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 101
    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 103
    :cond_4
    if-ne v1, v9, :cond_6

    iget-wide v1, p0, Lcom/riola/player/Step;->a:J

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v10, p0, Lcom/riola/player/Step;->b:J

    cmp-long v2, v10, v7

    if-gez v2, :cond_5

    const-string v2, "end"

    goto :goto_0

    :cond_5
    invoke-static {v10, v11}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 104
    :cond_6
    const-string v1, "whole track"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 105
    :goto_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 106
    invoke-virtual {p0}, Lcom/riola/player/Step;->timed()Z

    move-result v1

    if-eqz v1, :cond_7

    const-string v1, "loop for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v9, p0, Lcom/riola/player/Step;->durMs:J

    invoke-static {v9, v10}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 107
    :cond_7
    iget v1, p0, Lcom/riola/player/Step;->times:I

    if-ne v1, v9, :cond_8

    const-string v1, "once"

    goto :goto_2

    :cond_8
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lcom/riola/player/Step;->times:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " times"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 108
    :goto_3
    iget-wide v1, p0, Lcom/riola/player/Step;->gapMs:J

    cmp-long v1, v1, v7

    if-lez v1, :cond_9

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v7, p0, Lcom/riola/player/Step;->gapMs:J

    invoke-static {v7, v8}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " gap"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 109
    :cond_9
    iget v1, p0, Lcom/riola/player/Step;->speedPct:I

    if-eq v1, v6, :cond_a

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/riola/player/Step;->speedPct:I

    invoke-static {v2}, Lcom/riola/player/Fmt;->speed(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 110
    :cond_a
    iget v1, p0, Lcom/riola/player/Step;->volumePct:I

    if-eq v1, v6, :cond_b

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/riola/player/Step;->volumePct:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 111
    :cond_b
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public estMs()J
    .locals 8

    .line 126
    iget-boolean v0, p0, Lcom/riola/player/Step;->enabled:Z

    if-nez v0, :cond_0

    const-wide/16 v0, 0x0

    return-wide v0

    .line 127
    :cond_0
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    iget-wide v0, p0, Lcom/riola/player/Step;->durMs:J

    return-wide v0

    .line 128
    :cond_1
    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 129
    iget v0, p0, Lcom/riola/player/Step;->times:I

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 130
    iget v1, p0, Lcom/riola/player/Step;->tone:I

    invoke-static {v1}, Lcom/riola/player/Bell;->lengthMs(I)J

    move-result-wide v4

    int-to-long v6, v0

    mul-long/2addr v4, v6

    iget-wide v6, p0, Lcom/riola/player/Step;->gapMs:J

    sub-int/2addr v0, v3

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    int-to-long v0, v0

    mul-long/2addr v6, v0

    add-long/2addr v4, v6

    return-wide v4

    .line 132
    :cond_2
    invoke-virtual {p0}, Lcom/riola/player/Step;->timed()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-wide v0, p0, Lcom/riola/player/Step;->durMs:J

    return-wide v0

    .line 133
    :cond_3
    invoke-virtual {p0}, Lcom/riola/player/Step;->lengthMs()J

    move-result-wide v0

    .line 134
    iget v4, p0, Lcom/riola/player/Step;->speedPct:I

    if-lez v4, :cond_4

    const/16 v5, 0x64

    if-eq v4, v5, :cond_4

    const-wide/16 v5, 0x64

    mul-long/2addr v0, v5

    int-to-long v4, v4

    div-long/2addr v0, v4

    .line 135
    :cond_4
    iget v4, p0, Lcom/riola/player/Step;->times:I

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 136
    int-to-long v5, v4

    mul-long/2addr v0, v5

    iget-wide v5, p0, Lcom/riola/player/Step;->gapMs:J

    sub-int/2addr v4, v3

    invoke-static {v2, v4}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-long v2, v2

    mul-long/2addr v5, v2

    add-long/2addr v0, v5

    return-wide v0
.end method

.method public lengthMs()J
    .locals 7

    .line 115
    invoke-virtual {p0}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v0

    .line 116
    const-wide/16 v1, 0x0

    if-nez v0, :cond_0

    move-wide v3, v1

    goto :goto_0

    :cond_0
    iget-wide v3, v0, Lcom/riola/player/Track;->durMs:J

    .line 117
    :goto_0
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v5, 0x1

    if-ne v0, v5, :cond_2

    .line 118
    iget-wide v5, p0, Lcom/riola/player/Step;->b:J

    cmp-long v0, v5, v1

    if-gez v0, :cond_1

    goto :goto_1

    :cond_1
    move-wide v3, v5

    .line 119
    :goto_1
    iget-wide v5, p0, Lcom/riola/player/Step;->a:J

    sub-long/2addr v3, v5

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    return-wide v0

    .line 121
    :cond_2
    return-wide v3
.end method

.method public missing()Z
    .locals 2

    .line 72
    invoke-virtual {p0}, Lcom/riola/player/Step;->needsTrack()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/riola/player/Store;->MISSING:Ljava/util/Set;

    iget-object v1, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public needsTrack()Z
    .locals 2

    .line 62
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :goto_0
    return v1
.end method

.method public timed()Z
    .locals 1

    .line 75
    iget v0, p0, Lcom/riola/player/Step;->times:I

    if-gez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public title()Ljava/lang/String;
    .locals 2

    .line 78
    iget v0, p0, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const-string v0, "Silence"

    return-object v0

    .line 79
    :cond_0
    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    const-string v0, "Bell"

    return-object v0

    .line 80
    :cond_1
    invoke-virtual {p0}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v0

    .line 81
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 82
    :cond_2
    iget-object v0, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    goto :goto_1

    :cond_4
    :goto_0
    const-string v0, "Missing track"

    :goto_1
    return-object v0
.end method

.method public toJson()Lorg/json/JSONObject;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 149
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 150
    const-string v1, "ty"

    iget v2, p0, Lcom/riola/player/Step;->type:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 151
    const-string v1, "u"

    iget-object v2, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 152
    const-string v1, "n"

    iget-object v2, p0, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 153
    const-string v1, "a"

    iget-wide v2, p0, Lcom/riola/player/Step;->a:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 154
    const-string v1, "b"

    iget-wide v2, p0, Lcom/riola/player/Step;->b:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 155
    const-string v1, "x"

    iget v2, p0, Lcom/riola/player/Step;->times:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 156
    const-string v1, "d"

    iget-wide v2, p0, Lcom/riola/player/Step;->durMs:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 157
    const-string v1, "g"

    iget-wide v2, p0, Lcom/riola/player/Step;->gapMs:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 158
    const-string v1, "sp"

    iget v2, p0, Lcom/riola/player/Step;->speedPct:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 159
    const-string v1, "vo"

    iget v2, p0, Lcom/riola/player/Step;->volumePct:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 160
    const-string v1, "to"

    iget v2, p0, Lcom/riola/player/Step;->tone:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 161
    const-string v1, "eb"

    iget-boolean v2, p0, Lcom/riola/player/Step;->endBell:Z

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 162
    const-string v1, "en"

    iget-boolean v2, p0, Lcom/riola/player/Step;->enabled:Z

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 163
    return-object v0
.end method

.method public track()Lcom/riola/player/Track;
    .locals 1

    .line 65
    invoke-virtual {p0}, Lcom/riola/player/Step;->needsTrack()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 66
    :cond_0
    iget-object v0, p0, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-static {v0}, Lcom/riola/player/Store;->byUri(Ljava/lang/String;)Lcom/riola/player/Track;

    move-result-object v0

    .line 67
    return-object v0
.end method
