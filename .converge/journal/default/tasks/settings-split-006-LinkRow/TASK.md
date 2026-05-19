---
id: settings-split-006-LinkRow
title: "Split widget: LinkRow"
description: Extract LinkRow from Settings screen into its own file
inputs:
  - lib/screens/settings/settings_screen.dart
outputs:
  - lib/screens/settings/_widgets/LinkRow.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/settings/_widgets/LinkRow.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/settings/_widgets/LinkRow.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: settings
  screenTitle: Settings
  screenPath: lib/screens/settings/settings_screen.dart
  widgetId: LinkRow
  widgetName: LinkRow
  widgetFile: lib/screens/settings/_widgets/LinkRow.dart
---

# Split widget: LinkRow

Extract the `LinkRow` widget subtree from `lib/screens/settings/settings_screen.dart` into its own file at `lib/screens/settings/_widgets/LinkRow.dart`.

## Steps

1. **Read** — Load `lib/screens/settings/settings_screen.dart`.
2. **Locate** — Find the widget subtree implementing `LinkRow`. Use the description in `.stitch/designs/settings/widgets.jsonl` (the entry with `name == "LinkRow"`) to disambiguate.
3. **Create file** — Write `lib/screens/settings/_widgets/LinkRow.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/settings/settings_screen.dart` with `const LinkRow()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/settings/_widgets/LinkRow.dart lib/screens/settings/settings_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
