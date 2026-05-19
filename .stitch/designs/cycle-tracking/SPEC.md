# Cycle Tracking Screen Specification

## 1. Screen Title

**Cycle Tracking**

---

## 2. Purpose

Log menstrual cycles, view ovulation predictions, and manage cycle-related reminders. This screen provides a personal tracking hub for reproductive health outside of pregnancy tracking — allowing users to monitor cycle patterns, predict fertile windows, and maintain cycle history for health insights.

**Context:** Standalone push route from Browse tab. No bottom navigation visible on this screen. Primary interaction is adding new cycle entries via FAB.

---

## 3. Route

`/cycle-tracking`

---

## 4. Widget Name

`CycleTrackingScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, FAB, primary actions |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `blushRose` | `#F9A8D4` | Secondary accent, fertility window highlights |
| `softMint` | `#6EE7B7` | Success states, completed indicators |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions, timestamps |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |
| `softCoral` | `#EF4444` | Error states, delete actions |
| `warmWhite` | `#FFFFFF` | Bottom nav background, FAB surface |

### Typography (Nunito — Google Fonts)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 32sp | 700 | 40sp | Day count numbers |
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

- `Scaffold` with `ListView` body
- `AppBar`: Title "Cycle Tracking", back button (white/lavender arrow), no trailing icons
- `BottomNavigationBar`: Hidden (as per UX spec)
- `FAB`: `+` icon to add new cycle entry, positioned bottom-right with safe area respect

### AppBar Behavior

- Background: `lavenderBloom` (#7C3AED)
- Title: "Cycle Tracking" (SemiBold 20sp, white)
- Leading: Back button with 48dp touch target
- Scroll behavior: Static AppBar (no SliverAppBar needed for simple ListView)

### Body Layout

- `ListView` with `padding: EdgeInsets.symmetric(horizontal: 16dp, vertical: 24dp)`
- Two major sections stacked vertically with 24dp spacing
- Bottom padding: 100dp to clear FAB and safe area

### FAB Specifications

- Size: 56dp diameter
- Background: `lavenderBloom` (#7C3AED)
- Icon: White, 24dp `Icons.add`
- Shadow: Medium diffused shadow (12dp blur)
- Press feedback: 200ms scale to 90%
- Position: Bottom-right, 16dp from edges, respects safe area bottom

---

## 7. Sections

### Section 1: Current Cycle Card

**Description:** Prominent card displaying days since last period, current cycle day, and ovulation window prediction.

**Widget Type:** `Card` with `Column` layout inside `SliverToBoxAdapter`

**Layout:** Full-width card with 16dp internal padding.

**Components:**
- Card background: `morningMist` (#FAFAFA), 16dp corner radius, soft shadow
- Cycle day badge: Pill-shaped chip with `lavenderBloom` background, white text "Day X"
- Days since period: Large number (`displayLarge`) with "days since last period" label
- Next period estimate: Row with calendar icon + date prediction
- Ovulation window: Row with `blushRose` background pill, egg/flower icon + "Fertile window: [date range]"
- Length indicator: Horizontal bar showing cycle progress (filled portion in lavender)

**Data Requirements:**
- `lastPeriodDate` from `CycleEntryProvider`
- `cycleLength` average from `CycleEntryProvider` history
- Ovulation calculation: `lastPeriodDate + cycleLength - 14` (assumed ovulation day)
- Fertile window: `ovulationDay - 3` to `ovulationDay + 1`

**Interactive Elements:**
- Tap ovulation window → detail bottom sheet explaining fertile window calculation

---

### Section 2: Cycle History List

**Description:** Chronological list of all logged cycles with visual length indicators.

**Widget Type:** `SliverList` with `delegate: SliverChildBuilderDelegate`

**Layout:** Vertical list with 12dp gap between items.

**Components:**
- Section header: "Cycle History" (`headlineMedium`, 24sp)
- Each history item Card:
  - Start date (formatted: "Jan 15 - Feb 12, 2024") with `titleMedium` style
  - Cycle length badge: "28 days" pill with `lavenderTint` background
  - Visual bar: Horizontal bar showing relative cycle length (normalized to average)
  - Notes preview: First line of notes in `bodyMedium` stoneGrey if present
  - Irregular indicator: Small `blushRose` dot if `isIrregular = true`
- Empty state: Centered illustration with "No cycles logged yet" message, "Tap + to add your first cycle" subtitle
- Add history button at bottom (text button, not part of FAB flow)

**Data Requirements:**
- All `CycleEntry` records from `CycleEntryProvider`
- Sorted by `startDate` descending (most recent first)
- `startDate`, `endDate`, `cycleLength`, `notes`, `isIrregular` fields

**Interactive Elements:**
- Long-press entry → edit/delete bottom sheet
- Tap entry → detail bottom sheet with full notes view

---

### Section 3 (Overlay): New Cycle Entry Bottom Sheet

**Description:** Form for logging a new cycle start date and optional notes.

**Trigger:** Tap FAB `+`

**Widget Type:** `showModalBottomSheet` with `SingleChildScrollView`

**Layout:** Bottom sheet with 28dp top corner radius, handle bar, max 90% screen height.

**Components:**
- Handle bar: 40dp wide, 4dp tall, centered, Stone 300 color
- Title: "Log Cycle" (`titleLarge`)
- Date picker field: "Period Started" label with date display, tap → `showDatePicker`
- Length field (optional): "Cycle Length (days)" numeric input, pre-filled with average
- Notes field: Multi-line `TextField` with 56dp min height, hint "Add notes..."
- Irregular toggle: `Switch` with label "Irregular cycle"
- Action buttons: "Cancel" (text) and "Save" (primary pill button)
- Form validation: Period date required, must be before today

**Data Operations:**
- On save: `CycleEntryProvider.addEntry(startDate, endDate?, length, notes, isIrregular)`

---

### Section 4 (Overlay): Entry Detail/Edit Bottom Sheet

**Description:** View, edit, or delete existing cycle entry.

**Trigger:** Tap or long-press history item

**Components:**
- Header: Start date (editable via date picker)
- Cycle length display (calculated from start/end dates or manual)
- Notes field (editable)
- Irregular flag toggle
- Delete button: `softCoral` text button, triggers confirmation dialog
- "Save Changes" primary button

---

### Section 5 (Overlay): Ovulation Detail Bottom Sheet

**Description:** Explains the ovulation prediction with educational content.

**Trigger:** Tap ovulation window row on Current Cycle Card

**Components:**
- Header: "Ovulation Prediction" with flower/egg icon
- Date display: Large centered date
- Explanation text: "Based on your cycle history, ovulation is expected around [date]. Your fertile window is [start] - [end]."
- Tip: "Track your cycles consistently for more accurate predictions"
- Close button

---

## 8. Data

### Entity: CycleEntry

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `startDate` | `DateTime` | Yes | First day of period |
| `endDate` | `DateTime` | No | Last day of period (can be inferred) |
| `cycleLength` | `int` | No | Manual override for cycle length |
| `notes` | `String` | No | User notes about this cycle |
| `isIrregular` | `bool` | No | Flag for irregular patterns |

### Provider: CycleEntryProvider

**State:**
- `entries: List<CycleEntry>` — all logged cycles
- `averageCycleLength: int` — calculated from entries (default 28)

**Methods:**
- `addEntry(entry)` — adds new cycle entry
- `updateEntry(id, entry)` — modifies existing entry
- `deleteEntry(id)` — removes entry
- `getCurrentCycle()` — returns most recent entry
- `getOvulationWindow()` — calculates fertile window based on average

**Computed:**
- `daysSinceLastPeriod` = today - lastPeriodDate
- `nextPeriodEstimate` = lastPeriodDate + averageCycleLength

---

## 9. Motion

### Entry Animations

- Screen pushes with 300ms slide + fade (standard page transition)
- Current Cycle Card: 200ms fade-in on load
- History list items: Staggered reveal, 50ms delay between items, 200ms per item fade+slide

### Bottom Sheet Animations

- FAB → sheet: 250ms smooth deceleration slide-up
- Sheet dismiss: 200ms slide-down with fade

### Interactive Feedback

- History item tap: 200ms scale to 98% with shadow lift
- FAB press: 200ms scale to 90%, shadow intensifies
- Save button: 200ms scale to 95%

### Pull-to-refresh

- Not applicable (cycle data doesn't change external to this screen)

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Cycle Tracking, back button to return to Browse'` |
| Current Cycle Card | `'Current cycle, day ${day} since last period, fertile window ${date range}'` |
| Days counter | `'${days} days since last period'` |
| Ovulation row | `'Tap to learn about your fertile window'` |
| FAB | `'Add new cycle entry, double tap to open form'` |
| History item | `'Cycle from ${startDate} to ${endDate}, ${length} days${isIrregular ? ', irregular' : ''}'` |

### Focus Order

1. AppBar back button
2. Current Cycle Card (entire card)
3. Ovulation window row (focusable for details)
4. History list items (in order)
5. FAB

### Contrast Notes

- `lavenderBloom` on white: ~5.2:1 (passes AA)
- `deepGraphite` on morningMist: ~12:1 (passes AAA)
- `stoneGrey` on white: ~4.7:1 (passes AA for body text)
- `blushRose` used at 20% opacity for fertile window background (not text)

### Screen Reader Support

- Announce cycle logging success: "Cycle entry saved"
- Announce deletion: "Cycle entry deleted"
- Use `Semantics` to label cycle progress visually

### Touch Target Compliance

- All interactive elements: 48dp minimum
- FAB: 56dp (exceeds minimum)
- History items: Full card tap, 56dp+ height
- All buttons: 48dp minimum height

---

## 11. Anti-Patterns

**Do Not:**
- Use `GridView` for history list (simple `ListView` is appropriate)
- Add bottom navigation (per UX spec, BottomNavigationBar is hidden)
- Show FAB on initial load with no animation (fade-in over 200ms)
- Use hard-coded cycle length (calculate from `CycleEntryProvider`)
- Place FAB in bottom center (bottom-right per design system)
- Use pure black text on white backgrounds
- Use Inter, Roboto, or any font other than Nunito
- Add shadows to AppBar (transparent/floating style)
- Use `Navigator.push` instead of `context.push` with GoRouter
- Skip safe area handling for FAB position
- Display empty state without illustration/guidance text