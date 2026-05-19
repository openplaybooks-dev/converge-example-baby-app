---
id: 005-cycle-tracking-04-analyze
title: "Analyze: Cycle Tracking"
description: Identify extractable widget regions in Cycle Tracking
inputs:
  - lib/screens/cycle_tracking/cycle_tracking_screen.dart
outputs:
  - .stitch/designs/cycle-tracking/widgets.jsonl
checks:
  - id: widgets-json-exists
    type: cmd
    cmd: test -f .stitch/designs/cycle-tracking/widgets.jsonl
    description: widgets.jsonl exists for cycle-tracking
plan: {}
tags:
  - analyze
  - screen-cycle-tracking
vars:
  screenId: cycle-tracking
  title: Cycle Tracking
  screenPath: lib/screens/cycle_tracking/cycle_tracking_screen.dart
  widgetsJsonPath: .stitch/designs/cycle-tracking/widgets.jsonl
---

# Analyze: Cycle Tracking

Analyze the screen widget and identify extractable widget regions.

## Input
- `lib/screens/cycle_tracking/cycle_tracking_screen.dart` — The screen widget file

## Task

Read the screen file and identify widget subtrees that should be extracted into separate widget files.

Write `.stitch/designs/cycle-tracking/widgets.jsonl` with one JSON object per line (JSONL format):

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

- `.stitch/designs/cycle-tracking/widgets.jsonl` exists with valid JSONL
- Each entry has: name, grep, description, shared
- Widget names use PascalCase
