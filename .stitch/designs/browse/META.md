# META.md — Browse Screen Design

## Example Selection

**Selected Reference**: `.stitch/system/single-screen.html`

## Scoring Table

| Dimension | single-screen.html | multi-state-screen.html | celebration-screen.html |
|-----------|-------------------|------------------------|------------------------|
| App Type | Pregnancy Tracker ✓ | Mood/Wellness Form ✗ | Pregnancy Progress ✗ |
| Screen Pattern | Single Screen (card list) ✓ | Multi-State Form ✗ | Celebration ✗ |
| Component Overlap | Cards, bottom nav ✓ | Emoji selector, charts ✗ | Week hero, body changes ✗ |
| Visual Personality | Warm, card-based, Nunito ✓ | Similar warm aesthetic ✓ | Similar warm aesthetic ✓ |
| Navigation | 4-tab bottom nav ✓ | 4-tab bottom nav ✓ | 4-tab bottom nav ✓ |
| **Total** | **Strong Match** | **Weak Match** | **Weak Match** |

## Why single-screen.html

The `single-screen.html` reference contains exactly the structural pattern needed for the Browse screen:

1. **AppBar** — Transparent floating title "Browse", no leading/trailing
2. **Card Layout** — Two full-width cards with 16dp padding, 16dp radius, soft shadow
3. **Card Content** — Icon container + text content + trailing chevron in Row layout
4. **Bottom Navigation** — 4 tabs with active indicator pill at index 1
5. **Safe Area** — Status bar + home indicator handling

All components map 1:1 to the SPEC.md section requirements.

## Adaptation Notes

- Replace week banner with two navigation cards (Cycle Tracking, Weight & Nutrition)
- Use `data-flutter` attributes for Scaffold and NavigationBar identity
- Map design tokens from SPEC.md to CSS custom properties
- Ensure 375px phone frame for mobile mockup
- Use Nunito font from Google Fonts
- No FAB on tab screens