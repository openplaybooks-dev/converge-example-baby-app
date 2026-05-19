---
id: settings-split-001-SettingsCard
title: "Split widget: SettingsCard"
description: Extract SettingsCard from Settings screen into its own file
inputs:
  - lib/screens/settings/settings_screen.dart
outputs:
  - lib/screens/settings/_widgets/SettingsCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/settings/_widgets/SettingsCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/settings/_widgets/SettingsCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: settings
  screenTitle: Settings
  screenPath: lib/screens/settings/settings_screen.dart
  widgetId: SettingsCard
  widgetName: SettingsCard
  widgetFile: lib/screens/settings/_widgets/SettingsCard.dart
---

# Split widget: SettingsCard

Extract the `SettingsCard` widget subtree from `lib/screens/settings/settings_screen.dart` into its own file at `lib/screens/settings/_widgets/SettingsCard.dart`.

## Steps

1. **Read** — Load `lib/screens/settings/settings_screen.dart`.
2. **Locate** — Find the widget subtree implementing `SettingsCard`. Use the description in `.stitch/designs/settings/widgets.jsonl` (the entry with `name == "SettingsCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/settings/_widgets/SettingsCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/settings/settings_screen.dart` with `const SettingsCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/settings/_widgets/SettingsCard.dart lib/screens/settings/settings_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
