# Settings Screen Specification

## 1. Screen Title

**Title:** Settings
**Widget Name:** `SettingsScreen`
**Screen ID:** `settings`

---

## 2. Purpose

The Settings screen allows users to manage their personal profile, configure notification preferences, export app data, and view legal/version information. It is a structured preference screen organized into four themed sections: Profile, Notifications, Data, and About.

---

## 3. Route

**Route:** `/settings`
**Navigation Type:** Push (from Profile tab or Settings icon in Home AppBar)
**Swipe-back:** Enabled (dismisses to previous screen)

---

## 4. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary actions, section headers, AppBar title |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text (titles, names) |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions |
| `mistyBorder` | `#E5E7EB` | List item borders, toggles off state |
| `softCoral` | `#EF4444` | Clear data / destructive actions |
| `softMint` | `#6EE7B7` | Success states (export complete) |
| `warmWhite` | `#FFFFFF` | Card surfaces, bottom sheets |

### Typography (Nunito)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `titleLarge` | 20sp | 600 | 28sp | Screen title |
| `titleMedium` | 16sp | 600 | 24sp | Section headers |
| `bodyMedium` | 14sp | 400 | 20sp | List item titles, field labels |
| `bodySmall` | 14sp | 400 | 20sp | Descriptions, secondary text |
| `caption` | 12sp | 400 | 16sp | Metadata, hints, version text |

### Spacing (8pt Base)

| Token | Value |
|---|---|
| `xs` | 8dp |
| `md` | 16dp |
| `lg` | 24dp |

### Corner Radius

| Token | Value |
|---|---|
| `card` | 16dp |
| `listItem` | 12dp |

### Motion

| Motion | Duration | Curve |
|---|---|---|
| Screen push transition | 300ms | `Curves.easeInOut` |
| List item stagger reveal | 50ms delay between items | `Curves.easeOut` |
| Toggle switch thumb | 200ms | `Curves.easeOut` |
| Card tap feedback | 200ms | `Curves.easeOut` (scale to 98%) |
| Export success toast | 300ms fade in/out | `Curves.easeOut` |

---

## 5. Layout Rules

### Scaffold Structure

```
Scaffold
├── AppBar
│   ├── Title: "Settings" (titleLarge, deepGraphite)
│   ├── Back button (leading, 48dp touch target)
│   └── No trailing icons
├── BottomNavigationBar: Hidden
├── FAB: None
└── Body: ListView (sections separated by 24dp spacing)
```

### AppBar Behavior
- Background: lavenderTint (#F5F3FF), transparent feel
- Title: centered or left-aligned, SemiBold 20sp, deepGraphite
- Back button: icon button with lavenderBloom color on tap
- No actions/trailing widgets

### Body Layout
- Vertical `ListView` with `SliverAppBar` disabled (standard AppBar only)
- Cards are wrapped in `Padding` with 16dp horizontal margin
- 24dp vertical spacing between sections
- 12dp vertical spacing between items within a section

### Bottom Navigation Bar
- Hidden on this screen (navType: push)

---

## 6. Sections

### Section 1: Profile

**Card:** `Card` with morningMist background, 16dp corner radius, 16dp internal padding.

**Content:**
- **Name field** — `TextFormField` or tappable row that opens inline edit or bottom sheet. Label: "Name", value from `UserPreferences.name`.
- **Due date row** — Tappable list tile showing due date. Label: "Due Date", value from `PregnancyProfile.dueDate` (also stored in `UserPreferences.dueDate`). Tapping triggers `showDatePicker` bottom sheet.

**Data Requirements:**
- `UserPreferencesProvider` — `name` field
- `PregnancyProfileProvider` — `dueDate` field

**Interactive Elements:**
- Name tap → inline edit or bottom sheet with `TextEditingController`
- Due date tap → `showDatePicker` bottom sheet, saves to both providers

---

### Section 2: Notifications

**Card:** `Card` with morningMist background, 16dp corner radius, 16dp internal padding.

**Content:**
A `Column` of `SwitchListTile` widgets, one per notification category:
1. **Daily Reminders** — `UserPreferences.notifications.dailyReminders`
2. **Symptom Alerts** — `UserPreferences.notifications.symptomAlerts`
3. **Appointment Reminders** — `UserPreferences.notifications.appointmentReminders`
4. **Weekly Digest** — `UserPreferences.notifications.weeklyDigest`

Each switch:
- Title: notification category name (titleMedium, deepGraphite)
- Subtitle: brief description (bodySmall, stoneGrey)
- Active track color: lavenderBloom; inactive track: mistyBorder

**Data Requirements:**
- `UserPreferencesProvider` — `notificationsEnabled`, individual category flags

**Interactive Elements:**
- Toggle switch → `UserPreferencesProvider.updateNotification(category, enabled)`
- 200ms thumb slide animation

---

### Section 3: Data

**Card:** `Card` with morningMist background, 16dp corner radius, 16dp internal padding.

**Content:**
Two action rows:
1. **Export Data** — `InkWell` or `ListTile` with icon and label. Tap → generates JSON/CSV file of all user data, triggers system share sheet.
2. **Clear All Data** — `ListTile` with icon and label in softCoral color. Tap → `AlertDialog` confirmation ("Are you sure? This action cannot be undone."), then calls `UserPreferencesProvider.clearAll()`.

**Data Requirements:**
- `UserPreferencesProvider` — `clearAll()` method
- Export uses all provider data (pregnancy profile, mood entries, weight entries, health log)

**Interactive Elements:**
- Export tap → generate file → `Share.share()` system share sheet
- Clear tap → `showDialog()` with `AlertDialog` → confirmation calls `clearAll()` and shows success snackbar

---

### Section 4: About

**Card:** `Card` with morningMist background, 16dp corner radius, 16dp internal padding.

**Content:**
Three rows:
1. **App Version** — Static text row: "Version" label + version string from `pubspec.yaml` (e.g., "1.0.0"). Non-interactive.
2. **Privacy Policy** — `ListTile` with icon and label. Tap → opens external URL (e.g., `https://example.com/privacy`).
3. **Terms of Service** — `ListTile` with icon and label. Tap → opens external URL (e.g., `https://example.com/terms`).

**Interactive Elements:**
- Privacy Policy tap → `url_launcher.launchUrl()` with privacy policy URL
- Terms of Service tap → `url_launcher.launchUrl()` with terms URL

---

## 7. Data

### Entities

| Entity | Provider | Key Fields |
|---|---|---|
| `UserPreferences` | `UserPreferencesProvider` | `name`, `notificationsEnabled`, `dueDate` |
| `PregnancyProfile` | `PregnancyProfileProvider` | `dueDate`, `currentWeek` |

### Provider Scope

- `UserPreferencesProvider` — manages name, notification preferences, due date (shared with PregnancyProfile)
- `PregnancyProfileProvider` — manages due date, lastPeriodDate, currentWeek

### Export File Format

JSON format containing:
```json
{
  "exportDate": "ISO8601 timestamp",
  "user": { "name": "...", "dueDate": "..." },
  "pregnancyProfile": { ... },
  "moodEntries": [ ... ],
  "weightEntries": [ ... ],
  "symptomEntries": [ ... ],
  "cycleEntries": [ ... ]
}
```

---

## 8. Motion

### Screen Transition
- **Duration:** 300ms
- **Curve:** `Curves.easeInOut`
- **Type:** Slide + fade (standard push transition)

### List Item Reveal
- **Stagger:** 50ms between each item (from top to bottom)
- **Type:** Fade + slight slide up
- **Curve:** `Curves.easeOut`

### Toggle Switch
- **Duration:** 200ms
- **Type:** Thumb slide, track color transition

### Card Tap Feedback
- **Duration:** 200ms
- **Type:** Scale to 98%, then return to 100%
- **Curve:** `Curves.easeOut`

### Export Success
- **Duration:** 300ms
- **Type:** SnackBar fade in from bottom, auto-dismiss after 3s

---

## 9. Accessibility

### Semantic Labels
- **Name field:** "User name, [current name], double tap to edit"
- **Due date:** "Due date, [formatted date], double tap to change"
- **Notification toggles:** "[Category name], notifications [enabled/disabled], double tap to toggle"
- **Export Data:** "Export data, double tap to save and share your data"
- **Clear All Data:** "Clear all data, double tap to delete all app data. This action cannot be undone."
- **Privacy Policy:** "Privacy policy, opens in browser"
- **Terms of Service:** "Terms of service, opens in browser"

### Touch Targets
- All interactive list items: minimum 56dp height
- All switches: 48dp minimum touch target
- All buttons: 48dp minimum height

### Focus Order
1. Name field
2. Due date row
3. Daily Reminders toggle
4. Symptom Alerts toggle
5. Appointment Reminders toggle
6. Weekly Digest toggle
7. Export Data
8. Clear All Data
9. Privacy Policy
10. Terms of Service

### Color Contrast
- Primary text (deepGraphite #1F2937) on morningMist (#FAFAFA): 12.8:1 ratio (AA compliant)
- Secondary text (stoneGrey #6B7280) on morningMist: 4.6:1 ratio (AA compliant)
- All text meets WCAG 2.1 AA contrast requirements

---

## 10. Anti-Patterns

### Do NOT
- Use platform default colors — all colors from design token palette
- Show bottom navigation bar on this screen (hidden by navType: push)
- Use `AlertDialog` for anything other than destructive confirmation (clear data)
- Place critical actions (clear data) outside thumb zone (bottom two-thirds of screen)
- Use Inter or Roboto — Nunito only
- Use sharp corners — all cards 16dp radius, list items 12dp radius
- Use generic "OK" button labels — use action-specific labels ("Delete", "Cancel", "Export")
- Show FAB on this screen
- Use hardcoded strings — extract to localization keys