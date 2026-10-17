.class public final Lcom/adib/maintenance/TaskReminderActivity;
.super Landroid/app/Activity;
.source "TaskReminderActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adib/maintenance/TaskReminderActivity$Each;
    }
.end annotation


# static fields
.field static final COMPLETE:Ljava/lang/String; = "com.adib.maintenance.REMINDER_COMPLETE"

.field static final IO:Ljava/util/concurrent/ExecutorService;

.field static final OPEN:Ljava/lang/String; = "com.adib.maintenance.REMINDER_OPEN"

.field static final SNOOZE:Ljava/lang/String; = "com.adib.maintenance.REMINDER_SNOOZE"

.field static final START:Ljava/lang/String; = "com.adib.maintenance.REMINDER_START"

.field static visible:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/adib/maintenance/TaskReminderActivity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field busy:Z

.field complete:Landroid/widget/Button;

.field content:Landroid/widget/LinearLayout;

.field dark:Z

.field done:Z

.field page:Ljava/lang/String;

.field queuedIntent:Landroid/content/Intent;

.field root:Landroid/widget/LinearLayout;

.field snooze:Landroid/widget/Button;

.field start:Landroid/widget/Button;

.field status:Landroid/widget/TextView;

.field task:Lorg/json/JSONObject;

.field transport:Lcom/adib/maintenance/TaskReminderActions$Transport;


# direct methods
.method public static synthetic $r8$lambda$-aeOkay9p_yeyaVfVG83qLGAcwc(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$button$1(Ljava/lang/Runnable;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$2_5MjuV_oNeB4Jw_h-qPMU9hbEA(Lcom/adib/maintenance/TaskReminderActivity;ZLandroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$lock$12(ZLandroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$3PEHMh_Fyzl-28GXEG9fjMMmNxM(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$pickTime$16(Ljava/lang/String;J)V

    return-void
.end method

.method public static synthetic $r8$lambda$5cRKHsmcGmjnCe2BykimthDJB0U(Lcom/adib/maintenance/TaskReminderActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$perform$15(Z)V

    return-void
.end method

.method public static synthetic $r8$lambda$7ItZINjywMVXhSUus0cOD3glpHw(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method public static synthetic $r8$lambda$7woWtF7dQuafWral6LRxN5XQSfY(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$9()V

    return-void
.end method

.method public static synthetic $r8$lambda$AXaNm0wP4EGnfbGfXd3Fw3nxa5Y(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$pickTime$17(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ErSHVJ9sJH4W-d4bjSbUac-EwPk(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$pickTime$18(Ljava/lang/String;J)V

    return-void
.end method

.method public static synthetic $r8$lambda$JD_Fcy_rONKfW5U0hH7j7011r2c(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$6()V

    return-void
.end method

.method public static synthetic $r8$lambda$OohewfJgdRB9iVvxKE1U5Soo31Q(Lcom/adib/maintenance/TaskReminderActivity;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$7(I)V

    return-void
.end method

.method public static synthetic $r8$lambda$PMbPdMJ6k7w1ai-C4DsZ51bgMb4(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$10()V

    return-void
.end method

.method public static synthetic $r8$lambda$Q9HGltfH8bZrqkljUbEcJk5cKbQ(Lcom/adib/maintenance/TaskReminderActivity;Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/TimePicker;II)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$pickTime$19(Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/TimePicker;II)V

    return-void
.end method

.method public static synthetic $r8$lambda$UOByvKMGgLCNPQy_Jk4pPcEVBjA(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$11()V

    return-void
.end method

.method public static synthetic $r8$lambda$aAKgtivcpVtailnMJtjvy0uh5jg(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$perform$14(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$cNf0wb0dYLUshwsYR3Mud01m4lA(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$onCreate$2()V

    return-void
.end method

.method public static synthetic $r8$lambda$cqvBWeDSDuiuXKYxuv6E3RH88rI(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$onCreate$3()V

    return-void
.end method

.method public static synthetic $r8$lambda$llaYaJ2sVVjd8CqVdtQLqpGBi-w(Lcom/adib/maintenance/TaskReminderActivity;Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/DatePicker;III)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$pickTime$20(Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/DatePicker;III)V

    return-void
.end method

.method public static synthetic $r8$lambda$okDxjio3q-OG40_5gJDSsnAHGOo(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$8()V

    return-void
.end method

.method public static synthetic $r8$lambda$uEdwIPwVSK22HgnDnBv95ULxVts(Lcom/adib/maintenance/TaskReminderActivity;ZLorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$perform$13(ZLorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$wTAbs3D_VksZiBtGvojI7BwfQSQ(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$4()V

    return-void
.end method

.method public static synthetic $r8$lambda$wcJ2Rmw0bhxfKum3M6_P1kbYoHY(Lcom/adib/maintenance/TaskReminderActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskReminderActivity;->lambda$render$5()V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 5
    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    .line 14
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/adib/maintenance/TaskReminderActivity;->IO:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 4
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 13
    const-string v0, "adib.testing"

    invoke-static {v0}, Ljava/lang/Boolean;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda6;

    invoke-direct {v0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda6;-><init>()V

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/adib/maintenance/TaskCalendarActivity$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Lcom/adib/maintenance/TaskCalendarActivity$$ExternalSyntheticLambda1;-><init>()V

    :goto_0
    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->transport:Lcom/adib/maintenance/TaskReminderActions$Transport;

    const/4 v0, 0x0

    .line 14
    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    const-string v0, "card"

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    return-void
.end method

.method static cardVisible()Z
    .locals 2

    .line 6
    sget-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adib/maintenance/TaskReminderActivity;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskReminderActivity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskReminderActivity;->isDestroyed()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {v0}, Lcom/adib/maintenance/LockscreenReminder;->locked(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static handles(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .line 7
    sget-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adib/maintenance/TaskReminderActivity;

    invoke-static {}, Lcom/adib/maintenance/TaskReminderActivity;->cardVisible()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskReminderActivity;->hasWindowFocus()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v1, :cond_1

    const-string v2, "id"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, v0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v1, "scope"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/adib/maintenance/DirectConfig;->scope(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    iget-object p1, v0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    :cond_0
    const/4 p0, 0x1

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private synthetic lambda$button$1(Ljava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    .line 15
    iget-boolean p2, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    if-nez p2, :cond_0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method private synthetic lambda$lock$12(ZLandroid/view/View;)V
    .locals 1

    .line 30
    instance-of v0, p2, Landroid/widget/Button;

    if-eqz v0, :cond_2

    if-nez p1, :cond_1

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    if-eqz p1, :cond_0

    const-string p1, "reminder-close"

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    :cond_0
    const/4 p1, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    invoke-virtual {p2, p1}, Landroid/view/View;->setEnabled(Z)V

    :cond_2
    return-void
.end method

.method static synthetic lambda$new$0(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 13
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Use a fixture transport"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private synthetic lambda$onCreate$2()V
    .locals 1

    const/4 v0, 0x0

    .line 16
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    return-void
.end method

.method private synthetic lambda$onCreate$3()V
    .locals 1

    const/4 v0, 0x1

    .line 16
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    return-void
.end method

.method private synthetic lambda$perform$13(ZLorg/json/JSONObject;)V
    .locals 2

    .line 32
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    const-string v1, "syncPending"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    const-string p2, "\u041f\u043e\u043c\u0438\u0434\u043e\u0440 \u0438\u0434\u0451\u0442. \u0421\u0438\u043d\u0445\u0440\u043e\u043d\u0438\u0437\u0430\u0446\u0438\u044f \u0441 Notion \u0432 \u043e\u0447\u0435\u0440\u0435\u0434\u0438."

    goto :goto_0

    :cond_2
    const-string p2, "\u041f\u043e\u043c\u0438\u0434\u043e\u0440 \u0437\u0430\u043f\u0443\u0449\u0435\u043d \u0434\u043b\u044f \u044d\u0442\u043e\u0439 \u0437\u0430\u0434\u0430\u0447\u0438"

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->start:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string p2, "id"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/adib/maintenance/TaskReminderReceiver;->dismiss(Landroid/content/Context;Ljava/lang/String;)V

    :goto_1
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->processQueued()V

    return-void
.end method

.method private synthetic lambda$perform$14(Ljava/lang/Exception;)V
    .locals 3

    .line 32
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u043f\u043e\u0434\u0442\u0432\u0435\u0440\u0434\u0438\u0442\u044c \u0434\u0435\u0439\u0441\u0442\u0432\u0438\u0435. "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    if-eqz v0, :cond_1

    const/16 v0, -0x5349

    goto :goto_0

    :cond_1
    const v0, -0x49ab9f

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->processQueued()V

    return-void
.end method

.method private synthetic lambda$perform$15(Z)V
    .locals 5

    .line 32
    const-string v0, "id"

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    iget-object v2, p0, Lcom/adib/maintenance/TaskReminderActivity;->transport:Lcom/adib/maintenance/TaskReminderActions$Transport;

    invoke-static {v1, v2}, Lcom/adib/maintenance/TaskReminderActions;->complete(Lorg/json/JSONObject;Lcom/adib/maintenance/TaskReminderActions$Transport;)Lorg/json/JSONObject;

    move-result-object v1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    iget-object v2, p0, Lcom/adib/maintenance/TaskReminderActivity;->transport:Lcom/adib/maintenance/TaskReminderActions$Transport;

    invoke-static {p0, v1, v2}, Lcom/adib/maintenance/TaskReminderActions;->start(Landroid/content/Context;Lorg/json/JSONObject;Lcom/adib/maintenance/TaskReminderActions$Transport;)Lorg/json/JSONObject;

    move-result-object v1

    :goto_0
    if-nez p1, :cond_1

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/adib/maintenance/AdibFloatingTimerService;->applyConfirmedListTimer(Landroid/content/Context;Lorg/json/JSONObject;)V

    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/adib/maintenance/TaskReminderSync;->enabled(Landroid/content/Context;Ljava/lang/String;Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/adib/maintenance/TaskReminderReceiver;->cancel(Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/adib/maintenance/PlannerCache;->invalidate(Landroid/content/Context;)V

    :cond_2
    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda10;

    invoke-direct {v0, p0, p1, v1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda10;-><init>(Lcom/adib/maintenance/TaskReminderActivity;ZLorg/json/JSONObject;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda14;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda14;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$pickTime$16(Ljava/lang/String;J)V
    .locals 2

    .line 34
    :try_start_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v1, "date"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->invalidate(Landroid/content/Context;)V

    invoke-virtual {p0, p2, p3}, Lcom/adib/maintenance/TaskReminderActivity;->snoozeAt(J)V

    return-void
.end method

.method private synthetic lambda$pickTime$17(Ljava/lang/Exception;)V
    .locals 3

    const/4 v0, 0x0

    .line 34
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u0414\u0430\u0442\u0430 \u043d\u0435 \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u0430: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private synthetic lambda$pickTime$18(Ljava/lang/String;J)V
    .locals 2

    .line 34
    :try_start_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-static {p0, v0}, Lcom/adib/maintenance/TaskReminderActions;->requireScope(Landroid/content/Context;Lorg/json/JSONObject;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->transport:Lcom/adib/maintenance/TaskReminderActions$Transport;

    invoke-static {v0, p1, v1}, Lcom/adib/maintenance/TaskReminderActions;->changeDate(Lorg/json/JSONObject;Ljava/lang/String;Lcom/adib/maintenance/TaskReminderActions$Transport;)Lorg/json/JSONObject;

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda11;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda11;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/String;J)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda12;

    invoke-direct {p2, p0, p1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda12;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/TaskReminderActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$pickTime$19(Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/TimePicker;II)V
    .locals 2

    const/16 p4, 0xb

    .line 34
    invoke-virtual {p1, p4, p5}, Ljava/util/Calendar;->set(II)V

    const/16 p4, 0xc

    invoke-virtual {p1, p4, p6}, Ljava/util/Calendar;->set(II)V

    const/16 p4, 0xd

    const/4 p5, 0x0

    invoke-virtual {p1, p4, p5}, Ljava/util/Calendar;->set(II)V

    const/16 p4, 0xe

    invoke-virtual {p1, p4, p5}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {p1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide p4

    iget-object p6, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eq p6, p2, :cond_0

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    const-string p2, "\u041d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435 \u0438\u0437\u043c\u0435\u043d\u0438\u043b\u043e\u0441\u044c. \u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0432\u0440\u0435\u043c\u044f \u0437\u0430\u043d\u043e\u0432\u043e."

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    cmp-long p2, p4, v0

    if-gtz p2, :cond_1

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    const-string p2, "\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0432\u0440\u0435\u043c\u044f \u0432 \u0431\u0443\u0434\u0443\u0449\u0435\u043c"

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    if-nez p3, :cond_2

    invoke-virtual {p0, p4, p5}, Lcom/adib/maintenance/TaskReminderActivity;->snoozeAt(J)V

    return-void

    :cond_2
    const/4 p2, 0x1

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    new-instance p2, Ljava/text/SimpleDateFormat;

    const-string p3, "yyyy-MM-dd\'T\'HH:mm:ssXXX"

    sget-object p6, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {p2, p3, p6}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    invoke-virtual {p1}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p1

    sget-object p2, Lcom/adib/maintenance/TaskReminderActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance p3, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda0;

    invoke-direct {p3, p0, p1, p4, p5}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda0;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/String;J)V

    invoke-interface {p2, p3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$pickTime$20(Ljava/util/Calendar;Lorg/json/JSONObject;ZLandroid/widget/DatePicker;III)V
    .locals 0

    .line 34
    invoke-virtual {p1, p5, p6, p7}, Ljava/util/Calendar;->set(III)V

    move-object p4, p1

    new-instance p1, Landroid/app/TimePickerDialog;

    move p5, p3

    new-instance p3, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda17;

    invoke-direct {p3, p0, p4, p2, p5}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda17;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/util/Calendar;Lorg/json/JSONObject;Z)V

    const/16 p2, 0xb

    invoke-virtual {p4, p2}, Ljava/util/Calendar;->get(I)I

    move-result p2

    const/16 p5, 0xc

    invoke-virtual {p4, p5}, Ljava/util/Calendar;->get(I)I

    move-result p5

    const/4 p6, 0x1

    move p4, p2

    move-object p2, p0

    invoke-direct/range {p1 .. p6}, Landroid/app/TimePickerDialog;-><init>(Landroid/content/Context;Landroid/app/TimePickerDialog$OnTimeSetListener;IIZ)V

    invoke-virtual {p1}, Landroid/app/TimePickerDialog;->show()V

    return-void
.end method

.method private synthetic lambda$render$10()V
    .locals 1

    const/4 v0, 0x1

    .line 25
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    return-void
.end method

.method private synthetic lambda$render$11()V
    .locals 1

    const/4 v0, 0x0

    .line 25
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    return-void
.end method

.method private synthetic lambda$render$4()V
    .locals 1

    .line 22
    const-string v0, "card"

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    return-void
.end method

.method private synthetic lambda$render$5()V
    .locals 2

    .line 22
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v0, :cond_0

    const-string v1, "id"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adib/maintenance/TaskReminderReceiver;->dismiss(Landroid/content/Context;Ljava/lang/String;)V

    :cond_0
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->finish()V

    return-void
.end method

.method private synthetic lambda$render$6()V
    .locals 0

    .line 22
    invoke-static {p0}, Lcom/adib/maintenance/TaskReminderReceiver;->openExactSettings(Landroid/app/Activity;)V

    return-void
.end method

.method private synthetic lambda$render$7(I)V
    .locals 2

    const/4 v0, 0x7

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    .line 24
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->pickTime(Z)V

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->preset(IJ)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->snoozeAt(J)V

    return-void
.end method

.method private synthetic lambda$render$8()V
    .locals 1

    const/4 v0, 0x1

    .line 24
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->pickTime(Z)V

    return-void
.end method

.method private synthetic lambda$render$9()V
    .locals 1

    .line 25
    const-string v0, "snooze"

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    return-void
.end method

.method static preset(IJ)J
    .locals 7

    const/4 v0, 0x4

    if-ge p0, v0, :cond_0

    .line 29
    new-array v0, v0, [J

    fill-array-data v0, :array_0

    aget-wide v1, v0, p0

    const-wide/32 v3, 0xea60

    mul-long/2addr v1, v3

    add-long/2addr p1, v1

    return-wide p1

    :cond_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/16 v2, 0xd

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    const/16 v2, 0xe

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    const/16 v2, 0xc

    const/16 v4, 0xb

    const/4 v5, 0x1

    const/4 v6, 0x5

    if-ne p0, v0, :cond_1

    invoke-virtual {v1, v6, v5}, Ljava/util/Calendar;->add(II)V

    const/16 p0, 0x9

    invoke-virtual {v1, v4, p0}, Ljava/util/Calendar;->set(II)V

    :goto_0
    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    goto :goto_1

    :cond_1
    if-ne p0, v6, :cond_2

    const/16 p0, 0x14

    invoke-virtual {v1, v4, p0}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v2

    cmp-long p0, v2, p1

    if-gtz p0, :cond_3

    invoke-virtual {v1, v6, v5}, Ljava/util/Calendar;->add(II)V

    goto :goto_1

    :cond_2
    invoke-virtual {v1, v4, v5}, Ljava/util/Calendar;->add(II)V

    goto :goto_0

    :cond_3
    :goto_1
    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide p0

    return-wide p0

    nop

    :array_0
    .array-data 8
        0xf
        0x1e
        0x3c
        0xb4
    .end array-data
.end method


# virtual methods
.method button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;
    .locals 1

    .line 15
    new-instance v0, Landroid/widget/Button;

    invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    invoke-static {v0, p1, p2}, Lcom/adib/maintenance/HybridUi;->button(Landroid/widget/Button;ZZ)V

    new-instance p1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda15;

    invoke-direct {p1, p0, p3}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda15;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object v0
.end method

.method configureLockscreen(Landroid/content/Intent;)V
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 21
    const-string v1, "lockscreen_reminder"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/adib/maintenance/LockscreenReminder;->enabled(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/adib/maintenance/LockscreenReminder;->allowed(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :cond_0
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1b

    if-lt p1, v1, :cond_1

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setShowWhenLocked(Z)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setTurnScreenOn(Z)V

    goto :goto_0

    :cond_1
    const/high16 p1, 0x280000

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    if-eqz v0, :cond_2

    invoke-virtual {v1, p1}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    :cond_2
    invoke-virtual {v1, p1}, Landroid/view/Window;->clearFlags(I)V

    :goto_0
    if-eqz v0, :cond_3

    const-string p1, "\u041a\u0430\u0440\u0442\u043e\u0447\u043a\u0430 \u043f\u043e\u043b\u043d\u043e\u044d\u043a\u0440\u0430\u043d\u043d\u043e\u0433\u043e \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u044f \u043e\u0442\u043a\u0440\u044b\u0442\u0430"

    invoke-static {p0, p1}, Lcom/adib/maintenance/TaskReminderReceiver;->event(Landroid/content/Context;Ljava/lang/String;)V

    :cond_3
    return-void
.end method

.method currentScope()Z
    .locals 2

    .line 31
    :try_start_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-static {p0, v0}, Lcom/adib/maintenance/TaskReminderActions;->requireScope(Landroid/content/Context;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    return v0
.end method

.method dp(I)I
    .locals 0

    .line 15
    invoke-static {p0, p1}, Lcom/adib/maintenance/NativeImageSupport;->dp(Landroid/content/Context;I)I

    move-result p1

    return p1
.end method

.method fitWindow()V
    .locals 6

    .line 28
    const-string v0, "snooze"

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    iget-object v2, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v2, :cond_0

    const-string v3, "test"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    invoke-static {p0, v2}, Lcom/adib/maintenance/ReminderCardView;->height(Landroid/content/Context;Z)I

    move-result v2

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    const/16 v3, 0x40

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v3

    sub-int/2addr v2, v3

    const/16 v3, 0x212

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    :goto_1
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-static {p0}, Lcom/adib/maintenance/ReminderCardView;->width(Landroid/content/Context;)I

    move-result v4

    const/16 v5, 0xdc

    invoke-virtual {p0, v5}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v5

    invoke-static {v5, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v3, v4, v2}, Landroid/view/Window;->setLayout(II)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v2

    if-nez v0, :cond_2

    const/16 v3, 0x51

    goto :goto_2

    :cond_2
    const/16 v3, 0x11

    :goto_2
    invoke-virtual {v2, v3}, Landroid/view/Window;->setGravity(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    if-nez v0, :cond_3

    const/16 v0, 0x12

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v1

    :cond_3
    iput v1, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v1, 0x3f6b851f    # 0.92f

    invoke-virtual {v0, v1}, Landroid/view/Window;->setDimAmount(F)V

    return-void
.end method

.method lock(Z)V
    .locals 2

    .line 30
    iput-boolean p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda9;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda9;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Z)V

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->walk(Landroid/view/View;Lcom/adib/maintenance/TaskReminderActivity$Each;)V

    return-void
.end method

.method public onBackPressed()V
    .locals 2

    .line 35
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v0, "snooze"

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "card"

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v0, :cond_2

    const-string v1, "id"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adib/maintenance/PendingReminderPopups;->consume(Landroid/content/Context;Ljava/lang/String;)V

    :cond_2
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 16
    invoke-static {p0}, Lcom/adib/maintenance/TaskManagementActivity;->mainPreferencesName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "dark_theme"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/adib/maintenance/R$style;->QuickPopupDark:I

    goto :goto_0

    :cond_0
    sget v0, Lcom/adib/maintenance/R$style;->QuickPopupLight:I

    :goto_0
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setTheme(I)V

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->configureLockscreen(Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v2, 0x106000d

    invoke-virtual {v0, v2}, Landroid/view/Window;->setBackgroundDrawableResource(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v2, 0x10

    invoke-virtual {v0, v2}, Landroid/view/Window;->setSoftInputMode(I)V

    invoke-virtual {p0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->setFinishOnTouchOutside(Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "task_id"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adib/maintenance/TaskReminderReceiver;->reference(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "test_popup"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/adib/maintenance/TaskReminderReceiver;->testTask()Lorg/json/JSONObject;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    :cond_1
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v0, :cond_2

    const-string v2, "id"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/adib/maintenance/ReminderPopupService;->dismissMatching(Ljava/lang/String;)V

    :cond_2
    if-eqz p1, :cond_3

    const-string v0, "page"

    const-string v2, "card"

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    const-string v0, "done"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    :cond_3
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->fitWindow()V

    if-nez p1, :cond_6

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz p1, :cond_6

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    const-string v0, "com.adib.maintenance.REMINDER_SNOOZE"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string p1, "snooze"

    iput-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    return-void

    :cond_4
    const-string v0, "com.adib.maintenance.REMINDER_START"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda7;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda7;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_5
    const-string v0, "com.adib.maintenance.REMINDER_COMPLETE"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda8;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda8;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    :cond_6
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .line 11
    sget-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p0, :cond_0

    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    :cond_0
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/adib/maintenance/ReminderPopupService;->resumePending(Landroid/content/Context;)V

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 1

    .line 17
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->queuedIntent:Landroid/content/Intent;

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->receive(Landroid/content/Intent;)V

    return-void
.end method

.method protected onPause()V
    .locals 2

    .line 9
    sget-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p0, :cond_0

    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 8
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/adib/maintenance/TaskReminderActivity;->visible:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .line 20
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "page"

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "done"

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    .line 10
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/adib/maintenance/LockscreenReminder;->locked(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v0, "id"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/adib/maintenance/PendingReminderPopups;->consume(Landroid/content/Context;Ljava/lang/String;)V

    invoke-static {p0}, Lcom/adib/maintenance/ReminderPopupService;->resumePending(Landroid/content/Context;)V

    :cond_0
    return-void
.end method

.method perform(Z)V
    .locals 2

    .line 32
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v0, :cond_2

    const-string v1, "test"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->currentScope()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    if-eqz p1, :cond_1

    const-string v1, "\u0421\u043e\u0445\u0440\u0430\u043d\u044f\u044e \u0432\u044b\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u0435\u2026"

    goto :goto_0

    :cond_1
    const-string v1, "\u0417\u0430\u043f\u0443\u0441\u043a\u0430\u044e \u041f\u043e\u043c\u0438\u0434\u043e\u0440\u2026"

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lcom/adib/maintenance/TaskReminderActivity;->IO:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda13;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda13;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Z)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_2
    :goto_1
    return-void
.end method

.method pickTime(Z)V
    .locals 8

    .line 34
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->currentScope()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v1

    new-instance v2, Landroid/app/DatePickerDialog;

    new-instance v4, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda16;

    invoke-direct {v4, p0, v1, v0, p1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda16;-><init>(Lcom/adib/maintenance/TaskReminderActivity;Ljava/util/Calendar;Lorg/json/JSONObject;Z)V

    const/4 p1, 0x1

    invoke-virtual {v1, p1}, Ljava/util/Calendar;->get(I)I

    move-result v5

    const/4 p1, 0x2

    invoke-virtual {v1, p1}, Ljava/util/Calendar;->get(I)I

    move-result v6

    const/4 p1, 0x5

    invoke-virtual {v1, p1}, Ljava/util/Calendar;->get(I)I

    move-result v7

    move-object v3, p0

    invoke-direct/range {v2 .. v7}, Landroid/app/DatePickerDialog;-><init>(Landroid/content/Context;Landroid/app/DatePickerDialog$OnDateSetListener;III)V

    invoke-virtual {v2}, Landroid/app/DatePickerDialog;->show()V

    return-void
.end method

.method processQueued()V
    .locals 2

    .line 19
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->queuedIntent:Landroid/content/Intent;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->queuedIntent:Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->receive(Landroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method receive(Landroid/content/Intent;)V
    .locals 3

    const/4 v0, 0x0

    .line 18
    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->setIntent(Landroid/content/Intent;)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->configureLockscreen(Landroid/content/Intent;)V

    const-string v1, "task_id"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/adib/maintenance/TaskReminderReceiver;->reference(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v1, "test_popup"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/adib/maintenance/TaskReminderReceiver;->testTask()Lorg/json/JSONObject;

    move-result-object v1

    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    :cond_0
    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v1, :cond_1

    const-string v2, "id"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/adib/maintenance/ReminderPopupService;->dismissMatching(Ljava/lang/String;)V

    :cond_1
    iput-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    const-string v1, "com.adib.maintenance.REMINDER_SNOOZE"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "snooze"

    goto :goto_0

    :cond_2
    const-string v1, "card"

    :goto_0
    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->render()V

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v1, :cond_4

    const-string v1, "com.adib.maintenance.REMINDER_START"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    return-void

    :cond_3
    const-string v0, "com.adib.maintenance.REMINDER_COMPLETE"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskReminderActivity;->perform(Z)V

    :cond_4
    return-void
.end method

.method render()V
    .locals 13

    .line 22
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v1, "snooze"

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->renderCompact()V

    return-void

    :cond_0
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    const/16 v3, 0x12

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v4

    const/16 v5, 0x10

    invoke-virtual {p0, v5}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v6

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v7

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v3

    invoke-virtual {v0, v4, v6, v7, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    iget-boolean v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    invoke-static {v3}, Lcom/adib/maintenance/HybridUi;->surface(Z)I

    move-result v3

    const/16 v4, 0x16

    invoke-virtual {p0, v4}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v4

    int-to-float v4, v4

    iget-boolean v6, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    invoke-static {v6}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result v6

    invoke-virtual {p0, v2}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v7

    invoke-static {v3, v4, v6, v7}, Lcom/adib/maintenance/HybridUi;->rounded(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->setGravity(I)V

    new-instance v3, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda18;

    invoke-direct {v3, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda18;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v4, "\u2190"

    const/4 v6, 0x0

    invoke-virtual {p0, v4, v6, v3}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v3

    iget-object v4, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/16 v7, 0x30

    const/16 v8, 0x2c

    if-eqz v4, :cond_1

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p0, v8}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v9

    invoke-virtual {p0, v7}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v10

    invoke-direct {v4, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_1
    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const-string v4, "\u041e\u0442\u0441\u0440\u043e\u0447\u043a\u0430"

    if-eqz v3, :cond_2

    move-object v3, v4

    goto :goto_0

    :cond_2
    const-string v3, "\u041d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435 \u00b7 ADIB"

    :goto_0
    invoke-virtual {p0, v3, v5}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v3

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, -0x2

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-direct {v9, v6, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda19;

    invoke-direct {v3, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda19;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v9, "\u00d7"

    invoke-virtual {p0, v9, v6, v3}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v3

    const-string v9, "\u0417\u0430\u043a\u0440\u044b\u0442\u044c \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435"

    invoke-virtual {v3, v9}, Landroid/widget/Button;->setContentDescription(Ljava/lang/CharSequence;)V

    const-string v9, "reminder-close"

    invoke-virtual {v3, v9}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p0, v8}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v8

    invoke-virtual {p0, v7}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v7

    invoke-direct {v9, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x1

    invoke-direct {v7, v8, v6, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    const-string v1, "\u041d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435 \u0431\u043e\u043b\u044c\u0448\u0435 \u043d\u0435\u0434\u043e\u0441\u0442\u0443\u043f\u043d\u043e. \u041e\u0442\u043a\u0440\u043e\u0439\u0442\u0435 \u0437\u0430\u0434\u0430\u0447\u0443 \u0432 ADIB."

    invoke-virtual {p0, v1, v5}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setContentView(Landroid/view/View;)V

    return-void

    :cond_3
    const-string v3, "title"

    const-string v5, "\u0417\u0430\u0434\u0430\u0447\u0430"

    invoke-virtual {v0, v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/16 v3, 0x19

    invoke-virtual {p0, v0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v0

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    const/16 v3, 0xc

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v5

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v7

    invoke-virtual {v0, v6, v5, v6, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    const-string v5, "reminder-title"

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v5, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v5, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v5, "date"

    const-string v7, ""

    invoke-virtual {v0, v5, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v0, "\u041b\u043e\u043a\u0430\u043b\u044c\u043d\u043e\u0435 \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435"

    goto :goto_1

    :cond_4
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v9, "\u0414\u0430\u0442\u0430 \u0437\u0430\u0434\u0430\u0447\u0438: "

    invoke-direct {v5, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/16 v9, 0x54

    const/16 v12, 0x20

    invoke-virtual {v0, v9, v12}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    const/16 v5, 0xd

    invoke-virtual {p0, v0, v5}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v0

    iget-boolean v9, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    invoke-static {v9}, Lcom/adib/maintenance/HybridUi;->muted(Z)I

    move-result v9

    invoke-virtual {v0, v9}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v9, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {p0}, Lcom/adib/maintenance/TaskReminderReceiver;->exactAllowed(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_5

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda20;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda20;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v9, "\u0420\u0430\u0437\u0440\u0435\u0448\u0438\u0442\u044c \u0442\u043e\u0447\u043d\u044b\u0435 \u043d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u044f"

    invoke-virtual {p0, v9, v6, v0}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    const/high16 v9, 0x41300000    # 11.0f

    invoke-virtual {v0, v9}, Landroid/widget/Button;->setTextSize(F)V

    iget-object v9, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_5
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    if-eqz v0, :cond_6

    const-string v7, "\u0417\u0430\u0434\u0430\u0447\u0430 \u0437\u0430\u0432\u0435\u0440\u0448\u0435\u043d\u0430"

    :cond_6
    invoke-virtual {p0, v7, v5}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    const-string v5, "reminder-status"

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    invoke-virtual {p0, v3}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v3

    const/16 v5, 0x8

    invoke-virtual {p0, v5}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v7

    invoke-virtual {v0, v6, v3, v6, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setAccessibilityLiveRegion(I)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 23
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v3, "test"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    const-string v1, "\u0422\u0435\u0441\u0442 \u043e\u043a\u043d\u0430. \u0417\u0430\u0434\u0430\u0447\u0438 \u043d\u0435 \u0438\u0437\u043c\u0435\u043d\u044f\u044e\u0442\u0441\u044f."

    const/16 v3, 0xe

    invoke-virtual {p0, v1, v3}, Lcom/adib/maintenance/TaskReminderActivity;->text(Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda21;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda21;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v3, "\u0417\u0430\u043a\u0440\u044b\u0442\u044c \u0442\u0435\u0441\u0442"

    invoke-virtual {p0, v3, v2, v1}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setContentView(Landroid/view/View;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->fitWindow()V

    return-void

    .line 24
    :cond_7
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->page:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    new-instance v0, Landroid/widget/GridLayout;

    invoke-direct {v0, p0}, Landroid/widget/GridLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/widget/GridLayout;->setColumnCount(I)V

    new-array v3, v5, [Ljava/lang/String;

    const-string v4, "15 \u043c\u0438\u043d."

    aput-object v4, v3, v6

    const-string v4, "30 \u043c\u0438\u043d."

    aput-object v4, v3, v2

    const-string v2, "1 \u0447\u0430\u0441"

    aput-object v2, v3, v1

    const-string v1, "3 \u0447\u0430\u0441\u0430"

    const/4 v2, 0x3

    aput-object v1, v3, v2

    const/4 v1, 0x4

    const-string v4, "\u0417\u0430\u0432\u0442\u0440\u0430, 09:00"

    aput-object v4, v3, v1

    const/4 v1, 0x5

    const-string v4, "\u0421\u0435\u0433\u043e\u0434\u043d\u044f \u0432\u0435\u0447\u0435\u0440\u043e\u043c"

    aput-object v4, v3, v1

    const/4 v1, 0x6

    const-string v4, "\u0421\u043b\u0435\u0434\u0443\u044e\u0449\u0438\u0439 \u0447\u0430\u0441"

    aput-object v4, v3, v1

    const/4 v1, 0x7

    const-string v4, "\u0412\u044b\u0431\u0440\u0430\u0442\u044c \u0432\u0440\u0435\u043c\u044f\u2026"

    aput-object v4, v3, v1

    move v1, v6

    :goto_2
    if-ge v1, v5, :cond_8

    aget-object v4, v3, v1

    new-instance v7, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda1;

    invoke-direct {v7, p0, v1}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/TaskReminderActivity;I)V

    invoke-virtual {p0, v4, v6, v7}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "snooze:"

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    const/high16 v7, 0x41400000    # 12.0f

    invoke-virtual {v4, v7}, Landroid/widget/Button;->setTextSize(F)V

    new-instance v7, Landroid/widget/GridLayout$LayoutParams;

    div-int/lit8 v8, v1, 0x2

    invoke-static {v8}, Landroid/widget/GridLayout;->spec(I)Landroid/widget/GridLayout$Spec;

    move-result-object v8

    rem-int/lit8 v9, v1, 0x2

    invoke-static {v9, v11}, Landroid/widget/GridLayout;->spec(IF)Landroid/widget/GridLayout$Spec;

    move-result-object v9

    invoke-direct {v7, v8, v9}, Landroid/widget/GridLayout$LayoutParams;-><init>(Landroid/widget/GridLayout$Spec;Landroid/widget/GridLayout$Spec;)V

    iput v6, v7, Landroid/widget/GridLayout$LayoutParams;->width:I

    invoke-virtual {p0, v2}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v8

    invoke-virtual {p0, v2}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v9

    invoke-virtual {p0, v2}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v10

    invoke-virtual {p0, v2}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v12

    invoke-virtual {v7, v8, v9, v10, v12}, Landroid/widget/GridLayout$LayoutParams;->setMargins(IIII)V

    invoke-virtual {v0, v4, v7}, Landroid/widget/GridLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_8
    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda2;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v1, "\u0418\u0437\u043c\u0435\u043d\u0438\u0442\u044c \u0434\u0430\u0442\u0443 \u0437\u0430\u0434\u0430\u0447\u0438\u2026"

    invoke-virtual {p0, v1, v6, v0}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    const-string v1, "reminder-change-date"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_3

    .line 25
    :cond_9
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    invoke-virtual {p0, v4, v6, v1}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->snooze:Landroid/widget/Button;

    const-string v3, "reminder-snooze"

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    new-instance v1, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda4;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v3, "\u0417\u0430\u0432\u0435\u0440\u0448\u0438\u0442\u044c"

    invoke-virtual {p0, v3, v6, v1}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    iput-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->complete:Landroid/widget/Button;

    const-string v3, "reminder-complete"

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->snooze:Landroid/widget/Button;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v6, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v6, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {p0, v5}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    iget-object v3, p0, Lcom/adib/maintenance/TaskReminderActivity;->complete:Landroid/widget/Button;

    invoke-virtual {v0, v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v0, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda5;

    invoke-direct {v0, p0}, Lcom/adib/maintenance/TaskReminderActivity$$ExternalSyntheticLambda5;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v1, "\u25b6 \u041d\u0430\u0447\u0430\u0442\u044c \u041f\u043e\u043c\u0438\u0434\u043e\u0440"

    invoke-virtual {p0, v1, v2, v0}, Lcom/adib/maintenance/TaskReminderActivity;->button(Ljava/lang/String;ZLjava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->start:Landroid/widget/Button;

    const-string v1, "reminder-start"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v1, 0xa

    invoke-virtual {p0, v1}, Lcom/adib/maintenance/TaskReminderActivity;->dp(I)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/adib/maintenance/TaskReminderActivity;->start:Landroid/widget/Button;

    invoke-virtual {v1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->complete:Landroid/widget/Button;

    invoke-virtual {v0, v6}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->start:Landroid/widget/Button;

    invoke-virtual {v0, v6}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->snooze:Landroid/widget/Button;

    invoke-virtual {v0, v6}, Landroid/widget/Button;->setEnabled(Z)V

    .line 26
    :cond_a
    :goto_3
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setContentView(Landroid/view/View;)V

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->fitWindow()V

    return-void
.end method

.method renderCompact()V
    .locals 4

    .line 27
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    new-instance v2, Lcom/adib/maintenance/TaskReminderActivity$1;

    invoke-direct {v2, p0}, Lcom/adib/maintenance/TaskReminderActivity$1;-><init>(Lcom/adib/maintenance/TaskReminderActivity;)V

    const-string v3, "reminder-"

    invoke-static {p0, v0, v1, v3, v2}, Lcom/adib/maintenance/ReminderCardView;->create(Landroid/content/Context;Lorg/json/JSONObject;ZLjava/lang/String;Lcom/adib/maintenance/ReminderCardView$Actions;)Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->content:Landroid/widget/LinearLayout;

    const-string v1, "reminder-status"

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->status:Landroid/widget/TextView;

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->done:Z

    if-eqz v1, :cond_0

    const-string v1, "\u0417\u0430\u0434\u0430\u0447\u0430 \u0437\u0430\u0432\u0435\u0440\u0448\u0435\u043d\u0430"

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    const-string v2, "test"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "ADIB \u00b7 \u0442\u0435\u0441\u0442 \u043e\u043a\u043d\u0430, \u0431\u0435\u0437 \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u044f \u0437\u0430\u0434\u0430\u0447"

    goto :goto_0

    :cond_1
    const-string v1, ""

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    const-string v1, "reminder-complete"

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->complete:Landroid/widget/Button;

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    const-string v1, "reminder-snooze"

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->snooze:Landroid/widget/Button;

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    const-string v1, "reminder-start"

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->start:Landroid/widget/Button;

    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->setContentView(Landroid/view/View;)V

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->busy:Z

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->fitWindow()V

    return-void
.end method

.method snoozeAt(J)V
    .locals 2

    .line 33
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    if-eqz v0, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    cmp-long v0, p1, v0

    if-lez v0, :cond_2

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->currentScope()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskReminderActivity;->task:Lorg/json/JSONObject;

    invoke-static {p0, v0, p1, p2}, Lcom/adib/maintenance/TaskReminderReceiver;->schedule(Landroid/content/Context;Lorg/json/JSONObject;J)V

    const-string p1, "\u041d\u0430\u043f\u043e\u043c\u0438\u043d\u0430\u043d\u0438\u0435 \u043e\u0442\u043b\u043e\u0436\u0435\u043d\u043e"

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    iget-object p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->queuedIntent:Landroid/content/Intent;

    if-eqz p1, :cond_1

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/TaskReminderActivity;->lock(Z)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->processQueued()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskReminderActivity;->finish()V

    :cond_2
    :goto_0
    return-void
.end method

.method text(Ljava/lang/String;I)Landroid/widget/TextView;
    .locals 1

    .line 15
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    int-to-float p1, p2

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskReminderActivity;->dark:Z

    invoke-static {p1}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    return-object v0
.end method

.method walk(Landroid/view/View;Lcom/adib/maintenance/TaskReminderActivity$Each;)V
    .locals 3

    .line 30
    invoke-interface {p2, p1}, Lcom/adib/maintenance/TaskReminderActivity$Each;->apply(Landroid/view/View;)V

    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    move-object v1, p1

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v0, v2, :cond_0

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, p2}, Lcom/adib/maintenance/TaskReminderActivity;->walk(Landroid/view/View;Lcom/adib/maintenance/TaskReminderActivity$Each;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method
