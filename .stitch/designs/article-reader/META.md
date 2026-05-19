# Article Reader — Design Reference (META)

## Example Selection

**Target:** Article Reader — single article detail screen with collapsing SliverAppBar header, article body with pull-quotes, and related articles horizontal list.

### Scoring Against Available Examples

| Example | App Type | Platform | Interaction Density | Component Overlap | Screen Pattern Match | Total |
|---------|----------|----------|-------------------|-------------------|---------------------|-------|
| home | Pregnancy tracker | Phone 375px | Medium (cards, navigation) | High (cards, hero section, horizontal list) | Single Screen (home dashboard) | **High** |
| education | Pregnancy tracker | Phone 375px | Medium (card grid, horizontal scroll) | High (cards, topic chips, article cards) | Single Screen (content feed) | **High** |
| pregnancy-progress | Pregnancy tracker | Phone 375px | Medium (hero, sections, countdown) | Moderate (hero image, section headers) | Celebration (week hero) | **Moderate** |
| mood-wellness | Pregnancy tracker | Phone 375px | High (multi-state: empty/filling/complete) | Moderate (charts, emoji selector) | Multi-State | **Low** |

### Decision

**Strong Match — education/design.html**

Both article-reader and education are content-browsing screens in the same pregnancy tracker app. The education screen provides the best structural foundation because:

1. **Same App Type & Platform** — Both use the Gentle Bloom design system at 375px phone width
2. **Same Component Vocabulary** — Cards with topic badges, horizontal scroll lists, AppBar with search
3. **Similar Content Hierarchy** — Hero image area → topic badges → article metadata → content sections
4. **Similar Patterns** — Horizontal scroll for related content, card-based layouts

**Pattern Adaptation Required:**
- Replace `AppBar` with `SliverAppBar` (collapsing header with hero image)
- Remove `bottom-nav` (article reader hides navigation per spec)
- Add `data-flutter="sliver-app-bar"` with `data-expanded-height="240"` for hero image section
- Add pull-quote styling with left border accent
- Add bookmark/share actions to AppBar

### Vocabulary Source

- Flutter HTML Glossary: `.converge/skills/stitch-flutter/references/flutter-html-glossary.md`
- Design Tokens: `.stitch/system/DESIGN.md`