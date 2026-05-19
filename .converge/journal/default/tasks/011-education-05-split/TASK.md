---
id: 011-education-05-split
title: "Split: Education"
description: Extract widgets from Education screen into local widgets/
inputs:
  - .stitch/designs/education/widgets.jsonl
outputs:
  - lib/screens/education/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-education
vars:
  screenId: education
  title: Education
  screenPath: lib/screens/education/education_screen.dart
  widgetsJsonPath: .stitch/designs/education/widgets.jsonl
  localWidgetsDir: lib/screens/education/_widgets
---

# Split: Education

Extract each widget identified in `.stitch/designs/education/widgets.jsonl` into its own file under `lib/screens/education/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/education/widgets.jsonl"
LOCAL_DIR="lib/screens/education/_widgets"
SCREEN_PATH="lib/screens/education/education_screen.dart"
SID="education"
TITLE="Education"

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
