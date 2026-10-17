.class Lcom/riola/player/LibraryActivity$15$1;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity$15;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/riola/player/Track;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Lcom/riola/player/LibraryActivity$15;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity$15;)V
    .locals 0

    .line 454
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$15$1;->this$1:Lcom/riola/player/LibraryActivity$15;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/riola/player/Track;Lcom/riola/player/Track;)I
    .locals 0

    .line 455
    iget-object p1, p1, Lcom/riola/player/Track;->title:Ljava/lang/String;

    iget-object p2, p2, Lcom/riola/player/Track;->title:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 454
    check-cast p1, Lcom/riola/player/Track;

    check-cast p2, Lcom/riola/player/Track;

    invoke-virtual {p0, p1, p2}, Lcom/riola/player/LibraryActivity$15$1;->compare(Lcom/riola/player/Track;Lcom/riola/player/Track;)I

    move-result p1

    return p1
.end method
