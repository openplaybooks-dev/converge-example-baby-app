---
id: 03-build-screens
title: Build Screens
description: Per-screen vertical pipeline — spec, design HTML, Flutter widgets, analyze, split, lift — for every screen in screens.json
references:
  - flutter-building-layouts
  - flutter-animating-apps
  - flutter-improving-accessibility
seed:
  mode: cli
blocking: true
depends_on:
  - 02-design-system
tags:
  - screens
  - flutter
inputs:
  - .stitch/screens.json
  - .stitch/system/DESIGN.md
  - .stitch/UX.md
outputs:
  - lib/screens/**/*.dart
  - lib/widgets/**/*.dart
  - lib/router/app_router.dart
checks:
  - id: screens-json-exists
    cmd: test -f .stitch/screens.json
    description: Screen definitions exist
  - id: screens-created
    cmd: find lib/screens -name '*.dart' -type f | wc -l | awk '{if ($1 > 0) exit 0; exit 1}'
    description: At least one screen widget was created
  - id: dart-analysis-valid
    cmd: dart analyze lib/
    description: All generated code passes analysis
backlogs:
  - id: noop-buttons
    cmd: "grep -rn 'onPressed: null' lib/screens/ lib/widgets/ 2>/dev/null | grep -v 'disabled' || true"
    description: Buttons with null onPressed (non-functional)
    severity: high
  - id: placeholder-text
    cmd: "grep -rn 'Lorem\\|placeholder\\|TODO\\|FIXME\\|Coming soon\\|TBD' lib/screens/ lib/widgets/ 2>/dev/null || true"
    description: Placeholder or TODO text left in UI
    severity: medium
---

# Build Screens

Generate a 6-step pipeline (spec, design, convert, analyze, split, lift) per screen in `.stitch/screens.json` whose `route` starts with `/`.

**How to seed this task:**

1. Run the Bash script below verbatim with the **Bash** tool. It prints one `converge spawn template …` line per spawn — all quoting handled by the shell.
2. Take the script's stdout, split by newline, and place each non-empty line into the `commands` array of your JSON response.
3. Do not paraphrase, edit, or re-emit the lines — copy them as-is.

```bash
set -euo pipefail
TEMPLATES=".converge/playbooks/default/templates"
SCREENS_JSON=".stitch/screens.json"

SCREENS=$(jq -c '
  (if type == "array" then . else .screens end)
  | map(select(.route | startswith("/")))
' "${SCREENS_JSON}")

COUNT=$(echo "${SCREENS}" | jq 'length')
[ "${COUNT}" -gt 0 ] || { echo "no screens with route starting with /" >&2; exit 1; }

emit() {
  # printf %q makes every value shell-safe, which also makes it
  # parser-safe (the cli-spawn tokenizer accepts quote chars).
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
  SCREEN_PATH="lib/screens/${SNAKE}/${SNAKE}_screen.dart"
  LOCAL_WIDGETS_DIR="lib/screens/${SNAKE}/_widgets"
  WIDGETS_JSON=".stitch/designs/${SID}/widgets.jsonl"
  SPEC=".stitch/designs/${SID}/SPEC.md"
  META=".stitch/designs/${SID}/META.md"
  DESIGN=".stitch/designs/${SID}/design.html"

  emit "${TEMPLATES}/screen-01-spec/TASK.md"    "${PREFIX}-${SID}-01-spec" \
       "screenId=${SID}" "title=${TITLE}" "route=${ROUTE}" "widgetName=${WIDGET}" "specPath=${SPEC}"
  emit "${TEMPLATES}/screen-02-design/TASK.md"  "${PREFIX}-${SID}-02-design" \
       "screenId=${SID}" "title=${TITLE}" "specPath=${SPEC}" "metaPath=${META}" "designPath=${DESIGN}"
  emit "${TEMPLATES}/screen-03-convert/TASK.md" "${PREFIX}-${SID}-03-convert" \
       "screenId=${SID}" "title=${TITLE}" "route=${ROUTE}" "widgetName=${WIDGET}" "specPath=${SPEC}" "designPath=${DESIGN}" "screenPath=${SCREEN_PATH}"
  emit "${TEMPLATES}/screen-04-analyze/TASK.md" "${PREFIX}-${SID}-04-analyze" \
       "screenId=${SID}" "title=${TITLE}" "screenPath=${SCREEN_PATH}" "widgetsJsonPath=${WIDGETS_JSON}"
  emit "${TEMPLATES}/screen-05-split/TASK.md"   "${PREFIX}-${SID}-05-split" \
       "screenId=${SID}" "title=${TITLE}" "screenPath=${SCREEN_PATH}" "widgetsJsonPath=${WIDGETS_JSON}" "localWidgetsDir=${LOCAL_WIDGETS_DIR}"
  emit "${TEMPLATES}/screen-06-lift/TASK.md"    "${PREFIX}-${SID}-06-lift" \
       "screenId=${SID}" "title=${TITLE}" "screenPath=${SCREEN_PATH}" "widgetsJsonPath=${WIDGETS_JSON}" "localWidgetsDir=${LOCAL_WIDGETS_DIR}"
done
```
