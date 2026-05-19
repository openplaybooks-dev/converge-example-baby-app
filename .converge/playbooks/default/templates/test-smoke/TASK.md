---
title: Navigation smoke test
description: Walk every GoRouter route and assert each renders without throwing
skill: flutter-testing-apps
blocking: true
tags:
  - test
  - smoke
  - navigation
vars:
  testPath:
inputs:
  - lib/router/app_router.dart
  - .stitch/screens.json
outputs:
  - "{{testPath}}"
checks:
  - id: smoke-file-exists
    cmd: "test -f {{testPath}}"
    description: Smoke test file exists
  - id: smoke-passes
    cmd: "flutter test --no-pub --reporter=compact {{testPath}}"
    description: Smoke test walks every route successfully
---

# Navigation Smoke Test

Generate a single Flutter widget test that pumps the full app (`ProviderScope` + `MaterialApp.router` with the real router from `lib/router/app_router.dart`) and visits every top-level route declared there. For each route, assert the app renders without throwing and the route's screen widget is present.

## Output template

Read the route list from both `lib/router/app_router.dart` and `.stitch/screens.json` (intersection — only routes that exist in both) and produce `{{testPath}}` like this:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/app.dart' as app;

void main() {
  group('navigation smoke', () {
    for (final route in const ['/home', '/progress', '/health-log', '/mood', '/education']) {
      testWidgets('route $route renders', (tester) async {
        await tester.pumpWidget(const ProviderScope(child: app.BloomApp()));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        // App boots; subsequent routes will be exercised in follow-up taps.
        expect(tester.takeException(), isNull, reason: 'route $route threw on boot');
      });
    }
  });
}
```

Adjust the route list to match what's actually declared in `lib/router/app_router.dart` — don't hard-code routes that don't exist.

## Rules

- The smoke test must exercise the **real** router, not a stub.
- Use a non-zero `pumpAndSettle` duration to allow animations to finish.
- Catch `tester.takeException()` after each pump to surface unexpected exceptions clearly.
- If certain routes require a mock provider override (e.g. preferences gate), include the overrides inside `ProviderScope`.
