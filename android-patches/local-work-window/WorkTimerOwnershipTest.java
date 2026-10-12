package com.adib.maintenance;
import android.content.Context;import org.json.*;import org.junit.*;import org.junit.runner.RunWith;import org.robolectric.*;import org.robolectric.annotation.Config;import static org.junit.Assert.*;
@RunWith(RobolectricTestRunner.class) @Config(sdk={24,28,35})
public class WorkTimerOwnershipTest {
 Context c;
 @Before public void before(){c=RuntimeEnvironment.getApplication();WorkTimerClient.commandPrefs(c,WorkTimerClient.scope(c)).edit().clear().commit();}
 @After public void after(){WorkTimerClient.commandPrefs(c,WorkTimerClient.scope(c)).edit().clear().commit();}
 JSONObject session(String id,String op)throws Exception{return new JSONObject().put("id",id).put("status","running").put("startOperation",op);}
 JSONObject command(String action,String op)throws Exception{return new JSONObject().put("action",action).put("operationId",op);}
 @Test public void remoteSessionCannotAutomaticallyStartOverlay()throws Exception{JSONObject s=session("remote","remote-op");assertFalse(WorkTimerOwnership.allowed(c,s));WorkTimerService.sync(c,s);assertNull(Shadows.shadowOf((android.app.Application)c).getNextStartedService());}
 @Test public void confirmedLocalStartSurvivesClientResetAndStop()throws Exception{JSONObject s=session("local","local-op");WorkTimerOwnership.confirm(c,command("start","local-op"),s);assertTrue(WorkTimerOwnership.allowed(c,s));WorkTimerClient.state=new JSONObject();s.put("status","pending");assertTrue(WorkTimerOwnership.allowed(c,s));}
 @Test public void continueOwnsNewSessionButNotLaterRemoteSession()throws Exception{WorkTimerOwnership.confirm(c,command("continue","next-op"),session("next","next-op"));assertTrue(WorkTimerOwnership.allowed(c,session("next","next-op")));assertFalse(WorkTimerOwnership.allowed(c,session("remote","remote-op")));}
 @Test public void nonStartOrWrongOperationNeverClaimsOverlay()throws Exception{JSONObject s=session("remote","other-op");WorkTimerOwnership.confirm(c,command("start","local-op"),s);assertFalse(WorkTimerOwnership.allowed(c,s));WorkTimerOwnership.confirm(c,command("stop","other-op"),s);assertFalse(WorkTimerOwnership.allowed(c,s));assertFalse(WorkTimerOwnership.allowed(c,null));}
}
