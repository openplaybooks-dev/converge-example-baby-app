# Library Screen — Design Reference (META)

## Example Selection

### Scoring Reference Examples Against Library Screen

| Dimension | Weight | single-screen.html | multi-state-screen.html | celebration-screen.html |
|---|---|---|---|---|
| App Type | High | Pregnancy/wellness app — same category | Mood tracking — similar wellness domain | Pregnancy progress — same app category |
| Platform | High | Phone 375px, bottom nav tab | Phone 375px, bottom nav | Phone 375px, bottom nav |
| Interaction Density | Medium | Low (tap cards to navigate) | Medium (emoji selector, note field, charts) | Medium (week hero, body changes, countdown) |
| Visual Personality | Medium | Warm, card-based, gentle pastels | Warm, card-based, gentle pastels | Warm, card-based, gentle pastels |
| Component Overlap | Medium | Cards, icons, bottom nav, InkWell | Cards, charts, forms, bottom nav | Cards, hero, progress indicators |
| Screen Pattern | High | Single screen ✓ | Multi-state (not applicable) | Celebration (not applicable) |
| **Total Score** | | **1.0** | **0.65** | **0.65** |

## Selected Reference

**`single-screen.html`** — Strong match. Library is a single-screen tab with navigation cards, matching the home dashboard's card-based layout pattern. Uses the same Scaffold chrome, bottom navigation shell (4 tabs), and card layout approach.

## Design Decisions

| Decision | Rationale |
|---|---|
| Card layout with Row | Library has 3 navigation links — each card follows the same Row pattern (icon | text | chevron) |
| InkWell simulation via `.ink-well` | Cards need tap feedback with 200ms scale animation |
| Bottom nav with 4 tabs | Library is tab index 2 — matches home dashboard's nav structure |
| Staggered fade-in animations | Cards appear with 100ms delay between each, matching spec |
| No FAB | Tab screens do not have FABs per DESIGN.md anti-patterns |

## Token Mapping

| Design Token | Value | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Health Log icon, active nav indicator |
| `blushRose` | `#F9A8D4` | Mood & Wellness icon background |
| `softMint` | `#6EE7B7` | Education icon background |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text (titles, descriptions) |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions, chevrons |
| `warmWhite` | `#FFFFFF` | Bottom nav background |

## Flutter HTML Glossary Elements Used

- `.scaffold` — Root scaffold with Lavender Tint background
- `.app-bar` — Transparent app bar with "Library" title
- `.body` — SingleChildScrollView wrapper
- `.column` — Vertical card layout
- `.card` — Navigation link cards (3x)
- `.ink-well` — Card tap feedback with scale animation
- `.bottom-nav` — 4-tab navigation bar
- `.nav-destination` — Nav items with `data-selected` state
- Icons: inline SVG with `<!-- favorite -->` etc.