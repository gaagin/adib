.class final Lcom/adib/maintenance/ReminderCardSwipeOpen;
.super Ljava/lang/Object;
.source "ReminderCardSwipeOpen.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;

# instance fields
.field private final context:Landroid/content/Context;
.field private final taskId:Ljava/lang/String;
.field private downY:F
.field private tracking:Z

# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->context:Landroid/content/Context;
    iput-object p2, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->taskId:Ljava/lang/String;
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->tracking:Z
    return-void
.end method

# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 7
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I
    move-result v0
    if-nez v0, :action_up
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F
    move-result v0
    iput v0, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->downY:F
    const/4 v0, 0x1
    iput-boolean v0, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->tracking:Z
    return v0

    :action_up
    const/4 v1, 0x1
    if-ne v0, v1, :not_up
    iget-boolean v1, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->tracking:Z
    const/4 v2, 0x0
    iput-boolean v2, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->tracking:Z
    if-eqz v1, :consume
    iget v1, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->downY:F
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F
    move-result v3
    sub-float/2addr v1, v3
    iget-object v3, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->context:Landroid/content/Context;
    const/16 v4, 0x38
    invoke-static {v3, v4}, Lcom/adib/maintenance/ReminderCardView;->dp(Landroid/content/Context;I)I
    move-result v3
    int-to-float v3, v3
    cmpg-float v1, v1, v3
    if-gez v1, :open_task
    goto :consume

    :not_up
    const/4 v1, 0x3
    if-ne v0, v1, :consume
    const/4 v1, 0x0
    iput-boolean v1, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->tracking:Z
    goto :consume

    :open_task
    iget-object v1, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->taskId:Ljava/lang/String;
    invoke-static {v1}, Lcom/adib/maintenance/ReminderPopupService;->dismissMatching(Ljava/lang/String;)V
    new-instance v1, Landroid/content/Intent;
    iget-object v2, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->context:Landroid/content/Context;
    const-class v3, Lcom/adib/maintenance/MainActivity;
    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v2, "com.adib.maintenance.WIDGET_TASK"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
    move-result-object v1
    const-string v2, "widget_id"
    iget-object v3, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->taskId:Ljava/lang/String;
    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    move-result-object v1
    const v2, 0x34000000
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    move-result-object v1
    iget-object v2, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->context:Landroid/content/Context;
    invoke-virtual {v2, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    iget-object v2, p0, Lcom/adib/maintenance/ReminderCardSwipeOpen;->context:Landroid/content/Context;
    instance-of v3, v2, Landroid/app/Activity;
    if-eqz v3, :consume
    check-cast v2, Landroid/app/Activity;
    invoke-virtual {v2}, Landroid/app/Activity;->finish()V

    :consume
    const/4 v0, 0x1
    return v0
.end method
