# Bounded phone menus

Scope: online/mobile web and installed browser PWA. Native Windows is excluded by the existing ADIBDesktop guard; no APK is included.

## Fixes
- Put task actions, photo actions, view/filter menus, equipment actions, autocomplete, task-card and context menus in the browser popover top layer on screens up to 700px. Original DOM controls, IDs and handlers remain intact.
- Position panels inside the visual viewport, above the bottom navigation. Long panels scroll; labels wrap and controls have phone-sized touch targets.
- Close menus on outside click, navigation and selection of task/photo actions. Escape closes the popup without closing its parent task editor.
- Reposition open menus after viewport resizing/scrolling; restore original desktop panel styles above the phone breakpoint.
- Bound settings, employee and clock/work dialogs to the viewport.
- Align online discussion mobile layout at 700px, fixing conversation overlap at 651–700px. Native Windows keeps its original 650px threshold.
- Update the service worker cache to adib-online-v280-bounded-phone-menus.

## Verification
- `npm test`: 24 passed, 0 failed.
- New real-app fixture browser audit: 320×640, 390×850, 430×740, 700×500. Covers actions in both themes, original timer-action invocation, photos, cards, context menus, calendar/matrix/kanban filters, equipment search, properties, employee selection, discussion navigation, settings, clock and resize. See PHONE-MENU-AUDIT-REPORT.json.
- Existing browser suites: focused views (11 screen checks), discussion sidebar (3), mobile equipment (4), task footer (4), simple cards (3), all passed.
- Corrected the old focused-view discussion assertion to reflect the already-approved persistent desktop sidebar; desktop production layout was not changed by that test correction.
- `git diff --check`: passed.

Tests use sandbox Chromium and fixture APIs. Live deployment, physical phones, Android APK and Railway rollout were not verified.
