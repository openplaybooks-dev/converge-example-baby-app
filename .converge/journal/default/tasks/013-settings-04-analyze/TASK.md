---
id: 013-settings-04-analyze
title: "Analyze: Settings"
description: Identify extractable widget regions in Settings
inputs:
  - lib/screens/settings/settings_screen.dart
outputs:
  - .stitch/designs/settings/widgets.jsonl
checks:
  - id: widgets-json-exists
    type: cmd
    cmd: test -f .stitch/designs/settings/widgets.jsonl
    description: widgets.jsonl exists for settings
plan: {}
tags:
  - analyze
  - screen-settings
vars:
  screenId: settings
  title: Settings
  screenPath: lib/screens/settings/settings_screen.dart
  widgetsJsonPath: .stitch/designs/settings/widgets.jsonl
---

# Analyze: Settings

Analyze the screen widget and identify extractable widget regions.

## Input
- `lib/screens/settings/settings_screen.dart` — The screen widget file

## Task

Read the screen file and identify widget subtrees that should be extracted into separate widget files.

Write `.stitch/designs/settings/widgets.jsonl` with one JSON object per line (JSONL format):

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

- `.stitch/designs/settings/widgets.jsonl` exists with valid JSONL
- Each entry has: name, grep, description, shared
- Widget names use PascalCase
