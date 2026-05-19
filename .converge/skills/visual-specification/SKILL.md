---
name: visual-specification
description: Translate an asset requirements.json into a human-readable SPEC.md detailed enough for an image-generation model to produce a faithful SVG on first try. Mandates hex palette values, viewBox dimensions, and concrete style notes — no ambiguous adjectives.
---

# visual-specification

Turn structured requirements into a generation-ready visual specification.

## Inputs

- `requirements.json` produced by `asset-requirements-analysis`
- `.stitch/system/DESIGN.md` for style language consistency

## Output

Write `SPEC.md` (path supplied by the caller) with these sections, in order:

```markdown
# Asset Specification: <assetId>

## Overview
One paragraph describing what this asset is and where it appears in the app.

## Visual Description
Concrete description of composition, subjects, arrangement, mood.
Each sentence should be falsifiable — "centred raspberry with two leaves on
the upper-left, light shadow below" beats "cute fruit illustration".

## Color Palette
- Background: #EDE8F7 (Lavender Mist)
- Primary subject: #F28B8B (Coral Bloom)
- Accent: #8B7ED8 (Lilac Pulse)
- Outline: #2A2A3A at 1.5px

## Dimensions
- ViewBox: 0 0 200 200
- Padding: 12% inset
- Stroke width: 1.5px (icons) / decorative only (illustrations)

## Style Notes
- Line weight, corner radius, fill style, shadow treatment.
- Single fill for icons; layered pastel for illustrations.
- No text, no logos, no photographic realism.

## Variants
- Light mode: as above
- Dark mode: invert outline to #FFFFFF, deepen primary subject by 10%
```

## Rules

- No ambiguous adjectives ("nice", "soft", "modern") without an objective qualifier next to them.
- Always include hex values, never just colour names.
- viewBox dimensions match `requirements.dimensions` exactly.
- The Visual Description must be self-contained — an image model with no other context should be able to produce a passing asset from it.
