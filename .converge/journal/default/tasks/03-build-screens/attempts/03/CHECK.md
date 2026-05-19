# Checks: 03-build-screens

All checks must pass for this task to be considered complete.
Run each command from the project root. Fix failures and re-run.

## screens-json-exists
**Description**: Screen definitions exist
**Command**: `test -f .stitch/screens.json`

## screens-created
**Description**: At least one screen widget was created
**Command**: `find lib/screens -name '*.dart' -type f | wc -l | awk '{if ($1 > 0) exit 0; exit 1}'`

## dart-analysis-valid
**Description**: All generated code passes analysis
**Command**: `dart analyze lib/`