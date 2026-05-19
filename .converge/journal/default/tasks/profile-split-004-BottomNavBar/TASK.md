---
id: profile-split-004-BottomNavBar
title: "Split widget: BottomNavBar"
description: Extract BottomNavBar from Profile screen into its own file
inputs:
  - lib/screens/profile/profile_screen.dart
outputs:
  - lib/screens/profile/_widgets/BottomNavBar.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/profile/_widgets/BottomNavBar.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/profile/_widgets/BottomNavBar.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: profile
  screenTitle: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetId: BottomNavBar
  widgetName: BottomNavBar
  widgetFile: lib/screens/profile/_widgets/BottomNavBar.dart
---

# Split widget: BottomNavBar

Extract the `BottomNavBar` widget subtree from `lib/screens/profile/profile_screen.dart` into its own file at `lib/screens/profile/_widgets/BottomNavBar.dart`.

## Steps

1. **Read** — Load `lib/screens/profile/profile_screen.dart`.
2. **Locate** — Find the widget subtree implementing `BottomNavBar`. Use the description in `.stitch/designs/profile/widgets.jsonl` (the entry with `name == "BottomNavBar"`) to disambiguate.
3. **Create file** — Write `lib/screens/profile/_widgets/BottomNavBar.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/profile/profile_screen.dart` with `const BottomNavBar()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/profile/_widgets/BottomNavBar.dart lib/screens/profile/profile_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
