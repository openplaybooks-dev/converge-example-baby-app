# Checks: browse-split-001-LinkCard

All checks must pass for this task to be considered complete.
Run each command from the project root. Fix failures and re-run.

## widget-exists
**Description**: Widget file exists
**Command**: `test -f lib/screens/browse/_widgets/LinkCard.dart`

## dart-valid
**Description**: Dart analysis passes
**Command**: `dart analyze lib/screens/browse/_widgets/LinkCard.dart`