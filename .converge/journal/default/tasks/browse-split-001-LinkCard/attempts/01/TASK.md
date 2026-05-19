# Task: browse-split-001-LinkCard

# Split widget: LinkCard

Extract the `LinkCard` widget subtree from `lib/screens/browse/browse_screen.dart` into its own file at `lib/screens/browse/_widgets/LinkCard.dart`.

## Steps

1. **Read** — Load `lib/screens/browse/browse_screen.dart`.
2. **Locate** — Find the widget subtree implementing `LinkCard`. Use the description in `.stitch/designs/browse/widgets.jsonl` (the entry with `name == "LinkCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/browse/_widgets/LinkCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/browse/browse_screen.dart` with `const LinkCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/browse/_widgets/LinkCard.dart lib/screens/browse/browse_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.