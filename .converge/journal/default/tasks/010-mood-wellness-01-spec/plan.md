# Plan: Spec: Mood & Wellness



Based on my thorough exploration of the codebase, I now have a complete picture of the Mood & Wellness screen requirements. Let me provide the analysis and design plan.

---

# Spec: Mood & Wellness — Design Analysis

## Input Analysis

### From screens.json
- **Route:** `/mood-wellness`
- **Features:** `todays-mood-card`, `mood-trend-chart`, `energy-trend-chart`, `wellness-tip`
- **Navigation:** Push route (from Library tab), BottomNavigationBar hidden, no FAB

### From UX.md Section 3.7
The screen has 4 sections:
1. **Today's Mood Card** — 5 emoji selector + optional note
2. **Mood Trend Chart** — 7-day line chart (mood scores 1-5)
3. **Energy Trend Chart** — 7-day line chart (energy levels)
4. **Wellness Tip** — Contextual recommendation based on patterns

### Entity: MoodEntry
- `date: DateTime`
- `moodScore: int` (1-5 scale)
- `energyLevel: int` (1-5 scale)
- `note: String?`

### Provider: MoodEntryProvider
Reads entries for trend charts, writes new mood logs on emoji tap.

---

## Design Token Alignment

From **app_theme.dart** and **DESIGN.md**:

| Token | Value | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar |
| `blushRose` | `#F9A8D4` | Mood emoji highlights |
| `softMint` | `#6EE7B7` | Positive indicators |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text |

**Typography:** Nunito family, 8pt base spacing grid.

---

## Layout Architecture

```
MoodWellnessScreen
├── Scaffold
│   ├── AppBar ("Mood & Wellness", back button, transparent bg)
│   ├── body: CustomScrollView
│   │   └── SliverAppBar (collapsible, pinned)
│   │       └── Today's Mood Card (expanded)
│   └── Remaining content (SliverToBoxAdapter)
│       ├── Mood Trend Chart Section
│       ├── Energy Trend Chart Section
│       └── Wellness Tip Section
└── BottomNavigationBar: Hidden
```

**Body:** `CustomScrollView` with `SliverAppBar` (no FAB per UX spec)

---

## Sections Detail

### Section 1: Today's Mood Card (SliverAppBar Expanded)
- **Widget:** Container card with 5 mood emoji buttons in horizontal row
- **Data:** Reads `todayMood` from `MoodEntryProvider`
- **Interaction:** Tap emoji → `MoodEntryProvider.logMood(score)`
- **Emojis:** 😔 😕 😐 🙂 😊 (terrible to great, scores 1-5)

### Section 2: Mood Trend Chart
- **Widget:** CustomPaint line chart showing 7-day history
- **Toggle:** 1W / 1M / All chip selector (like Weight screen)
- **Interaction:** Tap data point → bottom sheet with day's detail
- **Data:** `MoodEntryProvider.entries` last 7 days

### Section 3: Energy Trend Chart
- **Widget:** Similar line chart to mood trend
- **Same toggle options**
- **Data:** Same entries, different y-axis (energyLevel)

### Section 4: Wellness Tip
- **Widget:** Card with contextual recommendation
- **Data:** Static tip catalog + pattern analysis from recent entries
- **Interaction:** Tap to expand full recommendation

---

## Screen Structure

Following the pattern from existing screens (mindfulness_screen.dart, weight_nutrition_screen.dart):

```dart
class MoodWellnessScreen extends StatelessWidget {
  // Scaffold with SliverAppBar
  // CustomScrollView body
  // Sections as private widget classes (_TodaysMoodCard, _MoodTrendChart, etc.)
  // Bottom sheets for detail views
}
```

---

## Implementation Approach

1. **Create mood_wellness_screen.dart** in `lib/screens/mood_wellness/`
2. **Add route** to `app_router.dart`: `GoRoute(path: '/mood-wellness', builder: ...)``
3. **Structure:** `CustomScrollView` with `SliverAppBar` + `SliverToBoxAdapter` sections
4. **Charts:** Use `CustomPainter` (following weight_nutrition_screen.dart pattern)
5. **Bottom sheets:** For chart point detail and mood logging
6. **Animation:** Use `flutter_animate` for fade-in on sections

---

## Critical Files for Implementation

1. **`lib/screens/mood_wellness/mood_wellness_screen.dart`** — New file to create (main screen implementation)

2. **`lib/router/app_router.dart`** — Add GoRoute for `/mood-wellness` pointing to MoodWellnessScreen

3. **`lib/screens/weight_nutrition/weight_nutrition_screen.dart`** — Reference for CustomScrollView + SliverAppBar structure, CustomPainter chart implementation, and bottom sheet patterns

4. **`.stitch/UX.md` (section 3.7)** — Source of truth for scaffold structure, sections, and interactions

5. **`lib/theme/app_theme.dart`** — Design tokens (colors, spacing, typography) for consistent styling

6. **`lib/providers/mood_entry_provider.dart`** — (if exists) Provider for MoodEntry state management; if not exists, note that MoodEntryProvider needs to be created or found in providers directory