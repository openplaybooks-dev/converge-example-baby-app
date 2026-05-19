# Plan: Spec: Library



Based on my exploration, I have a comprehensive understanding of the codebase. Let me now design the specification for the Library screen.

---

## Library Screen Specification Plan

### 1. Screen Title
**Library** — matches `screens.json` and bottom nav label

### 2. Purpose
Personal bookshelf tab serving as a navigation hub to Health Log, Mood & Wellness, and Education entry points. Part of the 4-tab bottom navigation shell.

### 3. Route
`/library`

### 4. Widget Name
`LibraryScreen`

### 5. Design Tokens (from DESIGN.md)

**Color Palette:**
| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, active nav indicator, icons |
| `blushRose` | `#F9A8D4` | Secondary accent, card backgrounds |
| `softMint` | `#6EE7B7` | Success states, completion indicators |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |
| `warmWhite` | `#FFFFFF` | Bottom nav, card surfaces |

**Typography (Nunito):**
| Style | Size | Weight | Usage |
|---|---|---|---|
| `displayLarge` | 32sp | 700 | Hero display |
| `headlineMedium` | 24sp | 700 | Section headers |
| `titleLarge` | 20sp | 600 | AppBar title |
| `titleMedium` | 16sp | 600 | Card titles |
| `bodyLarge` | 16sp | 400 | Body text |
| `bodyMedium` | 14sp | 400 | Secondary text |
| `labelLarge` | 14sp | 600 | Button text |
| `caption` | 12sp | 500 | Badges, timestamps |

**Spacing (8pt base):**
- `xxs`: 4dp, `xs`: 8dp, `sm`: 12dp, `md`: 16dp, `lg`: 24dp, `xl`: 32dp, `xxl`: 48dp

**Corner Radius:**
- `sm`: 8dp, `md`: 12dp, `lg`: 16dp, `pill`: 999dp

### 6. Layout Rules

**Scaffold Structure:**
- `Scaffold` with `SingleChildScrollView` body (no slivers needed — simple card list)
- `AppBar`: title "Library", no leading (tab screen), no FAB
- `BottomNavigationBar`: visible (4 tabs, index 2 = Library active)
- Safe area: 12dp top padding for status bar, 80dp bottom for nav + home indicator

**AppBar Behavior:**
- Transparent background blending to `lavenderTint`
- Title: "Library" (SemiBold 20sp, `deepGraphite`)

**Body Layout:**
- `SingleChildScrollView` as body
- `Padding` with 16dp horizontal
- `Column` with `mainAxisSize: MainAxisSize.min` containing card sections
- 24dp vertical spacing between card sections

### 7. Sections

**Section 1: Health Log Link Card**
- **Widget:** `Card` wrapped in `InkWell` for tap feedback
- **Layout:** Full-width card (16dp internal padding), `Row` with icon left, text right, chevron trailing
- **Components:**
  - 48dp circular icon container with `lavenderBloom/15` fill
  - Icon: `Icons.favorite_outline` (24sp, `lavenderBloom`)
  - Title: "Health Log" (`titleMedium`, `deepGraphite`)
  - Description: "Track symptoms, doctor visits, reminders" (`bodyMedium`, `stoneGrey`)
- **Interactive:** Tap → `context.push('/health-log')`

**Section 2: Mood & Wellness Link Card**
- **Widget:** `Card` wrapped in `InkWell` for tap feedback
- **Layout:** Full-width card (16dp internal padding), `Row` with icon left, text right, chevron trailing
- **Components:**
  - 48dp circular icon container with `blushRose/20` fill
  - Icon: `Icons.mood_outlined` (24sp, `blushRose`)
  - Title: "Mood & Wellness" (`titleMedium`, `deepGraphite`)
  - Description: "Log moods, track energy levels" (`bodyMedium`, `stoneGrey`)
- **Interactive:** Tap → `context.push('/mood-wellness')`

**Section 3: Education Link Card**
- **Widget:** `Card` wrapped in `InkWell` for tap feedback
- **Layout:** Full-width card (16dp internal padding), `Row` with icon left, text right, chevron trailing
- **Components:**
  - 48dp circular icon container with `softMint/20` fill
  - Icon: `Icons.school_outlined` (24sp, `softMint`)
  - Title: "Education" (`titleMedium`, `deepGraphite`)
  - Description: "Browse articles and trusted health info" (`bodyMedium`, `stoneGrey`)
- **Interactive:** Tap → `context.push('/education')`

**Each card uses:**
- 200ms ease-out scale to 98% on press with animated scale return
- Soft shadow (level1) with 16dp radius corners
- 48dp minimum touch target

### 8. Data

**Entities Consumed:**
| Entity | Provider | Fields Used |
|---|---|---|
| None | — | Library is purely navigational |

This screen serves as a discovery hub — all data is shown on destination screens.

### 9. Motion

**Entry Animations:**
- Screen loads with fade-in: 300ms, `easeOut`
- Cards may use staggered entry: 100ms delay between each, 300ms fade per card

**Interactive Feedback:**
- Card tap: 200ms ease-out scale to 98% on press, 200ms return
- Bottom nav indicator: 200ms ease-in-out glide between tab positions

**Anti-Motion:**
- All animations respect `MediaQuery.disableAnimations`
- `prefers-reduced-motion` media query honored

### 10. Accessibility

**Semantic Labels:**
| Element | Label |
|---|---|
| AppBar | `'Library screen'` |
| Health Log card | `'Health Log, double tap to open health log screen'` |
| Mood & Wellness card | `'Mood and Wellness, double tap to open mood and wellness screen'` |
| Education card | `'Education, double tap to open education screen'` |

**Focus Order:**
1. Health Log card
2. Mood & Wellness card
3. Education card
4. Bottom navigation items

**Contrast Notes:**
- `lavenderBloom` on `morningMist`: ~5.2:1
- `deepGraphite` on `morningMist`: ~12:1
- `stoneGrey` on `morningMist`: ~4.7:1

**Touch Target Compliance:**
- All cards: full card area, minimum 48dp height
- Icon buttons (if any): 48dp minimum

### 11. Anti-Patterns

**Do Not:**
- Add a FAB to Library screen (tab screens don't have FABs)
- Use `CustomScrollView` with slivers (not needed for simple card list)
- Add gradients to card backgrounds (flat `morningMist` only)
- Use platform default colors (all from design system)
- Use Inter, Roboto, or any font other than Nunito
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Add more than the 3 defined link cards
- Use hero animations (simple push navigation)

---

### Critical Files for Implementation

1. **`.stitch/designs/library/SPEC.md`** — The specification file to be created (output)
2. **`.stitch/designs/browse/SPEC.md`** — Reference pattern for tab screen card layout
3. **`lib/screens/browse/browse_screen.dart`** — Code reference for `_LinkCard` implementation pattern
4. **`.stitch/system/DESIGN.md`** — Design tokens source of truth
5. **`lib/theme/app_theme.dart`** — AppTheme constants used by existing screens (though spec won't directly reference this file)