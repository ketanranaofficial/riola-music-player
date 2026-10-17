.class Lcom/riola/player/EditorActivity$19;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->menu()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/riola/player/EditorActivity;


# direct methods
.method constructor <init>(Lcom/riola/player/EditorActivity;)V
    .locals 0

    .line 447
    iput-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .line 449
    if-nez p2, :cond_0

    .line 450
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$800(Lcom/riola/player/EditorActivity;)V

    goto/16 :goto_0

    .line 451
    :cond_0
    const/4 p1, 0x1

    if-ne p2, p1, :cond_1

    .line 452
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v1}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v1

    iget-object v1, v1, Lcom/riola/player/Program;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " copy"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/riola/player/Program;->copyAs(Ljava/lang/String;)Lcom/riola/player/Program;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/riola/player/Store;->put(Landroid/content/Context;Lcom/riola/player/Program;)V

    .line 453
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    const-string p2, "Duplicated"

    invoke-static {p1, p2}, Lcom/riola/player/Ui;->toast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 454
    :cond_1
    const/4 p1, 0x2

    if-ne p2, p1, :cond_2

    .line 455
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object p2

    const/16 v0, 0x12d

    invoke-static {p1, p2, v0}, Lcom/riola/player/Backup;->exportOne(Landroid/app/Activity;Lcom/riola/player/Program;I)V

    goto :goto_0

    .line 457
    :cond_2
    iget-object p1, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Delete "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget-object v0, p0, Lcom/riola/player/EditorActivity$19;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v0

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

    .line 458
    const-string p2, "Cancel"

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Lcom/riola/player/EditorActivity$19$1;

    invoke-direct {p2, p0}, Lcom/riola/player/EditorActivity$19$1;-><init>(Lcom/riola/player/EditorActivity$19;)V

    .line 459
    const-string v0, "Delete"

    invoke-virtual {p1, v0, p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 466
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 468
    :goto_0
    return-void
.end method
