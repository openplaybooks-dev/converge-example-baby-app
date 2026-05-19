---
id: profile-split-003-AboutCard
title: "Split widget: AboutCard"
description: Extract AboutCard from Profile screen into its own file
inputs:
  - lib/screens/profile/profile_screen.dart
outputs:
  - lib/screens/profile/_widgets/AboutCard.dart
checks:
  - id: widget-exists
    type: cmd
    cmd: test -f lib/screens/profile/_widgets/AboutCard.dart
    description: Widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/profile/_widgets/AboutCard.dart
    description: Dart analysis passes
tags:
  - split
  - widget
vars:
  screenId: profile
  screenTitle: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetId: AboutCard
  widgetName: AboutCard
  widgetFile: lib/screens/profile/_widgets/AboutCard.dart
---

# Split widget: AboutCard

Extract the `AboutCard` widget subtree from `lib/screens/profile/profile_screen.dart` into its own file at `lib/screens/profile/_widgets/AboutCard.dart`.

## Steps

1. **Read** — Load `lib/screens/profile/profile_screen.dart`.
2. **Locate** — Find the widget subtree implementing `AboutCard`. Use the description in `.stitch/designs/profile/widgets.jsonl` (the entry with `name == "AboutCard"`) to disambiguate.
3. **Create file** — Write `lib/screens/profile/_widgets/AboutCard.dart` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `lib/screens/profile/profile_screen.dart` with `const AboutCard()` and add the relative import.
5. **Verify** — Run `dart analyze lib/screens/profile/_widgets/AboutCard.dart lib/screens/profile/profile_screen.dart` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
