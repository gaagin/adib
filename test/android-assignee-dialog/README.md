# Isolated Android assignment dialog tests

Run with JDK 17+, Gradle 8.13+, and ANDROID_HOME pointing to SDK platform android-35:

    gradle -p test/android-assignee-dialog test

Copies the actual WorkTimerClient and WorkAssigneeSelection from the work-screen patch. Uses Robolectric on API 28 and 35. Support.java supplies test doubles for unrelated services/accounts; TaskAutosave.java is an existing autosave implementation fixture (not production replacement). This is not a complete APK build and does not test real server authorization. Production continues using the existing /api/task edit checks and /api/work-timer worker checks.
