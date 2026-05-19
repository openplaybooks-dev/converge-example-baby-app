# META.md — Home Screen Design

## Example Selection

**Selected Reference**: `.stitch/system/single-screen.html`

## Scoring Table

| Dimension | single-screen.html | multi-state-screen.html | celebration-screen.html |
|-----------|-------------------|------------------------|------------------------|
| App Type | Pregnancy Tracker ✓ | Mood/Wellness Form ✗ | Pregnancy Progress ✗ |
| Screen Pattern | Single Screen (home dashboard) ✓ | Multi-State Form ✗ | Celebration ✗ |
| Component Overlap | Week banner, mood check-in, checklist, quick actions, bottom nav ✓ | Emoji selector, charts ✗ | Week hero, body changes ✗ |
| Visual Personality | Warm, card-based, Nunito font ✓ | Similar warm aesthetic ✓ | Similar warm aesthetic ✓ |
| Navigation | 4-tab bottom nav ✓ | 4-tab bottom nav ✓ | 4-tab bottom nav ✓ |
| **Total** | **Strong Match** | **Weak Match** | **Weak Match** |

## Why single-screen.html

The `single-screen.html` reference contains exactly the structural pattern needed for the Home screen:

1. **Week Banner** — Hero card with week number, due date, fruit-size comparison chip
2. **Mood Check-In** — Horizontal emoji button row in a card
3. **Today's Checklist** — Horizontal scrollable chips
4. **Quick Actions** — 2x2 grid of action buttons
5. **Weekly Tip** — Gradient card at bottom
6. **Bottom Navigation** — 4 tabs with active indicator

All components map 1:1 to the SPEC.md section requirements.

## Adaptation Notes

- Replace CSS custom properties with SPEC.md design tokens
- Add `data-flutter` attributes for Flutter widget identity (Scaffold, SliverAppBar, etc.)
- Ensure 375px phone frame for mobile mockup
- Use Nunito font from Google Fonts