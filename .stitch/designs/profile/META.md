# Profile — Design Reference (META)

## Example Selection

### Reference: `single-screen.html` (Home dashboard)

| Dimension | Weight | Score (0-2) | Rationale |
|-----------|--------|-------------|----------|
| App Type | High | 2 | Same pregnancy tracker app — identical domain |
| Platform | High | 2 | Same 375px phone frame, same scaffold structure |
| Interaction Density | Medium | 2 | Low: static card list, no forms — identical complexity |
| Visual Personality | Medium | 2 | Same "Gentle Bloom" theme, same card + nav patterns |
| Component Overlap | Medium | 2 | Cards, avatar, bottom nav, section spacing — nearly identical |
| Screen Pattern Match | High | 2 | Single-screen pattern with card sections — exact match |
| **Total** | | **12/12** | |

### Decision

**Strong match (use directly).** Profile and Home share the same app shell: identical scaffold chrome, same bottom navigation with 4 tabs, same card styling, same spacing rhythm. Profile differs only in content (header + 3 nav cards vs. banner + checklist + quick actions). The single-screen.html structure is the ideal base.

---

## Structure Mapping

| single-screen.html element | Profile adaptation |
|---------------------------|-------------------|
| `.week-banner` | Profile header (avatar + name + due date) |
| `.card` with mood buttons | Mindfulness card, Settings card, About card |
| `.quick-actions` grid | N/A (Profile has list cards, not grid) |
| Bottom nav (4 tabs) | Bottom nav (4 tabs, Profile active at index 3) |

---

## Design Decisions

1. **Avatar gradient**: `lavenderBloom` → `blushRose` diagonal gradient (mirrors Home avatar treatment)
2. **Card tap feedback**: CSS `transform: scale(0.98)` on `:active` (same as Home action-btn)
3. **Section spacing**: 24dp vertical between sections (matches SPEC.md + system DESIGN.md)
4. **Bottom nav height**: 80px + 8px home indicator = 88px total (matches single-screen.html)