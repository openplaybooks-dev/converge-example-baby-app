# Needs: 004-profile-03-convert

## Description

Convert constrained HTML design to Flutter widgets for Profile using stitch-flutter

## Inputs

- `.stitch/designs/profile/design.html`
- `.stitch/designs/profile/SPEC.md`
- `.stitch/system/DESIGN.md`

## Expected Outputs

- `lib/screens/profile/profile_screen.dart`

## Checks

- **screen-exists**: Screen widget file exists
- **dart-valid**: Dart analysis passes
- **uses-theme**: Uses Theme.of(context) for styling
- **no-hardcoded-colors**: No hardcoded colors — uses colorScheme
