.class Lcom/riola/player/Runner$1;
.super Ljava/lang/Object;
.source "Runner.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Runner;->play(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/Runner$OnStarted;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$cb:Lcom/riola/player/Runner$OnStarted;

.field final synthetic val$from:I

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Lcom/riola/player/Program;Landroid/app/Activity;ILcom/riola/player/Runner$OnStarted;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 35
    iput-object p1, p0, Lcom/riola/player/Runner$1;->val$p:Lcom/riola/player/Program;

    iput-object p2, p0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    iput p3, p0, Lcom/riola/player/Runner$1;->val$from:I

    iput-object p4, p0, Lcom/riola/player/Runner$1;->val$cb:Lcom/riola/player/Runner$OnStarted;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .line 37
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 40
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 41
    nop

    .line 42
    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    :goto_0
    iget-object v5, p0, Lcom/riola/player/Runner$1;->val$p:Lcom/riola/player/Program;

    iget-object v5, v5, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-ge v3, v5, :cond_7

    .line 43
    iget-object v5, p0, Lcom/riola/player/Runner$1;->val$p:Lcom/riola/player/Program;

    iget-object v5, v5, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v5, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/riola/player/Step;

    .line 44
    iget-boolean v6, v5, Lcom/riola/player/Step;->enabled:Z

    if-nez v6, :cond_0

    goto/16 :goto_4

    .line 45
    :cond_0
    invoke-virtual {v5}, Lcom/riola/player/Step;->needsTrack()Z

    move-result v6

    if-nez v6, :cond_1

    add-int/lit8 v4, v4, 0x1

    goto :goto_4

    .line 46
    :cond_1
    iget-object v6, v5, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-virtual {v1, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Boolean;

    .line 47
    if-nez v6, :cond_3

    .line 48
    invoke-virtual {v5}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Lcom/riola/player/Runner$1;->val$a:Landroid/app/Activity;

    iget-object v7, v5, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-static {v6, v7}, Lcom/riola/player/Store;->readable(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    const/4 v6, 0x1

    goto :goto_1

    :cond_2
    move v6, v2

    :goto_1
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    .line 49
    iget-object v7, v5, Lcom/riola/player/Step;->trackUri:Ljava/lang/String;

    invoke-virtual {v1, v7, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    :cond_3
    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    if-nez v6, :cond_6

    .line 52
    iget-object v6, v5, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    if-eqz v6, :cond_5

    iget-object v6, v5, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-nez v6, :cond_4

    goto :goto_2

    .line 53
    :cond_4
    iget-object v5, v5, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    goto :goto_3

    :cond_5
    :goto_2
    const-string v5, "unknown track"

    .line 54
    :goto_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Step "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    add-int/lit8 v7, v3, 0x1

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  -  "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 55
    goto :goto_4

    .line 56
    :cond_6
    add-int/lit8 v4, v4, 0x1

    .line 42
    :goto_4
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    .line 59
    :cond_7
    nop

    .line 60
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/riola/player/Runner$1$1;

    invoke-direct {v2, p0, v0, v4}, Lcom/riola/player/Runner$1$1;-><init>(Lcom/riola/player/Runner$1;Ljava/util/List;I)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 67
    return-void
.end method
