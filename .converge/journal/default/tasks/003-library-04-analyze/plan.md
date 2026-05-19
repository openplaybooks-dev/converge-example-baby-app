# Plan: Analyze: Library



Now I have a clear understanding of the codebase. The library_screen.dart contains the LibraryScreen widget with several extractable regions.

Let me analyze the screen and identify the widget regions that meet the extraction criteria:

**Analysis of library_screen.dart:**

1. **`_LinkCard`** (lines 129-230, ~100 lines): A self-contained card with animated tap interaction, icon container, title, description, and chevron. Has its own StatefulWidget state (`_LinkCardState`). This is clearly extractable - it's a reusable card component.

2. **`_buildNavDestination`** (lines 86-126, ~40 lines): An individual navigation item with icon, label, and active state styling. This is a reusable component for bottom navigation.

3. **`_buildBottomNavigationBar`** (lines 60-84): The bottom navigation bar container that holds nav destinations. This is a shared pattern across screens.

**Extraction decisions:**
- `_LinkCard` → `LinkCard` (shared: true) - reusable card with tap animation
- `_buildNavDestination` → `NavDestination` (shared: true) - reusable nav item
- `_buildBottomNavigationBar` → `BottomNavBar` (shared: true) - shared navigation pattern

Looking at the home/widgets.jsonl pattern, widgets like `MoodCard`, `ChecklistSection`, and `BottomNavBar` follow similar extraction logic.

### Critical Files for Implementation

1. **`lib/screens/library/library_screen.dart`** — The source file to extract widgets from
2. **`.stitch/designs/library/widgets.jsonl`** — The output file to write (already exists, needs to be updated with extracted widget entries)
3. **`.stitch/designs/home/widgets.jsonl`** — Reference for shared widget pattern (NavDestination, BottomNavBar are already marked as shared)
4. **`lib/screens/library/link_card.dart`** — Target file for extracted LinkCard widget (new file)
5. **`lib/widgets/nav_destination.dart`** — Target file for extracted NavDestination widget (shared across screens)