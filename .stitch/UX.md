# Pregnant Tracker - Baby Bump — UX Specification

## Part 1: Project Overview

**App Name:** Pregnant Tracker - Baby Bump
**Platform:** Flutter Mobile (iOS & Android)
**Core Identity:** Calming, nurturing, empowering, trustworthy

### User Personas

| Persona | Description | Key Goals |
|---|---|---|
| First-Time Expecting Mothers | First pregnancy, seeking guidance and reassurance | Week-by-week progress, trusted information, due date tracking |
| Health-Conscious Mothers | Actively monitors weight, nutrition, exercise | Data-driven charts, daily logs, actionable insights |
| Anxiety-Prone Mothers | Elevated stress and emotional changes | Breathing exercises, mood logging, stress relief |

---

## Part 2: Vibe

- **Visual Atmosphere:** Soft, warm nursery aesthetic — like a cozy sunlit room with gentle natural light
- **Color Mood:** Cool-warm pastels anchored by lavender with blush rose accents; serene, never clinical
- **Typography Character:** Rounded, friendly, modern — Google Fonts "Nunito" family; generous letter-spacing for calm readability
- **Motion Personality:** Gentle spring-based animations with `Curves.easeInOut`; 300–400ms standard duration; nothing abrupt or bouncy

---

## Part 3: Screens

### 3.1 Home (`/`)

**Purpose:** Central dashboard showing today's snapshot — pregnancy progress, quick-log buttons, and personalized wellness nudges.

**Scaffold:**
- `AppBar`: Title "Baby Bump", no back button, trailing avatar icon
- `BottomNavigationBar`: Visible (4 tabs)
- `FAB`: None

**Body:** `CustomScrollView` with `SliverAppBar` (collapsing, shows current week badge).

**Sections:**
1. **Week Banner** — Large centered card showing pregnancy week, due date countdown, fruit-size comparison
2. **Mood Check-In Card** — Quick mood selector (5 emojis), tappable to log
3. **Today's Checklist** — Horizontal scrollable chips: weight entry, water intake, mood, symptom log
4. **Quick Actions** — 4 primary buttons: Log Weight, Log Mood, Log Symptoms, View Education
5. **Weekly Tip** — Single card with rotating wellness tip

**Data:** Reads from `PregnancyProfileProvider` (current week, due date), `MoodEntryProvider` (today's mood), `SelfCareCheckState` (today's checklist)

**Interactions:** Tap mood → log mood; tap weight → push weight form; tap symptom → push symptom form; tap education → tab to Education

**Transitions:** Arrives via bottom nav tab (no animation); pull-down refreshes widget data.

---

### 3.2 Cycle Tracking (`/cycle-tracking`)

**Purpose:** Log menstrual cycles, view ovulation predictions, manage cycle-related reminders.

**Scaffold:**
- `AppBar`: Title "Cycle Tracking", back button
- `BottomNavigationBar`: Hidden
- `FAB`: `+` to log a new cycle entry

**Body:** `ListView` with two sections.

**Sections:**
1. **Current Cycle Card** — Shows days since last period, next ovulation window estimate
2. **Cycle History List** — Chronological list of logged cycles with length indicators

**Data:** `CycleEntryProvider`

**Interactions:** Tap `+` FAB → bottom sheet form for new cycle log; long-press history entry → edit/delete sheet; tap ovulation window → detail bottom sheet

**Transitions:** Push from Home or bottom nav Browse; swipe-back to dismiss.

---

### 3.3 Weight & Nutrition (`/weight-nutrition`)

**Purpose:** Log daily weight, view progress chart, read stage-specific nutrition tips.

**Scaffold:**
- `AppBar`: Title "Weight & Nutrition", back button
- `BottomNavigationBar`: Hidden
- `FAB`: `+` to log today's weight

**Body:** `CustomScrollView` with `SliverAppBar`.

**Sections:**
1. **Progress Chart** — Line chart of weight over time; toggles 1 week / 1 month / all time
2. **Latest Entry** — Today's weight with delta from previous entry
3. **Nutrition Tips** — Stage-specific card (updates based on current pregnancy week)
4. **Weight Log List** — Scrollable list of all entries (date + weight + optional note)

**Data:** `WeightEntryProvider`, `PregnancyProfileProvider` (for week-based tips)

**Interactions:** Tap chart toggle → re-renders chart; tap `+` → bottom sheet form; long-press log entry → edit/delete sheet; tap nutrition tip → expand detail

**Transitions:** Push from Home Browse tab or Education detail; swipe-back to dismiss.

---

### 3.4 Pregnancy Progress (`/pregnancy-progress`)

**Purpose:** Due date management, week-by-week body change descriptions, fetal development visuals.

**Scaffold:**
- `AppBar`: Title "My Pregnancy", back button
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `PageView` with `PageController` (week-by-week swiper) + bottom summary section.

**Sections:**
1. **Week Hero** — Full-screen illustrated card with fruit-size comparison and week number prominently displayed
2. **Body Changes** — Bulleted list of what to expect this week
3. **Baby Development** — Short paragraph on fetal development
4. **Self-Care Tips** — 3 actionable tips for this week
5. **Due Date Summary** — Bottom card showing due date, days remaining, trimester badge

**Data:** `PregnancyProfileProvider` (current week, due date)

**Interactions:** Swipe left/right → navigate weeks; tap self-care tip → expand to full recommendation

**Transitions:** Push from Home; PageView swipe-back returns to previous screen.

---

### 3.5 Mindfulness (`/mindfulness`)

**Purpose:** Guided breathing exercises, light stretching guides, mindful activity suggestions.

**Scaffold:**
- `AppBar`: Title "Mindfulness", back button
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `ListView` with two sections.

**Sections:**
1. **Breathing Exercises** — Card list with exercise name, duration, difficulty badge; tap → full-screen breathing animation overlay
2. **Stretching & Self-Care** — Card list with routine name, trimester suitability, estimated time; tap → step-by-step guide bottom sheet

**Data:** Static exercise catalog (no provider dependency for MVP); `SelfCareCheckState` for completion tracking

**Interactions:** Tap breathing card → overlay:breathing-exercise (full-screen animated overlay); tap stretching card → overlay:stretching-guide (bottom sheet with steps)

**Transitions:** Push from Home or bottom nav; overlay slides up from bottom.

---

### 3.6 Health Log (`/health-log`)

**Purpose:** Unified timeline of all health entries — symptoms, doctor visits, reminders.

**Scaffold:**
- `AppBar`: Title "Health Log", back button, trailing filter icon
- `BottomNavigationBar`: Hidden
- `FAB`: `+` to add new entry

**Body:** `ListView` with chronological timeline.

**Sections:**
1. **Timeline** — Mixed list of `SymptomEntry`, `DoctorVisit`, `Reminder` entries sorted by date descending
2. **Summary Stats** — Top banner: total symptoms logged this week, next upcoming reminder

**Data:** `SymptomEntryProvider`, `DoctorVisitProvider`, `ReminderProvider`

**Interactions:** Tap `+` FAB → bottom sheet with entry type selector; tap entry → detail/edit bottom sheet; tap filter icon → bottom sheet filter options

**Transitions:** Push from Home; swipe-back to dismiss.

---

### 3.7 Mood & Wellness (`/mood-wellness`)

**Purpose:** Log daily moods and energy levels, visualize patterns over time, receive gentle wellness nudges.

**Scaffold:**
- `AppBar`: Title "Mood & Wellness", back button
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `CustomScrollView` with `SliverAppBar`.

**Sections:**
1. **Today's Mood Card** — Large emoji selector (5 options) + optional note field; tap to log
2. **Mood Trend Chart** — 7-day line chart of mood scores; tap data point → day detail
3. **Energy Trend Chart** — 7-day line chart of energy levels
4. **Wellness Tip** — Contextual recommendation based on recent mood/energy patterns

**Data:** `MoodEntryProvider`

**Interactions:** Tap emoji → saves mood for today; tap chart point → bottom sheet with day's detail; tap wellness tip → expand

**Transitions:** Push from Home; swipe-back to dismiss.

---

### 3.8 Education (`/education`)

**Purpose:** Browse and read trusted educational articles organized by topic.

**Scaffold:**
- `AppBar`: Title "Education", back button, trailing search icon
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `ListView` with topic sections.

**Sections:**
1. **Featured Article** — Hero card at top with large image and headline
2. **Topics Grid** — 2-column grid of topic cards: Nutrition, Body Changes, Maternal Care, Exercise, Mental Health
3. **Recent Articles** — Horizontal scroll of recently viewed articles

**Data:** Static article catalog (no provider for MVP); `ArticleProvider` for bookmarking

**Interactions:** Tap topic card → `/education/:topic` (filtered article list); tap article → `/article-reader/:id`; tap search → search overlay; tap bookmark icon → toggle bookmark

**Transitions:** Push from Home or Browse tab; swipe-back to dismiss.

---

### 3.9 Article Reader (`/article-reader/:id`)

**Purpose:** Read a single article with clean typography, bookmark capability.

**Scaffold:**
- `AppBar`: Title from article topic, back button, trailing bookmark and share icons
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `SingleChildScrollView` with article content.

**Sections:**
1. **Article Header** — Hero image, topic badge, title, read-time estimate
2. **Article Body** — Formatted text with section headers, pull-quote styling
3. **Related Articles** — Bottom section with 2–3 related article cards

**Data:** `ArticleProvider`

**Interactions:** Tap bookmark icon → toggle bookmark state; tap share → system share sheet; tap related article → push new Article Reader; scroll → collapses header image

**Transitions:** Push from Education list or Home; shared-element hero from article card; swipe-back to dismiss.

---

### 3.10 Settings (`/settings`)

**Purpose:** Manage user profile, due date, notification preferences, and data export.

**Scaffold:**
- `AppBar`: Title "Settings", back button
- `BottomNavigationBar`: Hidden
- `FAB`: None

**Body:** `ListView` grouped into preference sections.

**Sections:**
1. **Profile** — Due date display with edit capability, name field
2. **Notifications** — Toggle switches for reminder categories
3. **Data** — Export data button, clear data button (with confirmation dialog)
4. **About** — App version, privacy policy link

**Data:** `UserPreferencesProvider`, `PregnancyProfileProvider`

**Interactions:** Tap due date → date picker bottom sheet; tap export → generates shareable file; tap clear data → confirmation dialog

**Transitions:** Push from Profile tab or Settings icon in Home AppBar; swipe-back to dismiss.

---

## Part 4: Navigation Architecture

### Navigator Structure (GoRouter)
```
ShellRoute (BottomNavigationBar)
├── Home (/')
├── Browse (/browse)         ← contains Cycle Tracking, Weight & Nutrition
├── Library (/library)       ← contains Education, Health Log
└── Profile (/profile)      ← contains Settings, Mindfulness
```

### Bottom Navigation (4 tabs)
| Tab | Label | Icon | Route |
|---|---|---|---|
| Home | Home | `Icons.home_outlined` | `/` |
| Browse | Browse | `Icons.search_outlined` | `/browse` |
| Library | Library | `Icons.bookmark_outline` | `/library` |
| Profile | Profile | `Icons.person_outline` | `/profile` |

### Push Routes (detail screens)
| Screen | Route | Parent |
|---|---|---|
| Cycle Tracking | `/cycle-tracking` | Browse tab |
| Weight & Nutrition | `/weight-nutrition` | Browse tab |
| Pregnancy Progress | `/pregnancy-progress` | Home tab |
| Mindfulness | `/mindfulness` | Profile tab |
| Health Log | `/health-log` | Library tab |
| Mood & Wellness | `/mood-wellness` | Library tab |
| Education | `/education` | Library tab |
| Article Reader | `/article-reader/:id` | Education |
| Settings | `/settings` | Profile tab |

### Modal Overlays
| Overlay | Route | Type | Parent Screen |
|---|---|---|---|
| Breathing Exercise | `overlay:breathing-exercise` | full-sheet overlay | Mindfulness |
| Stretching Guide | `overlay:stretching-guide` | bottom-sheet | Mindfulness |
| Mode Selector | `overlay:mode-selector` | bottom-sheet | Home |
| Symptom Detail | `overlay:symptom-detail` | bottom-sheet | Health Log |

### Deep Links
- `babybump://home` → `/`
- `babybump://browse` → `/browse`
- `babybump://education/:id` → `/article-reader/:id`
- `babybump://settings` → `/settings`

---

## Part 5: Data Context

### Entities

| Entity | Key Fields | Provider | Screens |
|---|---|---|---|
| `PregnancyProfile` | dueDate, lastPeriodDate, currentWeek | `PregnancyProfileProvider` | Home, Pregnancy Progress, Settings |
| `CycleEntry` | startDate, endDate, notes, isIrregular | `CycleEntryProvider` | Cycle Tracking |
| `WeightEntry` | date, weightKg, note | `WeightEntryProvider` | Weight & Nutrition |
| `MoodEntry` | date, moodScore (1-5), note, energyLevel | `MoodEntryProvider` | Home, Mood & Wellness |
| `SymptomEntry` | date, symptomType, severity (1-3), notes | `SymptomEntryProvider` | Health Log |
| `DoctorVisit` | date, doctorName, notes, nextVisitDate | `DoctorVisitProvider` | Health Log |
| `Reminder` | title, date, category, isEnabled | `ReminderProvider` | Health Log |
| `SelfCareCheckState` | date, checkedItems: List<String> | `SelfCareCheckStateProvider` | Home, Mindfulness |
| `Article` | id, title, topic, content, imageUrl, isBookmarked | `ArticleProvider` | Education, Article Reader |
| `UserPreferences` | name, notificationsEnabled, dueDate | `UserPreferencesProvider` | Settings |

### Relationships
- `PregnancyProfile.currentWeek` drives all week-based content (tips, body changes, nutrition advice)
- `MoodEntryProvider` aggregates mood data for `MoodWellnessScreen` trend charts
- `SelfCareCheckState` stores today's checklist state, consumed by Home dashboard
- `ArticleProvider` tracks bookmarks, consumed by Library tab

---

## Part 6: Design Tokens

### Color Palette (Material 3 — Lavender Seed)
| Token | Hex | Usage |
|---|---|---|
| `seed` | `#A78BFA` | Primary color seed (soft violet) |
| `primary` | `#7C3AED` | AppBar, FAB, primary actions |
| `secondary` | `#F9A8D4` | Blush rose accents, mood emojis |
| `tertiary` | `#6EE7B7` | Success states, checkmarks |
| `surface` | `#FAFAFA` | Card backgrounds |
| `background` | `#F5F3FF` | Scaffold background (lavender tint) |
| `error` | `#EF4444` | Validation errors, delete actions |
| `onPrimary` | `#FFFFFF` | Text on primary color |
| `onSurface` | `#1F2937` | Body text |
| `onSurfaceVariant` | `#6B7280` | Secondary text, captions |

### Typography (Google Fonts — Nunito)
| Style | Font | Size | Weight | Line Height |
|---|---|---|---|---|
| `displayLarge` | Nunito | 32sp | 700 | 40sp |
| `headlineMedium` | Nunito | 24sp | 700 | 32sp |
| `titleLarge` | Nunito | 20sp | 600 | 28sp |
| `titleMedium` | Nunito | 16sp | 600 | 24sp |
| `bodyLarge` | Nunito | 16sp | 400 | 24sp |
| `bodyMedium` | Nunito | 14sp | 400 | 20sp |
| `labelLarge` | Nunito | 14sp | 600 | 20sp |
| `caption` | Nunito | 12sp | 400 | 16sp |

### Spacing Rhythm (base 8dp)
| Token | Value |
|---|---|
| `xxs` | 4dp |
| `xs` | 8dp |
| `sm` | 12dp |
| `md` | 16dp |
| `lg` | 24dp |
| `xl` | 32dp |
| `xxl` | 48dp |

### Corner Radius Scale
| Token | Value |
|---|---|
| `sm` | 8dp (chips, small cards) |
| `md` | 12dp (cards, bottom sheets) |
| `lg` | 16dp (large cards, dialogs) |
| `full` | 999dp (pills, avatars) |

### Elevation (Material 3 Tonal)
| Token | Usage |
|---|---|
| `level0` | Scaffold background |
| `level1` | Cards, bottom nav |
| `level2` | FAB, BottomSheet |
| `level3` | Dialogs, overlays |

### Motion
| Token | Value |
|---|---|
| `durationShort` | 200ms |
| `durationMedium` | 300ms |
| `durationLong` | 400ms |
| `easingStandard` | `Curves.easeInOut` |
| `easingEnter` | `Curves.easeOut` |
| `easingExit` | `Curves.easeIn` |
| `sharedAxis` | Hero transitions between list and detail |