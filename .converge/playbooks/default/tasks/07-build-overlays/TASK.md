---
id: 07-build-overlays
title: Build Overlays — Spec, Design, Convert, Connect, Mount
description: Per-overlay pipeline for dynamic views (bottom sheets, dialogs, persistent bars)
references:
  - flutter-implementing-navigation-and-routing
  - flutter-animating-apps
seed:
  mode: cli
blocking: true
depends_on:
  - 06-wire-screens
tags:
  - overlays
  - flutter
inputs:
  - .stitch/screens.json
  - .stitch/SITE.md
  - .stitch/system/DESIGN.md
  - .stitch/UX.md
outputs:
  - lib/widgets/overlays/**/*.dart
checks:
  - id: overlays-created
    cmd: find lib/widgets/overlays -name '*.dart' 2>/dev/null | wc -l | awk '{if ($1 >= 2) exit 0; exit 1}'
    description: At least 2 overlay widgets were created
  - id: dart-analysis-valid
    cmd: dart analyze lib/
    description: All generated code passes analysis
---

# Build Overlays

Per-overlay 5-step pipeline (spec, design, convert, connect, mount) for each overlay entry in `.stitch/screens.json` (entries whose `route` starts with `overlay:`).

**How to seed this task:**

1. Run the Bash script below with the **Bash** tool. It prints one `converge spawn template …` line per spawn — quoting is shell-safe.
2. Copy each printed line into the `commands` array verbatim.
3. If no overlay entries exist, emit no commands and set `done: true`.

```bash
set -euo pipefail
TEMPLATES=".converge/playbooks/default/templates"
SCREENS_JSON=".stitch/screens.json"
[ -f "${SCREENS_JSON}" ] || exit 0

OVERLAYS=$(jq -c '
  (if type == "array" then . else .screens end)
  | map(select(.route | startswith("overlay:")))
' "${SCREENS_JSON}")

COUNT=$(echo "${OVERLAYS}" | jq 'length')
[ "${COUNT}" -gt 0 ] || exit 0

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
  O=$(echo "${OVERLAYS}" | jq -c ".[${I}]")
  OID=$(echo "${O}"   | jq -r '.id')
  TITLE=$(echo "${O}" | jq -r '.title')
  ROUTE=$(echo "${O}" | jq -r '.route')
  WIDGET=$(echo "${OID}" | awk -F'[-_]' '{ s=""; for (i=1;i<=NF;i++){ if (length($i)>0) s = s toupper(substr($i,1,1)) tolower(substr($i,2)) } print s }')
  SNAKE=$(echo "${OID}" | tr '[:upper:]' '[:lower:]' | tr '-' '_')

  for STEP in 01-spec 02-design 03-convert 04-connect 05-mount; do
    emit "${TEMPLATES}/overlay-${STEP}/TASK.md" "${PREFIX}-${OID}-${STEP}" \
      "overlayId=${OID}" "title=${TITLE}" "route=${ROUTE}" "widgetName=${WIDGET}" "fileBaseName=${SNAKE}"
  done
done
```
