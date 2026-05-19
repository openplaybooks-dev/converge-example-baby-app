# Education — Screen Specification

## 1. Screen Title

**Education**

---

## 2. Purpose

Browse and read trusted educational articles organized by topic. This screen serves as a content discovery hub, allowing users to explore curated health information relevant to their pregnancy journey. Users can filter by topic, search articles, and bookmark content for later reference.

**Context:** Push route from Library tab. BottomNavigationBar is hidden. Primary actions are topic filtering, search, and article navigation.

---

## 3. Route

`/education`

---

## 4. Widget Name

`EducationScreen`

---

## 5. Design Tokens

### Colors (Light Theme — from DESIGN.md Section 2)

| Token | Hex | Usage |
|---|---|---|
| `lavenderBloom` | `#7C3AED` | Primary brand, AppBar, topic icons (Nutrition, Maternal Care) |
| `lavenderTint` | `#F5F3FF` | Scaffold background |
| `blushRose` | `#F9A8D4` | Secondary accent, Mental Health topic icon |
| `softMint` | `#6EE7B7` | Tertiary, success states, bookmark active indicator |
| `morningMist` | `#FAFAFA` | Card backgrounds |
| `deepGraphite` | `#1F2937` | Primary text |
| `stoneGrey` | `#6B7280` | Secondary text, captions, timestamps |
| `mistyBorder` | `#E5E7EB` | Borders, dividers |
| `softCoral` | `#EF4444` | Error states |
| `warmWhite` | `#FFFFFF` | Bottom nav background, sheets |

### Colors (Dark Theme)

| Token | Hex | Usage |
|---|---|---|
| `twilightBloom` | `#9F67FF` | Primary brand in dark mode |
| `duskyRose` | `#FBC4E0` | Secondary accent in dark mode |
| `nightMint` | `#34D399` | Tertiary success in dark mode |
| `deepTwilight` | `#1E1B2E` | Card backgrounds in dark mode |
| `nightSky` | `#13111C` | Scaffold background in dark mode |
| `softPearl` | `#F3F4F6` | Primary text in dark mode |
| `mutedSilver` | `#9CA3AF` | Secondary text in dark mode |
| `deepBorder` | `#2D2B3A` | Borders in dark mode |

### Typography (Nunito — Google Fonts from DESIGN.md Section 3)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 32sp | 700 | 40sp | Hero article title on featured card |
| `headlineMedium` | 22sp | 600 | 28sp | Section headers |
| `titleLarge` | 20sp | 600 | 28sp | AppBar title |
| `titleMedium` | 16sp | 600 | 24sp | Article card titles, topic card titles |
| `bodyLarge` | 16sp | 400 | 24sp | Primary body text, article descriptions |
| `bodyMedium` | 14sp | 400 | 20sp | Secondary text, descriptions, card subtitles |
| `labelLarge` | 14sp | 600 | 20sp | Button text, chip labels |
| `caption` | 11sp | 500 | 16sp | Badges, timestamps, read time |

### Spacing (8pt base from DESIGN.md Section 5 / UX.md Section 6)

| Token | Value |
|---|---|
| `xxs` | 4dp |
| `xs` | 8dp |
| `sm` | 12dp |
| `md` | 16dp |
| `lg` | 24dp |
| `xl` | 32dp |
| `xxl` | 48dp |

### Corner Radius

| Token | Value |
|---|---|
| `sm` | 8dp (chips) |
| `md` | 12dp |
| `lg` | 16dp (standard cards, featured article card) |
| `full` | 999dp (FAB, pills) |

### Motion (from DESIGN.md Section 6 / UX.md Section 6)

| Token | Value |
|---|---|
| `durationShort` | 200ms |
| `durationMedium` | 300ms |
| `durationLong` | 350ms |
| `staggerDelay` | 50ms between items |
| `easingStandard` | `Curves.easeInOut` |
| `easingEnter` | `Curves.easeOut` |
| `easingExit` | `Curves.easeIn` |

---

## 6. Layout Rules

### Scaffold Structure

- `Scaffold` with `CustomScrollView` body (requires `SliverAppBar` for scroll behavior)
- `AppBar`: Title "Education", back button, trailing search icon button
- `BottomNavigationBar`: Hidden (per UX.md 3.8)
- `FAB`: None

### AppBar Behavior

- Background: `lavenderTint` (#F5F3FF) / Night Sky (#13111C) in dark mode
- Title: "Education" (SemiBold 20sp, `deepGraphite` / `softPearl` in dark mode)
- Leading: Back button with 48dp touch target
- Trailing: Search icon button (48dp touch target) to open search overlay

### Body Layout

- `CustomScrollView` with `SliverAppBar` (collapsing header not needed — content scrolls beneath)
- `SliverToBoxAdapter` for Featured Article at top
- `SliverToBoxAdapter` for section header "Topics"
- `SliverGrid` for Topics (2 columns)
- `SliverToBoxAdapter` for section header "Recent Articles"
- `SliverToBoxAdapter` for Recent Articles (horizontal `ListView`)
- Bottom padding: 24dp for safe area

---

## 7. Sections

### Section 1: Featured Article

**Description:** Hero card at the top showcasing the current featured article with large image and headline.

**Widget Type:** `SliverToBoxAdapter` containing a `Card`

**Layout:** Full-width card with 16dp internal padding, stacked vertically (image top, content bottom).

**Components:**
- Article hero image: Full-width, 180dp height, `radiusLg` top corners, placeholder gradient if no image
- Topic badge: Pill chip at top-left of image, `lavenderBloom` background
- Title: "Featured Article" prefix label (`caption`, `stoneGrey`) + Article title (`displayLarge` 32sp, `deepGraphite`)
- Read time: Clock icon + "X min read" (`caption`, `stoneGrey`)
- Tap entire card → `/article-reader/:id`

**Card Specifications:**
- Background: `morningMist` (#FAFAFA) / `deepTwilight` in dark mode
- Corner radius: `radiusLg` (16dp)
- Shadow: Soft diffused — 8dp blur, 2dp offset-y, rgba(0,0,0,0.08) light / rgba(0,0,0,0.25) dark
- Internal padding: 16dp all sides

**Data Requirements:**
- Static featured article from article catalog (for MVP)
- Fields: `id`, `title`, `topic`, `illustrationUrl`, `readTime`

**Interactive Elements:**
- Tap card → push `/article-reader/:id`

**Tap Feedback:** 200ms scale to 98% with 200ms return

---

### Section 2: Topics Grid

**Description:** 2-column grid of topic category cards for filtering articles.

**Widget Type:** `SliverToBoxAdapter` containing a `GridView` with `shrinkWrap: true` and `physics: NeverScrollableScrollPhysics()` OR separate `SliverGrid`

**Layout:** 2 columns, 12dp gap between items, 16dp horizontal padding.

**Topic Cards (5 total):**
1. **Nutrition** — Icon: `Icons.restaurant_outlined`, color: `lavenderBloom`
2. **Body Changes** — Icon: `Icons.pregnant_woman_outlined`, color: `blushRose`
3. **Maternal Care** — Icon: `Icons.medical_services_outlined`, color: `lavenderBloom`
4. **Exercise** — Icon: `Icons.fitness_center_outlined`, color: `softMint`
5. **Mental Health** — Icon: `Icons.psychology_outlined`, color: `blushRose`

**Each Topic Card:**
- Size: Square-ish, aspect ratio ~1.3:1 (height slightly greater than width)
- Background: `morningMist` / `deepTwilight` in dark mode
- 48dp circular icon container at top with topic color at 15% opacity fill
- Icon: 24sp, topic color
- Title: Topic name (`titleMedium`, centered)
- Corner radius: `radiusLg` (16dp)
- Tap feedback: 200ms scale to 98%

**Interactive Elements:**
- Tap topic card → `/education/:topic` (filtered article list)

**Data Requirements:**
- Static topic list (for MVP)
- `ArticleTopic` enum: `nutrition`, `bodyChanges`, `maternalCare`, `exercise`, `mentalHealth`

---

### Section 3: Recent Articles

**Description:** Horizontal scrollable list of recently viewed articles for quick re-access.

**Widget Type:** `SliverToBoxAdapter` containing a `SizedBox` with horizontal `ListView`

**Layout:** Horizontal scrolling `ListView` with `SizedBox` height ~220dp, 16dp horizontal padding.

**Each Article Card:**
- Width: 160dp fixed
- Background: `morningMist` / `deepTwilight`
- Corner radius: `radiusLg` (16dp)
- Vertical stack:
  - Placeholder image area: 80dp height, `radiusSm` top corners, `lavenderTint` fill with centered icon
  - Title: `titleMedium`, max 2 lines, ellipsis overflow
  - Topic badge: Small pill below title
  - Read time: `caption` below topic badge

**Interactive Elements:**
- Tap article card → `/article-reader/:id`
- Tap bookmark icon on card → toggle bookmark state

**Data Requirements:**
- `ArticleProvider.articles` filtered for `isBookmarked == true` OR recently viewed (date-based)

---

### Section 4: Search Overlay

**Description:** Full-screen overlay for searching articles by keyword.

**Trigger:** Tap search icon in AppBar

**Widget Type:** `showModalBottomSheet` with `Column` OR separate overlay route

**Layout:** Bottom sheet or full-screen overlay with search input at top and results below.

**Components:**
- Search input field: `TextField` with search icon prefix, clear button suffix
- Recent searches: List of recent search terms (tappable chips)
- Search results: Vertical list of `Article` cards matching query
- Empty state: "No articles found" with search icon

**Data Operations:**
- On search submit: Filter `ArticleProvider.articles` by title/body containing query string

---

## 8. Data

### Entity: Article

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (UUID) | Yes | Unique identifier |
| `title` | `String` | Yes | Article title |
| `topic` | `ArticleTopic` | Yes | Topic category for filtering |
| `body` | `String` | Yes | Rich text article content |
| `illustrationUrl` | `String` | No | Hero image URL |
| `readTime` | `String` | No | Estimated read time (e.g., "5 min") |
| `isBookmarked` | `bool` | Yes | Whether user has bookmarked this article |
| `relatedArticleIds` | `List<String>` | Yes | IDs of related articles shown at bottom |

### Enum: ArticleTopic

| Value | Display Name | Icon |
|---|---|---|
| `nutrition` | Nutrition | `Icons.restaurant_outlined` |
| `bodyChanges` | Body Changes | `Icons.pregnant_woman_outlined` |
| `maternalCare` | Maternal Care | `Icons.medical_services_outlined` |
| `exercise` | Exercise | `Icons.fitness_center_outlined` |
| `mentalHealth` | Mental Health | `Icons.psychology_outlined` |

### Provider: ArticleProvider

**State:**
- `articles: List<Article>` — all articles (static catalog for MVP)
- `bookmarkedIds: Set<String>` — IDs of bookmarked articles
- `recentSearches: List<String>` — recent search terms

**Methods:**
- `getArticlesByTopic(topic)` — filters articles by `ArticleTopic`
- `toggleBookmark(id)` — toggles `isBookmarked` state
- `searchArticles(query)` — filters by title/body containing query
- `getBookmarkedArticles()` — returns articles where `isBookmarked == true`
- `getRecentArticles()` — returns recently viewed (by date, limit 5-10)

---

## 9. Motion

### Entry Animations

- Screen push: 300ms slide + fade (standard page transition)
- Featured article card: 200ms fade-in on load
- Topic grid: Staggered reveal — each card fades in 50ms apart
- Recent articles: Horizontal slide-in from right, 300ms

### Hero Transitions

- When navigating from article card to Article Reader: 350ms fast-out-slow-in shared element transition on card image and title

### Bottom Sheet Animations

- Search overlay: 250ms smooth deceleration slide-up
- Sheet dismiss: 200ms slide-down with fade

### Interactive Feedback

- Card tap: 200ms ease-out scale to 98%, then 200ms ease-out return
- Topic card tap: 200ms ease-out scale to 98%
- Bookmark icon tap: 150ms scale bounce + color transition
- Search input focus: 200ms border color transition to `lavenderBloom`

### Staggered List Reveals

- When content loads: list items cascade into view — 50ms delay between each item
- Applies to topic grid (items appear 50ms apart)

---

## 10. Accessibility

### Semantic Labels

| Element | Semantic Label |
|---|---|
| AppBar | `'Education, back button to return to Library, search button'` |
| Search button | `'Search articles, double tap to search'` |
| Featured article | `'$articleTitle, featured article, $readTime to read, double tap to open'` |
| Topic card | `'$topicName, double tap to view $topicName articles'` |
| Recent article | `'$articleTitle, $topicName, $readTime, double tap to read'` |
| Bookmark icon | `'Bookmark article, ${isBookmarked ? 'bookmarked' : 'not bookmarked'}'` |
| Read time | `'$readTime to read'` |

### Focus Order

1. AppBar (back button → search button)
2. Featured article card
3. Topic cards (in grid order: Nutrition, Body Changes, Maternal Care, Exercise, Mental Health)
4. Recent article horizontal list (left to right)
5. Within each recent article: bookmark icon

### Contrast Notes

- `lavenderBloom` on `morningMist`: ~5.2:1 (passes AA)
- `deepGraphite` on `morningMist`: ~12:1 (passes AAA)
- `stoneGrey` on `morningMist`: ~4.7:1 (passes AA for body text)
- Dark mode: `twilightBloom` on `deepTwilight`: ~5.8:1 (passes AA)

### Screen Reader Support

- Announce article opened: "Opening article: $title"
- Announce bookmark toggled: "Article ${isBookmarked ? 'bookmarked' : 'bookmark removed'}"
- Announce search results: "Found $count articles matching '$query'"
- Use `Semantics` to label topic cards with topic name and article count if available

### Touch Target Compliance

- All interactive elements: 48dp minimum
- Topic cards: Full card area, minimum 48dp height
- Recent article cards: Full card area, 160dp width
- Bookmark icons: 48dp minimum touch target area (extends tappable area beyond icon itself)
- All buttons in AppBar: 48dp minimum height

---

## 11. Anti-Patterns

**Do Not:**
- Add `BottomNavigationBar` (hidden per UX spec)
- Add FAB (Education screen has no primary action requiring FAB)
- Use `GridView` for recent articles (use horizontal `ListView` for horizontal scrolling)
- Add gradients to card backgrounds (flat `morningMist` only)
- Use platform default colors (all colors from design system)
- Use Inter, Roboto, or any font other than Nunito
- Create touch targets smaller than 48dp
- Use pure black (#000000) or pure white (#FFFFFF) for text
- Show featured article with hard-coded content in production (use provider data)
- Use `Navigator.push` instead of `context.push` with GoRouter
- Skip safe area handling
- Display empty state without illustration/guidance text
- Add shadows to AppBar (transparent/floating style per design system)
- Use default `Material` tap ripple — use scale feedback per design system
- Show all articles in recent if none are bookmarked — show "no recent articles" state

---

## 12. Critical Files for Implementation

1. **`lib/screens/education/education_screen.dart`** — New file to create (main scaffold with CustomScrollView, AppBar with search, sections for Featured Article, Topics Grid, Recent Articles)

2. **`lib/router/app_router.dart`** — Add GoRoute entry for `/education` pointing to `EducationScreen` and `/education/:topic` for topic-filtered article list

3. **`lib/theme/app_theme.dart`** — Reference for design tokens (`AppTheme.spaceMd`, `AppTheme.radiusLg`, `AppTheme.lavenderBloom`, etc.) and typography via `Theme.of(context).textTheme`

4. **`lib/screens/health_log/health_log_screen.dart`** — Reference implementation for a push-screen with `Scaffold`, `AppBar`, `ListView`/`CustomScrollView` body, card-based content with proper spacing and scale feedback patterns

5. **`.stitch/UX.md` (Section 3.8)** — Reference for Education screen specification: scaffold structure (AppBar with search, hidden BottomNav, no FAB), sections (featured article, topics grid, recent articles), data requirements (`ArticleProvider`), and interaction patterns

---

## 13. Screen Structure

```
EducationScreen
├── Scaffold
│   ├── AppBar ("Education", back button, search icon)
│   └── body: CustomScrollView
│       ├── SliverToBoxAdapter
│       │   └── FeaturedArticleCard
│       │       ├── Hero image
│       │       ├── Topic badge
│       │       └── Content (title, read time)
│       ├── SliverToBoxAdapter
│       │   └── SectionHeader("Topics")
│       ├── SliverGrid (2 columns)
│       │   └── TopicCard × 5 (Nutrition, Body Changes, Maternal Care, Exercise, Mental Health)
│       ├── SliverToBoxAdapter
│       │   └── SectionHeader("Recent Articles")
│       ├── SliverToBoxAdapter
│       │   └── RecentArticlesList (horizontal ListView)
│       │       └── ArticleCard × N
│       └── SliverToBoxAdapter (bottom padding)
├── Search icon → SearchOverlay
└── Topic card tap → /education/:topic
```