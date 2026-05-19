# Plan: Spec: My Pregnancy



Now I have all the information needed. Let me compile the spec for My Pregnancy.

---

## Implementation Plan: My Pregnancy Screen (`/pregnancy-progress`)

### Understanding the Requirements

From the UX spec, the Pregnancy Progress screen is a **week-by-week swiper** with a bottom summary section. It uses:
- `PageView` with `PageController` for week navigation
- Hidden bottom navigation and no FAB
- Five distinct sections: Week Hero, Body Changes, Baby Development, Self-Care Tips, Due Date Summary

### Design Tokens (from DESIGN.md)

| Token | Value | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar |
| `blushRose` | `#F9A8D4` | Secondary accent |
| `softMint` | `#6EE7B7` | Success/positive states |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text |
| `warmWhite` | `#FFFFFF` | Sheets/FAB surfaces |

Typography uses Nunito at sizes: 57sp (hero), 28sp (screen title), 22sp (section headers), 16sp (body), 14sp (body small/label), 11pt (caption).

Spacing follows 8pt base unit: 4/8/12/16/24/32/48dp.

### Key Implementation Considerations

1. **PageView with PageController** — Horizontal swipe navigates between weeks. Must track `currentPage` and sync with `PregnancyProfileProvider.currentWeek`.

2. **Week Hero as full-screen card** — The hero occupies most of the screen with fruit-size emoji, week number, and countdown. Uses `displayLarge` typography (57pt per DESIGN.md hero display).

3. **Static week content catalog** — Body changes, baby development, and self-care tips come from a static `WeekContent` catalog keyed by week number (similar to how `WeekContent.nutritionTips` is used in Weight & Nutrition).

4. **Due Date Summary pinned at bottom** — Unlike the swiping week content, the due date summary stays visible as a fixed bottom card.

5. **Swipe-back gesture** — PageView's swipe-back should return to previous screen (Home).

### Step-by-Step Implementation

1. **Add route to `app_router.dart`**: `/pregnancy-progress` → `PregnancyProgressScreen`
2. **Create `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`**: Scaffold with AppBar, PageView body, Due Date Summary card
3. **Build Week Hero widget**: Fruit emoji, week number (hero typography), countdown
4. **Build Body Changes section**: Bulleted list in a card
5. **Build Baby Development section**: Paragraph text in a card
6. **Build Self-Care Tips section**: 3 actionable tip cards with expand behavior
7. **Implement PageView with PageController**: Swipe navigation, sync with provider
8. **Add Due Date Summary as bottom pinned card**: Due date, days remaining, trimester badge
9. **Create static `WeekContent` catalog**: Content data source for all weeks 1-40

### Potential Challenges

- **PageView + SliverAppBar conflict**: Standard SliverAppBar doesn't work well inside PageView. May need `NotificationListener` for scroll detection or a custom collapsing header approach.
- **Static content for 40 weeks**: Need comprehensive week-by-week content catalog.
- **Week calculation**: `currentWeek = (today - dueDate + 280 days) / 7` — need to handle edge cases (before pregnancy, past due date).

---

### Critical Files for Implementation

1. **`lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`** — New screen widget, the core implementation
2. **`lib/router/app_router.dart`** — Add the route for `/pregnancy-progress`
3. **`lib/providers/pregnancy_profile_provider.dart`** (or equivalent) — Data source for current week and due date (may not exist yet)
4. **`.stitch/system/DESIGN.md`** — Reference for design tokens, typography scale, motion values
5. **`lib/theme/app_theme.dart`** — Reference for Flutter theme implementation (colorScheme mappings, spacing constants)