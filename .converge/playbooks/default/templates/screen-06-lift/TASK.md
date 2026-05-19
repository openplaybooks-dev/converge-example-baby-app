---
title: "Lift: {{title}}"
description: "Lift shared widgets from {{title}} to lib/widgets/ — one spawn per shared widget"
seed:
  mode: cli
blocking: true
tags:
  - lift
  - screen-{{screenId}}
vars:
  screenId:
  title:
  screenPath:
  widgetsJsonPath:
  localWidgetsDir:
inputs:
  - "{{widgetsJsonPath}}"
  - "{{localWidgetsDir}}/**/*.dart"
outputs:
  - lib/widgets/**/*.dart
---

# Lift: {{title}}

Spawn one child per widget marked `shared: true` in `{{widgetsJsonPath}}`. Each child moves its widget from `{{localWidgetsDir}}/<name>.dart` to `lib/widgets/<name>.dart` and updates all importers.

**How to seed:** run the Bash script below, then copy every printed line verbatim into the `commands` array. If no widgets are shared (or the file is missing), emit no commands and set `done: true`.

```bash
set -euo pipefail
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS="{{widgetsJsonPath}}"
LOCAL_DIR="{{localWidgetsDir}}"
SCREEN_PATH="{{screenPath}}"
SID="{{screenId}}"
TITLE="{{title}}"

[ -f "${WIDGETS}" ] || exit 0

emit() {
  local path="$1" id="$2"; shift 2
  local out="converge spawn template --path $(printf %q "$path") --id $(printf %q "$id")"
  while [ "$#" -gt 0 ]; do
    out="$out --var $(printf %q "$1")"
    shift
  done
  printf '%s\n' "$out"
}

I=0
while IFS= read -r W; do
  [ -z "${W}" ] && continue
  SHARED=$(echo "${W}" | jq -r '.shared // false')
  [ "${SHARED}" = "true" ] || continue
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"   | jq -r '.id // .name')
  WNAME=$(echo "${W}" | jq -r '.name // .id')
  SNAKE=$(echo "${WNAME}" | sed -E 's/([a-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')
  LOCAL_FILE="${LOCAL_DIR}/${SNAKE}.dart"
  SHARED_FILE="lib/widgets/${SNAKE}.dart"
  emit "${TEMPLATES}/screen-widget-lift/TASK.md" "${SID}-lift-${P}-${WID}" \
    "screenId=${SID}" "screenTitle=${TITLE}" "screenPath=${SCREEN_PATH}" \
    "widgetId=${WID}" "widgetName=${WNAME}" \
    "localFile=${LOCAL_FILE}" "sharedFile=${SHARED_FILE}"
done < "${WIDGETS}"
```
