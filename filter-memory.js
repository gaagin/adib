(function (root) {
  'use strict';

  const CACHE_KEY = 'adib-user-preferences-v1';
  const LEGACY_FILTER_PREFIX = 'adib-last-filters-v1:';
  const VALUE_KEYS = new Set([
    'ela-theme',
    'adib-chat-palette-v1',
    'adib-side-collapsed',
    'adib-completed-collapsed',
    'adib-home-hide-details',
    'adib-task-sort-key',
    'adib-task-sort-desc',
    'ela-kanban-group-prefs-v1',
    'ela-kanban-column-prefs-v1',
    'ela-personal-kanban-group-by-v1',
    'ela-personal-kanban-view-v1',
    'ela-equipment-kanban-view-v1',
  ]);

  let saveTimer = 0;
  let saving = false;
  let retryTimer = 0;

  function allowedValueKey(key) {
    return VALUE_KEYS.has(key) || /^adib-calendar-hour-height:(month|week|three|day|year|agenda)$/.test(key);
  }

  function object(value) {
    return value && typeof value === 'object' && !Array.isArray(value);
  }

  function state() {
    try {
      const value = JSON.parse(localStorage.getItem(CACHE_KEY) || 'null');
      if (object(value)) {
        return {
          version: 1,
          filters: object(value.filters) ? value.filters : {},
          values: object(value.values) ? value.values : {},
          updatedAt: Number(value.updatedAt) || 0,
        };
      }
    } catch (_) { /* Recover from a partial browser write. */ }
    return { version: 1, filters: {}, values: {}, updatedAt: 0 };
  }

  function saveLocal(value) {
    try {
      localStorage.setItem(CACHE_KEY, JSON.stringify(value));
      return true;
    } catch (_) {
      return false;
    }
  }

  function rememberValue(key, value) {
    if (!allowedValueKey(key) || typeof value !== 'string' || value.length > 4000) return;
    const current = state();
    if (current.values[key] === value) return;
    current.values[key] = value;
    current.updatedAt = Date.now();
    saveLocal(current);
    scheduleSync();
  }

  function scheduleSync() {
    clearTimeout(saveTimer);
    saveTimer = setTimeout(() => { void sync(); }, 900);
  }

  async function sync() {
    if (saving) return;
    const account = root.ADIBAccount;
    if (!account?.ready) return;
    saving = true;
    try {
      await account.ready;
      if (!account.user) return;
      const response = await root.fetch('/api/user/preferences', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ settings: state() }),
        keepalive: true,
      });
      if (!response.ok) throw new Error('Preferences save failed: ' + response.status);
      const result = await response.json();
      const current = state();
      current.updatedAt = Math.max(current.updatedAt, Number(result.updatedAt) || 0);
      saveLocal(current);
      if (retryTimer) clearTimeout(retryTimer);
      retryTimer = 0;
    } catch (error) {
      root.console?.warn?.('ADIB personal settings will retry when the connection is available:', error);
      if (!retryTimer) retryTimer = setTimeout(() => { retryTimer = 0; void sync(); }, 10000);
    } finally {
      saving = false;
    }
  }

  function read(screen, defaults) {
    const fallback = object(defaults) ? defaults : {};
    const current = state();
    let saved = current.filters[screen];
    if (!object(saved)) {
      try {
        saved = JSON.parse(localStorage.getItem(LEGACY_FILTER_PREFIX + screen) || '{}');
      } catch (_) {
        saved = {};
      }
    }
    if (!object(saved)) return { ...fallback };
    const result = { ...fallback };
    for (const key of Object.keys(fallback)) {
      const value = saved[key];
      if (typeof value === typeof fallback[key] &&
          (typeof value !== 'string' || value.length <= 4000)) {
        result[key] = value;
      }
    }
    return result;
  }

  function write(screen, values) {
    if (!/^[a-z0-9:_-]{1,120}$/i.test(String(screen)) || !object(values)) return false;
    const current = state();
    current.filters[screen] = values;
    current.updatedAt = Date.now();
    const saved = saveLocal(current);
    try { localStorage.setItem(LEGACY_FILTER_PREFIX + screen, JSON.stringify(values)); } catch (_) {}
    scheduleSync();
    return saved;
  }

  function getValue(key, fallback = null) {
    if (allowedValueKey(key)) {
      const current = state();
      if (Object.prototype.hasOwnProperty.call(current.values, key)) return current.values[key];
    }
    try {
      const value = localStorage.getItem(key);
      return value === null ? fallback : value;
    } catch (_) {
      return fallback;
    }
  }

  function setValue(key, value) {
    const stringValue = String(value);
    try { localStorage.setItem(key, stringValue); } catch (_) {}
    if (!allowedValueKey(key) || stringValue.length > 4000) return false;
    rememberValue(key, stringValue);
    return true;
  }

  root.ADIBFilters = { read, write, getValue, setValue, sync };

  // Existing UI modules write their own view/theme preferences directly.
  // Mirror only the explicit allowlist; task data and caches remain local.
  try {
    const storage = root.Storage.prototype;
    const originalSetItem = storage.setItem;
    storage.setItem = function (key, value) {
      const result = originalSetItem.call(this, key, value);
      if (this === root.localStorage) rememberValue(String(key), String(value));
      return result;
    };
  } catch (_) { /* Local-only behavior remains available if Storage is locked down. */ }
})(window);