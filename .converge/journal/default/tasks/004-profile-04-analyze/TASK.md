---
id: 004-profile-04-analyze
title: "Analyze: Profile"
description: Identify extractable widget regions in Profile
inputs:
  - lib/screens/profile/profile_screen.dart
outputs:
  - .stitch/designs/profile/widgets.jsonl
checks:
  - id: widgets-json-exists
    type: cmd
    cmd: test -f .stitch/designs/profile/widgets.jsonl
    description: widgets.jsonl exists for profile
plan: {}
tags:
  - analyze
  - screen-profile
vars:
  screenId: profile
  title: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetsJsonPath: .stitch/designs/profile/widgets.jsonl
---

# Analyze: Profile

Analyze the screen widget and identify extractable widget regions.

## Input
- `lib/screens/profile/profile_screen.dart` — The screen widget file

## Task

Read the screen file and identify widget subtrees that should be extracted into separate widget files.

Write `.stitch/designs/profile/widgets.jsonl` with one JSON object per line (JSONL format):

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

- `.stitch/designs/profile/widgets.jsonl` exists with valid JSONL
- Each entry has: name, grep, description, shared
- Widget names use PascalCase
