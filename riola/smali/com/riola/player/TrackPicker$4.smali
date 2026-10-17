.class Lcom/riola/player/TrackPicker$4;
.super Ljava/lang/Object;
.source "TrackPicker.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/TrackPicker;->show(Landroid/app/Activity;Ljava/lang/String;ZLcom/riola/player/TrackPicker$OnPicked;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$fill:[Ljava/lang/Runnable;

.field final synthetic val$filter:[Ljava/lang/String;


# direct methods
.method constructor <init>([Ljava/lang/String;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 126
    iput-object p1, p0, Lcom/riola/player/TrackPicker$4;->val$filter:[Ljava/lang/String;

    iput-object p2, p0, Lcom/riola/player/TrackPicker$4;->val$fill:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    .line 130
    iget-object v0, p0, Lcom/riola/player/TrackPicker$4;->val$filter:[Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    aput-object p1, v0, v1

    .line 131
    iget-object p1, p0, Lcom/riola/player/TrackPicker$4;->val$fill:[Ljava/lang/Runnable;

    aget-object p1, p1, v1

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 132
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .line 127
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .line 128
    return-void
.end method
