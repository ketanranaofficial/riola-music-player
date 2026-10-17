.class Lcom/riola/player/Themes$5;
.super Ljava/lang/Object;
.source "Themes.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Themes;->custom(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/riola/player/Themes$OnChosen;

.field final synthetic val$prefs:Lcom/riola/player/Prefs;

.field final synthetic val$rgb:[I


# direct methods
.method constructor <init>(Lcom/riola/player/Prefs;[ILcom/riola/player/Themes$OnChosen;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 142
    iput-object p1, p0, Lcom/riola/player/Themes$5;->val$prefs:Lcom/riola/player/Prefs;

    iput-object p2, p0, Lcom/riola/player/Themes$5;->val$rgb:[I

    iput-object p3, p0, Lcom/riola/player/Themes$5;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 144
    iget-object p1, p0, Lcom/riola/player/Themes$5;->val$prefs:Lcom/riola/player/Prefs;

    iget-object p2, p0, Lcom/riola/player/Themes$5;->val$rgb:[I

    const/4 v0, 0x0

    aget v0, p2, v0

    shl-int/lit8 v0, v0, 0x10

    const/high16 v1, -0x1000000

    or-int/2addr v0, v1

    const/4 v1, 0x1

    aget v1, p2, v1

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    const/4 v1, 0x2

    aget p2, p2, v1

    or-int/2addr p2, v0

    invoke-virtual {p1, p2}, Lcom/riola/player/Prefs;->accent(I)V

    .line 145
    iget-object p1, p0, Lcom/riola/player/Themes$5;->val$cb:Lcom/riola/player/Themes$OnChosen;

    invoke-interface {p1}, Lcom/riola/player/Themes$OnChosen;->chosen()V

    .line 146
    return-void
.end method
