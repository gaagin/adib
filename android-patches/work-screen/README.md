# Android 2.5.76 — working task screen
Apply AFTER android-patches/simple-cards (2.5.75), retaining all preceding patches. Copy the Java runtime files to app/src/main/java/com/adib/maintenance and test files to the matching test package.
Set versionCode 126, versionName "2.5.76-navigation-time". Keep the existing application ID and private release signer. No signing material is included.

Selected concept 3: working actions first, compact metadata, planned time, description preview, original subtasks and independent completion squares. Photos/results and all original fields are separately reachable. Original widgets, collectors and autosave handlers remain intact. Existing Pomodoro and equipment work timers are reused rather than replaced by cosmetic switches.
Task completion is held for five seconds. Cancel performs no completion write. Separate pending tasks have separate Undo controls. Cancelling the editor prevents its pending completion from saving.
All task-list, matrix, Kanban, calendar and day-plan/review views have a centered circular add control. Clock navigation item is removed; timer functionality remains reachable from tasks/drawer.
Calendar day/week/three-day hour height is saved per view on this device (32–160 dp). Menu zoom, reset and vertical two-finger zoom do not change task dates. Month is unchanged.
Equipment total label is Vaxt with whole minutes or hours/minutes. Native Windows is excluded. Tests are automated; physical Android installation and gesture handling remain to be checked by the user.
