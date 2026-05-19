# Browse Screen Specification

## 1. Screen Title

**Browse**

---

## 2. Purpose

Discovery hub linking to Cycle Tracking and Weight & Nutrition entry points. Provides quick access to two primary tracking features from a single tab-level screen.

**Context:** Part of ShellRoute with BottomNavigationBar (4 tabs). Browse is index 1 in the bottom nav (Home=0, Browse=1, Library=2, Profile=3). Acts as a navigation aggregator for features that don't need to occupy a dedicated tab.

---

## 3. Route

`/browse`

---

## 4. Widget Name

`BrowseScreen`

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
|---|---|---|
| `level0` | Scaffold background |
| `level1` | Cards, bottom nav |

### Motion

| Token | Duration | Curve |
|---|---|---|
| `durationShort` | 200ms | `Curves.easeOut` |
| `durationMedium` | 300ms | `Curves.easeInOut` |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `SingleChildScrollView` body (no CustomScrollView needed for 2 cards)
- `AppBar` with title "Browse", no leading, no FAB
- `BottomNavigationBar` visible (4 tabs, index 1 = Browse active)
- No FAB on Browse screen (tab screens don't have FABs)
- Safe area handling: 12dp top padding when status bar visible; bottom padding for home indicator (80dp)

### AppBar Behavior

- Background: Transparent blending to `lavenderTint`
- Title: "Browse" (SemiBold 20sp, `deepGraphite`)
- No leading button (tab screens don't have back buttons)
- No trailing icons

### Body Layout

- `SingleChildScrollView` as body
- `Padding` with 16dp horizontal padding
- `Column` with `mainAxisSize: MainAxisSize.min` containing card sections
- Section vertical spacing: 24dp between card sections
- Bottom padding: 80dp to clear bottom navigation

### Bottom Navigation

- 4 tabs: Home, Browse, Library, Profile
- Active indicator: pill shape with 15% opacity lavender background
- Active icon: filled, `lavenderBloom` color
- Inactive icon: outlined, `stoneGrey` color
- Touch target: 48dp minimum per tab item
- Browse tab (index 1) is active when this screen is shown

---

## 7. Sections

### Section 1: Cycle Tracking Link Card

**Description:** Tappable card that navigates to the Cycle Tracking screen. Shows cycle-related icon, title, and brief description.

**Widget Type:** `SliverToBoxAdapter` with `Card` wrapped in `InkWell` for tap feedback

**Layout:** Full-width card with 16dp internal padding. Content in `Row` layout: icon on left, text content on right.

**Components:**
- Card container (`morningMist` background, 16dp radius, soft shadow level1)
- Leading icon container: 48dp circular background with `lavenderBloom/15` fill, icon in `lavenderBloom`
- Icon: `Icons.calendar_month_outlined` (24sp)
- Title text: "Cycle Tracking" (`titleMedium`, `deepGraphite`)
- Description text: "Log cycles, view ovulation predictions" (`bodyMedium`, `stoneGrey`)
- Trailing chevron: `Icons.chevron_right` in `stoneGrey`

**Data Requirements:** None (navigation-only card)

**Interactive Elements:**
- Tap card → `context.push('/cycle-tracking')`
- Tap feedback: 200ms ease-out scale to 98%

---

### Section 2: Weight & Nutrition Link Card

**Description:** Tappable card that navigates to the Weight & Nutrition screen. Shows weight-related icon, title, and brief description.

**Widget Type:** `SliverToBoxAdapter` with `Card` wrapped in `InkWell` for tap feedback

**Layout:** Full-width card with 16dp internal padding. Content in `Row` layout: icon on left, text content on right.

**Components:**
- Card container (`morningMist` background, 16dp radius, soft shadow level1)
- Leading icon container: 48dp circular background with `blushRose/20` fill, icon in `blushRose`
- Icon: `Icons.monitor_weight_outlined` (24sp)
- Title text: "Weight & Nutrition" (`titleMedium`, `deepGraphite`)
- Description text: "Log weight, view progress, nutrition tips" (`bodyMedium`, `stoneGrey`)
- Trailing chevron: `Icons.chevron_right` in `stoneGrey`

**Data Requirements:** None (navigation-only card)

**Interactive Elements:**
- Tap card → `context.push('/weight-nutrition')`
- Tap feedback: 200ms ease-out scale to 98%

---

## 8. Data

### Entities Consumed on This Screen

| Entity | Provider | Fields Used |
|---|---|---|
| None | — | This screen is purely navigational |

### State Operations

- **No reads** — Browse screen does not consume any providers
- **No writes** — No state modifications on this screen

### Navigation Only

This screen serves as a discovery hub. All data presentation happens on the target screens (`/cycle-tracking` and `/weight-nutrition`).

---

## 9. Motion

### Entry Animations

- Screen loads with fade-in for entire body: 300ms duration, `easeOut`
- Cards may optionally use staggered entry: 100ms delay between each card, 300ms fade-in per card

### Scroll Behavior

- `SingleChildScrollView` enables scrolling if content exceeds viewport
- No sliver collapsing behavior (no SliverAppBar)

### Interactive Feedback

- Card tap: 200ms ease-out scale to 98% on press, 200ms ease-out return to 100%
- Bottom nav indicator: 200ms ease-in-out glide between tab positions

### Anti-Motion

- All animations respect `MediaQuery.disableAnimations`
- `prefers-reduced-motion` media query checked and honored

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Browse screen'` |
| Cycle Tracking card | `'Cycle Tracking, double tap to open cycle tracking screen'` |
| Weight & Nutrition card | `'Weight and Nutrition, double tap to open weight and nutrition screen'` |
| Bottom nav items | Built-in semantics from `NavigationBar` |

### Focus Order

1. Cycle Tracking card
2. Weight & Nutrition card
3. Bottom navigation items (Home → Browse → Library → Profile)

### Contrast Notes

- All text meets WCAG AA contrast (4.5:1 minimum for body, 3:1 for large text)
- `lavenderBloom` on `morningMist`: ratio ~5.2:1
- `deepGraphite` on `morningMist`: ratio ~12:1
- `stoneGrey` on `morningMist`: ratio ~4.7:1
- Active bottom nav text uses `lavenderBloom` (5.2:1), inactive uses `stoneGrey` (4.7:1)

### Touch Target Compliance

- All interactive elements minimum 48dp touch target
- Card touch target: full card area, minimum 48dp height
- Icon buttons (if any): 48dp minimum

### Screen Reader Support

- `ExcludeSemantics` on decorative chevron icons
- Cards announce as single interactive elements with combined label

---

## 11. Anti-Patterns

**Do Not:**
- Add a FAB to Browse screen (tab screens don't have FABs)
- Use `CustomScrollView` with slivers (not needed for simple card list)
- Place critical actions below the thumb zone (bottom 1/3 of screen)
- Use platform default colors (all colors from design system)
- Use Inter, Roboto, or any font other than Nunito
- Add gradients to card backgrounds (flat `morningMist` only)
- Use shadows without purpose (only soft diffused shadows on cards)
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Add more than the 2 defined link cards (Browse is a simple hub)
- Use hero animations (this is a simple push navigation)
- Skip safe area padding for notch and home indicator devices