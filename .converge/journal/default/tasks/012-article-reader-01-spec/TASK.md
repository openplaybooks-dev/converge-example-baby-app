---
id: 012-article-reader-01-spec
title: "Spec: Article Reader"
description: Generate Article Reader screen specification
inputs:
  - .stitch/system/DESIGN.md
  - .stitch/UX.md
  - .stitch/screens.json
outputs:
  - .stitch/designs/article-reader/SPEC.md
checks:
  - id: spec-exists
    type: cmd
    cmd: test -f .stitch/designs/article-reader/SPEC.md
    description: SPEC.md exists for article-reader
  - id: spec-has-content
    type: cmd
    cmd: test $(wc -l < .stitch/designs/article-reader/SPEC.md) -gt 50
    description: SPEC.md has >50 lines
plan: {}
tags:
  - spec
  - screen-article-reader
vars:
  references:
    - flutter-building-layouts
  screenId: article-reader
  title: Article Reader
  route: /article-reader/:id
  widgetName: ArticleReader
  specPath: .stitch/designs/article-reader/SPEC.md
---

# Spec: Article Reader

Generate the screen specification for **Article Reader** (`/article-reader/:id`).

## Inputs
- `.stitch/system/DESIGN.md` — Design system
- `.stitch/UX.md` — UX overview
- `.stitch/screens.json` — Screen definitions

## Task

Read inputs and produce `.stitch/designs/article-reader/SPEC.md` containing:

1. **Screen Title** — Article Reader
2. **Purpose** — What this screen does and why
3. **Route** — `/article-reader/:id`
4. **Widget Name** — `ArticleReaderScreen`
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

- `.stitch/designs/article-reader/SPEC.md` exists and has >50 lines
- All required sections present
- Design tokens reference DESIGN.md values
