.class Lcom/riola/player/PlayerBar$8;
.super Ljava/lang/Object;
.source "PlayerBar.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/PlayerBar;->askShuffle(Landroid/app/Activity;Lcom/riola/player/Engine;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$eng:Lcom/riola/player/Engine;


# direct methods
.method constructor <init>(Lcom/riola/player/Engine;Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 199
    iput-object p1, p0, Lcom/riola/player/PlayerBar$8;->val$eng:Lcom/riola/player/Engine;

    iput-object p2, p0, Lcom/riola/player/PlayerBar$8;->val$a:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 201
    iget-object p1, p0, Lcom/riola/player/PlayerBar$8;->val$eng:Lcom/riola/player/Engine;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->setShuffle(Z)V

    .line 202
    iget-object p1, p0, Lcom/riola/player/PlayerBar$8;->val$a:Landroid/app/Activity;

    const-string p2, "Playing in a random order"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 203
    return-void
.end method
