# Plan: Analyze: Mindfulness



Based on my analysis of the `mindfulness_screen.dart` file and existing patterns in the codebase, here's my plan:

---

## Analysis: Mindfulness Screen Widget Extraction

### Current Structure

The screen contains these widget classes:
- `MindfulnessScreen` - main screen widget (not extracted)
- `_BreathingSection` (26 lines) - section header + list builder
- `_BreathingExerciseCard` (103 lines) - card for breathing exercises
- `_StretchingSection` (26 lines) - section header + list builder
- `_StretchingRoutineCard` (97 lines) - card for stretching routines

### Key Observation: Structural Similarity

`_BreathingExerciseCard` and `_StretchingRoutineCard` have nearly identical layouts:
- Same `BoxDecoration` with `morningMist` background, `radiusLg`, and shadow
- Same `InkWell` with `onTap` handler
- Same `Row` layout with `Expanded` column and `chevron_right` icon
- Same badge pattern (pill shape with color and text)
- Same text structure (title, subtitle, badge)

The only differences are:
1. Badge content source (`difficulty` vs `trimester`)
2. Badge color logic (conditional based on difficulty vs fixed `blushRose`)

### Extraction Candidates

| Widget | Lines | Rationale |
|--------|-------|-----------|
| **BreathingExerciseCard** | 103 | Self-contained card, 15+ lines, reusable pattern |
| **StretchingRoutineCard** | 97 | Self-contained card, 15+ lines, reusable pattern |
| **ExerciseCard** (shared) | ~60 base | Extractable base structure shared by both |
| **Badge** (shared) | ~15 | Reusable pill badge pattern |

### Recommended Widgets for `.stitch/designs/mindfulness/widgets.jsonl`

```jsonl
{"name": "BreathingExerciseCard", "grep": "Box Breathing", "description": "Tappable card displaying breathing exercise name, duration, and difficulty badge with morningMist background and shadow", "shared": false}
{"name": "StretchingRoutineCard", "grep": "Neck & Shoulders", "description": "Tappable card displaying stretching routine name, duration, and trimester badge with morningMist background and shadow", "shared": false}
{"name": "ExerciseBadge", "grep": "radiusPill", "description": "Pill-shaped badge with configurable color for displaying difficulty or trimester labels", "shared": true}
```

**Reasoning:**
- `BreathingExerciseCard` and `StretchingRoutineCard` are screen-specific (different badge logic, different data sources) but are good candidates for screen-level extraction to reduce complexity
- `ExerciseBadge` is truly reusable and could be shared across other screens with similar pill-badge patterns

### Implementation Approach

1. **Create `ExerciseBadge`** (shared) - A generalized badge widget accepting `label`, `backgroundColor`, `textColor` parameters
2. **Extract `BreathingExerciseCard`** - Pull out as a reusable card with difficulty-based badge logic
3. **Extract `StretchingRoutineCard`** - Pull out with trimester-based badge logic

Since `_BreathingExerciseCard` and `_StretchingRoutineCard` are structurally nearly identical (same layout, same styling), a future refactor could create a shared `ExerciseCard` base with configurable badge content. However, for initial extraction per the task criteria, keeping them separate with screen-specific badge logic is appropriate.

---

### Critical Files for Implementation

1. **`lib/screens/mindfulness/mindfulness_screen.dart`** - Source file with widget definitions to extract
2. **`.stitch/designs/mindfulness/widgets.jsonl`** - Output file for widget manifest
3. **`lib/theme/app_theme.dart`** - Theme constants referenced by extracted widgets
4. **`.stitch/designs/browse/widgets.jsonl`** - Reference for JSONL format convention
5. **`lib/widgets/`** - Target directory where extracted widgets would be placed (existing pattern from other screens)