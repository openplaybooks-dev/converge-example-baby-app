---
name: metadata-generation
description: Emit a structured .meta.json sidecar next to a generated asset. Captures provenance (backend, model, seed), file shape (mime, bytes), and the Semantics label that should accompany the asset in a Flutter widget.
---

# metadata-generation

Write `<asset>.meta.json` so downstream wiring and a11y checks have a single source of truth for each asset.

## Inputs

- `outputPath` — the asset file just produced (e.g. `assets/icons/nav-home.svg`)
- `requirements.json` and `SPEC.md` from prior steps (for alt-text + palette)
- The backend's run output (seed, model, byte count) — read from the file the image backend already wrote, or recompute from the file on disk.

## Output

```json
{
  "id": "nav-home",
  "type": "icon",
  "backend": "minimax",
  "model": "image-01",
  "seed": 1234567,
  "bytes": 1284,
  "mime": "image/svg+xml",
  "dimensions": { "width": 24, "height": 24 },
  "alt_text": "Home navigation icon",
  "palette": ["#2A2A3A"]
}
```

## Rules

- File path is exactly `<outputPath>.meta.json` (sibling, not parent).
- `bytes` is the on-disk size of the asset file.
- `alt_text` comes from `requirements.alt_text` — don't invent one.
- If a sidecar already exists, merge: preserve `seed` and `model` from the existing file when re-running with the same backend.
