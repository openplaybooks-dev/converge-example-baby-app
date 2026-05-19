# FEEDBACK.md — Check Results

**Status**: ❌ 4/5 check(s) failed

- ✅ **meta-md-exists**
- ❌ **single-screen-exists**
- ❌ **multi-state-exists**
- ❌ **celebration-exists**
- ❌ **html-has-tokens**

## ❌ single-screen-exists

**Command**: `test -f .stitch/system/single-screen.html`
**Exit code**: 1

## ❌ multi-state-exists

**Command**: `test -f .stitch/system/multi-state-screen.html`
**Exit code**: 1

## ❌ celebration-exists

**Command**: `test -f .stitch/system/celebration-screen.html`
**Exit code**: 1

## ❌ html-has-tokens

**Command**: `grep -q ':root' .stitch/system/single-screen.html`
**Exit code**: 2
**Output**:
```
grep: .stitch/system/single-screen.html: No such file or directory
```
