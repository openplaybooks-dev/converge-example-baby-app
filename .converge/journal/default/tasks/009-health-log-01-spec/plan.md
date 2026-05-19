# Plan: Spec: Health Log



Based on my analysis of the input files and existing patterns, I have a comprehensive understanding of the Health Log screen requirements. Here's the design specification:

---

# Health Log Screen Specification

## 1. Screen Title

**Health Log**

---

## 2. Purpose

A unified timeline view of all health entries including symptoms, doctor visits, and reminders. This screen serves as the central health journal for pregnant women to track their wellness journey, view patterns over time, and stay on top of health reminders. It aggregates data from three providers (`SymptomEntryProvider`, `DoctorVisitProvider`, `ReminderProvider`) into a single chronological feed.

**Context:** Push route from Library tab. BottomNavigationBar is hidden. Primary actions are adding new entries via FAB and filtering existing entries.

---

## 3. Route

`/health-log`

---

## 4. Widget Name

`HealthLogScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, FAB, primary actions |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `blushRose` | `#F9A8D4` | Secondary accent, mood-related items |
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
| `displayLarge` | 32sp | 700 | 40sp | Stats numbers |
| `headlineMedium` | 22sp | 600 | 28sp | Section headers |
| `titleLarge` | 20sp | 600 | 28sp | AppBar title |
| `titleMedium` | 16sp | 600 | 24sp | Entry titles, card titles |
| `bodyLarge` | 16sp | 400 | 24sp | Primary body text |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, descriptions |
| `labelLarge` | 14sp | 600 | 20pt | Button text, chip labels |
| `caption` | 11sp | 500 | 16sp | Badges, timestamps |

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
| `lg` | 16dp (standard cards) |
| `pill` | 999dp (FAB, pills) |

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
- `AppBar`: Title "Health Log", back button, trailing filter icon button
- `BottomNavigationBar`: Hidden (as per UX spec)
- `FAB`: `+` icon to add new entry, positioned bottom-right with safe area respect

### AppBar Behavior

- Background: `lavenderTint` (#F5F3FF)
- Title: "Health Log" (SemiBold 20sp, `deepGraphite`)
- Leading: Back button with 48dp touch target
- Trailing: Filter icon button (48dp touch target) to open filter options

### Body Layout

- `ListView` with `padding: EdgeInsets.symmetric(horizontal: 16dp, vertical: 24dp)`
- Summary stats banner at top (always visible)
- Timeline section below with chronological entries
- Bottom padding: 100dp to clear FAB and safe area

### FAB Specifications

- Size: 56dp diameter
- Background: `lavenderBloom` (#7C3AED)
- Icon: White, 24dp `Icons.add`
- Press feedback: 200ms scale to 90%
- Position: Bottom-right, 16dp from edges, respects safe area bottom

---

## 7. Sections

### Section 1: Summary Stats Banner

**Description:** Top banner displaying aggregate health metrics — total symptoms logged this week and next upcoming reminder.

**Widget Type:** `SliverToBoxAdapter` containing a horizontal card row

**Layout:** Full-width card with 16dp internal padding, horizontal arrangement of stat items.

**Components:**
- Card background: `morningMist` (#FAFAFA), 16dp corner radius, soft shadow
- Two stat items side-by-side:
  - Left: Symptom count badge with `lavenderBloom` icon + "X symptoms this week" text
  - Right: Next reminder with calendar icon + "Next: [reminder title] on [date]"
- If no entries exist: Show "No health entries yet" message

**Data Requirements:**
- `SymptomEntryProvider.entries` filtered for current week
- `ReminderProvider.reminders` filtered for `isEnabled=true`, ordered by date, first item

**Interactive Elements:**
- Tap symptom count → scrolls to first symptom entry in timeline
- Tap reminder → scrolls to that reminder entry in timeline

---

### Section 2: Timeline

**Description:** Mixed chronological list of all health entries (symptoms, doctor visits, reminders) sorted by date descending.

**Widget Type:** `SliverList` with `SliverChildBuilderDelegate`

**Layout:** Vertical list with 12dp gap between items, grouped by date.

**Components:**

Each timeline entry card:
- Entry type indicator: Left border accent (4dp wide)
  - SymptomEntry: `lavenderBloom`
  - DoctorVisit: `blushRose`
  - Reminder: `softMint`
- Entry date header: "Today", "Yesterday", or formatted date ("May 15, 2024")
- Entry content varies by type:

**SymptomEntry Card:**
- Symptom type name (`titleMedium`)
- Severity indicator: 1-3 dots or chips (mild/moderate/severe)
- Notes preview (`bodyMedium`, truncated to 1 line)
- Timestamp: "2:30 PM"

**DoctorVisit Card:**
- Doctor name (`titleMedium`)
- Visit purpose/notes (`bodyMedium`, truncated)
- Next visit date if set (caption with `softMint` accent)
- Timestamp

**Reminder Card:**
- Reminder title (`titleMedium`)
- Category badge chip
- Due date/time
- Enabled/disabled indicator

**Date Grouping:**
- Entries grouped by date with sticky date headers
- Date headers: `caption` style, `stoneGrey`, left-aligned

**Empty State:**
- Centered illustration placeholder
- "No health entries logged" message
- "Tap + to add your first entry" subtitle

**Data Requirements:**
- Combine entries from: `SymptomEntryProvider`, `DoctorVisitProvider`, `ReminderProvider`
- Sort all by date descending
- Fields per entity:
  - SymptomEntry: `date`, `symptomType`, `severity` (1-3), `notes`
  - DoctorVisit: `date`, `doctorName`, `notes`, `nextVisitDate`
  - Reminder: `title`, `date`, `category`, `isEnabled`

**Interactive Elements:**
- Tap entry → `overlay:symptom-detail` bottom sheet for symptoms, similar detail sheets for other types
- Long-press entry → edit/delete bottom sheet
- Pull-to-refresh → reloads all providers

---

### Section 3 (Overlay): Add Entry Bottom Sheet

**Description:** Entry type selector and form for creating new health entries.

**Trigger:** Tap FAB `+`

**Widget Type:** `showModalBottomSheet` with `SingleChildScrollView`

**Layout:** Bottom sheet with 28dp top corner radius, handle bar, max 90% screen height.

**Components:**
- Handle bar: 40dp wide, 4dp tall, centered, `stoneGrey` color
- Title: "Add Entry" (`titleLarge`)
- Entry type selector: 3 horizontal chips/cards
  - "Symptom" — symptom icon
  - "Doctor Visit" — medical icon  
  - "Reminder" — bell icon
- Form fields depend on selected type (see symptom-detail overlay for symptom form)
- Action buttons: "Cancel" (text), "Save" (primary pill button)
- Form validation per entry type

**Data Operations:**
- On save: Call appropriate provider's `addEntry()` method

---

### Section 4 (Overlay): Filter Options Bottom Sheet

**Description:** Filter timeline by entry type and date range.

**Trigger:** Tap filter icon in AppBar

**Widget Type:** `showModalBottomSheet` with `Column`

**Layout:** Bottom sheet with 28dp top corner radius, handle bar.

**Components:**
- Handle bar
- Title: "Filter Entries" (`titleLarge`)
- Entry type filter: Checkbox list
  - [ ] Symptoms
  - [ ] Doctor Visits
  - [ ] Reminders
- Date range: "This week", "This month", "All time" (chip selector)
- "Apply" primary button
- "Clear filters" text button

---

### Section 5 (Overlay): Entry Detail/Edit Bottom Sheet

**Description:** View, edit, or delete existing entries.

**Trigger:** Tap timeline entry

**Components (SymptomDetail overlay per screens.json):**
- Header: Entry type icon + date
- Symptom type display/edit
- Severity selector: 1-3 rating with labels (Mild, Moderate, Severe)
- Date picker
- Notes field (multi-line)
- Delete button (`softCoral` text button)
- Save button

---

## 8. Data

### Entity: SymptomEntry

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `date` | `DateTime` | Yes | Entry timestamp |
| `symptomType` | `String` | Yes | Type of symptom (e.g., "Headache", "Nausea") |
| `severity` | `int` (1-3) | Yes | 1=mild, 2=moderate, 3=severe |
| `notes` | `String` | No | Additional notes |

### Entity: DoctorVisit

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `date` | `DateTime` | Yes | Visit date |
| `doctorName` | `String` | Yes | Doctor or clinic name |
| `notes` | `String` | No | Visit notes |
| `nextVisitDate` | `DateTime` | No | Scheduled follow-up |

### Entity: Reminder

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `title` | `String` | Yes | Reminder title |
| `date` | `DateTime` | Yes | Reminder date/time |
| `category` | `String` | No | Category (e.g., "Medication", "Appointment") |
| `isEnabled` | `bool` | Yes | Whether reminder is active |

### Provider: SymptomEntryProvider

**State:**
- `entries: List<SymptomEntry>` — all logged symptoms

**Methods:**
- `addEntry(entry)` — adds new symptom entry
- `updateEntry(id, entry)` — modifies existing entry
- `deleteEntry(id)` — removes entry
- `getThisWeekEntries()` — filters entries to current week

### Provider: DoctorVisitProvider

**State:**
- `visits: List<DoctorVisit>` — all logged visits

**Methods:**
- `addVisit(visit)` — adds new visit
- `updateVisit(id, visit)` — modifies existing visit
- `deleteVisit(id)` — removes visit

### Provider: ReminderProvider

**State:**
- `reminders: List<Reminder>` — all reminders

**Methods:**
- `addReminder(reminder)` — adds new reminder
- `updateReminder(id, reminder)` — modifies existing reminder
- `deleteReminder(id)` — removes reminder
- `getUpcomingEnabled()` — returns enabled reminders sorted by date

---

## 9. Motion

### Entry Animations

- Screen pushes with 300ms slide + fade (standard page transition)
- Summary stats card: 200ms fade-in on load
- Timeline items: Staggered reveal, 50ms delay between items, 200ms per item fade+slide

### Bottom Sheet Animations

- FAB → sheet: 250ms smooth deceleration slide-up
- Sheet dismiss: 200ms slide-down with fade

### Interactive Feedback

- Entry card tap: 200ms scale to 98% with shadow lift
- FAB press: 200ms scale to 90%, shadow intensifies
- Filter chip selection: 150ms opacity/color transition
- Save button: 200ms scale to 95%

### Pull-to-refresh

- 150ms duration, quick snap
- Refresh indicator appears and dismisses quickly

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Health Log, back button to return to Library, filter button'` |
| Filter button | `'Filter entries, double tap to open filter options'` |
| Summary stats | `'Health summary, X symptoms this week, next reminder on [date]'` |
| FAB | `'Add new health entry, double tap to open form'` |
| Symptom entry | `'$symptomType, $severity severity, $notes, $time'` |
| Doctor visit | `'Doctor visit with $doctorName, $notes, $time'` |
| Reminder | `'$title reminder, $category, $date, ${isEnabled ? 'enabled' : 'disabled'}'` |
| Date header | `'$date, $count entries'` |

### Focus Order

1. AppBar (back button → filter button)
2. Summary stats card
3. Timeline entries (in date order, most recent first)
4. FAB

### Contrast Notes

- `lavenderBloom` on `lavenderTint`: ~4.5:1 (passes AA)
- `deepGraphite` on `morningMist`: ~12:1 (passes AAA)
- `stoneGrey` on white: ~4.7:1 (passes AA for body text)
- Entry type accent colors used as borders, not backgrounds, for visibility

### Screen Reader Support

- Announce entry added: "Health entry saved"
- Announce deletion: "Entry deleted"
- Announce filter applied: "Showing $filteredTypes entries"
- Use `Semantics` to label entry severity (e.g., "Severity: 2 out of 3, moderate")

### Touch Target Compliance

- All interactive elements: 48dp minimum
- FAB: 56dp (exceeds minimum)
- Timeline entries: Full card tap, 56dp+ height
- All buttons: 48dp minimum height
- Filter chips: 48dp minimum height

---

## 11. Anti-Patterns

**Do Not:**
- Use `GridView` for timeline (simple `ListView` with date grouping is appropriate)
- Add `BottomNavigationBar` (hidden per UX spec)
- Show FAB on initial load without animation (fade-in over 200ms)
- Mix entry types inconsistently — always show type indicator
- Use hard-coded symptom types (use provider data)
- Place FAB in bottom center (bottom-right per design system)
- Use pure black text on backgrounds
- Use Inter, Roboto, or any font other than Nunito
- Add shadows to AppBar (transparent/floating style)
- Use `Navigator.push` instead of `context.push` with GoRouter
- Skip safe area handling for FAB position
- Display empty state without illustration/guidance text
- Use gradients on cards — flat `morningMist` only
- Skip entry type indicator (accessibility issue)

---

## 12. Critical Files for Implementation

1. **`lib/router/app_router.dart`** — Add GoRoute entry for `/health-log` pointing to `HealthLogScreen`

2. **`lib/theme/app_theme.dart`** — Reference for design tokens (spacing `AppTheme.spaceMd`, colors `AppTheme.lavenderBloom`, typography via `Theme.of(context).textTheme`)

3. **`lib/screens/mindfulness/mindfulness_screen.dart`** — Reference implementation pattern for a push-screen with `Scaffold`, `AppBar`, `ListView` body, and card-based content with similar structure

4. **`.stitch/screens.json`** — Reference for screen definitions: Health Log features (`timeline`, `summary-stats`, `fab-add-entry`, `filter-options`) and overlay relationship (`symptom-detail` parent is `health-log`)

5. **`.stitch/UX.md`** — Reference for UX spec section 3.6 Health Log: scaffold structure, sections, data providers, and interaction patterns

---

## 13. Screen Structure

```
HealthLogScreen
├── Scaffold
│   ├── AppBar ("Health Log", back button, filter icon)
│   └── body: ListView
│       ├── SummaryStatsCard (SliverToBoxAdapter)
│       └── Timeline (SliverList)
│           ├── DateHeader ("Today" / "May 15, 2024")
│           └── HealthEntryCard × N
│               ├── SymptomEntryCard
│               ├── DoctorVisitCard
│               └── ReminderEntryCard
├── FAB (+) → AddEntrySheet
├── Filter icon → FilterSheet
└── Entry tap → SymptomDetailSheet / detail sheet
```