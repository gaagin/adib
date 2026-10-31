// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverContent(context) {
async function listPageBlocks(pageId) {
  const blocks = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const result = await context.notion('/blocks/' + encodeURIComponent(pageId) + '/children?page_size=100' + suffix, { method: 'GET' });
    blocks.push(...(result.results || []));
    cursor = result.has_more ? result.next_cursor : '';
  } while (cursor);
  return blocks;
}

function blockRichText(block) { const value = block?.[block?.type] || {}; return (value.rich_text || []).map(part => part.plain_text || part.text?.content || '').join(''); }

async function blockContentText(block) {
  const type = block?.type || '';
  if (type === 'table_row') return (block.table_row?.cells || []).map(cell => (cell || []).map(part => part.plain_text || part.text?.content || '').join('')).join('\t');
  let text = blockRichText(block);
  if (type === 'to_do') text = (block.to_do?.checked ? '[x] ' : '[ ] ') + text;
  if (type === 'bulleted_list_item') text = '- ' + text;
  if (type === 'numbered_list_item') text = '1. ' + text;
  if (type === 'code' && block.code?.language) text = '```' + block.code.language + '\n' + text + '\n```';
  if (block.has_children) { const children = await listPageBlocks(block.id); const childText = (await Promise.all(children.map(blockContentText))).filter(Boolean).join('\n'); if (childText) text = text ? text + '\n' + childText : childText; }
  return text;
}

async function getPersonalTaskContent(idValue) { const id = context.cleanId(String(idValue || '').trim()); if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks'); const blocks = await listPageBlocks(id); return { ok: true, id, content: (await Promise.all(blocks.map(blockContentText))).join('\n') }; }

function contentBlocks(value) { return String(value ?? '').replace(/\r\n/g, '\n').split('\n').map(line => ({ object: 'block', type: 'paragraph', paragraph: { rich_text: line ? [{ type: 'text', text: { content: line.slice(0, 2000) } }] : [] } })); }

async function replacePersonalTaskContent(idValue, value) { const id = context.cleanId(String(idValue || '').trim()); if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks'); const oldBlocks = await listPageBlocks(id); for (const block of oldBlocks.filter(b=>!['image','file','video','audio','pdf','bookmark','embed','child_page','child_database'].includes(b.type))) await context.notion('/blocks/' + encodeURIComponent(block.id), { method: 'DELETE' }); const children = contentBlocks(value); for (let index = 0; index < children.length; index += 100) await context.notion('/blocks/' + encodeURIComponent(id) + '/children', { method: 'PATCH', body: JSON.stringify({ children: children.slice(index, index + 100) }) }); return { ok: true, id }; }

async function listStructuredPageBlocks(pageId) {
  const result = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const page = await context.notion('/blocks/' + encodeURIComponent(pageId) + '/children?page_size=100' + suffix, { method: 'GET' });
    result.push(...(page.results || []));
    cursor = page.has_more ? page.next_cursor : '';
  } while (cursor);
  return result;
}

async function loadStructuredBlockTree(pageId) {
  const blocks = await listStructuredPageBlocks(pageId);
  for (const block of blocks) if (block.has_children) block.children = await loadStructuredBlockTree(block.id);
  return blocks;
}

function decodeHtmlText(value) { return String(value || '').replace(/<br\s*\/?>/gi, '\n').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'"); }

function htmlToNotionRichText(html) {
  const runs = [], stack = [];
  const source = String(html || '').replace(/<div>/gi, '').replace(/<\/div>/gi, '\n');
  for (const token of source.split(/(<[^>]+>)/g).filter(Boolean)) {
    if (token[0] === '<') {
      const tag = token.match(/^<\/?\s*([a-z0-9]+)/i)?.[1]?.toLowerCase() || '';
      if (token[1] === '/') { const index = stack.lastIndexOf(tag); if (index >= 0) stack.splice(index, 1); continue; }
      if (tag === 'br') { runs.push({ type: 'text', text: { content: '\n' } }); continue; }
      if (['strong','b','em','i','u','s','strike','code','a','span'].includes(tag)) stack.push(tag);
      continue;
    }
    const text = decodeHtmlText(token); if (!text) continue;
    const annotations = { bold: stack.some(x => x === 'strong' || x === 'b'), italic: stack.some(x => x === 'em' || x === 'i'), underline: stack.includes('u'), strikethrough: stack.some(x => x === 's' || x === 'strike'), code: stack.includes('code'), color: 'default' };
    const item = { type: 'text', text: { content: text }, annotations };
    runs.push(item);
  }
  return runs.length ? runs : [];
}

function structuredTableRows(dto) { return (dto.rows || []).map(row => ({ object: 'block', type: 'table_row', table_row: { cells: (row || []).map(cell => htmlToNotionRichText(cell)) } })); }

function structuredSimpleBlock(dto) {
  const type = ['paragraph','heading_1','heading_2','heading_3','bulleted_list_item','numbered_list_item','quote','callout','code','to_do'].includes(dto.type) ? dto.type : 'paragraph';
  const value = { rich_text: htmlToNotionRichText(dto.html || '') };
  if (type === 'to_do') value.checked = Boolean(dto.checked);
  if (type === 'code') value.language = String(dto.language || 'plain text');
  if (type === 'callout') value.icon = { type: 'emoji', emoji: String(dto.icon || '💡') };
  return { object: 'block', type, [type]: value };
}

async function getPersonalTaskBlocks(idValue) { const id = context.cleanId(String(idValue || '').trim()); if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks'); return { ok: true, id, blocks: await loadStructuredBlockTree(id) }; }

function structuredTablePlan(dto) {
  const inputRows = Array.isArray(dto.rows) && dto.rows.length ? dto.rows : [['']];
  if (inputRows.some(row => !Array.isArray(row))) throw new Error('Cədvəl sətirləri xana massivləri olmalıdır');
  const declaredWidth = Number(dto.width) || 0;
  if (declaredWidth && (!Number.isInteger(declaredWidth) || declaredWidth < 1)) throw new Error('Yanlış cədvəl eni');
  const width = Math.max(1, declaredWidth, ...inputRows.map(row => row.length));
  if (width > 100) throw new Error('Cədvəldə 100-dən çox sütun ola bilməz');
  const normalized = inputRows.map(row => Array.from({length: width}, (_, i) => row[i] ?? ''));
  const rows = structuredTableRows({rows: normalized});
  return {
    block: {object: 'block', type: 'table', table: {
      table_width: width, has_column_header: Boolean(dto.hasColumnHeader), has_row_header: false,
      children: rows.slice(0, 100)
    }}, extraRows: rows.slice(100)
  };
}

async function replacePersonalTaskBlocks(idValue, blocks) {
  const id = context.cleanId(String(idValue || '').trim()); if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks');
  const items = Array.isArray(blocks) && blocks.length ? blocks : [{type: 'paragraph', html: ''}];
  // Validate/build the entire payload before making changes in Notion.
  const plan = items.filter(dto=>!dto?.preserveId).map(dto => {
    if (!dto || typeof dto !== 'object') throw new Error('Etibarsız tapşırıq məzmun bloku');
    return dto.type === 'table' ? structuredTablePlan(dto) : {block: structuredSimpleBlock(dto), extraRows: []};
  });
  const oldBlocks = await listStructuredPageBlocks(id), createdIds = [], archiveAttempted = [];
  try {
    // Stage all new content first. A rejected table must not erase existing content.
    for (const item of plan) {
      const created = await context.notion('/blocks/' + encodeURIComponent(id) + '/children', {method: 'PATCH', body: JSON.stringify({children: [item.block]})});
      const blockId = created.results?.[0]?.id;
      if (!blockId) throw new Error('Notion qaytarılmadı ID ; köhnə məzmun silinmir Yaradılmış tapşırığın');
      createdIds.push(blockId);
      for (let offset = 0; offset < item.extraRows.length; offset += 100) {
        await context.notion('/blocks/' + encodeURIComponent(blockId) + '/children', {method: 'PATCH', body: JSON.stringify({children: item.extraRows.slice(offset, offset + 100)})});
      }
    }
    for (const block of oldBlocks.filter(b=>!['image','file','video','audio','pdf','bookmark','embed','child_page','child_database'].includes(b.type))) {
      archiveAttempted.push(block.id);
      await context.notion('/blocks/' + encodeURIComponent(block.id), {method: 'DELETE'});
    }
  } catch (error) {
    const recoveryErrors = [];
    // Best-effort rollback: Notion has no atomic replace API.
    for (const blockId of archiveAttempted) {
      try {await context.notion('/blocks/' + encodeURIComponent(blockId), {method: 'PATCH', body: JSON.stringify({archived: false})});}
      catch (recovery) {recoveryErrors.push(recovery.message);}
    }
    for (const blockId of createdIds.reverse()) {
      try {await context.notion('/blocks/' + encodeURIComponent(blockId), {method: 'DELETE'});}
      catch (recovery) {recoveryErrors.push(recovery.message);}
    }
    if (recoveryErrors.length) error.message += ' · Qismən qənaəti tamamilə geri qaytarmaq mümkün olmadı. Redaktoru açıq saxlayın və mətnin surətini saxlayın.';
    throw error;
  }
  return {ok: true, id};
}
return { listPageBlocks, blockRichText, blockContentText, getPersonalTaskContent, contentBlocks, replacePersonalTaskContent, listStructuredPageBlocks, loadStructuredBlockTree, decodeHtmlText, htmlToNotionRichText, structuredTableRows, structuredSimpleBlock, getPersonalTaskBlocks, structuredTablePlan, replacePersonalTaskBlocks };
};
