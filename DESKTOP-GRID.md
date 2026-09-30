# Desktop container grid update

## Update Railway
Replace `ela-nov-paketleme-dynamic.html` and `sw.js` in the existing repository, commit and deploy. This package has not been published automatically. If earlier comment-author and recursive-plan fixes were not installed, deploy the full package; server.js retains those changes. Keep existing Railway environment variables.

## Changes
- My Tasks containers are displayed as five columns, up to two rows / ten containers per page on desktop screens wider than 900px.
- Additional containers have previous/next pages. Sparse pages use only occupied rows.
- Cards open a container's immediate child containers and direct tasks. Back moves one parent level at a time.
- The top list button opens tasks for the current container, including descendants; root lists all tasks.
- Fixed toolbar no longer covers the first row. Grid background, canvas panning/zoom/center button are disabled in desktop grid mode only.
- Supports existing light/dark themes and keeps saved hierarchy and canvas coordinates unchanged.
- Native Android APK and mobile web canvas renderer are not changed by this update.
- Corrected the first-click suppression check when the legacy window property was undefined.
- PWA cache version: adib-pwa-v30-desktop-container-grid.

## Validation
61 Node tests pass. Local Chromium checks: five columns / two rows, paging, nested navigation with visible header Back, current-container task list and return, 1024px fitting, desktop/mobile breakpoint, and no JavaScript page errors in these flows. Desktop light/dark, focused container and task list previews were rendered and visually inspected using mocked local data; no live Notion records were modified during QA. Live production deployment remains to be verified after deployment.
