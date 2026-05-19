# Plan: Analyze: Health Log



Based on my analysis of `health_log_screen.dart`, here's the widget extraction plan:

## Widget Extraction Analysis

| Widget | Lines | Justification |
|--------|-------|---------------|
| `_SummaryStatsCard` | 92 | Self-contained stats banner with icons and metrics. Contains business logic (week symptom count, next appointment). |
| `_HealthEntryCard` | 161 | Fully reusable card for health entries. Handles multiple entry types (symptom, doctor visit, reminder), severity indicators, badges, and enabled states. |
| `_AddEntryFab` | 15 | Common FAB pattern. Reusable across health-related screens. |

## Recommended Extraction (widgets.jsonl)

```jsonl
{"name": "SummaryStatsCard", "grep": "class _SummaryStatsCard", "description": "Summary banner showing weekly symptom count and next prenatal appointment", "shared": false}
{"name": "HealthEntryCard", "grep": "class _HealthEntryCard", "description": "Health log entry card with severity dots, badges, enabled indicator, and time", "shared": true}
{"name": "AddEntryFab", "grep": "class _AddEntryFab", "description": "Floating action button for adding new health log entries", "shared": true}
```

**Notes:**
- Section headers (`Today`, `Yesterday`, `May 15, 2026`) are plain Text widgets under 10 lines — excluded per criteria
- The `SeverityDots` sub-pattern (lines 305-327) is under the 15-line threshold for extraction but could be considered for extraction if `HealthEntryCard` is ever split further

### Critical Files for Implementation
1. `lib/screens/health_log/health_log_screen.dart` — Source file
2. `.stitch/designs/health-log/widgets.jsonl` — Target output
3. `.stitch/designs/cycle-tracking/widgets.jsonl` — Reference pattern (similar card-based design)
4. `.stitch/designs/home/widgets.jsonl` — Reference pattern (similar shared widget conventions)