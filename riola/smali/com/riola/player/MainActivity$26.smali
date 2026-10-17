.class Lcom/riola/player/MainActivity$26;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Ui$OnSlide;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->settings()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;)V
    .locals 0

    .line 528
    iput-object p1, p0, Lcom/riola/player/MainActivity$26;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 1

    .line 529
    iget-object v0, p0, Lcom/riola/player/MainActivity$26;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$1100(Lcom/riola/player/MainActivity;)Lcom/riola/player/Prefs;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/riola/player/Prefs;->volume(I)V

    iget-object v0, p0, Lcom/riola/player/MainActivity$26;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$200(Lcom/riola/player/MainActivity;)Lcom/riola/player/Engine;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/riola/player/Engine;->setMasterVolume(I)V

    return-void
.end method
