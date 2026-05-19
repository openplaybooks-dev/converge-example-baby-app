---
title: "Split: {{title}}"
description: "Extract widgets from {{title}} screen into local _widgets/ — one spawn per widget"
seed:
  mode: cli
tags:
  - split
  - screen-{{screenId}}
vars:
  screenId:
  title:
  screenPath:
  widgetsJsonPath:
  localWidgetsDir:
inputs:
  - "{{widgetsJsonPath}}"
outputs:
  - "{{localWidgetsDir}}/**/*.dart"
---

# Split: {{title}}

Spawn one child task per widget listed in `{{widgetsJsonPath}}` (JSONL, one widget per line). Each child extracts a single widget into `{{localWidgetsDir}}/<name>.dart`.

**How to seed:** run the Bash script below with the Bash tool, then copy every printed line verbatim into the `commands` array. If the widgets file is missing or empty, emit no commands and set `done: true`.

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
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"   | jq -r '.id // .name')
  WNAME=$(echo "${W}" | jq -r '.name // .id')
  SNAKE=$(echo "${WNAME}" | sed -E 's/([a-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')
  WIDGET_FILE="${LOCAL_DIR}/${SNAKE}.dart"
  emit "${TEMPLATES}/screen-widget-split/TASK.md" "${SID}-split-${P}-${WID}" \
    "screenId=${SID}" "screenTitle=${TITLE}" "screenPath=${SCREEN_PATH}" \
    "widgetId=${WID}" "widgetName=${WNAME}" "widgetFile=${WIDGET_FILE}"
done < "${WIDGETS}"
```
