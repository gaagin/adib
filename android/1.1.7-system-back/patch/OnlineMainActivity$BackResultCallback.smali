.class final Lcom/adib/maintenance/OnlineMainActivity$BackResultCallback;
.super Ljava/lang/Object;
.implements Landroid/webkit/ValueCallback;
.source "OnlineMainActivity.java"

.field final synthetic this$0:Lcom/adib/maintenance/OnlineMainActivity;

.method constructor <init>(Lcom/adib/maintenance/OnlineMainActivity;)V
    .locals 0
    iput-object p1, p0, Lcom/adib/maintenance/OnlineMainActivity$BackResultCallback;->this$0:Lcom/adib/maintenance/OnlineMainActivity;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onReceiveValue(Ljava/lang/Object;)V
    .locals 1
    iget-object v0, p0, Lcom/adib/maintenance/OnlineMainActivity$BackResultCallback;->this$0:Lcom/adib/maintenance/OnlineMainActivity;
    check-cast p1, Ljava/lang/String;
    invoke-virtual {v0, p1}, Lcom/adib/maintenance/OnlineMainActivity;->onSystemBackResult(Ljava/lang/String;)V
    return-void
.end method
