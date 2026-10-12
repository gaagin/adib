# Android local work-timer window patch

Base: ADIB Android 2.5.70-compact (applicationId com.adib.maintenance.planner.fast).
This directory is a source patch, not a standalone Android project. It is not served by the online server.

Copy WorkTimerOwnership.java, WorkTimerClient.java and WorkTimerService.java to app/src/main/java/com/adib/maintenance/ of the existing Android project. Copy WorkTimerOwnershipTest.java to app/src/test/java/com/adib/maintenance/.
Set versionCode 121 and versionName 2.5.71-local-work in app/build.gradle. Build and sign with the existing 2.5.70 signer; no signing credentials are included here. Install the resulting APK over the old app without uninstalling it.

Automatic work overlays require a locally confirmed start/continue operation and matching session ID. Shared task data, session history and calendar are not filtered. Explicit user requests to open time confirmation are still allowed. Pomodoro is unchanged.

Work regression tests: 60 passed across API 24/28/35. Extended run: 114 of 117 passed; the three failures are the existing TaskListPomodoroStateTest Russian `мин` vs Azerbaijani `dəq` assertion. Both that test and its implementation are byte-identical to the 2.5.70 baseline.
