# Spec: Mindfulness — Screen Specification

## 1. Screen Title

**Mindfulness**

---

## 2. Purpose

Guided breathing exercises, light stretching guides, and mindful activity suggestions. This screen provides anxiety-prone mothers with accessible stress relief tools that are gentle, non-clinical, and quick to use.

---

## 3. Route

`/mindfulness`

---

## 4. Widget Name

`MindfulnessScreen`

---

## 5. Design Tokens

### Colors (Light Theme)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, active states |
| `blushRose` | `#F9A8D4` | Secondary accent, trimester badges |
| `softMint` | `#6EE7B7` | Success states, completion checkmarks |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |

### Typography (Nunito)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `headlineMedium` | 22sp | 600 | 28sp | Section headers |
| `titleMedium` | 16sp | 600 | 24sp | Card titles, exercise names |
| `bodyLarge` | 16sp | 400 | 24sp | Body text, descriptions |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, metadata |
| `labelLarge` | 14sp | 600 | 20sp | Button labels |
| `caption` | 11sp | 500 | 16sp | Badges, timestamps |

### Spacing (8pt base)

| Token | Value |
|---|---|
| `xxs` | 4dp |
| `xs` | 8dp |
| `sm` | 12dp |
| `md` | 16dp |
| `lg` | 24dp |

### Corner Radius

| Token | Value |
|---|---|
| `sm` | 8dp (chips) |
| `lg` | 16dp (standard cards) |
| `pill` | 999dp (pills, avatars) |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with standard `AppBar` (no SliverAppBar needed)
- `AppBar`: Title "Mindfulness", back button (48dp touch target), no FAB
- `BottomNavigationBar`: Hidden on this screen
- Body: `ListView` with 16dp horizontal padding

### AppBar Behavior

- Background: `lavenderTint` (#F5F3FF)
- Title: "Mindfulness" — `headlineSmall` (SemiBold 20sp), `deepGraphite`
- Leading: `ArrowBackIOS` icon button with 48dp touch target
- Center title: `centerTitle: true`

### Body Layout

- `ListView` with two major sections
- Section vertical spacing: 24dp between major sections
- Card internal padding: 16dp all sides
- Card gap: 12dp between cards
- Bottom safe area: respect home indicator

---

## 7. Sections

### Section 1: Breathing Exercises

**Description:** A card list of breathing exercises with name, duration, and difficulty badge. Tapping a card triggers the `overlay:breathing-exercise` full-screen overlay.

**Widget Type:** `Column` containing section header + `ListView.separated` (vertical)

**Layout:**
- Section header: "Breathing Exercises" (`headlineMedium`, left-aligned)
- List of `BreathingExerciseCard` widgets
- Cards separated by 12dp spacing

**Components:**

Each `BreathingExerciseCard` contains:
- Exercise name (`titleMedium`)
- Duration text (`bodyMedium`, `stoneGrey`) — e.g., "2 min"
- Difficulty badge chip (`caption`) — "Beginner", "Intermediate", "Advanced"
- Chevron right icon (`stoneGrey`)
- Card background: `morningMist` with 16dp radius, soft shadow
- Entire card is tappable (48dp+ touch target)

**Data Requirements:**
- Static exercise catalog (no provider for MVP)
- Exercise fields: `id`, `name`, `durationSeconds`, `difficulty`, `description`
- Difficulty values: "Beginner", "Intermediate", "Advanced"

**Sample Data:**

```dart
[
  { id: "box-breathing", name: "Box Breathing", duration: 240, difficulty: "Beginner", description: "4-4-4-4 pattern for calm" },
  { id: "deep-breathe", name: "Deep Breathing", duration: 180, difficulty: "Beginner", description: "Simple inhale-exhale relaxation" },
  { id: "4-7-8", name: "4-7-8 Technique", duration: 270, difficulty: "Intermediate", description: "Promotes sleep and reduces anxiety" },
  { id: "energizing", name: "Energizing Breath", duration: 120, difficulty: "Intermediate", description: "Quick energizing breaths" },
]
```

**Interactive Elements:**
- Tap card → triggers overlay route `overlay:breathing-exercise` with exercise ID parameter
- Card press feedback: 200ms ease-out scale to 98%

---

### Section 2: Stretching & Self-Care

**Description:** A card list of stretching routines with routine name, trimester suitability, and estimated time. Tapping triggers `overlay:stretching-guide` bottom sheet.

**Widget Type:** `Column` containing section header + `ListView.separated` (vertical)

**Layout:**
- Section header: "Stretching & Self-Care" (`headlineMedium`, left-aligned)
- List of `StretchingRoutineCard` widgets
- Cards separated by 12dp spacing

**Components:**

Each `StretchingRoutineCard` contains:
- Routine name (`titleMedium`)
- Trimester badge (pill shape, `blushRose` background) — "All Trimester", "1st Tri", "2nd Tri", "3rd Tri"
- Duration text (`bodyMedium`, `stoneGrey`) — e.g., "10 min"
- Chevron right icon (`stoneGrey`)
- Card background: `morningMist` with 16dp radius, soft shadow

**Data Requirements:**
- Static routine catalog
- Routine fields: `id`, `name`, `durationMinutes`, `trimesterSuitability`, `steps`

**Sample Data:**

```dart
[
  { id: "neck-shoulders", name: "Neck & Shoulders", duration: 5, trimester: "All", steps: [...] },
  { id: "hip-opener", name: "Hip Opener", duration: 10, trimester: "2nd/3rd", steps: [...] },
  { id: "standing-stretch", name: "Standing Stretch", duration: 8, trimester: "1st/2nd", steps: [...] },
  { id: "floor-relaxation", name: "Floor Relaxation", duration: 15, trimester: "All", steps: [...] },
]
```

**Interactive Elements:**
- Tap card → triggers overlay route `overlay:stretching-guide` with routine ID parameter
- Card press feedback: 200ms ease-out scale to 98%

---

## 8. Data

### Entities

**BreathingExercise**
- `id`: String — unique identifier
- `name`: String — exercise name
- `durationSeconds`: int — duration in seconds
- `difficulty`: String — "Beginner" | "Intermediate" | "Advanced"
- `description`: String — brief description

**StretchingRoutine**
- `id`: String — unique identifier
- `name`: String — routine name
- `durationMinutes`: int — estimated duration in minutes
- `trimesterSuitability`: String — "All" | "1st/2nd" | "2nd/3rd" | etc.
- `steps`: List<String> — step-by-step instructions

### State Management

- `SelfCareCheckStateProvider` — tracks mindfulness completion (for Home checklist integration)
  - On completing a breathing exercise or stretching routine: mark the item complete in `SelfCareCheckState`

### Provider Dependencies (MVP)

- No provider dependency for exercise/routine data (static catalog)
- `SelfCareCheckState` integration is optional for MVP

---

## 9. Motion

### Entry Animations

- Screen loads with staggered fade-in for sections: 50ms delay between sections
- Section headers fade in with 200ms `easeOut`
- Cards cascade with 50ms stagger delay between each card

### Interactive Feedback

- Card tap: 200ms ease-out scale to 98%, then 200ms return to 100%
- Difficulty/trimester chips: no animation (static badges)

### Overlay Transitions

- Breathing exercise overlay: 300ms slide-up with `Curves.easeInOut` (full-screen)
- Stretching guide overlay: 250ms slide-up with `Curves.easeOut` (bottom sheet)

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Mindfulness screen, go back'` |
| Breathing card | `'$name breathing exercise, $duration, $difficulty, tap to start'` |
| Stretching card | `'$name stretching routine, $duration, tap to view guide'` |
| Difficulty badge | `'$difficulty level'` |
| Trimester badge | `'$suitability trimester suitability'` |

### Focus Order

1. AppBar (back button)
2. Breathing exercises section header
3. Breathing exercise cards (top to bottom)
4. Stretching section header
5. Stretching routine cards (top to bottom)

### Contrast Notes

- All text meets WCAG AA contrast (4.5:1 minimum)
- `deepGraphite` on `morningMist`: ~12:1
- `stoneGrey` on `morningMist`: ~4.7:1

### Screen Reader Support

- `ExcludeSemantics` on decorative chevron icons
- Live region when overlay is triggered: "Opening $name"

---

## 11. Anti-Patterns

**Do Not:**
- Add a FAB to this screen (per UX spec, FAB is None)
- Add `BottomNavigationBar` (hidden per spec)
- Use platform default colors — all from design system
- Use any font other than Nunito
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Create touch targets smaller than 48dp
- Add animations that are abrupt or bouncy — use gentle `easeInOut`
- Use gradients on cards — flat `morningMist` only
- Add more than two main sections — keep it focused
- Use `GridView` — this is a simple vertical list

---

## 12. Critical Files for Implementation

1. **`lib/router/app_router.dart`** — Add GoRoute entry for `/mindfulness` pointing to `MindfulnessScreen`

2. **`lib/theme/app_theme.dart`** — Reference for design tokens (spacing, colors, typography scale)

3. **`lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`** — Reference implementation pattern for a push-screen with `Scaffold`, `AppBar`, `ListView` body, and card-based content

4. **`.stitch/designs/mindfulness/SPEC.md`** — This specification document

5. **`.stitch/screens.json`** — Reference for screen definitions and overlay parent relationships (`mindfulness` → `breathing-exercise`, `stretching-guide`)

---

## 13. Screen Structure

```
MindfulnessScreen
├── Scaffold
│   ├── AppBar ("Mindfulness", back button)
│   └── body: ListView
│       ├── Section 1: Breathing Exercises
│       │   └── ListView.separated
│       │       └── BreathingExerciseCard × N
│       └── Section 2: Stretching & Self-Care
│           └── ListView.separated
│               └── StretchingRoutineCard × N
```

---

## 14. Route Definition

```dart
GoRoute(
  path: '/mindfulness',
  builder: (context, state) => const MindfulnessScreen(),
),
```

---

## 15. Overlay Handling

The breathing exercise and stretching guide overlays are separate routes (`overlay:breathing-exercise`, `overlay:stretching-guide`). For MVP, these can be implemented as:

- `BreathingExerciseOverlay` (full-screen, pushes over navigation stack)
- `StretchingGuideSheet` (bottom sheet, uses `showModalBottomSheet`)