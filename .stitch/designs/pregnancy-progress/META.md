# META.md — Pregnancy Progress Design

## Example Selection

Scored examples from `.stitch/system/META.md`:

| Screen | Route | Match Score | Notes |
|--------|-------|--------------|-------|
| celebration-screen | — | **9/10** | Direct match: week hero, fruit-size, body changes, baby dev, due date countdown, self-care tips |
| single-screen | `/` | 5/10 | Home dashboard, different layout, no week progression |
| multi-state-screen | — | 4/10 | Mood/wellbeing screen, different purpose |

## Selected Reference

**`celebration-screen.html`** — Used as structural reference for the pregnancy progress layout.

### Why celebration-screen
1. **Content match**: Week hero with fruit-size comparison, body changes list, baby development paragraph, self-care tips, due date summary — all required sections present
2. **Purpose match**: Celebration/pregnancy-themed screen matches this screen's user journey
3. **Data pattern**: Week-based navigation with page dots matches PageView requirement

### Adapted Elements
- Removed celebration confetti/sparkles (not in spec)
- Replaced bottom nav with pinned due date summary (per spec: no bottom nav on push route)
- Restructured to use Flutter HTML Glossary vocabulary for mechanical Flutter conversion

## Design Generation Notes

- Created design.html at 375px width per spec
- Used Flutter HTML Glossary: `data-flutter="scaffold"`, `data-color`, `data-spacing`, `data-p`
- PageView structure with PageController for week swiping
- Pinned bottom card for due date summary (28dp top corners per spec)