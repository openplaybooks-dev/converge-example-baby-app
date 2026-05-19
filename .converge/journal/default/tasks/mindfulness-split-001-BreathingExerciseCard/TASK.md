---
id: mindfulness-split-001-BreathingExerciseCard
title: "Split widget: BreathingExerciseCard"
description: Extract BreathingExerciseCard from Mindfulness screen into its own file
inputs:
  - lib/screens/mindfulness/mindfulness_screen.dart
outputs:
  - lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: mindfulness
  screenTitle: Mindfulness
  screenPath: lib/screens/mindfulness/mindfulness_screen.dart
  widgetId: BreathingExerciseCard
  widgetName: BreathingExerciseCard
  widgetFile: lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart
---

# Split widget: BreathingExerciseCard

Extract the `BreathingExerciseCard` widget subtree from `lib/screens/mindfulness/mindfulness_screen.dart` into its own file at `lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart`.

## Steps

1. **Read** — Load `lib/screens/mindfulness/mindfulness_screen.dart`.
2. **Locate** — Find the widget subtree implementing `BreathingExerciseCard`. Use the description in `.stitch/designs/mindfulness/widgets.jsonl` (the entry with `name == "BreathingExerciseCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/mindfulness/mindfulness_screen.dart` with `const BreathingExerciseCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/mindfulness/_widgets/BreathingExerciseCard.dart lib/screens/mindfulness/mindfulness_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
