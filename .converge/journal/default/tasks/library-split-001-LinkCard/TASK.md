---
id: library-split-001-LinkCard
title: "Split widget: LinkCard"
description: Extract LinkCard from Library screen into its own file
inputs:
  - lib/screens/library/library_screen.dart
outputs:
  - lib/screens/library/_widgets/LinkCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/library/_widgets/LinkCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/library/_widgets/LinkCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: library
  screenTitle: Library
  screenPath: lib/screens/library/library_screen.dart
  widgetId: LinkCard
  widgetName: LinkCard
  widgetFile: lib/screens/library/_widgets/LinkCard.dart
---

# Split widget: LinkCard

Extract the `LinkCard` widget subtree from `lib/screens/library/library_screen.dart` into its own file at `lib/screens/library/_widgets/LinkCard.dart`.

## Steps

1. **Read** — Load `lib/screens/library/library_screen.dart`.
2. **Locate** — Find the widget subtree implementing `LinkCard`. Use the description in `.stitch/designs/library/widgets.jsonl` (the entry with `name == "LinkCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/library/_widgets/LinkCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/library/library_screen.dart` with `const LinkCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/library/_widgets/LinkCard.dart lib/screens/library/library_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
