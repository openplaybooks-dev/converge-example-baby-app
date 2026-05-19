# Plan: Analyze: Weight & Nutrition



Looking at the screen file, I can identify the widget subtrees and evaluate the existing `widgets.jsonl`.

### Widget Subtrees Analysis

| Widget | Lines | Type | Covered? |
|--------|-------|------|----------|
| `_WeightProgressChart` | ~80 | StatefulWidget | ✓ WeightProgressChart |
| `_ChartPainter` | ~70 | CustomPainter | ✗ Missing |
| `_LatestEntryCard` | ~71 | StatelessWidget | ✓ LatestEntryCard |
| `_NutritionTipsCard` | ~79 | StatelessWidget | ✓ NutritionTipsCard |
| `_WeightLogSection` | ~32 | StatelessWidget | ✓ WeightLogList |
| `_WeightLogItem` | ~98 | StatelessWidget | ✓ WeightLogItem |
| `_AddWeightBottomSheet` | ~211 | StatefulWidget | ✓ AddWeightSheet |
| `_EntryDetailBottomSheet` | ~140 | StatelessWidget | ✓ EntryDetailSheet |

### Gap Found

The `_ChartPainter` (lines 164-234) is a 70-line `CustomPainter` responsible for rendering the weight progress chart. It has significant logic:
- Grid line rendering
- Fill path construction with gradient
- Line path drawing with rounded caps
- Data point dots

This is NOT captured in the existing `widgets.jsonl`. It could be extracted as:

```jsonl
{"name": "WeightChartPainter", "grep": "_ChartPainter", "description": "Custom painter that draws the weight progress line chart with fill gradient, dots, and grid", "shared": false}
```

### Evaluation of Existing Entries

The existing 13 entries are well-structured and cover all the major widget subtrees. Each entry:
- Uses PascalCase naming
- Has a unique `grep` string
- Has a descriptive `description`
- Correctly identifies `shared: true` for potentially reusable components (chips, indicators, input fields)

### Success Criteria Check

- ✅ `.stitch/designs/weight-nutrition/widgets.jsonl` exists with valid JSONL
- ✅ Each entry has: name, grep, description, shared
- ✅ Widget names use PascalCase

### Recommended Addition

The **only gap** is `_ChartPainter`. However, this is a `CustomPainter` rather than a standard widget subtree. If your extraction criteria focuses on widget subtrees (not painters), the existing coverage is complete. If you want to extract the painter as well, add the entry noted above.

### Critical Files for Implementation

1. **`lib/screens/weight_nutrition/weight_nutrition_screen.dart`** — Source file with all widget implementations
2. **`.stitch/designs/weight-nutrition/widgets.jsonl`** — Existing widget registry (needs `_ChartPainter` added if desired)
3. **`lib/theme/app_theme.dart`** — Theme constants used by widgets
4. **`.stitch/designs/home/widgets.jsonl`** — Reference pattern for comparison