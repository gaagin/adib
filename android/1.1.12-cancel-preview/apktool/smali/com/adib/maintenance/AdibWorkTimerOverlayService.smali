.class public final Lcom/adib/maintenance/AdibWorkTimerOverlayService;
.super Landroid/app/Service;
.source "AdibWorkTimerOverlayService.java"


# static fields
.field static final ACTION_HIDE:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_HIDE"

.field static final ACTION_PENDING:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_PENDING"

.field static final ACTION_REFRESH:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_REFRESH"

.field static final ACTION_STOP:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_STOP"

.field static final ACTION_SYNC:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_SYNC"

.field static final ACTION_TOGGLE:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_TOGGLE"

.field static final BROADCAST_PENDING:Ljava/lang/String; = "com.adib.maintenance.WORK_TIMER_PENDING_EVENT"

.field private static final CHANNEL:Ljava/lang/String; = "adib_work_timer"

.field private static final IO:Ljava/util/concurrent/ExecutorService;

.field private static final NOTIFICATION_ID:I = 0x1020

.field private static final PENDING_KEY:Ljava/lang/String; = "pending_session"

.field static final PREFS:Ljava/lang/String; = "adib_work_timer"


# instance fields
.field private baseSeconds:J

.field private clock:Landroid/widget/TextView;

.field private confirmationError:Landroid/widget/TextView;

.field private confirming:Z

.field private endField:Landroid/widget/EditText;

.field private endedAt:J

.field private final handler:Landroid/os/Handler;

.field private mini:Z

.field private overlay:Landroid/view/View;

.field private params:Landroid/view/WindowManager$LayoutParams;

.field private revision:I

.field private running:Z

.field private saveButton:Landroid/widget/TextView;

.field private cancelButton:Landroid/widget/TextView;

.field private saving:Z

.field private sessionId:Ljava/lang/String;

.field private sessionJson:Ljava/lang/String;

.field private sourceKey:Ljava/lang/String;

.field private startField:Landroid/widget/EditText;

.field private startUptime:J

.field private startedAt:J

.field private stopButton:Landroid/widget/TextView;

.field private stopping:Z

.field private taskId:Ljava/lang/String;

.field private taskTitle:Ljava/lang/String;

.field private final ticker:Ljava/lang/Runnable;

.field private title:Landroid/widget/TextView;

.field private wm:Landroid/view/WindowManager;

.field private worker:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$-0CpsL_X-zarY_Ogdydrn57P474(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$saveConfirmedTime$10(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$2Ccsr3pqA6CDLreSFi3Qad0Fl5Y(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$stopCurrent$7(Ljava/lang/String;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$7rGK1x_t7sYSICmVmBBQQg1e7W0(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$showConfirmation$8(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$KdSZjrptwJpypiOWLMT5QtykXx4(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$stopCurrent$5(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$M-2JAhtuW6IOaHq9ostQ2XT0m2g(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$showOverlay$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$RhAhI9ksOPMKpXlhm08ZcVBCby0(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$showOverlay$0(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$WLsiJOLbS5mfQcZpU8uDViT5UJI(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$showOverlay$3(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$eWrl944fypdrSBl_c-5SyHdzpEk(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;IJJLjava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$saveConfirmedTime$11(Ljava/lang/String;IJJLjava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ommaQrb22yzdygp-RP3HFWeHSN8(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$stopCurrent$4(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$rl8VYQQkwBYI2fKmMIPb9aANyZg(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$stopCurrent$6(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$wY2zR8xxM_Id8G6nPgTFzvXJ47Y(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$saveConfirmedTime$9(Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$zJsW-wP1ly4LjxBLv2uhbUqmSLc(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->lambda$showOverlay$1(Landroid/view/View;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgethandler(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetmini(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetparams(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)Landroid/view/WindowManager$LayoutParams;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetrunning(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetwm(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)Landroid/view/WindowManager;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mupdateClock(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->updateClock()V

    return-void
.end method

.method static bridge synthetic -$$Nest$mupdateNotification(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->updateNotification()V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 38
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->IO:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 34
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 39
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskId:Ljava/lang/String;

    const-string v1, "Tap\u015f\u0131r\u0131q"

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    const-string v1, "todo"

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sourceKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionJson:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    iput-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->baseSeconds:J

    iput-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    iput-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endedAt:J

    .line 41
    new-instance v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$1;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$1;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->ticker:Ljava/lang/Runnable;

    return-void
.end method

.method private acceptStopped(Lorg/json/JSONObject;J)V
    .locals 2

    .line 78
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->readSession(Ljava/lang/String;J)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object p3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->ticker:Ljava/lang/Runnable;

    invoke-virtual {p3, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-string p3, "adib_work_timer"

    invoke-virtual {p0, p3, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p3

    invoke-interface {p3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "running"

    invoke-interface {p3, v0, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "pending_native_confirmation"

    const/4 v1, 0x1

    invoke-interface {p3, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "hidden"

    invoke-interface {p3, v0, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p2

    invoke-interface {p2}, Landroid/content/SharedPreferences$Editor;->apply()V

    const/16 p2, 0x1020

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->notification()Landroid/app/Notification;

    move-result-object p3

    invoke-virtual {p0, p2, p3}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startForeground(ILandroid/app/Notification;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmation()V

    new-instance p2, Landroid/content/Intent;

    const-string p3, "com.adib.maintenance.WORK_TIMER_PENDING_EVENT"

    invoke-direct {p2, p3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getPackageName()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    const-string p3, "session"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private actionButton(Ljava/lang/String;)Landroid/widget/TextView;
    .locals 2

    .line 68
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v1, 0x1

    invoke-static {v1}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v1, 0x41700000    # 15.0f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    return-object v0
.end method

.method private confirmationField(Landroid/widget/LinearLayout;Ljava/lang/String;JLjava/lang/String;)Landroid/widget/EditText;
    .locals 4

    .line 83
    invoke-direct {p0, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    const/high16 v1, 0x41400000    # 12.0f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    const v1, 0x800013

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v2

    const/4 v3, -0x1

    invoke-direct {v1, v3, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSingleLine(Z)V

    invoke-static {v1}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    const/high16 v1, 0x41600000    # 14.0f

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextSize(F)V

    sget-object v1, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTypeface(Landroid/graphics/Typeface;)V

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v1, " i\u015f seans\u0131"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget-object p5, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {p2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string p5, "adib_work_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, p5, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p5

    invoke-static {p3, p4}, Lcom/adib/maintenance/WorkTimeEdit;->format(J)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p5, p2, p3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    new-instance p3, Lcom/adib/maintenance/AdibWorkTimerOverlayService$3;

    invoke-direct {p3, p0, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$3;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    new-instance p2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 p3, 0x42400000    # 48.0f

    invoke-direct {p0, p3}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result p3

    invoke-direct {p2, v3, p3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method private createChannel()V
    .locals 5

    .line 62
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    if-eqz v0, :cond_0

    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "ADIB i\u015f taymeri"

    const/4 v3, 0x2

    const-string v4, "adib_work_timer"

    invoke-direct {v1, v4, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const-string v2, "Tap\u015f\u0131r\u0131\u011f\u0131n aktiv i\u015f taymeri"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_0
    return-void
.end method

.method private dp(F)I
    .locals 1

    .line 66
    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private drag(Landroid/view/View;Landroid/view/View;)V
    .locals 1

    .line 73
    new-instance v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$2;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$2;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Landroid/view/View;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    return-void
.end method

.method private format(J)Ljava/lang/String;
    .locals 6

    const-wide/16 v0, 0x0

    .line 65
    invoke-static {v0, v1, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-wide/16 v1, 0xe10

    div-long v1, p1, v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-wide/16 v2, 0x3c

    div-long v4, p1, v2

    rem-long/2addr v4, v2

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    rem-long/2addr p1, v2

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    filled-new-array {v1, v4, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "%02d:%02d:%02d"

    invoke-static {v0, p2, p1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private synthetic lambda$saveConfirmedTime$10(Ljava/lang/Exception;)V
    .locals 3

    const/4 v0, 0x0

    .line 84
    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    const-string v2, "Vaxt\u0131 t\u0259sdiql\u0259"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    if-eqz v0, :cond_1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    :cond_1
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    if-eqz v0, :cond_2

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Saxlamaq al\u0131nmad\u0131: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ". Vaxt t\u0259sdiql\u0259nm\u0259yib."

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmationError(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$saveConfirmedTime$11(Ljava/lang/String;IJJLjava/lang/String;)V
    .locals 3

    .line 84
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "action"

    const-string v2, "save"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "sessionId"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "revision"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object p2

    const-string v0, "startedAt"

    invoke-virtual {p2, v0, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object p2

    const-string p3, "endedAt"

    invoke-virtual {p2, p3, p5, p6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object p2

    const-string p3, "operationId"

    invoke-virtual {p2, p3, p7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p2

    invoke-static {p0, p2}, Lcom/adib/maintenance/WorkTimerApi;->action(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p2

    const-string p3, "session"

    invoke-virtual {p2, p3}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p3

    if-eqz p3, :cond_0

    const-string p4, "saved"

    const-string p5, "status"

    invoke-virtual {p3, p5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p4, p5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_0

    iget-object p4, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance p5, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda7;

    invoke-direct {p5, p0, p3, p2, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda7;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)V

    invoke-virtual {p4, p5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Server saxlanman\u0131 t\u0259sdiql\u0259m\u0259di"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance p3, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda8;

    invoke-direct {p3, p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda8;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/Exception;)V

    invoke-virtual {p2, p3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private synthetic lambda$saveConfirmedTime$9(Lorg/json/JSONObject;Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 4

    .line 84
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p2, v1, v2, v3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-direct {p0, v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->readSession(Ljava/lang/String;J)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    const-string v0, "adib_work_timer"

    invoke-virtual {p0, v0, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pending_session"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "draft_start:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "draft_end:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-interface {v0, p3}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "save_operation_key"

    invoke-interface {p3, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "save_operation_id"

    invoke-interface {p3, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    const-string v0, "pending_native_confirmation"

    invoke-interface {p3, v0, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p3

    invoke-interface {p3}, Landroid/content/SharedPreferences$Editor;->apply()V

    new-instance p3, Landroid/content/Intent;

    const-string v0, "com.adib.maintenance.WORK_TIMER_PENDING_EVENT"

    invoke-direct {p3, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p3

    const-string v0, "session"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sendBroadcast(Landroid/content/Intent;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopSelf()V

    const-string p1, "\u0130\u015f vaxt\u0131 t\u0259sdiql\u0259ndi"

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private synthetic lambda$showConfirmation$8(Landroid/view/View;)V
    .locals 0

    .line 81
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveConfirmedTime()V

    return-void
.end method

.method private synthetic lambda$showOverlay$0(Landroid/view/View;)V
    .locals 1

    .line 70
    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    if-nez p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    const-string v0, "\u2026"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopCurrent()V

    :cond_0
    return-void
.end method

.method private synthetic lambda$showOverlay$1(Landroid/view/View;)V
    .locals 0

    .line 70
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->toggleMini()V

    return-void
.end method

.method private synthetic lambda$showOverlay$2(Landroid/view/View;)V
    .locals 2

    .line 70
    const-string p1, "adib_work_timer"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "hidden"

    const/4 v1, 0x1

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    return-void
.end method

.method private synthetic lambda$showOverlay$3(Landroid/view/View;)V
    .locals 0

    .line 71
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->toggleMini()V

    return-void
.end method

.method private synthetic lambda$stopCurrent$4(Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 3

    .line 77
    const-string v0, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p2, v0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v0

    invoke-direct {p0, p1, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->acceptStopped(Lorg/json/JSONObject;J)V

    return-void
.end method

.method private synthetic lambda$stopCurrent$5(Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 3

    .line 77
    const-string v0, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p2, v0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v0

    invoke-direct {p0, p1, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->acceptStopped(Lorg/json/JSONObject;J)V

    return-void
.end method

.method private synthetic lambda$stopCurrent$6(Ljava/lang/Exception;)V
    .locals 2

    const/4 v0, 0x0

    .line 77
    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    const-string v1, "\u25a0"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Taymeri dayand\u0131rmaq al\u0131nmad\u0131: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private synthetic lambda$stopCurrent$7(Ljava/lang/String;I)V
    .locals 6

    .line 77
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "action"

    const-string v2, "stop"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "sessionId"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "revision"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

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

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance v2, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda0;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    new-instance p2, Ljava/lang/IllegalStateException;

    const-string v0, "Server cavab\u0131nda seans yoxdur"

    invoke-direct {p2, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p2

    :try_start_1
    invoke-static {p0}, Lcom/adib/maintenance/WorkTimerApi;->getState(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "own"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    if-eqz v1, :cond_2

    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v2, v3, :cond_2

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v3, :cond_1

    const-string v4, "id"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const-string v4, "pending"

    const-string v5, "status"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0, v3, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    invoke-virtual {p1, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_1
    :cond_2
    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0, p2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda4;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/Exception;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private load()V
    .locals 7

    .line 59
    const-string v0, "adib_work_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "sessionJson"

    const-string v3, ""

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionJson:Ljava/lang/String;

    const-string v2, "sessionId"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    const-string v2, "taskId"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskId:Ljava/lang/String;

    const-string v2, "title"

    const-string v4, "Tap\u015f\u0131r\u0131q"

    invoke-interface {v0, v2, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    const-string v2, "worker"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    const-string v2, "sourceKey"

    const-string v3, "todo"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sourceKey:Ljava/lang/String;

    const-string v2, "revision"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    const-string v2, "startedAt"

    const-wide/16 v3, 0x0

    invoke-interface {v0, v2, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    const-string v2, "baseSeconds"

    invoke-interface {v0, v2, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->baseSeconds:J

    const-string v2, "startUptime"

    invoke-interface {v0, v2, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    const-string v2, "running"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    const-string v2, "mini"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionJson:Ljava/lang/String;

    invoke-direct {v0, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "pending"

    const-string v5, "status"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    const-string v2, "endedAt"

    invoke-virtual {v0, v2, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v2

    iput-wide v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endedAt:J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iput-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    return-void
.end method

.method private notification()Landroid/app/Notification;
    .locals 5

    .line 63
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.WORK_TIMER_REFRESH"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x34000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    :goto_0
    iget-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    const/high16 v2, 0xc000000

    const/16 v3, 0x1020

    if-eqz v1, :cond_1

    invoke-static {p0, v3, v0, v2}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    goto :goto_1

    :cond_1
    invoke-static {p0, v3, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    :goto_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_2

    new-instance v1, Landroid/app/Notification$Builder;

    const-string v2, "adib_work_timer"

    invoke-direct {v1, p0, v2}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_2

    :cond_2
    new-instance v1, Landroid/app/Notification$Builder;

    invoke-direct {v1, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    :goto_2
    sget v2, Lcom/adib/maintenance/R$drawable;->ic_adib:I

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v2, :cond_3

    const-string v2, "ADIB \u00b7 \u0130\u015f vaxt\u0131n\u0131 t\u0259sdiql\u0259yin"

    goto :goto_3

    :cond_3
    const-string v2, "ADIB \u00b7 \u0130\u015f taymeri"

    :goto_3
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \u00b7 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->elapsed()J

    move-result-wide v3

    invoke-direct {p0, v3, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->format(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method private notifyStopped()V
    .locals 5

    .line 86
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/OnlineMainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x34000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    const/high16 v1, 0xc000000

    const/16 v2, 0x1021

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v1, v3, :cond_0

    new-instance v1, Landroid/app/Notification$Builder;

    const-string v3, "adib_work_timer"

    invoke-direct {v1, p0, v3}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    new-instance v1, Landroid/app/Notification$Builder;

    invoke-direct {v1, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    :goto_0
    sget v3, Lcom/adib/maintenance/R$drawable;->ic_adib:I

    invoke-virtual {v1, v3}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v1

    const-string v3, "\u0130\u015f taymeri dayand\u0131r\u0131ld\u0131"

    invoke-virtual {v1, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " \u00b7 qeyd\u0259 al\u0131nan vaxt\u0131 ADIB-d\u0259 t\u0259sdiql\u0259yin"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    if-eqz v1, :cond_1

    invoke-virtual {v1, v2, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private persist()V
    .locals 4

    .line 60
    const-string v0, "adib_work_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sessionJson"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionJson:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sessionId"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "taskId"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskId:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "title"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "worker"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sourceKey"

    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sourceKey:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "revision"

    iget v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "startedAt"

    iget-wide v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "baseSeconds"

    iget-wide v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->baseSeconds:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "startUptime"

    iget-wide v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "running"

    iget-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private readSession(Ljava/lang/String;J)V
    .locals 12

    .line 58
    const-string v0, "pending"

    const-string v1, "id"

    const-string v2, "adib_work_timer"

    const-string v3, ""

    const-string v4, "status"

    :try_start_0
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v6, "revision"

    const/4 v7, 0x0

    if-eqz p1, :cond_0

    :try_start_1
    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p1

    iget v8, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    if-ge p1, v8, :cond_0

    goto/16 :goto_2

    :cond_0
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionJson:Ljava/lang/String;

    invoke-virtual {v5, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    const-string p1, "taskId"

    invoke-virtual {v5, p1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskId:Ljava/lang/String;

    const-string p1, "title"

    const-string v1, "Tap\u015f\u0131r\u0131q"

    invoke-virtual {v5, p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    const-string p1, "worker"

    invoke-virtual {v5, p1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    const-string p1, "sourceKey"

    const-string v1, "todo"

    invoke-virtual {v5, p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sourceKey:Ljava/lang/String;

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    const-string p1, "startedAt"

    invoke-virtual {v5, p1, p2, p3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v8

    iput-wide v8, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    const-string p1, "running"

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    const-string p1, "endedAt"

    const-wide/16 v8, 0x0

    invoke-virtual {v5, p1, v8, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v10

    iput-wide v10, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endedAt:J

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    if-eqz p1, :cond_1

    iget-wide v10, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    sub-long/2addr p2, v10

    const-wide/16 v10, 0x3e8

    div-long/2addr p2, v10

    invoke-static {v8, v9, p2, p3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    goto :goto_0

    :cond_1
    const-string p1, "seconds"

    invoke-virtual {v5, p1, v8, v9}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide p1

    invoke-static {v8, v9, p1, p2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p1

    :goto_0
    iput-wide p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->baseSeconds:J

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    invoke-virtual {p0, v2, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    const-string p2, "mini"

    invoke-interface {p1, p2, v7}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->persist()V

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string p2, "pending_session"

    if-eqz p1, :cond_2

    :try_start_2
    invoke-virtual {p0, v2, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void

    :cond_2
    const-string p1, "saved"

    invoke-virtual {v5, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-virtual {p0, v2, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1, p2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :cond_3
    :goto_2
    return-void

    :catch_0
    move-exception p1

    const-string p2, "ADIB"

    const-string p3, "Invalid work timer session"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method static refresh(Landroid/content/Context;)V
    .locals 2

    .line 43
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.WORK_TIMER_REFRESH"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->start(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method private removeOverlay()V
    .locals 3

    .line 76
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    invoke-interface {v2, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    :cond_0
    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    return-void
.end method

.method private saveConfirmedTime()V
    .locals 12

    .line 84
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    if-nez v0, :cond_3

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    if-eqz v0, :cond_3

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    if-nez v1, :cond_0

    goto/16 :goto_0

    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    invoke-static {v0, v1, v2}, Lcom/adib/maintenance/WorkTimeEdit;->editedMillis(Ljava/lang/String;J)J

    move-result-wide v7

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-wide v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endedAt:J

    invoke-static {v0, v1, v2}, Lcom/adib/maintenance/WorkTimeEdit;->editedMillis(Ljava/lang/String;J)J

    move-result-wide v9

    invoke-static {v7, v8, v9, v10}, Lcom/adib/maintenance/WorkTimeEdit;->validate(JJ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    const-string v2, "Saxlan\u0131l\u0131r\u2026"

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object v5, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    iget v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ":"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "adib_work_timer"

    invoke-virtual {p0, v2, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "save_operation_key"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v11, "save_operation_id"

    if-eqz v4, :cond_1

    invoke-interface {v1, v11, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :cond_1
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v11, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_2
    move-object v11, v3

    sget-object v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v3, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda6;

    move-object v4, p0

    invoke-direct/range {v3 .. v11}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda6;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;IJJLjava/lang/String;)V

    invoke-interface {v0, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void

    :catch_0
    move-exception v0

    move-object v4, p0

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmationError(Ljava/lang/String;)V

    return-void

    :cond_3
    :goto_0
    move-object v4, p0

    return-void
.end method


.method requestCancelPending()V
    .locals 3

    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->cancelButton:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    const-string v2, "Ləğv edilir…"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    new-instance v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelWorker;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelWorker;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    sget-object v2, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->IO:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v2, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method cancelPendingOnWorker()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "action"

    const-string v3, "cancel"

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "sessionId"

    iget-object v3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "revision"

    iget v3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/adib/maintenance/WorkTimerApi;->action(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    :goto_0
    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    new-instance v2, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;

    invoke-direct {v2, p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method finishCancelPending(Ljava/lang/String;)V
    .locals 7

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->cancelButton:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    const-string v1, "Ləğv et"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Ləğv alınmadı: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmationError(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string p1, "adib_work_timer"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "pending_session"

    invoke-interface {p1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "draft_start:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "draft_end:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "save_operation_key"

    invoke-interface {p1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "save_operation_id"

    invoke-interface {p1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "pending_native_confirmation"

    const/4 v1, 0x0

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    iput-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    iput-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saving:Z

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopSelf()V

    const-string p1, "İş seansı ləğv edildi"

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method


.method private showConfirmation()V
    .locals 15

    .line 79
    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->updateNotification()V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v1, 0x0

    if-nez v0, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    :goto_0
    iget-object v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    if-nez v2, :cond_3

    const/high16 v2, 0x42680000    # 58.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v2

    goto :goto_1

    :cond_3
    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    :goto_1
    iget-object v3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    instance-of v4, v3, Landroid/widget/LinearLayout;

    if-eqz v4, :cond_4

    check-cast v3, Landroid/widget/LinearLayout;

    invoke-virtual {v3}, Landroid/widget/LinearLayout;->removeAllViews()V

    goto :goto_2

    :cond_4
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    :goto_2
    move-object v5, v3

    iput-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    const/4 v3, 0x1

    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v4, 0x30

    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/high16 v4, 0x41600000    # 14.0f

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v6

    const/high16 v10, 0x41200000    # 10.0f

    invoke-direct {p0, v10}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    const/high16 v11, 0x41400000    # 12.0f

    invoke-direct {p0, v11}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v9

    invoke-virtual {v5, v6, v7, v8, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->surface()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-direct {p0, v10}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v6

    int-to-float v6, v6

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setElevation(F)V

    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->setFocusableInTouchMode(Z)V

    const/4 v6, 0x0

    iput-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    iput-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    iput-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    .line 80
    const-string v7, "\u283f  \u0130\u015f vaxt\u0131n\u0131 t\u0259sdiql\u0259yin"

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7, v6, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    invoke-virtual {v7, v4}, Landroid/widget/TextView;->setTextSize(F)V

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x42180000    # 38.0f

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v6

    const/4 v12, -0x1

    invoke-direct {v4, v12, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0, v5, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->drag(Landroid/view/View;Landroid/view/View;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    const-string v13, ""

    if-eqz v6, :cond_5

    move-object v6, v13

    goto :goto_3

    :cond_5
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, " \u00b7 "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v7, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    :goto_3
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setTextSize(F)V

    const/4 v6, 0x2

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setMaxLines(I)V

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v14, -0x2

    invoke-direct {v6, v12, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 81
    iget-wide v7, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startedAt:J

    const-string v9, "draft_start:"

    const-string v6, "Ba\u015flan\u011f\u0131c"

    move-object v4, p0

    invoke-direct/range {v4 .. v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationField(Landroid/widget/LinearLayout;Ljava/lang/String;JLjava/lang/String;)Landroid/widget/EditText;

    move-result-object v6

    iput-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startField:Landroid/widget/EditText;

    iget-wide v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endedAt:J

    const-string v9, "draft_end:"

    const-string v6, "Bitm\u0259"

    invoke-direct/range {v4 .. v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationField(Landroid/widget/LinearLayout;Ljava/lang/String;JLjava/lang/String;)Landroid/widget/EditText;

    move-result-object v6

    iput-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->endField:Landroid/widget/EditText;

    const-string v6, "Format: gg.AA.iiii ss:dd:ss"

    invoke-direct {p0, v6}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v6

    invoke-virtual {v6, v10}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-static {v3}, Lcom/adib/maintenance/HybridUi;->muted(Z)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextColor(I)V

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v8, 0x41e00000    # 28.0f

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    invoke-direct {v7, v12, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0, v13}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v6

    iput-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    const/16 v7, 0xe6

    const/16 v8, 0x70

    invoke-static {v7, v8, v8}, Landroid/graphics/Color;->rgb(III)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    const/16 v7, 0x8

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v12, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v8, 0x42300000    # 44.0f

    invoke-direct {p0, v8}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    invoke-direct {v7, v12, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v7, "Vaxt\u0131 t\u0259sdiql\u0259"

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v7

    iput-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    invoke-static {v3}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v12, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->saveButton:Landroid/widget/TextView;

    new-instance v7, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda5;

    invoke-direct {v7, p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda5;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v7, "L\u0259\u011fv et"

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v7

    iput-object v7, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->cancelButton:Landroid/widget/TextView;

    const/16 v8, 0xe0

    const/16 v9, 0x4b

    const/16 v10, 0x4b

    invoke-static {v8, v9, v10}, Landroid/graphics/Color;->rgb(III)I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextColor(I)V

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v9, 0x42300000    # 44.0f

    invoke-direct {p0, v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v9

    invoke-direct {v8, v12, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v8, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelClickListener;

    invoke-direct {v8, p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelClickListener;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 82
    iget-object v6, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    if-eqz v6, :cond_6

    invoke-virtual {v5}, Landroid/widget/LinearLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v6

    if-eqz v6, :cond_6

    move v6, v3

    goto :goto_4

    :cond_6
    move v6, v1

    :goto_4
    const/high16 v7, 0x43b40000    # 360.0f

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v8

    iget v8, v8, Landroid/util/DisplayMetrics;->widthPixels:I

    const/high16 v9, 0x41800000    # 16.0f

    invoke-direct {p0, v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v9

    sub-int/2addr v8, v9

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v7

    iget-object v8, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    if-nez v8, :cond_7

    new-instance v8, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v8}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v8, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    :cond_7
    iget-object v8, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v7, v8, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v14, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0x1a

    if-lt v8, v9, :cond_8

    const/16 v8, 0x7f6

    goto :goto_5

    :cond_8
    const/16 v8, 0x7d2

    :goto_5
    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->type:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v8, 0x120

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->flags:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v8, -0x3

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->format:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v8, 0x13

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v8, 0x31

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v7, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v0, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/high16 v7, 0x41c00000    # 24.0f

    invoke-direct {p0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v8

    iget v8, v8, Landroid/util/DisplayMetrics;->heightPixels:I

    const/high16 v9, 0x43be0000    # 380.0f

    invoke-direct {p0, v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v9

    sub-int/2addr v8, v9

    invoke-static {v2, v8}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v7, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    if-eqz v6, :cond_9

    :try_start_0
    iget-object v0, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    iget-object v2, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v5, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_6

    :cond_9
    iget-object v0, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    iget-object v2, v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v5, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :goto_6
    invoke-virtual {v5}, Landroid/widget/LinearLayout;->requestFocus()Z

    const-string v0, "adib_work_timer"

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "hidden"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "T\u0259sdiq p\u0259nc\u0259r\u0259sini a\u00e7maq al\u0131nmad\u0131: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private showConfirmationError(Ljava/lang/String;)V
    .locals 1

    .line 85
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirmationError:Landroid/widget/TextView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method private showOverlay()V
    .locals 22

    move-object/from16 v0, p0

    .line 69
    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-direct {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    return-void

    :cond_0
    iget-boolean v1, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v1, :cond_1

    invoke-direct {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmation()V

    return-void

    :cond_1
    iget-object v1, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/4 v2, 0x0

    if-nez v1, :cond_2

    move v1, v2

    goto :goto_0

    :cond_2
    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    :goto_0
    iget-object v3, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/high16 v4, 0x42680000    # 58.0f

    if-nez v3, :cond_3

    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v3

    goto :goto_1

    :cond_3
    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    :goto_1
    invoke-direct {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    new-instance v5, Landroid/widget/LinearLayout;

    invoke-direct {v5, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v5, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v6, 0x10

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/high16 v6, 0x41000000    # 8.0f

    invoke-direct {v0, v6}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v6

    const/high16 v7, 0x40a00000    # 5.0f

    invoke-direct {v0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    const/high16 v9, 0x40e00000    # 7.0f

    invoke-direct {v0, v9}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v9

    invoke-direct {v0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v10

    invoke-virtual {v5, v6, v8, v9, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-direct {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->surface()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/high16 v6, 0x41200000    # 10.0f

    invoke-direct {v0, v6}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    int-to-float v8, v8

    invoke-virtual {v5, v8}, Landroid/widget/LinearLayout;->setElevation(F)V

    .line 70
    iget-boolean v8, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    const/4 v9, 0x0

    const/high16 v10, 0x42280000    # 42.0f

    const/4 v11, 0x1

    if-nez v8, :cond_5

    const-string v8, "\u283f"

    invoke-direct {v0, v8}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v8

    invoke-static {v11}, Lcom/adib/maintenance/HybridUi;->muted(Z)I

    move-result v12

    invoke-virtual {v8, v12}, Landroid/widget/TextView;->setTextColor(I)V

    new-instance v12, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v13, 0x41c00000    # 24.0f

    invoke-direct {v0, v13}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v13

    const/high16 v14, 0x42300000    # 44.0f

    invoke-direct {v0, v14}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v15

    invoke-direct {v12, v13, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v8, v12}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v12, Landroid/widget/LinearLayout;

    invoke-direct {v12, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v12, v11}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/high16 v13, 0x40800000    # 4.0f

    invoke-direct {v0, v13}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v13

    invoke-direct {v0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-virtual {v12, v13, v2, v7, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v13, -0x2

    const/high16 v15, 0x3f800000    # 1.0f

    invoke-direct {v7, v2, v13, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v12, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v7, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v15, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->taskTitle:Ljava/lang/String;

    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    iget-object v15, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    invoke-virtual {v15}, Ljava/lang/String;->isEmpty()Z

    move-result v15

    if-eqz v15, :cond_4

    const-string v15, ""

    goto :goto_2

    :cond_4
    new-instance v15, Ljava/lang/StringBuilder;

    const-string v4, " \u00b7 "

    invoke-direct {v15, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->worker:Ljava/lang/String;

    invoke-virtual {v15, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    :goto_2
    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v7, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    invoke-static {v11}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result v7

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setMaxLines(I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    invoke-virtual {v4, v9, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->title:Landroid/widget/TextView;

    invoke-virtual {v12, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    invoke-static {v11}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    const/high16 v6, 0x41900000    # 18.0f

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    sget-object v6, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v4, v6, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    invoke-virtual {v12, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const-string v4, "\u25a0"

    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    const-string v6, "\u0130\u015f taymerini dayand\u0131r"

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v10}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-direct {v0, v14}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v10

    invoke-direct {v6, v7, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    new-instance v6, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda9;

    invoke-direct {v6, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda9;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v4, "\u2212"

    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v4

    const-string v6, "Taymeri y\u0131\u011f\u0131\u015fd\u0131r"

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x42000000    # 32.0f

    invoke-direct {v0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-direct {v0, v14}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v10

    invoke-direct {v6, v7, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v6, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda10;

    invoke-direct {v6, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda10;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v4, "\u00d7"

    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v4

    const/high16 v6, 0x41a00000    # 20.0f

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextSize(F)V

    const-string v6, "Taymeri dayand\u0131rmadan p\u0259nc\u0259r\u0259ni gizl\u0259t"

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x41e00000    # 28.0f

    invoke-direct {v0, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v7

    invoke-direct {v0, v14}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v10

    invoke-direct {v6, v7, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v6, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda11;

    invoke-direct {v6, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda11;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {v0, v5, v8}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->drag(Landroid/view/View;Landroid/view/View;)V

    goto :goto_3

    .line 71
    :cond_5
    invoke-virtual {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->elapsed()J

    move-result-wide v6

    invoke-direct {v0, v6, v7}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->format(J)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->actionButton(Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    invoke-static {v11}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    const/high16 v6, 0x41800000    # 16.0f

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    sget-object v6, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v4, v6, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    const-string v6, "\u0130\u015f taymeri. Geni\u015fl\u0259ndirm\u0259k \u00fc\u00e7\u00fcn toxunun"

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x1

    invoke-direct {v0, v10}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v8

    invoke-direct {v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v4, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda1;

    invoke-direct {v4, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V

    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    invoke-direct {v0, v5, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->drag(Landroid/view/View;Landroid/view/View;)V

    .line 72
    :goto_3
    new-instance v16, Landroid/view/WindowManager$LayoutParams;

    iget-boolean v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    if-eqz v4, :cond_6

    const/high16 v4, 0x43040000    # 132.0f

    goto :goto_4

    :cond_6
    const/high16 v4, 0x43a00000    # 320.0f

    :goto_4
    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v17

    iget-boolean v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    if-eqz v4, :cond_7

    const/high16 v4, 0x42500000    # 52.0f

    goto :goto_5

    :cond_7
    const/high16 v4, 0x42680000    # 58.0f

    :goto_5
    invoke-direct {v0, v4}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v18

    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1a

    if-lt v4, v6, :cond_8

    const/16 v4, 0x7f6

    goto :goto_6

    :cond_8
    const/16 v4, 0x7d2

    :goto_6
    move/from16 v19, v4

    const/16 v20, 0x128

    const/16 v21, -0x3

    invoke-direct/range {v16 .. v21}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    move-object/from16 v4, v16

    iput-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    const/16 v6, 0x31

    iput v6, v4, Landroid/view/WindowManager$LayoutParams;->gravity:I

    iget-object v4, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v1, v4, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v1, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput-object v5, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    :try_start_0
    iget-object v1, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    iget-object v3, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->params:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v1, v5, v3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v1, "adib_work_timer"

    invoke-virtual {v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v3, "hidden"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->updateClock()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iput-object v9, v0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->overlay:Landroid/view/View;

    const-string v1, "\u0130\u015f taymerini t\u0259tbiql\u0259rin \u00fcz\u0259rind\u0259 a\u00e7maq al\u0131nmad\u0131. ADIB icaz\u0259sini yoxlay\u0131n."

    invoke-static {v0, v1, v11}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private static start(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    .line 45
    :try_start_0
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

    const-string v0, "Work timer overlay could not start"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method static stop(Landroid/content/Context;)V
    .locals 2

    .line 44
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.WORK_TIMER_STOP"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->start(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method private stopCurrent()V
    .locals 4

    .line 77
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmation()V

    return-void

    :cond_0
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iput-boolean v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopping:Z

    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopButton:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    const-string v1, "\u2026"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->sessionId:Ljava/lang/String;

    iget v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->revision:I

    sget-object v2, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v3, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda2;

    invoke-direct {v3, p0, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService$$ExternalSyntheticLambda2;-><init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;I)V

    invoke-interface {v2, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void

    :cond_3
    :goto_0
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    invoke-virtual {p0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopSelf()V

    return-void
.end method

.method private surface()Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .line 67
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v1, 0x1

    invoke-static {v1}, Lcom/adib/maintenance/HybridUi;->surface(Z)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 v2, 0x41900000    # 18.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {p0, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->dp(F)I

    move-result v2

    invoke-static {v1}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result v1

    invoke-virtual {v0, v2, v1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    return-object v0
.end method

.method static sync(Landroid/content/Context;Lorg/json/JSONObject;J)V
    .locals 2

    .line 42
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/adib/maintenance/AdibWorkTimerOverlayService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.adib.maintenance.WORK_TIMER_SYNC"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    if-nez p1, :cond_0

    const-string p1, "{}"

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    const-string v1, "session"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    const-string v0, "serverNow"

    invoke-virtual {p1, v0, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->start(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method private toggleMini()V
    .locals 3

    .line 74
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showConfirmation()V

    return-void

    :cond_0
    iget-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    const-string v0, "adib_work_timer"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mini"

    iget-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showOverlay()V

    return-void
.end method

.method private updateClock()V
    .locals 3

    .line 75
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->clock:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->elapsed()J

    move-result-wide v1

    invoke-direct {p0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->format(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method private updateNotification()V
    .locals 3

    .line 64
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    if-eqz v0, :cond_0

    const/16 v1, 0x1020

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->notification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    :cond_0
    return-void
.end method


# virtual methods
.method elapsed()J
    .locals 9

    .line 61
    iget-wide v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->baseSeconds:J

    iget-boolean v2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    const-wide/16 v3, 0x0

    if-eqz v2, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    iget-wide v7, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    sub-long/2addr v5, v7

    const-wide/16 v7, 0x3e8

    div-long/2addr v5, v7

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    :cond_0
    add-long/2addr v0, v3

    return-wide v0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 1

    .line 46
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    const-string v0, "window"

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->wm:Landroid/view/WindowManager;

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->createChannel()V

    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 87
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->ticker:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopForeground(I)V

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 8

    .line 47
    const-string p2, "com.adib.maintenance.WORK_TIMER_REFRESH"

    if-nez p1, :cond_0

    move-object p3, p2

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p3

    .line 48
    :goto_0
    const-string v0, "com.adib.maintenance.WORK_TIMER_SYNC"

    invoke-virtual {v0, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    const-string v0, "session"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "serverNow"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p1, v1, v2, v3}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-direct {p0, v0, v1, v2}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->readSession(Ljava/lang/String;J)V

    goto :goto_1

    :cond_1
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->load()V

    .line 49
    :goto_1
    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    const/16 v0, 0x1020

    if-nez p1, :cond_2

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz p1, :cond_3

    :cond_2
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->notification()Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startForeground(ILandroid/app/Notification;)V

    .line 50
    :cond_3
    const-string p1, "com.adib.maintenance.WORK_TIMER_STOP"

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 v1, 0x2

    if-eqz p1, :cond_4

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopCurrent()V

    return v1

    .line 51
    :cond_4
    const-string p1, "com.adib.maintenance.WORK_TIMER_HIDE"

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const-string v2, "hidden"

    const/4 v3, 0x1

    const-string v4, "adib_work_timer"

    const/4 v5, 0x0

    if-eqz p1, :cond_7

    invoke-virtual {p0, v4, v5}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    if-nez p1, :cond_6

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-eqz p1, :cond_5

    goto :goto_2

    :cond_5
    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopSelf()V

    goto :goto_3

    :cond_6
    :goto_2
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->notification()Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startForeground(ILandroid/app/Notification;)V

    :goto_3
    return v1

    .line 52
    :cond_7
    const-string p1, "com.adib.maintenance.WORK_TIMER_TOGGLE"

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-nez p1, :cond_8

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    xor-int/2addr p1, v3

    iput-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    invoke-virtual {p0, v4, v5}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v6, "mini"

    iget-boolean v7, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->mini:Z

    invoke-interface {p1, v6, v7}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showOverlay()V

    .line 53
    :cond_8
    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_9

    invoke-virtual {p0, v4, v5}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1, v2, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 54
    :cond_9
    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    if-nez p1, :cond_a

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->confirming:Z

    if-nez p1, :cond_a

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->removeOverlay()V

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopForeground(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->stopSelf()V

    return v1

    .line 55
    :cond_a
    iget-wide p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    const-wide/16 v6, 0x0

    cmp-long p1, p1, v6

    if-nez p1, :cond_b

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startUptime:J

    :cond_b
    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->notification()Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->startForeground(ILandroid/app/Notification;)V

    .line 56
    invoke-virtual {p0, v4, v5}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1, v2, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-nez p1, :cond_c

    invoke-direct {p0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->showOverlay()V

    :cond_c
    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->handler:Landroid/os/Handler;

    iget-object p2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->ticker:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-boolean p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->running:Z

    if-eqz p1, :cond_d

    iget-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->ticker:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_d
    return v3
.end method
