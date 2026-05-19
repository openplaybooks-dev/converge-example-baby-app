---
id: article-reader-split-003-RelatedArticleCard
title: "Split widget: RelatedArticleCard"
description: Extract RelatedArticleCard from Article Reader screen into its own file
inputs:
  - lib/screens/article_reader/article_reader_screen.dart
outputs:
  - lib/screens/article_reader/_widgets/RelatedArticleCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/article_reader/_widgets/RelatedArticleCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/article_reader/_widgets/RelatedArticleCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: article-reader
  screenTitle: Article Reader
  screenPath: lib/screens/article_reader/article_reader_screen.dart
  widgetId: RelatedArticleCard
  widgetName: RelatedArticleCard
  widgetFile: lib/screens/article_reader/_widgets/RelatedArticleCard.dart
---

# Split widget: RelatedArticleCard

Extract the `RelatedArticleCard` widget subtree from `lib/screens/article_reader/article_reader_screen.dart` into its own file at `lib/screens/article_reader/_widgets/RelatedArticleCard.dart`.

## Steps

1. **Read** — Load `lib/screens/article_reader/article_reader_screen.dart`.
2. **Locate** — Find the widget subtree implementing `RelatedArticleCard`. Use the description in `.stitch/designs/article-reader/widgets.jsonl` (the entry with `name == "RelatedArticleCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/article_reader/_widgets/RelatedArticleCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/article_reader/article_reader_screen.dart` with `const RelatedArticleCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/article_reader/_widgets/RelatedArticleCard.dart lib/screens/article_reader/article_reader_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
