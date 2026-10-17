.class Lcom/riola/player/LibraryActivity$5;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->build()Landroid/view/View;
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

    .line 107
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$5;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    .line 111
    iget-object v0, p0, Lcom/riola/player/LibraryActivity$5;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/riola/player/LibraryActivity;->access$402(Lcom/riola/player/LibraryActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 112
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$5;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 113
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .line 108
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .line 109
    return-void
.end method
