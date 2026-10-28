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
      <nav class="team-mobile-bottom" aria-label="Əsas naviqasiya">
        <button type="button" data-team-destination="tasks"><span>✓</span>Tapşırıqlar</button>
        <button type="button" data-team-destination="calendar"><span>▦</span>Təqvim</button>
        <button type="button" data-team-destination="equipment"><span>⬡</span>Avadanlıq</button>
        <button type="button" class="active" aria-current="page"><span>♧</span>Komanda</button>
        <button type="button" data-team-close><span>⋯</span>Daha çox</button>
      </nav>
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
    root.querySelectorAll('[data-team-destination]').forEach(button => button.addEventListener('click', () => {
      const destination = button.dataset.teamDestination;
      close();
      if (destination === 'tasks') window.ADIBHomeBridge?.activate?.();
      if (destination === 'equipment') window.ADIBHomeBridge?.canvas?.();
      if (destination === 'calendar') window.ADIBCalendar?.open?.();
    }));
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

  async function load(quiet = false) {
    if (!quiet) setMessage('Komanda məlumatları yüklənir…');
    const refreshButton = root.querySelector('[data-team-refresh]');
    refreshButton.disabled = true;
    try {
      payload = await request('/api/team-snapshot');
      if (!selectedDate || selectedDate === today()) selectedDate = payload.selectedDate || today();
      setMessage('');
      render();
    } catch (error) {
      setMessage(`Məlumatları yükləmək alınmadı: ${error.message}`, true);
    } finally {
      refreshButton.disabled = false;
    }
  }

  function show() {
    if (!root) return;
    root.hidden = false;
    document.documentElement.classList.add('adib-team-open');
    document.body.classList.add('adib-team-open');
    root.querySelector('[data-team-close]').focus({preventScroll: true});
    if (!payload) load();
    clearInterval(refreshTimer);
    refreshTimer = setInterval(() => { if (!root.hidden) load(true); }, 60000);
  }

  function close() {
    if (!root || root.hidden) return;
    root.hidden = true;
    document.documentElement.classList.remove('adib-team-open');
    document.body.classList.remove('adib-team-open');
    clearInterval(refreshTimer);
    const trigger = lastTrigger?.isConnected ? lastTrigger : document.getElementById('teamSidebarButton') || document.getElementById('teamViewButton');
    trigger?.focus({preventScroll: true});
  }

  function open(event) {
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

  function render() {
    if (!root || !payload) return;
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

  function taskCard(task, label) {
    if (!task) return null;
    const button = el('button', `team-task-card ${task.kind === 'equipment' ? 'equipment' : 'personal'}`);
    button.type = 'button';
    button.addEventListener('click', () => openTask(task));
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
        section.append(el('h4', '', person.name));
        const rows = (person.tasks || []).filter(task => !task.completed || dayKey(task.completedAt) === selectedDate);
        if (!rows.length) section.append(el('p', 'team-empty', 'Bu gün üçün tapşırıq yoxdur.'));
        for (const task of rows) section.append(taskCard(task, task.completed ? 'TAMAMLANIB' : task.status || 'PLANLI'));
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
      active.append(current ? taskCard(current, current.kind === 'equipment' ? 'AVADANLIQ' : 'TAPŞIRIQ') : el('div', 'team-no-task', 'Hazırda aktiv tapşırıq yoxdur'));
      card.append(active);

      const upcoming = person.nextTask;
      if (upcoming) {
        const next = el('section', 'team-card-section next');
        next.append(el('div', 'team-section-label', 'NÖVBƏTİ TAPŞIRIQ'));
        const row = taskCard(upcoming, upcoming.date ? prettyDate(upcoming.date) : 'PLANLI');
        if (row) next.append(row);
        card.append(next);
      }

      const add = el('button', 'team-add-inline', '＋  Tapşırıq əlavə et');
      add.type = 'button';
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

  function addTask(person) {
    close();
    if (!window.ADIBHomeBridge?.newTask) {
      setTimeout(() => show(), 0);
      setMessage('Tapşırıq yaratmaq üçün şəxsi tapşırıqlar görünüşünü açın.');
      return;
    }
    window.ADIBHomeBridge.activate?.();
    window.ADIBHomeBridge.newTask({
      date: selectedDate,
      assignees: person?.assignee ? [person.assignee] : []
    });
  }

  function openTask(task) {
    if (task.kind === 'personal' && window.ADIBHomeBridge?.openTask) {
      close();
      window.ADIBHomeBridge.activate?.();
      window.ADIBHomeBridge.openTask(task.id);
      return;
    }
    if (task.kind === 'equipment' && window.ADIBEquipmentCalendar?.open) {
      close();
      window.ADIBEquipmentCalendar.open(task.id).catch(error => {
        show();
        setMessage(`Tapşırığı açmaq alınmadı: ${error.message}`, true);
      });
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
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape' && root && !root.hidden) close();
    });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init, {once: true});
  else init();
})();