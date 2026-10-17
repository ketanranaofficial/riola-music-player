.class Lcom/riola/player/MainActivity$15;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Runner$OnStarted;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->run(Lcom/riola/player/Program;I)V
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

    .line 322
    iput-object p1, p0, Lcom/riola/player/MainActivity$15;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public started()V
    .locals 2

    .line 324
    iget-object v0, p0, Lcom/riola/player/MainActivity$15;->this$0:Lcom/riola/player/MainActivity;

    const-string v1, ""

    invoke-static {v0, v1}, Lcom/riola/player/MainActivity;->access$902(Lcom/riola/player/MainActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 325
    iget-object v0, p0, Lcom/riola/player/MainActivity$15;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$1000(Lcom/riola/player/MainActivity;)V

    .line 326
    iget-object v0, p0, Lcom/riola/player/MainActivity$15;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 327
    return-void
.end method
