.class public Lcom/riola/player/Engine$St;
.super Ljava/lang/Object;
.source "Engine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/riola/player/Engine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "St"
.end annotation


# instance fields
.field public countIn:I

.field public durMs:I

.field public loopDone:I

.field public loopTotal:I

.field public paused:Z

.field public posMs:I

.field public preview:Z

.field public progRemainMs:J

.field public programId:Ljava/lang/String;

.field public programName:Ljava/lang/String;

.field public repDone:I

.field public repTotal:I

.field public resting:Z

.field public running:Z

.field public shuffled:Z

.field public skipped:I

.field public step:I

.field public stepDetail:Ljava/lang/String;

.field public stepRemainMs:J

.field public stepTitle:Ljava/lang/String;

.field public steps:I

.field public trackUri:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    const-string v0, ""

    iput-object v0, p0, Lcom/riola/player/Engine$St;->programId:Ljava/lang/String;

    iput-object v0, p0, Lcom/riola/player/Engine$St;->programName:Ljava/lang/String;

    .line 28
    iput-object v0, p0, Lcom/riola/player/Engine$St;->stepTitle:Ljava/lang/String;

    iput-object v0, p0, Lcom/riola/player/Engine$St;->stepDetail:Ljava/lang/String;

    .line 29
    iput-object v0, p0, Lcom/riola/player/Engine$St;->trackUri:Ljava/lang/String;

    .line 31
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/riola/player/Engine$St;->stepRemainMs:J

    .line 32
    iput-wide v0, p0, Lcom/riola/player/Engine$St;->progRemainMs:J

    .line 34
    const/4 v0, -0x1

    iput v0, p0, Lcom/riola/player/Engine$St;->repTotal:I

    .line 36
    const/4 v1, 0x1

    iput v1, p0, Lcom/riola/player/Engine$St;->loopTotal:I

    .line 37
    iput v0, p0, Lcom/riola/player/Engine$St;->countIn:I

    return-void
.end method
