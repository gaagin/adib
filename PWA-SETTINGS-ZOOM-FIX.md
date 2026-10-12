# PWA settings and Android equipment zoom fix

## Online / installed browser application
- New installations use the standard standalone title bar instead of overlapping window controls.
- Existing installations still in Window Controls Overlay mode reserve its actual height, with a 32 CSS-pixel fallback, across home, calendar, matrix, Kanban/list, equipment, discussions and day-plan panels. Geometry changes update the inset locally. Normal browser tabs reserve no extra space.
- Settings open from the sidebar into a body-level popup, rather than inside the hidden legacy header. The real theme/author controls are reused; explicit account/profile navigation and Close/Escape are available. Popup position is clamped to the viewport.
- Native Windows is excluded by the existing ADIBDesktop runtime guard.

## Android 2.5.74
- Ayarlar opens device/account choices rather than automatically launching AccountActivity and then the tasks home.
- Equipment canvas supports two-finger zoom plus minus/fit/plus controls. Multi-touch cancels item taps and long press. Camera scale and position survive background redraws for the same scope.
- Signed with the same ADIB certificate, applicationId com.adib.maintenance.planner.fast, versionCode 124. Install the APK over the existing app, without uninstalling it.

## Validation and limits
- Android Robolectric regression tests across API24/28/35, including synthetic multi-pointer MotionEvents, camera rebuild preservation and employee/admin settings routing. Native rendering reviewed for fit/zoom/settings.
- Chromium runs the actual online HTML with local API fixtures at390/1280. Window Controls Overlay is simulated via its geometry API, not a real installed Chrome/Edge window. Settings visibility/bounds and all primary overlay headings checked. Native Windows guard checked.
- Real Android phone gesture/installation and real installed PWA OS chrome are not available in this environment and still need user verification.
- Backend, request policy, timer and Pomodoro code are unchanged. No new recurring network requests. No live deployment verification or main-branch merge is implied by this source patch.
