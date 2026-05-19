---
name: asset-requirements-analysis
description: Analyze a single asset slot and produce a structured requirements.json describing dimensions, palette, usage sites, and accessibility label. Driven from DESIGN.md plus the relevant Dart widget and data-model fields. Used as the discovery step of the 08-generate-assets pipeline.
---

# asset-requirements-analysis

Per-asset, write a `requirements.json` file that captures everything downstream steps need to know: dimensions, palette, usage sites, a11y label.

## Inputs

The task passes via vars:

- `assetId` — slug, e.g. `week-12`, `nav-home`, `empty-data`
- `assetType` — `illustration` | `icon` | `empty-state`
- `dimensionWidth`, `dimensionHeight`
- `assetDescription` — one-line description of subject matter

The skill reads from disk:

- `.stitch/system/DESIGN.md` for the color palette
- `lib/screens/**/*.dart` and `lib/widgets/**/*.dart` to find usage sites
- `lib/models/**/*.dart` for any field that names this asset (e.g. `WeekContent.sizeComparison`)

## Output

Write `requirements.json` (path supplied by the caller) with this shape:

```json
{
  "id": "<assetId>",
  "type": "illustration",
  "dimensions": { "width": 200, "height": 200 },
  "palette": ["#EDE8F7", "#F28B8B", "#8B7ED8", "#FFFFFF", "#2A2A3A"],
  "usage": [
    { "file": "lib/screens/pregnancy_progress/_widgets/hero_size_card.dart", "widget": "HeroSizeCard", "line": 42 }
  ],
  "model_field": "WeekContent.sizeComparison",
  "alt_text": "Baby is the size of a raspberry — week 7",
  "style_notes": "soft pastel, single subject, centred, gentle shadow"
}
```

## Rules

- Palette must be specific hex values from DESIGN.md, not vague names.
- `usage` lists every file that should consume the asset (used by `flutter-asset-integration` to swap in the SvgPicture widget).
- `alt_text` is the Semantics label — keep it under 80 chars and human-readable.
- If no usage site is found, list the intended widget by name with `line: null` so wiring can create it.
