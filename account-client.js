/* API requests wait for the authenticated identity and per-user preferences. */
(function (root) {
  'use strict';

  const original = root.fetch.bind(root);
  const PREFS_KEY = 'adib-user-preferences-v1';
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
  let identity = null;
  let redirecting = false;
  const authProgress = root.ADIBLoading?.screen();
  const hasCachedOwner = (() => {
    try { return !!localStorage.getItem('adib-account-owner'); } catch (_) { return false; }
  })();
  if (!hasCachedOwner) document.documentElement.style.visibility = 'hidden';

  function allowedValueKey(key) {
    return VALUE_KEYS.has(key) || /^adib-calendar-hour-height:(month|week|three|day|year|agenda)$/.test(key);
  }

  function object(value) {
    return value && typeof value === 'object' && !Array.isArray(value);
  }

  function canonicalSettings(value) {
    const filters = object(value?.filters) ? value.filters : {};
    const values = object(value?.values) ? value.values : {};
    const cleanFilters = {};
    for (const [screen, filter] of Object.entries(filters)) {
      if (/^[a-z0-9:_-]{1,120}$/i.test(screen) && object(filter)) cleanFilters[screen] = filter;
    }
    const cleanValues = {};
    for (const [key, setting] of Object.entries(values)) {
      if (allowedValueKey(key) && typeof setting === 'string' && setting.length <= 4000) cleanValues[key] = setting;
    }
    return { version: 1, filters: cleanFilters, values: cleanValues };
  }

  function readLocalSettings() {
    let saved = null;
    try { saved = JSON.parse(localStorage.getItem(PREFS_KEY) || 'null'); } catch (_) {}
    const settings = canonicalSettings(saved);
    let updatedAt = Number(saved?.updatedAt) || 0;
    try {
      for (let index = 0; index < localStorage.length; index++) {
        const key = localStorage.key(index);
        if (!key) continue;
        if (key.startsWith(LEGACY_FILTER_PREFIX)) {
          const screen = key.slice(LEGACY_FILTER_PREFIX.length);
          if (settings.filters[screen]) continue;
          try {
            const filter = JSON.parse(localStorage.getItem(key) || 'null');
            if (/^[a-z0-9:_-]{1,120}$/i.test(screen) && object(filter)) settings.filters[screen] = filter;
          } catch (_) {}
        } else if (allowedValueKey(key) && !Object.prototype.hasOwnProperty.call(settings.values, key)) {
          const value = localStorage.getItem(key);
          if (value !== null && value.length <= 4000) settings.values[key] = value;
        }
      }
    } catch (_) {}
    return { settings, updatedAt };
  }

  function applyLocalSettings(settings, updatedAt) {
    const clean = canonicalSettings(settings);
    const record = { ...clean, updatedAt: Number(updatedAt) || 0 };
    try {
      localStorage.setItem(PREFS_KEY, JSON.stringify(record));
      for (const [screen, filter] of Object.entries(clean.filters)) {
        localStorage.setItem(LEGACY_FILTER_PREFIX + screen, JSON.stringify(filter));
      }
      for (const [key, value] of Object.entries(clean.values)) localStorage.setItem(key, value);
    } catch (_) {}
    return record;
  }

  function hasSettings(settings) {
    return Object.keys(settings?.filters || {}).length > 0 || Object.keys(settings?.values || {}).length > 0;
  }

  function sameSettings(left, right) {
    return JSON.stringify(canonicalSettings(left)) === JSON.stringify(canonicalSettings(right));
  }

  async function requestPreferences(method, body, signal) {
    return original('/api/user/preferences', {
      method,
      cache: 'no-store',
      ...(signal ? { signal } : {}),
      ...(body ? {
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      } : {}),
    });
  }

  async function hydratePreferences() {
    const local = readLocalSettings();
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 4500);
    try {
      const response = await requestPreferences('GET', null, controller.signal);
      if (!response.ok) return;
      const remote = await response.json();
      const remoteSettings = canonicalSettings(remote.settings);
      const remoteAt = Number(remote.updatedAt) || 0;
      const localHas = hasSettings(local.settings);
      const remoteHas = hasSettings(remoteSettings);

      if (remoteHas && (!localHas || remoteAt > local.updatedAt) && !sameSettings(local.settings, remoteSettings)) {
        applyLocalSettings(remoteSettings, remoteAt);
        return { reload: true };
      }
      if (remoteHas && sameSettings(local.settings, remoteSettings)) {
        applyLocalSettings(remoteSettings, Math.max(local.updatedAt, remoteAt));
        return;
      }
      if (localHas && (!remoteHas || local.updatedAt >= remoteAt)) {
        const record = applyLocalSettings(local.settings, local.updatedAt || Date.now());
        const saved = await requestPreferences('PUT', { settings: record }, controller.signal);
        if (saved.ok) {
          const result = await saved.json();
          applyLocalSettings(local.settings, Math.max(record.updatedAt, Number(result.updatedAt) || 0));
        }
      }
    } catch (error) {
      root.console?.warn?.('ADIB settings sync deferred:', error);
    } finally {
      clearTimeout(timeout);
    }
  }

  const go = () => {
    if (redirecting) return;
    redirecting = true;
    try { localStorage.clear(); } catch (_) {}
    root.location.replace('/account.html');
  };

  const authController = new AbortController();
  const authTimeout = setTimeout(() => authController.abort(), 10000);
  const ready = original('/api/auth/me', { cache: 'no-store', signal: authController.signal })
    .then(async response => {
      const data = await response.json();
      if (!response.ok) {
        go();
        throw new Error('Hesabınıza daxil olun');
      }
      if (!data.enabled) {
        document.documentElement.style.visibility = '';
        return null;
      }

      identity = data.user;
      root.ADIBAccount.user = identity;
      const owner = identity.id + ':' + identity.revision;
      let previousOwner = '';
      try { previousOwner = localStorage.getItem('adib-account-owner') || ''; } catch (_) {}
      if (previousOwner !== owner) {
        const previousUserId = previousOwner.split(':')[0];
        const migrated = previousUserId === identity.id ? readLocalSettings() : null;
        try {
          localStorage.clear();
          localStorage.setItem('adib-account-owner', owner);
          if (migrated && hasSettings(migrated.settings)) applyLocalSettings(migrated.settings, migrated.updatedAt || Date.now());
        } catch (_) {}
        // A first sign-in has no previous account state to flush, so continue
        // without an unnecessary reload. Reload only when switching accounts.
        if (previousOwner && previousUserId !== identity.id) {
          root.location.reload();
          return new Promise(() => {});
        }
      }

      const hydrated = await hydratePreferences();
      if (hydrated?.reload) {
        root.location.reload();
        return new Promise(() => {});
      }
      document.documentElement.style.visibility = '';
      return identity;
    })
    .catch(error => {
      if (!hasCachedOwner) throw error;
      root.ADIBAccount.cachedOffline = true;
      document.documentElement.style.visibility = '';
      root.console?.warn?.('ADIB is using the cached workspace while reconnecting:', error);
      return null;
    })
    .finally(() => clearTimeout(authTimeout));

  ready.then(() => authProgress?.done(), () => {
    if (!redirecting) authProgress?.fail();
  });

  root.ADIBAccount = {
    ready,
    user: null,
    cachedOffline: false,
    section: section => !identity || identity.role === 'admin' || identity.rules.sections.includes(section),
    action: action => !!identity && (identity.role === 'admin' || identity.rules.actions.includes(action)),
    open: () => { root.location.href = '/account.html'; },
  };

  root.fetch = async (input, options) => {
    const href = typeof input === 'string' ? input : input.url;
    let url;
    try { url = new URL(href, root.location.href); } catch (_) { return original(input, options); }
    if (url.origin === root.location.origin && url.pathname.startsWith('/api/') && !url.pathname.startsWith('/api/auth/')) {
      await ready;
      const response = await original(input, options);
      if (response.status === 401) go();
      return response;
    }
    return original(input, options);
  };

  function apply() {
    if (!identity) return;
    const allowed = root.ADIBAccount.section;
    for (const button of document.querySelectorAll('[data-home-nav]')) {
      const section = button.dataset.homeNav === 'tasks' ? 'personal' : button.dataset.homeNav;
      button.hidden = !allowed(section);
      button.style.display = allowed(section) ? '' : 'none';
    }
    for (const button of document.querySelectorAll('#adibPersistentSide button,.adib-home-tools button')) {
      const text = button.textContent.trim();
      const section = text === 'Eyzenhauer matrisi' ? 'matrix'
        : text === 'Kanban' || text === 'Tapşırıqlarımın təsviri' ? 'personal'
          : text === 'Vidjetlər' ? 'widgets' : text === 'Ayarlar' ? 'settings' : null;
      if (section) button.style.display = allowed(section) ? '' : 'none';
    }
    for (const button of document.querySelectorAll('#deleteTask,#personalEditorDelete,[data-task-delete]')) {
      button.style.display = root.ADIBAccount.action('delete') ? '' : 'none';
    }
    for (const button of document.querySelectorAll('.adib-home-check')) button.disabled = !root.ADIBAccount.action('status');
    for (const button of document.querySelectorAll('.adib-home-add')) button.style.display = root.ADIBAccount.action('create') ? '' : 'none';
    const profile = document.getElementById('currentUser');
    if (profile) {
      profile.disabled = true;
      profile.title = identity.name;
    }
    if (!document.getElementById('adibAccountButton') && document.body) {
      const button = document.createElement('button');
      button.id = 'adibAccountButton';
      button.textContent = identity.name + ' · Profil';
      button.style.cssText = 'position:fixed;bottom:12px;left:12px;z-index:2000;max-width:210px;padding:8px;border-radius:8px;border:1px solid #bccbea;background:var(--surface,#fff);color:inherit';
      button.onclick = root.ADIBAccount.open;
      document.body.append(button);
    }
    if (typeof currentUser === 'object' && currentUser.name !== identity.name) currentUser = { id: identity.id, name: identity.name };
  }

  let scheduled = false;
  const observer = new MutationObserver(() => {
    if (scheduled) return;
    scheduled = true;
    setTimeout(() => { scheduled = false; apply(); }, 80);
  });
  const init = () => {
    observer.observe(document.body, { childList: true, subtree: true });
    ready.then(apply).catch(() => {});
  };
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();

  async function revalidate() {
    if (!identity || root.ADIBIdle?.isIdle?.()) return;
    try {
      const response = await original('/api/auth/me', { cache: 'no-store' });
      if (!response.ok) { go(); return; }
      const data = await response.json();
      if (data.user.revision !== identity.revision) go();
      else document.documentElement.style.visibility = '';
    } catch (error) {
      root.console?.warn?.('ADIB session check deferred after a temporary connection error:', error);
    }
  }
  setInterval(revalidate, 30000);
  root.addEventListener('adib-network-idle', event => {
    if (!event.detail?.idle) revalidate();
  });
})(window);