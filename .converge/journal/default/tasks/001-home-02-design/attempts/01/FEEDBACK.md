# FEEDBACK.md — Check Results

**Status**: ❌ 3/4 check(s) failed

- ✅ **design-exists**
- ❌ **meta-exists**
- ❌ **uses-glossary**
- ❌ **has-data-attributes**

## ❌ meta-exists

**Command**: `test -f .stitch/designs/home/META.md`
**Exit code**: 1

## ❌ uses-glossary

**Command**: `grep -q 'class="scaffold"' .stitch/designs/home/design.html`
**Exit code**: 1

## ❌ has-data-attributes

**Command**: `grep -q 'data-color=' .stitch/designs/home/design.html`
**Exit code**: 1
