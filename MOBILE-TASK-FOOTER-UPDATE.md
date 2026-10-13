# Mobile working-task footer

## Fix
- Restore existing editor actions to the visible working-task footer instead of an unreachable hidden sheet. Existing IDs, handlers, autosave status, and error controls are preserved.
- Keep both completion/discussion and original editor action rows above the 58px navigation bar plus safe-area inset on phones up to 700px.
- Give the task content its own scroll area; panel height is bounded by the dynamic viewport. Expanded mode follows the same bounds.
- The header overflow menu opens task operations; properties remain available through the properties row.
- Keep the root modal's original close control mounted. The working header forwards to it so closing a task and returning to equipment does not remove the control needed by subsequent navigation.
- Native Windows follows its existing path. The change targets the existing working-task presentation; the separate new-task form is not redesigned.
- Service-worker cache version: `adib-online-v279-phone-task-footer`.

## Verification
- `test/mobile-task-footer-browser.cjs`: passed at 320x640, 390x850, 430x740, 700x500; existing equipment root/layer and personal task editors, light/dark, expanded mode, original close handlers, content scrolling, visible autosave status, unobscured 44px action targets above navigation.
- Working-screen browser regression passed (completion Undo, properties, calendar scale, desktop/phone).
- Mobile equipment regression passed at four widths.
- Simple cards regression passed three scenarios, including native Windows guard.
- Node tests: 24 passed, zero failures.

Sandbox Chromium and fixture APIs were used. Live Railway deployment and physical-phone behavior have not been verified. No Android APK was built.
