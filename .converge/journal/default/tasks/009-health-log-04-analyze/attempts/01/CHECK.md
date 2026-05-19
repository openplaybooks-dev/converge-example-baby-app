# Checks: 009-health-log-04-analyze

All checks must pass for this task to be considered complete.
Run each command from the project root. Fix failures and re-run.

## widgets-json-exists
**Description**: widgets.jsonl exists for health-log
**Command**: `test -f .stitch/designs/health-log/widgets.jsonl`