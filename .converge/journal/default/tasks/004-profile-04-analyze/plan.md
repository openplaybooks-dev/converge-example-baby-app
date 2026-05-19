# Plan: Analyze: Profile



Based on my analysis of `profile_screen.dart`, I can identify several widget subtrees that meet the extraction criteria:

**Extractable Widgets:**

1. **_ProfileHeader** (~80 lines) - Avatar, name, due date display with animation. Profile-specific, `shared: false`.

2. **_NavCard** (~100 lines) - Self-contained card with icon, title, description, animated press feedback, tap routing. Reused by MindfulnessCard and SettingsCard, `shared: true`.

3. **_AboutCard** (~58 lines) - App info card with name, version, privacy policy link. `shared: false`.

4. **_BottomNavBar** (~49 lines) - Bottom navigation container. `shared: true`.

5. **_NavItem** (~48 lines) - Individual nav item with icon, label, active state styling. Used within BottomNavBar, `shared: true`.

**Not extracted:**
- `_MindfulnessCard` and `_SettingsCard` are thin wrappers (~23 lines each) that only configure `_NavCard` with different parameters — they don't meet the threshold on their own.

---

### Critical Files for Implementation

1. `lib/screens/profile/profile_screen.dart` — Source file being analyzed
2. `.stitch/designs/home/widgets.jsonl` — Reference for shared widget patterns (MoodCard, BottomNavBar, etc.)
3. `.stitch/designs/browse/widgets.jsonl` — Another reference pattern (LinkCard)
4. `.stitch/designs/profile/widgets.jsonl` — Target output file to create
5. `.stitch/designs/profile/SPEC.md` — Existing spec to understand conventions