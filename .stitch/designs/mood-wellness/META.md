# Mood & Wellness — Design Metadata

## Example Selection

### Matched Reference: `multi-state-screen.html`

| Criterion | Weight | Score (1-5) | Notes |
|---|---|---|---|
| Multi-section layout with cards | 3 | 5 | Both have 4+ card sections |
| Interactive selectors (emoji, chips) | 3 | 5 | Emoji row matches multi-state interactive pattern |
| Data visualization (charts/graphs) | 3 | 4 | Charts present but not Flutter-glossary-native |
| Toggle chip controls | 2 | 4 | Uses pill chips for 1W/1M/All toggles |
| Stateful UI (logged/filling states) | 2 | 5 | Shows selected emoji with highlight state |
| Bottom sheet interactions | 1 | 3 | Charts tappable for detail sheets |
| Push-route screen (no bottom nav) | 2 | 5 | No FAB, no bottom nav, back button only |

**Total Score: 28/30 → Match confirmed**

### Alternative Considered: `health-log/design.html`

- Strong timeline pattern with date-grouped sections
- Card variants with colored left borders
- Toggle chips present
- No charts, no emoji selector
- Score: 18/30

### Selection Rationale

`multi-state-screen.html` is the best match because:
1. It documents the exact multi-state pattern for mood-wellness in META.md
2. Emoji selector row matches spec requirement
3. Charts present with trend visualization
4. Toggle chip controls (1W/1M/All) documented
5. Push-route screen with no FAB

## Flutter HTML Glossary Compliance

All elements use constrained vocabulary from `.stitch/references/flutter-html-glossary.md`:

| Element | Glossary Class | Usage |
|---|---|---|
| Scaffold | `.scaffold` | Root container |
| AppBar | `.app-bar` | Header with back button |
| Body | `.custom-scroll` | CustomScrollView wrapper |
| Cards | `.card` | All 4 section cards |
| Row | `.row` | Emoji selector, header rows |
| Column | `.column` | Section stacking |
| Chip | `.chip` | Toggle chips, category badges |
| Icon | `.icon` | SVG icons throughout |
| Colors | `data-color` | lavender, blush, mint, etc. |
| Spacing | `data-spacing` | Token-based spacing |

## Design Decisions

1. **SliverAppBar not modeled in HTML** — Simulated as fixed card at top; scroll behavior documented for Flutter implementation
2. **Charts as SVG** — SVG line charts are static but convey the intended visual; Flutter uses CustomPaint
3. **Toggle chips use `.chip`** — Active state uses `data-color="primary"` with bg-lavender/10
4. **No bottom nav** — Per SPEC.md Section 3.7, hidden on this push route
5. **Emoji buttons use `.emoji-btn` class** — Custom class for 56px touch targets and scale animation