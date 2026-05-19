---
title: "Generate — {{assetType}}: {{assetName}}"
description: Generate the actual asset file via the swappable image-generation backend
skill: svg-illustration-generation
blocking: true
tags:
  - asset
  - generate
  - "{{assetType}}"
vars:
  assetId:
  assetType:
  assetName:
  format:
  dimensionWidth:
  dimensionHeight:
  outputPath:
  specPath:
inputs:
  - "{{specPath}}"
  - .stitch/system/DESIGN.md
outputs:
  - "{{outputPath}}"
checks:
  - id: asset-exists
    cmd: "test -f {{outputPath}}"
    description: Asset file was generated
  - id: asset-is-svg
    cmd: "head -5 '{{outputPath}}' | grep -q '<svg'"
    description: Output is a valid SVG document
  - id: asset-size-reasonable
    cmd: "stat -f%z '{{outputPath}}' 2>/dev/null | awk '{if ($1 > 100 && $1 < 500000) exit 0; exit 1}'"
    description: Asset file size is reasonable (not empty, not huge)
  - id: meta-sidecar-exists
    cmd: "test -f '{{outputPath}}.meta.json'"
    description: Sidecar metadata was written by the backend
---

# Generate Asset

Generate the asset file at `{{outputPath}}` using the **svg-illustration-generation** skill. The skill dispatches to the backend selected by `.converge/skills/svg-illustration-generation/backends/ACTIVE` (default `minimax`), overridable via the `IMAGE_BACKEND` env var.

## Inputs

- `{{specPath}}` — visual specification (composition, palette, style, dimensions)
- `.stitch/system/DESIGN.md` — design system reference (color tokens, motion, density)

## Steps

1. **Read the spec** — load `{{specPath}}`.
2. **Compose the prompt** — combine the spec's Visual Description + Color Palette + Style Notes into a single text prompt. Include the design system palette as hex codes.
3. **Invoke the backend** — run the skill's dispatcher (`backends/<ACTIVE>/generate.js`) with this JSON on stdin:
   ```json
   {
     "prompt": "<composed prompt>",
     "output_path": "{{outputPath}}",
     "dimensions": { "width": {{dimensionWidth}}, "height": {{dimensionHeight}} },
     "asset_type": "{{assetType}}",
     "palette": ["#EDE8F7", "#F28B8B", "#8B7ED8", "#FFFFFF", "#2A2A3A"],
     "references": []
   }
   ```
4. **Verify** — the backend must write both `{{outputPath}}` (valid SVG) and `{{outputPath}}.meta.json` (backend, model, size, seed).

## Requirements

- Output is an SVG 1.1+ document at `{{dimensionWidth}}×{{dimensionHeight}}` viewBox.
- No external dependencies (no linked images, no remote fonts).
- Single fill colour for icons (24×24, 1.5px stroke); pastel palette for illustrations.
- Optimised for file size (under 500 KB).

If the backend errors, surface the error message verbatim — don't silently fall back. The orchestrator will retry.
