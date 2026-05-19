---
id: 007-pregnancy-progress-04-analyze
title: "Analyze: My Pregnancy"
description: Identify extractable widget regions in My Pregnancy
inputs:
  - lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
outputs:
  - .stitch/designs/pregnancy-progress/widgets.jsonl
checks:
  - id: widgets-json-exists
    type: cmd
    cmd: test -f .stitch/designs/pregnancy-progress/widgets.jsonl
    description: widgets.jsonl exists for pregnancy-progress
plan: {}
tags:
  - analyze
  - screen-pregnancy-progress
vars:
  screenId: pregnancy-progress
  title: My Pregnancy
  screenPath: lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
  widgetsJsonPath: .stitch/designs/pregnancy-progress/widgets.jsonl
---

# Analyze: My Pregnancy

Analyze the screen widget and identify extractable widget regions.

## Input
- `lib/screens/pregnancy_progress/pregnancy_progress_screen.dart` — The screen widget file

## Task

Read the screen file and identify widget subtrees that should be extracted into separate widget files.

Write `.stitch/designs/pregnancy-progress/widgets.jsonl` with one JSON object per line (JSONL format):

```jsonl
{"name": "WidgetName", "grep": "unique string to locate in source", "description": "what it renders", "shared": false}
{"name": "AnotherWidget", "grep": "unique string", "description": "what it renders", "shared": true}
```

## Extraction Criteria

Extract a region when:
- It's a self-contained visual block (card, list item, section header)
- It has 15+ lines of widget code
- It could be reused across screens (`shared: true`)
- It has its own data/state concerns

Do NOT extract:
- Simple `Text`, `Icon`, or `SizedBox` widgets
- Layout wrappers (`Padding`, `Center`)
- Anything under 10 lines

## Success Criteria

- `.stitch/designs/pregnancy-progress/widgets.jsonl` exists with valid JSONL
- Each entry has: name, grep, description, shared
- Widget names use PascalCase
