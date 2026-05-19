---
id: mood-wellness-split-002-MoodEmoji
title: "Split widget: MoodEmoji"
description: Extract MoodEmoji from Mood & Wellness screen into its own file
inputs:
  - lib/screens/mood_wellness/mood_wellness_screen.dart
outputs:
  - lib/screens/mood_wellness/_widgets/MoodEmoji.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/mood_wellness/_widgets/MoodEmoji.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/mood_wellness/_widgets/MoodEmoji.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: mood-wellness
  screenTitle: Mood & Wellness
  screenPath: lib/screens/mood_wellness/mood_wellness_screen.dart
  widgetId: MoodEmoji
  widgetName: MoodEmoji
  widgetFile: lib/screens/mood_wellness/_widgets/MoodEmoji.dart
---

# Split widget: MoodEmoji

Extract the `MoodEmoji` widget subtree from `lib/screens/mood_wellness/mood_wellness_screen.dart` into its own file at `lib/screens/mood_wellness/_widgets/MoodEmoji.dart`.

## Steps

1. **Read** — Load `lib/screens/mood_wellness/mood_wellness_screen.dart`.
2. **Locate** — Find the widget subtree implementing `MoodEmoji`. Use the description in `.stitch/designs/mood-wellness/widgets.jsonl` (the entry with `name == "MoodEmoji"`) to disambiguate.
3. **Create file** — Write `lib/screens/mood_wellness/_widgets/MoodEmoji.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/mood_wellness/mood_wellness_screen.dart` with `const MoodEmoji()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/mood_wellness/_widgets/MoodEmoji.dart lib/screens/mood_wellness/mood_wellness_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
