.class Lcom/riola/player/LibraryActivity$6;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->sortMenu()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;)V
    .locals 0

    .line 153
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$6;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 155
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$6;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$600(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Prefs;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/riola/player/Prefs;->librarySort(I)V

    .line 156
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$6;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 157
    return-void
.end method
