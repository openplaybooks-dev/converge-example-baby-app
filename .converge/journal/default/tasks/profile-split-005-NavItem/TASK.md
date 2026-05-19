---
id: profile-split-005-NavItem
title: "Split widget: NavItem"
description: Extract NavItem from Profile screen into its own file
inputs:
  - lib/screens/profile/profile_screen.dart
outputs:
  - lib/screens/profile/_widgets/NavItem.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/profile/_widgets/NavItem.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/profile/_widgets/NavItem.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: profile
  screenTitle: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetId: NavItem
  widgetName: NavItem
  widgetFile: lib/screens/profile/_widgets/NavItem.dart
---

# Split widget: NavItem

Extract the `NavItem` widget subtree from `lib/screens/profile/profile_screen.dart` into its own file at `lib/screens/profile/_widgets/NavItem.dart`.

## Steps

1. **Read** — Load `lib/screens/profile/profile_screen.dart`.
2. **Locate** — Find the widget subtree implementing `NavItem`. Use the description in `.stitch/designs/profile/widgets.jsonl` (the entry with `name == "NavItem"`) to disambiguate.
3. **Create file** — Write `lib/screens/profile/_widgets/NavItem.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/profile/profile_screen.dart` with `const NavItem()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/profile/_widgets/NavItem.dart lib/screens/profile/profile_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
