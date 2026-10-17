.class public Lcom/adib/maintenance/TaskManagementActivity;
.super Landroid/app/Activity;
.source "TaskManagementActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adib/maintenance/TaskManagementActivity$Transport;,
        Lcom/adib/maintenance/TaskManagementActivity$Operation;,
        Lcom/adib/maintenance/TaskManagementActivity$Pair;,
        Lcom/adib/maintenance/TaskManagementActivity$ApiError;
    }
.end annotation


# static fields
.field private static final BLUE:I


# instance fields
.field busy:Z

.field containers:Lorg/json/JSONArray;

.field content:Landroid/widget/LinearLayout;

.field dark:Z

.field day:Ljava/lang/String;

.field feedback:Landroid/widget/TextView;

.field private final fetchIO:Ljava/util/concurrent/ExecutorService;

.field fresh:Z

.field private generation:J

.field havePersonalCache:Z

.field private final io:Ljava/util/concurrent/ExecutorService;

.field list:Landroid/widget/LinearLayout;

.field query:Ljava/lang/String;

.field refreshing:Z

.field review:Ljava/lang/String;

.field root:Landroid/widget/LinearLayout;

.field private scroll:Landroid/widget/ScrollView;

.field shown:I

.field state:Lorg/json/JSONObject;

.field private statusError:Z

.field private statusText:Ljava/lang/String;

.field tab:Ljava/lang/String;

.field tasks:Lorg/json/JSONArray;

.field transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

.field writeConfirmed:Z


# direct methods
.method public static synthetic $r8$lambda$-6AlwvwxzPuCwVloJ3rG8vM6TuQ(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$startTask$33(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$1ePTkII4LxdNPDt7q7aUjN_ZI_4(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$taskTitle$9(Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$33ouulm8UpADdu6YvI5JcmdfKew(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$renderList$22()V

    return-void
.end method

.method public static synthetic $r8$lambda$5dw1t10XJI-44a7JNBx4_05b0gk(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$7(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$8gP3fTYgTmFPIf5NviGYjyS4lko(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$11(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$8ndwNLUUanTUShq2ueMTw93UPxQ(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$6()V

    return-void
.end method

.method public static synthetic $r8$lambda$BkkjKx9e6zvujFqzUGiobdT3GH0(Lcom/adib/maintenance/TaskManagementActivity;Landroid/app/AlertDialog;Landroid/widget/EditText;Ljava/lang/String;Landroid/content/DialogInterface;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$editEstimate$17(Landroid/app/AlertDialog;Landroid/widget/EditText;Ljava/lang/String;Landroid/content/DialogInterface;)V

    return-void
.end method

.method public static synthetic $r8$lambda$DMnJIOzn2Y1y0NMFKolk08umbfA(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$renderList$18(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$DvY90Hrgc9vblDfpObtv1SjZbuU(Lcom/adib/maintenance/TaskManagementActivity;ZLorg/json/JSONObject;Ljava/util/concurrent/atomic/AtomicLong;)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$fetchPair$37(ZLorg/json/JSONObject;Ljava/util/concurrent/atomic/AtomicLong;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$FgnQsJCYzjHqdjHqgHXx1bA4lEI(Lcom/adib/maintenance/TaskManagementActivity;ZJ)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$fetchPair$36(ZJ)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$FxELu_cJ3TqArk4JiYjM6BtSQyE(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$12(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$GPJEgfHJ9Jw-i5UYJbIgFLabFhI(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$renderList$21(Lorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$HH1cl678j-xmrcbBoA-gR1Sov_g(Lcom/adib/maintenance/TaskManagementActivity;JLorg/json/JSONObject;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$fetchPair$35(JLorg/json/JSONObject;)V

    return-void
.end method

.method public static synthetic $r8$lambda$IchBFFMItutQYgyF4dcs5ArMEZU(Lcom/adib/maintenance/TaskManagementActivity;JZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reload$45(JZ)V

    return-void
.end method

.method public static synthetic $r8$lambda$MqCxJt18iCRBLFZoDduZ8W4cCuw(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$confirmDelete$30(Lorg/json/JSONObject;Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$NVWe_LMMggLWRiDwJ8xoVwVUyps(Lcom/adib/maintenance/TaskManagementActivity;[Ljava/lang/String;Landroid/widget/Button;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reviewForm$26([Ljava/lang/String;Landroid/widget/Button;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$NgNraRnyFIorgjY8rtGPZl_IVWE(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$update$31(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$P7pVNuVg6Fi_F7KKz9qUislhz9U(Lcom/adib/maintenance/TaskManagementActivity;Landroid/widget/EditText;Ljava/lang/String;Landroid/app/AlertDialog;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$editEstimate$16(Landroid/widget/EditText;Ljava/lang/String;Landroid/app/AlertDialog;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$PVOgGCBYLk2ggsbtd5u5U9kVnZU(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reviewForm$27(Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$QOOYIhbU7JmEOV6i11jqB1MQCRk(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$8()V

    return-void
.end method

.method public static synthetic $r8$lambda$QkSQjmBGPDXe3O544Q-y02YclN0(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$15(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$RsgjjbTE5k2uolU_HOCYRDYpfqQ(Lcom/adib/maintenance/TaskManagementActivity;JLcom/adib/maintenance/TaskManagementActivity$Pair;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reload$43(JLcom/adib/maintenance/TaskManagementActivity$Pair;)V

    return-void
.end method

.method public static synthetic $r8$lambda$SyFnn-If2iuNXBan6yK3rZY45fk(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$10(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$TI_3HIwmD_ey8QX0qFeZJZc3vps(Lcom/adib/maintenance/TaskManagementActivity;JLjava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reload$44(JLjava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Ur6MSHLr6d-p2WcQ-R4BJydvqG0(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$13(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$X0sO4uJBFyJYRZjmHJ9ej8bXm74(Lcom/adib/maintenance/TaskManagementActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$perform$39(Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$XSrEN_q3_GiW4uHLT5WNTVJFicE(Lcom/adib/maintenance/TaskManagementActivity;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Landroid/app/AlertDialog;Ljava/lang/String;Landroid/view/View;)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reviewForm$28(Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Landroid/app/AlertDialog;Ljava/lang/String;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$XdSG8j6MaghkJjPpTlwPTd8E1tk(Lcom/adib/maintenance/TaskManagementActivity;Lcom/adib/maintenance/TaskManagementActivity$Operation;JLjava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$perform$42(Lcom/adib/maintenance/TaskManagementActivity$Operation;JLjava/lang/Runnable;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ZloeouzdO7ZFkaTt1orHt2K-_-Y(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$4()V

    return-void
.end method

.method public static synthetic $r8$lambda$aru6_36-AqvNLYkN83IxfDddv0M(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method public static synthetic $r8$lambda$c6-cCcqezrmop-dDJfPoMqKaKJ4(Lcom/adib/maintenance/TaskManagementActivity;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$dUv426GjYhMQXX9vUrqitI5qZ9Q(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$finishTask$34(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$iLICZD7dEAkJ9t66Gh-yn7NMkSQ(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;Ljava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$button$0(Ljava/lang/String;Ljava/lang/Runnable;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$kkUcImk54E899sEVctFr69ZjrJ4(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$dayCard$14(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$lezNGs1DzTzz6eZespFiDeW9fYQ(Lcom/adib/maintenance/TaskManagementActivity;JLcom/adib/maintenance/TaskManagementActivity$Pair;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$perform$38(JLcom/adib/maintenance/TaskManagementActivity$Pair;)V

    return-void
.end method

.method public static synthetic $r8$lambda$rfNRDylQcGDtRvOUzWsXU5bufG4(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$startTask$32(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$sD4a76911s2s3xn3cgdTuS0X4Hc(Lcom/adib/maintenance/TaskManagementActivity;Landroid/app/AlertDialog;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Ljava/lang/String;Landroid/content/DialogInterface;)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$reviewForm$29(Landroid/app/AlertDialog;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Ljava/lang/String;Landroid/content/DialogInterface;)V

    return-void
.end method

.method public static synthetic $r8$lambda$sFE-8WFM6qBrckujFuLfG2b7Log(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$renderList$20(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$v2RJIedDQiKoUy6FIZD8IDjqQDI(Lcom/adib/maintenance/TaskManagementActivity;[Landroid/widget/EditText;[I[I[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$settingsForm$23([Landroid/widget/EditText;[I[I[Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$vTdufDUgXGQz5qeSYrvrAltVUXg(Lcom/adib/maintenance/TaskManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$render$5()V

    return-void
.end method

.method public static synthetic $r8$lambda$w8FWRkL_JlGsJ0_MMQ0QEnlqCJM(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$renderList$19(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$xJ-2IoRtZqEPHm8G83iu6qBRw5E(Lcom/adib/maintenance/TaskManagementActivity;JLjava/lang/Exception;Ljava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->lambda$perform$41(JLjava/lang/Exception;Ljava/lang/Runnable;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgetscroll(Lcom/adib/maintenance/TaskManagementActivity;)Landroid/widget/ScrollView;
    .locals 0

    iget-object p0, p0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$malive(Lcom/adib/maintenance/TaskManagementActivity;)Z
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$mdp(Lcom/adib/maintenance/TaskManagementActivity;F)I
    .locals 0

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$mlabel(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;IZ)Landroid/widget/TextView;
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mpanel(Lcom/adib/maintenance/TaskManagementActivity;)I
    .locals 0

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->panel()I

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 41
    sget v0, Lcom/adib/maintenance/HybridUi;->BLUE:I

    sput v0, Lcom/adib/maintenance/TaskManagementActivity;->BLUE:I

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 27
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 33
    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda47;

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda47;-><init>()V

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    .line 34
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->io:Ljava/util/concurrent/ExecutorService;

    const/4 v0, 0x2

    .line 35
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->fetchIO:Ljava/util/concurrent/ExecutorService;

    const/4 v0, 0x0

    .line 36
    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    const-string v1, ""

    iput-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusError:Z

    .line 37
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->containers:Lorg/json/JSONArray;

    .line 38
    invoke-static {}, Lcom/adib/maintenance/TaskManagementActivity;->today()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    const-string v2, "day"

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    const-string v2, "incoming"

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->review:Ljava/lang/String;

    iput-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    const/16 v1, 0x14

    .line 39
    iput v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->writeConfirmed:Z

    return-void
.end method

.method private accent()I
    .locals 1

    .line 61
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0}, Lcom/adib/maintenance/HybridUi;->accent(Z)I

    move-result v0

    return v0
.end method

.method private alive()Z
    .locals 1

    .line 73
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private allowed(Ljava/lang/String;)Z
    .locals 3

    .line 153
    const-string v0, "delete:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    if-nez p1, :cond_0

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    if-eqz p1, :cond_0

    return v1

    :cond_0
    return v2

    :cond_1
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    if-nez v0, :cond_4

    const-string v0, "refresh"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    if-nez v0, :cond_4

    :cond_2
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->mutationTag(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    if-eqz p1, :cond_4

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    if-nez p1, :cond_4

    :cond_3
    return v1

    :cond_4
    return v2
.end method

.method private applyPair(Lcom/adib/maintenance/TaskManagementActivity$Pair;)V
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 156
    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    invoke-virtual {v2}, Landroid/widget/ScrollView;->getScrollY()I

    move-result v2

    :goto_0
    iget-object v4, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    const-string v6, "search"

    if-nez v4, :cond_1

    const/4 v4, 0x0

    goto :goto_1

    :cond_1
    invoke-direct {v0, v4, v6}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v4

    :goto_1
    const/4 v7, 0x1

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Landroid/view/View;->hasFocus()Z

    move-result v8

    if-eqz v8, :cond_2

    move v8, v7

    goto :goto_2

    :cond_2
    move v8, v3

    :goto_2
    instance-of v9, v4, Landroid/widget/EditText;

    if-eqz v9, :cond_3

    check-cast v4, Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v4

    goto :goto_3

    :cond_3
    move v4, v3

    :goto_3
    new-instance v9, Ljava/util/HashMap;

    invoke-direct {v9}, Ljava/util/HashMap;-><init>()V

    const/4 v10, 0x4

    new-array v11, v10, [Ljava/lang/String;

    const-string v12, "dailyTaskLimit"

    aput-object v12, v11, v3

    const-string v12, "wipLimit"

    aput-object v12, v11, v7

    const/4 v12, 0x2

    const-string v13, "budgetMinutes"

    aput-object v13, v11, v12

    const/4 v12, 0x3

    const-string v13, "staleDays"

    aput-object v13, v11, v12

    const-string v12, ""

    move v13, v3

    :goto_4
    if-ge v13, v10, :cond_7

    aget-object v14, v11, v13

    iget-object v15, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    if-nez v15, :cond_4

    const/4 v15, 0x0

    goto :goto_5

    :cond_4
    invoke-direct {v0, v15, v14}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v15

    :goto_5
    instance-of v5, v15, Landroid/widget/EditText;

    if-eqz v5, :cond_6

    move-object v5, v15

    check-cast v5, Landroid/widget/EditText;

    invoke-virtual {v5}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v10

    invoke-virtual {v10, v14}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v10

    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v5, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_5

    invoke-interface {v9, v14, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_5
    invoke-virtual {v15}, Landroid/view/View;->hasFocus()Z

    move-result v5

    if-eqz v5, :cond_6

    move-object v12, v14

    :cond_6
    add-int/lit8 v13, v13, 0x1

    const/4 v10, 0x4

    goto :goto_4

    .line 157
    :cond_7
    iget-object v5, v1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->state:Lorg/json/JSONObject;

    invoke-static {v0, v5}, Lcom/adib/maintenance/OfflineDeletes;->filterState(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v5

    iput-object v5, v0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    iget-object v5, v1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personal:Lorg/json/JSONObject;

    const-string v10, "tasks"

    invoke-static {v5, v10}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v5

    invoke-static {v0, v5}, Lcom/adib/maintenance/OfflineDeletes;->filterTasks(Landroid/content/Context;Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object v5

    iput-object v5, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    iget-object v1, v1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personal:Lorg/json/JSONObject;

    const-string v5, "containers"

    invoke-static {v1, v5}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->containers:Lorg/json/JSONArray;

    iput-boolean v7, v0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    iput-boolean v7, v0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    iput-boolean v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    iput-boolean v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    const-string v1, "\u041e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u043e"

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    iput-boolean v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->statusError:Z

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V

    invoke-interface {v9}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_8
    :goto_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_9

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    iget-object v7, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-direct {v0, v7, v9}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v7

    instance-of v9, v7, Landroid/widget/EditText;

    if-eqz v9, :cond_8

    check-cast v7, Landroid/widget/EditText;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v7, v5}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_6

    :cond_9
    if-eqz v8, :cond_a

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-direct {v0, v1, v6}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    if-eqz v1, :cond_b

    invoke-virtual {v1}, Landroid/widget/EditText;->requestFocus()Z

    invoke-virtual {v1}, Landroid/widget/EditText;->length()I

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/EditText;->setSelection(I)V

    goto :goto_7

    :cond_a
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_b

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-direct {v0, v1, v12}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_b

    invoke-virtual {v1}, Landroid/view/View;->requestFocus()Z

    :cond_b
    :goto_7
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    if-eqz v1, :cond_c

    invoke-virtual {v1}, Landroid/widget/ScrollView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v3

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$4;

    invoke-direct {v4, v0, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity$4;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/widget/ScrollView;I)V

    invoke-virtual {v3, v4}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    :cond_c
    return-void
.end method

.method static array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;
    .locals 0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    .line 47
    :cond_0
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    :goto_0
    if-nez p0, :cond_1

    new-instance p0, Lorg/json/JSONArray;

    invoke-direct {p0}, Lorg/json/JSONArray;-><init>()V

    :cond_1
    return-object p0
.end method

.method private bg()I
    .locals 1

    .line 57
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0}, Lcom/adib/maintenance/HybridUi;->bg(Z)I

    move-result v0

    return v0
.end method

.method static budget(Lorg/json/JSONArray;Lorg/json/JSONObject;)I
    .locals 5

    const/4 v0, 0x0

    move v1, v0

    .line 55
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v0, v2, :cond_0

    invoke-virtual {p0, v0}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "estimateMinutes"

    const/16 v4, 0x19

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return v1
.end method

.method private button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;
    .locals 5

    .line 76
    new-instance v0, Landroid/widget/Button;

    invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p2}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setAllCaps(Z)V

    const/high16 v1, 0x41600000    # 14.0f

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextSize(F)V

    const/high16 v1, 0x42400000    # 48.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setMinHeight(I)V

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setMinimumHeight(I)V

    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x41000000    # 8.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v4

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    invoke-virtual {v0, v2, v4, v1, v3}, Landroid/widget/Button;->setPadding(IIII)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->accent()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextColor(I)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->panel()I

    move-result v1

    iget-boolean v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v2}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result v2

    invoke-direct {p0, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->shape(II)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0, v1, p1}, Lcom/adib/maintenance/HybridUi;->button(Landroid/widget/Button;ZZ)V

    new-instance p1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda44;

    invoke-direct {p1, p0, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda44;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;Ljava/lang/Runnable;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0, p2}, Lcom/adib/maintenance/TaskManagementActivity;->allowed(Ljava/lang/String;)Z

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    invoke-virtual {v0}, Landroid/widget/Button;->isEnabled()Z

    move-result p1

    if-eqz p1, :cond_0

    const/high16 p1, 0x3f800000    # 1.0f

    goto :goto_0

    :cond_0
    const p1, 0x3ee66666    # 0.45f

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/Button;->setAlpha(F)V

    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 p2, -0x1

    const/4 p3, -0x2

    invoke-direct {p1, p2, p3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 p2, 0x40a00000    # 5.0f

    invoke-direct {p0, p2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p3

    iput p3, p1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    invoke-direct {p0, p2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p2

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method private card(Landroid/widget/LinearLayout;Z)Landroid/widget/LinearLayout;
    .locals 5

    .line 77
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    const/high16 v1, 0x41600000    # 14.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x41400000    # 12.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v4

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    invoke-virtual {v0, v2, v4, v1, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    if-eqz p2, :cond_0

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v1}, Lcom/adib/maintenance/HybridUi;->outgoing(Z)I

    move-result v1

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->panel()I

    move-result v1

    :goto_0
    if-eqz p2, :cond_1

    sget p2, Lcom/adib/maintenance/TaskManagementActivity;->BLUE:I

    goto :goto_1

    :cond_1
    iget-boolean p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {p2}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result p2

    :goto_1
    invoke-direct {p0, v1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->shape(II)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance p2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {p2, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v1, 0x41100000    # 9.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    iput v1, p2, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    const/high16 v1, 0x40800000    # 4.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    iput v1, p2, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    invoke-virtual {p1, v0, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method private chooseDate(Ljava/lang/String;Ljava/util/function/Consumer;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/function/Consumer<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 81
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    :try_start_0
    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy-MM-dd"

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {v1, v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/text/SimpleDateFormat;->setLenient(Z)V

    invoke-virtual {v1, p1}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    new-instance v1, Landroid/app/DatePickerDialog;

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    if-eqz p1, :cond_0

    sget p1, Lcom/adib/maintenance/R$style;->AdibDialogDark:I

    goto :goto_0

    :cond_0
    sget p1, Lcom/adib/maintenance/R$style;->AdibDialogLight:I

    :goto_0
    move v3, p1

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda4;

    invoke-direct {v4, p2}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda4;-><init>(Ljava/util/function/Consumer;)V

    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->get(I)I

    move-result v5

    const/4 p1, 0x2

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->get(I)I

    move-result v6

    const/4 p1, 0x5

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->get(I)I

    move-result v7

    move-object v2, p0

    invoke-direct/range {v1 .. v7}, Landroid/app/DatePickerDialog;-><init>(Landroid/content/Context;ILandroid/app/DatePickerDialog$OnDateSetListener;III)V

    invoke-virtual {v1}, Landroid/app/DatePickerDialog;->show()V

    return-void
.end method

.method private column()Landroid/widget/LinearLayout;
    .locals 2

    .line 75
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    return-object v0
.end method

.method static command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 2

    .line 48
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "type"

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    if-eqz p1, :cond_0

    const-string p0, "id"

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    if-eqz p2, :cond_1

    const-string p0, "day"

    invoke-virtual {v0, p0, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-object v0
.end method

.method private confirmDelete(Lorg/json/JSONObject;)V
    .locals 3

    .line 142
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->dialog()Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "\u0423\u0434\u0430\u043b\u0438\u0442\u044c \u0437\u0430\u0434\u0430\u0447\u0443?"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "title"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\u0417\u0430\u0434\u0430\u0447\u0430 \u0438\u0441\u0447\u0435\u0437\u043d\u0435\u0442 \u043d\u0430 \u0443\u0441\u0442\u0440\u043e\u0439\u0441\u0442\u0432\u0435. \u0423\u0434\u0430\u043b\u0435\u043d\u0438\u0435 \u0432 Notion \u0431\u0443\u0434\u0435\u0442 \u043e\u0442\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u043e \u043f\u0440\u0438 \u043f\u043e\u044f\u0432\u043b\u0435\u043d\u0438\u0438 \u0441\u0432\u044f\u0437\u0438."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "\u041e\u0442\u043c\u0435\u043d\u0430"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda25;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda25;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    const-string p1, "\u0423\u0434\u0430\u043b\u0438\u0442\u044c"

    invoke-virtual {v0, p1, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method static contains(Lorg/json/JSONArray;Ljava/lang/String;)Z
    .locals 3

    const/4 v0, 0x0

    move v1, v0

    .line 49
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_1

    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return v0
.end method

.method private dayCard(Ljava/lang/String;)V
    .locals 9

    .line 114
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->find(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->plan()Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "mainId"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, v2, v1}, Lcom/adib/maintenance/TaskManagementActivity;->card(Landroid/widget/LinearLayout;Z)Landroid/widget/LinearLayout;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "task:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    const/4 v3, 0x1

    const/16 v4, 0xe

    if-eqz v1, :cond_0

    .line 115
    const-string v1, "\u2605 \u0413\u043b\u0430\u0432\u043d\u044b\u0439 \u0440\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442"

    invoke-direct {p0, v1, v4, v3}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 116
    :cond_0
    const-string v1, "remove:"

    const-string v5, "\u0423\u0431\u0440\u0430\u0442\u044c \u0438\u0437 \u0434\u043d\u044f"

    if-nez v0, :cond_1

    const-string v0, "\u0417\u0430\u0434\u0430\u0447\u0430 \u043d\u0435\u0434\u043e\u0441\u0442\u0443\u043f\u043d\u0430"

    const/16 v4, 0x10

    invoke-direct {p0, v0, v4, v3}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda15;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    invoke-direct {p0, v5, v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object p1

    invoke-virtual {v2, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void

    .line 117
    :cond_1
    invoke-direct {p0, v2, v0}, Lcom/adib/maintenance/TaskManagementActivity;->taskTitle(Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "status"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " \u00b7 \ud83c\udf45 "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "pomodoroCount"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v6

    const-string v7, "pomodoroTotalCount"

    invoke-virtual {v0, v7, v6}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " \u00b7 "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "pomodoroMinutes"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;)D

    move-result-wide v6

    const-string v8, "pomodoroTotalMinutes"

    invoke-virtual {v0, v8, v6, v7}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Math;->round(D)J

    move-result-wide v6

    invoke-virtual {v3, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " \u043c\u0438\u043d"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v6, 0x0

    invoke-direct {p0, v0, v4, v6}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v4, "\u041e\u0446\u0435\u043d\u043a\u0430: "

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->estimate(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->meta(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "estimateMinutes"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, ""

    goto :goto_0

    :cond_2
    const-string v3, " (\u043f\u043e \u0443\u043c\u043e\u043b\u0447\u0430\u043d\u0438\u044e)"

    :goto_0
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "estimate:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda16;

    invoke-direct {v4, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda16;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    invoke-direct {p0, v0, v3, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 119
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "main:"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda17;

    invoke-direct {v3, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda17;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v4, "\u2605 \u0413\u043b\u0430\u0432\u043d\u0430\u044f"

    invoke-direct {p0, v4, v0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "start:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda18;

    invoke-direct {v4, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda18;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v6, "\u0412 \u0440\u0430\u0431\u043e\u0442\u0443"

    invoke-direct {p0, v6, v3, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v3

    invoke-direct {p0, v2, v0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V

    .line 120
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "finish:"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda19;

    invoke-direct {v3, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda19;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v4, "\u2713 \u0412\u044b\u043f\u043e\u043b\u043d\u0435\u043d\u043e"

    invoke-direct {p0, v4, v0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda20;

    invoke-direct {v3, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda20;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    invoke-direct {p0, v5, v1, v3}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object p1

    invoke-direct {p0, v2, v0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V

    return-void
.end method

.method private dialog()Landroid/app/AlertDialog$Builder;
    .locals 2

    .line 80
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-boolean v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    if-eqz v1, :cond_0

    sget v1, Lcom/adib/maintenance/R$style;->AdibDialogDark:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/adib/maintenance/R$style;->AdibDialogLight:I

    :goto_0
    invoke-direct {v0, p0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    return-object v0
.end method

.method private dp(F)I
    .locals 1

    .line 56
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getResources()Landroid/content/res/Resources;

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

.method private editEstimate(Ljava/lang/String;)V
    .locals 5

    .line 122
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    const/high16 v1, 0x41800000    # 16.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x40c00000    # 6.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v1, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->estimate(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    const-string v3, "\u041c\u0438\u043d\u0443\u0442\u044b, \u0446\u0435\u043b\u043e\u0435 \u0447\u0438\u0441\u043b\u043e 1\u201343200"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->field(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v1

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->dialog()Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const-string v3, "\u041e\u0446\u0435\u043d\u043a\u0430 \u0432\u0440\u0435\u043c\u0435\u043d\u0438"

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "\u041e\u0442\u043c\u0435\u043d\u0430"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "\u0421\u043e\u0445\u0440\u0430\u043d\u0438\u0442\u044c"

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda45;

    invoke-direct {v2, p0, v0, v1, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda45;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/app/AlertDialog;Landroid/widget/EditText;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method

.method static eligible(Lorg/json/JSONObject;Lorg/json/JSONObject;Lorg/json/JSONArray;Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 8

    const/4 v0, 0x0

    if-eqz p0, :cond_b

    .line 124
    const-string v1, "completed"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const-string v1, "checkDate"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v1, p4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-lez v2, :cond_1

    return v0

    .line 125
    :cond_1
    const-string v2, "waiting"

    invoke-virtual {v2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const-string v4, "disposition"

    const/4 v5, 0x1

    if-eqz v3, :cond_3

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_2

    invoke-virtual {v1, p4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    if-gtz p0, :cond_2

    return v5

    :cond_2
    return v0

    .line 126
    :cond_3
    const-string v3, "overdue"

    invoke-virtual {v3, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    const-string p1, "date"

    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_4

    const/16 p1, 0xa

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p2

    invoke-static {p1, p2}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-virtual {p0, v0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0, p4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    if-gez p0, :cond_4

    return v5

    :cond_4
    return v0

    .line 127
    :cond_5
    const-string v3, "stale"

    invoke-virtual {v3, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_7

    const-string p2, "updatedAt"

    invoke-virtual {p0, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p2, "reviewedAt"

    invoke-virtual {p1, p2, p0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    :try_start_0
    new-instance p1, Ljava/text/SimpleDateFormat;

    const-string p2, "yyyy-MM-dd\'T\'HH:mm:ss"

    sget-object p3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {p1, p2, p3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    const-string p2, "UTC"

    invoke-static {p2}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    invoke-virtual {p1, v0}, Ljava/text/SimpleDateFormat;->setLenient(Z)V

    const/16 p2, 0x13

    invoke-virtual {p0, v0, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/Date;->getTime()J

    move-result-wide p0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long p4, p5

    const-wide/32 v1, 0x5265c00

    mul-long/2addr p4, v1

    sub-long/2addr p2, p4

    cmp-long p0, p0, p2

    if-gez p0, :cond_6

    return v5

    :catch_0
    :cond_6
    return v0

    .line 128
    :cond_7
    const-string p3, "containerId"

    invoke-virtual {p0, p3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result p5

    move v3, v0

    :goto_0
    invoke-virtual {p2}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v3, v6, :cond_9

    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-eqz v6, :cond_8

    const-string v7, "id"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p3, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_8

    const-string v7, "name"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "inbox"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_8

    move p5, v5

    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_9
    if-eqz p5, :cond_b

    .line 129
    invoke-static {p0}, Lcom/adib/maintenance/TaskManagementActivity;->working(Lorg/json/JSONObject;)Z

    move-result p2

    if-nez p2, :cond_b

    const-string p2, "status"

    invoke-virtual {p0, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p2, "Delegate"

    invoke-virtual {p2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_b

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_b

    const-string p0, "later"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_a

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_b

    invoke-virtual {v1, p4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    if-gtz p0, :cond_b

    :cond_a
    return v5

    :cond_b
    :goto_1
    return v0
.end method

.method private error(Ljava/lang/String;)V
    .locals 1

    .line 161
    invoke-static {p1}, Lcom/adib/maintenance/OfflineNetwork;->error(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/adib/maintenance/OfflineNetwork;->message()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V

    return-void

    :cond_0
    if-nez p1, :cond_1

    const-string p1, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u0437\u0430\u0433\u0440\u0443\u0437\u0438\u0442\u044c \u0438\u043b\u0438 \u0441\u043e\u0445\u0440\u0430\u043d\u0438\u0442\u044c. \u041d\u0430\u0436\u043c\u0438\u0442\u0435 \u00ab\u041e\u0431\u043d\u043e\u0432\u0438\u0442\u044c\u00bb."

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private fetchPair(JZZ)Lcom/adib/maintenance/TaskManagementActivity$Pair;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    if-eqz p4, :cond_0

    .line 160
    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->read(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    goto :goto_0

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :goto_0
    const-string v1, "personalFetchedAt"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long/2addr v3, v1

    const-string v5, "personal"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const/4 v5, 0x1

    const-wide/16 v6, 0x0

    if-eqz p4, :cond_1

    cmp-long p4, v1, v6

    if-lez p4, :cond_1

    cmp-long p4, v3, v6

    if-ltz p4, :cond_1

    const-wide/16 v8, 0x3a98

    cmp-long p4, v3, v8

    if-gtz p4, :cond_1

    if-eqz v0, :cond_1

    const-string p4, "tasks"

    invoke-virtual {v0, p4}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p4

    if-eqz p4, :cond_1

    move p4, v5

    goto :goto_1

    :cond_1
    const/4 p4, 0x0

    :goto_1
    new-instance v3, Ljava/util/concurrent/atomic/AtomicLong;

    if-eqz p4, :cond_2

    goto :goto_2

    :cond_2
    move-wide v1, v6

    :goto_2
    invoke-direct {v3, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->fetchIO:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda5;

    invoke-direct {v2, p0, p3, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda5;-><init>(Lcom/adib/maintenance/TaskManagementActivity;ZJ)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/util/concurrent/Callable;)Ljava/util/concurrent/Future;

    move-result-object p1

    iget-object p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->fetchIO:Ljava/util/concurrent/ExecutorService;

    new-instance p3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda6;

    invoke-direct {p3, p0, p4, v0, v3}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda6;-><init>(Lcom/adib/maintenance/TaskManagementActivity;ZLorg/json/JSONObject;Ljava/util/concurrent/atomic/AtomicLong;)V

    invoke-interface {p2, p3}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/util/concurrent/Callable;)Ljava/util/concurrent/Future;

    move-result-object p2

    :try_start_0
    invoke-interface {p1}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lorg/json/JSONObject;

    invoke-interface {p2}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lorg/json/JSONObject;

    invoke-static {p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->validate(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$Pair;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v1

    invoke-direct {v0, p3, p4, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity$Pair;-><init>(Lorg/json/JSONObject;Lorg/json/JSONObject;J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p3

    invoke-interface {p1, v5}, Ljava/util/concurrent/Future;->cancel(Z)Z

    invoke-interface {p2, v5}, Ljava/util/concurrent/Future;->cancel(Z)Z

    instance-of p1, p3, Ljava/util/concurrent/ExecutionException;

    if-eqz p1, :cond_3

    invoke-virtual {p3}, Ljava/lang/Exception;->getCause()Ljava/lang/Throwable;

    move-result-object p1

    goto :goto_3

    :cond_3
    move-object p1, p3

    :goto_3
    instance-of p2, p1, Ljava/lang/Exception;

    if-eqz p2, :cond_4

    check-cast p1, Ljava/lang/Exception;

    throw p1

    :cond_4
    throw p3
.end method

.method private field(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Z)Landroid/widget/EditText;
    .locals 3

    const/16 v0, 0xe

    const/4 v1, 0x0

    .line 79
    invoke-direct {p0, p2, v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    new-instance p2, Landroid/widget/EditText;

    invoke-direct {p2, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->ink()I

    move-result p3

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setTextColor(I)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->muted()I

    move-result p3

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setHintTextColor(I)V

    const/high16 p3, 0x41800000    # 16.0f

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setTextSize(F)V

    const/high16 p3, 0x42400000    # 48.0f

    invoke-direct {p0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p3

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setMinHeight(I)V

    const/4 p3, 0x1

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setSingleLine(Z)V

    if-eqz p4, :cond_0

    const/4 p3, 0x2

    :cond_0
    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setInputType(I)V

    const/high16 p3, 0x41400000    # 12.0f

    invoke-direct {p0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p4

    const/high16 v0, 0x41000000    # 8.0f

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    invoke-direct {p0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p3

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v0

    invoke-virtual {p2, p4, v2, p3, v0}, Landroid/widget/EditText;->setPadding(IIII)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->panel()I

    move-result p3

    iget-boolean p4, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {p4}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result p4

    invoke-direct {p0, p3, p4}, Lcom/adib/maintenance/TaskManagementActivity;->shape(II)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    iget-boolean p3, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {p2, p3, v1}, Lcom/adib/maintenance/HybridUi;->edit(Landroid/widget/EditText;ZZ)V

    new-instance p3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 p4, -0x1

    const/4 v0, -0x2

    invoke-direct {p3, p4, v0}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, p2, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-object p2
.end method

.method private findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;
    .locals 3

    .line 155
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p1

    :cond_0
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    :goto_0
    move-object v1, p1

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v0, v2, :cond_2

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-direct {p0, v1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->findTag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_1

    return-object v1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    return-object p1
.end method

.method private finishTask(Ljava/lang/String;)V
    .locals 2

    .line 146
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "id"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "status"

    const-string v1, "Done"

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "completed"

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    move-result-object p1

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda31;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda31;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    const/4 p1, 0x0

    invoke-direct {p0, v0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->perform(Lcom/adib/maintenance/TaskManagementActivity$Operation;Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    return-void
.end method

.method static http(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/16 v0, 0x3a98

    .line 165
    invoke-static {p0, p1, p2, v0}, Lcom/adib/maintenance/TaskManagementActivity;->httpWithTimeout(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;I)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method static httpWithTimeout(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;I)Lorg/json/JSONObject;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 166
    const-string v0, ""

    invoke-static {}, Lcom/adib/maintenance/DirectRuntime;->enabled()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p0, p1, p2}, Lcom/adib/maintenance/DirectRuntime;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 v1, 0x0

    :try_start_0
    const-string v2, "https://adib-production-eba3.up.railway.app/"

    new-instance v3, Ljava/net/URL;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "/$"

    invoke-virtual {v2, v5, v0}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v3, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object p1

    check-cast p1, Ljava/net/HttpURLConnection;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    :try_start_1
    invoke-virtual {p1, p0}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/16 p0, 0x3a98

    invoke-virtual {p1, p0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {p1, p3}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    const-string p0, "Accept"

    const-string p3, "application/json"

    invoke-virtual {p1, p0, p3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_2

    const/4 p0, 0x1

    invoke-virtual {p1, p0}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    const-string p0, "Content-Type"

    const-string p3, "application/json; charset=utf-8"

    invoke-virtual {p1, p0, p3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :try_start_2
    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    sget-object p3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p2, p3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    invoke-virtual {p0, p2}, Ljava/io/OutputStream;->write([B)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz p0, :cond_2

    :try_start_3
    invoke-virtual {p0}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_4

    goto :goto_1

    :catchall_0
    move-exception p2

    if-eqz p0, :cond_1

    :try_start_4
    invoke-virtual {p0}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p0

    :try_start_5
    invoke-virtual {p2, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    throw p2

    :cond_2
    :goto_1
    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result p0

    const/16 p2, 0x190

    if-lt p0, p2, :cond_3

    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object p3

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object p3

    :goto_2
    if-eqz p3, :cond_7

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/InputStreamReader;

    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, p3, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    :goto_3
    :try_start_6
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object p3

    if-eqz p3, :cond_4

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    goto :goto_3

    :cond_4
    :try_start_7
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    :try_start_8
    new-instance p3, Lorg/json/JSONObject;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p3, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    if-ge p0, p2, :cond_6

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_5
    return-object p3

    :cond_6
    :try_start_9
    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    const-string v0, "error"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HTTP "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "code"

    invoke-virtual {p3, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-direct {p2, v0, p3, p0}, Lcom/adib/maintenance/TaskManagementActivity$ApiError;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    :catch_0
    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    const-string p3, "\u041e\u0442\u0432\u0435\u0442 \u0441\u0435\u0440\u0432\u0435\u0440\u0430 \u043d\u0435 \u0440\u0430\u0441\u043f\u043e\u0437\u043d\u0430\u043d. \u041d\u0443\u0436\u0435\u043d \u043e\u0431\u043d\u043e\u0432\u043b\u0451\u043d\u043d\u044b\u0439 \u0441\u0435\u0440\u0432\u0435\u0440 ADIB."

    invoke-direct {p2, p3, v0, p0}, Lcom/adib/maintenance/TaskManagementActivity$ApiError;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    :catchall_2
    move-exception p0

    :try_start_a
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    goto :goto_4

    :catchall_3
    move-exception p2

    :try_start_b
    invoke-virtual {p0, p2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_4
    throw p0

    :cond_7
    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    const-string p3, "\u0421\u0435\u0440\u0432\u0435\u0440 \u0432\u0435\u0440\u043d\u0443\u043b \u043f\u0443\u0441\u0442\u043e\u0439 \u043e\u0442\u0432\u0435\u0442"

    invoke-direct {p2, p3, v0, p0}, Lcom/adib/maintenance/TaskManagementActivity$ApiError;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    :catchall_4
    move-exception p0

    move-object v1, p1

    goto :goto_5

    :catchall_5
    move-exception p0

    :goto_5
    if-eqz v1, :cond_8

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_8
    throw p0
.end method

.method private ink()I
    .locals 1

    .line 59
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0}, Lcom/adib/maintenance/HybridUi;->text(Z)I

    move-result v0

    return v0
.end method

.method private label(Ljava/lang/String;IZ)Landroid/widget/TextView;
    .locals 1

    .line 74
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    int-to-float p1, p2

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->ink()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    if-eqz p3, :cond_0

    sget-object p1, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    const/4 p2, 0x1

    invoke-virtual {v0, p1, p2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    :cond_0
    const/high16 p1, 0x40a00000    # 5.0f

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p2

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p1

    const/4 p3, 0x0

    invoke-virtual {v0, p3, p2, p3, p1}, Landroid/widget/TextView;->setPadding(IIII)V

    return-object v0
.end method

.method private synthetic lambda$button$0(Ljava/lang/String;Ljava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    .line 76
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->allowed(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-interface {p2}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method static synthetic lambda$chooseDate$1(Ljava/util/function/Consumer;Landroid/widget/DatePicker;III)V
    .locals 0

    .line 81
    sget-object p1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    add-int/lit8 p3, p3, 0x1

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    filled-new-array {p2, p3, p4}, [Ljava/lang/Object;

    move-result-object p2

    const-string p3, "%04d-%02d-%02d"

    invoke-static {p1, p3, p2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p0, p1}, Ljava/util/function/Consumer;->accept(Ljava/lang/Object;)V

    return-void
.end method

.method private synthetic lambda$confirmDelete$30(Lorg/json/JSONObject;Landroid/content/DialogInterface;I)V
    .locals 0

    .line 142
    :try_start_0
    const-string p2, ""

    const/4 p3, 0x1

    invoke-static {p0, p1, p3, p2}, Lcom/adib/maintenance/OfflineDeletes;->enqueue(Landroid/content/Context;Lorg/json/JSONObject;ZLjava/lang/String;)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-static {p0, p1}, Lcom/adib/maintenance/OfflineDeletes;->filterTasks(Landroid/content/Context;Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    invoke-static {p0, p1}, Lcom/adib/maintenance/OfflineDeletes;->filterState(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->setResult(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V

    const-string p1, "\u0423\u0434\u0430\u043b\u0435\u043d\u043e \u043d\u0430 \u0443\u0441\u0442\u0440\u043e\u0439\u0441\u0442\u0432\u0435"

    const/4 p2, 0x0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$dayCard$10(Ljava/lang/String;)V
    .locals 2

    .line 116
    const-string v0, "day-remove"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-static {v0, p1, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$dayCard$11(Ljava/lang/String;)V
    .locals 0

    .line 118
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->editEstimate(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$dayCard$12(Ljava/lang/String;)V
    .locals 2

    .line 119
    const-string v0, "main"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-static {v0, p1, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$dayCard$13(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 119
    invoke-virtual {p0, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->startTask(Ljava/lang/String;Z)V

    return-void
.end method

.method private synthetic lambda$dayCard$14(Ljava/lang/String;)V
    .locals 0

    .line 120
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->finishTask(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$dayCard$15(Ljava/lang/String;)V
    .locals 2

    .line 120
    const-string v0, "day-remove"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-static {v0, p1, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$editEstimate$16(Landroid/widget/EditText;Ljava/lang/String;Landroid/app/AlertDialog;Landroid/view/View;)V
    .locals 2

    .line 122
    :try_start_0
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p4

    invoke-virtual {p4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p4

    const/4 v0, 0x1

    if-lt p4, v0, :cond_0

    const v0, 0xa8c0

    if-gt p4, v0, :cond_0

    const-string v0, "estimate"

    const/4 v1, 0x0

    invoke-static {v0, p2, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p2

    const-string v0, "minutes"

    invoke-virtual {p2, v0, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object p2

    invoke-virtual {p3}, Landroid/app/AlertDialog;->dismiss()V

    invoke-virtual {p0, p2}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void

    :cond_0
    new-instance p2, Ljava/lang/Exception;

    invoke-direct {p2}, Ljava/lang/Exception;-><init>()V

    throw p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-string p2, "\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0446\u0435\u043b\u043e\u0435 \u0447\u0438\u0441\u043b\u043e \u043e\u0442 1 \u0434\u043e 43200"

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setError(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private synthetic lambda$editEstimate$17(Landroid/app/AlertDialog;Landroid/widget/EditText;Ljava/lang/String;Landroid/content/DialogInterface;)V
    .locals 1

    const/4 p4, -0x1

    .line 122
    invoke-virtual {p1, p4}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p4

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda7;

    invoke-direct {v0, p0, p2, p3, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda7;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/widget/EditText;Ljava/lang/String;Landroid/app/AlertDialog;)V

    invoke-virtual {p4, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private synthetic lambda$fetchPair$35(JLorg/json/JSONObject;)V
    .locals 2

    .line 160
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    cmp-long p1, p1, v0

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    if-nez p1, :cond_0

    iget-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    if-eqz p1, :cond_0

    :try_start_0
    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1}, Lorg/json/JSONObject;-><init>()V

    const-string p2, "tasks"

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {p1, p2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-static {p3, p1}, Lcom/adib/maintenance/TaskManagementActivity;->validate(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    iput-object p3, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string p1, "\u041e\u0431\u043d\u043e\u0432\u043b\u044f\u044e\u2026 \u041f\u043e\u043a\u0430\u0437\u0430\u043d \u0441\u043e\u0445\u0440\u0430\u043d\u0451\u043d\u043d\u044b\u0439 \u0441\u043f\u0438\u0441\u043e\u043a \u0437\u0430\u0434\u0430\u0447."

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private synthetic lambda$fetchPair$36(ZJ)Lorg/json/JSONObject;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 160
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v1, "/api/task-management"

    const/4 v2, 0x0

    const-string v3, "GET"

    invoke-interface {v0, v3, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz p1, :cond_0

    new-instance p1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda1;

    invoke-direct {p1, p0, p2, p3, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda1;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JLorg/json/JSONObject;)V

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-object v0
.end method

.method private synthetic lambda$fetchPair$37(ZLorg/json/JSONObject;Ljava/util/concurrent/atomic/AtomicLong;)Lorg/json/JSONObject;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    if-eqz p1, :cond_0

    return-object p2

    .line 160
    :cond_0
    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string p2, "/api/personal-snapshot"

    const/4 v0, 0x0

    const-string v1, "GET"

    invoke-interface {p1, v1, p2, v0}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {p3, v0, v1}, Ljava/util/concurrent/atomic/AtomicLong;->set(J)V

    return-object p1
.end method

.method private synthetic lambda$finishTask$34(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 146
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v1, "PATCH"

    const-string v2, "/api/personal-task"

    invoke-interface {v0, v1, v2, p1}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method private synthetic lambda$perform$38(JLcom/adib/maintenance/TaskManagementActivity$Pair;)V
    .locals 2

    .line 162
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    cmp-long p1, p1, v0

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->applyPair(Lcom/adib/maintenance/TaskManagementActivity$Pair;)V

    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->setResult(I)V

    const-string p1, "\u0421\u043e\u0445\u0440\u0430\u043d\u0435\u043d\u043e"

    const/4 p2, 0x0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V

    :cond_1
    :goto_0
    return-void
.end method

.method private synthetic lambda$perform$39(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 162
    const-string p1, "\u0418\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u0435 \u043e\u0442\u043c\u0435\u043d\u0435\u043d\u043e"

    const/4 p2, 0x0

    invoke-direct {p0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic lambda$perform$40(Ljava/lang/Runnable;Landroid/content/DialogInterface;I)V
    .locals 0

    .line 162
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    return-void
.end method

.method private synthetic lambda$perform$41(JLjava/lang/Exception;Ljava/lang/Runnable;)V
    .locals 2

    .line 162
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    cmp-long p1, p1, v0

    if-eqz p1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    instance-of p2, p3, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    if-eqz p2, :cond_1

    move-object p2, p3

    check-cast p2, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    iget-object p2, p2, Lcom/adib/maintenance/TaskManagementActivity$ApiError;->code:Ljava/lang/String;

    const-string v0, "WIP_LIMIT"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    if-eqz p4, :cond_1

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->dialog()Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string p2, "\u041b\u0438\u043c\u0438\u0442 \u0437\u0430\u0434\u0430\u0447 \u0432 \u0440\u0430\u0431\u043e\u0442\u0435"

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, "\n\u0412\u0441\u0451 \u0440\u0430\u0432\u043d\u043e \u043d\u0430\u0447\u0430\u0442\u044c?"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda13;

    invoke-direct {p2, p0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda13;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string p3, "\u041e\u0442\u043c\u0435\u043d\u0430"

    invoke-virtual {p1, p3, p2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda14;

    invoke-direct {p2, p4}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda14;-><init>(Ljava/lang/Runnable;)V

    const-string p3, "\u041d\u0430\u0447\u0430\u0442\u044c \u0432\u0441\u0451 \u0440\u0430\u0432\u043d\u043e"

    invoke-virtual {p1, p3, p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void

    :cond_1
    iget-boolean p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->writeConfirmed:Z

    if-eqz p2, :cond_2

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->invalidate(Landroid/content/Context;)V

    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->setResult(I)V

    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "\u0427\u0430\u0441\u0442\u044c \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u0439 \u0443\u0436\u0435 \u0441\u043e\u0445\u0440\u0430\u043d\u0435\u043d\u0430. \u041d\u0430\u0436\u043c\u0438\u0442\u0435 \u00ab\u041e\u0431\u043d\u043e\u0432\u0438\u0442\u044c\u00bb, \u0447\u0442\u043e\u0431\u044b \u043f\u0440\u043e\u0432\u0435\u0440\u0438\u0442\u044c \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0435. "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_2
    invoke-virtual {p3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    :cond_3
    :goto_1
    return-void
.end method

.method private synthetic lambda$perform$42(Lcom/adib/maintenance/TaskManagementActivity$Operation;JLjava/lang/Runnable;)V
    .locals 6

    .line 162
    :try_start_0
    invoke-interface {p1}, Lcom/adib/maintenance/TaskManagementActivity$Operation;->run()Lorg/json/JSONObject;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->writeConfirmed:Z

    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->invalidate(Landroid/content/Context;)V

    const/4 p1, 0x0

    invoke-direct {p0, p2, p3, p1, p1}, Lcom/adib/maintenance/TaskManagementActivity;->fetchPair(JZZ)Lcom/adib/maintenance/TaskManagementActivity$Pair;

    move-result-object p1

    iget-object v0, p1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->state:Lorg/json/JSONObject;

    iget-object v1, p1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personal:Lorg/json/JSONObject;

    iget-wide v2, p1, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personalFetchedAt:J

    invoke-static {p0, v0, v1, v2, v3}, Lcom/adib/maintenance/PlannerCache;->rememberPair(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;J)V

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda32;

    invoke-direct {v0, p0, p2, p3, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda32;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JLcom/adib/maintenance/TaskManagementActivity$Pair;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    move-object p1, v0

    move-object v4, p1

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda34;

    move-object v1, p0

    move-wide v2, p2

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda34;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JLjava/lang/Exception;Ljava/lang/Runnable;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$reload$43(JLcom/adib/maintenance/TaskManagementActivity$Pair;)V
    .locals 2

    .line 164
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    cmp-long p1, p1, v0

    if-nez p1, :cond_0

    invoke-direct {p0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->applyPair(Lcom/adib/maintenance/TaskManagementActivity$Pair;)V

    :cond_0
    return-void
.end method

.method private synthetic lambda$reload$44(JLjava/lang/Exception;)V
    .locals 2

    .line 164
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->alive()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    cmp-long p1, p1, v0

    if-eqz p1, :cond_0

    goto :goto_2

    :cond_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    if-nez p2, :cond_2

    iget-boolean p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    if-eqz p2, :cond_1

    goto :goto_0

    :cond_1
    const-string p2, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u0437\u0430\u0433\u0440\u0443\u0437\u0438\u0442\u044c. \u041f\u0440\u043e\u0432\u0435\u0440\u044c\u0442\u0435 \u0438\u043d\u0442\u0435\u0440\u043d\u0435\u0442 \u0438 \u043e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435 \u0441\u0435\u0440\u0432\u0435\u0440\u0430. "

    goto :goto_1

    :cond_2
    :goto_0
    const-string p2, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u043e\u0431\u043d\u043e\u0432\u0438\u0442\u044c. \u0421\u043e\u0445\u0440\u0430\u043d\u0451\u043d\u043d\u044b\u0435 \u0434\u0430\u043d\u043d\u044b\u0435 \u043e\u0441\u0442\u0430\u0432\u043b\u0435\u043d\u044b \u043d\u0430 \u044d\u043a\u0440\u0430\u043d\u0435. \u0418\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u044f \u043f\u043e\u043a\u0430 \u043d\u0435\u0434\u043e\u0441\u0442\u0443\u043f\u043d\u044b. "

    :goto_1
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    :cond_3
    :goto_2
    return-void
.end method

.method private synthetic lambda$reload$45(JZ)V
    .locals 4

    const/4 v0, 0x1

    xor-int/2addr p3, v0

    .line 164
    :try_start_0
    invoke-direct {p0, p1, p2, v0, p3}, Lcom/adib/maintenance/TaskManagementActivity;->fetchPair(JZZ)Lcom/adib/maintenance/TaskManagementActivity$Pair;

    move-result-object p3

    iget-object v0, p3, Lcom/adib/maintenance/TaskManagementActivity$Pair;->state:Lorg/json/JSONObject;

    iget-object v1, p3, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personal:Lorg/json/JSONObject;

    iget-wide v2, p3, Lcom/adib/maintenance/TaskManagementActivity$Pair;->personalFetchedAt:J

    invoke-static {p0, v0, v1, v2, v3}, Lcom/adib/maintenance/PlannerCache;->rememberPair(Landroid/content/Context;Lorg/json/JSONObject;Lorg/json/JSONObject;J)V

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda21;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda21;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JLcom/adib/maintenance/TaskManagementActivity$Pair;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p3

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda23;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda23;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JLjava/lang/Exception;)V

    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method private synthetic lambda$render$2(Landroid/view/View;)V
    .locals 0

    .line 84
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->finish()V

    return-void
.end method

.method static synthetic lambda$render$3(Landroid/widget/LinearLayout;)V
    .locals 2

    .line 85
    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    const/4 v1, 0x0

    :cond_0
    invoke-virtual {p0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    return-void
.end method

.method private synthetic lambda$render$4()V
    .locals 1

    .line 85
    const-string v0, "day"

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->switchTab(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$render$5()V
    .locals 1

    .line 85
    const-string v0, "review"

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->switchTab(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$render$6()V
    .locals 1

    .line 88
    const-string v0, "settings"

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->switchTab(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$render$7(Ljava/lang/String;)V
    .locals 0

    .line 91
    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    const-string p1, ""

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V

    return-void
.end method

.method private synthetic lambda$render$8()V
    .locals 2

    .line 91
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    new-instance v1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda9;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda9;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    invoke-direct {p0, v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->chooseDate(Ljava/lang/String;Ljava/util/function/Consumer;)V

    return-void
.end method

.method private synthetic lambda$renderList$18(Ljava/lang/String;)V
    .locals 2

    .line 133
    const-string v0, "day-add"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-static {v0, p1, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$renderList$19(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 134
    invoke-direct {p0, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->reviewForm(Ljava/lang/String;Z)V

    return-void
.end method

.method private synthetic lambda$renderList$20(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    .line 134
    invoke-direct {p0, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->reviewForm(Ljava/lang/String;Z)V

    return-void
.end method

.method private synthetic lambda$renderList$21(Lorg/json/JSONObject;)V
    .locals 0

    .line 134
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->confirmDelete(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$renderList$22()V
    .locals 1

    .line 136
    iget v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    add-int/lit8 v0, v0, 0x14

    iput v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->renderList()V

    return-void
.end method

.method static synthetic lambda$reviewForm$24()V
    .locals 0

    return-void
.end method

.method static synthetic lambda$reviewForm$25([Ljava/lang/String;Landroid/widget/Button;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 141
    aput-object p2, p0, v0

    new-instance p0, Ljava/lang/StringBuilder;

    const-string v0, "\u041f\u0440\u043e\u0432\u0435\u0440\u0438\u0442\u044c: "

    invoke-direct {p0, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private synthetic lambda$reviewForm$26([Ljava/lang/String;Landroid/widget/Button;Landroid/view/View;)V
    .locals 1

    const/4 p3, 0x0

    .line 141
    aget-object p3, p1, p3

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda48;

    invoke-direct {v0, p1, p2}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda48;-><init>([Ljava/lang/String;Landroid/widget/Button;)V

    invoke-direct {p0, p3, v0}, Lcom/adib/maintenance/TaskManagementActivity;->chooseDate(Ljava/lang/String;Ljava/util/function/Consumer;)V

    return-void
.end method

.method private synthetic lambda$reviewForm$27(Lorg/json/JSONObject;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 141
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v1, "PATCH"

    const-string v2, "/api/personal-task"

    invoke-interface {v0, v1, v2, p1}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->writeConfirmed:Z

    iget-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v0, "/api/task-management"

    invoke-direct {p0, p2}, Lcom/adib/maintenance/TaskManagementActivity;->withRevision(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p2

    const-string v1, "POST"

    invoke-interface {p1, v1, v0, p2}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method private synthetic lambda$reviewForm$28(Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Landroid/app/AlertDialog;Ljava/lang/String;Landroid/view/View;)V
    .locals 2

    if-nez p1, :cond_0

    .line 141
    const-string p7, ""

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p7

    invoke-virtual {p7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p7

    invoke-virtual {p7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p7

    :goto_0
    if-eqz p2, :cond_2

    invoke-virtual {p7}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p7}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xc8

    if-le v0, v1, :cond_2

    :cond_1
    const-string p2, "\u0423\u043a\u0430\u0436\u0438\u0442\u0435 \u043e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043d\u043d\u043e\u0433\u043e, \u0434\u043e 200 \u0441\u0438\u043c\u0432\u043e\u043b\u043e\u0432"

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setError(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    const/4 p1, 0x0

    aget-object v0, p3, p1

    invoke-static {}, Lcom/adib/maintenance/TaskManagementActivity;->today()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-gez v0, :cond_3

    const-string p1, "\u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0441\u0435\u0433\u043e\u0434\u043d\u044f \u0438\u043b\u0438 \u0431\u0443\u0434\u0443\u0449\u0443\u044e \u0434\u0430\u0442\u0443"

    invoke-virtual {p4, p1}, Landroid/widget/Button;->setError(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    invoke-virtual {p5}, Landroid/app/AlertDialog;->dismiss()V

    :try_start_0
    const-string p4, "review"

    const/4 p5, 0x0

    invoke-static {p4, p6, p5}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p4

    const-string v0, "disposition"

    if-eqz p2, :cond_4

    const-string v1, "waiting"

    goto :goto_1

    :cond_4
    const-string v1, "later"

    :goto_1
    invoke-virtual {p4, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p4

    const-string v0, "checkDate"

    aget-object p1, p3, p1

    invoke-virtual {p4, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    const-string p3, "owner"

    invoke-virtual {p1, p3, p7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p1

    if-eqz p2, :cond_5

    new-instance p2, Lorg/json/JSONObject;

    invoke-direct {p2}, Lorg/json/JSONObject;-><init>()V

    const-string p3, "id"

    invoke-virtual {p2, p3, p6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p2

    const-string p3, "status"

    const-string p4, "Delegate"

    invoke-virtual {p2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p2

    const-string p3, "assignees"

    new-instance p4, Lorg/json/JSONArray;

    invoke-direct {p4}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {p4, p7}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-result-object p4

    invoke-virtual {p2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object p2

    new-instance p3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda46;

    invoke-direct {p3, p0, p2, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda46;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    invoke-direct {p0, p3, p5}, Lcom/adib/maintenance/TaskManagementActivity;->perform(Lcom/adib/maintenance/TaskManagementActivity$Operation;Ljava/lang/Runnable;)V

    return-void

    :cond_5
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$reviewForm$29(Landroid/app/AlertDialog;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Ljava/lang/String;Landroid/content/DialogInterface;)V
    .locals 8

    const/4 p7, -0x1

    .line 141
    invoke-virtual {p1, p7}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p7

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda0;

    move-object v1, p0

    move-object v6, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda0;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Landroid/app/AlertDialog;Ljava/lang/String;)V

    invoke-virtual {p7, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private synthetic lambda$settingsForm$23([Landroid/widget/EditText;[I[I[Ljava/lang/String;)V
    .locals 4

    .line 139
    const-string v0, "settings"

    const/4 v1, 0x0

    invoke-static {v0, v1, v1}, Lcom/adib/maintenance/TaskManagementActivity;->command(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x4

    if-ge v1, v2, :cond_1

    :try_start_0
    aget-object v2, p1, v1

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    aget v3, p2, v1

    if-lt v2, v3, :cond_0

    aget v3, p3, v1

    if-gt v2, v3, :cond_0

    aget-object v3, p4, v1

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    new-instance p4, Ljava/lang/Exception;

    invoke-direct {p4}, Ljava/lang/Exception;-><init>()V

    throw p4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    aget-object p1, p1, v1

    new-instance p4, Ljava/lang/StringBuilder;

    const-string v0, "\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0447\u0438\u0441\u043b\u043e \u043e\u0442 "

    invoke-direct {p4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    aget p2, p2, v1

    invoke-virtual {p4, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p4, " \u0434\u043e "

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    aget p3, p3, v1

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setError(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->update(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$startTask$32(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 145
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v1, "PATCH"

    const-string v2, "/api/personal-task"

    invoke-interface {v0, v1, v2, p1}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method private synthetic lambda$startTask$33(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    .line 145
    invoke-virtual {p0, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->startTask(Ljava/lang/String;Z)V

    return-void
.end method

.method private synthetic lambda$taskTitle$9(Lorg/json/JSONObject;)V
    .locals 0

    .line 113
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->openTask(Lorg/json/JSONObject;)V

    return-void
.end method

.method private synthetic lambda$update$31(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 144
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->transport:Lcom/adib/maintenance/TaskManagementActivity$Transport;

    const-string v1, "POST"

    const-string v2, "/api/task-management"

    invoke-interface {v0, v1, v2, p1}, Lcom/adib/maintenance/TaskManagementActivity$Transport;->request(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method static mainPreferencesName(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    .line 42
    const-class v0, Lcom/adib/maintenance/MainActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, "."

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    invoke-virtual {v0, p0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    return-object v0
.end method

.method private mutationTag(Ljava/lang/String;)Z
    .locals 1

    .line 152
    const-string v0, "save-settings"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "^(add|main|start|finish|remove|estimate|later|delegate|delete):.*"

    invoke-virtual {p1, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1
.end method

.method private muted()I
    .locals 1

    .line 60
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0}, Lcom/adib/maintenance/HybridUi;->muted(Z)I

    move-result v0

    return v0
.end method

.method static nextDate()Ljava/lang/String;
    .locals 4

    .line 44
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    const/4 v1, 0x5

    const/4 v2, 0x7

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->add(II)V

    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy-MM-dd"

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {v1, v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    .line 46
    :cond_0
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    :goto_0
    if-nez p0, :cond_1

    new-instance p0, Lorg/json/JSONObject;

    invoke-direct {p0}, Lorg/json/JSONObject;-><init>()V

    :cond_1
    return-object p0
.end method

.method private openTask(Lorg/json/JSONObject;)V
    .locals 5

    const/4 v0, -0x1

    .line 112
    invoke-virtual {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->setResult(I)V

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/adib/maintenance/MainActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "com.adib.maintenance.WIDGET_TASK"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "id"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "widget_id"

    invoke-virtual {v1, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const-string v3, "plannerEstimateKnown"

    iget-boolean v4, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->meta(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v2, "estimateMinutes"

    invoke-virtual {p1, v2, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p1

    const-string v0, "plannerEstimateMinutes"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object p1

    const/high16 v0, 0x24000000

    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->startActivity(Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->finish()V

    return-void
.end method

.method private pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V
    .locals 6

    .line 78
    invoke-virtual {p2}, Landroid/widget/Button;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "tab:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "refresh"

    invoke-virtual {p3}, Landroid/widget/Button;->getTag()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->fontScale:F

    const/high16 v1, 0x3fa00000    # 1.25f

    cmpl-float v0, v0, v1

    if-gtz v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->screenWidthDp:I

    const/16 v1, 0x12c

    if-ge v0, v1, :cond_1

    :cond_0
    invoke-virtual {p1, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {p1, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void

    :cond_1
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v2, v1, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v1, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    const/high16 v1, 0x40800000    # 4.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    iput v3, v2, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    iput v1, v5, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    const/high16 v1, 0x40a00000    # 5.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    iput v3, v5, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    iput v3, v2, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    iput v1, v5, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iput v1, v2, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    invoke-virtual {v0, p2, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, p3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method private panel()I
    .locals 1

    .line 58
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v0}, Lcom/adib/maintenance/HybridUi;->surface(Z)I

    move-result v0

    return v0
.end method

.method private perform(Lcom/adib/maintenance/TaskManagementActivity$Operation;Ljava/lang/Runnable;)V
    .locals 11

    .line 162
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->fresh:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->writeConfirmed:Z

    iget-wide v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    const-wide/16 v3, 0x1

    add-long v8, v1, v3

    iput-wide v8, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    const-string v1, "\u0421\u043e\u0445\u0440\u0430\u043d\u044f\u044e\u2026"

    invoke-direct {p0, v1, v0}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->io:Ljava/util/concurrent/ExecutorService;

    new-instance v5, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda3;

    move-object v6, p0

    move-object v7, p1

    move-object v10, p2

    invoke-direct/range {v5 .. v10}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda3;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lcom/adib/maintenance/TaskManagementActivity$Operation;JLjava/lang/Runnable;)V

    invoke-interface {v0, v5}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private reload(Z)V
    .locals 4

    .line 164
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->refreshing:Z

    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {p0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    if-eqz v2, :cond_1

    const-string v2, "\u041e\u0431\u043d\u043e\u0432\u043b\u044f\u044e\u2026 \u041f\u043e\u043a\u0430\u0437\u0430\u043d\u044b \u0441\u043e\u0445\u0440\u0430\u043d\u0451\u043d\u043d\u044b\u0435 \u0434\u0430\u043d\u043d\u044b\u0435."

    goto :goto_0

    :cond_1
    const-string v2, "\u0417\u0430\u0433\u0440\u0443\u0436\u0430\u044e \u043f\u043b\u0430\u043d\u2026"

    :goto_0
    const/4 v3, 0x0

    invoke-direct {p0, v2, v3}, Lcom/adib/maintenance/TaskManagementActivity;->status(Ljava/lang/String;Z)V

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->io:Ljava/util/concurrent/ExecutorService;

    new-instance v3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda24;

    invoke-direct {v3, p0, v0, v1, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda24;-><init>(Lcom/adib/maintenance/TaskManagementActivity;JZ)V

    invoke-interface {v2, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_2
    :goto_1
    return-void
.end method

.method private restorePlannerCache()V
    .locals 4

    .line 149
    invoke-static {p0}, Lcom/adib/maintenance/PlannerCache;->read(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "personal"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "state"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v1, :cond_0

    const-string v2, "tasks"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    if-eqz v3, :cond_0

    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    invoke-static {v1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    const-string v2, "containers"

    invoke-static {v1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    iput-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->containers:Lorg/json/JSONArray;

    :try_start_0
    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->validate(Lorg/json/JSONObject;Lorg/json/JSONObject;)V

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private reviewForm(Ljava/lang/String;Z)V
    .locals 13

    .line 141
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    const/high16 v1, 0x41800000    # 16.0f

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x40c00000    # 6.0f

    invoke-direct {p0, v3}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v1, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    const/4 v1, 0x0

    if-eqz p2, :cond_0

    const-string v2, "\u041e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043d\u043d\u044b\u0439"

    const-string v3, ""

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/adib/maintenance/TaskManagementActivity;->field(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v2

    move-object v8, v2

    goto :goto_0

    :cond_0
    move-object v8, v1

    :goto_0
    const/4 v2, 0x1

    new-array v10, v2, [Ljava/lang/String;

    invoke-static {}, Lcom/adib/maintenance/TaskManagementActivity;->nextDate()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v10, v4

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\u041f\u0440\u043e\u0432\u0435\u0440\u0438\u0442\u044c: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    aget-object v3, v10, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda22;

    invoke-direct {v3}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda22;-><init>()V

    const-string v4, "check-date"

    invoke-direct {p0, v2, v4, v3}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v11

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda33;

    invoke-direct {v2, p0, v10, v11}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda33;-><init>(Lcom/adib/maintenance/TaskManagementActivity;[Ljava/lang/String;Landroid/widget/Button;)V

    invoke-virtual {v11, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v0, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->dialog()Landroid/app/AlertDialog$Builder;

    move-result-object v2

    if-eqz p2, :cond_1

    const-string v3, "\u0414\u0435\u043b\u0435\u0433\u0438\u0440\u043e\u0432\u0430\u0442\u044c"

    goto :goto_1

    :cond_1
    const-string v3, "\u041e\u0442\u043b\u043e\u0436\u0438\u0442\u044c \u0434\u043e \u0440\u0430\u0437\u0431\u043e\u0440\u0430"

    :goto_1
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "\u041e\u0442\u043c\u0435\u043d\u0430"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "\u0421\u043e\u0445\u0440\u0430\u043d\u0438\u0442\u044c"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v7

    new-instance v5, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda43;

    move-object v6, p0

    move-object v12, p1

    move v9, p2

    invoke-direct/range {v5 .. v12}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda43;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/app/AlertDialog;Landroid/widget/EditText;Z[Ljava/lang/String;Landroid/widget/Button;Ljava/lang/String;)V

    invoke-virtual {v7, v5}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    invoke-virtual {v7}, Landroid/app/AlertDialog;->show()V

    return-void
.end method

.method private settingsForm()V
    .locals 12

    .line 138
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v1, "\u041b\u0438\u043c\u0438\u0442\u044b \u043e\u0431\u0449\u0438\u0435 \u0434\u043b\u044f \u0441\u0435\u0440\u0432\u0438\u0441\u0430"

    const/16 v2, 0x12

    const/4 v3, 0x1

    invoke-direct {p0, v1, v2, v3}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v1, "\u041f\u043e \u0443\u043c\u043e\u043b\u0447\u0430\u043d\u0438\u044e: 4 \u0437\u0430\u0434\u0430\u0447\u0438 \u0432 \u0434\u0435\u043d\u044c, WIP 2, \u0431\u044e\u0434\u0436\u0435\u0442 120 \u043c\u0438\u043d\u0443\u0442, \u0437\u0430\u043b\u0435\u0436\u0438\u0432\u0430\u043d\u0438\u0435 14 \u0434\u043d\u0435\u0439."

    const/16 v2, 0xe

    const/4 v4, 0x0

    invoke-direct {p0, v1, v2, v4}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const/4 v0, 0x4

    new-array v10, v0, [Ljava/lang/String;

    const-string v1, "dailyTaskLimit"

    aput-object v1, v10, v4

    const-string v1, "wipLimit"

    aput-object v1, v10, v3

    const-string v1, "budgetMinutes"

    const/4 v2, 0x2

    aput-object v1, v10, v2

    const-string v1, "staleDays"

    const/4 v5, 0x3

    aput-object v1, v10, v5

    new-array v1, v0, [Ljava/lang/String;

    const-string v6, "\u0417\u0430\u0434\u0430\u0447 \u0432 \u043f\u043b\u0430\u043d\u0435 (1\u201312)"

    aput-object v6, v1, v4

    const-string v6, "\u041e\u0434\u043d\u043e\u0432\u0440\u0435\u043c\u0435\u043d\u043d\u043e \u0432 \u0440\u0430\u0431\u043e\u0442\u0435 (1\u201310)"

    aput-object v6, v1, v3

    const-string v6, "\u0411\u044e\u0434\u0436\u0435\u0442, \u043c\u0438\u043d\u0443\u0442 (15\u20131440)"

    aput-object v6, v1, v2

    const-string v2, "\u0411\u0435\u0437 \u043e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u044f, \u0434\u043d\u0435\u0439 (1\u2013180)"

    aput-object v2, v1, v5

    const/16 v2, 0xf

    filled-new-array {v3, v3, v2, v3}, [I

    move-result-object v8

    const/16 v2, 0x5a0

    const/16 v5, 0xb4

    const/16 v6, 0xc

    const/16 v7, 0xa

    filled-new-array {v6, v7, v2, v5}, [I

    move-result-object v9

    new-array v7, v0, [Landroid/widget/EditText;

    :goto_0
    if-ge v4, v0, :cond_0

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    aget-object v5, v1, v4

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v6

    aget-object v11, v10, v4

    invoke-virtual {v6, v11}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v2, v5, v6, v3}, Lcom/adib/maintenance/TaskManagementActivity;->field(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v2

    aput-object v2, v7, v4

    aget-object v5, v10, v4

    invoke-virtual {v2, v5}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 139
    :cond_0
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    new-instance v5, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda8;

    move-object v6, p0

    invoke-direct/range {v5 .. v10}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda8;-><init>(Lcom/adib/maintenance/TaskManagementActivity;[Landroid/widget/EditText;[I[I[Ljava/lang/String;)V

    const-string v1, "\u0421\u043e\u0445\u0440\u0430\u043d\u0438\u0442\u044c \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438"

    const-string v2, "save-settings"

    invoke-direct {p0, v1, v2, v5}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method private shape(II)Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    .line 62
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 p1, 0x41400000    # 12.0f

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p1

    int-to-float p1, p1

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/high16 p1, 0x3f800000    # 1.0f

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result p1

    invoke-virtual {v0, p1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    return-object v0
.end method

.method private status(Ljava/lang/String;Z)V
    .locals 0

    .line 151
    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    iput-boolean p2, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusError:Z

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->updateFeedback()V

    return-void
.end method

.method private switchTab(Ljava/lang/String;)V
    .locals 0

    .line 111
    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    const-string p1, ""

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    const/16 p1, 0x14

    iput p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V

    return-void
.end method

.method private syncControls(Landroid/view/View;)V
    .locals 3

    .line 154
    instance-of v0, p1, Landroid/widget/Button;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->allowed(Ljava/lang/String;)Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/View;->setEnabled(Z)V

    invoke-virtual {p1}, Landroid/view/View;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0

    :cond_0
    const v0, 0x3ee66666    # 0.45f

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    goto :goto_1

    :cond_1
    instance-of v0, p1, Landroid/widget/EditText;

    if-nez v0, :cond_2

    instance-of v0, p1, Landroid/widget/Spinner;

    if-eqz v0, :cond_3

    :cond_2
    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setEnabled(Z)V

    :cond_3
    :goto_1
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_4

    const/4 v0, 0x0

    :goto_2
    move-object v1, p1

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v0, v2, :cond_4

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    return-void
.end method

.method private taskTitle(Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V
    .locals 3

    .line 113
    const-string v0, "title"

    const-string v1, "\u0411\u0435\u0437 \u043d\u0430\u0437\u0432\u0430\u043d\u0438\u044f"

    invoke-virtual {p2, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "open:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "id"

    invoke-virtual {p2, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda11;

    invoke-direct {v2, p0, p2}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda11;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    invoke-direct {p0, v0, v1, v2}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object p2

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->ink()I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    sget-object v0, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    const/4 v1, 0x1

    invoke-virtual {p2, v0, v1}, Landroid/widget/Button;->setTypeface(Landroid/graphics/Typeface;I)V

    const v0, 0x800013

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setGravity(I)V

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setBackgroundColor(I)V

    invoke-virtual {p1, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method static today()Ljava/lang/String;
    .locals 3

    .line 43
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd"

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private updateFeedback()V
    .locals 5

    .line 150
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {p0}, Lcom/adib/maintenance/OfflineDeletes;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, ""

    goto :goto_0

    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, " \u00b7 "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_0
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    iget-boolean v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusError:Z

    if-eqz v2, :cond_3

    iget-boolean v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    if-eqz v2, :cond_2

    const/16 v2, 0xff

    const/16 v3, 0x94

    goto :goto_1

    :cond_2
    const/16 v2, 0xb8

    const/16 v3, 0x1e

    :goto_1
    invoke-static {v2, v3, v3}, Landroid/graphics/Color;->rgb(III)I

    move-result v2

    goto :goto_2

    :cond_3
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->muted()I

    move-result v2

    :goto_2
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/adib/maintenance/TaskManagementActivity;->statusText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_4

    const/16 v0, 0x8

    goto :goto_3

    :cond_4
    const/4 v0, 0x0

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method static validate(Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adib/maintenance/TaskManagementActivity$ApiError;
        }
    .end annotation

    if-eqz p0, :cond_0

    .line 159
    const-string v0, "version"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const-string v0, "settings"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "tasks"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v1, "days"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Lcom/adib/maintenance/TaskManagementActivity$ApiError;

    const-string p1, "INVALID_SNAPSHOT"

    const/16 v0, 0x1f6

    const-string v1, "\u041d\u0443\u0436\u0435\u043d \u043e\u0431\u043d\u043e\u0432\u043b\u0451\u043d\u043d\u044b\u0439 \u0441\u0435\u0440\u0432\u0435\u0440 ADIB."

    invoke-direct {p0, v1, p1, v0}, Lcom/adib/maintenance/TaskManagementActivity$ApiError;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p0
.end method

.method private withRevision(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 143
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string v1, "revision"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    const-string v1, "expectedRevision"

    invoke-virtual {p1, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method static working(Lorg/json/JSONObject;)Z
    .locals 1

    .line 45
    const-string v0, "completed"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "status"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const-string v0, "in progress"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method estimate(Ljava/lang/String;)I
    .locals 2

    .line 54
    invoke-virtual {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->meta(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "estimateMinutes"

    const/16 v1, 0x19

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p1

    return p1
.end method

.method find(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 3

    const/4 v0, 0x0

    .line 53
    :goto_0
    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v2, "id"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {p0, p1}, Lcom/adib/maintenance/OfflineDeletes;->hidden(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    return-object v1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method meta(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 2

    .line 50
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string v1, "tasks"

    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    return-object p1
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 64
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-static {p0}, Lcom/adib/maintenance/TaskManagementActivity;->mainPreferencesName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "dark_theme"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    .line 65
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "tab"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "day"

    if-nez v0, :cond_0

    move-object v0, v3

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    if-eqz p1, :cond_1

    .line 66
    invoke-static {}, Lcom/adib/maintenance/TaskManagementActivity;->today()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-virtual {p1, v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    const-string v0, "review"

    const-string v2, "incoming"

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->review:Ljava/lang/String;

    const-string v0, "query"

    const-string v2, ""

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    .line 67
    :cond_1
    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->bg()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/Window;->setStatusBarColor(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->bg()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/Window;->setNavigationBarColor(I)V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    iget-boolean v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    if-eqz v0, :cond_2

    move v0, v1

    goto :goto_1

    :cond_2
    const/16 v0, 0x2000

    :goto_1
    invoke-virtual {p1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 68
    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->restorePlannerCache()V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->render()V

    invoke-direct {p0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->reload(Z)V

    return-void
.end method

.method protected onDestroy()V
    .locals 4

    .line 72
    iget-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->generation:J

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->fetchIO:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->io:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    const/4 v0, 0x0
    sput-boolean v0, Lcom/adib/maintenance/ChatNotifications;->foreground:Z

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 71
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    const/4 v0, 0x1
    sput-boolean v0, Lcom/adib/maintenance/ChatNotifications;->foreground:Z

    invoke-static {p0}, Lcom/adib/maintenance/OfflineDeletes;->kick(Landroid/content/Context;)V

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->renderList()V

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->updateFeedback()V

    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 1
    const/4 v0, 0x0
    sput-boolean v0, Lcom/adib/maintenance/ChatNotifications;->foreground:Z
    invoke-super {p0}, Landroid/app/Activity;->onPause()V
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .line 70
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "day"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "tab"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "review"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->review:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "query"

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method plan()Lorg/json/JSONObject;
    .locals 2

    .line 51
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string v1, "days"

    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    iget-object v1, p0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method reload()V
    .locals 1

    const/4 v0, 0x1

    .line 163
    invoke-direct {p0, v0}, Lcom/adib/maintenance/TaskManagementActivity;->reload(Z)V

    return-void
.end method

.method render()V
    .locals 17

    move-object/from16 v0, p0

    .line 83
    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v3

    const/high16 v4, 0x40c00000    # 6.0f

    invoke-direct {v0, v4}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v4

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v1, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->bg()I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->setContentView(Landroid/view/View;)V

    .line 84
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v3, 0x10

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda35;

    invoke-direct {v4, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda35;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v5, "\u2039"

    const-string v7, "back"

    invoke-direct {v0, v5, v7, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/widget/Button;->setEnabled(Z)V

    new-instance v7, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda36;

    invoke-direct {v7, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda36;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    invoke-virtual {v4, v7}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v8, 0x42400000    # 48.0f

    invoke-direct {v0, v8}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v9

    invoke-direct {v0, v8}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v10

    invoke-direct {v7, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const/16 v4, 0x16

    const-string v7, "\u041f\u043b\u0430\u043d \u0434\u043d\u044f"

    invoke-direct {v0, v7, v4, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v4

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    invoke-virtual {v4, v2, v6, v6, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x2

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v4, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 85
    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    const/16 v4, 0x8

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda37;

    invoke-direct {v4, v2}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda37;-><init>(Landroid/widget/LinearLayout;)V

    const-string v11, "\u22ef"

    const-string v12, "planner-more"

    invoke-direct {v0, v11, v12, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    const-string v11, "\u0414\u043e\u043f\u043e\u043b\u043d\u0438\u0442\u0435\u043b\u044c\u043d\u044b\u0435 \u0440\u0430\u0437\u0434\u0435\u043b\u044b \u043f\u043b\u0430\u043d\u0430"

    invoke-virtual {v4, v11}, Landroid/widget/Button;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance v11, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v8}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v12

    invoke-direct {v0, v8}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v8

    invoke-direct {v11, v12, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v4, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda38;

    invoke-direct {v1, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda38;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v4, "tab:day"

    invoke-direct {v0, v7, v4, v1}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda39;

    invoke-direct {v4, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda39;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v7, "\u0420\u0430\u0437\u0431\u043e\u0440"

    const-string v8, "tab:review"

    invoke-direct {v0, v7, v8, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    invoke-direct {v0, v2, v1, v4}, Lcom/adib/maintenance/TaskManagementActivity;->pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 86
    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    invoke-virtual {v1, v5}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->root:Landroid/widget/LinearLayout;

    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x1

    invoke-direct {v4, v7, v6, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const/high16 v2, 0x40800000    # 4.0f

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v4

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v2

    const/high16 v8, 0x41a00000    # 20.0f

    invoke-direct {v0, v8}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v8

    invoke-virtual {v1, v4, v6, v2, v8}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->scroll:Landroid/widget/ScrollView;

    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 88
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda40;

    invoke-direct {v2, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda40;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v4, "\u041d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438"

    const-string v8, "tab:settings"

    invoke-direct {v0, v4, v8, v2}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v2

    new-instance v4, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda41;

    invoke-direct {v4, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda41;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v8, "\u041e\u0431\u043d\u043e\u0432\u0438\u0442\u044c"

    const-string v10, "refresh"

    invoke-direct {v0, v8, v10, v4}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    invoke-direct {v0, v1, v2, v4}, Lcom/adib/maintenance/TaskManagementActivity;->pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V

    .line 89
    iget-boolean v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    if-eqz v1, :cond_0

    const-string v1, "\u0417\u0430\u0433\u0440\u0443\u0436\u0430\u044e\u2026"

    goto :goto_0

    :cond_0
    const-string v1, ""

    :goto_0
    const/16 v2, 0xe

    invoke-direct {v0, v1, v2, v6}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->muted()I

    move-result v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setAccessibilityLiveRegion(I)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    iget-object v4, v0, Lcom/adib/maintenance/TaskManagementActivity;->feedback:Landroid/widget/TextView;

    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->updateFeedback()V

    .line 90
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    if-nez v1, :cond_3

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v2, "\u0417\u0430\u0433\u0440\u0443\u0436\u0430\u044e \u043f\u043b\u0430\u043d \u0438 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438\u2026"

    invoke-direct {v0, v2, v3, v6}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-boolean v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->havePersonalCache:Z

    if-eqz v1, :cond_2

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v2, "\u041f\u043e\u0441\u043b\u0435\u0434\u043d\u0438\u0439 \u0441\u043e\u0445\u0440\u0430\u043d\u0451\u043d\u043d\u044b\u0439 \u0441\u043f\u0438\u0441\u043e\u043a \u0437\u0430\u0434\u0430\u0447"

    invoke-direct {v0, v2, v3, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    move v1, v6

    :goto_1
    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v2

    const/16 v3, 0x14

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    if-ge v1, v2, :cond_2

    iget-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {v0, v3, v6}, Lcom/adib/maintenance/TaskManagementActivity;->card(Landroid/widget/LinearLayout;Z)Landroid/widget/LinearLayout;

    move-result-object v3

    invoke-direct {v0, v3, v2}, Lcom/adib/maintenance/TaskManagementActivity;->taskTitle(Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    return-void

    .line 91
    :cond_3
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {v0, v1, v6}, Lcom/adib/maintenance/TaskManagementActivity;->card(Landroid/widget/LinearLayout;Z)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v8, "\u0414\u0435\u043d\u044c: "

    invoke-direct {v4, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v8, v0, Lcom/adib/maintenance/TaskManagementActivity;->day:Ljava/lang/String;

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v8, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda42;

    invoke-direct {v8, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda42;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v10, "day"

    invoke-direct {v0, v4, v10, v8}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 92
    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->plan()Lorg/json/JSONObject;

    move-result-object v4

    const-string v8, "ids"

    invoke-static {v4, v8}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    iget-object v8, v0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string v11, "tasks"

    invoke-static {v8, v11}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v8

    invoke-static {v4, v8}, Lcom/adib/maintenance/TaskManagementActivity;->budget(Lorg/json/JSONArray;Lorg/json/JSONObject;)I

    move-result v8

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v11

    const-string v12, "budgetMinutes"

    const/16 v13, 0x78

    invoke-virtual {v11, v12, v13}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v11

    move v12, v6

    move v13, v12

    :goto_2
    iget-object v14, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v14}, Lorg/json/JSONArray;->length()I

    move-result v14

    if-ge v12, v14, :cond_5

    iget-object v14, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v14, v12}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v14

    if-eqz v14, :cond_4

    iget-object v14, v0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v14, v12}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v14

    invoke-static {v14}, Lcom/adib/maintenance/TaskManagementActivity;->working(Lorg/json/JSONObject;)Z

    move-result v14

    if-eqz v14, :cond_4

    add-int/lit8 v13, v13, 0x1

    :cond_4
    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    .line 93
    :cond_5
    iget-object v12, v0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v10, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    const-string v14, " \u043c\u0438\u043d"

    const-string v15, "dailyTaskLimit"

    const-string v9, " / "

    const/16 v3, 0x12

    const/4 v2, 0x4

    if-eqz v12, :cond_6

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v12

    invoke-virtual {v12, v15, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v12

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v12, " \u0437\u0430\u0434\u0430\u0447 \u00b7 "

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v0, v6, v3, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v6

    invoke-virtual {v1, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 94
    :cond_6
    iget-object v6, v0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v10, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    new-instance v6, Landroid/widget/ProgressBar;

    const/4 v12, 0x0

    const v3, 0x1010078

    invoke-direct {v6, v0, v12, v3}, Landroid/widget/ProgressBar;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-static {v5, v11}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v6, v3}, Landroid/widget/ProgressBar;->setMax(I)V

    invoke-virtual {v6, v8}, Landroid/widget/ProgressBar;->setProgress(I)V

    sget v3, Lcom/adib/maintenance/TaskManagementActivity;->BLUE:I

    invoke-static {v3}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v3

    invoke-virtual {v6, v3}, Landroid/widget/ProgressBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v12, "\u0411\u044e\u0434\u0436\u0435\u0442 \u0434\u043d\u044f: "

    invoke-direct {v3, v12}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v12, " \u0438\u0437 "

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v12, " \u043c\u0438\u043d\u0443\u0442"

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v3}, Landroid/widget/ProgressBar;->setContentDescription(Ljava/lang/CharSequence;)V

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v12, 0x41000000    # 8.0f

    invoke-direct {v0, v12}, Lcom/adib/maintenance/TaskManagementActivity;->dp(F)I

    move-result v12

    invoke-direct {v3, v7, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v6, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v6, "\u041e\u0441\u0442\u0430\u043b\u043e\u0441\u044c "

    invoke-direct {v3, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sub-int v6, v11, v8

    const/4 v12, 0x0

    invoke-static {v12, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/16 v6, 0xd

    invoke-direct {v0, v3, v6, v12}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3

    :cond_7
    const/4 v12, 0x0

    .line 95
    :goto_3
    iget-object v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    if-le v8, v11, :cond_9

    const-string v3, "\u041f\u043b\u0430\u043d \u043f\u0440\u0435\u0432\u044b\u0448\u0430\u0435\u0442 \u0431\u044e\u0434\u0436\u0435\u0442 \u0432\u0440\u0435\u043c\u0435\u043d\u0438"

    const/16 v6, 0xe

    invoke-direct {v0, v3, v6, v12}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v3

    iget-boolean v6, v0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    if-eqz v6, :cond_8

    const/16 v6, 0xbc

    const/16 v8, 0x6a

    const/16 v11, 0xff

    invoke-static {v11, v6, v8}, Landroid/graphics/Color;->rgb(III)I

    move-result v6

    goto :goto_4

    :cond_8
    const/16 v6, 0x98

    const/16 v8, 0x4f

    invoke-static {v6, v8, v12}, Landroid/graphics/Color;->rgb(III)I

    move-result v6

    :goto_4
    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 96
    :cond_9
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v6, "\u0412 \u0440\u0430\u0431\u043e\u0442\u0435: "

    invoke-direct {v3, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v6

    const-string v8, "wipLimit"

    const/4 v9, 0x2

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " \u00b7 \u0442\u043e\u043b\u044c\u043a\u043e \u041c\u043e\u0438 \u0437\u0430\u0434\u0430\u0447\u0438"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/16 v6, 0xe

    const/4 v12, 0x0

    invoke-direct {v0, v3, v6, v12}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 97
    const-string v1, "settings"

    iget-object v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settingsForm()V

    return-void

    .line 98
    :cond_a
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v10, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_d

    .line 99
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v6, "\u0413\u043b\u0430\u0432\u043d\u0430\u044f \u0437\u0430\u0434\u0430\u0447\u0430 \u0438 \u0434\u043e "

    invoke-direct {v3, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v6

    invoke-virtual {v6, v15, v2}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v2

    sub-int/2addr v2, v5

    const/4 v12, 0x0

    invoke-static {v12, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \u0434\u043e\u043f\u043e\u043b\u043d\u0438\u0442\u0435\u043b\u044c\u043d\u044b\u0445"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x12

    invoke-direct {v0, v2, v3, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 100
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-nez v1, :cond_b

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v2, "\u041f\u043b\u0430\u043d \u043f\u0443\u0441\u0442. \u0412\u044b\u0431\u0435\u0440\u0438\u0442\u0435 \u0437\u0430\u0434\u0430\u0447\u0438 \u043d\u0438\u0436\u0435. \u041f\u0440\u043e\u0441\u0440\u043e\u0447\u0435\u043d\u043d\u044b\u0435 \u0430\u0432\u0442\u043e\u043c\u0430\u0442\u0438\u0447\u0435\u0441\u043a\u0438 \u043d\u0435 \u0434\u043e\u0431\u0430\u0432\u043b\u044f\u044e\u0442\u0441\u044f."

    const/16 v3, 0x10

    invoke-direct {v0, v2, v3, v12}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_b
    const/4 v1, 0x0

    .line 101
    :goto_5
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_c

    invoke-virtual {v4, v1}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Lcom/adib/maintenance/TaskManagementActivity;->dayCard(Ljava/lang/String;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 102
    :cond_c
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v2, "\u0414\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u0432 \u043f\u043b\u0430\u043d"

    const/16 v3, 0x12

    invoke-direct {v0, v2, v3, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_7

    :cond_d
    const/16 v3, 0x12

    .line 104
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v4, "\u0420\u0430\u0437\u0431\u0438\u0440\u0430\u0439\u0442\u0435 \u043f\u043e \u043e\u0434\u043d\u043e\u0439 \u0437\u0430\u0434\u0430\u0447\u0435"

    invoke-direct {v0, v4, v3, v5}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 105
    new-array v1, v2, [Ljava/lang/String;

    const-string v3, "incoming"

    const/16 v16, 0x0

    aput-object v3, v1, v16

    const-string v3, "overdue"

    aput-object v3, v1, v5

    const-string v3, "stale"

    aput-object v3, v1, v9

    const-string v3, "waiting"

    const/4 v4, 0x3

    aput-object v3, v1, v4

    new-array v3, v2, [Ljava/lang/String;

    const-string v6, "\u0412\u0445\u043e\u0434\u044f\u0449\u0438\u0435"

    aput-object v6, v3, v16

    const-string v6, "\u041f\u0440\u043e\u0441\u0440\u043e\u0447\u0435\u043d\u043d\u044b\u0435"

    aput-object v6, v3, v5

    const-string v6, "\u0414\u0430\u0432\u043d\u043e \u0431\u0435\u0437 \u043e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u044f"

    aput-object v6, v3, v9

    const-string v6, "\u041f\u0440\u043e\u0432\u0435\u0440\u0438\u0442\u044c \u0434\u0435\u043b\u0435\u0433\u0438\u0440\u043e\u0432\u0430\u043d\u043d\u044b\u0435"

    aput-object v6, v3, v4

    .line 106
    new-instance v4, Landroid/widget/Spinner;

    invoke-direct {v4, v0}, Landroid/widget/Spinner;-><init>(Landroid/content/Context;)V

    const-string v6, "review-filter"

    invoke-virtual {v4, v6}, Landroid/widget/Spinner;->setTag(Ljava/lang/Object;)V

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->panel()I

    move-result v6

    iget-boolean v8, v0, Lcom/adib/maintenance/TaskManagementActivity;->dark:Z

    invoke-static {v8}, Lcom/adib/maintenance/HybridUi;->border(Z)I

    move-result v8

    invoke-direct {v0, v6, v8}, Lcom/adib/maintenance/TaskManagementActivity;->shape(II)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v4, v6}, Landroid/widget/Spinner;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v6, Lcom/adib/maintenance/TaskManagementActivity$1;

    const v8, 0x1090008

    invoke-direct {v6, v0, v0, v8, v3}, Lcom/adib/maintenance/TaskManagementActivity$1;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Landroid/content/Context;I[Ljava/lang/String;)V

    invoke-virtual {v4, v6}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    const/4 v3, 0x0

    const/4 v12, 0x0

    :goto_6
    if-ge v12, v2, :cond_f

    aget-object v6, v1, v12

    iget-object v8, v0, Lcom/adib/maintenance/TaskManagementActivity;->review:Ljava/lang/String;

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_e

    move v3, v12

    :cond_e
    add-int/lit8 v12, v12, 0x1

    goto :goto_6

    :cond_f
    invoke-virtual {v4, v3}, Landroid/widget/Spinner;->setSelection(I)V

    iget-boolean v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->busy:Z

    xor-int/2addr v2, v5

    invoke-virtual {v4, v2}, Landroid/widget/Spinner;->setEnabled(Z)V

    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$2;

    invoke-direct {v2, v0, v1}, Lcom/adib/maintenance/TaskManagementActivity$2;-><init>(Lcom/adib/maintenance/TaskManagementActivity;[Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    invoke-direct {v2, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v4, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 108
    :goto_7
    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    const-string v2, "\u041f\u043e\u0438\u0441\u043a"

    iget-object v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    const/4 v12, 0x0

    invoke-direct {v0, v1, v2, v3, v12}, Lcom/adib/maintenance/TaskManagementActivity;->field(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v1

    const-string v2, "search"

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    invoke-direct {v0}, Lcom/adib/maintenance/TaskManagementActivity;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, v0, Lcom/adib/maintenance/TaskManagementActivity;->list:Landroid/widget/LinearLayout;

    iget-object v3, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 109
    new-instance v2, Lcom/adib/maintenance/TaskManagementActivity$3;

    invoke-direct {v2, v0}, Lcom/adib/maintenance/TaskManagementActivity$3;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    invoke-virtual {v0}, Lcom/adib/maintenance/TaskManagementActivity;->renderList()V

    iget-object v1, v0, Lcom/adib/maintenance/TaskManagementActivity;->content:Landroid/widget/LinearLayout;

    invoke-direct {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->syncControls(Landroid/view/View;)V

    return-void
.end method

.method renderList()V
    .locals 13

    .line 131
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-static {p0, v0}, Lcom/adib/maintenance/OfflineDeletes;->filterTasks(Landroid/content/Context;Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    invoke-static {p0, v0}, Lcom/adib/maintenance/OfflineDeletes;->filterState(Landroid/content/Context;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    iput-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->list:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    goto/16 :goto_4

    :cond_0
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->plan()Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "ids"

    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->array(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    move v3, v2

    :goto_0
    iget-object v4, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v4

    const/16 v5, 0xe

    if-ge v2, v4, :cond_7

    iget-object v4, p0, Lcom/adib/maintenance/TaskManagementActivity;->tasks:Lorg/json/JSONArray;

    invoke-virtual {v4, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    if-eqz v6, :cond_6

    const-string v4, "completed"

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_6

    const-string v4, "title"

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    sget-object v7, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v4, v7}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    iget-object v7, p0, Lcom/adib/maintenance/TaskManagementActivity;->query:Ljava/lang/String;

    sget-object v8, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v7, v8}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    goto/16 :goto_2

    :cond_1
    const-string v4, "id"

    invoke-virtual {v6, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v7, "day"

    iget-object v8, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-static {v0, v4}, Lcom/adib/maintenance/TaskManagementActivity;->contains(Lorg/json/JSONArray;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_3

    goto/16 :goto_2

    :cond_2
    invoke-virtual {p0, v4}, Lcom/adib/maintenance/TaskManagementActivity;->meta(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v7

    iget-object v8, p0, Lcom/adib/maintenance/TaskManagementActivity;->containers:Lorg/json/JSONArray;

    iget-object v9, p0, Lcom/adib/maintenance/TaskManagementActivity;->review:Ljava/lang/String;

    invoke-static {}, Lcom/adib/maintenance/TaskManagementActivity;->today()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {p0}, Lcom/adib/maintenance/TaskManagementActivity;->settings()Lorg/json/JSONObject;

    move-result-object v11

    const-string v12, "staleDays"

    invoke-virtual {v11, v12, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v11

    invoke-static/range {v6 .. v11}, Lcom/adib/maintenance/TaskManagementActivity;->eligible(Lorg/json/JSONObject;Lorg/json/JSONObject;Lorg/json/JSONArray;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v7

    if-nez v7, :cond_3

    goto/16 :goto_2

    :cond_3
    add-int/lit8 v3, v3, 0x1

    iget v7, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    if-le v3, v7, :cond_4

    goto/16 :goto_2

    .line 132
    :cond_4
    iget-object v7, p0, Lcom/adib/maintenance/TaskManagementActivity;->list:Landroid/widget/LinearLayout;

    invoke-direct {p0, v7, v1}, Lcom/adib/maintenance/TaskManagementActivity;->card(Landroid/widget/LinearLayout;Z)Landroid/widget/LinearLayout;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "candidate:"

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    invoke-direct {p0, v7, v6}, Lcom/adib/maintenance/TaskManagementActivity;->taskTitle(Landroid/widget/LinearLayout;Lorg/json/JSONObject;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "status"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "date"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_5

    const-string v9, ""

    goto :goto_1

    :cond_5
    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, " \u00b7 "

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    :goto_1
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8, v5, v1}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v5

    invoke-direct {p0}, Lcom/adib/maintenance/TaskManagementActivity;->muted()I

    move-result v8

    invoke-virtual {v5, v8}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {v7, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 133
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v8, "add:"

    invoke-direct {v5, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-instance v8, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda26;

    invoke-direct {v8, p0, v4}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda26;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v9, "\u041d\u0430 \u0432\u044b\u0431\u0440\u0430\u043d\u043d\u044b\u0439 \u0434\u0435\u043d\u044c"

    invoke-direct {p0, v9, v5, v8}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v5

    invoke-virtual {v7, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 134
    const-string v5, "review"

    iget-object v8, p0, Lcom/adib/maintenance/TaskManagementActivity;->tab:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v8, "later:"

    invoke-direct {v5, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-instance v8, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda27;

    invoke-direct {v8, p0, v4}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda27;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v9, "\u041f\u043e\u0437\u0436\u0435"

    invoke-direct {p0, v9, v5, v8}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v5

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "delegate:"

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda28;

    invoke-direct {v9, p0, v4}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda28;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    const-string v10, "\u0414\u0435\u043b\u0435\u0433\u0438\u0440\u043e\u0432\u0430\u0442\u044c"

    invoke-direct {p0, v10, v8, v9}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v8

    invoke-direct {p0, v7, v5, v8}, Lcom/adib/maintenance/TaskManagementActivity;->pair(Landroid/widget/LinearLayout;Landroid/widget/Button;Landroid/widget/Button;)V

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v8, "delete:"

    invoke-direct {v5, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda29;

    invoke-direct {v5, p0, v6}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda29;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    const-string v6, "\u0423\u0434\u0430\u043b\u0438\u0442\u044c"

    invoke-direct {p0, v6, v4, v5}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v4

    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_6
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    .line 136
    :cond_7
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->list:Landroid/widget/LinearLayout;

    if-nez v3, :cond_8

    const-string v2, "\u041d\u0435\u0442 \u0437\u0430\u0434\u0430\u0447 \u0434\u043b\u044f \u044d\u0442\u043e\u0433\u043e \u0444\u0438\u043b\u044c\u0442\u0440\u0430"

    goto :goto_3

    :cond_8
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "\u041f\u043e\u043a\u0430\u0437\u0430\u043d\u043e "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v4, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " \u0438\u0437 "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_3
    invoke-direct {p0, v2, v5, v1}, Lcom/adib/maintenance/TaskManagementActivity;->label(Ljava/lang/String;IZ)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->shown:I

    if-le v3, v0, :cond_9

    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->list:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda30;

    invoke-direct {v1, p0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda30;-><init>(Lcom/adib/maintenance/TaskManagementActivity;)V

    const-string v2, "\u041f\u043e\u043a\u0430\u0437\u0430\u0442\u044c \u0435\u0449\u0451 20"

    const-string v3, "more"

    invoke-direct {p0, v2, v3, v1}, Lcom/adib/maintenance/TaskManagementActivity;->button(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    :cond_9
    :goto_4
    return-void
.end method

.method settings()Lorg/json/JSONObject;
    .locals 2

    .line 52
    iget-object v0, p0, Lcom/adib/maintenance/TaskManagementActivity;->state:Lorg/json/JSONObject;

    const-string v1, "settings"

    invoke-static {v0, v1}, Lcom/adib/maintenance/TaskManagementActivity;->object(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method startTask(Ljava/lang/String;Z)V
    .locals 3

    .line 145
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "id"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "status"

    const-string v2, "In progress"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v0

    if-eqz p2, :cond_0

    const-string p2, "wipOverride"

    const/4 v1, 0x1

    invoke-virtual {v0, p2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    :cond_0
    new-instance p2, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda10;

    invoke-direct {p2, p0, v0}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda10;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda12;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda12;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Ljava/lang/String;)V

    invoke-direct {p0, p2, v0}, Lcom/adib/maintenance/TaskManagementActivity;->perform(Lcom/adib/maintenance/TaskManagementActivity$Operation;Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    return-void
.end method

.method update(Lorg/json/JSONObject;)V
    .locals 1

    .line 144
    :try_start_0
    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->withRevision(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    new-instance v0, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0, p1}, Lcom/adib/maintenance/TaskManagementActivity$$ExternalSyntheticLambda2;-><init>(Lcom/adib/maintenance/TaskManagementActivity;Lorg/json/JSONObject;)V

    const/4 p1, 0x0

    invoke-direct {p0, v0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->perform(Lcom/adib/maintenance/TaskManagementActivity$Operation;Ljava/lang/Runnable;)V

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/adib/maintenance/TaskManagementActivity;->error(Ljava/lang/String;)V

    return-void
.end method
