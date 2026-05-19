# Plan: Spec: Profile



Based on my analysis of the design system, UX specifications, existing screens, and patterns, here is the **Profile Screen Specification**:

---

# Profile Screen Specification

## 1. Screen Title

**Profile**

---

## 2. Purpose

Personal profile tab serving as a navigation hub to Mindfulness and Settings, with user avatar and name display. Part of the 4-tab bottom navigation shell. This screen provides access to mindfulness resources, app settings, and user profile management.

**Context:** Part of ShellRoute with BottomNavigationBar (4 tabs, index 3). Users arrive here from bottom nav or by tapping the avatar icon on Home AppBar.

---

## 3. Route

`/profile`

---

## 4. Widget Name

`ProfileScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, active nav indicator, Settings icon |
| `blushRose` | `#F9A8D4` | Secondary accent, Mindfulness icon |
| `softMint` | `#6EE7B7` | Tertiary, success states |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text (titles, names) |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions |
| `mistyBorder` | `#E5E7EB` | Card borders if needed |
| `warmWhite` | `#FFFFFF` | Bottom nav background, card surfaces |
| `deepTwilight` | `#1E1B2E` | Card backgrounds in dark mode |
| `twilightBloom` | `#9F67FF` | Primary brand in dark mode |
| `duskyRose` | `#FBC4E0` | Secondary accent in dark mode |
| `nightMint` | `#34D399` | Tertiary success in dark mode |

### Typography (Google Fonts — Nunito)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 32sp | 700 | 40sp | User name display |
| `headlineMedium` | 24sp | 700 | 32sp | Section headers |
| `titleLarge` | 20sp | 600 | 28sp | AppBar title |
| `titleMedium` | 16sp | 600 | 24pt | Card titles |
| `bodyLarge` | 16sp | 400 | 24sp | Body text |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, descriptions |
| `labelLarge` | 14sp | 600 | 20sp | Button text, chip labels |
| `caption` | 12sp | 500 | 16sp | Badges, timestamps |

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

| Token | Duration | Curve |
|---|---|---|
| `durationShort` | 200ms | `Curves.easeOut` |
| `durationMedium` | 300ms | `Curves.easeInOut` |
| Stagger delay | 50ms between items | — |

### Elevation

| Token | Usage |
|---|---|
| `level0` | Scaffold background |
| `level1` | Cards, bottom nav |
| `level2` | FAB, bottom sheets |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `SingleChildScrollView` as body (simple card list, no slivers needed)
- `AppBar`: title "Profile", no leading (tab screen), transparent background
- `BottomNavigationBar`: visible (4 tabs, index 3 = Profile active)
- No FAB on Profile tab screen
- Safe area: 12dp top padding for status bar, 80dp bottom for nav + home indicator

### AppBar Behavior

- Transparent background blending to `lavenderTint`
- Title: "Profile" (SemiBold 20sp, `deepGraphite`)
- No back button (tab screen)
- No trailing actions

### Body Layout

- `SingleChildScrollView` as body
- `Padding` with 16dp horizontal
- `Column` with `mainAxisSize: MainAxisSize.min` containing sections
- 24dp vertical spacing between sections
- Bottom padding: 100dp to clear bottom nav

---

## 7. Sections

### Section 1: Profile Header (Avatar + Name)

**Description:** User avatar with gradient background, name, and due date preview.

**Widget Type:** `Column` with centered content, wrapped in `SliverToBoxAdapter`

**Layout:** Centered column at top of scrollable content.

**Components:**
- Avatar container (80dp diameter) with gradient fill (`lavenderBloom` to `blushRose`)
- User initial or emoji inside avatar circle
- User name (`displayLarge`, `deepGraphite`)
- Due date subtitle (`bodyMedium`, `stoneGrey`) — from `PregnancyProfileProvider`
- Edit profile button (text button, `lavenderBloom`)

**Data Requirements:**
- `name` from `UserPreferencesProvider`
- `dueDate` from `PregnancyProfileProvider`

**Interactive Elements:**
- Tap edit profile button → `context.push('/settings')` (Profile section)
- Tap avatar → no action (decorative)

---

### Section 2: Mindfulness Link Card

**Description:** Navigation card leading to guided breathing exercises and stretching guides.

**Widget:** `Card` wrapped in `InkWell` for tap feedback.

**Layout:** Full-width card with 16dp internal padding, `Row` with icon left, text right, chevron trailing.

**Components:**
- 48dp circular icon container with `blushRose` at 20% opacity fill
- Icon: `Icons.self_improvement` (24sp, `blushRose`)
- Title: "Mindfulness" (`titleMedium`, `deepGraphite`)
- Description: "Breathing exercises, stretching, relaxation" (`bodyMedium`, `stoneGrey`)
- Trailing: `Icons.chevron_right` (24sp, `stoneGrey`)

**Data Requirements:** None (static navigation)

**Interactive Elements:**
- Tap card → `context.push('/mindfulness')`
- Scale feedback: 200ms ease-out scale to 98% on press, 200ms return

---

### Section 3: Settings Link Card

**Description:** Navigation card leading to app settings and preferences.

**Widget:** `Card` wrapped in `InkWell` for tap feedback.

**Layout:** Full-width card with 16dp internal padding, `Row` with icon left, text right, chevron trailing.

**Components:**
- 48dp circular icon container with `lavenderBloom` at 15% opacity fill
- Icon: `Icons.settings_outlined` (24sp, `lavenderBloom`)
- Title: "Settings" (`titleMedium`, `deepGraphite`)
- Description: "Notifications, due date, data export" (`bodyMedium`, `stoneGrey`)
- Trailing: `Icons.chevron_right` (24sp, `stoneGrey`)

**Data Requirements:** None (static navigation)

**Interactive Elements:**
- Tap card → `context.push('/settings')`
- Scale feedback: 200ms ease-out scale to 98% on press, 200ms return

---

### Section 4: App Info Card (About)

**Description:** Minimal card showing app version.

**Widget:** `Card` (non-interactive, display only).

**Layout:** Full-width card with 16dp internal padding.

**Components:**
- App name: "Baby Bump" (`titleMedium`, `deepGraphite`)
- Version text: "Version 1.0.0" (`caption`, `stoneGrey`)
- Privacy policy link text button

**Data Requirements:** None (static content)

**Interactive Elements:** None (display only)

---

## 8. Data

### Entities Consumed on This Screen

| Entity | Provider | Fields Used |
|---|---|---|
| `UserPreferences` | `UserPreferencesProvider` | `name` |
| `PregnancyProfile` | `PregnancyProfileProvider` | `dueDate` |

### State Operations

- **Read** `name` for Profile Header display name
- **Read** `dueDate` for Profile Header due date subtitle

### Provider Integration

```dart
// In ProfileScreen build method:
final userPrefs = ref.watch(userPreferencesProvider);
final pregnancyProfile = ref.watch(pregnancyProfileProvider);
```

---

## 9. Motion

### Entry Animations

- Screen loads with fade-in: 300ms, `Curves.easeOut`
- Header avatar has subtle scale-in: 200ms from 95% to 100%
- Cards use staggered entry: 100ms delay between each card, 300ms fade per card
- Total stagger duration: 600ms for all four sections

### Interactive Feedback

- Card tap: 200ms ease-out scale to 98% on press, 200ms ease-out return
- Bottom nav indicator: 200ms ease-in-out glide between tab positions

### Anti-Motion

- All animations respect `MediaQuery.disableAnimations`
- `prefers-reduced-motion` media query honored — when enabled, skip all animations

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Profile screen'` |
| Avatar | `'User profile picture'` |
| Name display | `'User name: ${userName}'` |
| Due date display | `'Due date: ${formattedDate}'` |
| Edit profile button | `'Edit profile, double tap to open settings'` |
| Mindfulness card | `'Mindfulness, double tap to open mindfulness screen'` |
| Settings card | `'Settings, double tap to open settings screen'` |
| Bottom nav items | Built-in semantics from `NavigationBar` |

### Focus Order

1. Avatar circle
2. User name
3. Due date subtitle
4. Edit profile button
5. Mindfulness card
6. Settings card
7. About card
8. Bottom navigation items (in order: Home, Browse, Library, Profile)

### Contrast Notes

- `lavenderBloom` (#7C3AED) on `morningMist` (#FAFAFA): ~5.2:1 (AA compliant)
- `blushRose` (#F9A8D4) on `morningMist` (#FAFAFA): ~3.8:1 (AA borderline — used for icon backgrounds)
- `deepGraphite` (#1F2937) on `morningMist` (#FAFAFA): ~12:1 (AAA compliant)
- `stoneGrey` (#6B7280) on `morningMist` (#FAFAFA): ~4.7:1 (AA borderline — used for descriptions only)
- Active bottom nav text uses `lavenderBloom` (5.2:1), inactive uses `stoneGrey` (4.7:1)

### Touch Target Compliance

- All cards: full card area, minimum 56dp height
- Icon containers: 48dp diameter
- Edit profile button: 48dp minimum height
- Avatar: 80dp diameter (decorative, no interaction beyond visual)
- All interactive elements meet 48dp minimum touch target

### Screen Reader Support

- `AnnounceRouteChange` for tab switches
- Live region on profile name: "Profile screen, ${userName}"

---

## 11. Anti-Patterns

**Do Not:**
- Add a FAB to Profile tab screen (tab screens don't have FABs per UX.md)
- Use `CustomScrollView` with slivers (not needed for simple card list — use `SingleChildScrollView`)
- Add gradients to card backgrounds (flat `morningMist` only for content cards)
- Use platform default colors (all colors from design system)
- Use Inter, Roboto, or any font other than Nunito
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Add more than the 4 defined sections (header, mindfulness, settings, about)
- Use hero animations (simple push navigation with no shared elements)
- Add elevation shadows beyond level1 for cards (soft shadow only)
- Place critical actions below the thumb zone
- Use hard-coded user name — derive from `UserPreferencesProvider.name`

---

### Critical Files for Implementation

1. **`lib/screens/profile/profile_screen.dart`** — New screen file to create, following `LibraryScreen` as reference pattern
2. **`lib/router/app_router.dart`** — Needs new route entry `GoRoute(path: '/profile', builder: ...)` added to shell
3. **`lib/screens/library/library_screen.dart`** — Reference pattern for `ProfileScreen` structure (card-based layout, bottom nav integration)
4. **`lib/theme/app_theme.dart`** — Design tokens referenced by the screen (colors, spacing, typography already defined)
5. **`.stitch/UX.md`** — Defines Profile screen features (`mindfulness-link`, `settings-link`, `avatar`) and navigation hierarchy