# Plan: Spec: Browse



Based on my exploration, I have all the information needed to design the Browse screen specification. Let me compile the findings.

---

## Browse Screen Specification Plan

### Screen Overview
The **Browse** screen (`/browse`) is a **tab-level screen** within the shell's BottomNavigationBar, serving as a discovery hub that links to Cycle Tracking and Weight & Nutrition entry points.

### Key Findings from Inputs

**From `screens.json`:**
- `id`: "browse"
- `route`: `/browse`
- `navType`: "tab" (BottomNavigationBar visible, like Home)
- `features`: ["cycle-tracking-link", "weight-nutrition-link"]
- Two primary destination cards linking to `/cycle-tracking` and `/weight-nutrition`

**From `UX.md` Section 3.2 and 3.3:**
- Cycle Tracking: Log cycles, view ovulation predictions, FAB for new entry
- Weight & Nutrition: Log weight, view progress chart, nutrition tips

**From `UX.md` Navigation Architecture:**
- Browse is index 1 in bottom nav (Home=0, Browse=1, Library=2, Profile=3)

**From `home/SPEC.md` pattern:**
- Tab screens use `Scaffold` with `CustomScrollView` or simple body
- `BottomNavigationBar` visible with 4 tabs
- No FAB for tab screens
- Uses `SliverToBoxAdapter` sections with 24dp spacing

**From `app_theme.dart`:**
- All design tokens defined: spacing (8pt base), radius, colors, typography
- Light and dark theme support via `ColorScheme`

### Proposed Layout

```
Scaffold
├── AppBar: "Browse", no back button (tab screen)
├── Body: CustomScrollView with 2 card sections
│   ├── Section 1: Cycle Tracking Card (tappable → /cycle-tracking)
│   └── Section 2: Weight & Nutrition Card (tappable → /weight-nutrition)
└── BottomNavigationBar: Visible (Browse tab active)
```

### Sections to Document in SPEC.md

1. **Cycle Tracking Link Card** — Icon + title + description, tappable to push `/cycle-tracking`
2. **Weight & Nutrition Link Card** — Icon + title + description, tappable to push `/weight-nutrition`

### Design Tokens to Reference
- Colors: `lavenderBloom`, `blushRose`, `morningMist`, `deepGraphite`, `stoneGrey`, `warmWhite`, etc.
- Typography: Nunito font family, type scale (titleLarge, titleMedium, bodyLarge, bodyMedium, caption)
- Spacing: 8pt base (spaceXs=8, spaceSm=12, spaceMd=16, spaceLg=24)
- Radius: radiusSm=8, radiusMd=12, radiusLg=16, radiusPill=999
- Motion: 200ms ease-out for interactions, 300ms for page transitions

### Anti-Patterns Specific to Browse
- No FAB (tab screens don't have FABs)
- No default platform colors
- All text via Nunito font family
- No pure black/white for text
- Touch targets minimum 48dp
- Links must navigate to push routes (not recreate content inline)

---

### Critical Files for Implementation

1. **`lib/screens/home/home_screen.dart`** — Reference implementation for tab-level screen with BottomNavigationBar (BrowseScreen will follow same pattern)
2. **`lib/theme/app_theme.dart`** — All design tokens (colors, spacing, typography, radius)
3. **`lib/router/app_router.dart`** — Route registration for `/browse` path
4. **`.stitch/designs/home/SPEC.md`** — Template for SPEC.md structure and documentation format
5. **`.stitch/system/DESIGN.md`** — Design token source of truth