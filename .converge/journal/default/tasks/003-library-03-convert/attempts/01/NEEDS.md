# Needs: 003-library-03-convert

## Description

Convert constrained HTML design to Flutter widgets for Library using stitch-flutter

## Inputs

- `.stitch/designs/library/design.html`
- `.stitch/designs/library/SPEC.md`
- `.stitch/system/DESIGN.md`

## Expected Outputs

- `lib/screens/library/library_screen.dart`

## Checks

- **screen-exists**: Screen widget file exists
- **dart-valid**: Dart analysis passes
- **uses-theme**: Uses Theme.of(context) for styling
- **no-hardcoded-colors**: No hardcoded colors — uses colorScheme
