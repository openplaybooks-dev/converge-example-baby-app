# Plan: Analyze: Article Reader



Now I have a clear understanding of the code structure and existing patterns. Let me analyze the ArticleReaderScreen for extractable widget regions.

Based on my analysis of the 531-line file, I can identify these widget regions that meet the extraction criteria (15+ lines, self-contained visual blocks, reusable potential):

**Candidate 1: Quote/Callout Block** (~22 lines each, appears twice)
- Lines 224-247 and 306-329
- Identical styling: left border accent, italic text, tertiaryContainer background
- Strong reusable candidate since it appears twice with same structure

**Candidate 2: `_buildBulletItem` method** (~30 lines)
- Lines 369-399
- Self-contained bullet point with colored dot and text
- Reusable across screens with similar list patterns

**Candidate 3: `_RelatedArticleCard` class** (~115 lines)
- Lines 402-517
- Self-contained card with icon, title, read time, and animations
- Reusable for article recommendation sections

---

### Implementation Plan

Create `.stitch/designs/article-reader/widgets.jsonl` with the following 3 entries:

```jsonl
{"name": "QuoteCallout", "grep": "\"Pairing iron-rich foods\"", "description": "Styled callout block with left border accent and italic text for quotes and tips", "shared": true}
{"name": "BulletItem", "grep": "_buildBulletItem", "description": "Bulleted list item with colored dot indicator and text content", "shared": true}
{"name": "RelatedArticleCard", "grep": "class _RelatedArticleCard", "description": "Card displaying related article with background icon, title, and read time badge", "shared": true}
```

---

### Critical Files for Implementation

1. **`lib/screens/article_reader/article_reader_screen.dart`** — Source file containing the widget regions to extract
2. **`.stitch/designs/article-reader/widgets.jsonl`** — Output file to create with the widget definitions
3. **`.stitch/designs/education/widgets.jsonl`** — Reference for similar extraction pattern in the same app
4. **`lib/widgets/`** — Target directory where extracted widget files will be placed (following existing conventions)
5. **`lib/screens/article_reader/`** — Directory containing the source screen for reference during extraction