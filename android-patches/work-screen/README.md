# Android — task properties, date range and equipment defaults
Apply AFTER android-patches/simple-cards (2.5.75), retaining all preceding patches. Copy the Java runtime files to app/src/main/java/com/adib/maintenance and test files to the matching test package.
Set versionCode 130, versionName "2.5.80-task-properties". Keep the existing application ID and private release signer. No signing material is included.

Restored the familiar scrollable/tabbed task-properties editor; the newer action-first work screen is no longer installed in production. Equipment task creation and editing use the consistent order Ad → Tapsirildi → Avadanliq → Tapşırıqlar bazası → Tarix və vaxt → Plan → remaining properties. Date fields use a theme-aware Notion-style range picker on Android and phone web, with optional time/end date and timezone display. Date ranges are sent through the existing date/dateEnd API fields. The equipment default-view preference is keyed by stable account/datasource identity rather than a changeable account revision, migrated from the previous key where possible, and committed synchronously.
Task completion is held for five seconds. Cancel performs no completion write. Separate pending tasks have separate Undo controls. Cancelling the editor prevents its pending completion from saving.
All task-list, matrix, Kanban, calendar and day-plan/review views have a centered circular add control. Clock navigation item is removed; timer functionality remains reachable from tasks/drawer.
Calendar day/week/three-day hour height is saved per view on this device (32–160 dp). Menu zoom, reset and vertical two-finger zoom do not change task dates. Month is unchanged.
Equipment total label is Vaxt with whole minutes or hours/minutes. Native Windows is excluded. Tests are automated; physical Android installation and gesture handling remain to be checked by the user.


## Work assignee chooser update (pending next APK)
The start dialog includes “Təyin olunanları dəyiş”. It opens source-specific Tapsirildi options with search and multiple checkboxes. Existing assignments missing from options are preserved. Cancel before save does not write. “Saxla və qayıt” requires at least one employee and returns to the chooser after confirmed save; it never starts work automatically. The previously selected worker is preserved if still assigned. Missing edit permission disables assignment changes; server authorization remains unchanged.

Copy WorkAssigneeSelection.java alongside WorkTimerClient.java (both patch folders include the model). Apply the latest work-screen MainActivity.java: it binds assignment edits to the existing task editor field and autosave queue and unbinds on dismissal. Pending/error saves stay visible; a locally queued change is not presented as a server-confirmed success. Standalone/reminder contexts use a partial PATCH /api/task containing only id/sourceKey/tapsirildi.

Isolated Android dialog tests: test/android-assignee-dialog/README.md. These compile the changed timer client with support doubles and exercise Android API 28 and 35, not a complete signed app. No updated APK is included; full build and physical-device verification are required before release. Web/PWA and native Windows are not changed by this feature.

## Equipment view chooser and local default (pending next APK)
The equipment canvas “Lövhə” menu now exposes “Siyahı rejimi”, “Kanban rejimi”, “Sxem rejimi” and “Defolt görünüş”. The task-list/board menu “Görünüş” opens a three-option chooser. The list shows tasks within the current machine or plan tree, not a replacement equipment-object hierarchy; switching views preserves that scope.

“Defolt görünüş” offers Sxem, Siyahı, Kanban and Son seçilmiş görünüş. It is also available under device settings. Saxla stores the preference locally per connection/account; cancellation does not save. Saving the default does not replace the currently displayed view. It applies on the next equipment-section entry (bottom navigation/drawer), including after app restart; normal Tasks startup and explicit widget navigation are unchanged. “Son seçilmiş görünüş” restores the last explicit view choice. Refresh and deferred loading retain the selected view and load fresh task data.

Copy EquipmentViewPreferences.java with the latest MainActivity.java into the main package; EquipmentViewsTest.java belongs in the test package. The equipment view default remains local to this device/profile; view choice and default remain distinct. The task-properties form/date picker also covers the mobile web client. Native Windows is unchanged. No new signed APK is included in this patch; physical-device validation and a newly versioned APK remain required before release.


## Equipment search and new-task source default (pending next APK)
The equipment selector in the work-task form is now searchable by equipment name (case- and diacritic-insensitive), while remaining a Spinner-compatible field so task editing/autosave keep using the same selected equipment ID. New equipment tasks default to Gorulen isler. The source selector still lets the user choose ToDo; quick-add choices are respected, and equipment subtasks remain ToDo. Existing tasks are unchanged.
