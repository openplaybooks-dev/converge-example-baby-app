# Pregnant Tracker - Baby Bump — Design Reference (META)

## Overview

This document serves as a machine-readable index and cross-reference for the design system. It maps design decisions to their source of truth, lists available assets, and provides tooling metadata.

---

## Design System Identity

| Field | Value |
|---|---|
| Theme name | Gentle Bloom |
| Primary mode | Light |
| Version | 1.0 |
| Created | 2026-05-18 |

---

## Source Files

| File | Purpose |
|---|---|
| `.stitch/UX.md` | UX specification with vibe, user personas, screens, navigation |
| `.stitch/screens.json` | Screen definitions with IDs, routes, and feature lists |
| `.stitch/system/DESIGN.md` | Design system specification with colors, typography, components |

---

## Font Stack

| Role | Font | Weights | Source |
|---|---|---|---|
| Display + Body | Nunito | 400, 500, 600, 700 | Google Fonts |

---

## Color Palette Reference

### Light Theme
| Role | Name | Hex |
|---|---|---|
| Primary brand | Lavender Bloom | #7C3AED |
| Secondary accent | Blush Rose | #F9A8D4 |
| Tertiary / success | Soft Mint | #6EE7B7 |
| Surface background | Morning Mist | #FAFAFA |
| Scaffold background | Lavender Tint | #F5F3FF |
| Primary text | Deep Graphite | #1F2937 |
| Secondary text | Stone Grey | #6B7280 |
| Border / divider | Misty Border | #E5E7EB |
| Error | Soft Coral | #EF4444 |
| Surface overlay | Warm White | #FFFFFF |

### Dark Theme
| Role | Name | Hex |
|---|---|---|
| Primary brand | Twilight Bloom | #9F67FF |
| Secondary accent | Dusky Rose | #FBC4E0 |
| Tertiary / success | Night Mint | #34D399 |
| Surface background | Deep Twilight | #1E1B2E |
| Scaffold background | Night Sky | #13111C |
| Primary text | Soft Pearl | #F3F4F6 |
| Secondary text | Muted Silver | #9CA3AF |
| Border / divider | Deep Border | #2D2B3A |
| Error | Muted Coral | #F87171 |
| Surface overlay | Charcoal Surface | #252336 |

---

## Spacing Scale

| Token | Points |
|---|---|
| Base unit | 8 |
| xxs | 4 |
| xs | 8 |
| sm | 12 |
| md | 16 |
| lg | 24 |
| xl | 32 |
| xxl | 48 |

---

## Corner Radius Scale

| Token | Points |
|---|---|
| sm | 8 |
| md | 12 |
| lg | 16 |
| full | 999 (pill) |

---

## Type Scale

| Role | Size | Weight | Line Height |
|---|---|---|---|
| Hero display | 57pt | Bold (700) | 64pt |
| Screen title | 28pt | SemiBold (600) | 36pt |
| Section header | 22pt | SemiBold (600) | 28pt |
| Subtitle | 16pt | Medium (500) | 24pt |
| Body | 16pt | Regular (400) | 24pt |
| Body small | 14pt | Regular (400) | 20pt |
| Button label | 14pt | SemiBold (600) | 20pt |
| Caption | 11pt | Medium (500) | 16pt |

---

## Motion Tokens

| Token | Duration | Easing Character |
|---|---|---|
| Micro-interactions | 200ms | Snappy ease-out |
| Page transitions | 300ms | Smooth deceleration |
| Hero transitions | 350ms | Fast-out-slow-in |
| Bottom sheets | 250ms | Smooth deceleration |
| Staggered reveals | 50ms delay per item | — |
| Pull-to-refresh | 150ms | Quick snap |
| Tab indicator | 200ms | Ease-in-out |

---

## Anti-Patterns (Banned)

- No platform default colors — use design system palette only
- No ad-hoc text sizing — use type scale only
- No inconsistent spacing — use spacing tokens only
- No arbitrary elevation — use defined shadow levels only
- No Inter or Roboto fonts
- No purple/neon accents — warm pastels only
- No pure black (#000000)
- No touch targets below 48pt
- No desktop-only patterns

---

## Screen Coverage

| Screen ID | Route | Navigation |
|---|---|---|
| home | `/` | Tab |
| browse | `/browse` | Tab |
| library | `/library` | Tab |
| profile | `/profile` | Tab |
| cycle-tracking | `/cycle-tracking` | Push |
| weight-nutrition | `/weight-nutrition` | Push |
| pregnancy-progress | `/pregnancy-progress` | Push |
| mindfulness | `/mindfulness` | Push |
| health-log | `/health-log` | Push |
| mood-wellness | `/mood-wellness` | Push |
| education | `/education` | Push |
| article-reader | `/article-reader/:id` | Push |
| settings | `/settings` | Push |

---

## Overlay Coverage

| Overlay ID | Type | Parent |
|---|---|---|
| breathing-exercise | full-sheet | mindfulness |
| stretching-guide | bottom-sheet | mindfulness |
| mode-selector | bottom-sheet | home |
| symptom-detail | bottom-sheet | health-log |

---

## Screen Reference Files

| File | Pattern | Description |
|------|---------|-------------|
| `single-screen.html` | Single Screen | Home dashboard with week banner, mood check-in, daily checklist, and quick actions |
| `multi-state-screen.html` | Multi-State | Mood & Wellness with emoji selector, note field, mood/energy trend charts across empty/filling/complete states |
| `celebration-screen.html` | Celebration | Pregnancy Progress showing week hero with fruit-size comparison, body changes, baby development, and due date countdown |

## Key Design Patterns

- Soft, nurturing UI with 16px card radius and pill-shaped buttons (24px radius)
- Lavender primary (#7C3AED) with Blush Rose secondary (#F9A8D4) accents
- Bottom navigation with 4 tabs and active state indicator pills
- SVG-based inline icons throughout
- Nunito font family with generous line-height for calm readability
- Gentle spring-based animations (200-300ms ease-out transitions)

## Implementation Notes

- All screens use the 4-tab bottom navigation shell
- Push routes hide the bottom navigation bar
- Full-sheet overlays cover the entire screen (used for breathing exercise animation)
- Bottom-sheet overlays slide up from the bottom edge for contextual forms
- FAB appears on push routes that support entry creation (cycle-tracking, weight-nutrition, health-log)