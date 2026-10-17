.class Lcom/riola/player/EditorActivity$8;
.super Ljava/lang/Object;
.source "EditorActivity.java"

# interfaces
.implements Lcom/riola/player/Ui$OnValue;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/riola/player/EditorActivity;->refresh()V
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

    .line 192
    iput-object p1, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 2

    .line 194
    iget-object v0, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v0

    iput p1, v0, Lcom/riola/player/Program;->loops:I

    .line 195
    iget-object p1, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1200(Lcom/riola/player/EditorActivity;)V

    .line 196
    iget-object p1, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1300(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v0

    invoke-virtual {v0}, Lcom/riola/player/Program;->summary()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 197
    iget-object p1, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {p1}, Lcom/riola/player/EditorActivity;->access$1400(Lcom/riola/player/EditorActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lcom/riola/player/EditorActivity$8;->this$0:Lcom/riola/player/EditorActivity;

    invoke-static {v0}, Lcom/riola/player/EditorActivity;->access$1100(Lcom/riola/player/EditorActivity;)Lcom/riola/player/Program;

    move-result-object v0

    invoke-virtual {v0}, Lcom/riola/player/Program;->estMs()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->rough(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 198
    return-void
.end method
