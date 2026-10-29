// Persistent sidebar navigation: included in the team dashboard deployment.
(() => {
  'use strict';

  const esc = value => String(value ?? '');
  const el = (tag, className, text) => {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (text !== undefined) node.textContent = esc(text);
    return node;
  };
  const today = () => new Intl.DateTimeFormat('en-CA', {
    timeZone: 'Asia/Baku', year: 'numeric', month: '2-digit', day: '2-digit'
  }).format(new Date());
  const dayKey = value => {
    if (!value) return '';
    const raw = String(value);
    const dateOnly = raw.match(/^(\d{4}-\d{2}-\d{2})/);
    if (dateOnly) return dateOnly[1];
    const date = new Date(raw);
    if (!Number.isFinite(date.getTime())) return '';
    return new Intl.DateTimeFormat('en-CA', {
      timeZone: 'Asia/Baku', year: 'numeric', month: '2-digit', day: '2-digit'
    }).format(date);
  };
  const prettyDate = value => {
    if (!value) return 'Tarix təyin edilməyib';
    const date = new Date(`${String(value).slice(0, 10)}T12:00:00`);
    return Number.isFinite(date.getTime())
      ? new Intl.DateTimeFormat('az-Latn-AZ', {day: 'numeric', month: 'short'}).format(date)
      : '';
  };
  const initials = name => String(name || 'ADIB').trim().split(/\s+/).slice(0, 2).map(x => x[0]).join('').toLocaleUpperCase('az');
  const openTasks = person => (person.tasks || []).filter(task => !task.completed);

  let root, user, payload, selectedDate = today(), currentView = 'employees', currentFilter = 'all', searchText = '', refreshTimer, navigationObserver, lastTrigger;

  async function request(path, options = {}) {
    const response = await fetch(path, {cache: 'no-store', credentials: 'same-origin', ...options});
    const result = await response.json().catch(() => ({}));
    if (!response.ok) throw new Error(result.error || `HTTP ${response.status}`);
    return result;
  }

  function makeDashboard() {
    root = el('section', 'adib-team-view');
    root.id = 'adibTeamDashboard';
    root.setAttribute('role', 'dialog');
    root.setAttribute('aria-modal', 'true');
    root.setAttribute('aria-label', 'Komanda planı');
    root.hidden = true;
    root.innerHTML = `
      <header class="team-header">
        <button type="button" class="team-back" data-team-close aria-label="Geri">←</button>
        <div class="team-brand"><span class="team-brand-mark">A</span><div><h1>Komanda</h1><small>ADIB · İş sahəsi</small></div></div>
        <div class="team-header-actions">
          <label class="team-search"><span aria-hidden="true">⌕</span><input type="search" data-team-search placeholder="Əməkdaş və ya tapşırıq axtarın" aria-label="Əməkdaş və ya tapşırıq axtarın"></label>
          <button type="button" class="team-icon-button" data-team-refresh aria-label="Yenilə" title="Yenilə">↻</button>
          <button type="button" class="team-close" data-team-close aria-label="Bağla">×</button>
        </div>
      </header>
      <div class="team-workspace">
        <aside class="team-sidebar">
          <div class="team-sidebar-title"><strong>Əməkdaşlar</strong><span data-team-count></span></div>
          <div class="team-sidebar-filters" role="group" aria-label="Əməkdaş filtri">
            <button type="button" data-team-filter="all" class="active">Hamısı</button>
            <button type="button" data-team-filter="working">İşdə</button>
            <button type="button" data-team-filter="overdue">Gecikən</button>
          </div>
          <div class="team-staff-list" data-team-staff></div>
          <div class="team-sidebar-foot">Məlumatlar ADIB tapşırıqları və taymerlərindən yenilənir.</div>
        </aside>
        <main class="team-main">
          <section class="team-page-heading">
            <div><p class="team-eyebrow">İŞ SAHƏSİ</p><h2>Komanda planı</h2><p>Əməkdaşların cari işi və tapşırıqlarının icra vəziyyəti</p></div>
            <div class="team-heading-tools">
              <label class="team-date-control"><span>Gün</span><input type="date" data-team-date aria-label="Günü seçin"></label>
              <button type="button" class="team-add-task" data-team-add hidden>＋ Tapşırıq</button>
            </div>
          </section>
          <section class="team-stats" data-team-stats aria-label="Komanda statistikası"></section>
          <div class="team-mobile-filters" role="group" aria-label="Əməkdaş filtri">
            <button type="button" data-team-filter="all" class="active">Hamısı</button>
            <button type="button" data-team-filter="working">İşdə</button>
            <button type="button" data-team-filter="overdue">Gecikən</button>
          </div>
          <div class="team-main-heading">
            <h3 data-team-section-title>Əməkdaşlar</h3>
            <div class="team-view-switch" role="group" aria-label="Komanda görünüşü">
              <button type="button" data-team-view="employees" class="active">İşçilər</button>
              <button type="button" data-team-view="tasks">Tapşırıqlar</button>
            </div>
          </div>
          <p class="team-message" data-team-message role="status" aria-live="polite" hidden></p>
          <section class="team-cards" data-team-cards></section>
        </main>
      </div>
    `;
    document.body.append(root);
    root.querySelectorAll('[data-team-close]').forEach(button => button.addEventListener('click', close));
    root.addEventListener('click', event => { if (event.target === root) close(); });
    root.querySelector('[data-team-refresh]').addEventListener('click', () => load(true));
    root.querySelector('[data-team-search]').addEventListener('input', event => {
      searchText = event.target.value.trim().toLocaleLowerCase();
      render();
    });
    root.querySelector('[data-team-date]').addEventListener('change', event => {
      selectedDate = event.target.value || today();
      render();
    });
    root.querySelectorAll('[data-team-view]').forEach(button => button.addEventListener('click', () => {
      currentView = button.dataset.teamView;
      render();
    }));
    root.querySelectorAll('[data-team-filter]').forEach(button => button.addEventListener('click', () => {
      currentFilter = button.dataset.teamFilter;
      render();
    }));
    root.querySelector('[data-team-add]').addEventListener('click', () => addTask());
    root.addEventListener('keydown', event => { if (event.key === 'Escape') close(); });
  }

  function mountSidebarNavigation() {
    if (!user || !['admin', 'manager'].includes(user.role)) return;
    const side = document.getElementById('adibPersistentSide');
    if (!side || document.getElementById('teamSidebarButton')) return;
    const button = el('button', 'adib-home-nav');
    button.id = 'teamSidebarButton';
    button.type = 'button';
    button.dataset.homeNav = 'team';
    button.setAttribute('aria-label', 'Komanda planını açın');
    button.innerHTML = '<span class="adib-nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2M9 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg></span><span>Komanda</span>';
    button.addEventListener('click', event => {
      if (window.ADIBHome?.canLeave && !window.ADIBHome.canLeave()) return;
      window.ADIBHome?.closeSidebarOnMobile?.();
      window.ADIBHomeBridge?.closeViews?.();
      open(event);
    });
    const chat = side.querySelector('[data-home-nav="chat"]');
    if (chat) side.insertBefore(button, chat);
    else side.append(button);
  }

  function addNavigation(userInfo) {
    mountSidebarNavigation();
    if (!navigationObserver) {
      // The persistent home sidebar is created lazily, after team initialization.
      navigationObserver = new MutationObserver(mountSidebarNavigation);
      navigationObserver.observe(document.body, {childList: true});
    }
    const brand = document.querySelector('#adibWorkspaceHeader .brandline');
    if (brand && !document.getElementById('teamViewButton')) {
      const button = el('button', 'team-open-desktop', 'Komanda');
      button.id = 'teamViewButton';
      button.type = 'button';
      button.addEventListener('click', open);
      brand.append(button);
    }
    const nav = document.getElementById('mobileNav');
    if (nav && !document.getElementById('teamMobileNavButton')) {
      const button = el('button', 'team-open-mobile', 'Komanda');
      button.id = 'teamMobileNavButton';
      button.type = 'button';
      button.innerHTML = '<span aria-hidden="true">♧</span>Komanda';
      button.addEventListener('click', open);
      nav.append(button);
    }
    const mobileActions = document.querySelector('#adibWorkspaceHeader .miro-mobile-actions');
    if (mobileActions && !document.getElementById('teamMobileHeaderButton')) {
      const button = el('button', 'team-open-mobile-top', '♧');
      button.id = 'teamMobileHeaderButton';
      button.type = 'button';
      button.title = 'Komanda';
      button.setAttribute('aria-label', 'Komanda planını açın');
      button.addEventListener('click', open);
      mobileActions.append(button);
    }
    const add = root.querySelector('[data-team-add]');
    add.hidden = !(userInfo.role === 'admin' || userInfo.rules?.actions?.includes('create'));
  }

  function setMessage(text, isError = false) {
    const box = root.querySelector('[data-team-message]');
    box.hidden = !text;
    box.textContent = text || '';
    box.classList.toggle('error', isError);
  }

  let refreshPromise = null, refreshQueued = false, refreshVersion = 0, refreshSoon;

  function refreshFromChanges() {
    refreshVersion++;
    clearTimeout(refreshSoon);
    if (!root || root.hidden) return;
    refreshSoon = setTimeout(() => load(true), 100);
  }

  async function load(quiet = false) {
    if (refreshPromise) {
      refreshQueued = true;
      return refreshPromise;
    }
    clearTimeout(refreshSoon);
    const version = refreshVersion;
    refreshPromise = (async () => {
    if (!quiet) setMessage('Komanda məlumatları yüklənir…');
    const refreshButton = root.querySelector('[data-team-refresh]');
    refreshButton.disabled = true;
    try {
      const result = await request('/api/team-snapshot');
      if (version !== refreshVersion) {
        refreshQueued = true;
        return;
      }
      payload = result;
      if (!selectedDate || selectedDate === today()) selectedDate = payload.selectedDate || today();
      setMessage('');
      render();
    } catch (error) {
      if (version !== refreshVersion) { refreshQueued = true; return; }
      setMessage(`Məlumatları yükləmək alınmadı: ${error.message}`, true);
    } finally {
      refreshButton.disabled = false;
    }
    })();
    try {
      return await refreshPromise;
    } finally {
      refreshPromise = null;
      if (refreshQueued) {
        refreshQueued = false;
        if (root && !root.hidden) load(true);
      }
    }
  }

  function syncSharedNavigation() {
    if (!root || root.hidden) return;
    const nav = document.querySelector('.adib-design-nav');
    const height = nav ? nav.getBoundingClientRect().height : 0;
    root.style.bottom = `${height}px`;
    const besideSidebar = globalThis.window?.innerWidth > 700 && document.body.classList.contains('adib-side-ready');
    root.setAttribute('aria-modal', height > 0 || besideSidebar ? 'false' : 'true');
  }

  function show() {
    if (!root) return;
    root.hidden = false;
    document.documentElement.classList.add('adib-team-open');
    document.body.classList.add('adib-team-open');
    syncSharedNavigation();
    document.getElementById('teamSidebarButton')?.setAttribute('aria-current', 'page');
    root.querySelector('[data-team-close]').focus({preventScroll: true});
    refreshVersion++;
    load(Boolean(payload));
    clearInterval(refreshTimer);
    refreshTimer = setInterval(() => { if (!root.hidden) load(true); }, 60000);
  }

  function close() {
    if (!root || root.hidden) return;
    cancelTeamDrag();
    root.hidden = true;
    document.documentElement.classList.remove('adib-team-open');
    document.body.classList.remove('adib-team-open');
    document.getElementById('teamSidebarButton')?.removeAttribute('aria-current');
    clearInterval(refreshTimer);
    clearTimeout(refreshSoon);
    const trigger = lastTrigger?.isConnected ? lastTrigger : document.getElementById('teamSidebarButton') || document.getElementById('teamViewButton');
    trigger?.focus({preventScroll: true});
  }

  function open(event) {
    cancelTaskReturn();
    lastTrigger = event?.currentTarget || document.activeElement;
    show();
  }

  function matchesSearch(person) {
    if (!searchText) return true;
    const content = [person.name, person.department, ...(person.tasks || []).map(task => task.title)].join(' ').toLocaleLowerCase();
    return content.includes(searchText);
  }

  function filteredPeople() {
    const people = (payload?.employees || []).filter(person => {
      if (!matchesSearch(person)) return false;
      if (currentFilter === 'working' && !person.isWorking) return false;
      if (currentFilter === 'overdue' && !person.overdueCount) return false;
      return true;
    });
    return people.sort((a, b) => a.name.localeCompare(b.name, 'az'));
  }

  function computeTotals(people) {
    const tasks = [...new Map(people.flatMap(person => person.tasks || []).map(task => [task.id, task])).values()];
    return {
      employees: people.length,
      working: people.filter(person => person.isWorking).length,
      completed: tasks.filter(task => task.completed && dayKey(task.completedAt) === selectedDate).length,
      overdue: people.reduce((sum, person) => sum + (person.tasks || []).filter(task => !task.completed && dayKey(task.dateEnd || task.date) && dayKey(task.dateEnd || task.date) < selectedDate).length, 0)
    };
  }

  function rememberTeamScroll() {
    const positions = [root, ...root.querySelectorAll('.team-main,.team-workspace,.team-staff-list')]
      .map(node => ({node, top: node.scrollTop, left: node.scrollLeft}));
    return () => positions.forEach(({node, top, left}) => {
      if (node.isConnected) { node.scrollTop = top; node.scrollLeft = left; }
    });
  }

  function render() {
    if (!root || !payload || teamDrag || transferPending) return;
    const restoreScroll = rememberTeamScroll();
    const people = filteredPeople();
    const totals = computeTotals(people);
    root.querySelector('[data-team-date]').value = selectedDate;
    root.querySelector('[data-team-count]').textContent = String(people.length);
    root.querySelector('[data-team-section-title]').textContent = currentView === 'employees' ? 'Əməkdaşlar' : 'Tapşırıqlar';
    root.querySelectorAll('[data-team-view]').forEach(button => button.classList.toggle('active', button.dataset.teamView === currentView));
    root.querySelectorAll('[data-team-filter]').forEach(button => button.classList.toggle('active', button.dataset.teamFilter === currentFilter));
    renderStats(totals);
    renderStaff(people);
    renderCards(people);
    restoreScroll();
  }

  function renderStats(stats) {
    const host = root.querySelector('[data-team-stats]');
    host.replaceChildren();
    const items = [
      ['●', 'İŞDƏ OLANLAR', stats.working, `${stats.employees} əməkdaş`,'green'],
      ['✓', 'TAMAMLANAN', stats.completed, 'tapşırıq bu gün','blue'],
      ['◷', 'DİQQƏT TƏLƏB EDİR', stats.overdue, 'gecikən tapşırıq','orange']
    ];
    for (const [icon, title, count, detail, tone] of items) {
      const card = el('article', `team-stat ${tone}`);
      card.append(el('span', 'team-stat-icon', icon));
      const text = el('div', 'team-stat-copy');
      text.append(el('small', '', title));
      const row = el('div', 'team-stat-value');
      row.append(el('strong', '', count), el('span', '', detail));
      text.append(row);
      card.append(text);
      host.append(card);
    }
  }

  function renderStaff(people) {
    const host = root.querySelector('[data-team-staff]');
    host.replaceChildren();
    for (const person of people) {
      const button = el('button', 'team-staff-item');
      button.type = 'button';
      const avatar = el('span', 'team-avatar small', initials(person.name));
      const details = el('span', 'team-staff-copy');
      details.append(el('strong', '', person.name), el('small', '', `${person.isWorking ? 'İşdə' : 'Aktiv'} · ${person.openCount} tapşırıq`));
      button.append(avatar, details, el('span', `team-presence ${person.isWorking ? 'working' : ''}`));
      button.addEventListener('click', () => root.querySelector(`[data-employee="${CSS.escape(person.key)}"]`)?.scrollIntoView({behavior: 'smooth', block: 'center'}));
      host.append(button);
    }
    if (!people.length) host.append(el('p', 'team-empty', 'Bu filtrə uyğun əməkdaş yoxdur.'));
  }

  function taskCard(task, label, person) {
    if (!task) return null;
    const button = el('button', `team-task-card ${task.kind === 'equipment' ? 'equipment' : 'personal'}`);
    button.type = 'button';
    button.addEventListener('click', event => {
      if (Date.now() < suppressTaskClick || event.target.closest('.team-drag-handle')) { event.preventDefault(); return; }
      openTask(task);
    });
    if (canMoveTask(task) && person) {
      button.classList.add('team-task-movable');
      const handle = el('span', 'team-drag-handle', '⠿');
      handle.title = 'Tutub başqa əməkdaşa daşıyın';
      handle.setAttribute('aria-label', handle.title);
      button.append(handle);
      button.addEventListener('pointerdown', event => beginTeamDrag(event, task, person, button));
      button.addEventListener('dragstart', event => event.preventDefault());
      handle.addEventListener('contextmenu', event => event.preventDefault());
    }
    if (label) button.append(el('small', 'team-task-label', label));
    button.append(el('strong', '', task.title));
    const meta = [task.machineName, task.source, task.date ? prettyDate(task.date) : ''].filter(Boolean).join(' · ');
    button.append(el('span', '', meta || task.status || 'Tapşırıq'));
    return button;
  }

  function renderCards(people) {
    const host = root.querySelector('[data-team-cards]');
    host.replaceChildren();
    if (!people.length) {
      host.append(el('div', 'team-empty-card', 'Göstəriləcək əməkdaş və ya tapşırıq yoxdur.'));
      return;
    }
    if (currentView === 'tasks') {
      for (const person of people) {
        const section = el('section', 'team-task-group');
        section.dataset.employee = person.key;
        section.append(el('h4', '', person.name));
        const rows = (person.tasks || []).filter(task => !task.completed || dayKey(task.completedAt) === selectedDate);
        if (!rows.length) section.append(el('p', 'team-empty', 'Bu gün üçün tapşırıq yoxdur.'));
        for (const task of rows) section.append(taskCard(task, task.completed ? 'TAMAMLANIB' : task.status || 'PLANLI', person));
        host.append(section);
      }
      return;
    }
    for (const person of people) {
      const card = el('article', 'team-employee-card');
      card.dataset.employee = person.key;
      const head = el('div', 'team-employee-head');
      const avatar = el('span', 'team-avatar', initials(person.name));
      const info = el('div', 'team-employee-info');
      info.append(el('strong', '', person.name), el('small', '', [person.department, person.isWorking ? 'Aktiv' : 'İşə hazır'].filter(Boolean).join(' · ')));
      const count = el('div', 'team-employee-count');
      count.append(el('span', `team-presence ${person.isWorking ? 'working' : ''}`), el('small', '', `${person.taskCount} tapşırıq`));
      head.append(avatar, info, count);
      card.append(head);

      const current = person.currentTask;
      const active = el('section', 'team-card-section');
      active.append(el('div', 'team-section-label', current ? (person.activeSessionStatus === 'pending' ? 'VAXTI TƏSDİQLƏYİN' : 'DAVAM EDİR') : 'CARİ İŞ'));
      active.append(current ? taskCard(current, current.kind === 'equipment' ? 'AVADANLIQ' : 'TAPŞIRIQ', person) : el('div', 'team-no-task', 'Hazırda aktiv tapşırıq yoxdur'));
      card.append(active);

      const upcoming = person.nextTask;
      if (upcoming) {
        const next = el('section', 'team-card-section next');
        next.append(el('div', 'team-section-label', 'NÖVBƏTİ TAPŞIRIQ'));
        const row = taskCard(upcoming, upcoming.date ? prettyDate(upcoming.date) : 'PLANLI', person);
        if (row) next.append(row);
        card.append(next);
      }

      const add = el('button', 'team-add-inline', '＋  Tapşırıq əlavə et');
      add.type = 'button';
      add.hidden = !canCreateTeamTask();
      add.addEventListener('click', () => addTask(person));
      card.append(add);

      const progress = el('div', 'team-progress');
      const completeCount = (person.tasks || []).filter(task => task.completed && dayKey(task.completedAt) === selectedDate).length;
      const total = Math.max(1, person.taskCount);
      const bar = el('span', 'team-progress-bar');
      bar.append(el('i'));
      bar.querySelector('i').style.width = `${Math.min(100, Math.round(completeCount / total * 100))}%`;
      progress.append(bar, el('small', '', `${completeCount} / ${person.taskCount} tamamlandı`));
      card.append(progress);
      host.append(card);
    }
  }

  let teamDrag = null, transferPending = false, suppressTaskClick = 0;

  function canMoveTask(task) {
    return !task.completed && !task.activeSession && !transferPending
      && (task.kind === 'personal' || ['todo', 'gorulen'].includes(task.sourceKey))
      && (user?.role === 'admin' || user?.rules?.actions?.includes('edit'));
  }

  function cancelTeamDrag() {
    const drag = teamDrag;
    if (!drag) return;
    teamDrag = null;
    clearTimeout(drag.hold);
    cancelAnimationFrame(drag.frame);
    document.removeEventListener('pointermove', drag.move, true);
    document.removeEventListener('pointerup', drag.up, true);
    document.removeEventListener('pointercancel', drag.cancel, true);
    document.removeEventListener('keydown', drag.key, true);
    window.removeEventListener('blur', drag.cancel);
    drag.button.classList.remove('team-drag-source');
    drag.ghost?.remove();
    root.classList.remove('team-dragging');
    root.querySelectorAll('.team-drop-target').forEach(node => node.classList.remove('team-drop-target'));
    if (drag.active) suppressTaskClick = Date.now() + 600;
  }

  function beginTeamDrag(event, task, person, button) {
    if (event.button !== 0 || !event.isPrimary || !canMoveTask(task) || teamDrag) return;
    if (event.pointerType !== 'mouse' && !event.target.closest('.team-drag-handle')) return;
    const drag = teamDrag = {task, person, button, id: event.pointerId,
      x: event.clientX, y: event.clientY, startX: event.clientX, startY: event.clientY, active: false};
    const hit = () => {
      root.querySelectorAll('.team-drop-target').forEach(node => node.classList.remove('team-drop-target'));
      const node = document.elementFromPoint(drag.x, drag.y)?.closest('[data-employee]');
      drag.target = node && root.contains(node) && node.dataset.employee !== person.key
        ? payload.employees.find(item => item.key === node.dataset.employee) : null;
      if (drag.target) node.classList.add('team-drop-target');
      if (drag.ghost) {
        drag.ghost.style.left = `${Math.min(window.innerWidth - 150, Math.max(8, drag.x + 12))}px`;
        drag.ghost.style.top = `${Math.max(8, drag.y - 38)}px`;
        drag.ghost.textContent = drag.target ? `${task.title} → ${drag.target.name}` : task.title;
      }
    };
    const tick = () => {
      if (teamDrag !== drag || !drag.active) return;
      const scroller = [...root.querySelectorAll('.team-workspace,.team-main')]
        .find(node => node.scrollHeight > node.clientHeight + 2 && /auto|scroll/.test(getComputedStyle(node).overflowY));
      if (scroller) {
        const rect = scroller.getBoundingClientRect(), edge = 70;
        const amount = drag.y < rect.top + edge ? -Math.min(18, (rect.top + edge - drag.y) / 4)
          : drag.y > rect.bottom - edge ? Math.min(18, (drag.y - rect.bottom + edge) / 4) : 0;
        if (amount) scroller.scrollTop += amount;
      }
      hit();
      drag.frame = requestAnimationFrame(tick);
    };
    const activate = () => {
      if (teamDrag !== drag || drag.active) return;
      drag.active = true;
      button.classList.add('team-drag-source');
      root.classList.add('team-dragging');
      drag.ghost = el('div', 'team-drag-ghost', task.title);
      drag.ghost.setAttribute('aria-hidden', 'true');
      root.append(drag.ghost);
      tick();
    };
    drag.move = e => {
      if (e.pointerId !== drag.id) return;
      drag.x = e.clientX; drag.y = e.clientY;
      if (event.pointerType === 'mouse' && Math.hypot(drag.x - drag.startX, drag.y - drag.startY) > 6) activate();
      if (drag.active) { e.preventDefault(); hit(); }
    };
    drag.up = e => {
      if (e.pointerId !== drag.id) return;
      drag.x = e.clientX; drag.y = e.clientY;
      if (drag.active) { hit(); e.preventDefault(); e.stopPropagation(); }
      const target = drag.active && drag.target;
      cancelTeamDrag();
      if (target) void transferTeamTask(task, person, target);
      else render();
    };
    drag.cancel = () => { cancelTeamDrag(); render(); };
    drag.key = e => { if (e.key === 'Escape') { e.preventDefault(); e.stopImmediatePropagation(); drag.cancel(); } };
    document.addEventListener('pointermove', drag.move, {capture: true, passive: false});
    document.addEventListener('pointerup', drag.up, true);
    document.addEventListener('pointercancel', drag.cancel, true);
    document.addEventListener('keydown', drag.key, true);
    window.addEventListener('blur', drag.cancel);
    if (event.pointerType !== 'mouse') { event.preventDefault(); drag.hold = setTimeout(activate, 180); }
  }

  async function transferTeamTask(task, from, to) {
    if (!canMoveTask(task) || from.key === to.key || !to.assignee) return;
    const key = task.kind === 'personal' ? 'assignees' : 'tapsirildi';
    const previous = [...(task[key] || [])];
    const aliases = new Set([...(from.aliases || []), from.assignee, from.name]);
    const next = [...new Set([...previous.filter(name => !aliases.has(name)), to.assignee])];
    const body = {id: task.id, [key]: next, autosaveBase: {[key]: previous}};
    if (task.kind === 'equipment') {
      body.sourceKey = task.sourceKey;
      if (task.assigneeId && (aliases.has(task.assigneeId) || aliases.has(task.assigneeName))) {
        body.assigneeId = '';
        body.autosaveBase.assigneeId = task.assigneeId;
      }
    }
    transferPending = true;
    refreshVersion++;
    root.classList.add('team-transfer-pending');
    setMessage('Tapşırıq köçürülür…');
    let failure = '';
    try {
      await request(task.kind === 'personal' ? '/api/personal-task' : '/api/task', {
        method: 'PATCH', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(body)
      });
      const moved = {...task, [key]: next};
      for (const person of payload.employees) {
        const had = (person.tasks || []).some(row => row.id === task.id);
        const assigned = person.key === to.key || (had && person.key !== from.key);
        person.tasks = (person.tasks || []).filter(row => row.id !== task.id);
        if (assigned) person.tasks.push(moved);
        person.taskCount = person.tasks.length;
        person.openCount = openTasks(person).length;
        if (person.currentTask?.id === task.id) person.currentTask = null;
        person.nextTask = openTasks(person).filter(row => row.id !== person.currentTask?.id)
          .sort((a,b) => (a.date || '9999').localeCompare(b.date || '9999'))[0] || null;
      }
      setMessage(`Tapşırıq ${to.name} əməkdaşına köçürüldü.`);
      window.dispatchEvent(new CustomEvent('adib-autosaved', {detail: {id: task.id}}));
    } catch (error) {
      failure = `Tapşırığı köçürmək alınmadı: ${error.message}`;
      setMessage(failure, true);
    } finally {
      transferPending = false;
      root.classList.remove('team-transfer-pending');
      refreshVersion++;
      render();
      await load(true);
      if (failure) setMessage(failure, true);
    }
  }

  function canCreateTeamTask() {
    return user?.role === 'admin' || user?.rules?.actions?.includes('create');
  }

  function addTask(person) {
    if (!canCreateTeamTask()) return;
    const existing = root.querySelector('.team-source-picker');
    if (existing) { existing.querySelector('button')?.focus(); return; }
    const trigger = document.activeElement;
    const dialog = el('dialog', 'team-source-picker');
    dialog.setAttribute('aria-labelledby', 'team-source-title');
    const heading = el('h3', '', 'Tapşırıq mənbəyini seçin');
    heading.id = 'team-source-title';
    dialog.append(heading);
    if (person?.name) dialog.append(el('p', 'team-source-person', person.name));
    const dismiss = () => {
      if (dialog.open) dialog.close();
      dialog.remove();
      if (trigger?.isConnected) trigger.focus({preventScroll: true});
    };
    for (const [key, label, detail] of [
      ['todo', 'ToDo', 'Planlaşdırılan iş və tapşırıqlar'],
      ['gorulen', 'Gorulen isler', 'Avadanlıq üzrə görülən işlər'],
      ['personal', 'Tasks', 'Şəxsi və komanda tapşırıqları']
    ]) {
      const button = el('button', 'team-source-choice');
      button.type = 'button';
      button.dataset.teamSource = key;
      button.append(el('strong', '', label), el('small', '', detail));
      button.addEventListener('click', () => { dismiss(); createTeamTask(key, person); });
      dialog.append(button);
    }
    const cancel = el('button', 'team-source-cancel', 'Ləğv et');
    cancel.type = 'button';
    cancel.addEventListener('click', dismiss);
    dialog.append(cancel);
    dialog.addEventListener('cancel', event => { event.preventDefault(); dismiss(); });
    dialog.addEventListener('keydown', event => {
      if (event.key === 'Escape') { event.preventDefault(); event.stopPropagation(); dismiss(); }
    });
    dialog.addEventListener('click', event => {
      const rect = dialog.getBoundingClientRect();
      if (event.target === dialog && (event.clientX < rect.left || event.clientX > rect.right
        || event.clientY < rect.top || event.clientY > rect.bottom)) dismiss();
    });
    root.append(dialog);
    dialog.showModal();
  }

  async function createTeamTask(sourceKey, person) {
    if (!canCreateTeamTask() || !['todo', 'gorulen', 'personal'].includes(sourceKey)) return;
    const assignees = person?.assignee ? [person.assignee] : [];
    try {
      if (sourceKey === 'personal') {
        if (!window.ADIBHomeBridge?.newTask) throw new Error('Tasks redaktoru hazır deyil.');
        await openEditorFromTeam(() => {
          window.ADIBHomeBridge.activate?.();
          return window.ADIBHomeBridge.newTask({date: selectedDate, assignees});
        });
      } else {
        const account = window.ADIBAccount;
        if (account?.user && (!account.section('equipment') || !account.action('create')))
          throw new Error('Avadanlıq tapşırığı yaratmaq üçün icazəniz yoxdur.');
        if (!window.newTaskDraft || !window.openTaskEditor) throw new Error('Avadanlıq redaktoru hazır deyil.');
        const draft = {...window.newTaskDraft(), sourceKey,
          source: sourceKey === 'todo' ? 'ToDo' : 'Gorulen isler',
          date: selectedDate, tapsirildi: assignees};
        await openEditorFromTeam(() => window.openTaskEditor(draft, null, true));
      }
    } catch (error) {
      setMessage(`Tapşırıq yaratmaq alınmadı: ${error.message}`, true);
    }
  }

  let taskReturn = null;

  function cancelTaskReturn() {
    const context = taskReturn;
    taskReturn = null;
    context?.observer.disconnect();
    clearTimeout(context?.checkTimer);
  }

  function activeTaskEditor() {
    return document.querySelector('#taskModal.open:not([hidden]) .task-editor, '
      + '.kanban-task-editor-layer:not([hidden]) .task-editor, '
      + '.personal-kanban-editor-layer:not([hidden]) .task-editor');
  }

  function beginTaskReturn() {
    cancelTaskReturn();
    const context = {restoreScroll: rememberTeamScroll(), ready: false};
    context.restore = () => {
      if (taskReturn !== context) return;
      cancelTaskReturn();
      show();
      context.restoreScroll();
    };
    context.check = () => {
      clearTimeout(context.checkTimer);
      context.checkTimer = setTimeout(() => {
        if (context.ready && taskReturn === context && !activeTaskEditor()) context.restore();
      }, 0);
    };
    context.observer = new MutationObserver(context.check);
    context.observer.observe(document.body, {
      childList: true, subtree: true, attributes: true, attributeFilter: ['class', 'hidden']
    });
    taskReturn = context;
    return context;
  }

  async function openEditorFromTeam(opener) {
    const context = beginTaskReturn();
    close();
    try {
      await opener();
      if (taskReturn !== context) return;
      context.ready = true;
      context.check();
    } catch (error) {
      if (taskReturn !== context) return;
      context.restore();
      setMessage(`Tapşırığı açmaq alınmadı: ${error.message}`, true);
    }
  }

  async function openTask(task) {
    const opener = task.kind === 'personal' && window.ADIBHomeBridge?.openTask
      ? () => {
        window.ADIBHomeBridge.activate?.();
        return window.ADIBHomeBridge.openTask(task.id);
      }
      : task.kind === 'equipment' && window.ADIBEquipmentCalendar?.open
        ? () => window.ADIBEquipmentCalendar.open(task.id) : null;
    if (opener) {
      await openEditorFromTeam(opener);
      return;
    }
    const url = task.serviceUrl || task.url;
    if (url) {
      close();
      window.location.assign(url);
    } else {
      setMessage('Bu tapşırığın açmaq üçün keçidi yoxdur.', true);
    }
  }

  async function init() {
    try {
      const auth = await request('/api/auth/me');
      user = auth.user;
      if (!user || !['admin', 'manager'].includes(user.role)) return;
    } catch {
      return;
    }
    makeDashboard();
    addNavigation(user);
    // The common task stores emit these after applying confirmed mutations or
    // realtime snapshots. Do not wait for the minute-long fallback poll.
    for (const type of ['adib-home-data', 'adib-equipment-data', 'adib-work-data',
      'adib-work-changed', 'adib-autosaved', 'adib-task-deleted']) {
      window.addEventListener(type, refreshFromChanges);
    }
    window.addEventListener('focus', () => { if (!root.hidden) refreshFromChanges(); });
    document.addEventListener('visibilitychange', () => {
      if (!document.hidden && !root.hidden) refreshFromChanges();
    });
    window.addEventListener('resize', syncSharedNavigation);
    window.visualViewport?.addEventListener('resize', syncSharedNavigation);
    const sharedNav = document.querySelector('.adib-design-nav');
    if (sharedNav && window.ResizeObserver) new ResizeObserver(syncSharedNavigation).observe(sharedNav);
    document.addEventListener('click', event => {
      const button = event.target.closest?.('.adib-design-nav button');
      const sideButton = event.target.closest?.('#adibPersistentSide button');
      const sideDestination = sideButton && sideButton.id !== 'teamSidebarButton' && !sideButton.matches('.adib-side-toggle,.adib-home-theme,.adib-home-clock');
      if (((button && button.dataset.designNav !== 'team') || sideDestination)
        && (taskReturn || (root && !root.hidden))
        && (!window.ADIBHome?.canLeave || window.ADIBHome.canLeave())) {
        cancelTaskReturn();
        if (root && !root.hidden) close();
      }
    }, true);
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape' && root && !root.hidden) close();
    });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init, {once: true});
  else init();
})();