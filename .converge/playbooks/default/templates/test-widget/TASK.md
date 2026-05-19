---
title: "Test: {{title}}"
description: "Widget smoke test for {{widgetName}}Screen"
skill: flutter-testing-apps
blocking: true
tags:
  - test
  - widget
  - screen-{{screenId}}
vars:
  screenId:
  title:
  route:
  widgetName:
  snakeName:
  screenPath:
  testPath:
inputs:
  - "{{screenPath}}"
outputs:
  - "{{testPath}}"
checks:
  - id: test-file-exists
    cmd: "test -f {{testPath}}"
    description: Widget test file exists
  - id: test-passes
    cmd: "flutter test --no-pub --reporter=compact {{testPath}}"
    description: Test passes against the real screen widget
---

# Widget Test: {{title}}

Generate a Flutter widget smoke test for `{{widgetName}}Screen`. The test must:

1. Pump the screen inside a `ProviderScope` and a minimal `MaterialApp.router` (or a stand-in `MaterialApp` with `home:` set to the screen) so Riverpod providers and GoRouter contexts resolve.
2. Assert the screen renders without throwing.
3. Use `expect(find.byType({{widgetName}}Screen), findsOneWidget)` as the primary assertion.
4. Run `await tester.pumpAndSettle()` to drain animations and futures.

## Output template

Write `{{testPath}}` along these lines, adapting imports to whatever the screen actually depends on:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/screens/{{snakeName}}/{{snakeName}}_screen.dart';

void main() {
  testWidgets('{{widgetName}}Screen renders without errors', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: {{widgetName}}Screen(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType({{widgetName}}Screen), findsOneWidget);
  });
}
```

## Rules

- Use only widgets and providers that actually exist in `{{screenPath}}` — read the screen file before writing the test.
- If the screen requires mock provider overrides, declare them inside the `ProviderScope`'s `overrides:` list.
- No network calls; if the screen fetches data, override the relevant provider with a synchronous mock.
- Run the test once before declaring done.
