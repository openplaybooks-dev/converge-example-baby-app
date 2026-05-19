---
id: mindfulness-split-003-ExerciseBadge
title: "Split widget: ExerciseBadge"
description: Extract ExerciseBadge from Mindfulness screen into its own file
inputs:
  - lib/screens/mindfulness/mindfulness_screen.dart
outputs:
  - lib/screens/mindfulness/_widgets/ExerciseBadge.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/mindfulness/_widgets/ExerciseBadge.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/mindfulness/_widgets/ExerciseBadge.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: mindfulness
  screenTitle: Mindfulness
  screenPath: lib/screens/mindfulness/mindfulness_screen.dart
  widgetId: ExerciseBadge
  widgetName: ExerciseBadge
  widgetFile: lib/screens/mindfulness/_widgets/ExerciseBadge.dart
---

# Split widget: ExerciseBadge

Extract the `ExerciseBadge` widget subtree from `lib/screens/mindfulness/mindfulness_screen.dart` into its own file at `lib/screens/mindfulness/_widgets/ExerciseBadge.dart`.

## Steps

1. **Read** — Load `lib/screens/mindfulness/mindfulness_screen.dart`.
2. **Locate** — Find the widget subtree implementing `ExerciseBadge`. Use the description in `.stitch/designs/mindfulness/widgets.jsonl` (the entry with `name == "ExerciseBadge"`) to disambiguate.
3. **Create file** — Write `lib/screens/mindfulness/_widgets/ExerciseBadge.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/mindfulness/mindfulness_screen.dart` with `const ExerciseBadge()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/mindfulness/_widgets/ExerciseBadge.dart lib/screens/mindfulness/mindfulness_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
