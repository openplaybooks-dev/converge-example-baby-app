# Task: article-reader-split-001-QuoteCallout

# Split widget: QuoteCallout

Extract the `QuoteCallout` widget subtree from `lib/screens/article_reader/article_reader_screen.dart` into its own file at `lib/screens/article_reader/_widgets/QuoteCallout.dart`.

## Steps

1. **Read** — Load `lib/screens/article_reader/article_reader_screen.dart`.
2. **Locate** — Find the widget subtree implementing `QuoteCallout`. Use the description in `.stitch/designs/article-reader/widgets.jsonl` (the entry with `name == "QuoteCallout"`) to disambiguate.
3. **Create file** — Write `lib/screens/article_reader/_widgets/QuoteCallout.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/article_reader/article_reader_screen.dart` with `const QuoteCallout()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/article_reader/_widgets/QuoteCallout.dart lib/screens/article_reader/article_reader_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.