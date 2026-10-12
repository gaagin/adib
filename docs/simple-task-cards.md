# Simple task cards — Android and online/PWA
Based on main 777d1bf668fc71cf1eaee052bcf67ce5caac615c.

## Presentation
- White rounded task groups; uncluttered rows with neutral checkboxes and normal-weight titles.
- Employee badge and readable date/time shown only when present.
- Completed tasks muted in a separately collapsible group. Stored preference does not remove task data.
- Status, priority, container and idle zero-Pomodoro decorations removed from cards, not task properties.
- Active Pomodoro/error indicators remain visible; editor and context actions retained.
- Native Windows excluded by existing ADIBDesktop guard. Request policy and timer/session backend unchanged.

## Validation
71 Android test cases (SDK 24/28/35 coverage in relevant tests), zero failures; 16 Node regressions passed.
Browser checks at 390 and 1280 widths: grouping/collapse, employee label, idle/active timer visibility, editor access, dark theme, list/Kanban and native Windows guard. Native Android visual snapshots reviewed in light/dark themes and Kanban.
APK versionCode 125, same app ID and existing release signer. Physical-device installation and live Railway deployment not verified.

## Install
Direct ZIP includes one signed APK. Install over 2.5.74 without uninstalling.
GitHub fallback: save downloads/Download-ADIB-Android-2.5.75.html using Raw, open the saved HTML and click download.
Online/PWA changes take effect only after merging this branch and successful deployment.
