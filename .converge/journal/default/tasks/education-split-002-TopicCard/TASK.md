---
id: education-split-002-TopicCard
title: "Split widget: TopicCard"
description: Extract TopicCard from Education screen into its own file
inputs:
  - lib/screens/education/education_screen.dart
outputs:
  - lib/screens/education/_widgets/TopicCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/education/_widgets/TopicCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/education/_widgets/TopicCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: education
  screenTitle: Education
  screenPath: lib/screens/education/education_screen.dart
  widgetId: TopicCard
  widgetName: TopicCard
  widgetFile: lib/screens/education/_widgets/TopicCard.dart
---

# Split widget: TopicCard

Extract the `TopicCard` widget subtree from `lib/screens/education/education_screen.dart` into its own file at `lib/screens/education/_widgets/TopicCard.dart`.

## Steps

1. **Read** — Load `lib/screens/education/education_screen.dart`.
2. **Locate** — Find the widget subtree implementing `TopicCard`. Use the description in `.stitch/designs/education/widgets.jsonl` (the entry with `name == "TopicCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/education/_widgets/TopicCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/education/education_screen.dart` with `const TopicCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/education/_widgets/TopicCard.dart lib/screens/education/education_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
