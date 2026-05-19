---
id: pregnancy-progress-split-004-SelfCareTipsCard
title: "Split widget: SelfCareTipsCard"
description: Extract SelfCareTipsCard from My Pregnancy screen into its own file
inputs:
  - lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
outputs:
  - lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: pregnancy-progress
  screenTitle: My Pregnancy
  screenPath: lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
  widgetId: SelfCareTipsCard
  widgetName: SelfCareTipsCard
  widgetFile: lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart
---

# Split widget: SelfCareTipsCard

Extract the `SelfCareTipsCard` widget subtree from `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` into its own file at `lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart`.

## Steps

1. **Read** — Load `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`.
2. **Locate** — Find the widget subtree implementing `SelfCareTipsCard`. Use the description in `.stitch/designs/pregnancy-progress/widgets.jsonl` (the entry with `name == "SelfCareTipsCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` with `const SelfCareTipsCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/pregnancy_progress/_widgets/SelfCareTipsCard.dart lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
