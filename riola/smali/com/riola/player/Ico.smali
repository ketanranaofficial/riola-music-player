.class public Lcom/riola/player/Ico;
.super Landroid/graphics/drawable/Drawable;
.source "Ico.java"


# static fields
.field public static final AB:I = 0xf

.field public static final BACK:I = 0x1a

.field public static final BELL:I = 0x23

.field public static final CHECK:I = 0x10

.field public static final CLOCK:I = 0x14

.field public static final CLOSE:I = 0x11

.field public static final COPY:I = 0x1d

.field public static final DOWN:I = 0x13

.field public static final DRAG:I = 0x1f

.field public static final EDIT:I = 0x17

.field public static final FOLDER:I = 0x7

.field public static final GEAR:I = 0xc

.field public static final HELP:I = 0xb

.field public static final LIST:I = 0x15

.field public static final LOOP:I = 0xd

.field public static final MINUS:I = 0x1e

.field public static final MOON:I = 0x21

.field public static final MORE:I = 0x19

.field public static final NEXT:I = 0x4

.field public static final NOTE:I = 0xe

.field public static final OPEN:I = 0xa

.field public static final PAUSE:I = 0x2

.field public static final PLAY:I = 0x1

.field public static final PLUS:I = 0x6

.field public static final PREV:I = 0x5

.field public static final PROGRAM:I = 0x20

.field public static final RESET:I = 0x22

.field public static final RIGHT:I = 0x1b

.field public static final SAVE:I = 0x9

.field public static final SCISSOR:I = 0x18

.field public static final SEARCH:I = 0x1c

.field public static final SHUFFLE:I = 0x24

.field public static final STOP:I = 0x3

.field public static final TRASH:I = 0x8

.field public static final UP:I = 0x12

.field public static final WAVE:I = 0x16


# instance fields
.field private color:I

.field private final id:I

.field private final p:Landroid/graphics/Paint;

.field private final path:Landroid/graphics/Path;

.field private final r:Landroid/graphics/RectF;


# direct methods
.method public constructor <init>(II)V
    .locals 2

    .line 31
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 27
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    .line 28
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    .line 29
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    .line 32
    iput p1, p0, Lcom/riola/player/Ico;->id:I

    .line 33
    iput p2, p0, Lcom/riola/player/Ico;->color:I

    .line 34
    return-void
.end method

.method private box(Landroid/graphics/Canvas;FFFFFFFF)V
    .locals 1

    .line 279
    iget-object v0, p0, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    mul-float/2addr p5, p4

    add-float/2addr p5, p2

    mul-float/2addr p6, p4

    add-float/2addr p6, p3

    mul-float/2addr p7, p4

    add-float/2addr p2, p7

    mul-float/2addr p8, p4

    add-float/2addr p3, p8

    invoke-virtual {v0, p5, p6, p2, p3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 280
    iget-object p2, p0, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    mul-float/2addr p9, p4

    iget-object p3, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p9, p9, p3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 281
    return-void
.end method

.method private line(Landroid/graphics/Canvas;FFFFFFF)V
    .locals 6

    .line 284
    mul-float/2addr p5, p4

    add-float v1, p2, p5

    mul-float/2addr p6, p4

    add-float v2, p3, p6

    mul-float/2addr p7, p4

    add-float v3, p2, p7

    mul-float/2addr p8, p4

    add-float v4, p3, p8

    iget-object v5, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 285
    return-void
.end method

.method private varargs poly(Landroid/graphics/Canvas;FFFZ[F)V
    .locals 4

    .line 269
    iget-object v0, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 270
    const/4 v0, 0x0

    :goto_0
    add-int/lit8 v1, v0, 0x1

    array-length v2, p6

    if-ge v1, v2, :cond_1

    .line 271
    if-nez v0, :cond_0

    iget-object v2, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    aget v3, p6, v0

    mul-float/2addr v3, p4

    add-float/2addr v3, p2

    aget v1, p6, v1

    mul-float/2addr v1, p4

    add-float/2addr v1, p3

    invoke-virtual {v2, v3, v1}, Landroid/graphics/Path;->moveTo(FF)V

    goto :goto_1

    .line 272
    :cond_0
    iget-object v2, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    aget v3, p6, v0

    mul-float/2addr v3, p4

    add-float/2addr v3, p2

    aget v1, p6, v1

    mul-float/2addr v1, p4

    add-float/2addr v1, p3

    invoke-virtual {v2, v3, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 270
    :goto_1
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 274
    :cond_1
    if-eqz p5, :cond_2

    iget-object p2, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    invoke-virtual {p2}, Landroid/graphics/Path;->close()V

    .line 275
    :cond_2
    iget-object p2, p0, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    iget-object p3, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 276
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 29

    .line 38
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    invoke-virtual/range {p0 .. p0}, Lcom/riola/player/Ico;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    .line 39
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    int-to-float v1, v1

    .line 40
    const/4 v2, 0x0

    cmpg-float v2, v1, v2

    if-gtz v2, :cond_0

    return-void

    .line 41
    :cond_0
    const/high16 v2, 0x41c00000    # 24.0f

    div-float v12, v1, v2

    .line 42
    invoke-virtual {v0}, Landroid/graphics/Rect;->exactCenterX()F

    move-result v1

    const/high16 v13, 0x41400000    # 12.0f

    mul-float v2, v12, v13

    sub-float v14, v1, v2

    .line 43
    invoke-virtual {v0}, Landroid/graphics/Rect;->exactCenterY()F

    move-result v0

    sub-float v15, v0, v2

    .line 45
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    iget v1, v10, Lcom/riola/player/Ico;->color:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 46
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget v1, Lcom/riola/player/Ui;->ICON_W:F

    mul-float/2addr v1, v12

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 47
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-boolean v1, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    if-eqz v1, :cond_1

    sget-object v1, Landroid/graphics/Paint$Cap;->BUTT:Landroid/graphics/Paint$Cap;

    goto :goto_0

    :cond_1
    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 48
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-boolean v1, Lcom/riola/player/Ui;->SQUARE_ICONS:Z

    if-eqz v1, :cond_2

    sget-object v1, Landroid/graphics/Paint$Join;->MITER:Landroid/graphics/Paint$Join;

    goto :goto_1

    :cond_2
    sget-object v1, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    :goto_1
    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 49
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 50
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 52
    iget v0, v10, Lcom/riola/player/Ico;->id:I

    const/high16 v9, 0x3fc00000    # 1.5f

    const/high16 v16, 0x40900000    # 4.5f

    const v1, 0x40c66666    # 6.2f

    const/high16 v17, 0x41940000    # 18.5f

    const/high16 v18, 0x41980000    # 19.0f

    const/high16 v3, 0x418c0000    # 17.5f

    const/high16 v4, 0x41a40000    # 20.5f

    const/high16 v5, 0x41500000    # 13.0f

    const v19, 0x40266666    # 2.6f

    const/4 v8, 0x3

    const/high16 v20, 0x40d00000    # 6.5f

    const/16 v7, 0x8

    const/high16 v21, 0x40b00000    # 5.5f

    const/4 v6, 0x0

    const/4 v13, 0x6

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_8

    .line 225
    :pswitch_0
    const/4 v5, 0x0

    new-array v6, v7, [F

    fill-array-data v6, :array_0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 226
    new-array v6, v7, [F

    fill-array-data v6, :array_1

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 227
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 228
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_2

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 229
    new-array v6, v13, [F

    fill-array-data v6, :array_3

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 230
    goto/16 :goto_8

    .line 238
    :pswitch_1
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 239
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    mul-float/2addr v1, v12

    add-float v4, v14, v1

    const v1, 0x41866666    # 16.8f

    mul-float/2addr v1, v12

    add-float/2addr v1, v15

    invoke-virtual {v0, v4, v1}, Landroid/graphics/Path;->moveTo(FF)V

    .line 240
    iget-object v3, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    const v0, 0x41266666    # 10.4f

    mul-float/2addr v0, v12

    add-float v20, v15, v0

    const v0, 0x41033333    # 8.2f

    mul-float/2addr v0, v12

    add-float v6, v14, v0

    const v0, 0x40f33333    # 7.6f

    mul-float/2addr v0, v12

    add-float v18, v15, v0

    add-float v13, v14, v2

    move/from16 v5, v20

    move/from16 v7, v18

    move v8, v13

    move/from16 v9, v18

    invoke-virtual/range {v3 .. v9}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 242
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    const v2, 0x417ccccd    # 15.8f

    mul-float/2addr v2, v12

    add-float v17, v14, v2

    const v2, 0x418e6666    # 17.8f

    mul-float/2addr v2, v12

    add-float v21, v14, v2

    move-object/from16 v16, v0

    move/from16 v19, v21

    move/from16 v22, v1

    invoke-virtual/range {v16 .. v22}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 244
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    iget-object v1, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 245
    const v5, 0x40933333    # 4.6f

    const v6, 0x41866666    # 16.8f

    const v7, 0x419b3333    # 19.4f

    const v8, 0x41866666    # 16.8f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 246
    const/high16 v5, 0x41400000    # 12.0f

    const v6, 0x4099999a    # 4.8f

    const/high16 v7, 0x41400000    # 12.0f

    const v8, 0x40f33333    # 7.6f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 247
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 248
    const v0, 0x419e6666    # 19.8f

    mul-float/2addr v0, v12

    add-float/2addr v15, v0

    const v0, 0x3fe66666    # 1.8f

    mul-float/2addr v12, v0

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v13, v15, v12, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 249
    goto/16 :goto_8

    .line 232
    :pswitch_2
    iget-object v0, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    mul-float v16, v16, v12

    add-float v1, v14, v16

    add-float v2, v15, v16

    const/high16 v3, 0x419c0000    # 19.5f

    mul-float/2addr v3, v12

    add-float v4, v14, v3

    add-float/2addr v3, v15

    invoke-virtual {v0, v1, v2, v4, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 233
    iget-object v1, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    const/high16 v2, -0x3d900000    # -60.0f

    const/high16 v3, 0x43960000    # 300.0f

    const/4 v4, 0x0

    iget-object v5, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 234
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 235
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_4

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 236
    goto/16 :goto_8

    .line 251
    :pswitch_3
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 252
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    mul-float v18, v18, v12

    add-float v1, v14, v18

    const/high16 v2, 0x41780000    # 15.5f

    mul-float/2addr v2, v12

    add-float/2addr v2, v15

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Path;->moveTo(FF)V

    .line 253
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    mul-float/2addr v5, v12

    add-float v6, v14, v5

    mul-float/2addr v3, v12

    add-float v24, v15, v3

    const/high16 v3, 0x40e00000    # 7.0f

    mul-float/2addr v3, v12

    add-float v25, v14, v3

    add-float v26, v15, v5

    const/high16 v3, 0x41180000    # 9.5f

    mul-float/2addr v3, v12

    add-float v27, v14, v3

    mul-float v21, v21, v12

    add-float v28, v15, v21

    move-object/from16 v22, v0

    move/from16 v23, v6

    invoke-virtual/range {v22 .. v28}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 255
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    const/high16 v3, 0x40400000    # 3.0f

    mul-float/2addr v3, v12

    add-float v23, v14, v3

    const/high16 v3, 0x41000000    # 8.0f

    mul-float/2addr v3, v12

    add-float v24, v15, v3

    const/high16 v3, 0x40800000    # 4.0f

    mul-float/2addr v3, v12

    add-float v25, v14, v3

    const/high16 v3, 0x41a00000    # 20.0f

    mul-float/2addr v3, v12

    add-float v26, v15, v3

    mul-float/2addr v4, v12

    add-float v3, v15, v4

    move-object/from16 v22, v0

    move/from16 v27, v6

    move/from16 v28, v3

    invoke-virtual/range {v22 .. v28}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 257
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    const/high16 v4, 0x41840000    # 16.5f

    mul-float/2addr v4, v12

    add-float v23, v14, v4

    mul-float v17, v17, v12

    add-float v25, v14, v17

    const/high16 v4, 0x41900000    # 18.0f

    mul-float/2addr v12, v4

    add-float v26, v15, v12

    move-object/from16 v22, v0

    move/from16 v24, v3

    move/from16 v27, v1

    move/from16 v28, v2

    invoke-virtual/range {v22 .. v28}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 259
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    .line 260
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 261
    iget-object v0, v10, Lcom/riola/player/Ico;->path:Landroid/graphics/Path;

    iget-object v1, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 262
    goto/16 :goto_8

    .line 180
    :pswitch_4
    move v9, v6

    :goto_2
    if-ge v9, v8, :cond_3

    .line 181
    int-to-float v0, v9

    mul-float v0, v0, v21

    add-float v16, v0, v20

    .line 182
    const/high16 v5, 0x40800000    # 4.0f

    const/high16 v7, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    move/from16 v6, v16

    move/from16 v8, v16

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 180
    add-int/lit8 v9, v9, 0x1

    const/4 v8, 0x3

    goto :goto_2

    .line 184
    :cond_3
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 185
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_5

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 186
    goto/16 :goto_8

    .line 210
    :pswitch_5
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 211
    nop

    :goto_3
    const/4 v13, 0x3

    if-ge v6, v13, :cond_4

    .line 212
    const/high16 v0, 0x41100000    # 9.0f

    mul-float/2addr v0, v12

    add-float/2addr v0, v14

    int-to-float v1, v6

    const/high16 v2, 0x40c00000    # 6.0f

    mul-float/2addr v1, v2

    add-float/2addr v1, v2

    mul-float/2addr v1, v12

    add-float/2addr v1, v15

    mul-float v2, v12, v9

    iget-object v3, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 213
    const/high16 v0, 0x41700000    # 15.0f

    mul-float/2addr v0, v12

    add-float/2addr v0, v14

    iget-object v3, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 211
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 215
    :cond_4
    goto/16 :goto_8

    .line 81
    :pswitch_6
    const/high16 v5, 0x40a00000    # 5.0f

    const/high16 v6, 0x41400000    # 12.0f

    const/high16 v7, 0x41980000    # 19.0f

    const/high16 v8, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 82
    goto/16 :goto_8

    .line 221
    :pswitch_7
    const/high16 v5, 0x41000000    # 8.0f

    const/high16 v6, 0x41000000    # 8.0f

    const/high16 v7, 0x41a00000    # 20.0f

    const/high16 v8, 0x41a00000    # 20.0f

    const v9, 0x4019999a    # 2.4f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 222
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_6

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 223
    goto/16 :goto_8

    .line 217
    :pswitch_8
    const/high16 v0, 0x41280000    # 10.5f

    mul-float/2addr v0, v12

    add-float v2, v14, v0

    add-float/2addr v0, v15

    mul-float/2addr v1, v12

    iget-object v3, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v2, v0, v1, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 218
    const v5, 0x41733333    # 15.2f

    const v6, 0x41733333    # 15.2f

    const/high16 v7, 0x41a00000    # 20.0f

    const/high16 v8, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 219
    goto/16 :goto_8

    .line 163
    :pswitch_9
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_7

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 164
    goto/16 :goto_8

    .line 160
    :pswitch_a
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_8

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 161
    goto/16 :goto_8

    .line 206
    :pswitch_b
    move v13, v8

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 207
    nop

    :goto_4
    if-ge v6, v13, :cond_5

    add-float v0, v14, v2

    int-to-float v1, v6

    mul-float v1, v1, v20

    add-float v1, v1, v21

    mul-float/2addr v1, v12

    add-float/2addr v1, v15

    const v3, 0x3fd9999a    # 1.7f

    mul-float/2addr v3, v12

    iget-object v4, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 208
    :cond_5
    goto/16 :goto_8

    .line 200
    :pswitch_c
    const/high16 v5, 0x40c00000    # 6.0f

    const/high16 v6, 0x40800000    # 4.0f

    const/high16 v7, 0x41900000    # 18.0f

    const/high16 v8, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 201
    const/high16 v5, 0x41900000    # 18.0f

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 202
    mul-float v21, v21, v12

    add-float v0, v14, v21

    mul-float v18, v18, v12

    add-float v15, v15, v18

    mul-float v1, v12, v19

    iget-object v2, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v15, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 203
    mul-float v12, v12, v17

    add-float/2addr v14, v12

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v14, v15, v1, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 204
    goto/16 :goto_8

    .line 197
    :pswitch_d
    const/4 v5, 0x1

    const/16 v0, 0xa

    new-array v6, v0, [F

    fill-array-data v6, :array_9

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 198
    goto/16 :goto_8

    .line 188
    :pswitch_e
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 189
    const/4 v13, 0x5

    new-array v9, v13, [F

    fill-array-data v9, :array_a

    .line 190
    move v8, v6

    :goto_5
    if-ge v8, v13, :cond_6

    .line 191
    int-to-float v0, v8

    const v1, 0x408ccccd    # 4.4f

    mul-float/2addr v0, v1

    add-float v5, v0, v19

    .line 192
    aget v0, v9, v8

    const/high16 v1, 0x40000000    # 2.0f

    div-float v2, v0, v1

    const/high16 v16, 0x41400000    # 12.0f

    sub-float v6, v16, v2

    const v2, 0x40333333    # 2.8f

    add-float v7, v5, v2

    div-float/2addr v0, v1

    add-float v17, v0, v16

    const v18, 0x3fa66666    # 1.3f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    move/from16 v20, v8

    move/from16 v8, v17

    move-object/from16 v17, v9

    move/from16 v9, v18

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 190
    add-int/lit8 v8, v20, 0x1

    move-object/from16 v9, v17

    goto :goto_5

    .line 194
    :cond_6
    goto/16 :goto_8

    .line 171
    :pswitch_f
    move v13, v8

    move v8, v6

    :goto_6
    if-ge v8, v13, :cond_7

    .line 172
    int-to-float v0, v8

    mul-float v0, v0, v21

    add-float v17, v0, v20

    .line 173
    const/high16 v5, 0x41080000    # 8.5f

    const/high16 v7, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    move/from16 v6, v17

    move/from16 v18, v8

    move/from16 v8, v17

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 174
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 175
    mul-float v0, v12, v16

    add-float/2addr v0, v14

    mul-float v17, v17, v12

    add-float v1, v15, v17

    mul-float v2, v12, v9

    iget-object v3, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 176
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 171
    add-int/lit8 v8, v18, 0x1

    goto :goto_6

    .line 178
    :cond_7
    goto/16 :goto_8

    .line 166
    :pswitch_10
    add-float v0, v14, v2

    add-float/2addr v2, v15

    const v1, 0x410ccccd    # 8.8f

    mul-float v6, v12, v1

    iget-object v1, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v2, v6, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 167
    const/high16 v5, 0x41400000    # 12.0f

    const/high16 v6, 0x41400000    # 12.0f

    const/high16 v7, 0x41400000    # 12.0f

    const v8, 0x40d33333    # 6.6f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 168
    const/high16 v7, 0x41800000    # 16.0f

    const/high16 v8, 0x41600000    # 14.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 169
    goto/16 :goto_8

    .line 157
    :pswitch_11
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_b

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 158
    goto/16 :goto_8

    .line 154
    :pswitch_12
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_c

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 155
    goto/16 :goto_8

    .line 150
    :pswitch_13
    const/high16 v5, 0x40c00000    # 6.0f

    const/high16 v6, 0x40c00000    # 6.0f

    const/high16 v7, 0x41900000    # 18.0f

    const/high16 v8, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 151
    const/high16 v5, 0x41900000    # 18.0f

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 152
    goto/16 :goto_8

    .line 147
    :pswitch_14
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_d

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 148
    goto/16 :goto_8

    .line 142
    :pswitch_15
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 143
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    const/high16 v1, 0x41380000    # 11.5f

    mul-float/2addr v1, v12

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 144
    add-float/2addr v14, v2

    const v0, 0x4181999a    # 16.2f

    mul-float/2addr v12, v0

    add-float/2addr v15, v12

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    const-string v1, "AB"

    invoke-virtual {v11, v1, v14, v15, v0}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 145
    goto/16 :goto_8

    .line 135
    :pswitch_16
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 136
    const v5, 0x4139999a    # 11.6f

    const/high16 v6, 0x40600000    # 3.5f

    const v8, 0x41633333    # 14.2f

    const/high16 v9, 0x41880000    # 17.0f

    const/high16 v13, 0x3f800000    # 1.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    move v7, v8

    move v8, v9

    move v9, v13

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 137
    const/4 v5, 0x1

    const/16 v13, 0x8

    new-array v6, v13, [F

    fill-array-data v6, :array_e

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 138
    iget-object v0, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    const v1, 0x40accccd    # 5.4f

    mul-float/2addr v1, v12

    add-float/2addr v1, v14

    const v2, 0x4159999a    # 13.6f

    mul-float/2addr v2, v12

    add-float/2addr v2, v15

    const v3, 0x41566666    # 13.4f

    mul-float/2addr v3, v12

    add-float/2addr v14, v3

    const v3, 0x41a33333    # 20.4f

    mul-float/2addr v12, v3

    add-float/2addr v15, v12

    invoke-virtual {v0, v1, v2, v14, v15}, Landroid/graphics/RectF;->set(FFFF)V

    .line 139
    iget-object v0, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    iget-object v1, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1}, Landroid/graphics/Canvas;->drawOval(Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 140
    goto/16 :goto_8

    .line 129
    :pswitch_17
    iget-object v0, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    const/high16 v1, 0x40600000    # 3.5f

    mul-float/2addr v1, v12

    add-float/2addr v1, v14

    mul-float v20, v20, v12

    add-float v2, v15, v20

    mul-float/2addr v4, v12

    add-float/2addr v4, v14

    mul-float/2addr v3, v12

    add-float/2addr v3, v15

    invoke-virtual {v0, v1, v2, v4, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 130
    iget-object v0, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    mul-float v1, v12, v21

    iget-object v2, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v0, v1, v1, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 131
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 132
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 133
    goto/16 :goto_8

    .line 108
    :pswitch_18
    move v13, v7

    add-float/2addr v14, v2

    add-float/2addr v15, v2

    .line 109
    move v0, v6

    :goto_7
    const v1, 0x3ff33333    # 1.9f

    const v2, 0x40cccccd    # 6.4f

    if-ge v0, v13, :cond_8

    .line 110
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->save()I

    .line 111
    int-to-float v3, v0

    const/high16 v4, 0x42340000    # 45.0f

    mul-float/2addr v3, v4

    invoke-virtual {v11, v3, v14, v15}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 112
    iget-object v3, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    mul-float/2addr v1, v12

    sub-float v4, v14, v1

    const/high16 v5, 0x41300000    # 11.0f

    mul-float/2addr v5, v12

    sub-float v5, v15, v5

    add-float/2addr v1, v14

    mul-float/2addr v2, v12

    sub-float v2, v15, v2

    invoke-virtual {v3, v4, v5, v1, v2}, Landroid/graphics/RectF;->set(FFFF)V

    .line 113
    iget-object v1, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 114
    iget-object v1, v10, Lcom/riola/player/Ico;->r:Landroid/graphics/RectF;

    const v2, 0x3f4ccccd    # 0.8f

    mul-float/2addr v2, v12

    iget-object v3, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v1, v2, v2, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 115
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Canvas;->restore()V

    .line 109
    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 117
    :cond_8
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 118
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    mul-float v3, v12, v19

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 119
    mul-float/2addr v2, v12

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v14, v15, v2, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 120
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    mul-float/2addr v1, v12

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 121
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v0, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 122
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 123
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    iget v1, v10, Lcom/riola/player/Ico;->color:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 124
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 125
    const v0, 0x40466666    # 3.1f

    mul-float/2addr v12, v0

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v14, v15, v12, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 126
    goto/16 :goto_8

    .line 102
    :pswitch_19
    add-float/2addr v14, v2

    add-float/2addr v2, v15

    const v0, 0x410ccccd    # 8.8f

    mul-float v6, v12, v0

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v11, v14, v2, v6, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 103
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 104
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    mul-float/2addr v5, v12

    invoke-virtual {v0, v5}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 105
    const v0, 0x4184cccd    # 16.6f

    mul-float/2addr v12, v0

    add-float/2addr v15, v12

    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    const-string v1, "?"

    invoke-virtual {v11, v1, v14, v15, v0}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 106
    goto/16 :goto_8

    .line 97
    :pswitch_1a
    const/high16 v5, 0x41400000    # 12.0f

    const/high16 v6, 0x41780000    # 15.5f

    const/high16 v7, 0x41400000    # 12.0f

    const/high16 v8, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 98
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_10

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 99
    const/high16 v5, 0x40900000    # 4.5f

    const/high16 v6, 0x41a00000    # 20.0f

    const/high16 v7, 0x419c0000    # 19.5f

    const/high16 v8, 0x41a00000    # 20.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 100
    goto/16 :goto_8

    .line 92
    :pswitch_1b
    const/high16 v5, 0x41400000    # 12.0f

    const/high16 v6, 0x40600000    # 3.5f

    const/high16 v7, 0x41400000    # 12.0f

    const/high16 v8, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 93
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_11

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 94
    const/high16 v5, 0x40900000    # 4.5f

    const/high16 v6, 0x41a00000    # 20.0f

    const/high16 v7, 0x419c0000    # 19.5f

    const/high16 v8, 0x41a00000    # 20.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 95
    goto/16 :goto_8

    .line 87
    :pswitch_1c
    move v13, v7

    const/high16 v5, 0x40c00000    # 6.0f

    const/high16 v6, 0x40f00000    # 7.5f

    const/high16 v7, 0x41900000    # 18.0f

    const/high16 v8, 0x41a40000    # 20.5f

    const/high16 v9, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 88
    const/high16 v5, 0x40600000    # 3.5f

    const/high16 v7, 0x41a40000    # 20.5f

    const/high16 v8, 0x40f00000    # 7.5f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 89
    const/4 v5, 0x0

    new-array v6, v13, [F

    fill-array-data v6, :array_12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 90
    goto/16 :goto_8

    .line 84
    :pswitch_1d
    const/4 v5, 0x1

    const/16 v0, 0xc

    new-array v6, v0, [F

    fill-array-data v6, :array_13

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 85
    goto/16 :goto_8

    .line 77
    :pswitch_1e
    const/high16 v5, 0x41400000    # 12.0f

    const/high16 v6, 0x40a00000    # 5.0f

    const/high16 v7, 0x41400000    # 12.0f

    const/high16 v8, 0x41980000    # 19.0f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 78
    const/high16 v5, 0x40a00000    # 5.0f

    const/high16 v6, 0x41400000    # 12.0f

    const/high16 v7, 0x41980000    # 19.0f

    const/high16 v8, 0x41400000    # 12.0f

    invoke-direct/range {v0 .. v8}, Lcom/riola/player/Ico;->line(Landroid/graphics/Canvas;FFFFFFF)V

    .line 79
    goto/16 :goto_8

    .line 72
    :pswitch_1f
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 73
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_14

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 74
    const/high16 v5, 0x40900000    # 4.5f

    const/high16 v6, 0x40800000    # 4.0f

    const/high16 v7, 0x40f00000    # 7.5f

    const/high16 v8, 0x41a00000    # 20.0f

    const v9, 0x3f99999a    # 1.2f

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 75
    goto/16 :goto_8

    .line 67
    :pswitch_20
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 68
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_15

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 69
    const/high16 v5, 0x41840000    # 16.5f

    const/high16 v6, 0x40800000    # 4.0f

    const/high16 v7, 0x419c0000    # 19.5f

    const/high16 v8, 0x41a00000    # 20.0f

    const v9, 0x3f99999a    # 1.2f

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 70
    goto :goto_8

    .line 63
    :pswitch_21
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 64
    const/high16 v5, 0x40b00000    # 5.5f

    const/high16 v6, 0x40b00000    # 5.5f

    const/high16 v7, 0x41940000    # 18.5f

    const/high16 v8, 0x41940000    # 18.5f

    const v9, 0x4019999a    # 2.4f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 65
    goto :goto_8

    .line 58
    :pswitch_22
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 59
    const/high16 v5, 0x40d00000    # 6.5f

    const/high16 v6, 0x40800000    # 4.0f

    const/high16 v7, 0x41280000    # 10.5f

    const/high16 v8, 0x41a00000    # 20.0f

    const v9, 0x3fb33333    # 1.4f

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 60
    const/high16 v5, 0x41580000    # 13.5f

    const/high16 v7, 0x418c0000    # 17.5f

    invoke-direct/range {v0 .. v9}, Lcom/riola/player/Ico;->box(Landroid/graphics/Canvas;FFFFFFFF)V

    .line 61
    goto :goto_8

    .line 54
    :pswitch_23
    iget-object v0, v10, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 55
    const/4 v5, 0x1

    new-array v6, v13, [F

    fill-array-data v6, :array_16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v14

    move v3, v15

    move v4, v12

    invoke-direct/range {v0 .. v6}, Lcom/riola/player/Ico;->poly(Landroid/graphics/Canvas;FFFZ[F)V

    .line 56
    nop

    .line 266
    :goto_8
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_23
        :pswitch_22
        :pswitch_21
        :pswitch_20
        :pswitch_1f
        :pswitch_1e
        :pswitch_1d
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :array_0
    .array-data 4
        0x40400000    # 3.0f
        0x40e00000    # 7.0f
        0x41000000    # 8.0f
        0x40e00000    # 7.0f
        0x41800000    # 16.0f
        0x41880000    # 17.0f
        0x41a80000    # 21.0f
        0x41880000    # 17.0f
    .end array-data

    :array_1
    .array-data 4
        0x40400000    # 3.0f
        0x41880000    # 17.0f
        0x41000000    # 8.0f
        0x41880000    # 17.0f
        0x41800000    # 16.0f
        0x40e00000    # 7.0f
        0x41a80000    # 21.0f
        0x40e00000    # 7.0f
    .end array-data

    :array_2
    .array-data 4
        0x41900000    # 18.0f
        0x40800000    # 4.0f
        0x41b00000    # 22.0f
        0x40e00000    # 7.0f
        0x41900000    # 18.0f
        0x41200000    # 10.0f
    .end array-data

    :array_3
    .array-data 4
        0x41900000    # 18.0f
        0x41600000    # 14.0f
        0x41b00000    # 22.0f
        0x41880000    # 17.0f
        0x41900000    # 18.0f
        0x41a00000    # 20.0f
    .end array-data

    :array_4
    .array-data 4
        0x41333333    # 11.2f
        0x40333333    # 2.8f
        0x40c00000    # 6.0f
        0x4059999a    # 3.4f
        0x410ccccd    # 8.8f
        0x41033333    # 8.2f
    .end array-data

    :array_5
    .array-data 4
        0x41880000    # 17.0f
        0x41000000    # 8.0f
        0x41b00000    # 22.0f
        0x41400000    # 12.0f
        0x41880000    # 17.0f
        0x41800000    # 16.0f
    .end array-data

    :array_6
    .array-data 4
        0x41800000    # 16.0f
        0x40a00000    # 5.0f
        0x40900000    # 4.5f
        0x40a00000    # 5.0f
        0x40900000    # 4.5f
        0x41800000    # 16.0f
    .end array-data

    :array_7
    .array-data 4
        0x41180000    # 9.5f
        0x40a00000    # 5.0f
        0x41840000    # 16.5f
        0x41400000    # 12.0f
        0x41180000    # 9.5f
        0x41980000    # 19.0f
    .end array-data

    :array_8
    .array-data 4
        0x41700000    # 15.0f
        0x40a00000    # 5.0f
        0x41000000    # 8.0f
        0x41400000    # 12.0f
        0x41700000    # 15.0f
        0x41980000    # 19.0f
    .end array-data

    :array_9
    .array-data 4
        0x40800000    # 4.0f
        0x41a00000    # 20.0f
        0x40a66666    # 5.2f
        0x4179999a    # 15.6f
        0x4179999a    # 15.6f
        0x40a66666    # 5.2f
        0x41966666    # 18.8f
        0x41066666    # 8.4f
        0x41066666    # 8.4f
        0x41966666    # 18.8f
    .end array-data

    :array_a
    .array-data 4
        0x40e00000    # 7.0f
        0x41500000    # 13.0f
        0x41a00000    # 20.0f
        0x41300000    # 11.0f
        0x40c00000    # 6.0f
    .end array-data

    :array_b
    .array-data 4
        0x40b00000    # 5.5f
        0x41100000    # 9.0f
        0x41400000    # 12.0f
        0x41780000    # 15.5f
        0x41940000    # 18.5f
        0x41100000    # 9.0f
    .end array-data

    :array_c
    .array-data 4
        0x40b00000    # 5.5f
        0x41700000    # 15.0f
        0x41400000    # 12.0f
        0x41080000    # 8.5f
        0x41940000    # 18.5f
        0x41700000    # 15.0f
    .end array-data

    :array_d
    .array-data 4
        0x40900000    # 4.5f
        0x414ccccd    # 12.8f
        0x411ccccd    # 9.8f
        0x41900000    # 18.0f
        0x419c0000    # 19.5f
        0x40c00000    # 6.0f
    .end array-data

    :array_e
    .array-data 4
        0x41633333    # 14.2f
        0x40600000    # 3.5f
        0x41a40000    # 20.5f
        0x40c00000    # 6.0f
        0x41a40000    # 20.5f
        0x41233333    # 10.2f
        0x41633333    # 14.2f
        0x40f33333    # 7.6f
    .end array-data

    :array_f
    .array-data 4
        0x41500000    # 13.0f
        0x40666666    # 3.6f
        0x418c0000    # 17.5f
        0x40d00000    # 6.5f
        0x41500000    # 13.0f
        0x41166666    # 9.4f
    .end array-data

    :array_10
    .array-data 4
        0x40e00000    # 7.0f
        0x41100000    # 9.0f
        0x41400000    # 12.0f
        0x40800000    # 4.0f
        0x41880000    # 17.0f
        0x41100000    # 9.0f
    .end array-data

    :array_11
    .array-data 4
        0x40e00000    # 7.0f
        0x41280000    # 10.5f
        0x41400000    # 12.0f
        0x41780000    # 15.5f
        0x41880000    # 17.0f
        0x41280000    # 10.5f
    .end array-data

    :array_12
    .array-data 4
        0x41100000    # 9.0f
        0x40f00000    # 7.5f
        0x41100000    # 9.0f
        0x40800000    # 4.0f
        0x41700000    # 15.0f
        0x40800000    # 4.0f
        0x41700000    # 15.0f
        0x40f00000    # 7.5f
    .end array-data

    :array_13
    .array-data 4
        0x40400000    # 3.0f
        0x41980000    # 19.0f
        0x40400000    # 3.0f
        0x40b00000    # 5.5f
        0x41100000    # 9.0f
        0x40b00000    # 5.5f
        0x41300000    # 11.0f
        0x41080000    # 8.5f
        0x41a80000    # 21.0f
        0x41080000    # 8.5f
        0x41a80000    # 21.0f
        0x41980000    # 19.0f
    .end array-data

    :array_14
    .array-data 4
        0x41980000    # 19.0f
        0x40800000    # 4.0f
        0x41080000    # 8.5f
        0x41400000    # 12.0f
        0x41980000    # 19.0f
        0x41a00000    # 20.0f
    .end array-data

    :array_15
    .array-data 4
        0x40a00000    # 5.0f
        0x40800000    # 4.0f
        0x41780000    # 15.5f
        0x41400000    # 12.0f
        0x40a00000    # 5.0f
        0x41a00000    # 20.0f
    .end array-data

    :array_16
    .array-data 4
        0x40d00000    # 6.5f
        0x40800000    # 4.0f
        0x419c0000    # 19.5f
        0x41400000    # 12.0f
        0x40d00000    # 6.5f
        0x41a00000    # 20.0f
    .end array-data
.end method

.method public getIntrinsicHeight()I
    .locals 1

    .line 291
    const/4 v0, -0x1

    return v0
.end method

.method public getIntrinsicWidth()I
    .locals 1

    .line 290
    const/4 v0, -0x1

    return v0
.end method

.method public getOpacity()I
    .locals 1

    .line 289
    const/4 v0, -0x3

    return v0
.end method

.method public setAlpha(I)V
    .locals 1

    .line 287
    iget-object v0, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {p0}, Lcom/riola/player/Ico;->invalidateSelf()V

    return-void
.end method

.method public setColor(I)V
    .locals 0

    .line 293
    iput p1, p0, Lcom/riola/player/Ico;->color:I

    invoke-virtual {p0}, Lcom/riola/player/Ico;->invalidateSelf()V

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1

    .line 288
    iget-object v0, p0, Lcom/riola/player/Ico;->p:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    invoke-virtual {p0}, Lcom/riola/player/Ico;->invalidateSelf()V

    return-void
.end method
