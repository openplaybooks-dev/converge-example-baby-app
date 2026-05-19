# Weight & Nutrition — Metadata

## Screen Identification

| Field | Value |
|---|---|
| ID | `weight-nutrition` |
| Title | Weight & Nutrition |
| Route | `/weight-nutrition` |
| Widget | `WeightNutritionScreen` |
| Nav Type | `push` |

## Design Tokens Summary

### Colors
- Primary: `lavenderBloom` (#7C3AED)
- Background: `lavenderTint` (#F5F3FF)
- Card: `morningMist` (#FAFAFA)
- Secondary accent: `blushRose` (#F9A8D4)
- Success/Positive delta: `softMint` (#6EE7B7)
- Error/Negative delta: `softCoral` (#EF4444)
- Primary text: `deepGraphite` (#1F2937)
- Secondary text: `stoneGrey` (#6B7280)
- Border: `mistyBorder` (#E5E7EB)

### Typography
- Font: Nunito (Google Fonts)
- displayLarge: 32sp / 700 (weight number)
- headlineMedium: 24sp / 700 (section headers)
- titleLarge: 20sp / 600 (AppBar title)
- titleMedium: 16sp / 600 (card titles)
- bodyLarge: 16sp / 400 (primary body)
- bodyMedium: 14sp / 400 (secondary text)
- labelLarge: 14sp / 600 (button text)
- caption: 12sp / 500 (badges, timestamps)

### Spacing (8pt base)
- xxs: 4dp / xs: 8dp / sm: 12dp / md: 16dp / lg: 24dp / xl: 32dp

### Radius
- sm: 8dp (chips) / md: 12dp / lg: 16dp (cards) / pill: 999dp (FAB)

## Sections

| Order | Section | Widget Type | Description |
|---|---|---|---|
| 1 | Progress Chart | Card + Line Chart | Line chart with 1W/1M/All toggle |
| 2 | Latest Entry Card | Card | Today's weight with delta |
| 3 | Nutrition Tips Card | Card (lavender tint bg) | Stage-specific tips with week badge |
| 4 | Weight Log List | SliverList | All entries sorted by date desc |
| 5 (overlay) | Add Weight Sheet | showModalBottomSheet | Form with weight, date, notes fields |
| 6 (overlay) | Entry Detail Sheet | showModalBottomSheet | View/edit/delete existing entry |

## Interactive Elements

| Element | Type | Behavior |
|---|---|---|
| Back button | Button | Navigate back |
| Toggle chips | Chip group | Filter chart data by time range |
| Latest Entry Card | Display | None (display-only) |
| Nutrition Tips Card | Card | Expandable (optional for MVP) |
| Log list items | Card | Tap → detail sheet, Long-press → edit/delete sheet |
| FAB | FloatingActionButton | Open add weight bottom sheet |

## Data Entities

### WeightEntry
```dart
class WeightEntry {
  String id;
  DateTime date;
  double value; // in user's preferred unit
  String? notes;
}
```

### Providers
- `WeightEntryProvider` — entries list, selectedRange, CRUD operations
- `PregnancyProfileProvider` — currentWeek for nutrition tips
- `UserPreferencesProvider` — units (kg/lbs)

## Animation Specs

| Animation | Duration | Curve |
|---|---|---|
| Screen push | 300ms | ease-in-out |
| Card fade-in | 200ms | ease-out |
| List stagger | 50ms delay per item | ease-out |
| FAB fade-in | 200ms | ease-out |
| Bottom sheet | 250ms | ease-out |
| Chip selection | 150ms | opacity |
| FAB press | 200ms | scale 90% |

## Accessibility

- Semantic labels on all interactive elements
- 48dp minimum touch targets
- Screen reader announcements for state changes
- Color contrast: AA compliant for all text/background pairs

## Anti-Patterns

- No GridView for weight log (use SliverList)
- No BottomNavigationBar (hidden per UX spec)
- No hard-coded weight units
- FAB positioned bottom-right only
- No animation on initial FAB load without fade-in