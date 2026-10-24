'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const { resolveEquipmentTaskPlan } = require('../equipment-task-access');

const equipment = [
  { id: '11111111-1111-4111-8111-111111111111', planId: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa' }
];

test('equipment task creation infers an omitted plan from the selected machine', () => {
  const result = resolveEquipmentTaskPlan({
    machineId: '11111111111141118111111111111111',
    allowedPlans: ['aaaaaaaaaaaa4aaa8aaaaaaaaaaaaaaa']
  }, equipment);
  assert.equal(result.ok, true);
  assert.equal(result.planId, 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa');
});

test('equipment task creation rejects a machine paired with a different plan', () => {
  const result = resolveEquipmentTaskPlan({
    machineId: equipment[0].id,
    planId: 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb',
    allowedPlans: '*'
  }, equipment);
  assert.equal(result.ok, false);
  assert.equal(result.reason, 'MACHINE_PLAN_MISMATCH');
});

test('equipment task creation still enforces access to the resolved plan', () => {
  const result = resolveEquipmentTaskPlan({
    machineId: equipment[0].id,
    allowedPlans: ['bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb']
  }, equipment);
  assert.equal(result.ok, false);
  assert.equal(result.reason, 'PLAN_NOT_ALLOWED');
});

test('equipment task creation rejects unknown machines instead of bypassing access checks', () => {
  const result = resolveEquipmentTaskPlan({
    machineId: 'cccccccc-cccc-4ccc-8ccc-cccccccccccc',
    allowedPlans: '*'
  }, equipment);
  assert.equal(result.ok, false);
  assert.equal(result.reason, 'MACHINE_NOT_FOUND');
});