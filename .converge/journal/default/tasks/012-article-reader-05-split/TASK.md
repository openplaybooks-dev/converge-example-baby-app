---
id: 012-article-reader-05-split
title: "Split: Article Reader"
description: Extract widgets from Article Reader screen into local widgets/
inputs:
  - .stitch/designs/article-reader/widgets.jsonl
outputs:
  - lib/screens/article_reader/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-article-reader
vars:
  screenId: article-reader
  title: Article Reader
  screenPath: lib/screens/article_reader/article_reader_screen.dart
  widgetsJsonPath: .stitch/designs/article-reader/widgets.jsonl
  localWidgetsDir: lib/screens/article_reader/_widgets
---

# Split: Article Reader

Extract each widget identified in `.stitch/designs/article-reader/widgets.jsonl` into its own file under `lib/screens/article_reader/_widgets/` — one spawn per widget.

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
