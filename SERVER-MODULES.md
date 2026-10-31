# Server modules

`npm start` still starts `server.js`. No runtime dependencies or deployment configuration changed.

The entry point owns configuration, persistent stores, mutable caches, realtime services and HTTP routing. Domain factories define functions without startup side effects. `serverContext` exposes live getters (and setters for mutable bindings), so invalidating a cache in one module is immediately visible to the others. Lazy bindings also preserve functions used during bootstrap before later stores are initialized.

| Module | Responsibility |
| --- | --- |
| server-notion.js | Notion requests, comments, attachments and field options |
| server-models.js | Property readers, task mappings and application links |
| server-snapshots.js | Equipment queries, incremental sync and snapshots |
| server-equipment.js | Layout, equipment/task mutations, HTTP helpers |
| server-personal.js | Personal workspace, containers and snapshot caches |
| server-content.js | Notion blocks and rich text conversion |
| server-task-writes.js | Personal task creation, validation and updates |
| server-pomodoro.js | Shared timer sessions and persistence |
| server-access.js | AI requests, realtime projection, authorization and team snapshots |

All modules remain private; the existing public asset allowlist is unchanged. Keep individual source files and complete GitHub upload JSON payloads below the integration's request limit. Upload new dependencies before an entry point that requires them.

Focused checks: `node --test test/server-modules.test.cjs test/team-section-permission.test.cjs test/team-dashboard.test.cjs test/equipment-task-access.test.cjs`.
