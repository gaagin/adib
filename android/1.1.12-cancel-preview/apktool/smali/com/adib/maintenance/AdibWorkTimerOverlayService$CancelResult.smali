.class final Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private final service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;
.field private final error:Ljava/lang/String;

.method constructor <init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;Ljava/lang/String;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;->service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;
    iput-object p2, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;->error:Ljava/lang/String;
    return-void
.end method

.method public run()V
    .locals 2
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;->service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;
    iget-object v1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelResult;->error:Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->finishCancelPending(Ljava/lang/String;)V
    return-void
.end method
