# Library Screen Specification

## 1. Screen Title

**Library**

---

## 2. Purpose

Personal bookshelf tab serving as a navigation hub to Health Log, Mood & Wellness, and Education entry points. Part of the 4-tab bottom navigation shell. This screen provides quick access to health tracking and wellness resources, acting as a central discovery point for personal health management tools.

---

## 3. Route

`/library`

---

## 4. Widget Name

`LibraryScreen`

---

## 5. Design Tokens

### Color Palette (from DESIGN.md)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, active nav indicator, Health Log icon |
| `blushRose` | `#F9A8D4` | Secondary accent, Mood & Wellness icon |
| `softMint` | `#6EE7B7` | Tertiary, success states, Education icon |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text (titles, descriptions) |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions |
| `mistyBorder` | `#E5E7EB` | Card borders if needed |
| `warmWhite` | `#FFFFFF` | Bottom nav background |

### Typography (Google Fonts — Nunito)

| Style | Size | Weight | Usage |
|---|---|---|---|
| `titleLarge` | 20sp | 600 | AppBar title |
| `titleMedium` | 16sp | 600 | Card titles |
| `bodyLarge` | 16sp | 400 | Body text |
| `bodyMedium` | 14sp | 400 | Secondary text, descriptions |
| `labelLarge` | 14sp | 600 | Button text |
| `caption` | 12sp | 500 | Badges, timestamps |

### Spacing Rhythm (base 8dp)

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
| `pill` | 999dp |

### Motion

| Token | Value |
|---|---|---|
| `durationShort` | 200ms |
| `durationMedium` | 300ms |
| `easingStandard` | `Curves.easeInOut` |
| `easingEnter` | `Curves.easeOut` |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `SingleChildScrollView` as body (no slivers needed — simple card list)
- `AppBar`: title "Library", no leading (tab screen), no FAB
- `BottomNavigationBar`: visible (4 tabs, index 2 = Library active)
- Safe area: 12dp top padding for status bar, 80dp bottom for nav + home indicator

### AppBar Behavior

- Transparent background blending to `lavenderTint`
- Title: "Library" (SemiBold 20sp, `deepGraphite`)
- No back button (tab screen)
- No actions

### Body Layout

- `SingleChildScrollView` as body
- `Padding` with 16dp horizontal
- `Column` with `mainAxisSize: MainAxisSize.min` containing card sections
- 24dp vertical spacing between card sections
- Bottom padding: 24dp to clear bottom nav

---

## 7. Sections

### Section 1: Health Log Link Card

**Description:** Navigation card leading to the unified health timeline.

**Widget:** `Card` wrapped in `InkWell` for tap feedback.

**Layout:** Full-width card with 16dp internal padding, `Row` with icon left, text right, chevron trailing.

**Components:**
- 48dp circular icon container with `lavenderBloom` at 15% opacity fill
- Icon: `Icons.favorite_outline` (24sp, `lavenderBloom`)
- Title: "Health Log" (`titleMedium`, `deepGraphite`)
- Description: "Track symptoms, doctor visits, reminders" (`bodyMedium`, `stoneGrey`)
- Trailing: `Icons.chevron_right` (24sp, `stoneGrey`)

**Interactive:** Tap → `context.push('/health-log')`

**Scale feedback:** 200ms ease-out scale to 98% on press, 200ms return

---

### Section 2: Mood & Wellness Link Card

**Description:** Navigation card leading to mood and energy tracking.

**Widget:** `Card` wrapped in `InkWell` for tap feedback.

**Layout:** Full-width card with 16dp internal padding, `Row` with icon left, text right, chevron trailing.

**Components:**
- 48dp circular icon container with `blushRose` at 20% opacity fill
- Icon: `Icons.mood_outlined` (24sp, `blushRose`)
- Title: "Mood & Wellness" (`titleMedium`, `deepGraphite`)
- Description: "Log moods, track energy levels" (`bodyMedium`, `stoneGrey`)
- Trailing: `Icons.chevron_right` (24sp, `stoneGrey`)

**Interactive:** Tap → `context.push('/mood-wellness')`

**Scale feedback:** 200ms ease-out scale to 98% on press, 200ms return

---

### Section 3: Education Link Card

**Description:** Navigation card leading to educational content browser.

**Widget:** `Card` wrapped in `InkWell` for tap feedback.

**Layout:** Full-width card with 16dp internal padding, `Row` with icon left, text right, chevron trailing.

**Components:**
- 48dp circular icon container with `softMint` at 20% opacity fill
- Icon: `Icons.school_outlined` (24sp, `softMint`)
- Title: "Education" (`titleMedium`, `deepGraphite`)
- Description: "Browse articles and trusted health info" (`bodyMedium`, `stoneGrey`)
- Trailing: `Icons.chevron_right` (24sp, `stoneGrey`)

**Interactive:** Tap → `context.push('/education')`

**Scale feedback:** 200ms ease-out scale to 98% on press, 200ms return

---

## 8. Data

**Entities Consumed:**
| Entity | Provider | Fields Used |
|---|---|---|
| None | — | Library is purely navigational |

This screen serves as a discovery hub — all data is shown on destination screens. No state providers are directly consumed by this screen.

---

## 9. Motion

### Entry Animations

- Screen loads with fade-in: 300ms, `easeOut`
- Cards use staggered entry: 100ms delay between each card, 300ms fade per card
- Total stagger duration: 500ms for all three cards

### Interactive Feedback

- Card tap: 200ms ease-out scale to 98% on press, 200ms ease-out return
- Bottom nav indicator: 200ms ease-in-out glide between tab positions

### Anti-Motion

- All animations respect `MediaQuery.disableAnimations`
- `prefers-reduced-motion` media query honored — when enabled, skip all animations

---

## 10. Accessibility

### Semantic Labels

| Element | Label |
|---|---|
| AppBar | `'Library screen'` |
| Health Log card | `'Health Log, double tap to open health log screen'` |
| Mood & Wellness card | `'Mood and Wellness, double tap to open mood and wellness screen'` |
| Education card | `'Education, double tap to open education screen'` |

### Focus Order

1. Health Log card
2. Mood & Wellness card
3. Education card
4. Bottom navigation items (in order: Home, Browse, Library, Profile)

### Contrast Notes

- `lavenderBloom` (#7C3AED) on `morningMist` (#FAFAFA): ~5.2:1 (AA compliant)
- `deepGraphite` (#1F2937) on `morningMist` (#FAFAFA): ~12:1 (AAA compliant)
- `stoneGrey` (#6B7280) on `morningMist` (#FAFAFA): ~4.7:1 (AA borderline — used for descriptions only)

### Touch Target Compliance

- All cards: full card area, minimum 48dp height
- Icon containers: 48dp diameter
- All interactive elements meet 48dp minimum touch target

---

## 11. Anti-Patterns

**Do Not:**
- Add a FAB to Library screen (tab screens don't have FABs per UX.md)
- Use `CustomScrollView` with slivers (not needed for simple card list — use `SingleChildScrollView`)
- Add gradients to card backgrounds (flat `morningMist` only)
- Use platform default colors (all colors from design system)
- Use Inter, Roboto, or any font other than Nunito
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Add more than the 3 defined link cards
- Use hero animations (simple push navigation with no shared elements)
- Add elevation shadows beyond level1 for cards (soft shadow only)