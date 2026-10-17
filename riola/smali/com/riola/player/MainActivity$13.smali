.class Lcom/riola/player/MainActivity$13;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/MainActivity;->menu(Lcom/riola/player/Program;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/MainActivity;

.field final synthetic val$p:Lcom/riola/player/Program;


# direct methods
.method constructor <init>(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 261
    iput-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iput-object p2, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .line 263
    packed-switch p2, :pswitch_data_0

    .line 286
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Delete "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget-object v0, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, "?"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 287
    const-string p2, "The program is removed. Your audio files are untouched."

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 288
    const-string p2, "Cancel"

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Lcom/riola/player/MainActivity$13$2;

    invoke-direct {p2, p0}, Lcom/riola/player/MainActivity$13$2;-><init>(Lcom/riola/player/MainActivity$13;)V

    .line 289
    const-string v0, "Delete"

    invoke-virtual {p1, v0, p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 295
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    .line 283
    :pswitch_0
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object p2, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    const/16 v0, 0xc9

    invoke-static {p1, p2, v0}, Lcom/riola/player/Backup;->exportOne(Landroid/app/Activity;Lcom/riola/player/Program;I)V

    .line 284
    goto :goto_0

    .line 276
    :pswitch_1
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v0, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    iget-object v0, v0, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, " copy"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/riola/player/Program;->copyAs(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object p1

    .line 277
    iget-object p2, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p2, p1}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 278
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 279
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    const-string p2, "Duplicated"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    .line 280
    goto :goto_0

    .line 267
    :pswitch_2
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object p2, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    iget-object p2, p2, Lcom/riola/player/Program;->name:Ljava/lang/String;

    new-instance v0, Lcom/riola/player/MainActivity$13$1;

    invoke-direct {v0, p0}, Lcom/riola/player/MainActivity$13$1;-><init>(Lcom/riola/player/MainActivity$13;)V

    const-string v1, "Rename program"

    const-string v2, "name"

    invoke-static {p1, v1, p2, v2, v0}, Lcom/riola/player/Pickers;->text(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/riola/player/Pickers$OnText;)V

    .line 274
    goto :goto_0

    .line 265
    :pswitch_3
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object p2, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    invoke-static {p1, p2}, Lcom/riola/player/MainActivity;->access$500(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;)V

    goto :goto_0

    .line 264
    :pswitch_4
    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    iget-object p2, p0, Lcom/riola/player/MainActivity$13;->val$p:Lcom/riola/player/Program;

    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Lcom/riola/player/MainActivity;->access$800(Lcom/riola/player/MainActivity;Lcom/riola/player/Program;I)V

    iget-object p1, p0, Lcom/riola/player/MainActivity$13;->this$0:Lcom/riola/player/MainActivity;

    invoke-static {p1}, Lcom/riola/player/MainActivity;->access$400(Lcom/riola/player/MainActivity;)V

    .line 297
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
