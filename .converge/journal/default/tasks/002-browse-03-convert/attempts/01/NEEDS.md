# Needs: 002-browse-03-convert

## Description

Convert constrained HTML design to Flutter widgets for Browse using stitch-flutter

## Inputs

- `.stitch/designs/browse/design.html`
- `.stitch/designs/browse/SPEC.md`
- `.stitch/system/DESIGN.md`

## Expected Outputs

- `lib/screens/browse/browse_screen.dart`

## Checks

- **screen-exists**: Screen widget file exists
- **dart-valid**: Dart analysis passes
- **uses-theme**: Uses Theme.of(context) for styling
- **no-hardcoded-colors**: No hardcoded colors — uses colorScheme
