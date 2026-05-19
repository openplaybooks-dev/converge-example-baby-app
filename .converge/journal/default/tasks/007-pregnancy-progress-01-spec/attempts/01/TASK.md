# Task: 007-pregnancy-progress-01-spec

# Spec: My Pregnancy

Generate the screen specification for **My Pregnancy** (`/pregnancy-progress`).

## Inputs
- `.stitch/system/DESIGN.md` — Design system
- `.stitch/UX.md` — UX overview
- `.stitch/screens.json` — Screen definitions

## Task

Read inputs and produce `.stitch/designs/pregnancy-progress/SPEC.md` containing:

1. **Screen Title** — My Pregnancy
2. **Purpose** — What this screen does and why
3. **Route** — `/pregnancy-progress`
4. **Widget Name** — `PregnancyProgressScreen`
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

- `.stitch/designs/pregnancy-progress/SPEC.md` exists and has >50 lines
- All required sections present
- Design tokens reference DESIGN.md values