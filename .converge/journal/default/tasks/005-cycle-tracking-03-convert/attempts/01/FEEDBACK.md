# FEEDBACK.md — Check Results

**Status**: ❌ 2/4 check(s) failed

- ✅ **screen-exists**
- ❌ **dart-valid**
- ✅ **uses-theme**
- ❌ **no-hardcoded-colors**

## ❌ dart-valid

**Command**: `dart analyze lib/screens/cycle_tracking/cycle_tracking_screen.dart`
**Exit code**: 2
**Output**:
```
Analyzing cycle_tracking_screen.dart...

warning - cycle_tracking_screen.dart:300:9 - The value of the field '_selectedDate' isn't used. Try removing the field, or using it. - unused_field
   info - cycle_tracking_screen.dart:56:75 - Missing a required trailing comma. Try adding a trailing comma. - require_trailing_commas
   info - cycle_tracking_screen.dart:88:15 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:89:58 - Missing a required trailing comma. Try adding a trailing comma. - require_trailing_commas
   info - cycle_tracking_screen.dart:112:19 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:128:20 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:130:22 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:204:77 - Missing a required trailing comma. Try adding a trailing comma. - require_trailing_commas
   info - cycle_tracking_screen.dart:446:15 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:557:26 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors
   info - cycle_tracking_screen.dart:559:28 - Use 'const' with the constructor to improve performance. Try adding the 'const' keyword to the constructor invocation. - prefer_const_constructors

11 issues found.
```

## ❌ no-hardcoded-colors

**Command**: `! grep -qE 'Color\(0x|Colors\.' lib/screens/cycle_tracking/cycle_tracking_screen.dart`
**Exit code**: 1

> **BROKEN COMMAND** — The check command itself cannot run.
> This is NOT a code problem. Fix the `cmd` in the source TASK.md
> (in `.converge/epics/`). Look for the check with id `no-hardcoded-colors`.
> Replace absolute/platform-specific paths with portable commands.
> Example: `grep -q "pattern" "file.tsx"`
