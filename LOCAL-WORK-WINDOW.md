# Work timer: local automatic window

Only the browser/profile or Android app that started a new work session automatically displays its floating work timer. Other devices keep shared task state and calendar/history but do not automatically open that window. Pomodoro and Windows binaries are unchanged.

Browser ownership is persisted per origin and account in localStorage. Tabs of the same profile share that ownership. An acknowledged local start/continue operation can recover the window after a lost response. No new network requests or polling intervals are introduced. Explicit time-confirmation requests are not blocked. Sessions started before this update lack an ownership marker and do not automatically open an overlay; they can still be accessed from the task.

Deploy this online branch and reload ADIB. Android native work overlays also require installing the separately built 2.5.71-local-work APK over 2.5.70; the online deployment alone does not update the Android service. Matching Android source changes are in android-patches/local-work-window/.

Validation: 8 online tests passed (`node --test test/local-work-window.test.cjs`), 60 Android work tests passed; extended Pomodoro/state test result is documented in the Android patch README. APK signer matches 2.5.70.
