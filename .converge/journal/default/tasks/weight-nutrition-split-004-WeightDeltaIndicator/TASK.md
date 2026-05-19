---
id: weight-nutrition-split-004-WeightDeltaIndicator
title: "Split widget: WeightDeltaIndicator"
description: Extract WeightDeltaIndicator from Weight & Nutrition screen into its own file
inputs:
  - lib/screens/weight_nutrition/weight_nutrition_screen.dart
outputs:
  - lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: weight-nutrition
  screenTitle: Weight & Nutrition
  screenPath: lib/screens/weight_nutrition/weight_nutrition_screen.dart
  widgetId: WeightDeltaIndicator
  widgetName: WeightDeltaIndicator
  widgetFile: lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart
---

# Split widget: WeightDeltaIndicator

Extract the `WeightDeltaIndicator` widget subtree from `lib/screens/weight_nutrition/weight_nutrition_screen.dart` into its own file at `lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart`.

## Steps

1. **Read** — Load `lib/screens/weight_nutrition/weight_nutrition_screen.dart`.
2. **Locate** — Find the widget subtree implementing `WeightDeltaIndicator`. Use the description in `.stitch/designs/weight-nutrition/widgets.jsonl` (the entry with `name == "WeightDeltaIndicator"`) to disambiguate.
3. **Create file** — Write `lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/weight_nutrition/weight_nutrition_screen.dart` with `const WeightDeltaIndicator()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/weight_nutrition/_widgets/WeightDeltaIndicator.dart lib/screens/weight_nutrition/weight_nutrition_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
