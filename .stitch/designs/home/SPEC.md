# Home Screen Specification

## 1. Screen Title

**Home**

---

## 2. Purpose

Central dashboard displaying today's snapshot — pregnancy progress at a glance, quick-log buttons for daily tracking, and personalized wellness nudges. This is the primary entry point that surfaces critical daily information without requiring navigation.

**Context:** Part of ShellRoute with BottomNavigationBar (4 tabs). This screen is the first thing users see when opening the app. All interactions on this screen are designed to be quick, glanceable, and actionable.

---

## 3. Route

`/` (root route)

---

## 4. Widget Name

`HomeScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, primary buttons, active nav indicator |
| `lavenderLight` | `#A78BFA` | Gradient ends, secondary lavender elements |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `blushRose` | `#F9A8D4` | Secondary accent, mood emoji backgrounds |
| `softMint` | `#6EE7B7` | Success states, completed checklist items |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions, inactive labels |
| `mistyBorder` | `#E5E7EB` | Borders, dividers, unselected chip borders |
| `softCoral` | `#EF4444` | Error states |
| `warmWhite` | `#FFFFFF` | Bottom nav background, card surfaces |

### Typography (Nunito — Google Fonts)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 32sp | 700 | 40sp | Hero week number display |
| `headlineMedium` | 24sp | 700 | 32sp | Section headers |
| `titleLarge` | 20sp | 600 | 28sp | AppBar title |
| `titleMedium` | 16sp | 600 | 24sp | Card titles, chip labels |
| `bodyLarge` | 16sp | 400 | 24sp | Body text, descriptions |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, metadata |
| `labelLarge` | 14sp | 600 | 20sp | Button text |
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
| `pill` | 999dp (pills, avatars) |

### Elevation

| Token | Usage |
|---|---|
| `level0` | Scaffold background |
| `level1` | Cards, bottom nav |
| `level2` | FAB, bottom sheets |

### Motion

| Token | Duration | Curve |
|---|---|---|
| `durationShort` | 200ms | `Curves.easeOut` |
| `durationMedium` | 300ms | `Curves.easeInOut` |
| `durationLong` | 400ms | `Curves.fastOutSlowIn` |
| Stagger delay | 50ms between items | — |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `CustomScrollView` body
- `SliverAppBar` with `pinned: true`, `expandedHeight: 280`, collapsing to `56` with week badge
- `BottomNavigationBar` visible (4 tabs, index 0 = Home active)
- No FAB on Home screen
- Safe area handling: 12dp top padding when status bar visible; bottom padding for home indicator

### AppBar Behavior

- Transparent background blending to `lavenderTint`
- Title: "Baby Bump" (SemiBold 20sp, `deepGraphite`)
- Leading: None (home screen)
- Trailing: Avatar icon button (48dp touch target)

### Body Layout

- `CustomScrollView` with `SliverAppBar` as first sliver
- Remaining content in `SliverToBoxAdapter` sections
- Horizontal padding: 16dp from each edge
- Section vertical spacing: 24dp between major sections
- Bottom padding: 80dp to clear bottom navigation

### Bottom Navigation

- 4 tabs: Home, Browse, Library, Profile
- Active indicator: pill shape with 15% opacity lavender background
- Active icon: filled, `lavenderBloom` color
- Inactive icon: outlined, `stoneGrey` color
- Touch target: 48dp minimum per tab item

---

## 7. Sections

### Section 1: Week Banner (SliverAppBar Expanded Content)

**Description:** Hero card displaying current pregnancy week, due date countdown, and fruit-size comparison.

**Widget Type:** `SliverAppBar` with expanded content containing `WeekBannerCard`

**Layout:** Centered column within expanded SliverAppBar area (280dp expanded height).

**Components:**
- Week badge chip (lavender background, white text, pill shape)
- Main card (`morningMist` background, 16dp radius, soft shadow)
- Fruit size emoji in gradient circle (blush to lavender-light)
- Week number (`displayLarge`, bold)
- Due date text (`bodyMedium`, `stoneGrey`)
- Countdown (`titleMedium`, `lavenderBloom`)
- Fruit size comparison chip (blush/20 background)

**Data Requirements:**
- `currentWeek` from `PregnancyProfileProvider`
- `dueDate` from `PregnancyProfileProvider`
- Fruit size mapping based on week (static catalog)

**Interactive Elements:** None (display only)

---

### Section 2: Mood Check-In Card

**Description:** Quick mood selector with 5 emoji options for today's mood logging.

**Widget Type:** `SliverToBoxAdapter` with `Card` containing `Row` of `IconButton` widgets

**Layout:** Card with horizontal `Row` of mood options, `spaceAround` distribution.

**Components:**
- Section header: "How are you feeling today?" (`titleMedium`)
- Date label (`caption`, `stoneGrey`)
- 5 mood emoji buttons in `spaceAround` Row
- Each button: emoji (32sp) + label (`caption`)
- Selected state: lavender ring + lavender text

**Data Requirements:**
- Today's date for date label
- `todayMood` from `MoodEntryProvider` (nullable, moodScore 1-5)

**Interactive Elements:**
- Tap emoji → triggers `MoodEntryProvider.logMood(score)` for corresponding 1-5 value
- Selected emoji persists and shows ring highlight

---

### Section 3: Today's Checklist

**Description:** Horizontal scrollable chips showing daily self-care tasks with completion state.

**Widget Type:** `SliverToBoxAdapter` with `SingleChildScrollView` (horizontal) containing `Row` of chips

**Layout:** Horizontal scroll with 16dp leading/trailing padding.

**Components:**
- Section header: "Today's Checklist" with progress badge "X of Y done"
- `ChecklistChip` for each item:
  - Completed: `softMint` background, mint border, checkmark icon, graphite text
  - Uncompleted: stone/10 background, `mistyBorder`, empty circle, stone text
- Default items: "Weight logged", "Mood checked", "Log symptoms", "Drink water"

**Data Requirements:**
- `checkedItems` from `SelfCareCheckStateProvider`
- Completion state persists across sessions

**Interactive Elements:**
- Tap chip → toggles completion state via `SelfCareCheckStateProvider.toggleItem(id)`
- Staggered entry animation: 50ms delay between each chip

---

### Section 4: Quick Actions

**Description:** 2x2 grid of primary action buttons for common logging and navigation tasks.

**Widget Type:** `SliverToBoxAdapter` with `GridView` (2 columns, cross-axis count)

**Layout:** 2-column grid with 12dp gap.

**Components:**
- Section header: "Quick Actions" (`titleMedium`)
- 4 action buttons in 2x2 grid:
  1. **Log Weight** (`lavenderBloom` bg, white icon+text) → navigates to `/weight-nutrition`
  2. **Log Mood** (`blushRose` bg, white icon+text) → navigates to `/mood-wellness`
  3. **Log Symptoms** (`warmWhite` bg, graphite icon+text, `mistyBorder`) → pushes symptom form overlay
  4. **View Education** (`warmWhite` bg, graphite icon+text, `mistyBorder`) → navigates to `/education`
- Each button: icon (32sp) + label (`labelLarge`), min height 88dp, 16dp radius

**Data Requirements:** None (static actions)

**Interactive Elements:**
- Tap button → corresponding navigation or overlay trigger
- Press feedback: 200ms scale to 95%

---

### Section 5: Weekly Tip

**Description:** Single card displaying a rotating wellness tip based on current week.

**Widget Type:** `SliverToBoxAdapter` with `Card` containing gradient background

**Layout:** Full-width card with 16dp horizontal padding.

**Components:**
- Gradient background (lavenderBloom to lavenderLight, 16dp radius)
- Info icon in white/20 circle (24dp)
- "Weekly Tip" label (`caption`, white/70)
- Tip title (`titleMedium`, white, semibold)
- Tip body (`bodyMedium`, white/80)
- Content aligned start with 12dp gap

**Data Requirements:** Static tip catalog indexed by week number

**Interactive Elements:** None (display only)

**Animation:** Subtle fade-in on scroll into view (300ms)

---

## 8. Data

### Entities Consumed on This Screen

| Entity | Provider | Fields Used |
|---|---|---|
| `PregnancyProfile` | `PregnancyProfileProvider` | `currentWeek`, `dueDate` |
| `MoodEntry` | `MoodEntryProvider` | `todayMood` (moodScore 1-5) |
| `SelfCareCheckState` | `SelfCareCheckStateProvider` | `checkedItems: List<String>` |

### State Operations

- **Read** `currentWeek`, `dueDate` for Week Banner
- **Read** `todayMood` for mood selector selection state
- **Read** `checkedItems` for checklist completion states
- **Write** `MoodEntry` on mood emoji tap
- **Write** `SelfCareCheckState` on checklist chip tap

### Provider Integration

```dart
// In HomeScreen build method:
final pregnancyProfile = ref.watch(pregnancyProfileProvider);
final moodEntry = ref.watch(moodEntryProvider);
final selfCareState = ref.watch(selfCareCheckStateProvider);
```

---

## 9. Motion

### Entry Animations

- Screen loads with staggered fade-in for body sections: 50ms delay between each section (200ms duration, `easeOut`)
- SliverAppBar content fades and scales subtly on initial load (300ms)

### Scroll Behavior

- SliverAppBar collapses smoothly as user scrolls
- Week badge appears in collapsed AppBar when scrolled past expanded height
- Content sections have slight parallax relative to SliverAppBar (factor 0.5)

### Interactive Feedback

- Mood emoji buttons: 150ms opacity/scale feedback on tap, selected state animates with 200ms ring appearance
- Checklist chips: 200ms ease-out scale to 97% on press
- Quick action buttons: 200ms ease-out scale to 95% on press, 200ms return
- Bottom nav indicator: 200ms ease-in-out glide between tab positions

### Refresh Behavior

- Pull-to-refresh triggers 150ms snap animation
- Content refreshes via provider invalidation

### Anti-Motion

- All animations respect `MediaQuery.disableAnimations`
- `prefers-reduced-motion` media query checked and honored

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Baby Bump home screen, week ${currentWeek}'` |
| Mood buttons | `'Feeling ${moodName}, tap to log mood'` |
| Checklist chips | `'$itemName, ${isCompleted ? 'completed' : 'not completed'}, double tap to toggle'` |
| Quick action buttons | `'$actionName, double tap to $actionDescription'` |
| Bottom nav items | Built-in semantics from `NavigationBar` |

### Focus Order

1. SliverAppBar title/avatar
2. Mood emoji buttons (left to right: terrible, bad, okay, good, great)
3. Checklist chips (in horizontal scroll order)
4. Quick action grid (row 1 left to right, then row 2)
5. Weekly tip card
6. Bottom navigation items (Home → Browse → Library → Profile)

### Contrast Notes

- All text meets WCAG AA contrast (4.5:1 minimum for body, 3:1 for large text)
- `lavenderBloom` on white: ratio ~5.2:1
- `deepGraphite` on white: ratio ~12:1
- `stoneGrey` on white: ratio ~4.7:1
- Active bottom nav text uses `lavenderBloom` (5.2:1), inactive uses `stoneGrey` (4.7:1)

### Screen Reader Support

- `AnnounceRouteChange` for tab switches
- `ExcludeSemantics` on decorative elements (fruit emoji, gradient circles)
- Live region on mood selection: "Mood logged as ${moodName}"

### Touch Target Compliance

- All interactive elements minimum 48dp touch target
- Mood buttons: 48dp minimum width/height
- Checklist chips: 48dp minimum height
- Quick action buttons: 48dp minimum, actual 88dp
- Bottom nav items: 48dp minimum

---

## 11. Anti-Patterns

**Do Not:**
- Add a FAB to Home screen (per UX spec, FAB is None)
- Use `SingleChildScrollView` instead of `CustomScrollView` with slivers
- Place critical actions below the thumb zone (bottom 1/3 of screen)
- Use platform default colors (all colors from design system)
- Use Inter, Roboto, or any font other than Nunito
- Add gradients to card backgrounds (flat `morningMist` only for content cards)
- Use shadows without purpose (only soft diffused shadows on cards)
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Display the week banner outside of SliverAppBar context
- Skip safe area padding for notch and home indicator devices
- Use hard-coded week numbers — derive from `PregnancyProfileProvider.currentWeek`