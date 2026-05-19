# Needs: 03-build-screens

## Description

Per-screen vertical pipeline — spec, design HTML, Flutter widgets, analyze, split, lift — for every screen in screens.json

## Inputs

- `.stitch/screens.json`
- `.stitch/system/DESIGN.md`
- `.stitch/UX.md`

## Expected Outputs

- `lib/screens/**/*.dart`
- `lib/widgets/**/*.dart`
- `lib/router/app_router.dart`

## Checks

- **screens-json-exists**: Screen definitions exist
- **screens-created**: At least one screen widget was created
- **dart-analysis-valid**: All generated code passes analysis
