.class public final Lcom/riola/player/StepSheet;
.super Ljava/lang/Object;
.source "StepSheet.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/riola/player/StepSheet$OnDone;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
    .locals 0

    .line 12
    invoke-static {p0, p1, p2, p3}, Lcom/riola/player/StepSheet;->fill(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    return-void
.end method

.method private static fill(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;Ljava/lang/Runnable;)V
    .locals 20

    .line 57
    move-object/from16 v8, p0

    move-object/from16 v9, p1

    move-object/from16 v10, p2

    move-object/from16 v6, p3

    invoke-virtual/range {p1 .. p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 59
    invoke-virtual/range {p2 .. p2}, Lcom/riola/player/Step;->needsTrack()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 60
    invoke-virtual/range {p2 .. p2}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v0

    .line 61
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/riola/player/Track;->shortTitle()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 62
    :cond_0
    iget-object v0, v10, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, v10, Lcom/riola/player/Step;->trackName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  (missing)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const-string v0, "pick a track"

    .line 63
    :goto_0
    new-instance v1, Lcom/riola/player/StepSheet$4;

    invoke-direct {v1, v8, v10, v6}, Lcom/riola/player/StepSheet$4;-><init>(Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    const-string v2, "Track"

    const/16 v3, 0xe

    invoke-static {v8, v2, v0, v3, v1}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 78
    :cond_2
    iget v0, v10, Lcom/riola/player/Step;->type:I

    const/16 v12, 0x14

    const/high16 v13, 0x3f800000    # 1.0f

    const/4 v14, 0x1

    const/4 v15, -0x2

    const/4 v5, 0x0

    if-ne v0, v14, :cond_5

    .line 79
    invoke-virtual/range {p2 .. p2}, Lcom/riola/player/Step;->track()Lcom/riola/player/Track;

    move-result-object v3

    .line 80
    if-nez v3, :cond_3

    const-wide/16 v16, 0x0

    goto :goto_1

    :cond_3
    iget-wide v1, v3, Lcom/riola/player/Track;->durMs:J

    move-wide/from16 v16, v1

    .line 82
    :goto_1
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v4

    .line 83
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 84
    invoke-static {v5, v15, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 85
    iget-wide v0, v10, Lcom/riola/player/Step;->a:J

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v1

    new-instance v0, Lcom/riola/player/StepSheet$5;

    move-object/from16 v18, v0

    move-object v11, v1

    move-object/from16 v1, p0

    move-object v7, v2

    move-object/from16 v2, p2

    move-object v14, v3

    move-object/from16 v19, v4

    move-wide/from16 v3, v16

    move-object/from16 v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/StepSheet$5;-><init>(Landroid/app/Activity;Lcom/riola/player/Step;JLjava/lang/Runnable;)V

    const-string v0, "Start (A)"

    move-object/from16 v1, v18

    invoke-static {v8, v0, v11, v12, v1}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 96
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v11

    .line 97
    const/4 v5, 0x0

    invoke-static {v5, v15, v13}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 98
    const/high16 v2, 0x41000000    # 8.0f

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/16 v18, 0x0

    move-object/from16 v0, p0

    move-object v1, v11

    move v13, v5

    move/from16 v5, v18

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 99
    iget-wide v0, v10, Lcom/riola/player/Step;->b:J

    const-wide/16 v3, 0x0

    cmp-long v0, v0, v3

    if-gez v0, :cond_4

    const-string v0, "end of track"

    goto :goto_2

    :cond_4
    iget-wide v0, v10, Lcom/riola/player/Step;->b:J

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->ms(J)Ljava/lang/String;

    move-result-object v0

    :goto_2
    move-object v5, v0

    new-instance v2, Lcom/riola/player/StepSheet$6;

    move-object v0, v2

    move-object/from16 v1, p0

    move-object v13, v2

    move-object/from16 v2, p2

    move-wide/from16 v3, v16

    move-object v15, v5

    move-object/from16 v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/riola/player/StepSheet$6;-><init>(Landroid/app/Activity;Lcom/riola/player/Step;JLjava/lang/Runnable;)V

    const-string v0, "End (B)"

    invoke-static {v8, v0, v15, v12, v13}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v11, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 110
    move-object/from16 v0, v19

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 111
    invoke-virtual {v0, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 112
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    new-instance v0, Lcom/riola/player/StepSheet$7;

    invoke-direct {v0, v14, v8, v10, v6}, Lcom/riola/player/StepSheet$7;-><init>(Lcom/riola/player/Track;Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    const-string v1, "Pick by ear"

    const/16 v2, 0xf

    const/4 v3, 0x1

    invoke-static {v8, v1, v2, v3, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 126
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-static {v0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 127
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 128
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 130
    iget-wide v0, v10, Lcom/riola/player/Step;->b:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_5

    .line 131
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "that slice is "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v4, v10, Lcom/riola/player/Step;->b:J

    iget-wide v13, v10, Lcom/riola/player/Step;->a:J

    sub-long/2addr v4, v13

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v1

    invoke-static {v1, v2}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " long"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/high16 v2, 0x41380000    # 11.5f

    const/4 v3, 0x0

    invoke-static {v8, v0, v2, v1, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v7

    .line 133
    const/high16 v2, 0x40000000    # 2.0f

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 134
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 138
    :cond_5
    iget v0, v10, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x2

    const-string v2, "Desk"

    const-string v3, "Bright"

    const-string v4, "Warm"

    const-string v5, "Low"

    const/high16 v7, 0x40c00000    # 6.0f

    if-ne v0, v1, :cond_6

    .line 139
    iget-wide v0, v10, Lcom/riola/player/Step;->durMs:J

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/riola/player/StepSheet$8;

    invoke-direct {v1, v8, v10, v6}, Lcom/riola/player/StepSheet$8;-><init>(Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    const-string v11, "How long"

    invoke-static {v8, v11, v0, v12, v1}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 147
    invoke-static {v8, v7}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 148
    iget-boolean v0, v10, Lcom/riola/player/Step;->endBell:Z

    new-instance v1, Lcom/riola/player/StepSheet$9;

    invoke-direct {v1, v10, v6}, Lcom/riola/player/StepSheet$9;-><init>(Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    const-string v7, "End with a bell"

    const-string v11, "chime when the rest is over"

    invoke-static {v8, v7, v11, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 156
    iget-boolean v0, v10, Lcom/riola/player/Step;->endBell:Z

    if-eqz v0, :cond_9

    .line 157
    filled-new-array {v5, v4, v3, v2}, [Ljava/lang/String;

    move-result-object v0

    iget v1, v10, Lcom/riola/player/Step;->tone:I

    invoke-static {v1}, Lcom/riola/player/Bell;->clamp(I)I

    move-result v1

    new-instance v2, Lcom/riola/player/StepSheet$10;

    invoke-direct {v2, v10, v6}, Lcom/riola/player/StepSheet$10;-><init>(Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    invoke-static {v8, v0, v1, v2}, Lcom/riola/player/Ui;->seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_4

    .line 167
    :cond_6
    iget v0, v10, Lcom/riola/player/Step;->type:I

    const/4 v1, 0x3

    const/high16 v11, 0x43160000    # 150.0f

    const/high16 v15, 0x41300000    # 11.0f

    const/high16 v12, 0x41580000    # 13.5f

    if-ne v0, v1, :cond_7

    .line 168
    const-string v0, "TONE"

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/4 v13, 0x1

    invoke-static {v8, v0, v15, v1, v13}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 169
    invoke-static {v8, v7}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 170
    filled-new-array {v5, v4, v3, v2}, [Ljava/lang/String;

    move-result-object v0

    iget v1, v10, Lcom/riola/player/Step;->tone:I

    invoke-static {v1}, Lcom/riola/player/Bell;->clamp(I)I

    move-result v1

    new-instance v2, Lcom/riola/player/StepSheet$11;

    invoke-direct {v2, v10, v6}, Lcom/riola/player/StepSheet$11;-><init>(Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    invoke-static {v8, v0, v1, v2}, Lcom/riola/player/Ui;->seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 178
    const-string v0, "A soft chime to mark a change without opening your eyes."

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/high16 v2, 0x41380000    # 11.5f

    const/4 v3, 0x0

    invoke-static {v8, v0, v2, v1, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    .line 180
    const/high16 v2, 0x40000000    # 2.0f

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 181
    invoke-virtual {v9, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 183
    new-instance v0, Lcom/riola/player/StepSheet$12;

    invoke-direct {v0, v10}, Lcom/riola/player/StepSheet$12;-><init>(Lcom/riola/player/Step;)V

    const-string v1, "Hear it"

    const/16 v2, 0x23

    const/4 v3, 0x1

    invoke-static {v8, v1, v2, v3, v0}, Lcom/riola/player/Ui;->btn(Landroid/content/Context;Ljava/lang/String;IILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v6

    .line 186
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-static {v0, v1}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 187
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 188
    invoke-virtual {v9, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 190
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 191
    const/high16 v3, 0x41200000    # 10.0f

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 192
    const-string v0, "Ring it"

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/4 v2, 0x0

    invoke-static {v8, v0, v12, v1, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 193
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v3, -0x2

    invoke-static {v2, v3, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 194
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 195
    iget v0, v10, Lcom/riola/player/Step;->times:I

    const/4 v1, 0x1

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/4 v2, 0x1

    const/16 v3, 0x9

    const/4 v4, 0x1

    const-string v5, "x"

    new-instance v6, Lcom/riola/player/StepSheet$13;

    invoke-direct {v6, v10}, Lcom/riola/player/StepSheet$13;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 198
    invoke-static {v8, v11}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, -0x2

    invoke-static {v1, v2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 199
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 200
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 202
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 203
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 204
    const-string v0, "Gap between rings"

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/4 v2, 0x0

    invoke-static {v8, v0, v12, v1, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 205
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v3, -0x2

    invoke-static {v2, v3, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 206
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 207
    iget-wide v0, v10, Lcom/riola/player/Step;->gapMs:J

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    long-to-int v1, v0

    const/4 v2, 0x0

    const/16 v3, 0x78

    const/4 v4, 0x1

    const-string v5, "s"

    new-instance v6, Lcom/riola/player/StepSheet$14;

    invoke-direct {v6, v10}, Lcom/riola/player/StepSheet$14;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 210
    invoke-static {v8, v11}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, -0x2

    invoke-static {v1, v2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 211
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 212
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 214
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->divider(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 215
    const-string v1, "Bell volume"

    const/16 v2, 0xa

    const/16 v3, 0x64

    iget v4, v10, Lcom/riola/player/Step;->volumePct:I

    const-string v5, "%"

    const/16 v6, 0x64

    new-instance v7, Lcom/riola/player/StepSheet$15;

    invoke-direct {v7, v10}, Lcom/riola/player/StepSheet$15;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 219
    goto/16 :goto_4

    .line 220
    :cond_7
    const/high16 v0, 0x41200000    # 10.0f

    invoke-static {v8, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 221
    const-string v0, "HOW OFTEN"

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/4 v2, 0x1

    invoke-static {v8, v0, v15, v1, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 222
    invoke-static {v8, v7}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 223
    const-string v0, "A number of times"

    const-string v1, "For a length of time"

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    .line 224
    invoke-virtual/range {p2 .. p2}, Lcom/riola/player/Step;->timed()Z

    move-result v1

    new-instance v2, Lcom/riola/player/StepSheet$16;

    invoke-direct {v2, v10, v6}, Lcom/riola/player/StepSheet$16;-><init>(Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    .line 223
    invoke-static {v8, v0, v1, v2}, Lcom/riola/player/Ui;->seg(Landroid/content/Context;[Ljava/lang/String;ILcom/riola/player/Ui$OnPick;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 231
    invoke-virtual/range {p2 .. p2}, Lcom/riola/player/Step;->timed()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 232
    iget-wide v0, v10, Lcom/riola/player/Step;->durMs:J

    invoke-static {v0, v1}, Lcom/riola/player/Fmt;->human(J)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/riola/player/StepSheet$17;

    invoke-direct {v1, v8, v10, v6}, Lcom/riola/player/StepSheet$17;-><init>(Landroid/app/Activity;Lcom/riola/player/Step;Ljava/lang/Runnable;)V

    const-string v2, "Keep looping for"

    const/16 v3, 0x14

    invoke-static {v8, v2, v0, v3, v1}, Lcom/riola/player/Ui;->field(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3

    .line 241
    :cond_8
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 242
    const/4 v2, 0x0

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 243
    const-string v0, "Play it"

    sget v1, Lcom/riola/player/Ui;->DIM:I

    const/4 v2, 0x0

    invoke-static {v8, v0, v12, v1, v2}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 244
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v3, -0x2

    invoke-static {v2, v3, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 245
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 246
    iget v0, v10, Lcom/riola/player/Step;->times:I

    const/4 v1, 0x1

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/4 v2, 0x1

    const/16 v3, 0x63

    const/4 v4, 0x1

    const-string v5, "x"

    new-instance v6, Lcom/riola/player/StepSheet$18;

    invoke-direct {v6, v10}, Lcom/riola/player/StepSheet$18;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 249
    const/high16 v1, 0x43200000    # 160.0f

    invoke-static {v8, v1}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, -0x2

    invoke-static {v1, v2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 250
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 251
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 254
    :goto_3
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->row(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v7

    .line 255
    const/4 v2, 0x0

    const/high16 v3, 0x41200000    # 10.0f

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object/from16 v0, p0

    move-object v1, v7

    invoke-static/range {v0 .. v5}, Lcom/riola/player/Ui;->margin(Landroid/content/Context;Landroid/view/View;FFFF)Landroid/view/View;

    .line 256
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 257
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, -0x2

    const/4 v3, 0x0

    invoke-static {v3, v2, v1}, Lcom/riola/player/Ui;->lpw(IIF)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 258
    const-string v1, "Gap between repeats"

    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v8, v1, v12, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 259
    const-string v1, "a short rest each time round"

    sget v2, Lcom/riola/player/Ui;->DIM:I

    invoke-static {v8, v1, v15, v2, v3}, Lcom/riola/player/Ui;->tv(Landroid/content/Context;Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 260
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 261
    iget-wide v0, v10, Lcom/riola/player/Step;->gapMs:J

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    long-to-int v1, v0

    const/4 v2, 0x0

    const/16 v3, 0x12c

    const/4 v4, 0x5

    const-string v5, "s"

    new-instance v6, Lcom/riola/player/StepSheet$19;

    invoke-direct {v6, v10}, Lcom/riola/player/StepSheet$19;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/riola/player/Ui;->stepper(Landroid/content/Context;IIIILjava/lang/String;Lcom/riola/player/Ui$OnValue;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 264
    invoke-static {v8, v11}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, -0x2

    invoke-static {v1, v2}, Lcom/riola/player/Ui;->lp(II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 265
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 266
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 268
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->divider(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 269
    const-string v1, "Speed for this step"

    const/16 v2, 0x32

    const/16 v3, 0xc8

    iget v4, v10, Lcom/riola/player/Step;->speedPct:I

    const-string v5, "%"

    const/16 v6, 0x64

    new-instance v7, Lcom/riola/player/StepSheet$20;

    invoke-direct {v7, v10}, Lcom/riola/player/StepSheet$20;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 273
    const-string v1, "Volume for this step"

    const/16 v2, 0xa

    const/16 v3, 0x64

    iget v4, v10, Lcom/riola/player/Step;->volumePct:I

    const-string v5, "%"

    new-instance v7, Lcom/riola/player/StepSheet$21;

    invoke-direct {v7, v10}, Lcom/riola/player/StepSheet$21;-><init>(Lcom/riola/player/Step;)V

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v7}, Lcom/riola/player/Ui;->sliderRow(Landroid/content/Context;Ljava/lang/String;IIILjava/lang/String;ILcom/riola/player/Ui$OnSlide;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 279
    :cond_9
    :goto_4
    invoke-static/range {p0 .. p0}, Lcom/riola/player/Ui;->divider(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 280
    iget-boolean v0, v10, Lcom/riola/player/Step;->enabled:Z

    new-instance v1, Lcom/riola/player/StepSheet$22;

    invoke-direct {v1, v10}, Lcom/riola/player/StepSheet$22;-><init>(Lcom/riola/player/Step;)V

    const-string v2, "Include this step"

    const-string v3, "turn it off to skip it for now"

    invoke-static {v8, v2, v3, v0, v1}, Lcom/riola/player/Ui;->switchRow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZLcom/riola/player/Ui$OnToggle;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 284
    const/high16 v0, 0x41a00000    # 20.0f

    invoke-static {v8, v0}, Lcom/riola/player/Ui;->gap(Landroid/content/Context;F)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 285
    return-void
.end method

.method public static show(Landroid/app/Activity;Lcom/riola/player/Program;ILcom/riola/player/StepSheet$OnDone;)V
    .locals 7

    .line 22
    if-ltz p2, :cond_4

    iget-object v0, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p2, v0, :cond_0

    goto/16 :goto_1

    .line 23
    :cond_0
    iget-object v0, p1, Lcom/riola/player/Program;->steps:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/riola/player/Step;

    invoke-virtual {v0}, Lcom/riola/player/Step;->copy()Lcom/riola/player/Step;

    move-result-object v0

    .line 25
    invoke-static {p0}, Lcom/riola/player/Ui;->col(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 26
    const/high16 v2, 0x41900000    # 18.0f

    invoke-static {p0, v2}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 27
    const/high16 v3, 0x40800000    # 4.0f

    invoke-static {p0, v3}, Lcom/riola/player/Ui;->dp(Landroid/content/Context;F)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v3, v2, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 29
    new-instance v2, Landroid/widget/ScrollView;

    invoke-direct {v2, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 30
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v3, v5, v6}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 32
    const/4 v3, 0x1

    new-array v5, v3, [Ljava/lang/Runnable;

    .line 33
    new-instance v6, Lcom/riola/player/StepSheet$1;

    invoke-direct {v6, p0, v1, v0, v5}, Lcom/riola/player/StepSheet$1;-><init>(Landroid/app/Activity;Landroid/widget/LinearLayout;Lcom/riola/player/Step;[Ljava/lang/Runnable;)V

    aput-object v6, v5, v4

    .line 36
    aget-object v1, v5, v4

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 38
    iget v1, v0, Lcom/riola/player/Step;->type:I

    const/4 v4, 0x2

    if-ne v1, v4, :cond_1

    const-string v1, "Silence"

    goto :goto_0

    .line 39
    :cond_1
    iget v1, v0, Lcom/riola/player/Step;->type:I

    const/4 v4, 0x3

    if-ne v1, v4, :cond_2

    const-string v1, "Bell"

    goto :goto_0

    .line 40
    :cond_2
    iget v1, v0, Lcom/riola/player/Step;->type:I

    if-ne v1, v3, :cond_3

    const-string v1, "Section"

    goto :goto_0

    :cond_3
    const-string v1, "Whole track"

    .line 42
    :goto_0
    invoke-static {p0}, Lcom/riola/player/Ui;->dialog(Landroid/app/Activity;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Step "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    add-int/lit8 v4, p2, 0x1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "  -  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 43
    invoke-virtual {p0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    new-instance v1, Lcom/riola/player/StepSheet$3;

    invoke-direct {v1, p3, p2}, Lcom/riola/player/StepSheet$3;-><init>(Lcom/riola/player/StepSheet$OnDone;I)V

    .line 44
    const-string v2, "Delete"

    invoke-virtual {p0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 47
    const-string v1, "Cancel"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    new-instance v1, Lcom/riola/player/StepSheet$2;

    invoke-direct {v1, p1, p2, v0, p3}, Lcom/riola/player/StepSheet$2;-><init>(Lcom/riola/player/Program;ILcom/riola/player/Step;Lcom/riola/player/StepSheet$OnDone;)V

    .line 48
    const-string p1, "Save"

    invoke-virtual {p0, p1, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 53
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 54
    return-void

    .line 22
    :cond_4
    :goto_1
    return-void
.end method
