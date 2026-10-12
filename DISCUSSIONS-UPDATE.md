# Fullscreen discussions: online and Android

- Android 2.5.72 adds Müzakirələr to the lower navigation, with an unread badge.
- Online, mobile web/PWA and Android discussions occupy the full application viewport. Windows UI is explicitly excluded via ADIBDesktop and no Windows binary is modified.
- Filters: All, Tasks, Employees, with search and a new-employee-chat chooser. Group chats, starred and saved messages are not added in this change.
- Existing task comments/attachments stay in Notion; direct employee messages are persisted in employee-chats.json beside accounts.json. Keep that directory on the same durable volume used for accounts/work sessions. Direct messages require active ADIB accounts and chat access; sending also requires comment permission. No client-supplied sender is trusted. Disabled or revoked users cannot access conversations.
- Employee chat reads never query Notion. Online refresh is lazy: opening discussions and the existing 45-second refresh while discussions are visible. Android likewise refreshes employee data only while discussions are open. No new polling timer is introduced.
- Direct messages in this initial update are text-only; image compression applies to existing task comments.
- Task-comment images target 150 KiB, stay below 200 KiB, preserve aspect ratio and do not enlarge small files. Existing Windows image policy remains at 200 KiB.
- Login page now links the PWA manifest/icons and registers the existing HTTPS service worker, so installability metadata is present before login. Browser/phone installation must be verified after deployment; this is not an APK installation.
- Work-timer local ownership and Pomodoro behavior are retained.

## Deployment
Merge only with user approval, deploy Railway, then reload ADIB/PWA and install the separately signed Android 2.5.72 APK over the old app without uninstalling. Download helper: downloads/Download-ADIB-Android-2.5.72.html; save that HTML locally, open it, and click Download ZIP. It embeds the exact verified archive and makes no network requests.

## Checks
96 Android tests passed; 16 Node tests passed (8 server/security + 8 work-window regression); actual Chromium scenarios: desktop/mobile 12 each, Windows exclusion 3, real image compression 6. Test report contains full details. Capture/layout diagnostics passed, but the image viewing tool was unavailable, so no manual visual-QA claim is made.
