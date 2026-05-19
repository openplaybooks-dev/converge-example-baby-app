# Plan: Analyze: Education



## Analysis: Education Screen Widget Extraction

### Widget Subtrees Identified

After reading `education_screen.dart`, I identified **4 extractable widget regions** that meet the extraction criteria:

| Widget | Lines | Reason |
|--------|-------|--------|
| `_FeaturedArticleCard` | ~116 | Self-contained card with hero image, topic badge, title, read time. Stateful with scale animation. Could reuse for article cards. |
| `_TopicCard` | ~63 | Self-contained topic icon card with color, icon, and label. Stateful with scale animation. Reusable for grid layouts. |
| `_RecentArticleCard` | ~112 | Self-contained horizontal article preview with image, topic badge, read time. Reusable in lists. |
| `_SearchOverlay` | ~141 | Modal bottom sheet with search input, recent searches chips. Reusable search pattern. |

### Data Models (embedded, not extractable)

- `_TopicData` (lines 311-320) - 9 lines, simple data class
- `_ArticlePreviewData` (lines 389-398) - 9 lines, simple data class

### Planned Output

The `.stitch/designs/education/widgets.jsonl` file should contain:

```jsonl
{"name": "FeaturedArticleCard", "grep": "Understanding Baby Growth: Week by Week", "description": "Hero article card with image, topic badge, title, and read time", "shared": true}
{"name": "TopicCard", "grep": "Nutrition", "description": "Grid card with icon, color, and topic name", "shared": true}
{"name": "RecentArticleCard", "grep": "Best Foods for Morning Sickness", "description": "Horizontal scrollable article preview card", "shared": true}
{"name": "SearchOverlay", "grep": "Search for articles by keyword", "description": "Modal bottom sheet with search input and recent search chips", "shared": true}
```

### Implementation Steps

1. Create directory `.stitch/designs/education/` (if not exists)
2. Write `widgets.jsonl` with one JSON object per line
3. Each `grep` value uses a unique string from the widget's content to enable code location
4. All widgets marked `shared: true` as they represent reusable UI patterns

### Critical Files for Implementation

1. **`lib/screens/education/education_screen.dart`** — Source file containing all 4 widget subtrees to extract
2. **`.stitch/designs/home/widgets.jsonl`** — Reference pattern for JSONL format
3. **`.stitch/designs/education/widgets.jsonl`** — Target output file to create
4. **`lib/theme/app_theme.dart`** — Theme constants referenced by widgets
5. **`lib/widgets/`** — Target directory where extracted widgets would be placed (following pattern from other screens)