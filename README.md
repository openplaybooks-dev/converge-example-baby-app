# Bloom — a Flutter pregnancy companion, generated end-to-end by Converge

[![smoke](https://github.com/minhlucvan/converge-example-baby-app/actions/workflows/smoke.yml/badge.svg)](https://github.com/minhlucvan/converge-example-baby-app/actions/workflows/smoke.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

A **[Converge](https://github.com/openplaybooks/converge)** showcase. Edit `idea.md`, run one script, and the playbook produces a Flutter app: **13 screens**, Riverpod state, GoRouter navigation, generated SVG illustrations, widget tests — all gated by real toolchain checks (`flutter pub get`, `dart analyze`, `flutter build`, `flutter test`).

## What this demonstrates

- **Dynamic spawn from manifests** — `02-design-system` produces a screen list at runtime; downstream tasks emit `converge spawn template …` per screen / overlay / asset / test. No hand-written copies of the per-screen work.
- **A real DAG with real failures** — this repo ships the actual journal from a long-running execution that **halted at task `03-build-screens`** (blocking failure cascaded to 54 downstream tasks). The artifact is published as-is so you can study Converge under partial-failure conditions, not just on a green-field happy path. See [`docs/RUN_LOG.md`](./docs/RUN_LOG.md).
- **Goal gates that mean something** — the playbook only converges when `flutter build apk --debug` succeeds, `dart analyze` is clean, no `onPressed: null` survives, no `Lorem|TODO|FIXME` lingers, and every `navigations.json` element reports `status: wired`.
- **Swappable image backend** — `svg-illustration-generation` skill ships a MiniMax primary and a stub for CI; switch via `backends/ACTIVE` or `IMAGE_BACKEND` env var.

## Screenshots (generated app, captured from `flutter build web`)

| | | | |
| :-: | :-: | :-: | :-: |
| ![Home](./docs/screenshots/01-home.png) | ![Pregnancy progress](./docs/screenshots/07-pregnancy-progress.png) | ![Weight & nutrition](./docs/screenshots/06-weight-nutrition.png) | ![Article reader](./docs/screenshots/12-article-reader.png) |
| Home (week tracker, mood, checklist) | Pregnancy progress (week N detail) | Weight & nutrition (chart) | Article reader |

<details>
<summary><b>All 13 screens →</b></summary>

| Route | Screen |
| :--- | :--- |
| [`/`](./docs/screenshots/01-home.png)                                       | Home |
| [`/browse`](./docs/screenshots/02-browse.png)                               | Browse |
| [`/library`](./docs/screenshots/03-library.png)                             | Library |
| [`/profile`](./docs/screenshots/04-profile.png)                             | Profile |
| [`/cycle-tracking`](./docs/screenshots/05-cycle-tracking.png)               | Cycle tracking |
| [`/weight-nutrition`](./docs/screenshots/06-weight-nutrition.png)           | Weight & nutrition |
| [`/pregnancy-progress`](./docs/screenshots/07-pregnancy-progress.png)       | Pregnancy progress |
| [`/mindfulness`](./docs/screenshots/08-mindfulness.png)                     | Mindfulness |
| [`/health-log`](./docs/screenshots/09-health-log.png)                       | Health log |
| [`/mood-wellness`](./docs/screenshots/10-mood-wellness.png)                 | Mood & wellness |
| [`/education`](./docs/screenshots/11-education.png)                         | Education |
| [`/article-reader/:id`](./docs/screenshots/12-article-reader.png)           | Article reader |
| [`/settings`](./docs/screenshots/13-settings.png)                           | Settings |

See [`docs/screenshots/README.md`](./docs/screenshots/README.md) for the capture method.
</details>

## Run results

This repo ships the **journal from one real execution against MiniMax-M2.7** so you can audit what Converge actually did — not a sanitized walkthrough.

| Number | Value |
| ---: | :--- |
| **LLM cost** | **$0.6133 USD** (138 sessions, MiniMax-M2.7) |
| Total tokens | 8.5M input / 622K output / **65M cache-read** (88.0% cache hit rate) |
| Wall-time | 4.22 h |
| Tasks total | 198 (64 completed, 1 failed, 54 blocked by the failure, 79 ready) |
| Tool calls | 2,514 (Read / Bash / Glob / Edit / Write / Grep / Skill / TaskUpdate) |
| Events recorded | 41,782 |

Full breakdown in **[docs/METRICS.md](./docs/METRICS.md)** and a chronological timeline in **[docs/RUN_LOG.md](./docs/RUN_LOG.md)**.

### About the partial run

The execution halted at task `03-build-screens` after 2 attempts (a blocking failure that cascaded to 54 downstream tasks). What's committed here:

| Phase | Status | Output |
| :--- | :--- | :--- |
| `01-prepare-requirements` | ✓ complete | `.stitch/UX.md`, `.stitch/SITE.md`, `.stitch/screens.json`, refined `PRD.md` |
| `02-design-system` | ✓ complete | `lib/theme/app_theme.dart`, design tokens |
| `03-build-screens` | ✗ blocking failure (2 attempts) | partial `lib/screens/*` (13 screen scaffolds via per-screen spec/design/convert/analyze sub-tasks) |
| `05-add-behavior` → `09-generate-tests` | ⊘ blocked by `03` | not executed |

To smoke-test the full DAG end-to-end with no API cost, run with the stub image backend (`IMAGE_BACKEND=stub ./scripts/run.sh`) — the CI workflow does exactly that.

## Prerequisites

| Tool | Why |
| :--- | :--- |
| Flutter SDK 3.41+ | `flutter pub get`, `dart analyze`, `flutter build apk --debug`, `flutter test` |
| `converge` CLI | playbook execution (`npm i -g @openplaybooks/converge`) |
| `jq` | task bodies parse `.stitch/screens.json` |
| Android SDK + cmdline-tools | required only for `flutter build apk --debug` |

Environment (see [`.env.example`](./.env.example)):

| Variable | Required | Purpose |
| :--- | :--- | :--- |
| `MINIMAX_API_KEY` | yes (any backend; the LLM provider needs it) | LLM provider auth |
| `MINIMAX_IMAGE_ENDPOINT` | yes when `IMAGE_BACKEND=minimax` | URL of the MiniMax text-to-image endpoint |
| `MINIMAX_IMAGE_MODEL` | no | image model id, defaults to `image-01` |
| `IMAGE_BACKEND` | no | `minimax` (default) or `stub` |

## Quick start

```bash
cp .env.example .env
$EDITOR .env                        # fill in MINIMAX_API_KEY
./scripts/clean.sh                  # wipe generated artifacts; keep inputs
./scripts/run.sh                    # ~30–60 min end-to-end (paid)
```

For a free smoke test (no image API spend) use the stub backend:

```bash
IMAGE_BACKEND=stub ./scripts/clean.sh && ./scripts/run.sh
```

After a run, refresh proof artifacts:

```bash
node scripts/extract-metrics.mjs        # → docs/METRICS.md + docs/RUN_LOG.md
./scripts/capture-screenshots.sh         # → docs/screenshots/*.png
```

## Inputs → outputs

| Input (hand-authored, kept across runs) | Drives | Output (generated) |
| :--- | :--- | :--- |
| `idea.md` | task 01 | `.stitch/UX.md`, `.stitch/SITE.md`, `.stitch/screens.json`, refined `PRD.md` |
| `PRD.md` | task 01 | (refinement target) |
| `data-models.md` | task 05 | `lib/models/*.dart` (Freezed), `lib/data/mock_data.dart` |
| `navigations.json` | task 06 | per-screen onPressed wiring + `lib/router/app_router.dart` |
| `pubspec.yaml` | always | dependency tree + asset declarations |
| `assets/assets.json` | task 08 | manifest reference (categories + counts) |

Every output is regenerated by `./scripts/clean.sh && ./scripts/run.sh`. Inputs are kept.

## DAG at a glance

```
01-prepare-requirements → 02-design-system → 03-build-screens ✗  ←  (run halted here)
                                                                   │
                          (would have continued: ────────────────  ▼
                          05-add-behavior → 06-wire-screens → 07-build-overlays →
                          08-generate-assets → 09-generate-tests)
```

Task IDs skip `04` — historical (an "i18n" phase that was dropped). Numbering is preserved so journals from older runs still align.

## Customization

- **Change the app idea**: edit `idea.md`. The playbook re-derives PRD → UX → screens → code on next run.
- **Change the asset catalog**: edit the inline arrays in `.converge/playbooks/default/tasks/08-generate-assets/TASK.md` (40 weeks, 5 empty states, 15 icons). Counts in `playbook.yml`'s `assets-generated` goal must match.
- **Swap image backend**: edit `.converge/skills/svg-illustration-generation/backends/ACTIVE` (one line: `minimax` or `stub`), or set `IMAGE_BACKEND=…` per invocation. Add a new backend by dropping a `backends/<name>/generate.js` file that exports a default function matching the contract in `SKILL.md`.
- **Bump the LLM model**: edit `.converge/project.yml`. Defaults to `MiniMax-M2.7` via the Anthropic-compat endpoint.

## Troubleshooting

| Symptom | Cause | Fix |
| :--- | :--- | :--- |
| `MINIMAX_API_KEY must be exported` | env not set | `cp .env.example .env && $EDITOR .env` before `./scripts/run.sh` |
| Task 08 fails immediately with "MINIMAX_IMAGE_ENDPOINT is not set" | minimax backend can't reach API | export the endpoint or set `IMAGE_BACKEND=stub` |
| `flutter run -d ios` "Unable to find a destination matching" | Xcode and iOS Simulator SDKs out of sync | use web (`flutter run -d chrome`) or install the matching iOS runtime via Xcode → Settings → Components |
| `flutter build apk --debug` fails with Android SDK error | cmdline-tools missing | `sdkmanager "platform-tools" "build-tools;34.0.0" "platforms;android-34"` |
| `flutter test` fails on first run after rebuild | stale `.dart_tool/` | `./scripts/clean.sh` then re-run |

## Repository layout

```
baby-app/
├── idea.md, PRD.md, data-models.md, navigations.json   ← inputs (hand-authored)
├── pubspec.yaml, analysis_options.yaml                  ← Flutter config (inputs)
├── assets/assets.json                                   ← asset manifest reference
├── scripts/
│   ├── clean.sh, run.sh                                 ← playbook entry points
│   ├── extract-metrics.mjs                              ← journal → docs/METRICS.md, docs/RUN_LOG.md
│   └── capture-screenshots.sh                           ← Flutter web → docs/screenshots/*.png
├── .converge/
│   ├── project.yml                                      ← provider config (MiniMax-M2.7)
│   ├── playbooks/default/
│   │   ├── playbook.yml                                 ← task DAG + goal checks
│   │   ├── tasks/{01..09}/TASK.md                       ← per-epic contracts
│   │   └── templates/<id>/TASK.md                       ← spawn templates (screen-*, overlay-*, asset-*, test-*)
│   ├── skills/                                          ← 26 reusable skills (svg-illustration-generation, flutter-*, etc.)
│   └── journal/default/                                 ← committed: real run telemetry
├── docs/
│   ├── METRICS.md, RUN_LOG.md                           ← extracted from journal
│   └── screenshots/                                     ← 13 PNGs, one per route
└── (generated) lib/, .stitch/, assets/illustrations/, test/
```

## License

[MIT](./LICENSE) © 2026 Minh Luc

Built with [Converge](https://github.com/openplaybooks/converge).
