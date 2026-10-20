.class public final Lcom/adib/maintenance/AdibFloatingTimerService;
.super Landroid/app/Service;
.source "AdibFloatingTimerService.java"


# static fields
.field public static final ACTION_CONFIRMED_LIST:Ljava/lang/String; = "com.adib.maintenance.POMODORO_CONFIRMED_LIST"

.field public static final ACTION_DISABLE_SYNC:Ljava/lang/String; = "com.adib.maintenance.POMODORO_SYNC_DISABLE"

.field public static final ACTION_HIDE:Ljava/lang/String; = "com.adib.maintenance.FLOAT_TIMER_HIDE"

.field public static final ACTION_OPEN_TASK:Ljava/lang/String; = "com.adib.maintenance.FLOAT_TIMER_OPEN_TASK"

.field public static final ACTION_PERMISSION:Ljava/lang/String; = "com.adib.maintenance.FLOAT_TIMER_PERMISSION"

.field public static final ACTION_SHOW:Ljava/lang/String; = "com.adib.maintenance.FLOAT_TIMER_SHOW"

.field public static final ACTION_SYNC:Ljava/lang/String; = "com.adib.maintenance.POMODORO_SYNC"

.field private static final CHANNEL:Ljava/lang/String; = "adib_pomodoro_overlay"

.field private static final COMMENTS_IO:Ljava/util/concurrent/ExecutorService;

.field private static final FINISH_CHANNEL:Ljava/lang/String; = "adib_pomodoro_finished"

.field private static final IO:Ljava/util/concurrent/ExecutorService;

.field static final PREFS:Ljava/lang/String; = "adib_floating_timer"

.field private static focusScreenVisible:Z

.field private static liveService:Lcom/adib/maintenance/AdibFloatingTimerService;


# instance fields
.field private clock:Landroid/widget/TextView;

.field private final commentPoll:Ljava/lang/Runnable;

.field private destroyed:Z

.field private duration:I

.field private endAt:J

.field private globalTimer:Z

.field private final handler:Landroid/os/Handler;

.field private label:Ljava/lang/String;

.field private miniMode:Z

.field private mode:Ljava/lang/String;

.field private overlay:Landroid/view/View;

.field private params:Landroid/view/WindowManager$LayoutParams;

.field private pauseButton:Landroid/widget/TextView;

.field private remainingMs:J

.field private final remotePoll:Ljava/lang/Runnable;

.field private running:Z

.field private syncMonitoring:Z

.field private taskId:Ljava/lang/String;

.field private final tick:Ljava/lang/Runnable;

.field private title:Landroid/widget/TextView;

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method public static synthetic $r8$lambda$-GdN9QOr2UROLJArU8kLPaEWw1s(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$00OZhcZ2e0VCbGoRtxUu1MX_PeU(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/content/SharedPreferences;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$postPomodoro$9(Landroid/content/SharedPreferences;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$6TPRSBoGmIKG1qd-sTjXuZ40Lec(Lcom/adib/maintenance/AdibFloatingTimerService;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$postPomodoro$10(Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$CvwyZGEAFGhL7bB6gT8GrHU9jsw(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$5(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$KZbCfx_dNBMAoKYwAdKTjFGFp-o(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$4(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$We60Z85TpNeOCXbdZl8XGW4slck(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$6(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$YuZGS6yYUOxEgO-8JsFb6-XqaM0(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$1(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$o9AMoRkQV-Ld3r-cWzpQVQi6JPQ(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showOverlay$3(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ouvgPyD2HSvHF5J-vQl0bu-0Fzc(Lcom/adib/maintenance/AdibFloatingTimerService;[F[I[ZILandroid/widget/LinearLayout;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$showMiniOverlay$7([F[I[ZILandroid/widget/LinearLayout;Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$t9GA-M5CKK0xsq5atT91ftPa_es(Lcom/adib/maintenance/AdibFloatingTimerService;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lcom/adib/maintenance/AdibFloatingTimerService;->lambda$postPomodoro$11(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgetcommentPoll(Lcom/adib/maintenance/AdibFloatingTimerService;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->commentPoll:Ljava/lang/Runnable;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetdestroyed(Lcom/adib/maintenance/AdibFloatingTimerService;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetendAt(Lcom/adib/maintenance/AdibFloatingTimerService;)J
    .locals 2

    iget-wide v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$fgethandler(Lcom/adib/maintenance/AdibFloatingTimerService;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetparams(Lcom/adib/maintenance/AdibFloatingTimerService;)Landroid/view/WindowManager$LayoutParams;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetremainingMs(Lcom/adib/maintenance/AdibFloatingTimerService;)J
    .locals 2

    iget-wide v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$fgetremotePoll(Lcom/adib/maintenance/AdibFloatingTimerService;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetrunning(Lcom/adib/maintenance/AdibFloatingTimerService;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetsyncMonitoring(Lcom/adib/maintenance/AdibFloatingTimerService;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetwindowManager(Lcom/adib/maintenance/AdibFloatingTimerService;)Landroid/view/WindowManager;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputremainingMs(Lcom/adib/maintenance/AdibFloatingTimerService;J)V
    .locals 0

    iput-wide p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    return-void
.end method

.method static bridge synthetic -$$Nest$fputsyncMonitoring(Lcom/adib/maintenance/AdibFloatingTimerService;Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$mcompleteTimer(Lcom/adib/maintenance/AdibFloatingTimerService;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->completeTimer()V

    return-void
.end method

.method static bridge synthetic -$$Nest$mupdateClock(Lcom/adib/maintenance/AdibFloatingTimerService;J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/AdibFloatingTimerService;->updateClock(J)V

    return-void
.end method

.method static bridge synthetic -$$Nest$sfgetCOMMENTS_IO()Ljava/util/concurrent/ExecutorService;
    .locals 1

    sget-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->COMMENTS_IO:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetIO()Ljava/util/concurrent/ExecutorService;
    .locals 1

    sget-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->IO:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smreadJson(Ljava/io/InputStream;)Lorg/json/JSONObject;
    .locals 0

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->readJson(Ljava/io/InputStream;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smsetWebSession(Ljava/net/HttpURLConnection;)V
    .locals 0

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->setWebSession(Ljava/net/HttpURLConnection;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 47
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->IO:Ljava/util/concurrent/ExecutorService;

    .line 61
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->COMMENTS_IO:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 39
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 48
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    .line 54
    const-string v0, ""

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    const-string v0, "work"

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    const-string v0, "Pomodoro"

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    const/16 v0, 0x19

    .line 55
    iput v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    const/4 v0, 0x0

    .line 56
    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    .line 59
    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$1;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$1;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    .line 62
    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$2;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$2;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->commentPoll:Ljava/lang/Runnable;

    .line 69
    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$3;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$3;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    return-void
.end method

.method static applyConfirmedListTimer(Landroid/content/Context;Lorg/json/JSONObject;)V
    .locals 2

    .line 63
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.POMODORO_CONFIRMED_LIST"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "confirmed_json"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string p1, "ADIB"

    const-string v0, "Confirmed Pomodoro overlay could not start"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private buildNotification()Landroid/app/Notification;
    .locals 7

    .line 114
    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "active"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    new-instance v2, Landroid/content/Intent;

    const-class v3, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v3, 0x14000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v2

    if-eqz v0, :cond_0

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "com.adib.maintenance.FLOAT_TIMER_PERMISSION"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_0
    if-eqz v0, :cond_1

    iget-boolean v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "com.adib.maintenance.WIDGET_TASK"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "widget_id"

    iget-object v4, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    :goto_0
    const/16 v3, 0x100c

    const/high16 v4, 0xc000000

    invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x1a

    if-lt v3, v5, :cond_2

    new-instance v3, Landroid/app/Notification$Builder;

    const-string v5, "adib_pomodoro_overlay"

    invoke-direct {v3, p0, v5}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    new-instance v3, Landroid/app/Notification$Builder;

    invoke-direct {v3, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    :goto_1
    sget v5, Lcom/adib/maintenance/R$drawable;->ic_adib:I

    invoke-virtual {v3, v5}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v5

    if-eqz v0, :cond_3

    const-string v6, "ADIB \u00b7 Pomodoro"

    goto :goto_2

    :cond_3
    const-string v6, "ADIB \u00b7 Pomodoro sinxronizasiyas\u0131"

    :goto_2
    invoke-virtual {v5, v6}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v5

    if-eqz v0, :cond_6

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_4

    const-string v0, "\u00dcz\u0259n p\u0259nc\u0259r\u0259y\u0259 icaz\u0259 verm\u0259k \u00fc\u00e7\u00fcn toxunun"

    goto :goto_4

    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v6, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v6, :cond_5

    const-string v6, "Taymer i\u015fl\u0259yir: "

    goto :goto_3

    :cond_5
    const-string v6, "Haz\u0131r / fasil\u0259d\u0259: "

    :goto_3
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_6
    const-string v0, "Telefon v\u0259 ya komp\u00fcterd\u0259n taymer g\u00f6zl\u0259nilir"

    :goto_4
    invoke-virtual {v5, v0}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v0, :cond_7

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.POMODORO_SYNC_DISABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const/16 v1, 0x1010

    invoke-static {p0, v1, v0, v4}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    new-instance v1, Landroid/app/Notification$Action$Builder;

    const/4 v2, 0x0

    const-string v4, "Sinxronizasiyan\u0131 s\u00f6nd\u00fcr"

    invoke-direct {v1, v2, v4, v0}, Landroid/app/Notification$Action$Builder;-><init>(Landroid/graphics/drawable/Icon;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    invoke-virtual {v1}, Landroid/app/Notification$Action$Builder;->build()Landroid/app/Notification$Action;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    :cond_7
    invoke-virtual {v3}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method private completeTimer()V
    .locals 9

    .line 184
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "active"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "running"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "stopped"

    const/4 v3, 0x1

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "remainingMs"

    const-wide/16 v4, 0x0

    invoke-interface {v0, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v2, "finish"

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    iget-object v6, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    const-string v7, "break"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    const-string v6, "break-finish"

    goto :goto_0

    :cond_0
    move-object v6, v2

    :goto_0
    iget-object v7, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    iget v8, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    invoke-direct {p0, v0, v6, v7, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_1
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    if-eqz v0, :cond_2

    invoke-static {p0, v2, v4, v5}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncGlobal(Landroid/content/Context;Ljava/lang/String;J)V

    invoke-static {p0}, Lcom/adib/maintenance/AdibWidgetData;->cancelPomodoroTick(Landroid/content/Context;)V

    const-string v0, "adib_widget_data"

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pomodoro_stopped"

    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pomodoro_end"

    invoke-interface {v0, v1, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pomodoro_remaining"

    invoke-interface {v0, v1, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string v0, "pomodoro"

    invoke-static {p0, v0}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    :cond_2
    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->postCompletionNotification()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->hideOverlay()V

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v0, :cond_3

    const/16 v0, 0x100c

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    return-void

    :cond_3
    invoke-virtual {p0, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return-void
.end method

.method private createNotificationChannel()V
    .locals 6

    .line 113
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_1

    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "adib_pomodoro_overlay"

    const-string v3, "Aktiv Pomodoro"

    const/4 v4, 0x2

    invoke-direct {v1, v2, v3, v4}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const-string v2, "Aktiv taymerin \u00fcz\u0259n p\u0259nc\u0259r\u0259sini d\u0259st\u0259kl\u0259yir"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "adib_pomodoro_finished"

    const-string v3, "Pomodoronun bitm\u0259si"

    const/4 v5, 0x4

    invoke-direct {v1, v2, v3, v5}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const-string v2, "Taymer bitdikd\u0259 s\u0259sli bildiri\u015f"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    new-array v2, v5, [J

    fill-array-data v2, :array_0

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V

    invoke-static {v4}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v2

    new-instance v3, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v3}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v4, 0x5

    invoke-virtual {v3, v4}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v3

    invoke-virtual {v3, v5}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_1
    :goto_0
    return-void

    nop

    :array_0
    .array-data 8
        0x0
        0xfa
        0x96
        0xfa
    .end array-data
.end method

.method private dp(F)I
    .locals 1

    .line 116
    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p1, v0

    float-to-int p1, p1

    return p1
.end method

.method static focusVisibilityChanged(Z)V
    .locals 7

    .line 44
    sput-boolean p0, Lcom/adib/maintenance/AdibFloatingTimerService;->focusScreenVisible:Z

    sget-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->liveService:Lcom/adib/maintenance/AdibFloatingTimerService;

    if-eqz v0, :cond_4

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    if-eqz v1, :cond_0

    goto/16 :goto_0

    :cond_0
    if-eqz p0, :cond_1

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    return-void

    :cond_1
    const-string p0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v2, "active"

    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v2, "stopped"

    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_0

    :cond_2
    const-string v2, "running"

    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const-string v2, "endAt"

    const-wide/16 v3, 0x0

    invoke-interface {p0, v2, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    const-string v2, "remainingMs"

    invoke-interface {p0, v2, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    iput-wide v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    const-string v2, "taskId"

    const-string v3, ""

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    const-string v2, "label"

    const-string v3, "Pomodoro"

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    const-string v2, "mode"

    const-string v3, "work"

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    const-string v2, "duration"

    const/16 v3, 0x19

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    const-string v2, "global"

    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v2, "mini"

    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    iput-boolean p0, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    iget-boolean p0, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz p0, :cond_3

    iget-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    cmp-long p0, v1, v3

    if-gtz p0, :cond_3

    iget-object p0, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {p0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p0, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_3
    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result p0

    if-eqz p0, :cond_4

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->showOverlay()V

    :cond_4
    :goto_0
    return-void
.end method

.method public static hide(Landroid/content/Context;)V
    .locals 5

    .line 98
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "taskId"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "|"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "session_id"

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "shared_key"

    invoke-interface {v0, v3, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "shared_visibility_id"

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/adib/maintenance/SharedPomodoroState;->dismiss(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "pending"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "needs_overlay_permission"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "notification_permission_pending"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "active"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "running"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncEnabled(Landroid/content/Context;)Z

    move-result v0

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.FLOAT_TIMER_HIDE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    return-void
.end method

.method private hideOverlay()V
    .locals 2

    .line 187
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    return-void
.end method

.method static synthetic lambda$postCompletionNotification$8(Landroid/app/NotificationChannel;)Z
    .locals 1

    .line 167
    const-string v0, "adib_pomodoro_finished"

    invoke-virtual {p0}, Landroid/app/NotificationChannel;->getId()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method private synthetic lambda$postPomodoro$10(Lorg/json/JSONObject;)V
    .locals 5

    .line 190
    const-string v0, "serverNow"

    const-string v1, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "local_mutation_until"

    const-wide/16 v3, 0x0

    invoke-interface {v1, v2, v3, v4}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-boolean v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    if-nez v1, :cond_0

    const-string v1, "timer"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    if-eqz v2, :cond_0

    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v3

    invoke-virtual {v2, v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "timers"

    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {v3, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {v0, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->applySharedSnapshot(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private synthetic lambda$postPomodoro$11(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 26

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move/from16 v4, p4

    move-object/from16 v5, p5

    .line 190
    :try_start_0
    invoke-static {v1}, Lcom/adib/maintenance/DirectRuntime;->init(Landroid/content/Context;)V

    invoke-static {}, Lcom/adib/maintenance/DirectRuntime;->enabled()Z

    move-result v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    const-string v9, "expectedVisibilityId"

    const-string v10, "hide"

    const-string v11, "sessionId"

    move/from16 v16, v8

    const-wide/16 v17, 0x3e8

    const-string v12, "POST"

    const-string v13, "remainingSeconds"

    const-wide/16 v19, 0x3e7

    const-string v14, "duration"

    const-string v15, "/api/personal-pomodoro"

    const-string v7, "mode"

    const-string v8, "action"

    move-object/from16 v21, v12

    const-string v12, "id"

    move-object/from16 v22, v15

    const-string v15, "adib_floating_timer"

    const/4 v6, 0x0

    move-object/from16 v23, v9

    const/4 v9, 0x1

    if-eqz v16, :cond_1

    :try_start_1
    invoke-virtual {v1, v15, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v6

    new-instance v15, Lorg/json/JSONObject;

    invoke-direct {v15}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v15, v12, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, v8, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, v7, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {v9, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v0, v14, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object v0

    iget-wide v3, v1, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    add-long v3, v3, v19

    div-long v3, v3, v17

    const-wide/16 v7, 0x0

    invoke-static {v7, v8, v3, v4}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    invoke-virtual {v0, v13, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, v11, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v10, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    move-object/from16 v2, p6

    move-object/from16 v3, v23

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    move-object/from16 v2, v21

    move-object/from16 v3, v22

    invoke-static {v2, v3, v0}, Lcom/adib/maintenance/DirectRuntime;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    iget-object v2, v1, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    new-instance v3, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda9;

    invoke-direct {v3, v1, v6, v0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda9;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/content/SharedPreferences;Lorg/json/JSONObject;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_1
    move/from16 v16, v9

    move-object/from16 v9, v21

    move-object/from16 v25, v22

    move-object/from16 v24, v23

    const-string v6, "https://adib-production-eba3.up.railway.app/"

    move-object/from16 v22, v10

    const-string v10, "/"

    invoke-virtual {v6, v10}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v23

    add-int/lit8 v5, v23, -0x1

    move-object/from16 v23, v11

    const/4 v11, 0x0

    invoke-virtual {v6, v11, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v6, v25

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_0

    :cond_2
    move-object/from16 v23, v11

    const-string v5, "https://adib-production-eba3.up.railway.app//api/personal-pomodoro"

    :goto_0
    new-instance v6, Ljava/net/URL;

    invoke-direct {v6, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v5

    check-cast v5, Ljava/net/HttpURLConnection;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_5

    :try_start_2
    invoke-virtual {v5, v9}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/16 v6, 0x1b58

    invoke-virtual {v5, v6}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    const/16 v6, 0x2ee0

    invoke-virtual {v5, v6}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    move/from16 v6, v16

    invoke-virtual {v5, v6}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    const-string v6, "Content-Type"

    const-string v9, "application/json; charset=utf-8"

    invoke-virtual {v5, v6, v9}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v5}, Lcom/adib/maintenance/AdibFloatingTimerService;->setWebSession(Ljava/net/HttpURLConnection;)V

    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v6, v12, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v6, v8, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v6, v7, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const/4 v0, 0x1

    invoke-static {v0, v4}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {v6, v14, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const/4 v11, 0x0

    invoke-virtual {v1, v15, v11}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "local_mutation_until"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    const-wide/16 v9, 0x3a98

    add-long/2addr v7, v9

    invoke-interface {v0, v3, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-wide v3, v1, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    add-long v3, v3, v19

    div-long v3, v3, v17

    const-wide/16 v7, 0x0

    invoke-static {v7, v8, v3, v4}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    invoke-virtual {v6, v13, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-object/from16 v0, p5

    move-object/from16 v3, v23

    invoke-virtual {v6, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-object/from16 v0, v22

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    move-object/from16 v2, p6

    move-object/from16 v3, v24

    invoke-virtual {v6, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_3
    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    :try_start_3
    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/io/OutputStream;->write([B)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-eqz v2, :cond_4

    :try_start_4
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    :cond_4
    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0

    const/16 v2, 0xc8

    if-ne v0, v2, :cond_6

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    :try_start_5
    invoke-static {v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->readJson(Ljava/io/InputStream;)Lorg/json/JSONObject;

    move-result-object v0

    iget-object v3, v1, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    new-instance v4, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda10;

    invoke-direct {v4, v1, v0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda10;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;Lorg/json/JSONObject;)V

    invoke-virtual {v3, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v2, :cond_6

    :try_start_6
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    goto :goto_2

    :catchall_0
    move-exception v0

    move-object v3, v0

    if-eqz v2, :cond_5

    :try_start_7
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    :try_start_8
    invoke-virtual {v3, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_5
    :goto_1
    throw v3
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    :cond_6
    :goto_2
    if-eqz v5, :cond_9

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->disconnect()V

    return-void

    :catchall_2
    move-exception v0

    move-object v3, v0

    if-eqz v2, :cond_7

    :try_start_9
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception v0

    :try_start_a
    invoke-virtual {v3, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_7
    :goto_3
    throw v3
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_0
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    :catchall_4
    move-exception v0

    move-object v7, v5

    goto :goto_4

    :catch_0
    move-object v7, v5

    goto :goto_5

    :catchall_5
    move-exception v0

    const/4 v7, 0x0

    :goto_4
    if-eqz v7, :cond_8

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_8
    throw v0

    :catch_1
    const/4 v7, 0x0

    :goto_5
    if-eqz v7, :cond_9

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_9
    return-void
.end method

.method private synthetic lambda$postPomodoro$9(Landroid/content/SharedPreferences;Lorg/json/JSONObject;)V
    .locals 4

    .line 190
    const-string v0, "serverNow"

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v1, "local_mutation_until"

    const-wide/16 v2, 0x0

    invoke-interface {p1, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    if-nez p1, :cond_0

    const-string p1, "timer"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "timers"

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {v2, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->applySharedSnapshot(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private synthetic lambda$showMiniOverlay$7([F[I[ZILandroid/widget/LinearLayout;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 6

    .line 142
    invoke-virtual {p7}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result p6

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p6, :cond_5

    if-eq p6, v0, :cond_3

    const/4 v2, 0x2

    if-eq p6, v2, :cond_0

    return v0

    :cond_0
    invoke-virtual {p7}, Landroid/view/MotionEvent;->getRawX()F

    move-result p6

    aget v2, p1, v1

    sub-float/2addr p6, v2

    invoke-virtual {p7}, Landroid/view/MotionEvent;->getRawY()F

    move-result p7

    aget p1, p1, v0

    sub-float/2addr p7, p1

    float-to-double v2, p6

    float-to-double v4, p7

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v2

    int-to-double v4, p4

    cmpl-double p1, v2, v4

    if-lez p1, :cond_1

    aput-boolean v0, p3, v1

    :cond_1
    aget-boolean p1, p3, v1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    aget p3, p2, v1

    float-to-int p4, p6

    add-int/2addr p3, p4

    iput p3, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    aget p2, p2, v0

    float-to-int p3, p7

    add-int/2addr p2, p3

    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    :try_start_0
    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    iget-object p2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {p1, p5, p2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return v0

    :cond_3
    aget-boolean p1, p3, v1

    if-nez p1, :cond_4

    iput-boolean v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    const-string p1, "adib_floating_timer"

    invoke-virtual {p0, p1, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "mini"

    invoke-interface {p1, p2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->showOverlay()V

    :cond_4
    return v0

    :cond_5
    invoke-virtual {p7}, Landroid/view/MotionEvent;->getRawX()F

    move-result p4

    aput p4, p1, v1

    invoke-virtual {p7}, Landroid/view/MotionEvent;->getRawY()F

    move-result p4

    aput p4, p1, v0

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    aput p1, p2, v1

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    aput p1, p2, v0

    aput-boolean v1, p3, v1

    return v0
.end method

.method private synthetic lambda$showOverlay$1(Landroid/view/View;)V
    .locals 0

    .line 127
    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->toggleFromIsland()V

    return-void
.end method

.method private synthetic lambda$showOverlay$2(Landroid/view/View;)V
    .locals 0

    .line 128
    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopFromIsland()V

    return-void
.end method

.method private synthetic lambda$showOverlay$3(Landroid/view/View;)V
    .locals 0

    .line 129
    invoke-static {p0}, Lcom/adib/maintenance/PomodoroFocusActivity;->floatingIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private synthetic lambda$showOverlay$4(Landroid/view/View;)V
    .locals 2

    const/4 p1, 0x1

    .line 130
    iput-boolean p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mini"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->showOverlay()V

    return-void
.end method

.method private synthetic lambda$showOverlay$5(Landroid/view/View;)V
    .locals 0

    .line 131
    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->dismissOverlay()V

    return-void
.end method

.method private synthetic lambda$showOverlay$6(Landroid/view/View;)V
    .locals 2

    .line 132
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/adib/maintenance/MainActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v0, 0x34000000

    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object p1

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "com.adib.maintenance.WIDGET_TASK"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v0, "widget_id"

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic lambda$syncGlobal$0(Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Landroid/content/SharedPreferences;)V
    .locals 24

    move-object/from16 v0, p1

    move-object/from16 v1, p4

    .line 67
    const-string v2, "local_mutation_until"

    :try_start_0
    invoke-static/range {p0 .. p0}, Lcom/adib/maintenance/DirectRuntime;->init(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_7
    .catchall {:try_start_0 .. :try_end_0} :catchall_8

    :try_start_1
    invoke-static {}, Lcom/adib/maintenance/DirectRuntime;->enabled()Z

    move-result v6
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_8

    const-string v7, "session_id"

    const-string v8, "timer"

    const-string v9, "POST"

    const-string v14, "remainingSeconds"

    const-string v5, "duration"

    const-wide/16 v16, 0x3e8

    const-string v10, "/api/personal-pomodoro"

    const-string v11, "work"

    const-wide/16 v18, 0x3e7

    const-string v12, "mode"

    const-string v13, "action"

    const-string v3, "00000000-0000-4000-8000-000000000001"

    const-string v4, "id"

    const-string v15, "sessionId"

    if-eqz v6, :cond_2

    :try_start_2
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v6, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3, v13, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v3

    const/16 v4, 0x19

    invoke-virtual {v3, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object v3

    add-long v4, p2, v18

    div-long v4, v4, v16
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_6
    .catchall {:try_start_2 .. :try_end_2} :catchall_8

    const-wide/16 v11, 0x0

    :try_start_3
    invoke-static {v11, v12, v4, v5}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v4
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_8

    :try_start_4
    invoke-virtual {v3, v14, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3, v15, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v3, "hide"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "expectedVisibilityId"

    move-object/from16 v3, p5

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    invoke-static {v9, v10, v1}, Lcom/adib/maintenance/DirectRuntime;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-virtual {v0, v15}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v7, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_6
    .catchall {:try_start_4 .. :try_end_4} :catchall_8

    :cond_1
    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-wide/16 v11, 0x0

    invoke-interface {v0, v2, v11, v12}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void

    :catch_0
    move-object v3, v2

    goto/16 :goto_a

    :cond_2
    :try_start_5
    const-string v6, "https://adib-production-eba3.up.railway.app/"
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_6
    .catchall {:try_start_5 .. :try_end_5} :catchall_8

    move-object/from16 v20, v2

    :try_start_6
    new-instance v2, Ljava/net/URL;

    move-object/from16 v21, v7

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v22, v8

    const-string v8, "/"

    invoke-virtual {v6, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    move/from16 p5, v8

    if-eqz p5, :cond_3

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v23

    const/16 p5, 0x1

    add-int/lit8 v8, v23, -0x1

    const/4 v1, 0x0

    invoke-virtual {v6, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    :cond_3
    const/16 p5, 0x1

    :goto_0
    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5
    .catchall {:try_start_6 .. :try_end_6} :catchall_7

    :try_start_7
    invoke-virtual {v1, v9}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/16 v2, 0x1b58

    invoke-virtual {v1, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    const/16 v2, 0x2ee0

    invoke-virtual {v1, v2}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    move/from16 v2, p5

    invoke-virtual {v1, v2}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    const-string v2, "Content-Type"

    const-string v6, "application/json"

    invoke-virtual {v1, v2, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->setWebSession(Ljava/net/HttpURLConnection;)V

    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {v2, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v2, v13, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const/16 v4, 0x19

    invoke-virtual {v0, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object v0

    add-long v2, p2, v18

    div-long v2, v2, v16
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_6

    const-wide/16 v11, 0x0

    :try_start_8
    invoke-static {v11, v12, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_6

    :try_start_9
    invoke-virtual {v0, v14, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v0

    move-object/from16 v2, p4

    invoke-virtual {v0, v15, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_6

    :try_start_a
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/io/OutputStream;->write([B)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    if-eqz v2, :cond_4

    :try_start_b
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_1
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    move-object v5, v1

    move-object/from16 v3, v20

    goto/16 :goto_9

    :catch_1
    move-object v5, v1

    move-object/from16 v3, v20

    goto/16 :goto_7

    :cond_4
    :goto_1
    :try_start_c
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_3
    .catchall {:try_start_c .. :try_end_c} :catchall_6

    const/16 v2, 0xc8

    if-ne v0, v2, :cond_7

    :try_start_d
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_1
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    :try_start_e
    invoke-static {v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->readJson(Ljava/io/InputStream;)Lorg/json/JSONObject;

    move-result-object v0

    move-object/from16 v3, v22

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-virtual {v0, v15}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object/from16 v4, v21

    invoke-interface {v3, v4, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_1

    :cond_5
    if-eqz v2, :cond_7

    :try_start_f
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_1
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    goto :goto_3

    :catchall_1
    move-exception v0

    move-object v3, v0

    if-eqz v2, :cond_6

    :try_start_10
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_2

    goto :goto_2

    :catchall_2
    move-exception v0

    :try_start_11
    invoke-virtual {v3, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_6
    :goto_2
    throw v3
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_1
    .catchall {:try_start_11 .. :try_end_11} :catchall_0

    :cond_7
    :goto_3
    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    move-object/from16 v3, v20

    const-wide/16 v11, 0x0

    invoke-interface {v0, v3, v11, v12}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    if-eqz v1, :cond_a

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    return-void

    :catchall_3
    move-exception v0

    move-object/from16 v3, v20

    move-object v4, v0

    if-eqz v2, :cond_8

    :try_start_12
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_4

    goto :goto_4

    :catchall_4
    move-exception v0

    :try_start_13
    invoke-virtual {v4, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_8
    :goto_4
    throw v4
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_4
    .catchall {:try_start_13 .. :try_end_13} :catchall_5

    :catchall_5
    move-exception v0

    goto :goto_5

    :catch_2
    move-object/from16 v3, v20

    move-object v5, v1

    goto :goto_b

    :catchall_6
    move-exception v0

    move-object/from16 v3, v20

    :goto_5
    move-object v5, v1

    goto :goto_9

    :catch_3
    move-object/from16 v3, v20

    :catch_4
    move-object v5, v1

    goto :goto_7

    :catchall_7
    move-exception v0

    move-object/from16 v3, v20

    goto :goto_8

    :catch_5
    move-object/from16 v3, v20

    goto :goto_6

    :catch_6
    move-object v3, v2

    :goto_6
    const/4 v5, 0x0

    :goto_7
    const-wide/16 v11, 0x0

    goto :goto_b

    :catchall_8
    move-exception v0

    move-object v3, v2

    :goto_8
    const/4 v5, 0x0

    :goto_9
    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-wide/16 v11, 0x0

    invoke-interface {v1, v3, v11, v12}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    if-eqz v5, :cond_9

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_9
    throw v0

    :catch_7
    move-object v3, v2

    const-wide/16 v11, 0x0

    :goto_a
    const/4 v5, 0x0

    :goto_b
    invoke-interface/range {p6 .. p6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v3, v11, v12}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    if-eqz v5, :cond_a

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_a
    return-void
.end method

.method static markNotificationPermissionPending(Landroid/content/Context;)V
    .locals 2

    .line 87
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v0, "notification_permission_pending"

    const/4 v1, 0x1

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method static maybeStartPending(Landroid/content/Context;)V
    .locals 4

    .line 86
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "needs_overlay_permission"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startStored(Landroid/content/Context;)V

    :cond_1
    :goto_0
    return-void
.end method

.method static notifyTimerFinished(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 183
    invoke-static/range {p0 .. p5}, Lcom/adib/maintenance/AdibFloatingTimerService;->postCompletionNotification(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static openForTask(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    .line 66
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    if-nez p1, :cond_0

    const-string p1, ""

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "com.adib.maintenance.POMODORO_SYNC"

    goto :goto_0

    :cond_1
    const-string v1, "com.adib.maintenance.FLOAT_TIMER_OPEN_TASK"

    :goto_0
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "taskId"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_2

    invoke-virtual {p0, p1}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_2
    invoke-virtual {p0, p1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string p1, "ADIB"

    const-string v0, "Pomodoro overlay could not open"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method static openNotificationPermissionPrompt(Landroid/content/Context;)V
    .locals 3

    .line 89
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_1

    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "notification_permission_pending"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.TIMER_NOTIFICATION_PERMISSION"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const/high16 v1, 0x34000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private overlayButton(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;
    .locals 1

    .line 145
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 p1, -0x1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 p1, 0x41800000    # 16.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 p1, 0x11

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setGravity(I)V

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    return-object v0
.end method

.method private postCompletionNotification()V
    .locals 6

    .line 158
    iget-wide v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    iget-object v4, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    iget-object v5, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/adib/maintenance/AdibFloatingTimerService;->postCompletionNotification(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static postCompletionNotification(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    .line 160
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    .line 161
    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-wide/16 v1, 0x0

    cmp-long v3, p1, v1

    .line 162
    const-string v4, "notified_end_at"

    if-lez v3, :cond_0

    invoke-interface {v0, v4, v1, v2}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v1

    cmp-long v1, v1, p1

    if-nez v1, :cond_0

    goto/16 :goto_2

    :cond_0
    if-lez v3, :cond_1

    .line 163
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 165
    :cond_1
    :try_start_0
    const-string p1, "notification"

    invoke-virtual {p0, p1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    if-nez p1, :cond_2

    goto/16 :goto_2

    .line 167
    :cond_2
    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    const-string v0, "adib_pomodoro_finished"

    const/16 v1, 0x1a

    const/4 v2, 0x1

    if-lt p2, v1, :cond_3

    :try_start_1
    invoke-virtual {p1}, Landroid/app/NotificationManager;->getNotificationChannels()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->stream()Ljava/util/stream/Stream;

    move-result-object p2

    new-instance v3, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda1;

    invoke-direct {v3}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda1;-><init>()V

    invoke-interface {p2, v3}, Ljava/util/stream/Stream;->anyMatch(Ljava/util/function/Predicate;)Z

    move-result p2

    if-nez p2, :cond_3

    .line 168
    new-instance p2, Landroid/app/NotificationChannel;

    const-string v3, "Pomodoronun bitm\u0259si"

    const/4 v4, 0x4

    invoke-direct {p2, v0, v3, v4}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 169
    const-string v3, "Taymer bitdikd\u0259 s\u0259sli bildiri\u015f"

    invoke-virtual {p2, v3}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 170
    invoke-virtual {p2, v2}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    new-array v3, v4, [J

    fill-array-data v3, :array_0

    invoke-virtual {p2, v3}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V

    const/4 v3, 0x2

    .line 171
    invoke-static {v3}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v3

    new-instance v5, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v5}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v6, 0x5

    invoke-virtual {v5, v6}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v5

    invoke-virtual {v5, v4}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v4

    invoke-virtual {p2, v3, v4}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    .line 172
    invoke-virtual {p1, p2}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 174
    :cond_3
    new-instance p2, Landroid/content/Intent;

    const-class v3, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {p2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v3, 0x34000000

    invoke-virtual {p2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object p2

    if-eqz p3, :cond_4

    .line 175
    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "00000000-0000-4000-8000-000000000001"

    invoke-virtual {v3, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "com.adib.maintenance.WIDGET_TASK"

    invoke-virtual {p2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "widget_id"

    invoke-virtual {p2, v3, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_4
    const/16 p3, 0x100d

    const/high16 v3, 0xc000000

    .line 176
    invoke-static {p0, p3, p2, v3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p2

    .line 177
    const-string p3, "break"

    invoke-virtual {p3, p5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_5

    const-string p3, "Fasil\u0259 bitdi"

    goto :goto_0

    :cond_5
    const-string p3, "Pomodoro bitdi"

    .line 178
    :goto_0
    sget p5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p5, v1, :cond_6

    new-instance p5, Landroid/app/Notification$Builder;

    invoke-direct {p5, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    :cond_6
    new-instance p5, Landroid/app/Notification$Builder;

    invoke-direct {p5, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 179
    :goto_1
    sget p0, Lcom/adib/maintenance/R$drawable;->ic_adib:I

    invoke-virtual {p5, p0}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0, p3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object p0

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    if-nez p4, :cond_7

    const-string p4, "Pomodoro"

    :cond_7
    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, " \u00b7 vaxt bitdi"

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p0, p3}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0, p2}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object p0

    const-string p2, "alarm"

    invoke-virtual {p0, p2}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0, v2}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0, v2}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0, v2}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    move-result-object p0

    const-wide/16 p2, 0x4e20

    invoke-virtual {p0, p2, p3}, Landroid/app/Notification$Builder;->setTimeoutAfter(J)Landroid/app/Notification$Builder;

    move-result-object p0

    invoke-virtual {p0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p0

    const/16 p2, 0x100e

    .line 180
    invoke-virtual {p1, p2, p0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :goto_2
    return-void

    nop

    :array_0
    .array-data 8
        0x0
        0xfa
        0x96
        0xfa
    .end array-data
.end method

.method private postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 9

    .line 190
    const-string v0, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x3a98

    add-long/2addr v4, v6

    const-string v6, "local_mutation_until"

    invoke-interface {v3, v6, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-virtual {p0, v0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    const-string v4, "session_id"

    const-string v5, ""

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "shared_visibility_id"

    invoke-interface {v0, v2, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    sget-object v8, Lcom/adib/maintenance/AdibFloatingTimerService;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda11;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v7}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda11;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    invoke-interface {v8, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private static readJson(Ljava/io/InputStream;)Lorg/json/JSONObject;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 189
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v1, 0x1000

    new-array v1, v1, [B

    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    const/high16 v3, 0x100000

    if-gt v2, v3, :cond_0

    goto :goto_0

    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Pomodoro response too large"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    new-instance p0, Lorg/json/JSONObject;

    new-instance v1, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-direct {p0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    return-object p0
.end method

.method private removeOverlayView()V
    .locals 2

    .line 186
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    :cond_0
    return-void
.end method

.method private rounded(I)Landroid/graphics/drawable/GradientDrawable;
    .locals 2

    .line 115
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 p1, 0x41a00000    # 20.0f

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result p1

    int-to-float p1, p1

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/high16 p1, 0x3f800000    # 1.0f

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result p1

    sget v1, Lcom/adib/maintenance/HybridUi;->BLUE:I

    invoke-virtual {v0, p1, v1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    return-object v0
.end method

.method static setSyncEnabled(Landroid/content/Context;Z)V
    .locals 3

    .line 68
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sync_enabled"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startSync(Landroid/content/Context;)V

    return-void

    :cond_0
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "com.adib.maintenance.POMODORO_SYNC_DISABLE"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private static setWebSession(Ljava/net/HttpURLConnection;)V
    .locals 4

    .line 188
    :try_start_0
    const-string v0, "https://adib-production-eba3.up.railway.app/"

    const-string v1, "Origin"

    const-string v2, "/$"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "Referer"

    invoke-virtual {p0, v1, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "Cookie"

    invoke-virtual {p0, v1, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private showMiniOverlay(II)V
    .locals 14

    .line 138
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v1, 0x11

    invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/high16 v2, 0x41200000    # 10.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v3

    const/high16 v4, 0x40a00000    # 5.0f

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v5

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v7

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v4

    invoke-virtual {v6, v3, v5, v7, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    const/4 v3, 0x1

    invoke-static {v3}, Lcom/adib/maintenance/HybridUi;->surface(Z)I

    move-result v4

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibFloatingTimerService;->rounded(I)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v6, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v6, v2}, Landroid/widget/LinearLayout;->setElevation(F)V

    const-string v2, "Pomodoro vaxt\u0131 \u2014 toxunaraq geni\u015fl\u0259ndirin"

    invoke-virtual {v6, v2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 139
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    invoke-static {v3}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    const/high16 v4, 0x41700000    # 15.0f

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    sget-object v4, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v2, v4, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    const-string v2, "Pomodoro vaxt\u0131"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v4, 0x42100000    # 36.0f

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v4

    const/4 v5, -0x1

    invoke-direct {v2, v5, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v7, 0x0

    .line 140
    iput-object v7, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    new-instance v8, Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x42a40000    # 82.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v9

    const/high16 v1, 0x42380000    # 46.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    const/16 v1, 0x7f6

    goto :goto_0

    :cond_0
    const/16 v1, 0x7d2

    :goto_0
    move v11, v1

    const/16 v12, 0x128

    const/4 v13, -0x3

    invoke-direct/range {v8 .. v13}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v8, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x31

    iput v1, v8, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    move/from16 v1, p2

    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    const/4 p1, 0x2

    .line 141
    new-array v2, p1, [F

    fill-array-data v2, :array_0

    filled-new-array {v0, v0}, [I

    move-result-object p1

    new-array v4, v3, [Z

    aput-boolean v0, v4, v0

    invoke-static {p0}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v5

    .line 142
    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda8;

    move-object v1, p0

    move-object v3, p1

    invoke-direct/range {v0 .. v6}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda8;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;[F[I[ZILandroid/widget/LinearLayout;)V

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 143
    iput-object v6, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    :try_start_0
    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {p1, v6, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :catch_0
    iput-object v7, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return-void

    :array_0
    .array-data 4
        0x0
        0x0
    .end array-data
.end method

.method public static showOrRequest(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;IZ)V
    .locals 9

    .line 83
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    const-string v1, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v3, "shared_key"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/adib/maintenance/SharedPomodoroState;->allow(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    const-wide/16 v7, 0x3a98

    add-long/2addr v5, v7

    const-string v3, "local_mutation_until"

    invoke-interface {v1, v3, v5, v6}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "pending"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    xor-int/lit8 v3, v0, 0x1

    const-string v5, "needs_overlay_permission"

    invoke-interface {v1, v5, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "active"

    const/4 v5, 0x1

    invoke-interface {v1, v3, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "running"

    invoke-interface {v1, v3, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "stopped"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "remainingMs"

    const-wide/16 v6, 0x0

    invoke-interface {v1, v2, v6, v7}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "endAt"

    invoke-interface {v1, v2, p1, p2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-nez p3, :cond_0

    move-object p3, v4

    :cond_0
    const-string p2, "taskId"

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-nez p4, :cond_1

    const-string p4, "Pomodoro"

    :cond_1
    const-string p2, "label"

    invoke-interface {p1, p2, p4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-nez p5, :cond_2

    const-string p5, "work"

    :cond_2
    const-string p2, "mode"

    invoke-interface {p1, p2, p5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "duration"

    invoke-static {v5, p6}, Ljava/lang/Math;->max(II)I

    move-result p3

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "global"

    move/from16 p3, p7

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    if-eqz v0, :cond_3

    .line 84
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startStored(Landroid/content/Context;)V

    return-void

    :cond_3
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startServiceNow(Landroid/content/Context;)V

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string p2, "com.adib.maintenance.FLOAT_TIMER_PERMISSION"

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    const/high16 p2, 0x34000000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private showOverlay()V
    .locals 14

    .line 118
    sget-boolean v0, Lcom/adib/maintenance/AdibFloatingTimerService;->focusScreenVisible:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void

    .line 119
    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    :goto_0
    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    const/high16 v3, 0x40800000    # 4.0f

    if-nez v2, :cond_2

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->statusBarHeight()I

    move-result v2

    invoke-direct {p0, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v4

    add-int/2addr v2, v4

    goto :goto_1

    :cond_2
    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 120
    :goto_1
    iget-object v4, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    const/4 v5, 0x0

    if-eqz v4, :cond_3

    :try_start_0
    iget-object v6, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    invoke-interface {v6, v4}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iput-object v5, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    .line 121
    :cond_3
    iget-boolean v4, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    if-eqz v4, :cond_4

    invoke-direct {p0, v0, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->showMiniOverlay(II)V

    return-void

    .line 122
    :cond_4
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v4, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v6, 0x10

    invoke-virtual {v4, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/high16 v6, 0x40e00000    # 7.0f

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    invoke-direct {p0, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v7

    const/high16 v8, 0x40a00000    # 5.0f

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {p0, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v9

    invoke-virtual {v4, v6, v7, v8, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    const/4 v6, 0x1

    invoke-static {v6}, Lcom/adib/maintenance/HybridUi;->surface(Z)I

    move-result v7

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibFloatingTimerService;->rounded(I)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v4, v7}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/high16 v7, 0x41200000    # 10.0f

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v4, v7}, Landroid/widget/LinearLayout;->setElevation(F)V

    .line 123
    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v8, "\u283f"

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {v6}, Lcom/adib/maintenance/HybridUi;->muted(Z)I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v8, 0x41700000    # 15.0f

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v8, 0x11

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setGravity(I)V

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v9, 0x41b00000    # 22.0f

    invoke-direct {p0, v9}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    const/high16 v11, 0x42280000    # 42.0f

    invoke-direct {p0, v11}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v11

    invoke-direct {v8, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    new-instance v8, Landroid/widget/LinearLayout;

    invoke-direct {v8, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v8, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    invoke-direct {p0, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v3

    const/high16 v10, 0x40400000    # 3.0f

    invoke-direct {p0, v10}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    invoke-virtual {v8, v3, v1, v10, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, -0x2

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v4, v8, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 125
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    iget-object v10, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    invoke-static {v6}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result v10

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    const/high16 v10, 0x41100000    # 9.0f

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    sget-object v10, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-virtual {v3, v10, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setMaxLines(I)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    invoke-virtual {v8, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 126
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    invoke-static {v6}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v10

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    const/high16 v10, 0x41880000    # 17.0f

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    sget-object v10, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v3, v10, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    invoke-virtual {v8, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 127
    iget-boolean v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v3, :cond_5

    const-string v3, "\u2161"

    goto :goto_2

    :cond_5
    const-string v3, "\u25b6"

    :goto_2
    const-string v6, "Fasil\u0259 ver v\u0259 ya davam et"

    invoke-direct {p0, v3, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->overlayButton(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v3

    iput-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->pauseButton:Landroid/widget/TextView;

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v8, 0x42080000    # 34.0f

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    const/high16 v12, 0x42200000    # 40.0f

    invoke-direct {p0, v12}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v13

    invoke-direct {v6, v10, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v3, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->pauseButton:Landroid/widget/TextView;

    new-instance v6, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda0;

    invoke-direct {v6, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda0;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 128
    const-string v3, "\u00d7"

    const-string v6, "Pomidoru l\u0259\u011fv et"

    invoke-direct {p0, v3, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->overlayButton(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v3

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {p0, v12}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    invoke-direct {v6, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v8, 0x40000000    # 2.0f

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    iput v8, v6, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    invoke-virtual {v4, v3, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v6, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda3;

    invoke-direct {v6, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 129
    new-instance v3, Landroid/widget/ImageButton;

    invoke-direct {v3, p0}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    sget v6, Lcom/adib/maintenance/R$drawable;->ic_focus_screen:I

    invoke-virtual {v3, v6}, Landroid/widget/ImageButton;->setImageResource(I)V

    const-string v6, "Qara ekran"

    invoke-virtual {v3, v6}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    invoke-virtual {v3, v1}, Landroid/widget/ImageButton;->setBackgroundColor(I)V

    const/high16 v1, 0x41000000    # 8.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v1

    invoke-virtual {v3, v6, v8, v10, v1}, Landroid/widget/ImageButton;->setPadding(IIII)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x42100000    # 36.0f

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    invoke-direct {p0, v12}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {v1, v6, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda4;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v3, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 130
    const-string v1, "\u2212"

    const-string v3, "Pomodoronu y\u0131\u011f\u0131\u015fd\u0131r"

    invoke-direct {p0, v1, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->overlayButton(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x41e00000    # 28.0f

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {p0, v12}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    invoke-direct {v3, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-direct {p0, v11}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    iput v8, v3, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    invoke-virtual {v4, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda5;

    invoke-direct {v3, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda5;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 131
    const-string v1, "\u00d7"

    const-string v3, "P\u0259nc\u0259r\u0259ni gizl\u0259t"

    invoke-direct {p0, v1, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->overlayButton(Ljava/lang/String;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    invoke-direct {p0, v12}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v8

    invoke-direct {v3, v6, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-direct {p0, v11}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    iput v6, v3, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    invoke-virtual {v4, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v1, v9}, Landroid/widget/TextView;->setTextSize(F)V

    new-instance v3, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda6;

    invoke-direct {v3, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda6;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 132
    new-instance v1, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda7;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;)V

    invoke-virtual {v4, v1}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 133
    new-instance v8, Landroid/view/WindowManager$LayoutParams;

    const/high16 v1, 0x43a80000    # 336.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v1

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->widthPixels:I

    const/high16 v6, 0x41400000    # 12.0f

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v6

    sub-int/2addr v3, v6

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v9

    const/high16 v1, 0x42580000    # 54.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v10

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v1, v3, :cond_6

    const/16 v1, 0x7f6

    goto :goto_3

    :cond_6
    const/16 v1, 0x7d2

    :goto_3
    move v11, v1

    const/16 v12, 0x128

    const/4 v13, -0x3

    invoke-direct/range {v8 .. v13}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v8, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x31

    iput v1, v8, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v0, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 134
    new-instance v0, Lcom/adib/maintenance/AdibFloatingTimerService$4;

    invoke-direct {v0, p0, v4}, Lcom/adib/maintenance/AdibFloatingTimerService$4;-><init>(Lcom/adib/maintenance/AdibFloatingTimerService;Landroid/widget/LinearLayout;)V

    invoke-virtual {v7, v0}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 135
    iput-object v4, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    :try_start_1
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v4, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void

    :catch_1
    iput-object v5, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return-void
.end method

.method private static startServiceNow(Landroid/content/Context;)V
    .locals 3

    .line 91
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.FLOAT_TIMER_SHOW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method private static startStored(Landroid/content/Context;)V
    .locals 3

    .line 90
    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "pending"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "needs_overlay_permission"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startServiceNow(Landroid/content/Context;)V

    return-void
.end method

.method static startSync(Landroid/content/Context;)V
    .locals 3

    .line 65
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncEnabled(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibFloatingTimerService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.POMODORO_SYNC"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_1

    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_1
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string v0, "ADIB"

    const-string v1, "Pomodoro sync could not start"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private statusBarHeight()I
    .locals 4

    .line 157
    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "dimen"

    const-string v2, "android"

    const-string v3, "status_bar_height"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    return v0

    :cond_0
    const/high16 v0, 0x41c00000    # 24.0f

    invoke-direct {p0, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->dp(F)I

    move-result v0

    return v0
.end method

.method private stopFromIsland()V
    .locals 6

    const/4 v0, 0x0

    .line 153
    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    const-string v3, "adib_floating_timer"

    invoke-virtual {p0, v3, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "active"

    invoke-interface {v3, v4, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "running"

    invoke-interface {v3, v4, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "stopped"

    const/4 v5, 0x1

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "remainingMs"

    invoke-interface {v3, v4, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "endAt"

    invoke-interface {v3, v4, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 154
    iget-boolean v3, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v4, "reset"

    if-eqz v3, :cond_0

    invoke-static {p0, v4, v1, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncGlobal(Landroid/content/Context;Ljava/lang/String;J)V

    invoke-static {p0}, Lcom/adib/maintenance/AdibWidgetData;->cancelPomodoroTick(Landroid/content/Context;)V

    const-string v3, "adib_widget_data"

    invoke-virtual {p0, v3, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "pomodoro_stopped"

    invoke-interface {v0, v3, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "pomodoro_end"

    invoke-interface {v0, v3, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pomodoro_remaining"

    const-wide/32 v2, 0x16e360

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string v0, "pomodoro"

    invoke-static {p0, v0}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    const-string v3, "cancel"

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    iget v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 155
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v0, :cond_2

    const/16 v0, 0x100c

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    return-void

    :cond_2
    invoke-virtual {p0, v5}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return-void
.end method

.method static syncEnabled(Landroid/content/Context;)Z
    .locals 2

    .line 64
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v0, "sync_enabled"

    const/4 v1, 0x1

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method static syncGlobal(Landroid/content/Context;Ljava/lang/String;J)V
    .locals 11

    .line 67
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "adib_floating_timer"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v10

    invoke-interface {v10}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const-wide/16 v3, 0x3a98

    add-long/2addr v1, v3

    const-string v3, "local_mutation_until"

    invoke-interface {v0, v3, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    const-string v0, "taskId"

    const-string v1, ""

    invoke-interface {v10, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "00000000-0000-4000-8000-000000000001"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "session_id"

    invoke-interface {v10, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v8, v0

    goto :goto_0

    :cond_0
    move-object v8, v1

    :goto_0
    const-string v0, "shared_visibility_id"

    invoke-interface {v10, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    sget-object v0, Lcom/adib/maintenance/AdibFloatingTimerService;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v3, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda2;

    move-object v4, p0

    move-object v5, p1

    move-wide v6, p2

    invoke-direct/range {v3 .. v10}, Lcom/adib/maintenance/AdibFloatingTimerService$$ExternalSyntheticLambda2;-><init>(Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Landroid/content/SharedPreferences;)V

    invoke-interface {v0, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method static takeNotificationPermissionPending(Landroid/content/Context;)Z
    .locals 3

    .line 88
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v0, "notification_permission_pending"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-nez v2, :cond_0

    return v1

    :cond_0
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    const/4 p0, 0x1

    return p0
.end method

.method private toggleFromIsland()V
    .locals 18

    move-object/from16 v0, p0

    .line 148
    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const-string v2, "pomodoro"

    const-string v3, "pomodoro_remaining"

    const-string v4, "pomodoro_end"

    const-string v5, "pomodoro_stopped"

    const-string v6, "adib_widget_data"

    const-string v7, "endAt"

    const-string v8, "remainingMs"

    const-string v9, "running"

    const-string v10, "adib_floating_timer"

    const/4 v11, 0x1

    const-wide/16 v12, 0x0

    if-eqz v1, :cond_2

    iget-wide v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    sub-long v14, v14, v16

    invoke-static {v12, v13, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v14

    iput-wide v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    cmp-long v14, v14, v12

    if-gtz v14, :cond_0

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->completeTimer()V

    return-void

    :cond_0
    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    invoke-virtual {v0, v10, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v10

    invoke-interface {v10}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v10

    invoke-interface {v10, v9, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v9

    iget-wide v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-interface {v9, v8, v14, v15}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v8

    invoke-interface {v8, v7, v12, v13}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v7

    invoke-interface {v7}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-boolean v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v8, "pause"

    if-eqz v7, :cond_1

    iget-wide v9, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-static {v0, v8, v9, v10}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncGlobal(Landroid/content/Context;Ljava/lang/String;J)V

    invoke-static {v0}, Lcom/adib/maintenance/AdibWidgetData;->cancelPomodoroTick(Landroid/content/Context;)V

    invoke-virtual {v0, v6, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6, v5, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v4, v12, v13}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-wide v4, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-interface {v1, v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {v0, v2}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_1
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_5

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    iget-wide v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    const-wide/32 v5, 0xea5f

    add-long/2addr v3, v5

    const-wide/32 v5, 0xea60

    div-long/2addr v3, v5

    long-to-int v3, v3

    invoke-static {v11, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-direct {v0, v1, v8, v2, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 149
    :cond_2
    iget-wide v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    cmp-long v14, v14, v12

    if-gtz v14, :cond_3

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopFromIsland()V

    return-void

    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    move-object/from16 v17, v2

    iget-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    add-long/2addr v14, v1

    iput-wide v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    iput-boolean v11, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const/4 v1, 0x0

    invoke-virtual {v0, v10, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, v9, v11}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, v8, v12, v13}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    iget-wide v8, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-interface {v2, v7, v8, v9}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V

    iget-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v7, "start"

    if-eqz v2, :cond_4

    iget-wide v8, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-static {v0, v7, v8, v9}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncGlobal(Landroid/content/Context;Ljava/lang/String;J)V

    const/4 v1, 0x0

    invoke-virtual {v0, v6, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, v5, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-wide v5, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-interface {v1, v4, v5, v6}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v3, v12, v13}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    move-object/from16 v1, v17

    invoke-static {v0, v1}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_5

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    iget v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    invoke-direct {v0, v1, v7, v2, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 150
    :cond_5
    :goto_0
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->pauseButton:Landroid/widget/TextView;

    if-eqz v1, :cond_7

    iget-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v2, :cond_6

    const-string v2, "\u2161"

    goto :goto_1

    :cond_6
    const-string v2, "\u25b6"

    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_7
    const/16 v1, 0x100c

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method private updateClock(J)V
    .locals 6

    .line 146
    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-wide/16 v0, 0x3e7

    add-long/2addr p1, v0

    const-wide/16 v0, 0x3e8

    div-long/2addr p1, v0

    const-wide/16 v0, 0x0

    invoke-static {v0, v1, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->clock:Landroid/widget/TextView;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    const-wide/16 v2, 0x3c

    div-long v4, p1, v2

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    rem-long/2addr p1, v2

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    filled-new-array {v4, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "%02d:%02d"

    invoke-static {v1, p2, p1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method static updatePausedTimer(Landroid/content/Context;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 4

    .line 93
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 94
    const-string v2, "active"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v2, "taskId"

    const-string v3, ""

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez p3, :cond_0

    move-object p3, v3

    :cond_0
    invoke-virtual {v2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-nez p3, :cond_1

    goto :goto_0

    .line 95
    :cond_1
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "running"

    invoke-interface {p3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "stopped"

    invoke-interface {p3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-wide/16 v0, 0x3e8

    invoke-static {v0, v1, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    const-string v0, "remainingMs"

    invoke-interface {p3, v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "endAt"

    const-wide/16 v0, 0x0

    invoke-interface {p1, p2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-nez p4, :cond_2

    const-string p4, "Pomodoro"

    :cond_2
    const-string p2, "label"

    invoke-interface {p1, p2, p4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-nez p5, :cond_3

    const-string p5, "work"

    :cond_3
    const-string p2, "mode"

    invoke-interface {p1, p2, p5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const/4 p2, 0x1

    invoke-static {p2, p6}, Ljava/lang/Math;->max(II)I

    move-result p2

    const-string p3, "duration"

    invoke-interface {p1, p3, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 96
    invoke-static {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->startServiceNow(Landroid/content/Context;)V

    :cond_4
    :goto_0
    return-void
.end method


# virtual methods
.method applySharedSnapshot(Lorg/json/JSONObject;)V
    .locals 33

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 71
    const-string v2, "adib_floating_timer"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-string v6, "local_mutation_until"

    const-wide/16 v7, 0x0

    invoke-interface {v2, v6, v7, v8}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v9

    cmp-long v4, v4, v9

    if-gez v4, :cond_0

    goto/16 :goto_7

    .line 72
    :cond_0
    const-string v4, "taskId"

    const-string v5, ""

    invoke-interface {v2, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v1, v6}, Lcom/adib/maintenance/SharedPomodoroState;->select(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    if-nez v6, :cond_1

    goto/16 :goto_7

    :cond_1
    const-string v9, "revision"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v9

    const-string v11, "id"

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    iget-object v12, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    const-string v13, "shared_revision_basis"

    const-string v14, "revisionBasis"

    const-string v15, "shared_revision"

    if-eqz v12, :cond_2

    invoke-virtual {v6, v14}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-interface {v2, v13, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v12, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v2, v15, v7, v8}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v16

    cmp-long v5, v9, v16

    if-gez v5, :cond_2

    goto/16 :goto_7

    .line 73
    :cond_2
    invoke-static {v6}, Lcom/adib/maintenance/SharedPomodoroState;->displayKey(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v5

    const-string v12, "windowHidden"

    invoke-virtual {v6, v12}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v16

    if-nez v16, :cond_4

    invoke-static {v2, v6}, Lcom/adib/maintenance/SharedPomodoroState;->dismissed(Landroid/content/SharedPreferences;Lorg/json/JSONObject;)Z

    move-result v8

    if-eqz v8, :cond_3

    goto :goto_0

    :cond_3
    move v8, v3

    goto :goto_1

    :cond_4
    :goto_0
    const/4 v8, 0x1

    .line 74
    :goto_1
    const-string v7, "running"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v3

    move/from16 v19, v8

    const-string v8, "ready"

    move-object/from16 v20, v12

    const-string v12, "status"

    move-object/from16 v21, v13

    invoke-virtual {v6, v12}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v8, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    const-string v13, "paused"

    invoke-virtual {v6, v12}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v13, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    .line 75
    const-string v13, "pomodoro"

    move/from16 v22, v8

    const-string v8, "pomodoro_remaining"

    move/from16 v23, v12

    const-string v12, "pomodoro_end"

    move-object/from16 v24, v14

    const-string v14, "pomodoro_stopped"

    move-object/from16 v25, v5

    const-string v5, "adib_widget_data"

    move-object/from16 v26, v4

    const-string v4, "00000000-0000-4000-8000-000000000001"

    move-object/from16 v27, v2

    const-string v2, "stopped"

    move/from16 v28, v3

    const-string v3, "active"

    if-nez v28, :cond_6

    if-nez v22, :cond_6

    if-nez v23, :cond_6

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v11, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_f

    invoke-interface/range {v27 .. v27}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const/4 v6, 0x0

    invoke-interface {v1, v3, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v7, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v15, v9, v10}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    iput-boolean v6, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const-wide/16 v1, 0x0

    iput-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-virtual {v4, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-virtual {v0, v5, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-interface {v4, v14, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v12, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v8, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {v0, v13}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    :cond_5
    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->hideOverlay()V

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    const/16 v2, 0x100c

    invoke-virtual {v0, v2, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    return-void

    :cond_6
    move-object/from16 v22, v12

    move-object/from16 v23, v13

    .line 76
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    move-object/from16 v29, v8

    if-eqz v28, :cond_7

    const-string v8, "serverNow"

    move-wide/from16 v30, v9

    invoke-virtual {v1, v8, v12, v13}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v8

    invoke-static {v6, v8, v9, v12, v13}, Lcom/adib/maintenance/SharedPomodoroState;->localEnd(Lorg/json/JSONObject;JJ)J

    move-result-wide v8

    goto :goto_2

    :cond_7
    move-wide/from16 v30, v9

    const-wide/16 v8, 0x0

    :goto_2
    if-eqz v28, :cond_8

    sub-long v12, v8, v12

    move-object v10, v14

    move-object v1, v15

    const-wide/16 v14, 0x0

    invoke-static {v14, v15, v12, v13}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v12

    move-wide/from16 v17, v14

    goto :goto_3

    :cond_8
    move-object v10, v14

    move-object v1, v15

    const-wide/16 v14, 0x0

    const-string v12, "remainingSeconds"

    move-wide/from16 v17, v14

    const-wide/16 v14, 0x5dc

    invoke-virtual {v6, v12, v14, v15}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v12

    const-wide/16 v14, 0x3e8

    mul-long/2addr v12, v14

    invoke-static {v14, v15, v12, v13}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v12

    :goto_3
    if-eqz v28, :cond_9

    cmp-long v14, v12, v17

    if-gtz v14, :cond_9

    goto/16 :goto_7

    .line 77
    :cond_9
    iget-object v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    if-eqz v14, :cond_b

    iget-object v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v11, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_b

    iget-boolean v14, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    move/from16 v15, v28

    if-eq v14, v15, :cond_a

    goto :goto_4

    :cond_a
    const/4 v14, 0x0

    goto :goto_5

    :cond_b
    move/from16 v15, v28

    :goto_4
    const/4 v14, 0x1

    :goto_5
    iput-object v11, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    move-object/from16 p1, v1

    const-string v1, "title"

    move-object/from16 v28, v10

    const-string v10, "Pomodoro"

    invoke-virtual {v6, v1, v10}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    const-string v1, "work"

    const-string v10, "mode"

    invoke-virtual {v6, v10, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    const-string v1, "duration"

    move/from16 v32, v14

    const/16 v14, 0x19

    invoke-virtual {v6, v1, v14}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v14, 0x1

    invoke-static {v14, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    iput-boolean v15, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    iput-wide v8, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    iput-wide v12, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-virtual {v4, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    const-string v1, "mini"

    move-object/from16 v4, v27

    const/4 v8, 0x0

    invoke-interface {v4, v1, v8}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    .line 78
    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    xor-int/lit8 v9, v19, 0x1

    invoke-interface {v1, v3, v9}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-boolean v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    invoke-interface {v1, v7, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v2, v8}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "global"

    iget-boolean v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    move-object/from16 v3, v26

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "label"

    iget-object v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    invoke-interface {v1, v10, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "duration"

    iget v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "endAt"

    iget-wide v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-interface {v1, v2, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "remainingMs"

    iget-wide v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    invoke-interface {v1, v2, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "sessionId"

    invoke-virtual {v6, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "session_id"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "shared_key"

    move-object/from16 v3, v25

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "windowVisibilityId"

    invoke-virtual {v6, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v7, "shared_visibility_id"

    invoke-interface {v1, v7, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    move-object/from16 v2, p1

    move-wide/from16 v7, v30

    invoke-interface {v1, v2, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    move-object/from16 v2, v24

    invoke-virtual {v6, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v7, v21

    invoke-interface {v1, v7, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v2

    const/16 v16, 0x1

    xor-int/lit8 v2, v2, 0x1

    const-string v7, "needs_overlay_permission"

    invoke-interface {v1, v7, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 79
    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    if-eqz v1, :cond_d

    const/4 v8, 0x0

    invoke-virtual {v0, v5, v8}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    move-object/from16 v10, v28

    invoke-interface {v1, v10, v8}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v2, :cond_c

    iget-wide v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    goto :goto_6

    :cond_c
    move-wide/from16 v7, v17

    :goto_6
    move-object/from16 v2, v22

    invoke-interface {v1, v2, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    iget-wide v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    move-object/from16 v2, v29

    invoke-interface {v1, v2, v7, v8}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    move-object/from16 v1, v23

    invoke-static {v0, v1}, Lcom/adib/maintenance/AdibWidgetData;->updateFromCache(Landroid/content/Context;Ljava/lang/String;)V

    :cond_d
    move-object/from16 v1, v20

    .line 80
    invoke-virtual {v6, v1}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_e

    const-string v1, "windowVisibilityId"

    invoke-virtual {v6, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v4, v3, v1}, Lcom/adib/maintenance/SharedPomodoroState;->dismiss(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;)V

    :cond_e
    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    const/16 v2, 0x100c

    invoke-virtual {v0, v2, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    if-eqz v19, :cond_10

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v1, :cond_f

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_f
    :goto_7
    return-void

    :cond_10
    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_11

    if-eqz v32, :cond_11

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->showOverlay()V

    return-void

    :cond_11
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->title:Landroid/widget/TextView;

    if-eqz v1, :cond_12

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_12
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->pauseButton:Landroid/widget/TextView;

    if-eqz v1, :cond_14

    iget-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v2, :cond_13

    const-string v2, "\u2161"

    goto :goto_8

    :cond_13
    const-string v2, "\u25b6"

    :goto_8
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_14
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method dismissOverlay()V
    .locals 4

    .line 185
    const-string v0, "adib_floating_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "session_id"

    const-string v3, ""

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "shared_visibility_id"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/adib/maintenance/SharedPomodoroState;->dismiss(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->removeOverlayView()V

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "adib.testing"

    invoke-static {v0}, Ljava/lang/Boolean;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    iget v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    const-string v3, "hide"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->postPomodoro(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 4

    .line 100
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    sput-object p0, Lcom/adib/maintenance/AdibFloatingTimerService;->liveService:Lcom/adib/maintenance/AdibFloatingTimerService;

    const-string v0, "window"

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->windowManager:Landroid/view/WindowManager;

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->createNotificationChannel()V

    iget-object v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->commentPoll:Ljava/lang/Runnable;

    const-wide/16 v2, 0x3a98

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public onDestroy()V
    .locals 3

    const/4 v0, 0x1

    .line 191
    iput-boolean v0, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->destroyed:Z

    sget-object v1, Lcom/adib/maintenance/AdibFloatingTimerService;->liveService:Lcom/adib/maintenance/AdibFloatingTimerService;

    if-ne v1, p0, :cond_0

    const/4 v1, 0x0

    sput-object v1, Lcom/adib/maintenance/AdibFloatingTimerService;->liveService:Lcom/adib/maintenance/AdibFloatingTimerService;

    :cond_0
    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/adib/maintenance/AdibFloatingTimerService;->commentPoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibFloatingTimerService;->hideOverlay()V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopForeground(I)V

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 102
    const-string v2, "serverNow"

    const-string v3, "com.adib.maintenance.POMODORO_SYNC"

    if-nez v1, :cond_0

    move-object v4, v3

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    :goto_0
    const-string v5, "adib_floating_timer"

    const/4 v6, 0x0

    invoke-virtual {v0, v5, v6}, Lcom/adib/maintenance/AdibFloatingTimerService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v5

    invoke-static {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncEnabled(Landroid/content/Context;)Z

    move-result v7

    iput-boolean v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    .line 103
    const-string v7, "com.adib.maintenance.POMODORO_CONFIRMED_LIST"

    invoke-virtual {v7, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    const-string v8, "running"

    const-wide/16 v9, 0x0

    const-string v11, "taskId"

    const/16 v12, 0x100c

    const/4 v13, 0x1

    if-eqz v7, :cond_5

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v3

    invoke-virtual {v0, v12, v3}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    iget-object v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-interface {v5, v11, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "local_mutation_until"

    invoke-interface {v3, v4, v9, v10}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    const-string v4, "confirmed_json"

    invoke-virtual {v1, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "timer"

    invoke-virtual {v3, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-virtual {v1, v8}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "ready"

    const-string v6, "status"

    invoke-virtual {v1, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_1
    invoke-static {v1}, Lcom/adib/maintenance/SharedPomodoroState;->displayKey(Lorg/json/JSONObject;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/adib/maintenance/SharedPomodoroState;->allow(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    :cond_2
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {v3, v2, v5, v6}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v5

    invoke-virtual {v4, v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "timers"

    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v4, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->applySharedSnapshot(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v1, :cond_4

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    const-wide/16 v3, 0x1388

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_4
    return v13

    .line 104
    :cond_5
    const-string v2, "com.adib.maintenance.POMODORO_SYNC_DISABLE"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v7, 0x2

    const-string v14, "active"

    if-eqz v2, :cond_7

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "sync_enabled"

    invoke-interface {v1, v2, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    iput-boolean v6, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-interface {v5, v14, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_6

    invoke-virtual {v0, v13}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopForeground(I)V

    invoke-virtual {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return v7

    :cond_6
    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v12, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    return v13

    .line 105
    :cond_7
    const-string v2, "com.adib.maintenance.FLOAT_TIMER_OPEN_TASK"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const-string v15, "global"

    move/from16 p2, v7

    const-string v7, ""

    if-eqz v2, :cond_b

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    invoke-virtual {v1, v11}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    :goto_1
    if-eqz v7, :cond_9

    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_9

    iput-object v7, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v11, v7}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v15, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_9
    invoke-static {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->syncEnabled(Landroid/content/Context;)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v12, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v1, :cond_a

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_a
    return v13

    .line 106
    :cond_b
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_d

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->overlay:Landroid/view/View;

    if-eqz v1, :cond_d

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v12, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v1, :cond_c

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_c
    return v13

    .line 107
    :cond_d
    const-string v1, "com.adib.maintenance.FLOAT_TIMER_HIDE"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_f

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->hideOverlay()V

    iput-boolean v6, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v12, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-nez v1, :cond_e

    invoke-virtual {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return p2

    :cond_e
    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return v13

    .line 108
    :cond_f
    const-string v1, "endAt"

    invoke-interface {v5, v1, v9, v10}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v1

    iput-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-interface {v5, v11, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->taskId:Ljava/lang/String;

    const-string v1, "label"

    const-string v2, "Pomodoro"

    invoke-interface {v5, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->label:Ljava/lang/String;

    const-string v1, "mode"

    const-string v2, "work"

    invoke-interface {v5, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->mode:Ljava/lang/String;

    const-string v1, "duration"

    const/16 v2, 0x19

    invoke-interface {v5, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    iput v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->duration:I

    invoke-interface {v5, v15, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->globalTimer:Z

    invoke-interface {v5, v8, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    const-string v1, "mini"

    invoke-interface {v5, v1, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->miniMode:Z

    const-string v1, "remainingMs"

    invoke-interface {v5, v1, v9, v10}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v1

    iput-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    .line 109
    invoke-interface {v5, v14, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_12

    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-eqz v1, :cond_10

    iget-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->endAt:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    cmp-long v1, v1, v3

    if-gtz v1, :cond_11

    :cond_10
    iget-boolean v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    if-nez v1, :cond_12

    iget-wide v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remainingMs:J

    cmp-long v1, v1, v9

    if-lez v1, :cond_12

    :cond_11
    move v1, v13

    goto :goto_2

    :cond_12
    move v1, v6

    :goto_2
    if-nez v1, :cond_13

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, v14, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V

    iput-boolean v6, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->running:Z

    .line 110
    :cond_13
    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->buildNotification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v12, v2}, Lcom/adib/maintenance/AdibFloatingTimerService;->startForeground(ILandroid/app/Notification;)V

    if-eqz v1, :cond_15

    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_14

    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->showOverlay()V

    goto :goto_3

    :cond_14
    invoke-direct {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->hideOverlay()V

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->tick:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 111
    :cond_15
    :goto_3
    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v3, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->syncMonitoring:Z

    if-eqz v2, :cond_16

    iget-object v1, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->handler:Landroid/os/Handler;

    iget-object v2, v0, Lcom/adib/maintenance/AdibFloatingTimerService;->remotePoll:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_4

    :cond_16
    if-nez v1, :cond_17

    invoke-virtual {v0}, Lcom/adib/maintenance/AdibFloatingTimerService;->stopSelf()V

    return p2

    :cond_17
    :goto_4
    return v13
.end method
