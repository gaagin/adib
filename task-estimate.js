'use strict';

const FIELD = 'Təxmini müddət, dəq';
const validMinutes = value => Number.isInteger(value) && value >= 1 && value <= 43200;
const error = (message, statusCode = 400, code = 'TASK_ESTIMATE_ERROR') =>
  Object.assign(new Error(message), { statusCode, code });

function create({ notion, sources, field = FIELD }) {
  const schemas = new Map();
  const flights = new Map();
  const ensureFlights = new Map();

  function sourceFor(key) {
    const source = sources()[key];
    if (!source || (!source.dataSourceId && !source.databaseId)) {
      throw error('Tapşırıq bazası konfiqurasiya edilməyib: ' + key, 503);
    }
    return source;
  }

  function endpoint(source) {
    return source.dataSourceId
      ? { path: '/data_sources/' + source.dataSourceId, version: undefined }
      : { path: '/databases/' + source.databaseId, version: '2022-06-28' };
  }

  async function schema(key, { force = false } = {}) {
    const source = sourceFor(key);
    const identity = [key, source.dataSourceId, source.databaseId].join(':');
    const cached = schemas.get(identity);
    if (!force && cached) return cached;
    if (flights.has(identity)) return flights.get(identity);

    const job = (async () => {
      const target = endpoint(source);
      let value;
      if (source.dataSourceId) {
        try {
          value = await notion(target.path, { method: 'GET' });
        } catch (e) {
          if (![400, 404].includes(e.notionStatus) && !/Notion API (400|404):/.test(e.message || '')) throw e;
          if (!source.databaseId) throw e;
          value = await notion('/databases/' + source.databaseId, { method: 'GET' }, '2022-06-28');
        }
      } else {
        value = await notion(target.path, { method: 'GET' }, target.version);
      }
      if (!value?.properties) throw error('Notion sahələrinin sxemi yüklənmədi', 502, 'TASK_ESTIMATE_SCHEMA_UNAVAILABLE');
      schemas.set(identity, value);
      return value;
    })();
    flights.set(identity, job);
    try {
      return await job;
    } finally {
      if (flights.get(identity) === job) flights.delete(identity);
    }
  }

  async function ensureOnce(key) {
    const source = sourceFor(key);
    const identity = [key, source.dataSourceId, source.databaseId].join(':');
    let value = await schema(key);
    const current = value.properties[field];
    if (current && current.type !== 'number' && !current.number) {
      throw error('Notion sahəsi «' + field + '» rəqəm tipində olmalıdır', 409, 'TASK_ESTIMATE_SCHEMA_INVALID');
    }
    if (!current) {
      const target = endpoint(source);
      const updated = await notion(target.path, {
        method: 'PATCH',
        body: JSON.stringify({ properties: { [field]: { number: { format: 'number' } } } })
      }, target.version);
      value = updated?.properties
        ? updated
        : { ...value, properties: { ...value.properties, [field]: { type: 'number', number: { format: 'number' } } } };
      schemas.set(identity, value);
    }
    return value;
  }

  async function ensure(key) {
    const source = sourceFor(key);
    const identity = [key, source.dataSourceId, source.databaseId].join(':');
    if (ensureFlights.has(identity)) return ensureFlights.get(identity);
    const job = ensureOnce(key);
    ensureFlights.set(identity, job);
    try {
      return await job;
    } finally {
      if (ensureFlights.get(identity) === job) ensureFlights.delete(identity);
    }
  }

  function read(page) {
    const property = page?.properties?.[field];
    if (!property || (property.type && property.type !== 'number' && !property.number)) return null;
    const value = property.number;
    return validMinutes(value) ? value : null;
  }

  async function save(key, id, minutes) {
    if (minutes !== null && !validMinutes(minutes)) {
      throw error('Vaxt təxmini: 1-dən 43200 dəqiqəyə qədər tam ədəd və ya boş dəyər', 400, 'INVALID_ESTIMATE');
    }
    await ensure(key);
    await notion('/pages/' + encodeURIComponent(id), {
      method: 'PATCH',
      body: JSON.stringify({ properties: { [field]: { number: minutes } } })
    });
    return minutes;
  }

  return { schema, ensure, read, save, field };
}

module.exports = { create, FIELD, validMinutes };