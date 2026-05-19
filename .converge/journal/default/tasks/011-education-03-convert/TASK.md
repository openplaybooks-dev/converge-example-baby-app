---
id: 011-education-03-convert
title: "Convert: Education"
description: Convert constrained HTML design to Flutter widgets for Education using stitch-flutter
inputs:
  - .stitch/designs/education/design.html
  - .stitch/designs/education/SPEC.md
  - .stitch/system/DESIGN.md
outputs:
  - lib/screens/education/education_screen.dart
checks:
  - id: screen-exists
    type: cmd
    cmd: test -f lib/screens/education/education_screen.dart
    description: Screen widget file exists
  - id: dart-valid
    type: cmd
    cmd: dart analyze lib/screens/education/education_screen.dart
    description: Dart analysis passes
  - id: uses-theme
    type: cmd
    cmd: grep -q 'Theme.of(context)' lib/screens/education/education_screen.dart
    description: Uses Theme.of(context) for styling
  - id: no-hardcoded-colors
    type: cmd
    cmd: "! grep -qE 'Color\\(0x|Colors\\.' lib/screens/education/education_screen.dart"
    description: No hardcoded colors — uses colorScheme
tags:
  - convert
  - flutter
  - screen-education
vars:
  skill: stitch-flutter
  references:
    - flutter-building-layouts
    - flutter-animating-apps
  screenId: education
  title: Education
  route: /education
  widgetName: Education
  specPath: .stitch/designs/education/SPEC.md
  designPath: .stitch/designs/education/design.html
  screenPath: lib/screens/education/education_screen.dart
---

# Convert: Education

Convert the constrained HTML design to a pixel-perfect Flutter widget using the **stitch-flutter** skill.

## Inputs
- `.stitch/designs/education/design.html` — HTML design mockup (written in Flutter HTML Glossary vocabulary)
- `.stitch/designs/education/SPEC.md` — Screen specification
- `.stitch/system/DESIGN.md` — Design system specification

## How It Works

The HTML mockup uses the **Flutter HTML Glossary** — a constrained vocabulary where every HTML class and `data-*` attribute maps 1:1 to a Flutter widget. This enables mechanical, pixel-perfect conversion.

## Conversion Steps

1. **Read HTML** — Parse `.stitch/designs/education/design.html` and extract:
   - `:root` CSS tokens → update `lib/theme/app_theme.dart` if new tokens found
   - `.scaffold` element tree → this is the conversion entry point
   - `data-*` attributes → Flutter widget parameters
   - `data-animate` attributes → `flutter_animate` chains
   - `aria-*` attributes → `Semantics` widgets

2. **Walk the DOM** — Process each glossary element top-down:
   - `.scaffold` → `Scaffold()`
   - `.app-bar` → `AppBar()`
   - `.column` → `Column()`
   - `.row` → `Row()`
   - `.card` → `Card()`
   - `.ink-well[data-route]` → `InkWell(onTap: () => context.push(route))`
   - `.network-image` → `CachedNetworkImage()`
   - `.icon[data-name]` → `Icon(Icons.{name})`
   - Text classes (`.title-large`, `.body-medium`, etc.) → `Text(..., style: textTheme.X)`
   - `data-color` → `colorScheme.X`
   - `data-spacing` → `AppTheme.spaceX`
   - `data-radius` → `AppTheme.radiusX`

3. **Generate Dart** — Write `lib/screens/education/education_screen.dart`:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:cached_network_image/cached_network_image.dart';
   import 'package:flutter_animate/flutter_animate.dart';
   import 'package:folio/theme/app_theme.dart';

   class EducationScreen extends StatelessWidget {
     const EducationScreen({super.key});

     @override
     Widget build(BuildContext context) {
       final theme = Theme.of(context);
       final colorScheme = theme.colorScheme;
       final textTheme = theme.textTheme;

       return Scaffold(
         // ... mechanically converted from glossary elements
       );
     }
   }
   ```

4. **Update router** — Add route to `lib/router/app_router.dart`:
   ```dart
   GoRoute(
     path: '/education',
     builder: (context, state) => const EducationScreen(),
   ),
   ```

5. **Verify** — Run `dart analyze lib/screens/education/education_screen.dart`

## Reference Skills

- Read **flutter-building-layouts** for constraint rules (constraints down, sizes up), avoiding unbounded constraints in flex boxes, and when to use `Expanded` vs `Flexible` vs `SizedBox`.
- Read **flutter-animating-apps** for Hero transition setup, implicit vs explicit animations, and staggered animation patterns.

## Quality Gates

- **No hardcoded colors** — `Color(0xFF...)` and `Colors.blue` are banned; use `colorScheme.X`
- **No hardcoded text styles** — `TextStyle(fontSize: 16)` is banned; use `textTheme.X`
- **No hardcoded spacing** — `EdgeInsets.all(16)` is banned; use `AppTheme.spaceMd`
- **No Container abuse** — prefer `SizedBox`, `Padding`, `DecoratedBox` when Container is overkill
- **Use const** — `const` constructor wherever possible
- **Trailing commas** — on every parameter list

## Success Criteria

- `lib/screens/education/education_screen.dart` exists with valid Dart
- Uses `Theme.of(context)` for all styling (colors, text, shapes)
- No hardcoded colors, text styles, or spacing values
- Route added to `app_router.dart`
- `dart analyze` passes
