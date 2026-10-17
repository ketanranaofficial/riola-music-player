.class Lcom/riola/player/Themes$4;
.super Ljava/lang/Object;
.source "Themes.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/Themes;->custom(Landroid/app/Activity;Lcom/riola/player/Prefs;Lcom/riola/player/Themes$OnChosen;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$channel:I

.field final synthetic val$paint:Ljava/lang/Runnable;

.field final synthetic val$rgb:[I


# direct methods
.method constructor <init>([IILjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 127
    iput-object p1, p0, Lcom/riola/player/Themes$4;->val$rgb:[I

    iput p2, p0, Lcom/riola/player/Themes$4;->val$channel:I

    iput-object p3, p0, Lcom/riola/player/Themes$4;->val$paint:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 0

    .line 129
    iget-object p1, p0, Lcom/riola/player/Themes$4;->val$rgb:[I

    iget p3, p0, Lcom/riola/player/Themes$4;->val$channel:I

    aput p2, p1, p3

    .line 130
    iget-object p1, p0, Lcom/riola/player/Themes$4;->val$paint:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 131
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 132
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 133
    return-void
.end method
