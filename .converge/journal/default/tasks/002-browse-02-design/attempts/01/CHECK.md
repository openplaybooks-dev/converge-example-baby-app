# Checks: 002-browse-02-design

All checks must pass for this task to be considered complete.
Run each command from the project root. Fix failures and re-run.

## design-exists
**Description**: design.html exists for browse
**Command**: `test -f .stitch/designs/browse/design.html`

## meta-exists
**Description**: META.md exists for browse
**Command**: `test -f .stitch/designs/browse/META.md`

## uses-glossary
**Description**: HTML uses Flutter HTML Glossary vocabulary
**Command**: `grep -q 'class="scaffold"' .stitch/designs/browse/design.html`

## has-data-attributes
**Description**: HTML uses data-* attributes for Flutter conversion
**Command**: `grep -q 'data-color=' .stitch/designs/browse/design.html`