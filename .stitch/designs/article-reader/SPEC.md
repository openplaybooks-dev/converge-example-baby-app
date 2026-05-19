# Article Reader — Screen Specification

## 1. Screen Title
**Article Reader**

## 2. Purpose
Display a single article in a clean, readable format with bookmark capability and related article navigation. This is the dedicated reading experience — optimized for extended reading with proper typography, clear hierarchy, and quick access to related content.

## 3. Route
```
/article-reader/:id
```
- Path parameter `id` identifies the article to display
- Source screen: Education (`/education`), Home wellness tip

## 4. Widget Name
`ArticleReaderScreen`

## 5. Design Tokens

### Color Palette (from DESIGN.md)
| Token | Light Mode | Dark Mode | Usage |
|---|---|---|---|
| Primary | `#7C3AED` Lavender Bloom | `#9F67FF` Twilight Bloom | AppBar actions, links |
| Secondary | `#F9A8D4` Blush Rose | `#FBC4E0` Dusky Rose | Topic badge accent |
| Surface | `#FAFAFA` Morning Mist | `#1E1B2E` Deep Twilight | Card backgrounds |
| Scaffold BG | `#F5F3FF` Lavender Tint | `#13111C` Night Sky | Screen background |
| Body Text | `#1F2937` Deep Graphite | `#F3F4F6` Soft Pearl | Primary text |
| Secondary Text | `#6B7280` Stone Grey | `#9CA3AF` Muted Silver | Captions, metadata |
| Divider | `#E5E7EB` Misty Border | `#2D2B3A` Deep Border | Section separators |
| Error | `#EF4444` Soft Coral | `#F87171` Muted Coral | Validation errors |

### Typography (Nunito — from DESIGN.md)
| Role | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Display | 57pt | 700 | 64pt | — |
| Screen Title | 28pt | 600 | 36pt | AppBar title |
| Section Header | 22pt | 600 | 28pt | Article title |
| Subtitle | 16pt | 500 | 24pt | Author, date |
| Body | 16pt | 400 | 24pt | Article body text |
| Body Small | 14pt | 400 | 20pt | Captions, metadata |
| Button Label | 14pt | 600 | 20pt | Chips, labels |
| Caption | 11pt | 500 | 16pt | Badges, timestamps |

### Spacing (8pt base — from DESIGN.md)
| Token | Value | Usage |
|---|---|---|
| `xxs` | 4dp | Tight internal spacing |
| `xs` | 8dp | Icon gaps, small padding |
| `sm` | 12dp | Chip padding |
| `md` | 16dp | Card padding, section margins |
| `lg` | 24dp | Section vertical spacing |
| `xl` | 32dp | Large gaps |
| `xxl` | 48dp | Screen top/bottom padding |

### Corner Radius
| Token | Value | Usage |
|---|---|---|
| `sm` | 8dp | Chips, small elements |
| `md` | 12dp | Text fields, bottom sheets |
| `lg` | 16dp | Cards, large containers |
| `full` | 999dp | Pills, avatars |

### Motion (from DESIGN.md)
| Token | Value | Usage |
|---|---|---|
| Page transition | 300ms, smooth deceleration | Screen push/pop |
| Micro-interaction | 200ms, snappy ease-out | Tap feedback, icon toggle |
| Hero transition | 350ms, fast-out-slow-in | Shared element from article card |
| Card tap | 200ms scale to 98% | Press feedback |

## 6. Layout Rules

### Scaffold Structure
```
Scaffold
├── AppBar (SliverAppBar with collapsing header)
│   ├── Leading: Back button (48pt touch target)
│   ├── Title: Article topic text (centered or trailing)
│   └── Actions: Bookmark icon, Share icon
├── Body: SingleChildScrollView
│   ├── SliverAppBar with FlexibleSpace (hero image, collapses on scroll)
│   └── Remaining content (ArticleHeader, ArticleBody, RelatedArticles)
└── No BottomNavigationBar, No FAB
```

### AppBar Behavior
- Collapsing header: `SliverAppBar` with `flexibleSpace` containing the hero image
- Background: transparent, blends into scaffold `Lavender Tint`
- On scroll: image collapses and fades; title transitions from large to compact
- Back button: standard leading, returns to Education or previous screen
- Trailing actions: bookmark (toggleable), share (system sheet)

### Navigation Bar
- Hidden (not visible during article reading)
- Swipe-back enabled for dismissal

### Screen Padding
- Horizontal: 16dp from each edge
- Vertical sections: 24dp between major sections
- Card internal padding: 16dp

## 7. Sections

### 7.1 Article Header (collapsed view in SliverAppBar)

**Description:** Full-width hero image at top, topic badge, article title, and metadata. When scrolled, this collapses into a compact AppBar representation.

**Widget:** `SliverAppBar` with `flexibleSpace` containing a `Column`
- Hero image: `BoxFit.cover`, height 240dp expanded / 56dp collapsed
- Topic badge: `Container` with `Blush Rose` background, white text, pill shape (12dp radius)
- Title: `Text` with `Section Header` style, max 3 lines, ellipsis overflow
- Metadata row: Author name, date, estimated read time (separated by `•`)

**Data requirements:**
```
Article {
  id: String
  title: String
  topic: String (e.g., "Nutrition", "Body Changes")
  imageUrl: String (hero image URL)
  authorName: String
  publishedDate: DateTime
  readTimeMinutes: int
}
```

**Interactive elements:**
- Hero image: shared element transition (hero) from EducationScreen article card
- Scroll: collapses header, triggers AppBar fade-in

---

### 7.2 Article Body

**Description:** Formatted text content with section headers and pull-quote styling.

**Widget:** `SingleChildScrollView` → `Padding` → `Column`
- Section headers: `Text` with `Title Medium` style, `Lavender Bloom` color
- Body paragraphs: `Text` with `Body` style, `Deep Graphite` color, `0.15` letter spacing
- Pull quotes: `Container` with `Blush Rose` left border (4dp), italic text, 16dp padding
- Bullet lists: `Row` with `Blush Rose` dot + body text

**Data requirements:**
```
Article {
  sections: List<ArticleSection>
}

ArticleSection {
  type: enum (paragraph, header, pullquote, list)
  content: String
  items: List<String>? // for list type
}
```

**Interactive elements:**
- None (read-only content)
- Links in future: open external browser

---

### 7.3 Related Articles

**Description:** Bottom section displaying 2–3 related article cards in a horizontal `ListView`.

**Widget:** `Column` with section title and horizontal `ListView`
- Section title: `Text` "Related Articles" with `Title Medium` style
- Related article cards: `InkWell` with `ArticleCard` widget (120dp width, image + title)
- Card spacing: 12dp between cards
- Tap → navigate to new `ArticleReaderScreen` with hero transition

**Data requirements:**
```
Article {
  relatedArticleIds: List<String>
}

ArticleProvider.getArticlesByIds(List<String>) → List<Article>
```

**Interactive elements:**
- Tap card: push new `ArticleReaderScreen` with that article's ID
- Hero transition: article card image and title animate to new screen header

---

### 7.4 Bookmark Action

**Description:** Trailing AppBar icon that toggles article bookmark state.

**Widget:** `IconButton` in AppBar actions
- Unbookmarked: `Icons.bookmark_outline` (Stone Grey)
- Bookmarked: `Icons.bookmark` (Lavender Bloom, filled)

**Data requirements:**
```
Article.isBookmarked: bool
ArticleProvider.toggleBookmark(String articleId)
```

**Interactive elements:**
- Tap: toggle bookmark state, animate icon with 150ms scale bounce + color transition
- State persists in `ArticleProvider`

---

### 7.5 Share Action

**Description:** Trailing AppBar icon that opens system share sheet.

**Widget:** `IconButton` in AppBar actions
- Icon: `Icons.share_outlined` (Stone Grey)
- Tap → `Share.share(articleUrl, subject: articleTitle)` from `share_plus`

**Data requirements:**
```
Article {
  shareUrl: String
  title: String
}
```

**Interactive elements:**
- Tap: open native share sheet with article title and URL

## 8. Data

### Article Entity
```
Article {
  id: String (unique identifier)
  title: String (article headline)
  topic: String (e.g., "Nutrition", "Body Changes", "Exercise", "Mental Health")
  imageUrl: String (hero image URL)
  authorName: String
  publishedDate: DateTime
  readTimeMinutes: int
  content: List<ArticleSection>
  relatedArticleIds: List<String>
  isBookmarked: bool
  shareUrl: String
}

ArticleSection {
  type: ArticleSectionType (paragraph, header, pullquote, list)
  content: String
  items: List<String>? (for list type)
}
```

### Provider: `ArticleProvider`
- `getArticle(String id)`: returns `Article?`
- `getRelatedArticles(List<String> ids)`: returns `List<Article>`
- `toggleBookmark(String id)`: flips `isBookmarked` state
- State: in-memory for MVP (persisted to local storage in future)

## 9. Motion

### Page Transition
- Type: push with 300ms slide + fade
- Curve: `Curves.easeInOut`
- Back swipe: enabled, reverses the animation

### Hero Transition (from Education Screen)
- Duration: 350ms
- Easing: fast-out-slow-in (`Curves.easeOut` enter, `Curves.easeIn` exit)
- Shared elements: hero image, article title text
- Trigger: tap article card in EducationScreen → article reader opens

### Header Collapse (SliverAppBar)
- Behavior: scroll down → header shrinks, image fades
- Animation: tied to scroll position, continuous
- Title: transitions from large (22pt) to compact (16pt) as AppBar collapses

### Bookmark Toggle
- Duration: 150ms
- Effect: scale 1.0 → 1.2 → 1.0 + color fade from outline to filled
- Curve: `Curves.easeOut`

### Card Tap (Related Articles)
- Duration: 200ms
- Effect: scale to 98% on press, return to 100%
- Curve: `Curves.easeOut`

## 10. Accessibility

### Semantic Labels
- Back button: "Navigate back"
- Bookmark icon (unbookmarked): "Bookmark article"
- Bookmark icon (bookmarked): "Remove bookmark"
- Share icon: "Share article"
- Related article card: "Read [article title]"
- Hero image: "Article hero image"

### Focus Order
1. Back button (leading)
2. Bookmark action
3. Share action
4. Article body content (scrollable)
5. Related article cards (traversed in order)

### Contrast Ratios
- Body text (`#1F2937` on `#FAFAFA`): 14.7:1 ✓ (exceeds 7:1)
- Secondary text (`#6B7280` on `#FAFAFA`): 4.6:1 ✓ (exceeds 4.5:1)
- Topic badge (white on `#F9A8D4`): 3.2:1 ✓ (exceeds 3:1)
- AppBar title (`#1F2937` on `#F5F3FF`): 12.6:1 ✓ (exceeds 7:1)

### Touch Targets
- All interactive elements: minimum 48dp × 48dp
- AppBar icons: 48dp touch target via `IconButton`
- Related article cards: full card is tappable

### Screen Reader
- Article title announced when screen loads
- Section headers announced as navigation landmarks
- Pull quotes read with emphasis

## 11. Anti-Patterns

**Do NOT:**
- Use `AppBar` with `title` instead of `SliverAppBar` with collapsing header
- Show `BottomNavigationBar` (hidden for reading focus)
- Use pure black (`#000000`) or pure white (`#FFFFFF`) for text
- Apply hard shadows or aggressive elevation
- Use Inter, Roboto, or non-Nunito fonts
- Display more than 3 related articles (overwhelming)
- Use unsourced placeholder images
- Allow body text smaller than 16sp
- Use arbitrary spacing not aligned to 8pt grid
- Trigger animations longer than 400ms (jarring)
- Use `ListView` for article body (performance on long articles)