# Mobile online/PWA equipment layout

## Scope
- Online/PWA equipment task lists at viewport widths up to 700px use an Android-like 52px header, compact task rows, a scrollable list, and the shared circular add-task button.
- Original search, source, sorting, grouping, property filters, column settings, and completed-task controls move into the header menu. Existing control IDs, event handlers, and values are retained.
- Search focus and menu state survive list rerenders. Menu actions have readable labels.
- Phone navigation closes the previous equipment modal and its filters before showing tasks, calendar, equipment, matrix, or discussions.
- Add-task actions retain the selected machine context; existing completion Undo remains available.
- When resizing above 700px, the original desktop controls are restored. Native Windows is excluded by the existing ADIBDesktop guard; no native Android source or APK change is required.
- Service-worker cache version is bumped to adib-online-v277-phone-equipment.

## Verification
- `test/mobile-equipment-browser.cjs`: passed at 320, 390, 430, and 700px. Checks compact header, hidden default filters, search and filters through rerender, list/Kanban switching, Undo, creation context, five navigation destinations, responsive restoration, and absence of page errors. Includes a dark-theme preview.
- `test/discussions-sidebar-browser.cjs`: three scenarios passed.
- `test/simple-cards-browser.cjs`: three scenarios passed, including the native Windows guard.
- `npm test`: 24 passed, zero failed.

Browser verification used sandbox Chromium and fixture API responses. Live Railway deployment and physical-phone behavior have not been verified. Merge and deployment are separate from these tests.
