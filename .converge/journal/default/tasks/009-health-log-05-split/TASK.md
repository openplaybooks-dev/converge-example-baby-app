---
id: 009-health-log-05-split
title: "Split: Health Log"
description: Extract widgets from Health Log screen into local widgets/
inputs:
  - .stitch/designs/health-log/widgets.jsonl
outputs:
  - lib/screens/health_log/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-health-log
vars:
  screenId: health-log
  title: Health Log
  screenPath: lib/screens/health_log/health_log_screen.dart
  widgetsJsonPath: .stitch/designs/health-log/widgets.jsonl
  localWidgetsDir: lib/screens/health_log/_widgets
---

# Split: Health Log

Extract each widget identified in `.stitch/designs/health-log/widgets.jsonl` into its own file under `lib/screens/health_log/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/health-log/widgets.jsonl"
LOCAL_DIR="lib/screens/health_log/_widgets"
SCREEN_PATH="lib/screens/health_log/health_log_screen.dart"
SID="health-log"
TITLE="Health Log"

[ -f "${WIDGETS}" ] || exit 0

I=0
while IFS= read -r W; do
  [ -z "${W}" ] && continue
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"      | jq -r '.id // .name')
  WNAME=$(echo "${W}"    | jq -r '.name // .id')
  WIDGET_FILE="${LOCAL_DIR}/${WNAME}.dart"
  converge spawn template \
    --path "${TEMPLATES}/screen-widget-split/TASK.md" \
    --id "${SID}-split-${P}-${WID}" \
    --var "screenId=${SID}" \
    --var "screenTitle=${TITLE}" \
    --var "screenPath=${SCREEN_PATH}" \
    --var "widgetId=${WID}" \
    --var "widgetName=${WNAME}" \
    --var "widgetFile=${WIDGET_FILE}"
done < "${WIDGETS}"
```

If the widgets file is missing or empty, exit with no spawns.
