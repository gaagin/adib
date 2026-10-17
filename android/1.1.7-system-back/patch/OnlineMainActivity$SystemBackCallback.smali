.class final Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;
.super Ljava/lang/Object;
.implements Landroid/window/OnBackInvokedCallback;
.source "OnlineMainActivity.java"

.field final synthetic this$0:Lcom/adib/maintenance/OnlineMainActivity;

.method constructor <init>(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0
    iput-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;->this$0:Lcom/adib/maintenance/OnlineMainActivity;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onBackInvoked()V
    .locals 1
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity$SystemBackCallback;->this$0:Lcom/adib/maintenance/OnlineMainActivity;
    invoke-virtual {v0}, Lcom/adib/maintenance/OnlineMainActivity;->dispatchSystemBack()V
    return-void
.end method
