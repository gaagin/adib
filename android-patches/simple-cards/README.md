# Android 2.5.75 — simple task cards
Apply AFTER android-patches/settings-zoom (2.5.74), keeping earlier patches.
Copy MainActivity.java and CompactDesign.java into app/src/main/java/com/adib/maintenance/.
Copy SimpleCardsTest.java and SimpleCardsVisualTest.java into the matching test package.
Set app/build.gradle versionCode 125 and versionName "2.5.75-simple-cards".
Build with the existing application ID and existing private release signer. No signing credentials are included.

Neutral square checkboxes, normal-weight readable titles, optional pink employee labels and readable date/time ranges. No status/priority/container/zero-Pomodoro clutter. Completed tasks are muted in a collapsible group; collapse state persists. Explicit sorting still separates completed tasks.
Task editing, context actions, completion saves, active Pomodoro and equipment work-timer controls remain available. Existing 7-day completed-history visibility and request policy remain unchanged.
Native Windows is excluded. Physical-device installation has not been tested.
