(function (root, factory) {
  'use strict';
  const api = factory(root);
  if (typeof module === 'object' && module.exports) module.exports = api;
  else root.ADIBTaskStats = api;
})(typeof globalThis !== 'undefined' ? globalThis : this, function (root) {
  'use strict';

  const WINDOW = 7 * 24 * 60 * 60 * 1000;
  const DONE = new Set([
    'done', 'complete', 'completed', 'finished', 'closed', 'is goruldu', 'is gorulub',
    'goruldu', 'gorulub', 'tamamlandi', 'tamamlanib', 'tamamlanmis', 'bitdi', 'bitib',
    'yekunlasdi', 'hell olundu', 'hell edildi', 'выполнено', 'выполнена', 'завершено',
    'завершена', 'решено'
  ]);
  const COLORS = ['#4d6cf5', '#23a57a', '#efa93a', '#e45d78', '#865be2', '#18a6bd', '#f07845', '#9a6bdb', '#70a83b', '#dd7b4a'];

  function localKey(date) {
    return date.getFullYear() + '-' + String(date.getMonth() + 1).padStart(2, '0') + '-' + String(date.getDate()).padStart(2, '0');
  }

  function isDone(task) {
    if (root.ADIBTaskHistory?.done) return root.ADIBTaskHistory.done(task);
    const key = String(task?.process || task?.status || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/ı/g, 'i').trim().toLowerCase().replace(/\s+/g, ' ');
    return task?.completed === true || task?.done === true || task?.isCompleted === true || DONE.has(key);
  }

  function completedInWindow(tasks, now = Date.now()) {
    const from = now - WINDOW;
    const seen = new Set();
    let count = 0;
    for (const task of tasks || []) {
      const id = String(task?.id || '');
      if (!id || seen.has(id) || !isDone(task)) continue;
      seen.add(id);
      const stamp = Date.parse(task.completedAt || '');
      if (Number.isFinite(stamp) && stamp >= from && stamp <= now + 60000) count++;
    }
    return count;
  }

  function summarize(tasks, now = Date.now(), locale = 'az-AZ') {
    const today = new Date(now), days = [];
    today.setHours(0, 0, 0, 0);
    for (let i = 6; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(today.getDate() - i);
      days.push({ key: localKey(date), date, count: 0, color: COLORS[6 - i] });
    }
    const byDay = new Map(days.map(day => [day.key, day]));
    const seen = new Set(), from = now - WINDOW;
    for (const task of tasks || []) {
      const id = String(task?.id || '');
      if (!id || seen.has(id) || !isDone(task)) continue;
      seen.add(id);
      const stamp = Date.parse(task.completedAt || '');
      if (!Number.isFinite(stamp) || stamp < from || stamp > now + 60000) continue;
      const day = byDay.get(localKey(new Date(stamp)));
      if (day) day.count++;
    }
    const format = new Intl.DateTimeFormat(locale, { weekday: 'short', day: 'numeric', month: 'short' });
    for (const day of days) day.label = format.format(day.date);
    return { days, total: days.reduce((n, day) => n + day.count, 0), from, to: now };
  }

  function descendantPlanIds(plans, selectedId) {
    const ids = new Set([String(selectedId)]);
    let changed = true;
    while (changed) {
      changed = false;
      for (const plan of plans || []) {
        const id = String(plan.id || ''), parentId = String(plan.parentId || '');
        if (id && parentId && ids.has(parentId) && !ids.has(id)) {
          ids.add(id);
          changed = true;
        }
      }
    }
    return ids;
  }

  function equipmentBreakdown(data, scope = 'all', now = Date.now(), locale = 'az-AZ') {
    const plans = data?.plans || [];
    const allEquipment = data?.equipment || [];
    let equipment = allEquipment;
    if (scope.startsWith('plan:')) {
      const ids = descendantPlanIds(plans, scope.slice(5));
      equipment = allEquipment.filter(item => ids.has(String(item.planId || '')));
    }
    const collator = new Intl.Collator(locale, { numeric: true, sensitivity: 'base' });
    const equipmentCount = equipment.length;
    const items = equipment.map(item => ({
      id: String(item.id || ''),
      name: String(item.name || 'Adsız avadanlıq'),
      count: completedInWindow(item.tasks || [], now)
    })).filter(item => item.id && item.count > 0).sort((a, b) => b.count - a.count || collator.compare(a.name, b.name));
    return { items, equipmentCount, total: items.reduce((sum, item) => sum + item.count, 0), from: now - WINDOW, to: now };
  }

  function completedTasksForEquipment(data, equipmentId, now = Date.now()) {
    const equipment = (data?.equipment || []).find(item => String(item.id) === String(equipmentId));
    const from = now - WINDOW, seen = new Set();
    return (equipment?.tasks || []).filter(task => {
      const id = String(task?.id || ''), stamp = Date.parse(task?.completedAt || '');
      if (!id || seen.has(id) || !isDone(task) || !Number.isFinite(stamp) || stamp < from || stamp > now + 60000) return false;
      seen.add(id);
      return true;
    }).sort((a, b) => Date.parse(b.completedAt || '') - Date.parse(a.completedAt || ''));
  }

  // Kept for compatibility with callers/tests that need a single task list.
  function scopedTasks(data, scope) {
    const plans = data?.plans || [], equipment = data?.equipment || [];
    let selected = [];
    if (scope === 'all') selected = [...plans, ...equipment].flatMap(item => item.tasks || []);
    else if (scope.startsWith('machine:')) {
      const machine = equipment.find(item => String(item.id) === scope.slice(8));
      selected = machine?.tasks || [];
    } else if (scope.startsWith('plan:')) {
      const ids = descendantPlanIds(plans, scope.slice(5));
      selected = [...plans.filter(plan => ids.has(String(plan.id))), ...equipment.filter(item => ids.has(String(item.planId || '')))].flatMap(item => item.tasks || []);
    }
    const seen = new Set();
    return selected.filter(task => {
      const id = String(task?.id || '');
      if (!id || seen.has(id)) return false;
      seen.add(id);
      return true;
    });
  }

  function append(parent, tag, className, text) {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (text !== undefined) node.textContent = text;
    parent.append(node);
    return node;
  }

  function snapshot() {
    return root.ADIBEquipmentCalendar?.statsSnapshot?.() || { currentPlan: '', plans: [], equipment: [] };
  }

  function open() {
    if (typeof document === 'undefined') return null;
    const old = document.getElementById('adibTaskStatsDialog');
    if (old) { old.showModal?.(); return old; }

    const dialog = document.createElement('dialog');
    dialog.id = 'adibTaskStatsDialog';
    dialog.className = 'adib-task-stats-dialog';
    dialog.setAttribute('aria-labelledby', 'adibTaskStatsTitle');
    const head = append(dialog, 'header', 'adib-task-stats-head');
    const back = document.createElement('button');
    back.type = 'button'; back.className = 'adib-task-stats-back'; back.setAttribute('aria-label', 'Geri'); back.textContent = '←'; back.hidden = true;
    head.append(back);
    const title = append(head, 'h2', '', 'Son 7 gün · avadanlıq üzrə tamamlanan tapşırıqlar');
    title.id = 'adibTaskStatsTitle';
    const close = document.createElement('button');
    close.type = 'button'; close.className = 'adib-task-stats-close'; close.setAttribute('aria-label', 'Bağla'); close.textContent = '×';
    close.onclick = () => dialog.close(); head.append(close);

    const label = append(dialog, 'label', 'adib-task-stats-label', 'Plan');
    const select = document.createElement('select');
    select.setAttribute('aria-label', 'Plan seçin'); label.append(select);
    const summary = append(dialog, 'div', 'adib-task-stats-summary');
    const chartWrap = append(summary, 'div', 'adib-task-stats-pie');
    const legend = append(summary, 'ol', 'adib-task-stats-legend');
    const list = append(dialog, 'section', 'adib-task-stats-task-list'); list.hidden = true;
    const empty = append(dialog, 'p', 'adib-task-stats-empty', '');
    document.body.append(dialog);
    let selectedEquipmentId = '';

    function equipmentTitle(data, id) {
      return (data.equipment || []).find(item => String(item.id) === String(id))?.name || 'Avadanlıq';
    }

    function showEquipment(id) {
      const data = snapshot(), equipment = (data.equipment || []).find(item => String(item.id) === String(id));
      if (!equipment) return;
      selectedEquipmentId = String(id);
      title.textContent = equipmentTitle(data, id);
      back.hidden = false; label.hidden = true; summary.hidden = true; list.hidden = false; list.replaceChildren(); empty.textContent = '';
      const now = root.ADIBClock?.now?.() ?? Date.now();
      const tasks = completedTasksForEquipment(data, id, now);
      const subhead = append(list, 'p', 'adib-task-stats-list-caption', 'Son 7 gündə tamamlananlar · ' + tasks.length);
      if (!tasks.length) { empty.textContent = 'Son 7 gündə tamamlanan tapşırıq yoxdur'; return; }
      const formatter = new Intl.DateTimeFormat('az-AZ', { day: 'numeric', month: 'short', hour: '2-digit', minute: '2-digit' });
      for (const task of tasks) {
        const row = document.createElement('button');
        row.type = 'button'; row.className = 'adib-task-stats-task';
        const name = append(row, 'span', 'adib-task-stats-task-name', String(task.title || task.name || 'Tapşırıq'));
        const stamp = Date.parse(task.completedAt || '');
        append(row, 'span', 'adib-task-stats-task-date', Number.isFinite(stamp) ? formatter.format(new Date(stamp)) : '');
        row.setAttribute('aria-label', String(task.title || task.name || 'Tapşırıq') + ' — aç');
        row.addEventListener('click', () => {
          const taskId = String(task.id || ''), api = root.ADIBEquipmentCalendar;
          dialog.close();
          setTimeout(() => { if (taskId && api?.open) api.open(taskId).catch?.(() => {}); }, 0);
        });
        list.append(row);
      }
    }

    function drawPie(host, legendHost, stats) {
      host.replaceChildren(); legendHost.replaceChildren();
      const ns = 'http://www.w3.org/2000/svg', svg = document.createElementNS(ns, 'svg');
      svg.setAttribute('viewBox', '0 0 180 180'); svg.setAttribute('role', 'img');
      svg.setAttribute('aria-label', 'Avadanlıq üzrə son 7 gündə tamamlanan tapşırıqlar: ' + stats.total);
      const base = document.createElementNS(ns, 'circle');
      base.setAttribute('cx', '90'); base.setAttribute('cy', '90'); base.setAttribute('r', '65'); base.setAttribute('fill', 'none');
      base.setAttribute('stroke', 'var(--adib-stats-track,#e9edf5)'); base.setAttribute('stroke-width', '30'); svg.append(base);
      const circumference = 2 * Math.PI * 65; let offset = 0;
      if (stats.total) stats.items.forEach((item, index) => {
        const length = circumference * item.count / stats.total, segment = document.createElementNS(ns, 'circle');
        segment.setAttribute('cx', '90'); segment.setAttribute('cy', '90'); segment.setAttribute('r', '65'); segment.setAttribute('fill', 'none');
        segment.setAttribute('stroke', COLORS[index % COLORS.length]); segment.setAttribute('stroke-width', '30');
        segment.setAttribute('stroke-dasharray', Math.max(0, length - 2) + ' ' + circumference); segment.setAttribute('stroke-dashoffset', String(-offset));
        segment.setAttribute('transform', 'rotate(-90 90 90)'); segment.setAttribute('aria-label', item.name + ': ' + item.count);
        const tip = document.createElementNS(ns, 'title'); tip.textContent = item.name + ': ' + item.count; segment.append(tip); svg.append(segment); offset += length;
      });
      const total = document.createElementNS(ns, 'text'); total.setAttribute('x', '90'); total.setAttribute('y', '86'); total.setAttribute('text-anchor', 'middle'); total.setAttribute('class', 'adib-task-stats-total'); total.textContent = String(stats.total); svg.append(total);
      const caption = document.createElementNS(ns, 'text'); caption.setAttribute('x', '90'); caption.setAttribute('y', '106'); caption.setAttribute('text-anchor', 'middle'); caption.setAttribute('class', 'adib-task-stats-caption'); caption.textContent = 'tapşırıq'; svg.append(caption);
      host.append(svg);
      stats.items.forEach((item, index) => {
        const li = document.createElement('li'), swatch = append(li, 'span', 'adib-task-stats-swatch');
        const button = append(li, 'button', 'adib-task-stats-equipment', item.name);
        button.type = 'button'; button.dataset.equipmentId = item.id; button.setAttribute('aria-label', item.name + ' avadanlığının tapşırıqlarını göstər');
        const pct = Math.round(item.count * 100 / stats.total);
        append(li, 'strong', 'adib-task-stats-value', item.count + ' · ' + pct + '%');
        swatch.style.backgroundColor = COLORS[index % COLORS.length];
        li.setAttribute('aria-label', item.name + ': ' + item.count + ' tapşırıq, ' + pct + '%'); legendHost.append(li);
      });
    }

    function update() {
      const data = snapshot(), previous = select.value;
      const plans = [...(data.plans || [])].sort((a, b) => String(a.name || '').localeCompare(String(b.name || ''), 'az', { numeric: true }));
      select.replaceChildren();
      const all = document.createElement('option'); all.value = 'all'; all.textContent = 'Bütün planlar · bütün avadanlıq'; select.append(all);
      for (const plan of plans) { const option = document.createElement('option'); option.value = 'plan:' + String(plan.id); option.textContent = String(plan.name || 'Adsız plan'); select.append(option); }
      const available = new Set([...select.options].map(option => option.value)), defaultPlan = 'plan:' + String(data.currentPlan || '');
      select.value = available.has(previous) ? previous : available.has(defaultPlan) ? defaultPlan : 'all';
      const stats = equipmentBreakdown(data, select.value, root.ADIBClock?.now?.() ?? Date.now());
      drawPie(chartWrap, legend, stats);
      empty.textContent = stats.total ? '' : stats.equipmentCount ? 'Son 7 gündə tamamlanan tapşırıq yoxdur' : 'Bu plan üçün avadanlıq tapılmadı';
    }

    legend.addEventListener('click', event => {
      const button = event.target.closest('[data-equipment-id]');
      if (button) showEquipment(button.dataset.equipmentId);
    });
    select.addEventListener('change', update);
    back.addEventListener('click', () => { selectedEquipmentId = ''; title.textContent = 'Son 7 gün · avadanlıq üzrə tamamlanan tapşırıqlar'; back.hidden = true; label.hidden = false; summary.hidden = false; list.hidden = true; empty.textContent = ''; update(); });
    dialog.addEventListener('cancel', () => dialog.remove()); dialog.addEventListener('close', () => dialog.remove());
    let active = true;
    const refresh = () => { if (active && dialog.isConnected) { if (selectedEquipmentId) showEquipment(selectedEquipmentId); else update(); } };
    for (const name of ['adib-equipment-data', 'adib-create-data', 'adib-home-data']) root.addEventListener(name, refresh);
    dialog.addEventListener('close', () => { active = false; for (const name of ['adib-equipment-data', 'adib-create-data', 'adib-home-data']) root.removeEventListener(name, refresh); }, { once: true });
    update(); dialog.showModal(); close.focus({ preventScroll: true }); return dialog;
  }

  return { WINDOW, summarize, scopedTasks, equipmentBreakdown, completedTasksForEquipment, open };
});
