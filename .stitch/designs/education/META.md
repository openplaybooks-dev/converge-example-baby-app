# META — Education Screen Design

## Example Selection

| Criterion | Weight | Browse Screen | Library Screen | Health-log Screen |
|---|---|---|---|---|
| Topic list with icons | Required | ✓ (category chips) | ✓ (bookshelf grid) | ✓ (symptom list) |
| Scrollable content | Required | ✓ (vertical scroll) | ✓ (vertical scroll) | ✓ (vertical scroll) |
| Card-based layout | Required | ✓ | ✓ | ✓ |
| AppBar with actions | Required | ✓ (search icon) | ✓ (filter icon) | ✓ (back + actions) |
| Push route (hidden bottom nav) | Required | N/A | N/A | ✓ |
| Featured/hero section | Helpful | ✓ (promotional banner) | ✓ (featured book) | Partial |
| Horizontal scrolling list | Helpful | ✓ (trending) | ✓ (continue reading) | ✓ (quick logs) |
| Grid layout for categories | Helpful | ✓ (2-col categories) | ✓ (bookshelf grid) | Partial |
| Search functionality | Required | ✓ | ✓ | Partial |
| **Total Score** | | **9** | **9** | **8** |

## Selected Reference: Browse Screen

The Browse screen (`/browse`) provides the best template for the Education screen:
- Similar push route structure with hidden BottomNavigationBar
- Grid of topic/category cards as primary navigation
- Horizontal scrolling "Recent" list
- Search in AppBar
- Card-based content with images and badges

## Design Decisions

1. **No SliverAppBar collapse** — Education uses a static AppBar with search icon, similar to Health-log
2. **2-column topic grid** — Mirrors Browse's category grid, 5 topics fit well in 2×3 (with one empty)
3. **Horizontal recent articles list** — Follows Browse's trending section pattern
4. **Featured article hero** — Uses the promotional banner pattern from Browse
5. **Search overlay** — Bottom sheet approach consistent with the app's modal pattern

## Reference Screen Pattern

```
BrowseScreen → EducationScreen
├── Scaffold with CustomScrollView
├── AppBar: "Browse"/"Education", back button, search icon
├── Featured content card at top
├── 2-column category/topic grid
├── Horizontal scrolling recent/trending list
└── BottomNavigationBar (hidden on push)
```

## Flutter HTML Glossary Elements Used

- `.scaffold` — Main scaffold wrapper
- `.app-bar` — App bar with title and actions
- `.card` — Article and topic cards
- `.chip` — Topic badges and filter chips
- `.row` / `.column` — Layout containers
- `.network-image` / `.placeholder-image` — Article illustrations
- `data-color` — Color scheme roles
- `data-spacing` — Spacing tokens
- `data-route` — Navigation routes