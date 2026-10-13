# Android 2.5.76 — working task screen
Apply AFTER android-patches/simple-cards (2.5.75), retaining all preceding patches. Copy the Java runtime files to app/src/main/java/com/adib/maintenance and test files to the matching test package.
Set versionCode 126, versionName "2.5.76-navigation-time". Keep the existing application ID and private release signer. No signing material is included.

Selected concept 3: working actions first, compact metadata, planned time, description preview, original subtasks and independent completion squares. Photos/results and all original fields are separately reachable. Original widgets, collectors and autosave handlers remain intact. Existing Pomodoro and equipment work timers are reused rather than replaced by cosmetic switches.
Task completion is held for five seconds. Cancel performs no completion write. Separate pending tasks have separate Undo controls. Cancelling the editor prevents its pending completion from saving.
All task-list, matrix, Kanban, calendar and day-plan/review views have a centered circular add control. Clock navigation item is removed; timer functionality remains reachable from tasks/drawer.
Calendar day/week/three-day hour height is saved per view on this device (32–160 dp). Menu zoom, reset and vertical two-finger zoom do not change task dates. Month is unchanged.
Equipment total label is Vaxt with whole minutes or hours/minutes. Native Windows is excluded. Tests are automated; physical Android installation and gesture handling remain to be checked by the user.


## Work assignee chooser update (pending next APK)
The start dialog includes “Təyin olunanları dəyiş”. It opens source-specific Tapsirildi options with search and multiple checkboxes. Existing assignments missing from options are preserved. Cancel before save does not write. “Saxla və qayıt” requires at least one employee and returns to the chooser after confirmed save; it never starts work automatically. The previously selected worker is preserved if still assigned. Missing edit permission disables assignment changes; server authorization remains unchanged.

Copy WorkAssigneeSelection.java alongside WorkTimerClient.java (both patch folders include the model). Apply the latest work-screen MainActivity.java: it binds assignment edits to the existing task editor field and autosave queue and unbinds on dismissal. Pending/error saves stay visible; a locally queued change is not presented as a server-confirmed success. Standalone/reminder contexts use a partial PATCH /api/task containing only id/sourceKey/tapsirildi.

Isolated Android dialog tests: test/android-assignee-dialog/README.md. These compile the changed timer client with support doubles and exercise Android API 28 and 35, not a complete signed app. No updated APK is included; full build and physical-device verification are required before release. Web/PWA and native Windows are not changed by this feature.
