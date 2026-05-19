# Needs: 004-profile-02-design

## Description

Generate constrained HTML design for Profile using Flutter HTML Glossary

## Inputs

- `.stitch/designs/profile/SPEC.md`
- `.stitch/system/DESIGN.md`
- `.stitch/system/META.md`

## Expected Outputs

- `.stitch/designs/profile/META.md`
- `.stitch/designs/profile/design.html`

## Checks

- **design-exists**: design.html exists for profile
- **meta-exists**: META.md exists for profile
- **uses-glossary**: HTML uses Flutter HTML Glossary vocabulary
- **has-data-attributes**: HTML uses data-* attributes for Flutter conversion
