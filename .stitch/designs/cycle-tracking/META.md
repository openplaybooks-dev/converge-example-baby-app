# META.md — Cycle Tracking Screen Design

## Example Selection

**Selected Reference**: `.stitch/system/single-screen.html`

## Scoring Table

| Dimension | single-screen.html | multi-state-screen.html | celebration-screen.html |
|-----------|-------------------|------------------------|------------------------|
| App Type | Pregnancy Tracker ✓ | Mood/Wellness Form ✗ | Pregnancy Progress ✗ |
| Screen Pattern | Single Screen with card layout ✓ | Multi-State Form ✗ | Celebration ✗ |
| Component Overlap | AppBar, FAB, card surfaces, progress bars ✓ | Emoji selector, charts ✗ | Week hero, body changes ✗ |
| Visual Personality | Warm, card-based, Nunito font ✓ | Similar warm aesthetic ✓ | Similar warm aesthetic ✓ |
| Navigation | Standalone push route (no bottom nav on this screen) ✓ | 4-tab bottom nav ✗ | 4-tab bottom nav ✗ |
| **Total** | **Strong Match** | **Weak Match** | **Weak Match** |

## Why single-screen.html

The `single-screen.html` reference contains exactly the structural pattern needed for the Cycle Tracking screen:

1. **AppBar** — Title bar with back navigation, lavender primary background
2. **Card Surfaces** — Elevated cards with rounded corners for current cycle info
3. **Progress Indicators** — Horizontal bars for cycle length visualization
4. **FAB** — Floating action button bottom-right for adding entries
5. **Bottom Sheet** — Modal form overlay for cycle entry

## Adaptation Notes

- Replace CSS custom properties with SPEC.md design tokens
- Use `lavenderBloom` (#7C3AED) for AppBar and FAB (primary brand color)
- Use `morningMist` (#FAFAFA) for card backgrounds
- Use `blushRose` (#F9A8D4) at 20% opacity for fertile window background
- Add `data-flutter` attributes for Flutter widget identity
- Ensure 375px phone frame for mobile mockup
- Use Nunito font from Google Fonts
- No bottom navigation (hidden per UX spec for standalone push route)