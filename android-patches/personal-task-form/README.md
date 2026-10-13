# ADIB 2.5.81 — personal task properties and elegant shared UI

Apply after work-screen 2.5.80. Use application ID `com.adib.maintenance.planner.fast`, versionCode **131**, versionName **2.5.81-personal-elegant**, and the existing private signer.

1. Copy the latest work-screen Java runtime/test files into the corresponding native packages.
2. Copy `ElegantUi.java` and `HybridUi.java` into the runtime package, and `PersonalTaskFormTest.java` into unit tests.
3. Copy `assets/direct/core-source.js` and `assets/direct/sources.json` over the matching native direct runtime assets. Keep the current engine wrapper/direct-sync.js and private connection configuration.

## Ordered personal properties

Create/edit use `Ad → Tapsirildi → Avadanlıq → Tapşırıqlar bazası → Tarix və vaxt → Plan → remaining properties`.

The Tasks database is retained. The database field is read-only, not a migration control. Equipment/Plan are optional ADIB associations stored in task-management metadata (and in the existing shared management record in native direct mode); no Notion Tasks schema is created or altered. Existing tags, category, parent task, container, estimate, content, discussions and date ranges are retained. The server validates new references and existing equipment/plan permissions. A machine derives its containing plan; conflicting combinations are rejected.

## Shared visual system

`elegant-ui.css/js` provide quiet light/dark surfaces, stronger hierarchy, readable labels, rounded controls, a two-column desktop form and a stacked phone form. Search dialogs are viewport-bound. Discussion content is collapsed below the form rather than occupying the top. Classic form actions sit outside the scrolling area; autosave retains authority. Mobile height is based on the visible viewport/navigation, not guessed fixed footer offsets. The native palette is shared across Android screens.

## Date regressions

Native date-picker drafts now commit to stored values only on confirmation, cancellation leaves them unchanged, instants convert into local wall time, and end values carry their transport offset. Web month navigation no longer jumps back to the selected month.

## Delivery

Online runtime ZIP, signed APK ZIP and desktop web-UI update ZIP are prepared separately. The desktop ZIP is an asset update for an existing portable/Electron installation, not a standalone Windows executable. Preserve user profiles, settings and server volumes when updating. Native Windows launch/physical Android installation are not tested in this Linux environment.
