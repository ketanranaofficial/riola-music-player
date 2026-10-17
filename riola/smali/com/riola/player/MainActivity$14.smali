.class Lcom/riola/player/MainActivity$14;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Lcom/riola/player/Pickers$OnText;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->newProgram()V
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

    .line 302
    iput-object p1, p0, Lcom/riola/player/MainActivity$14;->this$0:Lcom/riola/player/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public picked(Ljava/lang/String;)V
    .locals 1

    .line 304
    invoke-static {p1}, Lcom/riola/player/Program;->blank(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object p1

    .line 305
    iget-object v0, p0, Lcom/riola/player/MainActivity$14;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0, p1}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 306
    iget-object v0, p0, Lcom/riola/player/MainActivity$14;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 307
    iget-object v0, p0, Lcom/riola/player/MainActivity$14;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {v0, p1}, Lcom/riola/player/MainActivity;->access$500(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    .line 308
    return-void
.end method
