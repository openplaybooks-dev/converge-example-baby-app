# Plan: Analyze: Browse



Based on my analysis of `lib/screens/browse/browse_screen.dart`, I can identify the extractable widget regions.

## Analysis Summary

**BrowseScreen** (lines 4-45) contains:
- AppBar with "Browse" title
- SingleChildScrollView with Column
- Two `_LinkCard` instances (Cycle Tracking and Weight & Nutrition)
- SizedBox spacers

**_LinkCard** (lines 47-148) is a self-contained widget that:
- Renders a tappable navigation card with icon, title, description, and chevron
- Has its own State class with animation logic (`_scale` for press feedback)
- ~100 lines of widget code
- Could be reused for other navigation cards across screens

## Extracted Widget

| Name | Grep | Description | Shared |
|------|------|-------------|--------|
| `LinkCard` | `_LinkCard` (the class definition) | Tappable navigation card with icon, title, description, and animated press feedback | `true` |

The `_LinkCard` class is the only extractable widget meeting all criteria (self-contained visual block, 15+ lines, reusable across screens, has own state concerns).

## Implementation Plan

1. **Create** `.stitch/designs/browse/widgets.jsonl` with the LinkCard entry

The JSONL file content would be:
```jsonl
{"name": "LinkCard", "grep": "class _LinkCard", "description": "Tappable navigation card with icon, title, description, and animated press feedback", "shared": true}
```

### Critical Files for Implementation

1. **`lib/screens/browse/browse_screen.dart`** — Source file containing the `_LinkCard` widget to extract
2. **`.stitch/designs/browse/widgets.jsonl`** — Target file to create with the widget specification
3. **`.stitch/designs/home/widgets.jsonl`** — Reference for JSONL format conventions used in this project
4. **`.stitch/designs/browse/SPEC.md`** — Reference for design tokens and accessibility requirements that the extracted widget should honor