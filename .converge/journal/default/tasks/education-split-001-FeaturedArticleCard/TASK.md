---
id: education-split-001-FeaturedArticleCard
title: "Split widget: FeaturedArticleCard"
description: Extract FeaturedArticleCard from Education screen into its own file
inputs:
  - lib/screens/education/education_screen.dart
outputs:
  - lib/screens/education/_widgets/FeaturedArticleCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/education/_widgets/FeaturedArticleCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/education/_widgets/FeaturedArticleCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: education
  screenTitle: Education
  screenPath: lib/screens/education/education_screen.dart
  widgetId: FeaturedArticleCard
  widgetName: FeaturedArticleCard
  widgetFile: lib/screens/education/_widgets/FeaturedArticleCard.dart
---

# Split widget: FeaturedArticleCard

Extract the `FeaturedArticleCard` widget subtree from `lib/screens/education/education_screen.dart` into its own file at `lib/screens/education/_widgets/FeaturedArticleCard.dart`.

## Steps

1. **Read** — Load `lib/screens/education/education_screen.dart`.
2. **Locate** — Find the widget subtree implementing `FeaturedArticleCard`. Use the description in `.stitch/designs/education/widgets.jsonl` (the entry with `name == "FeaturedArticleCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/education/_widgets/FeaturedArticleCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/education/education_screen.dart` with `const FeaturedArticleCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/education/_widgets/FeaturedArticleCard.dart lib/screens/education/education_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
