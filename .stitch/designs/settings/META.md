# Settings — Design Reference (META)

## Example Selection

### Reference: `profile/design.html`

| Dimension | Weight | Score (0-2) | Rationale |
|-----------|--------|-------------|----------|
| App Type | High | 2 | Same pregnancy tracker app — identical domain |
| Platform | High | 2 | Same 375px phone frame, same scaffold structure |
| Interaction Density | Medium | 2 | Same: card-based list with interactive rows |
| Visual Personality | Medium | 2 | Same "Gentle Bloom" theme, same card styling |
| Component Overlap | Medium | 2 | Cards, app bar, list items — same component vocabulary |
| Screen Pattern Match | High | 2 | Push screen with card sections — exact match |
| **Total** | | **12/12** | |

### Decision

**Strong match (use directly).** Profile and Settings share the same card-based structure with list items. Both are push screens (no bottom nav). Settings differs in content (switch toggles instead of nav cards, action rows for export/clear).

---

## Structure Mapping

| profile/design.html element | Settings adaptation |
|---------------------------|---------------------|
| `.profile-header` | N/A (Settings has simple AppBar, not profile header) |
| `.nav-card` (link rows) | Profile section: name + due date rows |
| `.nav-card` with switches | Notifications section: SwitchListTile widgets |
| `.about-card` | Data section (export/clear) + About section (version/links) |
| AppBar | Same structure (title, no actions) |

---

## Design Decisions

1. **No bottom nav**: Settings is a push screen — bottom nav is hidden per SPEC.md
2. **Card styling**: Same 16px radius, same shadow, same morningMist background
3. **Switch toggles**: Active track uses `lavenderBloom`, inactive uses `mistyBorder`
4. **Section spacing**: 24dp vertical between sections, 12dp between items within section
5. **Clear All Data**: Uses `softCoral` color for destructive action
6. **Export success**: Uses `softMint` for success feedback (toast/snackbar)