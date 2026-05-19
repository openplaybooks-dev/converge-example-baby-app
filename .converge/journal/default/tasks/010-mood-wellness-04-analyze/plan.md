# Plan: Analyze: Mood & Wellness



Based on my analysis, I can identify the widget regions that should be extracted from `mood_wellness_screen.dart`.

## Analysis Summary

The screen contains these widget subtrees:

1. **_TodaysMoodCard** (~163 lines) - Card with mood emoji selector (5 emojis) and note input field. Self-contained visual block with its own data concerns. Not shared.

2. **_MoodEmoji** (~50 lines) - Individual mood selection emoji button with selection state and animation. Reusable across screens for mood logging. **Shared: true**.

3. **_MoodTrendChart** (~106 lines) - Line chart card showing mood history with time range chips. Self-contained chart card.

4. **_EnergyTrendChart** (~106 lines) - Line chart card showing energy history with identical structure to MoodTrendChart. Self-contained chart card.

5. **_WellnessTipCard** (~133 lines) - Expandable card showing wellness tips with animated expand/collapse. Screen-specific.

6. **_ChartChip** (~41 lines) - Time range selector chip used by both trend charts. **Shared: true** - already reused in multiple places.

### Not Extracted (Below threshold or not widgets)
- `_MoodChartPainter` - CustomPainter (not a widget subtree)
- `_EnergyChartPainter` - CustomPainter (not a widget subtree)

### Critical Files for Implementation

1. `lib/screens/mood_wellness/mood_wellness_screen.dart` - Source file to refactor
2. `.stitch/designs/mood-wellness/widgets.jsonl` - Output file to create
3. `.stitch/designs/mindfulness/widgets.jsonl` - Reference for naming conventions
4. `.stitch/designs/health-log/widgets.jsonl` - Reference for shared widget patterns
5. `.stitch/designs/pregnancy-progress/widgets.jsonl` - Reference for complex card patterns

The extraction will produce 6 widget entries: `TodaysMoodCard`, `MoodEmoji` (shared), `MoodTrendChart`, `EnergyTrendChart`, `WellnessTipCard`, and `ChartChip` (shared).