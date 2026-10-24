'use strict';

function accountKey(value) {
  return String(value || '').replace(/-/g, '').toLowerCase();
}

function resolveEquipmentTaskPlan({ machineId = '', planId = '', allowedPlans = '*' } = {}, equipment = []) {
  const machineKey = accountKey(machineId);
  const machine = machineKey ? equipment.find(item => accountKey(item.id) === machineKey) : null;
  if (machineKey && !machine) return { ok: false, reason: 'MACHINE_NOT_FOUND' };

  const machinePlanId = String(machine?.planId || '').trim();
  const requestedPlanId = String(planId || '').trim();
  if (machine && requestedPlanId && accountKey(requestedPlanId) !== accountKey(machinePlanId)) {
    return { ok: false, reason: 'MACHINE_PLAN_MISMATCH' };
  }

  const resolvedPlanId = requestedPlanId || machinePlanId;
  if (!resolvedPlanId) return { ok: false, reason: 'PLAN_REQUIRED' };

  const allowed = allowedPlans === '*' ||
    (Array.isArray(allowedPlans) && allowedPlans.some(id => accountKey(id) === accountKey(resolvedPlanId)));
  if (!allowed) return { ok: false, reason: 'PLAN_NOT_ALLOWED' };

  return { ok: true, planId: resolvedPlanId, machine };
}

module.exports = { resolveEquipmentTaskPlan };