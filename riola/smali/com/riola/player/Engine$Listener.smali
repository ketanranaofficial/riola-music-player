.class public interface abstract Lcom/riola/player/Engine$Listener;
.super Ljava/lang/Object;
.source "Engine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/riola/player/Engine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Listener"
.end annotation


# virtual methods
.method public abstract onFinished(Z)V
.end method

.method public abstract onLog(Ljava/lang/String;)V
.end method

.method public abstract onState(Lcom/riola/player/Engine$St;)V
.end method
