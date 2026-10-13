# Equipment touch viewport

Online/PWA touch input now registers at the SVG capture phase, before equipment/card handlers can consume it. Two fingers zoom around their midpoint; one finger pans the viewport rather than moving equipment. Pinch release/cancellation clears pointer state and suppresses accidental task-opening taps. Two fingers also cancel the long-press menu timer. Mouse object editing remains on the existing path; new touch behavior is guarded for native Windows.

Equipment zoom buttons `minus` and `plus` are hidden in the focused UI. Centering controls and the task-creation FAB are not removed. No task data or sync endpoints changed. Service-worker cache: `adib-online-v278-equipment-pinch`.

## Verification
- `test/equipment-pinch-browser.cjs`: real Chromium touch injection at 320, 390, 430, 700px; zoom in/out, zoom over SVG equipment, cancellation/recovery, single-finger pan without object edits, no accidental task modal or long-press menu, hidden +/- controls, task FAB retained. Existing double-tap opening checked at 320/390/430px.
- Mobile equipment regression: four widths passed.
- Simple card regression: three scenarios passed, including native Windows guard.
- Node tests: 24 passed, zero failures.

Tests use fixture APIs and sandbox Chromium. A physical phone and live Railway deployment have not been verified. No new Android APK has been built for this online/PWA fix.
