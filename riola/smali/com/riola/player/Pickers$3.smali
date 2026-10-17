.class Lcom/riola/player/Pickers$3;
.super Ljava/lang/Object;
.source "Pickers.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Pickers;->duration(Landroid/app/Activity;Ljava/lang/String;JLcom/riola/player/Pickers$OnMs;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Pickers$OnMs;

.field final synthetic val$value:[J


# direct methods
.method constructor <init>(Lcom/riola/player/Pickers$OnMs;[J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 50
    iput-object p1, p0, Lcom/riola/player/Pickers$3;->val$cb:Lcom/riola/player/Pickers$OnMs;

    iput-object p2, p0, Lcom/riola/player/Pickers$3;->val$value:[J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 51
    iget-object p1, p0, Lcom/riola/player/Pickers$3;->val$cb:Lcom/riola/player/Pickers$OnMs;

    iget-object p2, p0, Lcom/riola/player/Pickers$3;->val$value:[J

    const/4 v0, 0x0

    aget-wide v0, p2, v0

    invoke-interface {p1, v0, v1}, Lcom/riola/player/Pickers$OnMs;->picked(J)V

    return-void
.end method
