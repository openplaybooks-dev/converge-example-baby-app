---
id: 009-health-log-04-analyze
title: "Analyze: Health Log"
description: Identify extractable widget regions in Health Log
inputs:
  - lib/screens/health_log/health_log_screen.dart
outputs:
  - .stitch/designs/health-log/widgets.jsonl
checks:
  - id: widgets-json-exists
    type: cmd
    cmd: test -f .stitch/designs/health-log/widgets.jsonl
    description: widgets.jsonl exists for health-log
plan: {}
tags:
  - analyze
  - screen-health-log
vars:
  screenId: health-log
  title: Health Log
  screenPath: lib/screens/health_log/health_log_screen.dart
  widgetsJsonPath: .stitch/designs/health-log/widgets.jsonl
---

# Analyze: Health Log

Analyze the screen widget and identify extractable widget regions.

## Input
- `lib/screens/health_log/health_log_screen.dart` — The screen widget file

## Task

Read the screen file and identify widget subtrees that should be extracted into separate widget files.

Write `.stitch/designs/health-log/widgets.jsonl` with one JSON object per line (JSONL format):

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

- `.stitch/designs/health-log/widgets.jsonl` exists with valid JSONL
- Each entry has: name, grep, description, shared
- Widget names use PascalCase
