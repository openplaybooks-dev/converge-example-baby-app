---
id: 010-mood-wellness-01-spec
title: "Spec: Mood & Wellness"
description: Generate Mood & Wellness screen specification
inputs:
  - .stitch/system/DESIGN.md
  - .stitch/UX.md
  - .stitch/screens.json
outputs:
  - .stitch/designs/mood-wellness/SPEC.md
checks:
  - id: spec-exists
    type: cmd
    cmd: test -f .stitch/designs/mood-wellness/SPEC.md
    description: SPEC.md exists for mood-wellness
  - id: spec-has-content
    type: cmd
    cmd: test $(wc -l < .stitch/designs/mood-wellness/SPEC.md) -gt 50
    description: SPEC.md has >50 lines
plan: {}
tags:
  - spec
  - screen-mood-wellness
vars:
  references:
    - flutter-building-layouts
  screenId: mood-wellness
  title: Mood & Wellness
  route: /mood-wellness
  widgetName: MoodWellness
  specPath: .stitch/designs/mood-wellness/SPEC.md
---

# Spec: Mood & Wellness

Generate the screen specification for **Mood & Wellness** (`/mood-wellness`).

## Inputs
- `.stitch/system/DESIGN.md` — Design system
- `.stitch/UX.md` — UX overview
- `.stitch/screens.json` — Screen definitions

## Task

Read inputs and produce `.stitch/designs/mood-wellness/SPEC.md` containing:

1. **Screen Title** — Mood & Wellness
2. **Purpose** — What this screen does and why
3. **Route** — `/mood-wellness`
4. **Widget Name** — `MoodWellnessScreen`
5. **Design Tokens** — Colors, typography, spacing from DESIGN.md
6. **Layout Rules** — Scaffold structure, app bar, body, bottom nav
7. **Sections** — Each visual section with:
   - Description of content
   - Widget type (ListView, GridView, Column, etc.)
   - Data requirements
   - Interactive elements
8. **Data** — Entities and fields displayed on this screen
9. **Motion** — Entry animations, transitions, hero animations
10. **Accessibility** — Semantics labels, focus order, contrast notes
11. **Anti-Patterns** — Things to avoid

## Success Criteria

- `.stitch/designs/mood-wellness/SPEC.md` exists and has >50 lines
- All required sections present
- Design tokens reference DESIGN.md values
