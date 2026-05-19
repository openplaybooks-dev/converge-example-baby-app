# Plan: Analyze: Settings



Based on my analysis of `settings_screen.dart`, I can identify the following widget subtrees that should be extracted into separate files:

**Already isolated as private classes but could be extracted as shared widgets:**

| Widget | Lines | Description | Shared |
|--------|-------|-------------|--------|
| `_SettingsCard` | 47 | Container with animated scale press effect | `true` |
| `_ListItemRow` | 84 | Icon + title/description + optional chevron | `true` |
| `_SwitchRow` | 65 | Toggle row with title/description | `true` |
| `_ActionRow` | 89 | Icon + label/description + chevron | `true` |
| `_AboutRow` | 44 | Label + value row | `true` |
| `_LinkRow` | 58 | Icon + link text + chevron | `true` |
| `_InkWellScale` | 31 | Press animation wrapper | `true` |

**Section widgets** - These are Settings-specific and contain their own state/data concerns:
- `_SectionProfile` (50 lines) - Profile data display
- `_SectionNotifications` (75 lines) - Contains state: 4 boolean toggles
- `_SectionData` (123 lines) - Contains AlertDialog for confirmation
- `_SectionAbout` (50 lines) - Static about info

### Critical Files for Implementation

1. **`lib/screens/settings/settings_screen.dart`** — Primary file being analyzed
2. **`.stitch/designs/settings/widgets.jsonl`** — Output file with widget extraction plan
3. **`lib/theme/app_theme.dart`** — Referenced for `AppTheme.space*`, `AppTheme.radius*`, `AppTheme.shadow`
4. **`lib/widgets/`** — Target directory where extracted widgets would be placed (based on convention)
5. **`lib/screens/settings/`** — Directory structure for the settings screen and its extracted widgets

The extraction would move reusable UI components (`_SettingsCard`, `_ListItemRow`, `_SwitchRow`, `_ActionRow`, `_AboutRow`, `_LinkRow`, `_InkWellScale`) to `lib/widgets/` since they follow the pattern of "reusable across screens". The section-specific widgets (`_SectionProfile`, `_SectionNotifications`, `_SectionData`, `_SectionAbout`) should remain in `settings_screen.dart` or be moved to a `lib/screens/settings/widgets/` directory as screen-specific components.