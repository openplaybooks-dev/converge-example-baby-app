# Mood & Wellness — Screen Specification

## 1. Screen Title

**Mood & Wellness**

---

## 2. Purpose

Log daily moods and energy levels, visualize patterns over a 7-day trend, and receive contextual wellness recommendations. The screen serves as a dedicated space for emotional self-awareness during pregnancy — empowering mothers to track and understand their mental and physical energy patterns over time.

---

## 3. Route

```
/mood-wellness
```

**Parent Navigation:** Library tab (push route)

---

## 4. Widget Name

```dart
MoodWellnessScreen
```

---

## 5. Design Tokens

### Color Palette (from DESIGN.md)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, chart lines |
| `blushRose` | `#F9A8D4` | Mood emoji highlights, secondary accents |
| `softMint` | `#6EE7B7` | Positive indicators, high energy states |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions |
| `mistyBorder` | `#E5E7EB` | Dividers, subtle structure |
| `softCoral` | `#EF4444` | Error states |

### Typography (Nunito — Google Fonts)

| Style | Size | Weight | Usage |
|---|---|---|---|
| `headlineMedium` | 24sp | 700 | Screen title |
| `titleLarge` | 20sp | 600 | Section headers |
| `titleMedium` | 16sp | 600 | Card titles |
| `bodyLarge` | 16sp | 400 | Primary body text |
| `bodyMedium` | 14sp | 400 | Secondary text, notes |
| `labelLarge` | 14sp | 600 | Button labels, chip text |
| `caption` | 12sp | 400 | Timestamps, metadata |

### Spacing (8pt base grid)

| Token | Value |
|---|---|
| `xxs` | 4dp |
| `xs` | 8dp |
| `sm` | 12dp |
| `md` | 16dp |
| `lg` | 24dp |
| `xl` | 32dp |

### Corner Radius

| Token | Value |
|---|---|
| `sm` | 8dp |
| `md` | 12dp |
| `lg` | 16dp |
| `full` | 999dp (pills) |

---

## 6. Layout Rules

### Scaffold Structure

```
MoodWellnessScreen
├── AppBar ("Mood & Wellness", back button, transparent/lavender tint bg)
├── body: CustomScrollView
│   ├── SliverAppBar (collapsible, pinned)
│   │   └── Today's Mood Card (expanded height ~280dp)
│   └── SliverToBoxAdapter
│       ├── Mood Trend Chart Section
│       ├── Energy Trend Chart Section
│       └── Wellness Tip Section
└── BottomNavigationBar: Hidden
```

### AppBar Behavior

- **Title:** "Mood & Wellness", SemiBold 20pt, deepGraphite
- **Leading:** Back arrow (IconButton, 48pt touch target)
- **Background:** Transparent, blends into lavenderTint scaffold
- **Scroll behavior:** SliverAppBar collapses on scroll; title remains visible

### Body

- `CustomScrollView` with `SliverAppBar` (no FAB per UX spec)
- `SliverToBoxAdapter` wraps remaining sections below the collapsible header
- Each section separated by 24dp vertical spacing

### Bottom Navigation

- **Hidden** on this screen (per UX.md 3.7)
- Screen is reached via push route from Library tab

---

## 7. Sections

### Section 1: Today's Mood Card

**Description:** Large card with 5 emoji mood selectors in a horizontal row and an optional note field. The card serves as the primary interaction point for logging today's mood.

**Widget Type:** `SliverAppBar` expanded child (Container card)

**Layout:**
```
Card (rounded 16dp, morningMist bg, soft shadow)
├── Header row: "How are you feeling today?" title + date
├── Emoji row: 5 emoji buttons (😔 😕 😐 🙂 😊) evenly spaced
├── Selected indicator: highlighted emoji with blushRose border
└── Note field: optional TextField for context
```

**Emoji Mapping:**
| Emoji | Mood Score | Label |
|---|---|---|
| 😔 | 1 | Terrible |
| 😕 | 2 | Bad |
| 😐 | 3 | Okay |
| 🙂 | 4 | Good |
| 😊 | 5 | Great |

**Data Requirements:**
- Reads `todayMood` from `MoodEntryProvider`
- Writes new mood log on emoji tap via `MoodEntryProvider.logMood(score)`
- If mood already logged today, show the selected emoji pre-highlighted

**Interactive Elements:**
- Tap emoji → `MoodEntryProvider.logMood(score)` + visual highlight
- Tap note field → expands for text input (max 200 characters)
- Tap outside deselects note field

**States:**
- **Default:** No mood logged today, all emojis neutral
- **Logged:** Selected emoji highlighted with blushRose border and subtle scale
- **Loading:** Emoji tap shows 200ms ripple before confirmation

---

### Section 2: Mood Trend Chart

**Description:** Line chart showing 7-day mood score history. The chart is interactive — tapping a data point reveals a bottom sheet with that day's details.

**Widget Type:** CustomPaint line chart inside a Card container

**Layout:**
```
Card (rounded 16dp, morningMist bg)
├── Section header: "Mood Trend" + toggle chips (1W / 1M / All)
├── Chart area: 200dp height, CustomPaint line chart
│   ├── X-axis: 7 day labels (Mon, Tue, Wed, etc.)
│   ├── Y-axis: 1-5 scale with emoji labels
│   └── Line: lavenderBloom colored, 2dp stroke, smooth curve
├── Legend: "Score" label + 5-dot color guide
└── Tap target: entire chart is tappable
```

**Data Requirements:**
- Reads `MoodEntryProvider.entries` last 7 days (filtered by `date`)
- Mood scores 1-5 mapped to emoji at Y-axis positions
- Data points connected with smooth bezier curves

**Toggle Behavior:**
- `1W` — Last 7 days (default)
- `1M` — Last 30 days (shows more data points)
- `All` — All historical entries
- Active toggle has lavenderBloom bg at 15% opacity

**Interactive Elements:**
- Tap data point → bottom sheet with day detail (date, mood score, emoji, note if exists)
- Toggle chip tap → re-renders chart with new time range

**Chart Style:**
- Line color: `lavenderBloom` (#7C3AED)
- Line stroke: 2dp
- Data point dots: 6dp circles at each entry
- Empty state: "No mood data yet" centered text

---

### Section 3: Energy Trend Chart

**Description:** Line chart showing 7-day energy level history. Structure mirrors the Mood Trend Chart but tracks energy instead of mood.

**Widget Type:** CustomPaint line chart inside a Card container

**Layout:**
```
Card (rounded 16dp, morningMist bg)
├── Section header: "Energy Trend" + toggle chips (1W / 1M / All)
├── Chart area: 200dp height, CustomPaint line chart
│   ├── X-axis: 7 day labels
│   ├── Y-axis: 1-5 scale with energy descriptors
│   └── Line: softMint (#6EE7B7) colored, 2dp stroke
├── Legend: "Energy" label + 5-dot color guide
└── Tap target: entire chart is tappable
```

**Data Requirements:**
- Reads `MoodEntryProvider.entries` last 7 days
- Energy levels 1-5 mapped to descriptors at Y-axis positions

**Y-Axis Labels:**
| Score | Label |
|---|---|
| 1 | Very Low |
| 2 | Low |
| 3 | Moderate |
| 4 | High |
| 5 | Very High |

**Interactive Elements:**
- Tap data point → bottom sheet with day detail (date, energy level, note if exists)
- Toggle chip tap → re-renders chart with new time range

**Chart Style:**
- Line color: `softMint` (#6EE7B7)
- Line stroke: 2dp
- Data point dots: 6dp circles

---

### Section 4: Wellness Tip

**Description:** Contextual recommendation card that analyzes recent mood/energy patterns and suggests a gentle wellness nudge.

**Widget Type:** Card with expandable content

**Layout:**
```
Card (rounded 16dp, morningMist bg)
├── Header row: "Wellness Tip" title + lightbulb icon
├── Tip text: Contextual recommendation (2-3 sentences)
├── Category badge: "Mood" / "Energy" / "General" chip
└── Expand trigger: Tap anywhere on card to expand
```

**Tip Generation Logic (Rule-Based):**
- If average mood < 3 over past 7 days → "Your mood has been low lately. Consider a gentle breathing exercise or a short walk outside."
- If average energy < 3 over past 7 days → "Your energy levels seem to be dipping. Remember to stay hydrated and take short breaks throughout the day."
- If mood is high but energy is low → "You've been feeling good emotionally, but energy is lagging. Listen to your body and rest when needed."
- Default → "Regular mood check-ins help you notice patterns. Keep up the great work tracking your wellness!"

**Data Requirements:**
- Reads `MoodEntryProvider.entries` last 7 days
- Computes average moodScore and average energyLevel
- Selects appropriate tip from static catalog

**Interactive Elements:**
- Tap card → expands to show full recommendation (up to 100 characters additional detail)
- Tap category badge → no action (informational only)

**States:**
- **Collapsed:** Shows tip preview (max 2 lines)
- **Expanded:** Shows full tip text with additional context
- **No Data:** Shows generic tip "Log your mood to receive personalized wellness tips."

---

## 8. Data

### Entity: MoodEntry

```dart
class MoodEntry {
  final DateTime date;
  final int moodScore;    // 1-5 scale
  final int energyLevel;  // 1-5 scale
  final String? note;
}
```

### Provider: MoodEntryProvider

**Read Operations:**
- `todayMood` → MoodEntry? — Today's mood entry (if exists)
- `entries` → List<MoodEntry> — All mood entries sorted by date
- `entriesInRange(start, end)` → List<MoodEntry> — Entries within date range

**Write Operations:**
- `logMood(int score)` → void — Logs/updates today's mood score
- `logEnergy(int level)` → void — Logs/updates today's energy level
- `addNote(String note)` → void — Adds/updates note for today

### Screen Data Dependencies

| Section | Data Source | Fields Used |
|---|---|---|
| Today's Mood Card | `MoodEntryProvider.todayMood` | `moodScore`, `note` |
| Mood Trend Chart | `MoodEntryProvider.entriesInRange` | `date`, `moodScore` |
| Energy Trend Chart | `MoodEntryProvider.entriesInRange` | `date`, `energyLevel` |
| Wellness Tip | `MoodEntryProvider.entries` (last 7 days) | `moodScore`, `energyLevel` |

---

## 9. Motion

### Entry Animations

| Element | Animation | Duration | Curve |
|---|---|---|---|
| Today's Mood Card | Fade + slide up | 300ms | easeOut |
| Mood Trend Chart | Fade + slide up (staggered 50ms after card) | 300ms | easeOut |
| Energy Trend Chart | Fade + slide up (staggered 50ms after mood chart) | 300ms | easeOut |
| Wellness Tip | Fade + slide up (staggered 50ms after energy chart) | 300ms | easeOut |

### Micro-Interactions

| Interaction | Animation | Duration | Curve |
|---|---|---|---|
| Emoji tap | Scale to 95% + color fill | 200ms | easeOut |
| Toggle chip select | Background color fade | 150ms | easeInOut |
| Card expand | Height + content fade | 250ms | easeInOut |
| Chart data point tap | Scale pulse on dot | 200ms | easeOut |

### Page Transitions

- **Enter:** Push from Library tab — 300ms slide from right + fade
- **Exit:** Swipe-back or back button — 300ms slide to right + fade

---

## 10. Accessibility

### Semantics Labels

| Element | Semantics Label |
|---|---|
| Mood emoji 😔 | "Terrible mood, tap to log" |
| Mood emoji 😕 | "Bad mood, tap to log" |
| Mood emoji 😐 | "Okay mood, tap to log" |
| Mood emoji 🙂 | "Good mood, tap to log" |
| Mood emoji 😊 | "Great mood, tap to log" |
| Mood chart | "Mood trend chart showing 7 day history" |
| Energy chart | "Energy trend chart showing 7 day history" |
| Wellness tip card | "Wellness tip: [tip text]" |

### Focus Order

1. AppBar back button
2. Today's Mood Card emoji buttons (left to right: 😔 😕 😐 🙂 😊)
3. Note text field
4. Mood chart toggle chips
5. Energy chart toggle chips
6. Wellness tip card

### Contrast Notes

- All text meets WCAG AA contrast (4.5:1 for body, 3:1 for large text)
- Emoji buttons have 48pt minimum touch targets
- Chart lines use lavenderBloom on morningMist — sufficient contrast
- Focus indicators use 2dp blushRose outline

---

## 11. Anti-Patterns

**DO NOT:**
- Use default Flutter colors — all colors from design token palette
- Add a FAB — this screen has no FAB per UX spec
- Show BottomNavigationBar — it is hidden
- Use sharp corners — all cards use 16dp radius
- Display raw numbers on chart axes — use emoji/text labels
- Use Inter or Roboto — Nunito only
- Show gradients — flat colors only
- Use touch targets smaller than 48pt
- Place critical actions outside thumb zone