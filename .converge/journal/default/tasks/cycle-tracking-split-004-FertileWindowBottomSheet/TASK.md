---
id: cycle-tracking-split-004-FertileWindowBottomSheet
title: "Split widget: FertileWindowBottomSheet"
description: Extract FertileWindowBottomSheet from Cycle Tracking screen into its own file
inputs:
  - lib/screens/cycle_tracking/cycle_tracking_screen.dart
outputs:
  - lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: cycle-tracking
  screenTitle: Cycle Tracking
  screenPath: lib/screens/cycle_tracking/cycle_tracking_screen.dart
  widgetId: FertileWindowBottomSheet
  widgetName: FertileWindowBottomSheet
  widgetFile: lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart
---

# Split widget: FertileWindowBottomSheet

Extract the `FertileWindowBottomSheet` widget subtree from `lib/screens/cycle_tracking/cycle_tracking_screen.dart` into its own file at `lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart`.

## Steps

1. **Read** — Load `lib/screens/cycle_tracking/cycle_tracking_screen.dart`.
2. **Locate** — Find the widget subtree implementing `FertileWindowBottomSheet`. Use the description in `.stitch/designs/cycle-tracking/widgets.jsonl` (the entry with `name == "FertileWindowBottomSheet"`) to disambiguate.
3. **Create file** — Write `lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/cycle_tracking/cycle_tracking_screen.dart` with `const FertileWindowBottomSheet()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/cycle_tracking/_widgets/FertileWindowBottomSheet.dart lib/screens/cycle_tracking/cycle_tracking_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
