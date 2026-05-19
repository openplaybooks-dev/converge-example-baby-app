# META.md — Mindfulness Screen Design

## Example Selection

**Selected Reference**: `.stitch/system/multi-state-screen.html`

## Scoring Table

| Dimension | single-screen.html | multi-state-screen.html | celebration-screen.html |
|-----------|-------------------|------------------------|------------------------|
| App Type | Pregnancy Tracker ✓ | Pregnancy Tracker ✓ | Pregnancy Tracker ✓ |
| Screen Pattern | Tab (home) ✗ | Push screen ✓ | Push screen ✓ |
| Navigation | Has bottom nav (not needed) ✗ | Back button, no bottom nav ✓ | Back button, no bottom nav ✓ |
| Content Structure | Tab dashboard | Form/card content | Hero + cards |
| Component Overlap | Cards, chips, buttons | Cards, emoji selector, back button | Cards, hero, back button |
| Visual Personality | Warm, card-based ✓ | Warm, card-based ✓ | Warm, card-based ✓ |
| **Total** | **Moderate Match** | **Strong Match** | **Strong Match** |

## Why multi-state-screen.html

The `multi-state-screen.html` reference provides the structural pattern closest to Mindfulness:

1. **Push screen** — No bottom nav, back button in AppBar, centered title
2. **Card-based content** — Vertical card list with sections
3. **Touch targets** — 48dp buttons with proper spacing
4. **No FAB** — Correct for this screen per SPEC.md
5. **Scrollable body** — Content scrolls independently of AppBar

## Adaptation Notes

- Remove state indicator badge (multi-state-screen has it; Mindfulness doesn't)
- Replace emoji selector with card list items (BreathingExerciseCard, StretchingRoutineCard)
- Use Tailwind for styling per Flutter HTML Glossary rules
- Add `data-flutter` attributes for Flutter widget identity (scaffold, app-bar, custom-scroll)
- Use data-color and data-spacing attributes for design token mapping
- Ensure 375px phone frame for mobile mockup
- Use Nunito font from Google Fonts