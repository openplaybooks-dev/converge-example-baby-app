# Pregnant Tracker - Baby Bump — Design System

## 1. Visual Theme

**Theme Name:** Gentle Bloom

**Mood:** A soft, nurturing sanctuary — warm natural light filtering through a nursery window, reassuring and calm without being clinical or sterile.

**Light Mode (Primary):** Light mode is the primary experience. The interface feels like morning sunlight in a cozy, plant-filled nursery — airy, warm, and welcoming.

**Dark Mode (Secondary):** Deep twilight tones that maintain the warmth of the light palette. Not cold charcoal — more like a softly lit nursery at dusk with warm accent lighting.

**Key Visual Metaphors:** Organic shapes and rounded corners evoke softness and approachability. Breathing room between elements mirrors the intentional calm the app encourages. No sharp edges or sterile clinical aesthetics.

---

## 2. Color Palette

### Light Theme

- **Lavender Bloom** (#7C3AED) — Primary brand color, used for key actions, navigation highlights, and the primary AppBar. Provides confident yet gentle presence.
- **Blush Rose** (#F9A8D4) — Secondary accent, used for mood emojis, mood trend highlights, and decorative touches that feel warm and nurturing.
- **Soft Mint** (#6EE7B7) — Tertiary color for success states, checkmarks, and positive confirmations. Subtle and reassuring.
- **Morning Mist** (#FAFAFA) — Card and surface backgrounds. Clean without being stark white.
- **Lavender Tint** (#F5F3FF) — Scaffold background. A gentle purple-tinted wash that unifies the visual experience.
- **Deep Graphite** (#1F2937) — Primary text color. Softer than pure black, easier on the eyes during extended reading.
- **Stone Grey** (#6B7280) — Secondary text, captions, timestamps, and supporting labels.
- **Misty Border** (#E5E7EB) — Borders, dividers, and subtle structural lines. Barely-there structure.
- **Soft Coral** (#EF4444) — Error states, validation messages, destructive actions. Stands out without alarm.
- **Warm White** (#FFFFFF) — Bottom navigation bar background, sheets, and dialog surfaces.

### Dark Theme

- **Twilight Bloom** (#9F67FF) — Primary brand in dark mode. Slightly lighter and warmer than the light primary to maintain softness in low-light conditions.
- **Dusky Rose** (#FBC4E0) — Secondary accent for dark mode. Warmer and more luminous than the light secondary.
- **Night Mint** (#34D399) — Tertiary success color for dark mode. More vibrant to stand out against dark surfaces.
- **Deep Twilight** (#1E1B2E) — Card and surface backgrounds in dark mode. Warm-tinted dark purple-grey, never cold.
- **Night Sky** (#13111C) — Scaffold background in dark mode. Deep but warm, avoiding pure black.
- **Soft Pearl** (#F3F4F6) — Primary text in dark mode. High contrast but not harsh.
- **Muted Silver** (#9CA3AF) — Secondary text, captions, and supporting labels in dark mode.
- **Deep Border** (#2D2B3A) — Borders, dividers, and structural lines in dark mode. Subtle but visible.
- **Muted Coral** (#F87171) — Error states in dark mode. Slightly softer red to maintain the warm tone.
- **Charcoal Surface** (#252336) — Bottom navigation bar background, sheets, and dialog surfaces in dark mode.

### Neutral Scale (Light Theme)
- **Ivory** (#FAFAF9)
- **Pearl** (#F5F5F4)
- **Stone 100** (#F5F5F4)
- **Stone 200** (#E7E5E4)
- **Stone 300** (#D6D3D1)
- **Stone 400** (#A8A29E)
- **Stone 500** (#78716C)
- **Stone 600** (#57534E)
- **Stone 700** (#44403C)
- **Stone 800** (#292524)
- **Stone 900** (#1C1917)

### Neutral Scale (Dark Theme)
- **Night Ivory** (#1A1825)
- **Night Pearl** (#252336)
- **Night Stone 100** (#2D2B3A)
- **Night Stone 200** (#3D3A4D)
- **Night Stone 300** (#4D4A5E)
- **Night Stone 400** (#6B6880)
- **Night Stone 500** (#8B8899)
- **Night Stone 600** (#ABABB9)
- **Night Stone 700** (#CBCAD0)
- **Night Stone 800** (#E5E4E8)
- **Night Stone 900** (#F3F4F6)

---

## 3. Typography

### Font Selection

- **Display Font:** Nunito — Rounded, friendly letterforms with a warm, approachable character. Excellent for headlines and large text where softness and readability are paramount. Nunito's terminals and joints have a gentle, open quality that avoids feeling sharp or clinical. Used for: Hero display, screen titles, section headers.

- **Body Font:** Nunito — The same family is used for body text to maintain visual cohesion. At reading sizes, Nunito's proportions provide comfortable extended reading without fatigue. Used for: Body text, labels, captions, button text, chips.

### Type Scale

| Role | Font | Weight | Size | Line Height | Usage |
|---|---|---|---|---|---|
| Hero display | Nunito | Bold (700) | 57pt | 64pt | Splash screens, week number display on pregnancy hero |
| Screen title | Nunito | SemiBold (600) | 28pt | 36pt | Top-level screen headings |
| Section header | Nunito | SemiBold (600) | 22pt | 28pt | Card titles, section headers within screens |
| Subtitle | Nunito | Medium (500) | 16pt | 24pt | List item titles, subtitles, chart labels |
| Body | Nunito | Regular (400) | 16pt | 24pt | Primary reading text, article body |
| Body small | Nunito | Regular (400) | 14pt | 20pt | Secondary text, descriptions, log entry details |
| Button label | Nunito | SemiBold (600) | 14pt | 20pt | Button text, chip labels, navigation items |
| Caption | Nunito | Medium (500) | 11pt | 16pt | Badges, timestamps, tab labels, small metadata |

### Letter Spacing Guidelines

- Hero display: 0pt (set solid)
- Screen titles: -0.5pt (slight tightening for large type)
- Body text: 0.15pt (open, readable spacing)
- Caption and labels: 0.4pt (clear separation for small text)

---

## 4. Component Styles

### Card
- **Corner radius:** 16 points
- **Shadow depth:** Soft, diffused shadow — 8 points blur, 2 points offset-y, rgba(0,0,0,0.08) in light mode; rgba(0,0,0,0.25) in dark mode. The shadow feels like gentle morning light creating a soft pool beneath the card.
- **Background:** Morning Mist (#FAFAFA) in light mode; Deep Twilight (#1E1B2E) in dark mode
- **Internal padding:** 16 points all sides; 20 points for cards containing action buttons
- **Tap feedback:** Subtle scale-down to 98% on press, with 200ms ease-out return. The press feels like a gentle press into a soft surface rather than a click.
- **Spacing between cards:** 12 points

### Buttons

**Primary Button**
- Shape: Pill-shaped (fully rounded on all corners, corner radius equals half the button height)
- Minimum height: 48 points (touch target compliance)
- Background: Lavender Bloom (#7C3AED) in light mode; Twilight Bloom (#9F67FF) in dark mode
- Text: White (#FFFFFF), SemiBold, 14pt
- Press feedback: 200ms ease-out scale to 95%, background darkens by 8% brightness
- Corner radius: 24 points (fully rounded pill)

**Secondary Button**
- Shape: Pill-shaped
- Minimum height: 48 points
- Background: Transparent with Lavender Bloom border (2 points stroke) in light mode; Transparent with Twilight Bloom border in dark mode
- Text: Lavender Bloom (#7C3AED) in light mode; Twilight Bloom (#9F67FF) in dark mode
- Press feedback: 200ms ease-out scale to 95%, background fills with 10% primary color
- Corner radius: 24 points

**Text Button**
- Shape: No background, no border
- Minimum height: 48 points
- Text: Lavender Bloom (#7C3AED) in light mode; Text button inherits no background, only color
- Press feedback: 200ms ease-out opacity reduction to 60%

**FAB (Floating Action Button)**
- Size: 56 points diameter
- Background: Lavender Bloom (#7C3AED); Twilight Bloom (#9F67FF) in dark mode
- Icon: White, 24 points
- Shadow: Medium diffused shadow, 12 points blur
- Press feedback: 200ms scale to 90%, shadow intensifies slightly

### Text Input
- **Decoration style:** Filled background — a rounded container that feels like a gentle trough for text
- **Corner radius:** 12 points
- **Fill color:** Stone 100 (#F5F5F4) in light mode; Night Stone 100 (#2D2B3A) in dark mode
- **Border:** None at rest; on focus, a 2-point Lavender Bloom border appears with smooth 200ms transition
- **Label behavior:** Floating label that rises above the field on focus or when content is present; label color transitions from Stone 400 (#A8A29E) to Lavender Bloom on focus
- **Error state:** Border becomes Soft Coral (#EF4444), error message appears below in Soft Coral, 14pt
- **Minimum height:** 56 points to ensure comfortable touch interaction

### Chip
- **Shape:** Fully rounded pill (corner radius = half the chip height)
- **Corner radius:** 16 points (pill shape)
- **Background (default):** Stone 100 (#F5F5F4) in light mode; Night Stone 100 (#2D2B3A) in dark mode
- **Background (selected):** Lavender Bloom at 15% opacity (#7C3AED1A), with Lavender Bloom text
- **Minimum height:** 32 points (comfortable touch target)
- **Horizontal padding:** 12 points left and right
- **Tap feedback:** 150ms opacity shift to selected state, no scale change (chips feel like gentle toggles, not buttons)

### Bottom Sheet
- **Top corner radius:** 28 points — large, prominent rounding that feels organic and soft
- **Background:** Warm White (#FFFFFF) in light mode; Charcoal Surface (#252336) in dark mode
- **Handle bar:** 40 points wide, 4 points tall, centered at top, Stone 300 (#D6D3D1) color in light mode; Night Stone 200 in dark mode. The handle feels like a gentle grip point, not structural.
- **Maximum height:** 90% of screen height for full sheets; 50% for half sheets
- **Shadow:** Soft diffused shadow, 16 points blur, 4 points offset-y
- **Open animation:** 250ms smooth deceleration — slides up from bottom edge with subtle fade

### Navigation Bar (Bottom Tabs)
- **Background color:** Warm White (#FFFFFF) in light mode; Charcoal Surface (#252336) in dark mode
- **Active indicator:** A small rounded pill beneath the active tab icon and label. The pill is filled with Lavender Bloom at 15% opacity. The indicator transitions smoothly (200ms) between tabs.
- **Icon style:** Outlined icons for inactive state, filled icons for active state — the active tab is visually "filled" with color
- **Icon size:** 24 points
- **Label visibility:** Labels are always visible below icons — no hidden label behavior. Text is SemiBold 11pt when active, Regular 11pt when inactive.
- **Touch target:** Each tab item has a minimum 48-point touch target height
- **Safe area:** Bottom navigation respects the home indicator area on notched devices

### App Bar
- **Background:** Transparent to scaffold background color (Lavender Tint #F5F3FF in light mode; Night Sky #13111C in dark mode). The AppBar feels like it floats over the content.
- **Title text style:** SemiBold 20pt, Deep Graphite (#1F2937) in light mode; Soft Pearl (#F3F4F6) in dark mode
- **Scroll behavior:** On scrollable content, the AppBar has a subtle fade-in effect as content scrolls beneath it. On screens with SliverAppBar, the AppBar collapses to show a smaller representation.
- **Leading/back button:** Icon button with 48-point touch target, Lavender Bloom on tap

---

## 5. Layout Principles

- **Base spacing unit:** 8 points — all spacing is derived from multiples of 8
- **Screen horizontal padding:** 16 points from each edge
- **Section vertical spacing:** 24 points between major sections
- **Card internal padding:** 16 points all sides
- **Card gap:** 12 points between cards in a grid or list
- **List item minimum height:** 56 points (comfortable touch target for interactive list items)
- **Minimum touch target:** 48 points (compliant with mobile accessibility standards)
- **Bottom sheet handle bar:** 40 points wide, 4 points tall, centered 20 points from top
- **Safe area awareness:** Respect status bar at top (add 12 points padding when status bar is visible) and home indicator at bottom (bottom navigation and FAB account for this)
- **Grid gutters:** 12 points between columns in 2-column grids
- **Card corner radius:** 16 points for standard cards; 12 points for smaller card variants

---

## 6. Motion & Animation

Motion is gentle, purposeful, and never jarring. The app feels like a calm, flowing experience rather than a reactive, mechanical one.

- **Page transitions:** 300ms duration, smooth deceleration. Screen content slides and fades simultaneously — the new screen appears to gently settle into place.
- **Micro-interactions:** 200ms duration, snappy ease-out. Button presses, chip selections, toggle switches — responses feel quick but soft, like a gentle tap on a responsive surface.
- **Hero transitions:** 350ms duration, fast-out-slow-in easing. When navigating from a list to a detail view (e.g., article reader), shared elements like images and titles smoothly expand and continue their motion arc.
- **Staggered list reveals:** 50ms delay between each item. When content loads, list items cascade into view in a waterfall — items appear 50ms apart, creating a sense of gentle unfolding rather than a sudden dump of content.
- **Bottom sheets:** 250ms duration, smooth deceleration. Sheets slide up from the bottom edge, decelerating naturally as they reach their resting position.
- **Pull-to-refresh:** 150ms duration, quick snap. The refresh indicator appears and dismisses quickly but not abruptly.
- **Tab indicator movement:** 200ms duration, ease-in-out. The active indicator pill smoothly glides between tab positions.
- **Card tap feedback:** 200ms ease-out scale to 98%, then 200ms ease-out return to 100%.
- **FAB appearance:** 200ms fade-in with subtle scale from 95% to 100%.

---

## 7. Anti-Patterns (Banned Design Rules)

- No default platform colors — every color comes from the design system palette
- No ad-hoc text sizing — all text uses the defined type scale
- No inconsistent spacing — all spacing uses the 8-point base unit scale
- No arbitrary elevation — every shadow level communicates a specific hierarchy
- No Inter or Roboto — Nunito is the only font family
- No purple or neon AI aesthetic — colors are warm pastels, not synthetic
- No generic gradients — backgrounds are flat or subtly tinted, not gradient-washed
- No shadows without purpose — elevation always communicates hierarchy
- No desktop patterns — no sidebars, hover tooltips, right-click menus, or desktop-only interaction patterns
- No touch targets smaller than 48 points
- No critical actions outside the thumb zone (bottom two-thirds of screen height)
- No pure black (#000000) anywhere — deep charcoal and off-black only
- No pure white (#FFFFFF) for text — use off-white tones that reduce eye strain