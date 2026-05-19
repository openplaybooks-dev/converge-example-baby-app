# Plan: Spec: Weight & Nutrition



Based on my exploration of the codebase, I now have all the information needed to produce the screen specification. Let me compile the complete plan.

---

# Plan: Weight & Nutrition Screen Specification

## Input Files Reviewed
- `.stitch/system/DESIGN.md` — Design system with color palette, typography, spacing, motion tokens
- `.stitch/UX.md` — UX specification including section 3.3 for Weight & Nutrition
- `.stitch/screens.json` — Screen definition entry for weight-nutrition
- `data-models.md` — WeightEntry entity definition
- `.stitch/designs/cycle-tracking/SPEC.md` — Reference spec following the exact format required
- `lib/screens/cycle_tracking/cycle_tracking_screen.dart` — Implementation reference
- `lib/theme/app_theme.dart` — Design token constants
- `lib/router/app_router.dart` — Router structure

## Output: `.stitch/designs/weight-nutrition/SPEC.md`

The spec will follow the established cycle-tracking SPEC format and include:

### Structure (11 Sections)

1. **Screen Title** — Weight & Nutrition
2. **Purpose** — Log daily weight, view progress chart, read stage-specific nutrition tips
3. **Route** — `/weight-nutrition`
4. **Widget Name** — `WeightNutritionScreen`
5. **Design Tokens** — Full color, typography, spacing, radius, elevation, motion tables
6. **Layout Rules** — Scaffold with AppBar (lavenderBloom bg, white title, back button), hidden BottomNavigationBar, FAB for add, CustomScrollView with SliverAppBar
7. **Sections** — 4 visible sections plus 2 overlays:
   - Progress Chart (LineChart with toggle chips for 1W/1M/All)
   - Latest Entry Card (today's weight + delta from previous)
   - Nutrition Tips Card (week-based from WeekContent.nutritionTips)
   - Weight Log List (SliverList with date/weight/note)
   - FAB → Add Weight Bottom Sheet
   - Long-press → Edit/Delete Bottom Sheet
8. **Data** — WeightEntry entity, WeightEntryProvider, PregnancyProfileProvider (for week lookup into WeekContent)
9. **Motion** — Page transition (300ms), card fade-in (200ms), staggered list (50ms delay), bottom sheet (250ms)
10. **Accessibility** — Semantic labels for all interactive elements, 48dp touch targets, contrast ratios for text on backgrounds
11. **Anti-Patterns** — No bottom nav, no hardcoded values, no Inter/Roboto fonts, safe area respect for FAB

---

### Critical Files for Implementation

1. **`lib/screens/weight_nutrition/weight_nutrition_screen.dart`** — Main screen widget to create
2. **`lib/providers/weight_entry_provider.dart`** — Provider for weight data (referenced in task 002-provider-WeightEntry)
3. **`lib/router/app_router.dart`** — Route registration for `/weight-nutrition`
4. **`lib/theme/app_theme.dart`** — Design token constants to reference
5. **`data-models.md`** — WeightEntry entity definition and relationships