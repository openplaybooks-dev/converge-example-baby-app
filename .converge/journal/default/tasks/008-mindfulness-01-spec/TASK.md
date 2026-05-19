---
id: 008-mindfulness-01-spec
title: "Spec: Mindfulness"
description: Generate Mindfulness screen specification
inputs:
  - .stitch/system/DESIGN.md
  - .stitch/UX.md
  - .stitch/screens.json
outputs:
  - .stitch/designs/mindfulness/SPEC.md
checks:
  - id: spec-exists
    type: cmd
    cmd: test -f .stitch/designs/mindfulness/SPEC.md
    description: SPEC.md exists for mindfulness
  - id: spec-has-content
    type: cmd
    cmd: test $(wc -l < .stitch/designs/mindfulness/SPEC.md) -gt 50
    description: SPEC.md has >50 lines
plan: {}
tags:
  - spec
  - screen-mindfulness
vars:
  references:
    - flutter-building-layouts
  screenId: mindfulness
  title: Mindfulness
  route: /mindfulness
  widgetName: Mindfulness
  specPath: .stitch/designs/mindfulness/SPEC.md
---

# Spec: Mindfulness

Generate the screen specification for **Mindfulness** (`/mindfulness`).

## Inputs
- `.stitch/system/DESIGN.md` — Design system
- `.stitch/UX.md` — UX overview
- `.stitch/screens.json` — Screen definitions

## Task

Read inputs and produce `.stitch/designs/mindfulness/SPEC.md` containing:

1. **Screen Title** — Mindfulness
2. **Purpose** — What this screen does and why
3. **Route** — `/mindfulness`
4. **Widget Name** — `MindfulnessScreen`
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

- `.stitch/designs/mindfulness/SPEC.md` exists and has >50 lines
- All required sections present
- Design tokens reference DESIGN.md values
