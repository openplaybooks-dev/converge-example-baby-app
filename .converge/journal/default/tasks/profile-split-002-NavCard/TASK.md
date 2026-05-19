---
id: profile-split-002-NavCard
title: "Split widget: NavCard"
description: Extract NavCard from Profile screen into its own file
inputs:
  - lib/screens/profile/profile_screen.dart
outputs:
  - lib/screens/profile/_widgets/NavCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/profile/_widgets/NavCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/profile/_widgets/NavCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: profile
  screenTitle: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetId: NavCard
  widgetName: NavCard
  widgetFile: lib/screens/profile/_widgets/NavCard.dart
---

# Split widget: NavCard

Extract the `NavCard` widget subtree from `lib/screens/profile/profile_screen.dart` into its own file at `lib/screens/profile/_widgets/NavCard.dart`.

## Steps

1. **Read** — Load `lib/screens/profile/profile_screen.dart`.
2. **Locate** — Find the widget subtree implementing `NavCard`. Use the description in `.stitch/designs/profile/widgets.jsonl` (the entry with `name == "NavCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/profile/_widgets/NavCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/profile/profile_screen.dart` with `const NavCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/profile/_widgets/NavCard.dart lib/screens/profile/profile_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
