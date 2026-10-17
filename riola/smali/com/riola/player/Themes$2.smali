.class Lcom/riola/player/Themes$2;
.super Ljava/lang/Object;
.source "Themes.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Themes;->colour(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$cb:Lcom/riola/player/Themes$OnChosen;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 61
    iput-object p1, p0, Lcom/riola/player/Themes$2;->val$a:Landroid/app/Activity;

    iput-object p2, p0, Lcom/riola/player/Themes$2;->val$prefs:Lcom/riola/player/Prefs;

    iput-object p3, p0, Lcom/riola/player/Themes$2;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .line 62
    iget-object p1, p0, Lcom/riola/player/Themes$2;->val$a:Landroid/app/Activity;

    iget-object p2, p0, Lcom/riola/player/Themes$2;->val$prefs:Lcom/riola/player/Prefs;

    iget-object v0, p0, Lcom/riola/player/Themes$2;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-static {p1, p2, v0}, Lcom/riola/player/Themes;->access$000(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V

    return-void
.end method
