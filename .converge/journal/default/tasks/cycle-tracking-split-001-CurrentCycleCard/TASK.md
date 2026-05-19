---
id: cycle-tracking-split-001-CurrentCycleCard
title: "Split widget: CurrentCycleCard"
description: Extract CurrentCycleCard from Cycle Tracking screen into its own file
inputs:
  - lib/screens/cycle_tracking/cycle_tracking_screen.dart
outputs:
  - lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: cycle-tracking
  screenTitle: Cycle Tracking
  screenPath: lib/screens/cycle_tracking/cycle_tracking_screen.dart
  widgetId: CurrentCycleCard
  widgetName: CurrentCycleCard
  widgetFile: lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart
---

# Split widget: CurrentCycleCard

Extract the `CurrentCycleCard` widget subtree from `lib/screens/cycle_tracking/cycle_tracking_screen.dart` into its own file at `lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart`.

## Steps

1. **Read** — Load `lib/screens/cycle_tracking/cycle_tracking_screen.dart`.
2. **Locate** — Find the widget subtree implementing `CurrentCycleCard`. Use the description in `.stitch/designs/cycle-tracking/widgets.jsonl` (the entry with `name == "CurrentCycleCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/cycle_tracking/cycle_tracking_screen.dart` with `const CurrentCycleCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/cycle_tracking/_widgets/CurrentCycleCard.dart lib/screens/cycle_tracking/cycle_tracking_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
