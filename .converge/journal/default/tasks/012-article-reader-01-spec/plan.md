# Plan: Spec: Article Reader



I have all the information needed. Let me compile the Article Reader screen specification plan.

---

## Plan: Article Reader Screen Specification

### Summary of Findings

**From screens.json (Section 102-109):**
- Route: `/article-reader/:id`
- Widget: `ArticleReaderScreen`
- Features: article-header, article-body, related-articles, bookmark, share, hero-transition
- NavType: push (hidden BottomNavigationBar, no FAB)
- Data: `ArticleProvider`

**From UX.md (Section 3.9, pages 225-245):**
- AppBar: Title from article topic, back button, trailing bookmark and share icons
- Body: `SingleChildScrollView` with article content
- Sections: Article Header (hero image, topic badge, title, read-time), Article Body (formatted text with section headers, pull-quote styling), Related Articles (2-3 cards)
- Interactions: bookmark toggle, share sheet, related article tap, header collapse on scroll
- Transition: hero from article card, swipe-back dismiss

**From DESIGN.md:**
- Color palette, typography (Nunito), spacing (8pt base), corner radius, motion tokens
- No pure black (#000000), no pure white for text, gentle bloom theme
- Cards: 16dp radius, soft shadow 8dp blur
- Motion: 300-350ms hero transitions, 200ms micro-interactions

**Existing patterns (EducationScreen, HealthLogScreen):**
- Scaffold → AppBar with leading back button → body
- Scale animation on tap (0.98), 200ms duration
- Card backgrounds: `morningMist` (light) / `deepTwilight` (dark)
- AppBar background: `lavenderTint` (light) / `nightSky` (dark)
- Dark mode via `theme.brightness == Brightness.dark`

**AppTheme tokens to reference:**
- `lavenderBloom`, `blushRose`, `softMint`, `morningMist`, `lavenderTint`, `deepGraphite`, `stoneGrey`, `mistyBorder`, `softCoral`, `warmWhite`, `deepTwilight`, `nightSky`
- `spaceXxs` (4), `spaceXs` (8), `spaceSm` (12), `spaceMd` (16), `spaceLg` (24), `spaceXl` (32), `spaceXxl` (48)
- `radiusSm` (8), `radiusMd` (12), `radiusLg` (16), `radiusPill` (999)
- Typography via `textTheme.displayLarge`, `textTheme.titleLarge`, `textTheme.bodyLarge`, `textTheme.labelSmall`, etc.

**Router:**
- `app_router.dart` has EducationScreen import but no `/article-reader/:id` route yet
- Pattern: `GoRoute(path: '/article-reader/:id', builder: ...)` needed

---

### Implementation Approach

**1. File Structure**
- Create `lib/screens/article_reader/article_reader_screen.dart` with `ArticleReaderScreen` widget
- Create related widgets: `_ArticleHeader`, `_ArticleBody`, `_PullQuote`, `_RelatedArticles`, `_ShareSheet`
- Add route in `app_router.dart`

**2. Scaffold Structure**
```
Scaffold
├── AppBar (title from topic, back button, bookmark icon, share icon)
│   └── SliverAppBar with flexible space for collapsing header image
└── Body: SingleChildScrollView
    ├── ArticleHeader (hero image, topic badge, title, read time, author/date)
    ├── ArticleBody (rich text sections, pull quotes)
    ├── Divider
    └── RelatedArticles (horizontal ListView of 2-3 cards)
```

**3. Key Design Decisions**
- **Hero Transition:** Use `flutter_animate` or `Hero` widget for image/title shared-element transition from EducationScreen card
- **Header Collapse:** `SliverAppBar` with `flexibleSpace` collapses on scroll — hero image shrinks and fades
- **Bookmark:** Icon toggles filled/outlined state, persists via `ArticleProvider`
- **Share:** `Share.share()` from `share_plus` package or native `Share` widget
- **Article Body:** Render sections with `Html` widget or custom `Widget` tree for markdown-like formatting
- **Related Articles:** Tap navigates to new `ArticleReaderScreen`, triggering another hero transition

**4. Data Flow**
- `ArticleReaderScreen` extracts `id` from route state via `state.pathParameters['id']`
- `ArticleProvider.getArticle(id)` returns `Article` data
- Related articles filtered by `Article.relatedArticleIds`

**5. Motion Patterns**
- Page push: 300ms slide + fade (standard GoRouter transition)
- Hero: 350ms fast-out-slow-in for shared elements
- Bookmark toggle: 150ms scale bounce + color transition
- Card tap: 200ms scale to 98%

**6. Accessibility**
- Semantic labels for article title, bookmark state, share action
- Focus order: back button → bookmark → share → article body → related articles
- Contrast: `deepGraphite` on `morningMist` = 12.6:1 ✓

---

### Critical Files for Implementation

1. **`lib/screens/article_reader/article_reader_screen.dart`** — New file: main scaffold with SliverAppBar, SingleChildScrollView body, article header/body/related sections

2. **`lib/router/app_router.dart`** — Add `GoRoute(path: '/article-reader/:id')` entry pointing to `ArticleReaderScreen`

3. **`lib/theme/app_theme.dart`** — Reference for design tokens (`AppTheme.lavenderBloom`, `AppTheme.spaceMd`, `AppTheme.radiusLg`, etc.)

4. **`lib/screens/education/education_screen.dart`** — Reference for hero transition patterns, scale tap feedback, dark mode handling

5. **`.stitch/UX.md` (Section 3.9, pages 225-245)** — Source of truth for Article Reader scaffold structure, sections, interactions, and data requirements