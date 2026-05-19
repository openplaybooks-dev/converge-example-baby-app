# Plan: Spec: Settings



Based on my exploration, I now have all the context needed to produce the Settings screen specification. Let me create the plan for the `.stitch/designs/settings/SPEC.md` file.

---

## Settings Screen Specification Plan

### Input Analysis

From **screens.json** (line 111-118):
- `id`: "settings"
- `route`: `/settings`
- `features`: ["profile-section", "notifications-section", "data-section", "about-section"]
- `navType`: "push"

From **UX.md Section 3.10** (lines 249-270):
- AppBar: "Settings", back button, no bottom nav, no FAB
- Body: `ListView` grouped into 4 sections
- Profile section: due date with edit capability, name field
- Notifications: toggle switches for reminder categories
- Data: export button, clear data with confirmation
- About: app version, privacy policy link
- Data providers: `UserPreferencesProvider`, `PregnancyProfileProvider`

### Design Token Mapping

| Token | Value | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary actions, section headers |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, descriptions |
| `mistyBorder` | `#E5E7EB` | List item borders, toggles off |
| `softCoral` | `#EF4444` | Clear data/destructive actions |
| `softMint` | `#6EE7B7` | Success states (export complete) |
| `warmWhite` | `#FFFFFF` | Card surfaces, sheets |

Typography uses Nunito at defined sizes (titleLarge 20sp, titleMedium 16sp, bodyMedium 14sp, caption 12sp). Spacing follows 8pt base (xs=8, md=16, lg=24).

### Sections to Document

1. **Profile Section** — User name field, due date display with date picker trigger
2. **Notifications Section** — Toggle switches for: daily reminders, symptom alerts, appointment reminders, weekly digest
3. **Data Section** — Export data button (generates shareable file), Clear all data button (triggers confirmation dialog)
4. **About Section** — App version display, privacy policy link, terms of service link

### Widget Structure

```
Scaffold
├── AppBar ("Settings", back button, hidden bottom nav)
└── Body: ListView (grouped sections)
    ├── Section 1: Profile Card (name + due date)
    ├── Section 2: Notifications Card (toggle list)
    ├── Section 3: Data Card (export + clear)
    └── Section 4: About Card (version + links)
```

### Data Entities

| Entity | Provider | Fields |
|---|---|---|
| `UserPreferences` | `UserPreferencesProvider` | `name`, `notificationsEnabled`, `dueDate` (shared with PregnancyProfile) |
| `PregnancyProfile` | `PregnancyProfileProvider` | `dueDate` |

### Key Interactions

- Tap name field → inline edit or bottom sheet
- Tap due date → `showDatePicker` bottom sheet
- Toggle switches → `UserPreferencesProvider.updateNotification(category, enabled)`
- Tap Export → generates JSON/CSV, triggers share sheet
- Tap Clear Data → `AlertDialog` confirmation → `UserPreferencesProvider.clearAll()`
- Tap Privacy Policy → external URL or internal route

### Motion

- Screen push: 300ms slide + fade (standard)
- List items: staggered reveal 50ms between items
- Toggle switch: 200ms thumb slide
- Card tap: 200ms scale to 98% feedback

### Accessibility

- All toggles: semantic labels with current state
- Name field: "User name, $name, double tap to edit"
- Due date: "Due date, $date, double tap to change"
- Export: "Export data, double tap to save and share"
- Clear: "Clear all data, double tap to delete all app data"
- Touch targets: all 48dp minimum

---

### Critical Files for Implementation

1. **`lib/screens/settings/settings_screen.dart`** — The main settings screen widget (does not exist yet, needs to be created)
2. **`lib/providers/user_preferences_provider.dart`** — UserPreferencesProvider for name, notification prefs
3. **`lib/providers/pregnancy_profile_provider.dart`** — PregnancyProfileProvider for due date
4. **`lib/theme/app_theme.dart`** — Design tokens (AppTheme constants for spacing, colors, radius)
5. **`.stitch/designs/settings/SPEC.md`** — This specification document (the output of this task)