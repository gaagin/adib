.class final Lcom/adib/maintenance/ReminderCardView;
.super Ljava/lang/Object;
.source "ReminderCardView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adib/maintenance/ReminderCardView$Actions;
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;
    .locals 2

    .line 12
    new-instance v0, Landroid/widget/Button;

    invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p2}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setAllCaps(Z)V

    int-to-float p2, p5

    invoke-virtual {v0, p2}, Landroid/widget/Button;->setTextSize(F)V

    const/4 p2, 0x0

    const/4 p5, 0x1

    invoke-virtual {v0, p2, p5}, Landroid/widget/Button;->setTypeface(Landroid/graphics/Typeface;I)V

    invoke-virtual {v0, p4}, Landroid/widget/Button;->setTextColor(I)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setMinWidth(I)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setMinimumWidth(I)V

    const/16 p2, 0x28

    invoke-static {p0, p2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p4

    invoke-virtual {v0, p4}, Landroid/widget/Button;->setMinHeight(I)V

    invoke-static {p0, p2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p2

    invoke-virtual {v0, p2}, Landroid/widget/Button;->setMinimumHeight(I)V

    const/4 p2, 0x6

    invoke-static {p0, p2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p4

    const/4 p5, 0x4

    invoke-static {p0, p5}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-static {p0, p2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p2

    invoke-static {p0, p5}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p5

    invoke-virtual {v0, p4, v1, p2, p5}, Landroid/widget/Button;->setPadding(IIII)V

    const/16 p2, 0xa

    invoke-static {p0, p2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p0

    int-to-float p0, p0

    invoke-static {p3, p0, p1, p1}, Lcom/adib/maintenance/HybridUi;->rounded(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance p0, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda0;

    invoke-direct {p0, p6}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda0;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object v0
.end method

.method static container(Landroid/content/Context;Lorg/json/JSONObject;)Ljava/lang/String;
    .locals 5

    .line 11
    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->read(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object p0

    const-string v0, "personal"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    const-string v0, "containers"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    :goto_0
    const-string v0, "\u041c\u043e\u0438 \u0437\u0430\u0434\u0430\u0447\u0438"

    if-eqz p0, :cond_3

    const/4 v1, 0x0

    :goto_1
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_3

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    if-eqz v2, :cond_2

    const-string v3, "id"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "containerId"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string p0, "name"

    invoke-virtual {v2, p0, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p1, "INBOX"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p0, "\u0412\u0445\u043e\u0434\u044f\u0449\u0438\u0435"

    :cond_1
    return-object p0

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_3
    return-object v0
.end method

.method static addSwipeHandle(Landroid/content/Context;Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V
    .locals 5

    const-string v0, "test"
    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z
    move-result v0
    if-nez v0, :done

    const-string v0, "id"
    const-string v1, ""
    invoke-virtual {p2, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :done

    new-instance v1, Landroid/view/View;
    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    const-string v2, "reminder-swipe-handle"
    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/view/View;->setBackgroundColor(I)V
    new-instance v2, Lcom/adib/maintenance/ReminderCardSwipeOpen;
    invoke-direct {v2, p0, v0}, Lcom/adib/maintenance/ReminderCardSwipeOpen;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    invoke-virtual {v1, v2}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v3, -0x1
    const/16 v4, 0xc
    invoke-static {p0, v4}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I
    move-result v4
    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    const/4 v3, 0x0
    invoke-virtual {p1, v1, v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    :done
    return-void
.end method

.method static create(Landroid/content/Context;Lorg/json/JSONObject;ZLjava/lang/String;Lcom/adib/maintenance/ReminderCardView$Actions;)Landroid/widget/LinearLayout;
    .locals 17

    move-object/from16 v0, p0

    move-object/from16 v7, p1

    move-object/from16 v8, p3

    move-object/from16 v9, p4

    if-eqz p2, :cond_0

    const v1, -0x574201

    goto :goto_0

    :cond_0
    const v1, -0xab881c

    :goto_0
    move v10, v1

    if-eqz p2, :cond_1

    const v1, -0xd0b06

    goto :goto_1

    :cond_1
    const v1, -0xdbdbdc

    :goto_1
    move v11, v1

    if-eqz p2, :cond_2

    const v1, -0x4f4a3f

    goto :goto_2

    :cond_2
    const v1, -0x666667

    :goto_2
    move v4, v1

    .line 13
    new-instance v12, Landroid/widget/LinearLayout;

    invoke-direct {v12, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const-string v1, "automatic-reminder-popup"

    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    const/16 v1, 0x12

    invoke-static {v0, v1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    const/16 v14, 0xc

    invoke-static {v0, v14}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v3

    invoke-static {v0, v1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v5

    invoke-static {v0, v1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v12, v2, v3, v5, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    if-eqz p2, :cond_3

    const v1, -0xdbd4c8

    goto :goto_3

    :cond_3
    const/4 v1, -0x1

    :goto_3
    const/16 v2, 0x10

    invoke-static {v0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v3

    int-to-float v3, v3

    const/4 v5, 0x0

    invoke-static {v1, v3, v5, v5}, Lcom/adib/maintenance/HybridUi;->rounded(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/16 v1, 0xa

    invoke-static {v0, v1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v12, v3}, Landroid/widget/LinearLayout;->setElevation(F)V

    invoke-static {v0, v12, v7}, Lcom/adib/maintenance/ReminderCardView;->addSwipeHandle(Landroid/content/Context;Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V

    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v2, 0x14

    const/16 v6, -0x40ce

    const-string v1, "\u2691"

    invoke-static {v0, v1, v2, v6}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v6, 0x16

    invoke-static {v0, v6}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v6

    const/4 v15, -0x2

    invoke-direct {v2, v6, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-static {v7}, Lcom/adib/maintenance/ReminderCardView;->due(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0xe

    invoke-static {v0, v1, v2, v10}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "date"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v1, v13}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v2, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v15, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v1, "\u25a3"
    invoke-static {v0, v1, v14, v4}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;
    move-result-object v1
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/16 v6, 0x12
    invoke-static {v0, v6}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I
    move-result v6
    invoke-direct {v2, v6, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v3, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-static/range {p0 .. p1}, Lcom/adib/maintenance/ReminderCardView;->container(Landroid/content/Context;Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v14, v4}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1, v13}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v2, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    const/16 v2, 0x62

    invoke-static {v0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setMaxWidth(I)V

    const/4 v2, 0x6

    invoke-static {v0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v6, 0x4

    invoke-static {v0, v6}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v6

    invoke-virtual {v1, v2, v5, v6, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v2, v2, Landroid/content/res/Configuration;->fontScale:F

    const v6, 0x3f99999a    # 1.2f

    cmpg-float v2, v2, v6

    if-gtz v2, :cond_4



    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v15, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_4
    const-string v1, "test"
    invoke-virtual {v7, v1}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z
    move-result v1
    if-nez v1, :skip_header_pomodoro
    move-object/from16 v14, v3
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, "start"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v9}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;
    new-instance v6, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda4;
    invoke-direct {v6, v9}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda4;-><init>(Lcom/adib/maintenance/ReminderCardView$Actions;)V
    const-string v1, "\u25ce"
    const/4 v3, 0x0
    const/16 v5, 0x18
    invoke-static/range {v0 .. v6}, Lcom/adib/maintenance/ReminderCardView;->button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;
    move-result-object v1
    const-string v2, "Pomodoro"
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setContentDescription(Ljava/lang/CharSequence;)V
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/16 v3, 0x24
    invoke-static {v0, v3}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I
    move-result v3
    const/16 v5, 0x30
    invoke-static {v0, v5}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I
    move-result v6
    invoke-direct {v2, v3, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v14, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    move-object/from16 v3, v14
    :skip_header_pomodoro
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "close"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v9}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v6, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda1;

    invoke-direct {v6, v9}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/ReminderCardView$Actions;)V

    const-string v1, "\u00d7"

    move-object v15, v3

    const/4 v3, 0x0

    move/from16 v16, v5

    const/16 v5, 0x1b

    const/16 v14, 0xa

    invoke-static/range {v0 .. v6}, Lcom/adib/maintenance/ReminderCardView;->button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    const-string v2, "\u0417\u0430\u043a\u0440\u044b\u0442\u044c \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435"

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v3, 0x24

    invoke-static {v0, v3}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v3

    const/16 v5, 0x30

    invoke-static {v0, v5}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v6

    invoke-direct {v2, v3, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v15, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v2, v2, Landroid/content/res/Configuration;->fontScale:F

    const/high16 v3, 0x42080000    # 34.0f

    mul-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v2, v2

    invoke-static {v5, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-static {v0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v3, -0x1

    invoke-direct {v1, v3, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v15, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v2, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    const-string v3, "\u0417\u0430\u0434\u0430\u0447\u0430"

    const-string v6, "title"

    invoke-virtual {v7, v6, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const/16 v15, 0x18

    invoke-static {v0, v3, v15, v11}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v3

    const/4 v11, 0x0

    invoke-virtual {v3, v11, v13}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    invoke-static {v0, v14}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v6

    const/16 v11, 0xc

    invoke-static {v0, v11}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v15

    const/4 v14, 0x0

    invoke-virtual {v3, v14, v6, v14, v15}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const-string v3, "test"

    invoke-virtual {v7, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    const-string v6, "ADIB \u00b7 \u0442\u0435\u0441\u0442 \u043e\u043a\u043d\u0430, \u0431\u0435\u0437 \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u044f \u0437\u0430\u0434\u0430\u0447"

    goto :goto_4

    :cond_5
    const-string v6, ""

    :goto_4
    invoke-static {v0, v6, v11, v4}, Lcom/adib/maintenance/ReminderCardView;->text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;

    move-result-object v6

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v15, "status"

    invoke-virtual {v11, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v6, v13}, Landroid/widget/TextView;->setAccessibilityLiveRegion(I)V

    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v14, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v12, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v7, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "test-close"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v9}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v6, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda1;

    invoke-direct {v6, v9}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/ReminderCardView$Actions;)V

    const-string v1, "\u0417\u0430\u043a\u0440\u044b\u0442\u044c \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0435 \u043e\u043a\u043d\u043e"

    const v3, -0xab881c

    const/4 v4, -0x1

    move v7, v5

    const/16 v5, 0xf

    invoke-static/range {v0 .. v6}, Lcom/adib/maintenance/ReminderCardView;->button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-static {v0, v7}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v0

    const/4 v3, -0x1

    invoke-direct {v2, v3, v0}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object v12

    :cond_6
    move v7, v5

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->fontScale:F

    const/high16 v2, 0x42200000    # 40.0f

    mul-float/2addr v1, v2

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v1

    double-to-int v1, v1

    const/16 v2, 0x2c

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v0, v1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v13

    new-instance v15, Landroid/widget/LinearLayout;

    invoke-direct {v15, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "snooze"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    if-eqz p2, :cond_7

    const v1, -0xcac2b5

    goto :goto_5

    :cond_7
    const v1, -0x9090a

    :goto_5
    move v3, v1

    invoke-static {v9}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v6, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda2;

    invoke-direct {v6, v9}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda2;-><init>(Lcom/adib/maintenance/ReminderCardView$Actions;)V

    const-string v1, "\u041e\u0442\u0441\u0440\u043e\u0447\u043a\u0430"

    const/16 v5, 0x10

    invoke-static/range {v0 .. v6}, Lcom/adib/maintenance/ReminderCardView;->button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "complete"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    if-eqz p2, :cond_8

    const v0, -0xcbba97

    goto :goto_6

    :cond_8
    const v0, -0x110d01

    :goto_6
    move v3, v0

    invoke-static {v9}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v6, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda3;

    invoke-direct {v6, v9}, Lcom/adib/maintenance/ReminderCardView$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/ReminderCardView$Actions;)V

    move-object v0, v1

    const-string v1, "\u0417\u0430\u0432\u0435\u0440\u0448\u0438\u0442\u044c"

    const/16 v5, 0x10

    move v4, v10

    move-object v10, v0

    move-object/from16 v0, p0

    invoke-static/range {v0 .. v6}, Lcom/adib/maintenance/ReminderCardView;->button(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIILjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v14, v13, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v15, v10, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v14, v13, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    const/16 v3, 0x8

    invoke-static {v0, v3}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v3

    iput v3, v2, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    invoke-virtual {v15, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v1, v3, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v15, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object v12
.end method

.method static dp(Landroid/content/Context;I)I
    .locals 0

    .line 6
    invoke-static {p0, p1}, Lcom/adib/maintenance/NativeImageSupport;->dp(Landroid/content/Context;I)I

    move-result p0

    return p0
.end method

.method static due(Lorg/json/JSONObject;)Ljava/lang/String;
    .locals 5

    .line 10
    const-string v0, "date"

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/adib/maintenance/TaskDateTime;->display(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v0, "test"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "\u0422\u0435\u0441\u0442 \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u044f"

    return-object p0

    :cond_0
    const-string p0, "\u041d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435"

    return-object p0

    :cond_1
    const/16 p0, 0xa

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    invoke-static {p0, v2}, Ljava/lang/Math;->min(II)I

    move-result p0

    const/4 v2, 0x0

    invoke-virtual {v0, v2, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0x10

    if-lt v2, v3, :cond_2

    const/16 v2, 0xb

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v1

    :goto_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    const/4 v3, 0x5

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Ljava/util/Calendar;->add(II)V

    invoke-static {}, Lcom/adib/maintenance/TaskCalendarModel;->today()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    const-string p0, "\u0421\u0435\u0433\u043e\u0434\u043d\u044f"

    goto :goto_1

    :cond_3
    invoke-virtual {v2}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v2

    invoke-static {v2}, Lcom/adib/maintenance/TaskCalendarModel;->key(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string p0, "\u0417\u0430\u0432\u0442\u0440\u0430"

    :cond_4


    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_5

    goto :goto_2

    :cond_5
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, ", "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static height(Landroid/content/Context;Z)I
    .locals 3

    const/16 v0, 0xb4

    .line 8
    invoke-static {p0, v0}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    const/16 v2, 0x60

    invoke-static {p0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    sub-int/2addr v1, v2

    if-eqz p1, :cond_0

    const/16 p1, 0xf0

    goto :goto_0

    :cond_0
    const/16 p1, 0x10e

    :goto_0
    invoke-static {p0, p1}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p0

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    return p0
.end method

.method static synthetic lambda$button$0(Ljava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    .line 12
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method static text(Landroid/content/Context;Ljava/lang/String;II)Landroid/widget/TextView;
    .locals 1

    .line 9
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    int-to-float p0, p2

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    return-object v0
.end method

.method static width(Landroid/content/Context;)I
    .locals 3

    const/16 v0, 0xb4

    .line 7
    invoke-static {p0, v0}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    const/16 v2, 0x14

    invoke-static {p0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result v2

    sub-int/2addr v1, v2

    const/16 v2, 0x208

    invoke-static {p0, v2}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I

    move-result p0

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    return p0
.end method
