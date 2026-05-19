# Checks: 01-prepare-requirements

All checks must pass for this task to be considered complete.
Run each command from the project root. Fix failures and re-run.

## ux-spec-exists
**Description**: UX specification exists
**Command**: `test -f .stitch/UX.md`

## screens-json-exists
**Description**: Screen definitions exist
**Command**: `test -f .stitch/screens.json`