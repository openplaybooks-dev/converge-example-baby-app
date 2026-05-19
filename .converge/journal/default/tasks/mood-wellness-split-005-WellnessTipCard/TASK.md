---
id: mood-wellness-split-005-WellnessTipCard
title: "Split widget: WellnessTipCard"
description: Extract WellnessTipCard from Mood & Wellness screen into its own file
inputs:
  - lib/screens/mood_wellness/mood_wellness_screen.dart
outputs:
  - lib/screens/mood_wellness/_widgets/WellnessTipCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/mood_wellness/_widgets/WellnessTipCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/mood_wellness/_widgets/WellnessTipCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: mood-wellness
  screenTitle: Mood & Wellness
  screenPath: lib/screens/mood_wellness/mood_wellness_screen.dart
  widgetId: WellnessTipCard
  widgetName: WellnessTipCard
  widgetFile: lib/screens/mood_wellness/_widgets/WellnessTipCard.dart
---

# Split widget: WellnessTipCard

Extract the `WellnessTipCard` widget subtree from `lib/screens/mood_wellness/mood_wellness_screen.dart` into its own file at `lib/screens/mood_wellness/_widgets/WellnessTipCard.dart`.

## Steps

1. **Read** — Load `lib/screens/mood_wellness/mood_wellness_screen.dart`.
2. **Locate** — Find the widget subtree implementing `WellnessTipCard`. Use the description in `.stitch/designs/mood-wellness/widgets.jsonl` (the entry with `name == "WellnessTipCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/mood_wellness/_widgets/WellnessTipCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/mood_wellness/mood_wellness_screen.dart` with `const WellnessTipCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/mood_wellness/_widgets/WellnessTipCard.dart lib/screens/mood_wellness/mood_wellness_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
