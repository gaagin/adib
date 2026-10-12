# ADIB 2.5.76 — selected working-screen concept
- Desktop web/PWA discussions occupy the workspace to the right of the permanent, collapsible sidebar. Mobile remains full-width.
- Bottom clock navigation removed; existing timer/Pomodoro actions retained.
- Equipment/task-work total: `Vaxt: 25 dəq` or `Vaxt: 1 saat 15 dəq`; fractional minutes are floored.
- Direct matrix completion squares; task-card/subtask completion has independent five-second local Undo, without a completion write when cancelled.
- Week/three-day/day vertical calendar scale is saved separately per device/view. Mobile two-finger vertical zoom and menu +/-/reset. Month unchanged.
- Centered round add control across task lists, matrix, Kanban, calendar and day/review views.
- Selected properties concept 3: working actions first, compact metadata, time, description preview/checklist, subtasks, completion/discussion footer; rare original fields/photos/results remain accessible. No fields or save endpoints are removed.
- `task-concept.js/css` are explicitly served by the web server. PWA service-worker version is updated.

Scope: Android and online/PWA. Native Windows retains its previous UI.
APK: com.adib.maintenance.planner.fast, versionCode 126, versionName 2.5.76-navigation-time; same existing release signer.
Validation: Android tests at SDK24/28/35; browser viewport390/1280 and installed-PWA overlay900; sidebar/time checks, per-view zoom persistence, distinct completion queues and five-second cancel/commit checks. Native working-screen light/dark renders inspected. No physical Android install or live Railway deployment verified.
