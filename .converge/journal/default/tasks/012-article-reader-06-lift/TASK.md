---
id: 012-article-reader-06-lift
title: "Lift: Article Reader"
description: Lift shared widgets from Article Reader to lib/widgets/
blocking: true
inputs:
  - .stitch/designs/article-reader/widgets.jsonl
  - lib/screens/article_reader/_widgets/**/*.dart
outputs:
  - lib/widgets/**/*.dart
seed:
  mode: cli
tags:
  - lift
  - screen-article-reader
vars:
  screenId: article-reader
  title: Article Reader
  screenPath: lib/screens/article_reader/article_reader_screen.dart
  widgetsJsonPath: .stitch/designs/article-reader/widgets.jsonl
  localWidgetsDir: lib/screens/article_reader/_widgets
---

# Lift: Article Reader

Lift each widget in `lib/screens/article_reader/_widgets/` marked `shared: true` in `.stitch/designs/article-reader/widgets.jsonl` to `lib/widgets/` — one spawn per shared widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/article-reader/widgets.jsonl"
LOCAL_DIR="lib/screens/article_reader/_widgets"
SCREEN_PATH="lib/screens/article_reader/article_reader_screen.dart"
SID="article-reader"
TITLE="Article Reader"

[ -f "${WIDGETS}" ] || exit 0

I=0
while IFS= read -r W; do
  [ -z "${W}" ] && continue
  SHARED=$(echo "${W}" | jq -r '.shared // false')
  [ "${SHARED}" = "true" ] || continue
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"   | jq -r '.id // .name')
  WNAME=$(echo "${W}" | jq -r '.name // .id')
  LOCAL_FILE="${LOCAL_DIR}/${WNAME}.dart"
  SHARED_FILE="lib/widgets/${WNAME}.dart"
  converge spawn template \
    --path "${TEMPLATES}/screen-widget-lift/TASK.md" \
    --id "${SID}-lift-${P}-${WID}" \
    --var "screenId=${SID}" \
    --var "screenTitle=${TITLE}" \
    --var "screenPath=${SCREEN_PATH}" \
    --var "widgetId=${WID}" \
    --var "widgetName=${WNAME}" \
    --var "localFile=${LOCAL_FILE}" \
    --var "sharedFile=${SHARED_FILE}"
done < "${WIDGETS}"
```

If no widgets are shared (or the file is missing/empty), exit with no spawns.
