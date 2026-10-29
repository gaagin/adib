'use strict';

function normalizeName(value) {
  return String(value || '')
    .replace(/[əƏ]/g, 'e')
    .replace(/[ıİ]/g, 'i')
    .normalize('NFKD')
    .replace(/\p{Diacritic}/gu, '')
    .toLocaleLowerCase()
    .replace(/[^a-z0-9]+/g, ' ')
    .trim();
}

function dateInZone(value, timeZone) {
  const date = value ? new Date(value) : null;
  if (!date || !Number.isFinite(date.getTime())) return '';
  const parts = new Intl.DateTimeFormat('en-CA', {
    timeZone, year: 'numeric', month: '2-digit', day: '2-digit'
  }).formatToParts(date);
  const get = type => parts.find(part => part.type === type)?.value || '';
  return `${get('year')}-${get('month')}-${get('day')}`;
}

function taskDay(value, timeZone) {
  if (!value) return '';
  const text = String(value);
  const dateOnly = text.match(/^(\d{4}-\d{2}-\d{2})/);
  return dateOnly ? dateOnly[1] : dateInZone(text, timeZone);
}

function buildTeamDashboard({
  users = [], directory = [], tasks = [], sessions = [],
  now = Date.now(), timeZone = 'Asia/Baku'
} = {}) {
  // Deduplicate before filtering: a newer tombstone must override an older row.
  tasks = [...new Map(tasks.filter(task => task?.id).map(task => [String(task.id), task])).values()]
    .filter(task => !task.deleted && !task.archived && !task.in_trash);
  const today = dateInZone(now, timeZone);
  const profiles = new Map(directory.map(person => [String(person.id || '').replaceAll('-', '').toLowerCase(), person]));
  const employees = users.filter(user => !user.disabled).map(user => {
    const profile = profiles.get(String(user.personalPageId || '').replaceAll('-', '').toLowerCase());
    const aliases = [...new Set([profile?.name, user.rules?.assignee, user.name].filter(Boolean))];
    return {
      key: user.id,
      name: profile?.name || user.name || 'Əməkdaş',
      department: profile?.department || '',
      role: user.role || 'employee',
      aliases,
      normalizedAliases: new Set(aliases.map(normalizeName).filter(Boolean))
    };
  });
  const taskRows = tasks.map(task => {
    const assigneeNames = task.kind === 'personal'
      ? (task.assignees || [])
      : [...(task.tapsirildi || []), task.assigneeName, task.assigneeId].filter(Boolean);
    const normalized = new Set(assigneeNames.map(normalizeName).filter(Boolean));
    return {
      id: task.id,
      title: task.title || 'Tapşırıq',
      kind: task.kind || 'personal',
      source: task.source || (task.kind === 'equipment' ? 'Avadanlıq' : 'Tapşırıqlarım'),
      status: task.status || task.process || '',
      completed: Boolean(task.completed),
      completedAt: task.completedAt || '',
      date: task.date || '',
      dateEnd: task.dateEnd || '',
      priority: task.priority || '',
      machineName: task.machineName || '',
      serviceUrl: task.serviceUrl || '',
      normalizedAssignees: normalized
    };
  });
  const activeSessions = sessions.filter(session =>
    session && ['running', 'pending'].includes(session.status)
  );
  const todayKey = today;
  const result = employees.map(employee => {
    const assigned = taskRows.filter(task =>
      [...task.normalizedAssignees].some(name => employee.normalizedAliases.has(name))
    );
    const ownSession = activeSessions.find(session =>
      employee.normalizedAliases.has(normalizeName(session.worker))
    );
    const sessionTask = ownSession && taskRows.find(task =>
      String(task.id) === String(ownSession.taskId)
    );
    const inProgress = assigned.find(task =>
      !task.completed && /in progress|is gedir|icra olunur|işləyir/i.test(task.status)
    );
    const currentTask = sessionTask || inProgress || null;
    const open = assigned.filter(task => !task.completed);
    const upcoming = open
      .filter(task => task !== currentTask)
      .sort((a, b) => (taskDay(a.date, timeZone) || '9999-99-99')
        .localeCompare(taskDay(b.date, timeZone) || '9999-99-99'));
    const completedToday = assigned.filter(task =>
      task.completed && taskDay(task.completedAt, timeZone) === todayKey
    ).length;
    const overdue = open.filter(task => {
      const due = taskDay(task.dateEnd || task.date, timeZone);
      return due && due < todayKey;
    }).length;
    return {
      key: employee.key,
      name: employee.name,
      department: employee.department,
      role: employee.role,
      assignee: employee.aliases.find(value => normalizeName(value) !== normalizeName(employee.name)) || employee.name,
      aliases: employee.aliases,
      taskCount: assigned.length,
      openCount: open.length,
      completedToday,
      overdueCount: overdue,
      isWorking: Boolean(ownSession || currentTask),
      activeSessionStatus: ownSession?.status || '',
      currentTask,
      nextTask: upcoming[0] || null,
      tasks: assigned.map(({normalizedAssignees, ...task}) => task)
    };
  });
  const allTasks = result.flatMap(employee => employee.tasks);
  return {
    employees: result,
    selectedDate: today,
    totals: {
      employees: result.length,
      working: result.filter(employee => employee.isWorking).length,
      completedToday: result.reduce((sum, employee) => sum + employee.completedToday, 0),
      overdue: result.reduce((sum, employee) => sum + employee.overdueCount, 0),
      tasks: new Set(allTasks.map(task => task.id)).size
    }
  };
}

module.exports = { buildTeamDashboard, normalizeName, dateInZone, taskDay };