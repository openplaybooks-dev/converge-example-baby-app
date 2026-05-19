# Plan: Analyze: Home

Now I have a complete picture of the home screen. Let me provide my analysis.

## Analysis Summary

After reading `lib/screens/home/home_screen.dart`, I've identified widget subtrees that meet the extraction criteria (15+ lines, self-contained visual block, reusable/shared concerns):

### Extracted Widgets

| Widget | Lines | Self-contained | Reusable | Grep Pattern |
|--------|-------|----------------|----------|--------------|
| **MoodCard** | 53 | Card with mood emojis | true | "How are you feeling today?" |
| **MoodButton** | 37 | Mood emoji button | true | "Terrible" |
| **ChecklistSection** | 52 | Checklist with chips | false | "Today's Checklist" |
| **ChecklistChip** | 55 | Individual chip | true | "Weight logged" |
| **QuickActionsSection** | 60 | Grid of actions | false | "Quick Actions" |
| **QuickActionButton** | 44 | Action button | true | "Log Weight" |
| **WeeklyTipCard** | 69 | Gradient tip card | false | "Weekly Tip" |
| **BottomNavBar** | 24 | Navigation bar | true | "Icons.home" |
| **NavDestination** | 40 | Nav item | true | Nav item structure |

### Design Decisions

1. **MoodCard shared=true**: Mood tracking is a cross-screen feature (daily check-ins, history views)
2. **ChecklistSection shared=false**: Today's checklist is specific to the home screen's daily view
3. **QuickActionsSection shared=false**: Layout is specific to home screen's 2x2 grid
4. **WeeklyTipCard shared=false**: Content is home-screen specific; though the pattern could become reusable
5. **BottomNavBar shared=true**: Standard app-wide navigation pattern
6. **ChecklistChip shared=true**: Generic checklist chip reusable for any todo/tracking system

### Critical Files for Implementation

1. **`lib/screens/home/home_screen.dart`** - Source widget to be refactored
2. **`.stitch/designs/home/design.html`** - Visual reference for widget regions
3. **`lib/theme/app_theme.dart`** - Theme constants used by widgets
4. **`lib/router/app_router.dart`** - For navigation integration (BottomNavBar)

The widgets.jsonl file would be written to `.stitch/designs/home/widgets.jsonl` with one JSON object per line in JSONL format.