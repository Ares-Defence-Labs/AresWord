# Native Word table sorting

AresWord's source SDK and editor can sort simple native tables by one to three
columns using text, number or explicitly formatted Gregorian dates. This is a
defined subset of Microsoft Word sorting; language-specific collation,
locale date inference, delimited fields and complete imported-table
support remain open.

```dart
final session = await sdk.edit(await sdk.load(path));
try {
  session.sortWordTable(tableSectionIndex,
    headerRows: 1,
    keys: const [
      AresWordTableSortKey(0),
      AresWordTableSortKey(1, type: AresWordTableSortType.number,
        descending: true),
    ],
  );
  await sdk.save(session);
} finally {
  session.dispose();
}
```

`tableSectionIndex` identifies a Word table block, not a rendered page. Columns
are zero-based logical grid indices. Inspect the document first. The operation
flushes supported pending cell text/formatting to native XML, then moves complete
native rows. Cell runs, row/cell properties and relationship IDs travel with the
row; cells are not flattened to newly generated text. It is one undo step.
An unchanged row order does not create a new history entry or discard pending
formatting. Source conflict, native package validation, entitlement checks and
storage writes continue through the managed SDK save path.

## Ordering rules

- Tables must be rectangular and contain at most 1,000 cells, including headers.
  Select one to three distinct, valid columns. The SDK can retain any valid
  number of leading header rows; the editor offers one header row or none.
- Text keys trim surrounding whitespace and use ordinal comparison; default
  comparison lowercases keys, with optional case sensitivity. This is not a
  language-aware Word collation implementation. Stored cell text is unchanged.
- Number keys require finite plain floating-point values or blank cells.
  Decimal/scientific forms use binary64 precision consistently on native/web;
  currency symbols, grouping separators and locale guesses are rejected.
- Date keys use `AresWordTableSortType.date` and the key's `dateFormat`:
  `AresWordTableDateFormat.yearMonthDay` (default, exactly `YYYY-MM-DD`),
  `dayMonthYear` (`D/M/YYYY`) or `monthDayYear` (`M/D/YYYY`). Slash formats
  accept one or two digits for day/month; years always have four ASCII digits,
  0001–9999. Surrounding whitespace is trimmed. Gregorian leap-year and month
  lengths are validated before sorting. Invalid dates reject the whole operation
  without modifying the session. No timezone, two-digit year, month-name,
  timestamp, separator or locale inference is performed. `1/2/2024` means
  1 February in day/month mode and 2 January in month/day mode. All nonblank
  values in a date key must match the same chosen format. Stored text remains
  unchanged. The implementation compares calendar components, independent of
  device timezone/DST and native/web timestamp normalization.
- Blank keys stay after nonblank keys in either direction. When a key ties,
  subsequent keys decide order. Rows equal across all keys retain their original
  order, including descending sorts. Leading header rows stay in place.
- Repeated-header flags are retained; moving such a row rejects rather than
  silently changing its repeated-header semantics.

For a date column:

```dart
session.sortWordTable(tableSectionIndex, keys: const [
  AresWordTableSortKey(0, type: AresWordTableSortType.date,
    dateFormat: AresWordTableDateFormat.dayMonthYear),
]);
```

## Native structure and preservation

Recognized merges, nested tables, row/cell wrappers, fields, tracked changes,
bookmarks/range permissions, comment/move/custom-XML range markers, proofing range
markers and section properties inside the table reject the operation. Ambiguous
duplicate properties, foreign direct row structures and invalid permutations
also reject before replacement. Unsupported metadata outside the inspected block
and full complex-story/protection/reference semantics still require broader
acceptance. This is not a complete Word range/field rewriting implementation.

`AresWordTableSorting.order(cells, keys:, headerRows:)` is a pure helper returning
an owned immutable row-index permutation. `reorder(tableXml, order)` copies whole
native rows into their row slots; the original string is never modified. It
supports native Transitional/Strict WordprocessingML namespace aliases without
creating new XML names. Raw strict-namespace reorder tests do not establish
complete Strict DOCX managed authoring or reference fidelity. The caller of raw
helpers owns matching the matrix to its XML/table and the surrounding document
context. Pure helpers do not read/write files or independently activate a licence.

## Editor

Place the cursor in the table, then choose **Layout → Sort table**. Choose the
column, Text/Number/Date and Ascending/Descending for each level. **Add sort level**
adds another distinct column, up to three. Date keys expose their own calendar
format selector; choose the format that matches that column. Case-sensitive text and first-header
options apply to the captured table. The dialog scrolls on narrow displays.
The ribbon action is unavailable for non-table/read-only/oversized selections.
Cancel leaves the document alone. Host edit permission is checked before opening
and again before applying. Reloading/changing the captured document or target
section while the dialog or authorization is pending rejects stale application.
Existing native saving and saved undo/redo remain available afterward.

## Evidence and remaining work

Validation uses synthetic native packages and source widgets with mocked licence
verification or a raw browser loader. It does not establish issued customer/admin
activation, production protected delivery, Microsoft-reference or six-platform
acceptance. Locale-aware dates and language sorting, advanced field/reference updates,
merged/nested tables, richer selection/sort options and broader preservation and
accessibility verification remain open. The SDK/editor target remains Android,
iOS, macOS, Windows, Linux and web; scanner capture remains native Android/iOS.
Windows runtime testing remains owner-deferred. No publishing/deployment.

[Microsoft's sorting workflow](https://support.microsoft.com/en-us/word/sort-the-contents-of-a-table)
provides the feature baseline; it is not an executed reference-build receipt.
