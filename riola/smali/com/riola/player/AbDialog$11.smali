.class Lcom/riola/player/AbDialog$11;
.super Ljava/lang/Object;
.source "AbDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/AbDialog;->show(Landroid/app/Activity;Lcom/riola/player/Track;JJLcom/riola/player/AbDialog$OnPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:[J

.field final synthetic val$b:[J

.field final synthetic val$cb:Lcom/riola/player/AbDialog$OnPick;


# direct methods
.method constructor <init>([J[JLcom/riola/player/AbDialog$OnPick;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 134
    iput-object p1, p0, Lcom/riola/player/AbDialog$11;->val$b:[J

    iput-object p2, p0, Lcom/riola/player/AbDialog$11;->val$a:[J

    iput-object p3, p0, Lcom/riola/player/AbDialog$11;->val$cb:Lcom/riola/player/AbDialog$OnPick;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .line 136
    iget-object p1, p0, Lcom/riola/player/AbDialog$11;->val$b:[J

    const/4 p2, 0x0

    aget-wide v0, p1, p2

    .line 137
    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-ltz p1, :cond_0

    iget-object p1, p0, Lcom/riola/player/AbDialog$11;->val$a:[J

    aget-wide v2, p1, p2

    cmp-long p1, v0, v2

    if-gtz p1, :cond_0

    const-wide/16 v0, 0x3a98

    add-long/2addr v0, v2

    .line 138
    :cond_0
    iget-object p1, p0, Lcom/riola/player/AbDialog$11;->val$cb:Lcom/riola/player/AbDialog$OnPick;

    iget-object v2, p0, Lcom/riola/player/AbDialog$11;->val$a:[J

    aget-wide v3, v2, p2

    invoke-interface {p1, v3, v4, v0, v1}, Lcom/riola/player/AbDialog$OnPick;->picked(JJ)V

    .line 139
    return-void
.end method
