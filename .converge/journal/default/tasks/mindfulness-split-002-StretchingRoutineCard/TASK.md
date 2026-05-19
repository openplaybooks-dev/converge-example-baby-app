---
id: mindfulness-split-002-StretchingRoutineCard
title: "Split widget: StretchingRoutineCard"
description: Extract StretchingRoutineCard from Mindfulness screen into its own file
inputs:
  - lib/screens/mindfulness/mindfulness_screen.dart
outputs:
  - lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: mindfulness
  screenTitle: Mindfulness
  screenPath: lib/screens/mindfulness/mindfulness_screen.dart
  widgetId: StretchingRoutineCard
  widgetName: StretchingRoutineCard
  widgetFile: lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart
---

# Split widget: StretchingRoutineCard

Extract the `StretchingRoutineCard` widget subtree from `lib/screens/mindfulness/mindfulness_screen.dart` into its own file at `lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart`.

## Steps

1. **Read** — Load `lib/screens/mindfulness/mindfulness_screen.dart`.
2. **Locate** — Find the widget subtree implementing `StretchingRoutineCard`. Use the description in `.stitch/designs/mindfulness/widgets.jsonl` (the entry with `name == "StretchingRoutineCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/mindfulness/mindfulness_screen.dart` with `const StretchingRoutineCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/mindfulness/_widgets/StretchingRoutineCard.dart lib/screens/mindfulness/mindfulness_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
