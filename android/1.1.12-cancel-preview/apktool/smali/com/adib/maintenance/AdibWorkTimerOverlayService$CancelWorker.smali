.class final Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelWorker;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private final service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;

.method constructor <init>(Lcom/adib/maintenance/AdibWorkTimerOverlayService;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelWorker;->service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;
    return-void
.end method

.method public run()V
    .locals 1
    iget-object v0, p0, Lcom/adib/maintenance/AdibWorkTimerOverlayService$CancelWorker;->service:Lcom/adib/maintenance/AdibWorkTimerOverlayService;
    invoke-virtual {v0}, Lcom/adib/maintenance/AdibWorkTimerOverlayService;->cancelPendingOnWorker()V
    return-void
.end method
