---
id: pregnancy-progress-split-006-DueDateSummaryCard
title: "Split widget: DueDateSummaryCard"
description: Extract DueDateSummaryCard from My Pregnancy screen into its own file
inputs:
  - lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
outputs:
  - lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: pregnancy-progress
  screenTitle: My Pregnancy
  screenPath: lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
  widgetId: DueDateSummaryCard
  widgetName: DueDateSummaryCard
  widgetFile: lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart
---

# Split widget: DueDateSummaryCard

Extract the `DueDateSummaryCard` widget subtree from `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` into its own file at `lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart`.

## Steps

1. **Read** — Load `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`.
2. **Locate** — Find the widget subtree implementing `DueDateSummaryCard`. Use the description in `.stitch/designs/pregnancy-progress/widgets.jsonl` (the entry with `name == "DueDateSummaryCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` with `const DueDateSummaryCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/pregnancy_progress/_widgets/DueDateSummaryCard.dart lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
