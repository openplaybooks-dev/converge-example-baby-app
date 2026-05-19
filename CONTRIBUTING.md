# Contributing

This repo is a **frozen showcase** of one playbook run. Its purpose is to demonstrate the [Converge](https://github.com/openplaybooks-dev/converge) framework — autonomous, gated, dynamically-spawning playbooks — not to be an actively maintained Flutter app.

## What lives where

| Where | What | Edit it? |
| :--- | :--- | :--- |
| `idea.md`, `PRD.md`, `data-models.md`, `navigations.json` | Hand-authored inputs the playbook reads | yes, then rerun |
| `.converge/playbooks/default/`, `.converge/skills/` | The playbook contract + reusable skills | yes |
| `lib/`, `.stitch/`, `assets/illustrations/`, `test/` | Generated outputs from the last run | no — these are regenerated |
| `docs/METRICS.md`, `docs/RUN_LOG.md`, `docs/screenshots/` | Proof artifacts from the canonical run | regenerate via `scripts/extract-metrics.mjs` + `scripts/capture-screenshots.sh` |

## Where to send issues

- **Framework bugs** (runner crashes, journal corruption, goal-check semantics, skill dispatch): open them upstream at <https://github.com/openplaybooks-dev/converge>.
- **Playbook bugs** (a goal check that's too strict, a missing dependency in `playbook.yml`, a task body that drifts from the data-models contract): open them here.
- **Generated-code bugs** (the produced Flutter app fails to compile, an analyzer rule fires): also here — usually they point back to a missing assertion in the playbook.

## Re-running the playbook

```bash
cp .env.example .env             # fill in MINIMAX_API_KEY
./scripts/clean.sh               # wipe all generated outputs, keep inputs
IMAGE_BACKEND=stub ./scripts/run.sh   # free dry-run for CI
./scripts/run.sh                 # paid run (real SVGs, ~30–60 min, ≤$1 in MiniMax tokens)
```

After a run, refresh proof:

```bash
node scripts/extract-metrics.mjs       # → docs/METRICS.md, docs/RUN_LOG.md
./scripts/capture-screenshots.sh        # → docs/screenshots/*.png
```
