# META.md — Health Log Screen Design

## Example Selection

**Selected Reference**: `.stitch/designs/mindfulness/design.html`

## Scoring Table

| Dimension | mindfulness | single-screen.html | multi-state-screen.html |
|-----------|-------------|--------------------|------------------------|
| App Type | Health/Wellness ✓ | Pregnancy Tracker ✓ | Mood/Wellness Form ✗ |
| Screen Pattern | Push Screen (list) ✓ | Home Dashboard (sliver) ~ | Multi-State Form ✗ |
| Component Overlap | Card list, FAB, AppBar, back button ✓ | Week banner, nav, chips ~ | Form fields, emoji ✗ |
| Visual Personality | Warm, card-based, Nunito ✓ | Same warm aesthetic ✓ | Same warm aesthetic ✓ |
| Navigation | Push screen, hidden bottom nav ✓ | Tab shell with bottom nav ✗ | Tab shell ✗ |
| **Total** | **Strong Match** | **Moderate Match** | **Weak Match** |

## Why mindfulness/design.html

The `mindfulness/design.html` reference provides the exact structural pattern needed for the Health Log screen:

1. **Push Screen** — No bottom nav, just AppBar with back button
2. **ListView body** — Scrollable card list with sections
3. **AppBar** — Title, back button, trailing actions
4. **Card-based content** — Each entry rendered as a card with title, description, badge
5. **FAB pattern** — Though not shown in mindfulness, the app type supports FAB

The Health Log timeline is a vertical card list, same structure as mindfulness exercise list.

## Adaptation Notes

- Replace exercise content with health entry types (symptoms, doctor visits, reminders)
- Add summary stats banner at top (similar to home screen's mood check-in card)
- Add FAB for adding new entries
- Use color-coded left border for entry type indication (lavender=symptom, blush=doctor, mint=reminder)
- Add filter icon button in AppBar trailing position
- Use SPEC.md design tokens (lavenderBloom, blushRose, softMint, etc.)
- Ensure 375px phone frame for mobile mockup