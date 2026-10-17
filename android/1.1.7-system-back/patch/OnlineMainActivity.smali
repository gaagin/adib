.class public final Lcom/adib/maintenance/OnlineMainActivity;
.super Landroid/app/Activity;
.source "OnlineMainActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adib/maintenance/OnlineMainActivity$AndroidBridge;
    }
.end annotation


# static fields
.field private static final IO:Ljava/util/concurrent/ExecutorService;

.field private static final PREFS:Ljava/lang/String; = "adib_native_bridge"

.field private static final WAITING:Ljava/lang/String; = "overlay_permission_target"


# instance fields
.field private final host:Ljava/lang/String;
.field private backDispatchPending:Z

.field private systemBackCallback:Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;

.field private navigationScrim:Landroid/view/View;

.field private navigationSurface:I

.field private offline:Landroid/widget/LinearLayout;

.field private pageSurface:I

.field private pendingDialogVisible:Z

.field private pendingSession:Ljava/lang/String;

.field private photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

.field private receiverRegistered:Z

.field private root:Landroid/widget/FrameLayout;

.field private statusSurface:I

.field private web:Landroid/webkit/WebView;

.field private final workReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public static synthetic $r8$lambda$0mSTME4sEM035jBiEarrlsdCrzU(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$openCurrentWorkTimer$5(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$1d0dbtYNqCPrr3wqIhLidEbvDyc(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$stopWorkTimerSession$9(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$3wce9-gJsOt9ybtC1hi7I5_fF2s(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$openCurrentWorkTimer$4(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$4W8eMWfEokJ-yx_29cZJ2d25e4k(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->showPendingDialog()V

    return-void
.end method

.method public static synthetic $r8$lambda$5iicWCTKaK5eI8xNNunhTQ2g5Ls(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$openCurrentWorkTimer$3(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$8tWmBV_kE21DiKyRiSgaNXeevIc(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$requestOverlayPermission$10(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$BJCZ1AjUyd8j2QLjSwmUtFL6ylw(Lcom/adib/maintenance/OnlineMainActivity;Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$addInsetHandling$1(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$C6qwb1xFn1UUA9gnFy3thOVFGpg(Lcom/adib/maintenance/OnlineMainActivity;)Z
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$onCreate$0()Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$CBy-EkcT1iDgFC59mk73vKycIf0(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$stopWorkTimerSession$7(Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$EHYRdsNerQXhgATPsONfqlXsFsI(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$stopWorkTimerSession$6(Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Gd02KD1X3E29ZVDtGGiZIBKlnp4(Lcom/adib/maintenance/OnlineMainActivity;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$makeOfflineView$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$JpPDGxEvaW9cmM8ft2Bqr-lyrBg(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$submitPending$16(Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$XYY_cYl1BsgPJTywgKt1MAbheLc(Lcom/adib/maintenance/OnlineMainActivity;Landroid/content/SharedPreferences;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$requestOverlayPermission$12(Landroid/content/SharedPreferences;Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$ZkTMr1BxthDQCx2f4ZTshhmpkpY(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$refreshWorkState$13()V

    return-void
.end method

.method public static synthetic $r8$lambda$cmCyLvyBMXmCJoRmMLvz1bC_S0I(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$stopWorkTimerSession$8(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$pRMvnACctW2vO4fqnxH_oxblqoo(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$toast$17(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$sYBAR_qo_7Yrqjc64_VuyVUwGlQ(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$submitPending$14(Ljava/lang/String;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$weVUOGva79eLBEXAfgIf4FJF91o(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->lambda$submitPending$15(Ljava/lang/Exception;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgethost(Lcom/adib/maintenance/OnlineMainActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/OnlineMainActivity;->host:Ljava/lang/String;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetoffline(Lcom/adib/maintenance/OnlineMainActivity;)Landroid/widget/LinearLayout;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetpendingSession(Lcom/adib/maintenance/OnlineMainActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetphotoChooser(Lcom/adib/maintenance/OnlineMainActivity;)Lcom/adib/maintenance/WebPhotoChooser;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/OnlineMainActivity;->photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetweb(Lcom/adib/maintenance/OnlineMainActivity;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputpendingSession(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    return-void
.end method

.method static bridge synthetic -$$Nest$mhandleLaunchIntent(Lcom/adib/maintenance/OnlineMainActivity;Landroid/content/Intent;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->handleLaunchIntent(Landroid/content/Intent;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$minjectNativeHooks(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->injectNativeHooks()V

    return-void
.end method

.method static bridge synthetic -$$Nest$mopenCurrentWorkTimer(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->openCurrentWorkTimer(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mrequestOverlayPermission(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mshowPendingDialog(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->showPendingDialog()V

    return-void
.end method

.method static bridge synthetic -$$Nest$mstopWorkTimerSession(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->stopWorkTimerSession(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mtoast(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 38
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/adib/maintenance/OnlineMainActivity;->IO:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const/4 v0, 0x0

    .line 45
    iput-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingDialogVisible:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->receiverRegistered:Z

    .line 46
    const-string v0, ""

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    .line 47
    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$1;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/OnlineMainActivity$1;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->workReceiver:Landroid/content/BroadcastReceiver;

    .line 48
    const-string v0, "https://adib-production-eba3.up.railway.app/"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->host:Ljava/lang/String;

    return-void
.end method

.method private addInsetHandling()V
    .locals 4

    .line 55
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationScrim:Landroid/view/View;

    iget v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationSurface:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, 0x0

    const/16 v2, 0x50

    const/4 v3, -0x1

    invoke-direct {v0, v3, v1, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationScrim:Landroid/view/View;

    invoke-virtual {v1, v2, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda18;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda18;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    return-void
.end method

.method private configureBars()V
    .locals 9

    .line 54
    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    const/16 v1, 0x20

    const/4 v2, 0x0

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    const/16 v1, 0x2c

    const/16 v3, 0x16

    const/16 v4, 0x1e

    if-eqz v0, :cond_1

    invoke-static {v3, v4, v1}, Landroid/graphics/Color;->rgb(III)I

    move-result v5

    goto :goto_1

    :cond_1
    const/16 v5, 0x83

    const/16 v6, 0xe2

    const/16 v7, 0x23

    invoke-static {v7, v5, v6}, Landroid/graphics/Color;->rgb(III)I

    move-result v5

    :goto_1
    iput v5, p0, Lcom/adib/maintenance/OnlineMainActivity;->statusSurface:I

    const/16 v5, 0xfc

    const/16 v6, 0xf5

    const/16 v7, 0xf2

    if-eqz v0, :cond_2

    invoke-static {v3, v4, v1}, Landroid/graphics/Color;->rgb(III)I

    move-result v8

    goto :goto_2

    :cond_2
    invoke-static {v7, v6, v5}, Landroid/graphics/Color;->rgb(III)I

    move-result v8

    :goto_2
    iput v8, p0, Lcom/adib/maintenance/OnlineMainActivity;->pageSurface:I

    if-eqz v0, :cond_3

    invoke-static {v3, v4, v1}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    goto :goto_3

    :cond_3
    invoke-static {v7, v6, v5}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    :goto_3
    iput v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationSurface:I

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v4, :cond_4

    move v3, v2

    goto :goto_4

    :cond_4
    iget v3, p0, Lcom/adib/maintenance/OnlineMainActivity;->statusSurface:I

    :goto_4
    invoke-virtual {v1, v3}, Landroid/view/Window;->setStatusBarColor(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v4, :cond_5

    move v3, v2

    goto :goto_5

    :cond_5
    iget v3, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationSurface:I

    :goto_5
    invoke-virtual {v1, v3}, Landroid/view/Window;->setNavigationBarColor(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v3, 0x10

    invoke-virtual {v1, v3}, Landroid/view/Window;->setSoftInputMode(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    if-eqz v0, :cond_6

    move v3, v2

    :cond_6
    invoke-virtual {v1, v3}, Landroid/view/View;->setSystemUiVisibility(I)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_7

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->setStatusBarContrastEnforced(Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->setNavigationBarContrastEnforced(Z)V

    :cond_7
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v4, :cond_8

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->setDecorFitsSystemWindows(Z)V

    :cond_8
    return-void
.end method

.method private dp(F)I
    .locals 1

    .line 56
    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private handleLaunchIntent(Landroid/content/Intent;)V
    .locals 4

    if-eqz p1, :cond_5

    .line 76
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    goto/16 :goto_1

    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.adib.maintenance.FLOAT_TIMER_PERMISSION"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string p1, "pomodoro"

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v1, "com.adib.maintenance.TIMER_NOTIFICATION_PERMISSION"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->requestNotificationPermission()V

    return-void

    :cond_2
    const-string v1, "com.adib.maintenance.QUICK_ADD"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_4

    const-string v1, "com.adib.maintenance.WIDGET_PLUS"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    goto :goto_0

    :cond_3
    const-string v1, "com.adib.maintenance.WIDGET_TASK"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "widget_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "[data-home-open=\'"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\']"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "(function(){window.ADIBHome?.open();setTimeout(()=>document.querySelector("

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ")?.click(),900)})()"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void

    :cond_4
    :goto_0
    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    const-string v0, "(function(){window.ADIBHome?.open();setTimeout(()=>document.querySelector(\'.adib-home-add\')?.click(),700)})()"

    invoke-virtual {p1, v0, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_5
    :goto_1
    return-void
.end method

.method private injectNativeHooks()V
    .locals 3

    .line 58
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v1, "(function(){if(window.__adibAndroidNativeHooks)return;window.__adibAndroidNativeHooks=true;document.documentElement.classList.add(\'adib-android-wrapper\');if(document.body)document.body.classList.add(\'adib-android-wrapper\');var B=window.ADIBAndroid;if(!B)return;function call(method){try{if(B&&typeof B[method]===\'function\')B[method].apply(B,Array.prototype.slice.call(arguments,1))}catch(e){}}function nativeButton(host,label,method,id){if(!host||host.querySelector(\'[data-adib-native=\\\"\'+method+\'\\\"]\'))return;var b=document.createElement(\'button\');b.type=\'button\';b.dataset.adibNative=method;b.textContent=\'\u2197\';b.title=label;b.setAttribute(\'aria-label\',label);b.style.cssText=\'min-width:36px;min-height:36px;margin:2px 4px;border:1px solid #d6deed;border-radius:9px;background:#f7f9fd;color:#4776ef;font:600 16px system-ui;flex:none\';b.onclick=function(e){e.preventDefault();e.stopPropagation();call(method,id||\'\')};host.appendChild(b)}function nativeCss(){try{if(B.hasOverlayPermission()){var st=document.getElementById(\'adib-native-floats\');if(!st){st=document.createElement(\'style\');st.id=\'adib-native-floats\';document.head.appendChild(st)}var css=\'.adib-work-floating,.personal-pomodoro-fab,.personal-pomodoro-overlay{display:none!important}\';if(st.textContent!==css)st.textContent=css}}catch(e){}}function enhance(){nativeCss();document.querySelectorAll(\'.adib-work-panel\').forEach(function(p){var row=p.querySelector(\':scope > div\');if(row)nativeButton(row,\'\u0130\u015f taymerini t\u0259tbiql\u0259rin \u00fcz\u0259rind\u0259 a\u00e7\',\'openWorkTimer\',p.dataset.workTask||\'\');var counter=p.querySelector(\'strong\');if(counter&&!counter.dataset.adibStopHook){counter.dataset.adibStopHook=\'1\';counter.setAttribute(\'role\',\'button\');counter.setAttribute(\'tabindex\',\'0\');counter.title=\'Taymeri dayand\u0131rmaq \u00fc\u00e7\u00fcn klikl\u0259yin\';counter.style.cursor=\'pointer\';counter.addEventListener(\'click\',function(e){e.preventDefault();e.stopPropagation();call(\'stopWorkTimer\',p.dataset.workTask||\'\')})}});document.querySelectorAll(\'.personal-pomodoro-head,.personal-pomodoro-overlay\').forEach(function(h){var m=h.closest(\'.personal-pomodoro-modal\'),id=(m&&m.dataset.taskId)||h.dataset.taskId||(window.ADIBBrowserPomodoro&&window.ADIBBrowserPomodoro.activeId&&window.ADIBBrowserPomodoro.activeId());if(id)nativeButton(h,\'Pomodoronu t\u0259tbiql\u0259rin \u00fcz\u0259rind\u0259 a\u00e7\',\'openPomodoro\',id)});document.querySelectorAll(\'[data-browser-pomodoro]\').forEach(function(b){b.style.display=\'none\'});}if(window.fetch){var f=window.fetch;window.fetch=function(input,init){var url=typeof input===\'string\'?input:(input&&input.url)||\'\',method=((init&&init.method)||(input&&input.method)||\'GET\').toUpperCase(),body=init&&init.body;var p=f.apply(this,arguments);if(method===\'POST\'&&/\\/api\\/(work-timer|personal-pomodoro)(?:[?#]|$)/.test(url)){p.then(function(r){if(!r.ok)return;r.clone().json().then(function(d){if(url.indexOf(\'/api/work-timer\')>=0)call(\'onWorkTimer\',JSON.stringify(d));else{var b={};try{b=typeof body===\'string\'?JSON.parse(body):{}}catch(e){}call(\'onPomodoroAction\',b.action||\'\',b.id||\'\')}}).catch(function(){})}).catch(function(){})}return p}}var obs=new MutationObserver(function(){enhance()});if(document.documentElement)obs.observe(document.documentElement,{childList:true,subtree:true});window.__adibNativeEnhance=enhance;enhance();})();"

    const/4 v2, 0x0

    .line 63
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    const-string v1, "(function(){window.__adibAndroidSystemBack=function(){try{var q=function(s){return document.querySelector(s)},pop=q(':popover-open');if(pop){if(pop.hidePopover)pop.hidePopover();return 1}var ds=document.querySelectorAll('dialog[open]');if(ds.length){var d=ds[ds.length-1];if(d.requestClose)d.requestClose();else d.close();return 1}var c=document.getElementById('adibChatOverlay');if(c&&!c.hidden){var b=c.querySelector('[data-chat-back]');if(c.classList.contains('conversation-open')&&b)b.click();else{b=c.querySelector('[data-chat-close]');if(b)b.click();else if(window.closeCommentChat)window.closeCommentChat();else c.hidden=true}return 1}var x=document.getElementById('adibSettingsMenu');if(x&&!x.hidden){x.hidden=true;x=document.getElementById('adibSettingsButton');if(x)x.setAttribute('aria-expanded','false');return 1}var p=q('.personal-kanban-modal');if(p&&p.classList.contains('personal-kanban-search-open')){p.classList.remove('personal-kanban-search-open');return 1}var k=q('.modal-backdrop.open.kanban-modal');if(k&&k.classList.contains('kanban-search-open')){k.classList.remove('kanban-search-open');return 1}if(document.body.classList.contains('miro-personal-search-open')){document.body.classList.remove('miro-personal-search-open');return 1}x=document.getElementById('mobileSearchPanel');if(x&&!x.hidden){if(window.setMobileMode)window.setMobileMode('canvas');else x.hidden=true;return 1}if(p&&p.classList.contains('personal-kanban-filter-open')){p.classList.remove('personal-kanban-filter-open');return 1}if(k&&k.classList.contains('kanban-filter-open')){k.classList.remove('kanban-filter-open');return 1}x=q('.personal-eisenhower-modal.personal-eisenhower-filter-open');if(x){x.classList.remove('personal-eisenhower-filter-open');return 1}x=document.getElementById('taskFiltersPanel');if(x&&!x.hidden){x.hidden=true;return 1}var ms=document.querySelectorAll('.adib-view-menu[open]');if(ms.length){ms[ms.length-1].open=false;return 1}var pers=document.getElementById('personalMode'),isPers=!!(pers&&!pers.hidden);if(isPers&&window.__adibCanPersonalBack&&window.__adibCanPersonalBack()&&window.__adibPersonalBack)return window.__adibPersonalBack()?1:0;if(!isPers&&window.__adibCanEquipmentBack&&window.__adibCanEquipmentBack()&&window.__adibEquipmentBack)return window.__adibEquipmentBack()?1:0;var st=history.state;if(st&&st.adibNavigation&&!st.adibRoot){history.back();return 1}if(st&&st.adibNavigation&&st.adibRoot)return -1;return 0}catch(e){return 0}}})();"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$addInsetHandling$1(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 5

    .line 55
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    invoke-static {}, Landroid/view/WindowInsets$Type;->statusBars()I

    move-result v0

    invoke-static {}, Landroid/view/WindowInsets$Type;->navigationBars()I

    move-result v2

    or-int/2addr v0, v2

    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I

    move-result v2

    or-int/2addr v0, v2

    invoke-virtual {p2, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v0

    iget v2, v0, Landroid/graphics/Insets;->top:I

    iget v3, v0, Landroid/graphics/Insets;->bottom:I

    iget v4, v0, Landroid/graphics/Insets;->left:I

    iget v0, v0, Landroid/graphics/Insets;->right:I

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetTop()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetBottom()I

    move-result v3

    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetLeft()I

    move-result v4

    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetRight()I

    move-result v0

    :goto_0
    invoke-virtual {p1, v4, v2, v0, v3}, Landroid/view/View;->setPadding(IIII)V

    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationScrim:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    iput v3, p1, Landroid/widget/FrameLayout$LayoutParams;->height:I

    neg-int v0, v3

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->navigationScrim:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p1, v1, :cond_1

    sget-object p1, Landroid/view/WindowInsets;->CONSUMED:Landroid/view/WindowInsets;

    return-object p1

    :cond_1
    invoke-virtual {p2}, Landroid/view/WindowInsets;->consumeSystemWindowInsets()Landroid/view/WindowInsets;

    move-result-object p1

    return-object p1
.end method

.method private synthetic lambda$makeOfflineView$2(Landroid/view/View;)V
    .locals 1

    .line 57
    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->reload()V

    return-void
.end method

.method private synthetic lambda$onCreate$0()Z
    .locals 3

    .line 52
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    const-string v1, "https"

    invoke-virtual {v0}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->host:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method private synthetic lambda$openCurrentWorkTimer$3(Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 3

    if-nez p1, :cond_0

    .line 72
    const-string p1, "\u018fvv\u0259lc\u0259 tap\u015f\u0131r\u0131qda i\u015f taymerini ba\u015flad\u0131n"

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void

    :cond_0
    const-string v0, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p2, v0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v0

    invoke-static {p0, p1, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sync(Landroid/content/Context;Lorg/json/JSONObject;J)V

    const-string p1, "work"

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$openCurrentWorkTimer$4(Ljava/lang/Exception;)V
    .locals 2

    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Taymeri a\u00e7maq al\u0131nmad\u0131: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$openCurrentWorkTimer$5(Ljava/lang/String;)V
    .locals 9

    .line 72
    :try_start_0
    invoke-static {p0}, Lcom/adib/maintenance/WorkTimerApi;->getState(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "own"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v2, "status"

    const-string v3, "taskId"

    const/4 v4, 0x0

    if-eqz v1, :cond_2

    move v5, v4

    :goto_0
    :try_start_1
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v5, v6, :cond_2

    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-eqz v6, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_0

    invoke-virtual {v6, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    :cond_0
    const-string v7, "running"

    invoke-virtual {v6, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_2
    const/4 v6, 0x0

    :goto_1
    if-nez v6, :cond_5

    if-eqz v1, :cond_5

    :goto_2
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v4, v5, :cond_5

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    if-eqz v5, :cond_4

    const-string v7, "pending"

    invoke-virtual {v5, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    invoke-virtual {v5, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    :cond_3
    move-object v6, v5

    goto :goto_3

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_5
    :goto_3
    new-instance p1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda12;

    invoke-direct {p1, p0, v6, v0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda12;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda13;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda13;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$refreshWorkState$13()V
    .locals 8

    .line 78
    const-string v0, "status"

    :try_start_0
    invoke-static {p0}, Lcom/adib/maintenance/WorkTimerApi;->getState(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "own"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    if-nez v2, :cond_0

    goto :goto_2

    :cond_0
    const/4 v3, 0x0

    move v4, v3

    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v4, v5, :cond_4

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    if-nez v5, :cond_1

    goto :goto_1

    :cond_1
    const-string v6, "running"

    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    const-string v0, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v0

    invoke-static {p0, v5, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sync(Landroid/content/Context;Lorg/json/JSONObject;J)V

    return-void

    :cond_2
    const-string v6, "pending"

    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v6, "adib_work_timer"

    invoke-virtual {p0, v6, v3}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v6

    const-string v7, "pending_native_confirmation"

    invoke-interface {v6, v7, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda17;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda17;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_3
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_0
    :cond_4
    :goto_2
    return-void
.end method

.method private synthetic lambda$requestOverlayPermission$10(Ljava/lang/String;)V
    .locals 0

    .line 74
    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic lambda$requestOverlayPermission$11(Landroid/content/SharedPreferences;Landroid/content/DialogInterface;I)V
    .locals 0

    .line 74
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string p1, "permission_prompt_open"

    const/4 p2, 0x0

    invoke-interface {p0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string p1, "overlay_permission_target"

    invoke-interface {p0, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private synthetic lambda$requestOverlayPermission$12(Landroid/content/SharedPreferences;Landroid/content/DialogInterface;I)V
    .locals 2

    const-string p2, "package:"

    .line 74
    :try_start_0
    new-instance p3, Landroid/content/Intent;

    const-string v0, "android.settings.action.MANAGE_OVERLAY_PERMISSION"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->getPackageName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-direct {p3, v0, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, p3}, Lcom/adib/maintenance/OnlineMainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "permission_prompt_open"

    const/4 p3, 0x0

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "overlay_permission_target"

    invoke-interface {p1, p2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string p1, "ADIB parametrl\u0259rini a\u00e7\u0131n v\u0259 dig\u0259r t\u0259tbiql\u0259rin \u00fcz\u0259rind\u0259 g\u00f6st\u0259rilm\u0259y\u0259 icaz\u0259 verin"

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$stopWorkTimerSession$6(Lorg/json/JSONObject;)V
    .locals 2

    .line 73
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    const-string p1, "adib_work_timer"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "pending_session"

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "pending_native_confirmation"

    const/4 v1, 0x1

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->showPendingDialog()V

    return-void
.end method

.method private synthetic lambda$stopWorkTimerSession$7(Lorg/json/JSONObject;)V
    .locals 0

    .line 73
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->showPendingDialog()V

    return-void
.end method

.method private synthetic lambda$stopWorkTimerSession$8(Ljava/lang/Exception;)V
    .locals 2

    .line 73
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Seans\u0131 dayand\u0131rmaq al\u0131nmad\u0131: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$stopWorkTimerSession$9(Ljava/lang/String;)V
    .locals 9

    .line 73
    const-string v0, "revision"

    :try_start_0
    invoke-static {p0}, Lcom/adib/maintenance/WorkTimerApi;->getState(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "own"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v2, "pending"

    const/4 v3, 0x0

    const-string v4, "status"

    if-eqz v1, :cond_2

    move v5, v3

    :goto_0
    :try_start_1
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v5, v6, :cond_2

    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-eqz v6, :cond_1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_0

    const-string v7, "taskId"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    :cond_0
    const-string v7, "running"

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_3

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_2
    const/4 v6, 0x0

    :cond_3
    :goto_1
    if-eqz v6, :cond_6

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    new-instance p1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda3;

    invoke-direct {p1, p0, v6}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;)V

    :goto_2
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void

    :cond_4
    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "action"

    const-string v2, "stop"

    invoke-virtual {p1, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "sessionId"

    const-string v2, "id"

    invoke-virtual {v6, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {v6, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "operationId"

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/adib/maintenance/WorkTimerApi;->action(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "session"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_5

    const-string v1, "adib_work_timer"

    invoke-virtual {p0, v1, v3}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pending_session"

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pending_native_confirmation"

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string v1, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p1, v1, v2, v3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-static {p0, v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sync(Landroid/content/Context;Lorg/json/JSONObject;J)V

    new-instance p1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda4;

    invoke-direct {p1, p0, v0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda4;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Lorg/json/JSONObject;)V

    goto :goto_2

    :cond_5
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Server dayand\u0131rman\u0131 t\u0259sdiql\u0259m\u0259di"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_6
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Bu tap\u015f\u0131r\u0131q \u00fc\u00e7\u00fcn aktiv seans yoxdur"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    move-exception p1

    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda5;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$submitPending$14(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 1

    .line 80
    const-string v0, "continue"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "\u0130\u015f davam etdirildi"

    goto :goto_0

    :cond_0
    const-string p1, "\u0130\u015f vaxt\u0131 saxlan\u0131ld\u0131"

    :goto_0
    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    const-string p1, "status"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "running"

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->refresh(Landroid/content/Context;)V

    goto :goto_1

    :cond_1
    const-string p1, "work"

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V

    :cond_2
    :goto_1
    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Landroid/webkit/WebView;->reload()V

    :cond_3
    return-void
.end method

.method private synthetic lambda$submitPending$15(Ljava/lang/Exception;)V
    .locals 2

    .line 80
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Vaxt\u0131 t\u0259sdiql\u0259m\u0259k al\u0131nmad\u0131: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$submitPending$16(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 6

    .line 80
    const-string v0, "endedAt"

    const-string v1, "startedAt"

    const-string v2, "revision"

    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    const-string v4, "action"

    invoke-virtual {v3, v4, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "sessionId"

    const-string v5, "id"

    invoke-virtual {p2, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {p2, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v3

    invoke-virtual {v2, v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object p2

    const-string v0, "operationId"

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p2

    invoke-static {p0, p2}, Lcom/adib/maintenance/WorkTimerApi;->action(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p2

    const-string v0, "session"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "adib_work_timer"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "pending_session"

    invoke-interface {v1, v3}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "pending_native_confirmation"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string v1, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p2, v1, v2, v3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-static {p0, v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sync(Landroid/content/Context;Lorg/json/JSONObject;J)V

    new-instance p2, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda8;

    invoke-direct {p2, p0, p1, v0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda8;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;Lorg/json/JSONObject;)V

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void

    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Server \u0259m\u0259liyyat\u0131 t\u0259sdiql\u0259m\u0259di"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    new-instance p2, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda9;

    invoke-direct {p2, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda9;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$toast$17(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    .line 81
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private makeOfflineView()V
    .locals 7

    .line 57
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v3

    const/high16 v4, 0x41a00000    # 20.0f

    invoke-direct {p0, v4}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v5

    invoke-direct {p0, v2}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v2

    invoke-direct {p0, v4}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v6

    invoke-virtual {v0, v3, v5, v2, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/16 v2, 0xf5

    const/16 v3, 0xfc

    const/16 v5, 0xf2

    invoke-static {v5, v2, v3}, Landroid/graphics/Color;->rgb(III)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v2, "Ba\u011flant\u0131 yoxdur"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/16 v2, 0x33

    const/16 v3, 0x4b

    const/16 v5, 0x25

    invoke-static {v5, v2, v3}, Landroid/graphics/Color;->rgb(III)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v2, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v2, "Yenid\u0259n c\u0259hd et"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v3, 0x41700000    # 15.0f

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/16 v3, 0x76

    const/16 v4, 0xef

    const/16 v5, 0x47

    invoke-static {v5, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 v3, 0x41400000    # 12.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x42400000    # 48.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v3, 0x41900000    # 18.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/OnlineMainActivity;->dp(F)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    iget-object v3, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda2;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v3, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private openCurrentWorkTimer(Ljava/lang/String;)V
    .locals 2

    .line 72
    sget-object v0, Lcom/adib/maintenance/OnlineMainActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private refreshWorkState()V
    .locals 2

    .line 78
    sget-object v0, Lcom/adib/maintenance/OnlineMainActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda6;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private requestNotificationPermission()V
    .locals 3

    .line 77
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_0

    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    const/16 v0, 0x385

    invoke-virtual {p0, v1, v0}, Lcom/adib/maintenance/OnlineMainActivity;->requestPermissions([Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method private requestOverlayPermission(Ljava/lang/String;)V
    .locals 4

    .line 74
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-eq v0, v1, :cond_0

    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void

    :cond_0
    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "work"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->refresh(Landroid/content/Context;)V

    goto :goto_0

    :cond_1
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startSync(Landroid/content/Context;)V

    :goto_0
    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz p1, :cond_3

    const-string v0, "window.__adibNativeEnhance&&window.__adibNativeEnhance()"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void

    :cond_2
    const-string v0, "adib_native_bridge"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "permission_prompt_open"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_4

    :cond_3
    return-void

    :cond_4
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "overlay_permission_target"

    invoke-interface {v1, v2, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    new-instance p1, Landroid/app/AlertDialog$Builder;

    invoke-direct {p1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "\u00dcz\u0259n p\u0259nc\u0259r\u0259y\u0259 icaz\u0259 verilsin?"

    invoke-virtual {p1, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string v1, "ADIB taymerinin dig\u0259r t\u0259tbiql\u0259rin \u00fcz\u0259rind\u0259 g\u00f6r\u00fcnm\u0259si \u00fc\u00e7\u00fcn icaz\u0259 verin. Bu icaz\u0259ni Android parametrl\u0259rind\u0259 l\u0259\u011fv ed\u0259 bil\u0259rsiniz."

    invoke-virtual {p1, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda10;

    invoke-direct {v1, v0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda10;-><init>(Landroid/content/SharedPreferences;)V

    const-string v2, "L\u0259\u011fv et"

    invoke-virtual {p1, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v1, p0, v0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda11;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Landroid/content/SharedPreferences;)V

    const-string v0, "Parametrl\u0259ri a\u00e7"

    invoke-virtual {p1, v0, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method private resumeWaitingTimer()V
    .locals 5

    .line 75
    const-string v0, "adib_native_bridge"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/OnlineMainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, ""

    const-string v3, "overlay_permission_target"

    invoke-interface {v0, v3, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v3}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "permission_prompt_open"

    invoke-interface {v0, v3, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "\u00dcz\u0259n p\u0259nc\u0259r\u0259 \u00fc\u00e7\u00fcn icaz\u0259 verilm\u0259yib"

    invoke-direct {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v0, "work"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->refreshWorkState()V

    goto :goto_0

    :cond_2
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startSync(Landroid/content/Context;)V

    :goto_0
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :cond_3

    const-string v1, "window.__adibNativeEnhance&&window.__adibNativeEnhance()"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_3
    :goto_1
    return-void
.end method

.method private showPendingDialog()V
    .locals 3

    .line 79
    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pendingSession:Ljava/lang/String;

    invoke-direct {v0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "pending"

    const-string v2, "status"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {p0, v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sync(Landroid/content/Context;Lorg/json/JSONObject;J)V

    invoke-static {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->refresh(Landroid/content/Context;)V

    return-void

    :cond_2
    const-string v0, "work"

    invoke-direct {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->requestOverlayPermission(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "T\u0259sdiq p\u0259nc\u0259r\u0259sini a\u00e7maq al\u0131nmad\u0131: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->toast(Ljava/lang/String;)V

    :cond_3
    :goto_0
    return-void
.end method

.method private stopWorkTimerSession(Ljava/lang/String;)V
    .locals 2

    .line 73
    sget-object v0, Lcom/adib/maintenance/OnlineMainActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda15;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private submitPending(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 2

    .line 80
    sget-object v0, Lcom/adib/maintenance/OnlineMainActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v1, p0, p2, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;Lorg/json/JSONObject;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private toast(Ljava/lang/String;)V
    .locals 1

    .line 81
    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda16;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda16;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 85
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/adib/maintenance/WebPhotoChooser;->result(IILandroid/content/Intent;)Z

    :cond_0
    return-void
.end method

.method public dispatchSystemBack()V
    .locals 3

    iget-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->backDispatchPending:Z

    if-nez v0, :done

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-nez v0, :dispatch

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :dispatch
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->backDispatchPending:Z

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$BackResultCallback;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$BackResultCallback;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    const-string v2, "(function(){try{return window.__adibAndroidSystemBack?window.__adibAndroidSystemBack():0}catch(e){return 0}})()"

    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :done
    return-void
.end method

.method public onSystemBackResult(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->backDispatchPending:Z

    const-string v0, "1"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :done

    const-string v0, "-1"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :fallback

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :fallback
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :exit

    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v1

    if-eqz v1, :exit

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->offline:Landroid/widget/LinearLayout;

    if-eqz v1, :go_back

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v1

    if-eqz v1, :go_back

    goto :exit

    :go_back
    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V

    return-void

    :exit
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    :done
    return-void
.end method

.method private registerSystemBackCallback()V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :done

    new-instance v0, Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->systemBackCallback:Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;

    invoke-virtual {p0}, Landroid/app/Activity;->getOnBackInvokedDispatcher()Landroid/window/OnBackInvokedDispatcher;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2, v0}, Landroid/window/OnBackInvokedDispatcher;->registerOnBackInvokedCallback(ILandroid/window/OnBackInvokedCallback;)V

    :done
    return-void
.end method

.method private unregisterSystemBackCallback()V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :done

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->systemBackCallback:Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;

    if-eqz v0, :done

    invoke-virtual {p0}, Landroid/app/Activity;->getOnBackInvokedDispatcher()Landroid/window/OnBackInvokedDispatcher;

    move-result-object v1

    invoke-interface {v1, v0}, Landroid/window/OnBackInvokedDispatcher;->unregisterOnBackInvokedCallback(Landroid/window/OnBackInvokedCallback;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->systemBackCallback:Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;

    :done
    return-void
.end method

.method public onBackPressed()V
    .locals 0

    invoke-virtual {p0}, Lcom/adib/maintenance/OnlineMainActivity;->dispatchSystemBack()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 50
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->configureBars()V

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    iget v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->statusSurface:I

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    new-instance v0, Landroid/webkit/WebView;

    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    iget v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->pageSurface:I

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setSupportMultipleWindows(Z)V

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v0

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {v0, v1, v2}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$AndroidBridge;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/adib/maintenance/OnlineMainActivity$AndroidBridge;-><init>(Lcom/adib/maintenance/OnlineMainActivity;Lcom/adib/maintenance/OnlineMainActivity-IA;)V

    const-string v2, "ADIBAndroid"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->makeOfflineView()V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->addInsetHandling()V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->setContentView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->root:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->requestApplyInsets()V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->registerSystemBackCallback()V

    .line 51
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$2;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$2;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 52
    new-instance v0, Lcom/adib/maintenance/WebPhotoChooser;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$$ExternalSyntheticLambda7;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-direct {v0, p0, v1}, Lcom/adib/maintenance/WebPhotoChooser;-><init>(Landroid/app/Activity;Ljava/util/function/BooleanSupplier;)V

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

    invoke-virtual {v0, p1}, Lcom/adib/maintenance/WebPhotoChooser;->restore(Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    new-instance v1, Lcom/adib/maintenance/OnlineMainActivity$3;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/OnlineMainActivity$3;-><init>(Lcom/adib/maintenance/OnlineMainActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->restoreState(Landroid/os/Bundle;)Landroid/webkit/WebBackForwardList;

    move-result-object p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    return-void

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    const-string v0, "https://adib-production-eba3.up.railway.app/"

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 88
    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->unregisterSystemBackCallback()V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/adib/maintenance/WebPhotoChooser;->close()V

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    :cond_1
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 0

    .line 84
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->setIntent(Landroid/content/Intent;)V

    invoke-direct {p0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->handleLaunchIntent(Landroid/content/Intent;)V

    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 83
    iget-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->receiverRegistered:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->workReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/OnlineMainActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->receiverRegistered:Z

    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected onResume()V
    .locals 3

    .line 82
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->receiverRegistered:Z

    if-nez v0, :cond_1

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.adib.maintenance.WORK_TIMER_PENDING_EVENT"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->workReceiver:Landroid/content/BroadcastReceiver;

    const/4 v2, 0x4

    invoke-virtual {p0, v1, v0, v2}, Lcom/adib/maintenance/OnlineMainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/adib/maintenance/OnlineMainActivity;->workReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/adib/maintenance/OnlineMainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    :goto_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->receiverRegistered:Z

    :cond_1
    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->resumeWaitingTimer()V

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startSync(Landroid/content/Context;)V

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->maybeStartPending(Landroid/content/Context;)V

    invoke-direct {p0}, Lcom/adib/maintenance/OnlineMainActivity;->refreshWorkState()V

    invoke-static {p0}, Lcom/adib/maintenance/AdibWidgetData;->updateAll(Landroid/content/Context;)V

    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1

    .line 86
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->web:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->saveState(Landroid/os/Bundle;)Landroid/webkit/WebBackForwardList;

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity;->photoChooser:Lcom/adib/maintenance/WebPhotoChooser;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Lcom/adib/maintenance/WebPhotoChooser;->save(Landroid/os/Bundle;)V

    :cond_1
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
