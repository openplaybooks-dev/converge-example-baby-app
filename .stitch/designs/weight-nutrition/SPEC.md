# Weight & Nutrition Screen Specification

## 1. Screen Title

**Weight & Nutrition**

---

## 2. Purpose

Log daily weight, view progress chart, and read stage-specific nutrition tips. This screen provides a personal weight tracking hub for health-conscious mothers, allowing users to monitor weight trends over time and receive pregnancy-stage-appropriate nutritional guidance based on their current pregnancy week.

**Context:** Standalone push route from Browse tab. No bottom navigation visible on this screen. Primary interaction is adding new weight entries via FAB.

---

## 3. Route

`/weight-nutrition`

---

## 4. Widget Name

`WeightNutritionScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, FAB, primary actions |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `blushRose` | `#F9A8D4` | Secondary accent, trend highlights |
| `softMint` | `#6EE7B7` | Success states, positive delta indicators |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions, timestamps |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |
| `softCoral` | `#EF4444` | Error states, delete actions, negative delta |
| `warmWhite` | `#FFFFFF` | Bottom nav background, sheet surfaces |

### Typography (Nunito — Google Fonts)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 32sp | 700 | 40sp | Weight number display |
| `headlineMedium` | 24sp | 700 | 32sp | Section headers |
| `titleLarge` | 20sp | 600 | 28sp | AppBar title |
| `titleMedium` | 16sp | 600 | 24sp | Card titles, list item titles |
| `bodyLarge` | 16sp | 400 | 24sp | Primary body text |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, descriptions |
| `labelLarge` | 14sp | 600 | 20sp | Button text, chip labels |
| `caption` | 12sp | 500 | 16sp | Badges, timestamps |

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
| `sm` | 8dp (chips) |
| `md` | 12dp (small cards) |
| `lg` | 16dp (standard cards) |
| `pill` | 999dp (FAB, pills) |

### Elevation

| Token | Usage |
|---|---|---|
| `level0` | Scaffold background |
| `level1` | Cards, bottom nav |
| `level2` | FAB, bottom sheets |

### Motion

| Token | Duration | Curve |
|---|---|---|
| `durationShort` | 200ms | `Curves.easeOut` |
| `durationMedium` | 300ms | `Curves.easeInOut` |
| Stagger delay | 50ms between items | — |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `CustomScrollView` body
- `SliverAppBar`: Title "Weight & Nutrition", back button (white/lavender arrow), no trailing icons, collapsing on scroll
- `BottomNavigationBar`: Hidden (as per UX spec)
- `FAB`: `+` icon to log today's weight, positioned bottom-right with safe area respect

### AppBar Behavior

- Background: `lavenderBloom` (#7C3AED)
- Title: "Weight & Nutrition" (SemiBold 20sp, white)
- Leading: Back button with 48dp touch target
- Scroll behavior: Collapses on scroll, shows minimal version at scroll extreme

### Body Layout

- `CustomScrollView` with `SliverAppBar` and `SliverList` body
- Screen horizontal padding: 16dp from each edge
- Section vertical spacing: 24dp between major sections
- Bottom padding: 100dp to clear FAB and safe area

### FAB Specifications

- Size: 56dp diameter
- Background: `lavenderBloom` (#7C3AED)
- Icon: White, 24dp `Icons.add`
- Shadow: Medium diffused shadow (12dp blur)
- Press feedback: 200ms scale to 90%
- Position: Bottom-right, 16dp from edges, respects safe area bottom
- Appears with 200ms fade-in

---

## 7. Sections

### Section 1: Progress Chart

**Description:** Line chart displaying weight over time with toggle options to filter by 1 week, 1 month, or all time.

**Widget Type:** `SliverToBoxAdapter` containing a `Card` with a line chart widget (e.g., `fl_chart`)

**Layout:** Full-width card with 16dp internal padding, 16dp corner radius.

**Components:**
- Section header: "Weight Progress" (`headlineMedium`, 24sp)
- Toggle chips row: "1W" / "1M" / "All" — horizontally arranged, 8dp gap
  - Default selected: "1W"
  - Selected chip: `lavenderBloom` background at 15% opacity with `lavenderBloom` text
  - Unselected chip: `stone100` background, `stoneGrey` text
- Line chart:
  - X-axis: Date labels (formatted as "MMM d")
  - Y-axis: Weight in user's preferred unit (kg/lbs from `UserPreferences`)
  - Line color: `lavenderBloom`
  - Fill: Gradient from `lavenderBloom` at 20% opacity to transparent
  - Data points: Small dots, 4dp diameter
  - Grid lines: `mistyBorder` at 50% opacity
- Touch interaction: Show tooltip with exact value on tap/drag

**Data Requirements:**
- `WeightEntry` list from `WeightEntryProvider`, filtered by selected time range
- `UserPreferences.units` for y-axis label formatting

**Interactive Elements:**
- Tap toggle chip → re-render chart with filtered data
- Drag on chart → show tooltip with date and weight

---

### Section 2: Latest Entry Card

**Description:** Prominent card showing today's weight entry with delta from the previous entry.

**Widget Type:** `SliverToBoxAdapter` containing a `Card` with `Column` layout

**Layout:** Full-width card with 16dp internal padding, 16dp corner radius.

**Components:**
- Card background: `morningMist` (#FAFAFA), soft shadow
- "Today's Weight" label (`caption`, `stoneGrey`)
- Weight display: Large number (`displayLarge`, `deepGraphite`) with unit suffix ("kg" or "lbs")
- Delta row: Arrow icon + delta value + "from last entry"
  - Positive delta: `softCoral` text, up-arrow icon
  - Negative delta: `softMint` text, down-arrow icon
  - Zero delta: `stoneGrey` text, horizontal arrow
- Timestamp: "Logged at [time]" (`caption`, `stoneGrey`)
- Empty state: "No weight logged today" message with "Tap + to add" subtitle

**Data Requirements:**
- Most recent `WeightEntry` from `WeightEntryProvider`
- Previous `WeightEntry` for delta calculation
- `UserPreferences.units` for unit display

**Interactive Elements:**
- None (display-only card)

---

### Section 3: Nutrition Tips Card

**Description:** Stage-specific nutrition tips based on the user's current pregnancy week, pulled from `WeekContent.nutritionTips`.

**Widget Type:** `SliverToBoxAdapter` containing a `Card` with `Column` layout

**Layout:** Full-width card with 16dp internal padding, 16dp corner radius. Background: `lavenderTint` for subtle differentiation.

**Components:**
- Header row: "Nutrition Tips" (`titleMedium`) + week badge ("Week [N]" pill, `lavenderBloom` background, white text)
- Tip list: `BulletList` of 3-5 tip items from `WeekContent.nutritionTips`
- Each tip item: Small dot (blushRose) + tip text (`bodyMedium`)
- "Learn more" link/text button at bottom (optional for MVP)

**Data Requirements:**
- `currentWeek` from `PregnancyProfileProvider`
- `WeekContent` entry for `currentWeek` from static catalog
- `nutritionTips: List<String>` field

**Interactive Elements:**
- Tap card → expand to show full tips (if collapsed)

---

### Section 4: Weight Log List

**Description:** Scrollable list of all weight entries with date, weight value, and optional note.

**Widget Type:** `SliverList` with `delegate: SliverChildBuilderDelegate`

**Layout:** Vertical list with 12dp gap between items.

**Components:**
- Section header: "Weight Log" (`headlineMedium`, 24sp)
- Each log item Card:
  - Date: Formatted as "Mon, Jan 15, 2024" (`titleMedium`, `deepGraphite`)
  - Weight: "[value] [unit]" (`bodyLarge`, `deepGraphite`)
  - Note preview: First line of `notes` in `bodyMedium` `stoneGrey` if present
  - Time badge: Small pill with time ("9:30 AM") in `caption` style
- Empty state: Centered illustration with "No weight entries yet" message, "Tap + to log your first weight" subtitle
- Sorted by date descending (most recent first)

**Data Requirements:**
- All `WeightEntry` records from `WeightEntryProvider`
- Fields: `date`, `value`, `notes`
- `UserPreferences.units` for unit formatting

**Interactive Elements:**
- Long-press entry → edit/delete bottom sheet
- Tap entry → detail bottom sheet with full notes view

---

### Section 5 (Overlay): Add Weight Bottom Sheet

**Description:** Form for logging a new weight entry.

**Trigger:** Tap FAB `+`

**Widget Type:** `showModalBottomSheet` with `SingleChildScrollView`

**Layout:** Bottom sheet with 28dp top corner radius, handle bar, max 90% screen height.

**Components:**
- Handle bar: 40dp wide, 4dp tall, centered, Stone 300 color
- Title: "Log Weight" (`titleLarge`)
- Weight input field: Numeric `TextField` with floating label "Weight", suffix for unit (kg/lbs)
- Date picker field: "Date" label with date display, tap → `showDatePicker`, defaults to today
- Notes field: Multi-line `TextField` with 56dp min height, hint "Add notes (optional)..."
- Action buttons: "Cancel" (text) and "Save" (primary pill button)
- Form validation: Weight value required and must be > 0, date must be today or in the past

**Data Operations:**
- On save: `WeightEntryProvider.addEntry(value, date, notes)`

---

### Section 6 (Overlay): Entry Detail/Edit Bottom Sheet

**Description:** View, edit, or delete existing weight entry.

**Trigger:** Long-press log list item

**Components:**
- Header: Date (editable via date picker)
- Weight field (editable)
- Notes field (editable)
- Delete button: `softCoral` text button, triggers confirmation dialog
- "Save Changes" primary button

**Data Operations:**
- On save: `WeightEntryProvider.updateEntry(id, entry)`
- On delete: `WeightEntryProvider.deleteEntry(id)`

---

## 8. Data

### Entity: WeightEntry

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `date` | `DateTime` | Yes | Date of weight measurement |
| `value` | `double` | Yes | Weight value in user's preferred unit |
| `notes` | `String` | No | Optional notes about the entry |

### Provider: WeightEntryProvider

**State:**
- `entries: List<WeightEntry>` — all logged weight entries
- `selectedRange: ChartRange` — current chart filter (1W, 1M, All)

**Methods:**
- `addEntry(value, date, notes)` — adds new weight entry
- `updateEntry(id, entry)` — modifies existing entry
- `deleteEntry(id)` — removes entry
- `getLatestEntry()` — returns most recent entry
- `getEntriesForRange(range)` — filters entries by time range
- `calculateDelta()` — returns difference between latest and previous entry

**Computed:**
- `latestEntry` = entries sorted by date descending, first item
- `previousEntry` = entries sorted by date descending, second item (if exists)
- `delta` = latestEntry.value - previousEntry.value

### Related Entities

| Entity | Field Used | Source |
|---|---|---|
| `PregnancyProfile` | `currentWeek` | `PregnancyProfileProvider` |
| `WeekContent` | `nutritionTips` (keyed by week) | Static catalog |
| `UserPreferences` | `units` (kg/lbs) | `UserPreferencesProvider` |

---

## 9. Motion

### Entry Animations

- Screen pushes with 300ms slide + fade (standard page transition)
- Progress Chart card: 200ms fade-in on load
- Latest Entry card: 200ms fade-in after chart
- Nutrition Tips card: 200ms fade-in after Latest Entry
- Weight Log list items: Staggered reveal, 50ms delay between items, 200ms per item fade+slide

### Bottom Sheet Animations

- FAB → sheet: 250ms smooth deceleration slide-up
- Sheet dismiss: 200ms slide-down with fade
- Form field focus: 200ms border color transition

### Interactive Feedback

- List item tap: 200ms scale to 98% with shadow lift
- FAB press: 200ms scale to 90%, shadow intensifies
- Toggle chip selection: 150ms opacity transition
- Save button: 200ms scale to 95%

### FAB Appearance

- 200ms fade-in with subtle scale from 95% to 100%

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Weight & Nutrition, back button to return to Browse'` |
| Progress Chart | `'Weight progress chart, tap a chip to change time range'` |
| Chart chip (selected) | `'1 week selected, tap to view 1 week data'` |
| Chart chip (unselected) | `'${label} not selected, tap to view ${label} data'` |
| Latest Entry Card | `'Today's weight ${value} ${unit}, ${delta} ${direction} from last entry'` |
| Delta positive | `'${value} kilograms gained since last entry'` |
| Delta negative | `'${value} kilograms lost since last entry'` |
| Nutrition Tips | `'Nutrition tips for week ${week}'` |
| Weight log item | `'${date}: ${value} ${unit}${hasNote ? ', with note' : ''}'` |
| FAB | `'Log weight, double tap to open form'` |

### Focus Order

1. AppBar back button
2. Progress Chart (entire card)
3. Toggle chips (in order 1W → 1M → All)
4. Latest Entry card
5. Nutrition Tips card
6. Weight Log list items (in order)
7. FAB

### Contrast Notes

- `lavenderBloom` on white: ~5.2:1 (passes AA)
- `deepGraphite` on morningMist: ~12:1 (passes AAA)
- `stoneGrey` on white: ~4.7:1 (passes AA for body text)
- `softMint` on morningMist: ~4.5:1 (passes AA for positive delta)
- `softCoral` on morningMist: ~4.8:1 (passes AA for negative delta/errors)

### Screen Reader Support

- Announce weight logging success: "Weight entry saved"
- Announce deletion: "Weight entry deleted"
- Announce chart range change: "Showing ${range} data"
- Use `Semantics` to label chart data points

### Touch Target Compliance

- All interactive elements: 48dp minimum
- FAB: 56dp (exceeds minimum)
- Toggle chips: 32dp height, 12dp horizontal padding (exceeds minimum)
- Log items: Full card tap, 56dp+ height
- All buttons: 48dp minimum height

---

## 11. Anti-Patterns

**Do Not:**
- Use `GridView` for weight log list (simple `SliverList` is appropriate)
- Add bottom navigation (per UX spec, BottomNavigationBar is hidden)
- Use hard-coded weight units (read from `UserPreferences.units`)
- Place FAB in bottom center (bottom-right per design system)
- Show FAB on initial load without animation (fade-in over 200ms)
- Use pure black text on white/morningMist backgrounds
- Use Inter, Roboto, or any font other than Nunito
- Add shadows to AppBar (transparent/floating style)
- Use `Navigator.push` instead of `context.push` with GoRouter
- Skip safe area handling for FAB position
- Display empty state without illustration/guidance text
- Show negative delta styling for zero delta (use stoneGrey instead)
- Use generic chart colors not in the design system palette