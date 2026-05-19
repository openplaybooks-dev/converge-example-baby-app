---
id: 004-profile-02-design
title: "Design: Profile"
description: Generate constrained HTML design for Profile using Flutter HTML Glossary
inputs:
  - .stitch/designs/profile/SPEC.md
  - .stitch/system/DESIGN.md
  - .stitch/system/META.md
outputs:
  - .stitch/designs/profile/META.md
  - .stitch/designs/profile/design.html
checks:
  - id: design-exists
    type: cmd
    cmd: test -f .stitch/designs/profile/design.html
    description: design.html exists for profile
  - id: meta-exists
    type: cmd
    cmd: test -f .stitch/designs/profile/META.md
    description: META.md exists for profile
  - id: uses-glossary
    type: cmd
    cmd: grep -q 'class="scaffold"' .stitch/designs/profile/design.html
    description: HTML uses Flutter HTML Glossary vocabulary
  - id: has-data-attributes
    type: cmd
    cmd: grep -q 'data-color=' .stitch/designs/profile/design.html
    description: HTML uses data-* attributes for Flutter conversion
tags:
  - design
  - html
  - screen-profile
vars:
  skill: stitch-generate
  screenId: profile
  title: Profile
  specPath: .stitch/designs/profile/SPEC.md
  metaPath: .stitch/designs/profile/META.md
  designPath: .stitch/designs/profile/design.html
---

# Design: Profile

Generate the HTML design mockup for **Profile** using the **Flutter HTML Glossary** constrained vocabulary.

## Critical Constraint

The HTML MUST use ONLY elements from the **Flutter HTML Glossary** (`stitch-flutter/references/flutter-html-glossary.md`). This ensures the `stitch-flutter` converter can produce pixel-perfect Flutter widgets mechanically.

## Inputs
- `.stitch/designs/profile/SPEC.md` — Screen specification
- `.stitch/system/DESIGN.md` — Design system
- `.stitch/system/META.md` — Reference examples metadata

## Steps

1. **Read spec** — Load `.stitch/designs/profile/SPEC.md` to understand layout, sections, data
2. **Read glossary** — Load `stitch-flutter/references/flutter-html-glossary.md` to understand the constrained vocabulary
3. **Select best example match** — Read `.stitch/system/META.md` and score against examples per `stitch-generate/references/selecting-examples.md`
4. **Read matched reference** — Study the matching example's patterns
5. **Generate META.md** — Write `.stitch/designs/profile/META.md` with example selection and scoring table
6. **Generate design.html** — Write `.stitch/designs/profile/design.html` following `stitch-generate` skill using ONLY glossary elements

## Glossary Quick Reference

- Layout: `.column`, `.row`, `.stack`, `.wrap`, `.expanded`, `.padding`, `.sized-box`
- Scaffold: `.scaffold`, `.app-bar`, `.body`, `.bottom-nav`, `.fab`
- Text: `.title-large`, `.body-medium`, `.label-small` (Material 3 TextTheme classes)
- Components: `.card`, `.chip`, `.list-tile`, `.divider`, `.badge`, `.avatar`
- Buttons: `.elevated-btn`, `.filled-btn`, `.text-btn`, `.icon-btn`
- Images: `.network-image`, `.placeholder-image`
- Icons: `<svg class="icon" data-name="{material_icon}" data-size="24">`
- Colors: `data-color="primary"`, `data-bg="surface"` (ColorScheme roles)
- Spacing: `data-spacing="md"`, `data-p="lg"` (token names)
- Animation: `data-animate="fade-in"`, `data-animate-delay="100"`
- Navigation: `.ink-well` with `data-route="/path"`

## Output

- `.stitch/designs/profile/META.md` — Example selection and scoring
- `.stitch/designs/profile/design.html` — Self-contained HTML mockup at 375px using glossary vocabulary
