# SPEC.md — My Pregnancy (`/pregnancy-progress`)

## 1. Screen Title

**My Pregnancy** — Week-by-week pregnancy progress viewer

---

## 2. Purpose

The Pregnancy Progress screen allows expecting mothers to explore their pregnancy journey week by week through a horizontal swiper interface. It provides:

- At-a-glance view of current pregnancy week with fruit-size comparison
- Body change expectations for each week
- Baby development milestones
- Actionable self-care tips tailored to each week
- Due date tracking with countdown and trimester indicator

**Why it exists:** Replaces uncertainty with knowledge — mothers can swipe to any week to understand what's happening in their body and with their baby, building confidence throughout the journey.

---

## 3. Route

```
/pregnancy-progress
```

- **Parent:** Home tab (`/`)
- **Navigation type:** Push (no bottom nav, no FAB)
- **Swipe-back:** Returns to Home

---

## 4. Widget Name

```
PregnancyProgressScreen
```

File: `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`

---

## 5. Design Tokens

### Colors

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar background, primary actions |
| `blushRose` | `#F9A8D4` | Secondary accent, fruit emoji tints, mood highlights |
| `softMint` | `#6EE7B7` | Success states, positive indicators |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions, timestamps |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |
| `warmWhite` | `#FFFFFF` | Bottom nav background, sheets, FAB surfaces |

### Typography (Nunito)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 57pt | Bold (700) | 64pt | Week number hero |
| `headlineMedium` | 28pt | SemiBold (600) | 36pt | Screen title |
| `titleLarge` | 22pt | SemiBold (600) | 28pt | Section headers |
| `titleMedium` | 16pt | Medium (500) | 24pt | Subtitles, list item titles |
| `bodyLarge` | 16pt | Regular (400) | 24pt | Primary body text, descriptions |
| `bodyMedium` | 14pt | Regular (400) | 20pt | Secondary text, bullet items |
| `labelLarge` | 14pt | SemiBold (600) | 20pt | Button labels, chips |
| `caption` | 11pt | Medium (500) | 16pt | Badges, timestamps |

### Spacing (8pt base)

| Token | Value |
|---|---|
| `xxs` | 4dp |
| `xs` | 8dp |
| `sm` | 12dp |
| `md` | 16dp |
| `lg` | 24dp |
| `xl` | 32dp |
| `xxl` | 48dp |

### Corner Radius

| Token | Value |
|---|---|
| `sm` | 8dp |
| `md` | 12dp |
| `lg` | 16dp |
| `full` | 999dp (pills) |

### Motion

| Token | Value |
|---|---|
| `durationShort` | 200ms |
| `durationMedium` | 300ms |
| `easingStandard` | `Curves.easeInOut` |

---

## 6. Layout Rules

### Scaffold Structure

```
Scaffold
├── AppBar (title: "My Pregnancy", no elevation, Lavender Tint background)
│   └── Back button (leading) → returns to Home
├── Body: PageView (week-by-week swiper)
│   └── Each page: SingleChildScrollView
│       ├── WeekHeroCard (full-width, ~40% screen height)
│       ├── BodyChangesCard
│       ├── BabyDevelopmentCard
│       └── SelfCareTipsCard
└── Bottom: DueDateSummaryCard (pinned, always visible)
```

### AppBar
- **Height:** Standard AppBar (56dp)
- **Background:** Lavender Tint (`#F5F3FF`)
- **Title:** "My Pregnancy", SemiBold 20pt, Deep Graphite
- **Leading:** Back arrow icon with 48dp touch target
- **Elevation:** 0 (transparent, blends with scaffold)

### Body (PageView)
- **Widget:** `PageView` with `PageController`
- **Physics:** `PageScrollPhysics` (snaps to pages)
- **Initial page:** Current pregnancy week from `PregnancyProfileProvider`
- **Swipe direction:** Horizontal (left = earlier weeks, right = later weeks)
- **Cache:** Keep 1 page on each side (`PageView.cacheExtent`)

### Bottom Card (Due Date Summary)
- **Position:** Pinned at bottom, above safe area
- **Height:** ~120dp content + bottom safe area
- **Background:** Warm White
- **Corner radius:** Top corners 28dp (bottom sheet style)
- **Shadow:** Soft diffused, 16dp blur, 4dp offset-y

---

## 7. Sections

### 7.1 Week Hero Card

**Description:** Full-width card displaying the current pregnancy week with visual fruit-size comparison and countdown to due date.

**Widget type:** `Container` with `BoxDecoration` (rounded card, soft shadow)

**Layout:**
```
WeekHeroCard
├── FruitEmoji (centered, 80dp size) — e.g., "🍅" for week 12
├── WeekNumberText ("Week 12", displayLarge 57pt)
├── TrimesterBadge ("Second Trimester", caption pill)
├── CountdownText ("18 weeks to go", bodyMedium, stoneGrey)
└── DueDateText ("Due January 15, 2026", caption, stoneGrey)
```

**Data:**
- `currentWeek` from `PregnancyProfileProvider`
- Fruit size mapping: static catalog (week 4 = poppy seed, week 12 = lime, etc.)
- `dueDate` from `PregnancyProfileProvider`
- Trimester calculated from week number (1-13 = First, 14-26 = Second, 27-40 = Third)

**Interactive elements:** None (static display card)

### 7.2 Body Changes Card

**Description:** Bulleted list of physical changes the mother may experience during this pregnancy week.

**Widget type:** `Card` with `Column` + `Bullets` children

**Layout:**
```
BodyChangesCard (Card, lg radius)
├── SectionHeader ("Body Changes", titleLarge)
└── BulletList (ListView, no scroll, bodyMedium items)
    ├── Bullet item: "Your uterus is now about the size of a grapefruit"
    ├── Bullet item: "You may experience mild cramping or round ligament pain"
    └── ...
```

**Data:** Static `WeekContent.bodyChanges[week]` catalog (List<String>)

**Interactive elements:** None (read-only card)

### 7.3 Baby Development Card

**Description:** Paragraph describing fetal development milestones for the current week.

**Widget type:** `Card` with `Column`

**Layout:**
```
BabyDevelopmentCard (Card, lg radius)
├── SectionHeader ("Baby's Development", titleLarge)
└── BodyText (bodyLarge, Deep Graphite)
    "Your baby is now about 2 inches long — the size of a plum! "
    "Fingers and toes are fully formed, and tooth buds are appearing "
    "beneath the gums..."
```

**Data:** Static `WeekContent.babyDevelopment[week]` catalog (String)

**Interactive elements:** None (read-only card)

### 7.4 Self-Care Tips Card

**Description:** Three actionable self-care tips for the current week. Each tip can be tapped to expand and show more detail.

**Widget type:** `Card` with `Column` of expandable `TipTile` widgets

**Layout:**
```
SelfCareTipsCard (Card, lg radius)
├── SectionHeader ("Self-Care Tips", titleLarge)
└── TipTile (expandable)
    ├── TipNumber (1, 2, 3 — blushRose circle)
    ├── TipTitle (titleMedium)
    └── TipDetail (expandable, bodyMedium) — shows on tap
```

**Data:** Static `WeekContent.selfCareTips[week]` catalog (List<SelfCareTip>)

**Interactive elements:**
- `TipTile` is tappable — on tap, expands/collapses `TipDetail`
- Expansion animation: 200ms ease-out, height transition
- Only one tip expanded at a time (accordion behavior)

### 7.5 Due Date Summary Card (Bottom Pinned)

**Description:** Fixed bottom card showing due date, days remaining, and current trimester badge.

**Widget type:** `Container` with decorative top corners (28dp radius)

**Layout:**
```
DueDateSummaryCard (bottom pinned)
├── TrimesterBadge (left, full pill: "Second Trimester")
├── DueDateLabel ("Due Date", caption, stoneGrey)
├── DueDateValue ("January 15, 2026", titleMedium)
└── DaysRemaining ("42 days remaining", bodyMedium, softMint for positive)
```

**Data:** `dueDate` from `PregnancyProfileProvider`

**Interactive elements:** None (read-only summary)

---

## 8. Data

### Entities

#### `PregnancyProfile`
| Field | Type | Source |
|---|---|---|
| `dueDate` | `DateTime` | `PregnancyProfileProvider` |
| `lastPeriodDate` | `DateTime` | `PregnancyProfileProvider` |
| `currentWeek` | `int` (computed) | `(today - dueDate + 280 days) / 7` |

#### `WeekContent` (static catalog, keyed by week 1-40)
| Field | Type |
|---|---|
| `fruitEmoji` | `String` |
| `fruitSize` | `String` |
| `bodyChanges` | `List<String>` |
| `babyDevelopment` | `String` |
| `selfCareTips` | `List<SelfCareTip>` |

#### `SelfCareTip`
| Field | Type |
|---|---|
| `title` | `String` |
| `detail` | `String` |

---

## 9. Motion

### Page Transitions
- **Type:** Horizontal slide with PageView default physics
- **Duration:** 300ms (PageView built-in)
- **Curve:** `Curves.easeInOut`

### Card Entrance
- **Type:** Fade + slight upward slide
- **Duration:** 300ms
- **Delay:** 50ms stagger between cards
- **Curve:** `Curves.easeOut`

### Self-Care Tip Expansion
- **Type:** Height animation with fade
- **Duration:** 200ms
- **Curve:** `Curves.easeOut`

### Bottom Card
- **Type:** No entrance animation (always visible)
- **Shadow:** Subtle pulse on week change — 200ms shadow intensity increase/decrease

---

## 10. Accessibility

### Semantic Labels
- **Week Hero:** `"Pregnancy week {n}, {fruitSize} size, {countdown} until due date"`
- **Body Changes:** `"Body changes this week: {count} items"`
- **Baby Development:** `"Baby development for week {n}: {description excerpt}"`
- **Self-Care Tip:** `"Self-care tip {n}: {title}. Tap to expand"`
- **Due Date Summary:** `"Due date: {date}, {days} days remaining, {trimester}"`
- **PageView swipe:** `"Week {n} of 40. Use swipe gestures to navigate weeks"`

### Focus Order
1. Back button (AppBar leading)
2. Week Hero (implicitly focusable as first content)
3. Body Changes card
4. Baby Development card
5. Self-Care Tips (each tip focusable in order)
6. Due Date Summary card

### Contrast Notes
- All text meets WCAG AA contrast (4.5:1 minimum for body, 3:1 for large text)
- Deep Graphite (#1F2937) on Morning Mist (#FAFAFA) = 12.6:1 ✓
- Stone Grey (#6B7280) on Morning Mist = 4.7:1 ✓
- White on Lavender Bloom = 4.2:1 ✓

---

## 11. Anti-Patterns

### Banned
- **No default platform colors** — all colors from design token palette
- **No arbitrary text sizing** — use type scale (57pt hero, 28pt title, 22pt section header, 16pt body)
- **No inconsistent spacing** — use 8pt base unit
- **No bottom nav** — this screen hides bottom navigation per spec
- **No FAB** — this screen has no FAB per spec
- **No hardcoded week content** — all week content from `WeekContent` catalog
- **No SliverAppBar inside PageView** — incompatible scroll physics; use standard AppBar
- **No touch targets under 48dp**
- **No pure black (#000000)** — use Deep Graphite (#1F2937)
- **No pure white (#FFFFFF) for body text** — use Deep Graphite on light surfaces

### Constraints
- PageView cannot be nested inside another scrollable that conflicts (no SliverAppBar in same scaffold)
- Due Date Summary must not overlap content when keyboard is visible
- Week navigation must not reset expanded tip state (accordion local to each week's tip set)