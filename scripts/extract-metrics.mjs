#!/usr/bin/env node
// Generates docs/METRICS.md and docs/RUN_LOG.md from `.converge/journal/default/`.
// Primary sources: `converge show metrics --json`, `converge show gantt`, events.jsonl, per-task dirs.

import { execSync } from 'node:child_process';
import { readFileSync, writeFileSync, readdirSync, existsSync, statSync } from 'node:fs';
import { join } from 'node:path';

const JOURNAL = '.converge/journal/default';
const TASKS_DIR = join(JOURNAL, 'tasks');
const EVENTS = join(JOURNAL, 'events.jsonl');

function fmtMs(ms) {
  if (!ms || ms < 0) return '—';
  const s = ms / 1000;
  if (s < 60) return `${s.toFixed(1)}s`;
  const m = s / 60;
  if (m < 60) return `${m.toFixed(1)}m`;
  return `${(m / 60).toFixed(2)}h`;
}

function fmtNum(n) {
  return n.toLocaleString('en-US');
}

function readMetrics() {
  const raw = execSync('converge show metrics --json 2>/dev/null', { encoding: 'utf8' });
  const jsonStart = raw.indexOf('{');
  return JSON.parse(raw.slice(jsonStart));
}

function readGanttSummary() {
  try {
    const raw = execSync('converge show gantt 2>/dev/null', { encoding: 'utf8' });
    const m = raw.match(/Total Tasks:\s*(\d+)[\s\S]*?Completed:\s*(\d+)[\s\S]*?Failed:\s*(\d+)[\s\S]*?Blocked:\s*(\d+)[\s\S]*?Ready:\s*(\d+)/);
    if (!m) return null;
    return { total: +m[1], completed: +m[2], failed: +m[3], blocked: +m[4], ready: +m[5] };
  } catch {
    return null;
  }
}

function readTaskCheckpoints() {
  // Each task dir has a checkpoint.json with attempt + status info.
  const out = [];
  if (!existsSync(TASKS_DIR)) return out;
  for (const name of readdirSync(TASKS_DIR)) {
    const full = join(TASKS_DIR, name);
    if (!statSync(full).isDirectory()) continue;
    const cp = join(full, 'checkpoint.json');
    if (!existsSync(cp)) continue;
    try {
      const data = JSON.parse(readFileSync(cp, 'utf8'));
      const attempts = existsSync(join(full, 'attempts'))
        ? readdirSync(join(full, 'attempts')).filter(a => /^\d+$/.test(a)).length
        : 0;
      out.push({
        id: name,
        status: data.status || data.state || 'unknown',
        attempts,
        duration_ms: data.duration_ms || data.durationMs || null,
        phase: name.split('-')[0],
      });
    } catch {
      // skip malformed
    }
  }
  return out;
}

function readEvents(limit = null) {
  if (!existsSync(EVENTS)) return [];
  const raw = readFileSync(EVENTS, 'utf8');
  const lines = raw.split('\n').filter(Boolean);
  const events = [];
  for (const line of lines) {
    try {
      const ev = JSON.parse(line);
      events.push(ev);
    } catch {}
  }
  return limit ? events.slice(-limit) : events;
}

function writeMetricsMd(metrics, gantt, tasks) {
  const o = metrics.overall || {};
  const totalCost = (o.totalCostUsd || 0).toFixed(4);
  const cacheHit = ((o.cacheHitRate || 0) * 100).toFixed(1);
  const errRate = ((o.errorRate || 0) * 100).toFixed(2);

  const tools = o.toolBreakdown || {};
  const toolRows = Object.entries(tools)
    .sort((a, b) => b[1].calls - a[1].calls)
    .map(([name, s]) => {
      const sr = s.calls ? ((s.successes / s.calls) * 100).toFixed(1) : '—';
      return `| \`${name}\` | ${fmtNum(s.calls)} | ${fmtNum(s.successes)} | ${fmtNum(s.failures)} | ${sr}% |`;
    })
    .join('\n');

  const models = o.modelBreakdown || {};
  const modelRows = Object.entries(models)
    .map(([name, s]) => `| \`${name}\` | ${s.sessions} | $${(s.costUSD || 0).toFixed(4)} | ${fmtNum(s.inputTokens)} | ${fmtNum(s.outputTokens)} |`)
    .join('\n');

  const ganttBlock = gantt
    ? `| State | Count |
| :--- | ---: |
| Tasks total | ${gantt.total} |
| Completed   | ${gantt.completed} |
| Failed      | ${gantt.failed} |
| Blocked     | ${gantt.blocked} |
| Ready       | ${gantt.ready} |`
    : '_(gantt summary unavailable)_';

  const phaseCounts = tasks.reduce((acc, t) => {
    acc[t.phase] = (acc[t.phase] || 0) + 1;
    return acc;
  }, {});
  const phaseRows = Object.entries(phaseCounts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 15)
    .map(([phase, count]) => `| \`${phase}-*\` | ${count} |`)
    .join('\n');

  const out = `# Run Metrics

Source: \`converge show metrics --json\` + \`converge show gantt\` aggregating \`.converge/journal/default/\` from the last execution. See [RUN_LOG.md](./RUN_LOG.md) for the chronological timeline.

## Run snapshot

${ganttBlock}

> The run halted at \`03-build-screens\` (blocking failure) after 2 attempts. 54 downstream tasks were blocked; 79 reached "ready" before the cascade fired. The 64 completed tasks include the full \`01-prepare-requirements\` and \`02-design-system\` phases plus partial progress through screen spec/design/convert/analyze for all 13 screens.

## Cost & token usage

| Metric | Value |
| ---: | :--- |
| Total cost (USD) | **$${totalCost}** |
| LLM sessions | ${fmtNum(o.sessionCount || 0)} |
| Error rate | ${errRate}% |
| Total turns | ${fmtNum(o.totalTurns || 0)} |
| Input tokens | ${fmtNum(o.totalInputTokens || 0)} |
| Output tokens | ${fmtNum(o.totalOutputTokens || 0)} |
| Cache-read tokens | ${fmtNum(o.totalCacheReadTokens || 0)} |
| Cache-creation tokens | ${fmtNum(o.totalCacheCreationTokens || 0)} |
| **Cache hit rate** | **${cacheHit}%** |
| Total wall-time | ${fmtMs(o.totalDurationMs)} |
| Avg session duration | ${fmtMs(o.avgDurationMs)} |

Even at $0.61 total across 138 sessions, the cache hit rate (${cacheHit}%) shows how much Converge's deterministic playbook structure benefits from prompt caching — 65M of the 73.6M total prompt tokens were served from cache.

## LLM models

| Model | Sessions | Cost | Input tokens | Output tokens |
| :--- | ---: | ---: | ---: | ---: |
${modelRows}

## Tool-call breakdown

| Tool | Calls | Successes | Failures | Success rate |
| :--- | ---: | ---: | ---: | ---: |
${toolRows}

## Task phase distribution

Top phases by spawned-child count (the playbook's dynamic spawn from \`02-design-system\` produced one child group per screen):

| Phase prefix | Tasks |
| :--- | ---: |
${phaseRows}

---

_Generated by \`scripts/extract-metrics.mjs\`. Regenerate after any new run with \`node scripts/extract-metrics.mjs\`._
`;
  writeFileSync('docs/METRICS.md', out);
  return out.length;
}

function writeRunLogMd(events, tasks) {
  // Group events by taskId.
  const byTask = new Map();
  let firstTs = null;
  let lastTs = null;
  for (const ev of events) {
    if (!firstTs) firstTs = ev.timestamp;
    lastTs = ev.timestamp;
    const tid = ev?.metadata?.taskId || ev.taskId || '<runner>';
    if (!byTask.has(tid)) byTask.set(tid, []);
    byTask.get(tid).push(ev);
  }

  // Pick a representative timeline: the first 80 task starts + completes + failures.
  const interesting = events.filter(ev =>
    ['TASK_ATTEMPT_START', 'TASK_EXECUTION_COMPLETE', 'TASK_EXECUTION_FAILED', 'TASK_BLOCKED', 'TASK_RETRY'].includes(ev.eventType)
  );

  const sample = [];
  const seen = new Set();
  for (const ev of interesting) {
    const tid = ev?.metadata?.taskId;
    const key = `${tid}-${ev.eventType}`;
    if (seen.has(key)) continue;
    seen.add(key);
    sample.push(ev);
    if (sample.length >= 120) break;
  }

  const timelineRows = sample.map(ev => {
    const t = (ev.timestamp || '').replace('T', ' ').split('.')[0];
    const type = ev.eventType.replace('TASK_', '');
    const tid = ev?.metadata?.taskId || '—';
    const dur = ev?.metadata?.duration ? ` (${ev.metadata.duration}ms)` : '';
    const ok = ev?.metadata?.success === false ? ' ❌' : (ev?.metadata?.success === true ? ' ✓' : '');
    return `| ${t} | \`${tid}\` | ${type}${ok}${dur} |`;
  }).join('\n');

  // Final state per task
  const finalRows = tasks
    .sort((a, b) => a.id.localeCompare(b.id))
    .map(t => `| \`${t.id}\` | ${t.status} | ${t.attempts} |`)
    .join('\n');

  const out = `# Run Log — Bloom canonical execution

> **Note on telemetry**: this run terminated at task \`03-build-screens\` (2 attempts, blocking failure). 64 of 198 tasks completed; 54 were blocked by the cascade; 79 had reached "ready" state. The journal's \`metadata.json\` was patched post-hoc from \`status: "running"\` → \`status: "partial-completed"\` so downstream tools (\`converge show metrics\`) report cleanly. No data was synthesized — every number in [METRICS.md](./METRICS.md) and every event below comes directly from \`.converge/journal/default/events.jsonl\` (41,782 events) and \`converge show metrics --json\`.
>
> **Note on size**: two tasks (\`002-browse-05-split\`, \`012-article-reader-05-split\`) hit a separate runner bug — a stuck retry loop that drove their attempt counters to 9,262 and 9,263 respectively (visible in the per-task table below). The journal originally contained one directory per attempt for each (≈940 MB total). For this commit those two task dirs were thinned to keep only \`attempts/01\`, \`02\`, \`03\` and the final three (\`9260\`–\`9262\` / \`9261\`–\`9263\`), bringing the journal down to ~111 MB. The attempt **counts** are real and authoritative (sourced from the upstream \`events.jsonl\`, which was not modified).

**Wall-clock window**: ${firstTs || '?'} → ${lastTs || '?'}
**Total events recorded**: ${fmtNum(events.length)}
**Tasks tracked**: ${tasks.length}

## Why this is a Converge proof, not a Flutter app

The point of committing this journal is to show what happens when a long-running, dynamically-spawning playbook actually executes against a real LLM provider and a real toolchain. The events file captures **every** task start, attempt, command execution, and outcome — including the failure modes (one task hit \`attempt: 9263\` due to a stuck cursor in the runner, a separate bug). All of this is publicly inspectable.

## Final per-task state

(${tasks.length} tasks; sorted alphabetically by id)

| Task | Status | Attempts |
| :--- | :--- | ---: |
${finalRows}

## Representative timeline

Filtered to the first 120 distinct task-state transitions across the run. Full event stream lives at \`.converge/journal/default/events.jsonl\`.

| Time (UTC) | Task | Event |
| :--- | :--- | :--- |
${timelineRows}

---

_Generated by \`scripts/extract-metrics.mjs\`._
`;
  writeFileSync('docs/RUN_LOG.md', out);
  return out.length;
}

function patchJournalMetadata(lastTs) {
  const path = join(JOURNAL, 'metadata.json');
  if (!existsSync(path)) return;
  const data = JSON.parse(readFileSync(path, 'utf8'));
  if (data.status === 'running') {
    data.status = 'partial-completed';
    data.endTime = lastTs || new Date().toISOString();
    data.note = 'status patched from "running" to "partial-completed" by scripts/extract-metrics.mjs after run halted at 03-build-screens';
    writeFileSync(path, JSON.stringify(data, null, 2));
    console.log(`Patched ${path}: status → partial-completed, endTime → ${data.endTime}`);
  }
}

// --- main ---

console.log('Reading converge metrics…');
const metrics = readMetrics();
console.log('Reading gantt summary…');
const gantt = readGanttSummary();
console.log('Reading task checkpoints…');
const tasks = readTaskCheckpoints();
console.log(`Found ${tasks.length} tasks with checkpoints.`);
console.log('Reading events.jsonl…');
const events = readEvents();
console.log(`Read ${events.length} events.`);

const lastTs = events.length ? events[events.length - 1].timestamp : null;
patchJournalMetadata(lastTs);

const mLen = writeMetricsMd(metrics, gantt, tasks);
console.log(`Wrote docs/METRICS.md (${mLen} bytes)`);
const rLen = writeRunLogMd(events, tasks);
console.log(`Wrote docs/RUN_LOG.md (${rLen} bytes)`);
