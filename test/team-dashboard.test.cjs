'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const {buildTeamDashboard, normalizeName} = require('../team-dashboard');

test('team dashboard joins employee profiles, assignments and live work sessions', () => {
  const now = Date.parse('2026-10-26T08:00:00Z');
  const result = buildTeamDashboard({
    now,
    users: [{
      id: 'member-1', name: 'Araz Verdiyev', personalPageId: 'person-1',
      role: 'employee', rules: {assignee: 'Araz'}
    }],
    directory: [{id: 'person1', name: 'Araz Verdiyev', department: 'Avadanlıq'}],
    tasks: [
      {id: 'active', kind: 'equipment', title: 'Tablet təmiri', status: 'In progress', tapsirildi: ['Araz'], date: '2026-10-26'},
      {id: 'next', kind: 'personal', title: 'SAP bağlamaq', status: 'Waiting', assignees: ['Araz'], date: '2026-10-27'},
      {id: 'done', kind: 'personal', title: 'Yoxlama', status: 'Done', completed: true, completedAt: '2026-10-26T06:00:00Z', assignees: ['Araz']},
      {id: 'other', kind: 'personal', title: 'Başqa işçi', assignees: ['Ilqar']}
    ],
    sessions: [{taskId: 'active', worker: 'Araz', status: 'running'}]
  });
  assert.equal(normalizeName('Araz Vərdiyev'), 'araz verdiyev');
  assert.equal(result.employees[0].name, 'Araz Verdiyev');
  assert.equal(result.employees[0].currentTask.id, 'active');
  assert.equal(result.employees[0].nextTask.id, 'next');
  assert.equal(result.employees[0].completedToday, 1);
  assert.equal(result.employees[0].taskCount, 3);
  assert.equal(result.totals.working, 1);
  assert.equal(result.totals.completedToday, 1);
  assert.equal(result.totals.tasks, 3);
});

test('overdue tasks are counted only for unfinished tasks and employee names are normalized', () => {
  const result = buildTeamDashboard({
    now: Date.parse('2026-10-26T12:00:00Z'),
    users: [{id: 'u', name: 'Ilqar Mamedov', rules: {assignee: 'İlqar'}}],
    tasks: [
      {id: 'late', kind: 'personal', date: '2026-10-25', assignees: ['Ilqar']},
      {id: 'closed', kind: 'personal', date: '2026-10-24', completed: true, assignees: ['Ilqar']}
    ]
  });
  assert.equal(result.employees[0].overdueCount, 1);
  assert.equal(result.employees[0].openCount, 1);
});