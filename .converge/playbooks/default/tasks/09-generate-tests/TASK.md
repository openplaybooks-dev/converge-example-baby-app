---
id: 09-generate-tests
title: Generate Tests
description: Per-screen widget smoke tests + one navigation smoke test. Wires the existing flutter-testing-apps skill.
references:
  - flutter-testing-apps
seed:
  mode: cli
blocking: true
depends_on:
  - 08-generate-assets
tags:
  - tests
  - flutter
inputs:
  - .stitch/screens.json
  - lib/router/app_router.dart
  - lib/screens/**/*.dart
outputs:
  - test/screens/**/*_test.dart
  - test/smoke_test.dart
checks:
  - id: widget-tests-created
    cmd: find test/screens -name '*_test.dart' -type f | wc -l | awk '{if ($1 > 0) exit 0; exit 1}'
    description: At least one widget test was created
  - id: smoke-test-created
    cmd: test -f test/smoke_test.dart
    description: Navigation smoke test exists
  - id: tests-pass
    cmd: flutter test --no-pub
    description: All tests pass
---

# Generate Tests

Spawn one widget smoke test per screen plus one navigation smoke test.

**How to seed this task:**

1. Run the Bash script below with the **Bash** tool. Stdout is the spawn-command list — quoting handled by the shell.
2. Copy each printed line into the `commands` array verbatim.

```bash
set -euo pipefail
TEMPLATES=".converge/playbooks/default/templates"
SCREENS_JSON=".stitch/screens.json"

SCREENS=$(jq -c '
  (if type == "array" then . else .screens end)
  | map(select(.route | startswith("/")))
' "${SCREENS_JSON}")

COUNT=$(echo "${SCREENS}" | jq 'length')
[ "${COUNT}" -gt 0 ] || { echo "no screens to test" >&2; exit 1; }

emit() {
  local path="$1" id="$2"; shift 2
  local out="converge spawn template --path $(printf %q "$path") --id $(printf %q "$id")"
  while [ "$#" -gt 0 ]; do
    out="$out --var $(printf %q "$1")"
    shift
  done
  printf '%s\n' "$out"
}

for I in $(seq 0 $((COUNT - 1))); do
  PREFIX=$(printf '%03d' $((I + 1)))
  S=$(echo "${SCREENS}" | jq -c ".[${I}]")
  SID=$(echo "${S}"   | jq -r '.id')
  TITLE=$(echo "${S}" | jq -r '.title')
  ROUTE=$(echo "${S}" | jq -r '.route')
  WIDGET=$(echo "${SID}" | awk -F'[-_]' '{ s=""; for (i=1;i<=NF;i++){ if (length($i)>0) s = s toupper(substr($i,1,1)) tolower(substr($i,2)) } print s }')
  SNAKE=$(echo "${SID}" | tr '[:upper:]' '[:lower:]' | tr '-' '_')

  emit "${TEMPLATES}/test-widget/TASK.md" "${PREFIX}-${SID}-test-widget" \
    "screenId=${SID}" "title=${TITLE}" "route=${ROUTE}" "widgetName=${WIDGET}" "snakeName=${SNAKE}" \
    "screenPath=lib/screens/${SNAKE}/${SNAKE}_screen.dart" \
    "testPath=test/screens/${SNAKE}_test.dart"
done

emit "${TEMPLATES}/test-smoke/TASK.md" "999-test-smoke" "testPath=test/smoke_test.dart"
```
