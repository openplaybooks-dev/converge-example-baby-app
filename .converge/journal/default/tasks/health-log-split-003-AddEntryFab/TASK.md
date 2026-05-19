---
id: health-log-split-003-AddEntryFab
title: "Split widget: AddEntryFab"
description: Extract AddEntryFab from Health Log screen into its own file
inputs:
  - lib/screens/health_log/health_log_screen.dart
outputs:
  - lib/screens/health_log/_widgets/AddEntryFab.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/health_log/_widgets/AddEntryFab.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/health_log/_widgets/AddEntryFab.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: health-log
  screenTitle: Health Log
  screenPath: lib/screens/health_log/health_log_screen.dart
  widgetId: AddEntryFab
  widgetName: AddEntryFab
  widgetFile: lib/screens/health_log/_widgets/AddEntryFab.dart
---

# Split widget: AddEntryFab

Extract the `AddEntryFab` widget subtree from `lib/screens/health_log/health_log_screen.dart` into its own file at `lib/screens/health_log/_widgets/AddEntryFab.dart`.

## Steps

1. **Read** — Load `lib/screens/health_log/health_log_screen.dart`.
2. **Locate** — Find the widget subtree implementing `AddEntryFab`. Use the description in `.stitch/designs/health-log/widgets.jsonl` (the entry with `name == "AddEntryFab"`) to disambiguate.
3. **Create file** — Write `lib/screens/health_log/_widgets/AddEntryFab.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/health_log/health_log_screen.dart` with `const AddEntryFab()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/health_log/_widgets/AddEntryFab.dart lib/screens/health_log/health_log_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
