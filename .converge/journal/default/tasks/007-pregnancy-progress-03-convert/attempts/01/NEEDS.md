# Needs: 007-pregnancy-progress-03-convert

## Description

Convert constrained HTML design to Flutter widgets for My Pregnancy using stitch-flutter

## Inputs

- `.stitch/designs/pregnancy-progress/design.html`
- `.stitch/designs/pregnancy-progress/SPEC.md`
- `.stitch/system/DESIGN.md`

## Expected Outputs

- `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart`

## Checks

- **screen-exists**: Screen widget file exists
- **dart-valid**: Dart analysis passes
- **uses-theme**: Uses Theme.of(context) for styling
- **no-hardcoded-colors**: No hardcoded colors — uses colorScheme
