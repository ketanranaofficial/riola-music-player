.class Lcom/riola/player/LibraryActivity$10;
.super Ljava/lang/Object;
.source "LibraryActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/LibraryActivity;->menu(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/LibraryActivity;

.field final synthetic val$index:I

.field final synthetic val$t:Lcom/riola/player/Track;


# direct methods
.method constructor <init>(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 213
    iput-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iput-object p2, p0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    iput p3, p0, Lcom/riola/player/LibraryActivity$10;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .line 215
    packed-switch p2, :pswitch_data_0

    .line 234
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iget p2, p0, Lcom/riola/player/LibraryActivity$10;->val$index:I

    iget-object v0, p0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    invoke-static {p1, p2, v0}, Lcom/riola/player/LibraryActivity;->access$1200(Lcom/riola/player/LibraryActivity;ILcom/riola/player/Track;)V

    goto :goto_0

    .line 233
    :pswitch_0
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iget p2, p0, Lcom/riola/player/LibraryActivity$10;->val$index:I

    const/4 v0, 0x1

    invoke-static {p1, p2, v0}, Lcom/riola/player/LibraryActivity;->access$1100(Lcom/riola/player/LibraryActivity;II)V

    goto :goto_0

    .line 232
    :pswitch_1
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iget p2, p0, Lcom/riola/player/LibraryActivity$10;->val$index:I

    const/4 v0, -0x1

    invoke-static {p1, p2, v0}, Lcom/riola/player/LibraryActivity;->access$1100(Lcom/riola/player/LibraryActivity;II)V

    goto :goto_0

    .line 231
    :pswitch_2
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object p2, p0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    invoke-static {p1, p2}, Lcom/riola/player/LibraryActivity;->access$1000(Lcom/riola/player/LibraryActivity;Lcom/riola/player/Track;)V

    goto :goto_0

    .line 222
    :pswitch_3
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    iget-object p2, p0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    invoke-virtual {p2}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object p2

    new-instance v0, Lcom/riola/player/LibraryActivity$10$1;

    invoke-direct {v0, p0}, Lcom/riola/player/LibraryActivity$10$1;-><init>(Lcom/riola/player/LibraryActivity$10;)V

    const-string v1, "Rename track"

    const-string v2, "name"

    invoke-static {p1, v1, p2, v2, v0}, Lcom/riola/player/Pickers;->text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V

    .line 230
    goto :goto_0

    .line 217
    :pswitch_4
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$700(Lcom/riola/player/LibraryActivity;)Lcom/riola/player/Engine;

    move-result-object p1

    iget-object p2, p0, Lcom/riola/player/LibraryActivity$10;->val$t:Lcom/riola/player/Track;

    invoke-virtual {p1, p2}, Lcom/riola/player/Engine;->previewTrack(Lcom/riola/player/Track;)V

    .line 218
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/PlayerBar;->startService(Landroid/app/Activity;)V

    .line 219
    iget-object p1, p0, Lcom/riola/player/LibraryActivity$10;->this$0:Lcom/riola/player/LibraryActivity;

    invoke-static {p1}, Lcom/riola/player/LibraryActivity;->access$500(Lcom/riola/player/LibraryActivity;)V

    .line 220
    nop

    .line 236
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
