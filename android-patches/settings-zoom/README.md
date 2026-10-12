# Android 2.5.74 settings and equipment zoom
Apply after android-patches/focused-views (2.5.73). Copy MainActivity.java to app/src/main/java/com/adib/maintenance and the two tests to app/src/test/java/com/adib/maintenance. Set versionCode 124 and versionName 2.5.74-settings-zoom. Sign with the existing ADIB signer; no credentials are included.

Settings always show a settings menu. Employees have device options as well as an explicit account/profile choice. Equipment canvas supports direct two-finger pinch, pan, minus/fit/plus buttons, and local per-scope camera preservation through background redraws. These actions do not call the API. Task/employee discussion behavior, work timer ownership and Pomodoro synchronization are unchanged.
