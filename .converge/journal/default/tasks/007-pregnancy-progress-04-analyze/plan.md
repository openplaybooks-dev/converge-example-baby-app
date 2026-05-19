# Plan: Analyze: My Pregnancy



Now I have a clear understanding of the source file and the expected JSONL format. Let me analyze the screen to identify extractable widget regions.

## Analysis Summary

The `pregnancy_progress_screen.dart` contains 6 extractable widget regions:

| Widget | Lines | Description |
|--------|-------|-------------|
| `_WeekHeroCard` | 102 | Hero section showing week number, trimester, fruit emoji, and due date with gradient background |
| `_BodyChangesCard` | 90 | Card listing body changes for the week with bullet points |
| `_BabyDevelopmentCard` | 56 | Card showing baby's developmental milestones |
| `_SelfCareTipsCard` | 120 | Card with expandable self-care tip tiles (has own state) |
| `_ExpandableTipTile` | 85 | Reusable expandable tile component with number badge, title, and detail |
| `_DueDateSummaryCard` | 117 | Bottom summary bar showing trimester badge and days remaining |

All 6 widgets meet the extraction criteria:
- Self-contained visual blocks (cards/sections)
- All exceed 15+ lines
- All have reusable potential across screens
- All have their own data/state concerns

### Critical Files for Implementation

1. **`lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`** — Source file containing all 6 widget classes to extract
2. **`.stitch/designs/pregnancy-progress/widgets.jsonl`** — Target output file (does not exist yet, must be created)
3. **`.stitch/designs/home/widgets.jsonl`** — Reference for JSONL format conventions
4. **`lib/theme/app_theme.dart`** — Theme constants referenced by all widget classes (spacing, radius, shadows)
5. **`lib/screens/pregnancy_progress/`** — Target directory where extracted widget files would be placed

---

**Note:** Per the task instructions, this is a READ-ONLY planning task. The `.stitch/designs/pregnancy-progress/widgets.jsonl` file does not exist yet and would need to be created with the following content:

```jsonl
{"name": "WeekHeroCard", "grep": "Week $week", "description": "Hero card showing current week with fruit emoji, trimester badge, and due date countdown", "shared": true}
{"name": "BodyChangesCard", "grep": "Body Changes", "description": "Card listing body changes for the current pregnancy week with bullet points", "shared": true}
{"name": "BabyDevelopmentCard", "grep": "Baby's Development", "description": "Card displaying baby's developmental milestones for the current week", "shared": true}
{"name": "SelfCareTipsCard", "grep": "Self-Care Tips", "description": "Expandable tips card with numbered tiles showing self-care recommendations", "shared": true}
{"name": "ExpandableTipTile", "grep": "isExpanded", "description": "Expandable tile with number badge, title, and collapsible detail text", "shared": true}
{"name": "DueDateSummaryCard", "grep": "days to go", "description": "Bottom summary bar showing trimester badge and countdown to due date", "shared": true}
```