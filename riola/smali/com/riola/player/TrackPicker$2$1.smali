.class Lcom/riola/player/TrackPicker$2$1;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/TrackPicker$2;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/TrackPicker$2;


# direct methods
.method constructor <init>(Lcom/riola/player/TrackPicker$2;)V
    .locals 0

    .line 80
    iput-object p1, p0, Lcom/riola/player/TrackPicker$2$1;->this$0:Lcom/riola/player/TrackPicker$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 82
    iget-object p1, p0, Lcom/riola/player/TrackPicker$2$1;->this$0:Lcom/riola/player/TrackPicker$2;

    iget-object p1, p1, Lcom/riola/player/TrackPicker$2;->val$prefs:Lcom/riola/player/Prefs;

    invoke-virtual {p1, p2}, Lcom/riola/player/Prefs;->librarySort(I)V

    .line 83
    iget-object p1, p0, Lcom/riola/player/TrackPicker$2$1;->this$0:Lcom/riola/player/TrackPicker$2;

    iget-object p1, p1, Lcom/riola/player/TrackPicker$2;->val$fill:[Ljava/lang/Runnable;

    const/4 p2, 0x0

    aget-object p1, p1, p2

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 84
    return-void
.end method
