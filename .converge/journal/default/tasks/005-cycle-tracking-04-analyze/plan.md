# Plan: Analyze: Cycle Tracking



Now I have a clear understanding of the codebase patterns and the cycle_tracking_screen.dart structure. Let me analyze and identify the extractable widget regions.

## Analysis Summary

The file contains several distinct widget regions that meet the extraction criteria:

| Widget | Lines | Self-Contained | Reusable | Data/State |
|--------|-------|----------------|----------|------------|
| `_buildCurrentCycleCard` | 97 | Yes (card) | Potentially | No (stateless) |
| `_buildHistoryItem` | 84 | Yes (list item) | Yes | No (receives params) |
| `_LogCycleBottomSheet` | 124 | Yes | Yes | Yes (Stateful) |
| `_FertileWindowBottomSheet` | 59 | Yes | Yes | No (stateless) |
| `_EntryDetailBottomSheet` | 108 | Yes | Yes | No (stateless) |

### Candidates for Extraction:

1. **`CurrentCycleCard`** - Large card (97 lines) showing current cycle status with day counter, progress bar, fertile window indicator
2. **`HistoryItemCard`** - Reusable list item (84 lines) used 3 times with different data
3. **`LogCycleBottomSheet`** - Stateful form (124 lines) for logging cycle data
4. **`FertileWindowBottomSheet`** - Informational sheet (59 lines) displaying ovulation prediction
5. **`EntryDetailBottomSheet`** - Form sheet (108 lines) for viewing/editing cycle entry details

---

### Critical Files for Implementation

1. **`lib/screens/cycle_tracking/cycle_tracking_screen.dart`** - Source file containing all widgets to extract
2. **`.stitch/designs/cycle-tracking/widgets.jsonl`** - Target file to create (does not exist yet)
3. **`lib/theme/app_theme.dart`** - Referenced for theming constants like `AppTheme.spaceMd`, `AppTheme.radiusLg`
4. **`.stitch/designs/home/widgets.jsonl`** - Reference pattern for JSONL structure and widget naming conventions
5. **`lib/screens/`** - Target directory where extracted widgets would be placed

---

### Implementation Plan

1. Create directory `.stitch/designs/cycle-tracking/` (if doesn't exist)
2. Write `.stitch/designs/cycle-tracking/widgets.jsonl` with 5 entries:

```jsonl
{"name": "CurrentCycleCard", "grep": "_buildCurrentCycleCard", "description": "Card displaying current cycle day, progress bar, and fertile window indicator", "shared": false}
{"name": "HistoryItemCard", "grep": "ClipRRect\\(\\s*borderRadius: BorderRadius\\.circular\\(AppTheme\\.radiusPill\\)", "description": "List item showing cycle history entry with date range, duration badge, progress bar and notes", "shared": true}
{"name": "LogCycleBottomSheet", "grep": "class _LogCycleBottomSheet", "description": "Bottom sheet form with date picker, cycle length input, notes field, and irregular cycle toggle", "shared": true}
{"name": "FertileWindowBottomSheet", "grep": "displayMedium\\s*\\?\\.copyWith", "description": "Bottom sheet displaying ovulation prediction date and fertile window information", "shared": true}
{"name": "EntryDetailBottomSheet", "grep": "class _EntryDetailBottomSheet", "description": "Bottom sheet for viewing and editing cycle entry details with delete and save actions", "shared": true}
```

### Extraction Rationale

- **`HistoryItemCard`**: Marked `shared: true` because the same visual pattern (date range + badge + progress + note) could appear in analytics screens, reports, or other cycle-related views
- **`CurrentCycleCard`**: Marked `shared: false` as it's specific to the tracking screen's main dashboard view
- **All BottomSheets**: Marked `shared: true` as reusable UI patterns (forms, info displays) that could be used in similar contexts