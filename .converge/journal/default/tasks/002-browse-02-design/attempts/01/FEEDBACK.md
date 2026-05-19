# FEEDBACK.md — Check Results

**Status**: ❌ 4/4 check(s) failed

- ❌ **design-exists**
- ❌ **meta-exists**
- ❌ **uses-glossary**
- ❌ **has-data-attributes**

## ❌ design-exists

**Command**: `test -f .stitch/designs/browse/design.html`
**Exit code**: 1

## ❌ meta-exists

**Command**: `test -f .stitch/designs/browse/META.md`
**Exit code**: 1

## ❌ uses-glossary

**Command**: `grep -q 'class="scaffold"' .stitch/designs/browse/design.html`
**Exit code**: 2
**Output**:
```
grep: .stitch/designs/browse/design.html: No such file or directory
```

## ❌ has-data-attributes

**Command**: `grep -q 'data-color=' .stitch/designs/browse/design.html`
**Exit code**: 2
**Output**:
```
grep: .stitch/designs/browse/design.html: No such file or directory
```
