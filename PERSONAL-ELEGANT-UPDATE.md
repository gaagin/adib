# Personal task forms and elegant shared design — 2.5.81

This update includes Android plus the phone/desktop web interface and a shared desktop UI asset patch.

- Same first six properties for personal and equipment tasks, for creation and editing.
- Personal Tasks retain their original database. Equipment/Plan associations use optional ADIB metadata rather than creating new Notion properties.
- Equipment search and date/time ranges are available in the personal form.
- Light/dark visual polish, readable controls and labels, restrained card styling, collapsed discussions and a visible action footer.
- Existing completion Undo, list views, reminders, subtasks and autosave are retained.

Deploy `server.js`, `task-management.js`, `autosave.js`, HTML, picker assets, `elegant-ui.css/js` and `sw.js` together. Keep environment variables and state volumes unchanged. No secrets or profiles belong in release archives.

The online runtime is prepared in a pull request; production deployment requires merge approval. APK versionCode 131 uses the prior signing certificate. The desktop UI archive updates an existing installation's web asset directory; it does not include a new Windows executable.

## Release verification

- 38 Node tests passed.
- 142 targeted Android regression tests passed across API 28/35 (13 active suites).
- Phone web UI checked at 320×640 and 390×850, desktop browser at 1280×900, light/dark. Equipment search, date month navigation, explicit save, visible footer and action menu passed; no page errors.
- Public runtime assets byte-checked against local HTTP server. Service worker uses a new v283 cache.
- APK signature matches the previous release; preserve the installed app when updating.
- These checks do not constitute a physical-device Android install or native Windows launch test. Production remains unchanged until PR approval/merge.


## Personal task form follow-up

- Removed the Equipment, Tasks database and Plan selectors from personal-task create/edit in Android and phone/desktop web. These selectors remain in equipment-task forms. Existing stored link metadata is left untouched because the personal form no longer submits edits to those fields.
- Moved the existing Qovluq picker immediately after Ad; create/edit continues to save containerId as before.

## My Tasks form follow-up (2.5.82)
The My Tasks form drops Equipment, database and Plan pickers (the equipment task form retains them). Qovluq is moved directly under Ad in Android and web forms, preserving the existing container field and selected value. Old optional equipment/plan context is omitted from updates rather than cleared.
