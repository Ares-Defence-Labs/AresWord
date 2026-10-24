# Word content, layout and formatting

Use `AresWordSdk` and the session returned by `sdk.edit`. The native DOCX model
retains package structure for supported edits; it is not a flat text editor with
a guarantee that all imported Word content can be changed losslessly.

## Paragraphs and rich text

`replaceWordTextRangePreservingRuns` changes supported paragraph text while
retaining unaffected runs. `formatWordTextRange` applies a character style to a
UTF-16 selection. `replaceSectionText` replaces the whole logical section; choose
that only when whole-block replacement is intended. `insertWordParagraph`,
`splitWordParagraph`, `mergeWordParagraphWithNext`, `moveWordBlock` and
`deleteWordBlock` manage supported content blocks. Re-read indices after inserts.

`AresOfficeFormatChange` separates text properties (font family/size, bold,
italic, underline, strike, superscript/subscript, font/fill colors) from paragraph
properties. Use `setWordParagraphStyle`, list-kind/level operations, tab stops
and paragraph formatting only where the native block supports them. A formatting
change is not proof that every Word layout rule is rendered identically.

## Tables, layout and forms

| Workflow | Session operations | Limits |
| --- | --- | --- |
| Tables | `insertWordTable`, `setWordTableCell`, resize/axis/style/merge operations | Validate dimensions; unsupported merged/linked structures can reject edits. |
| Breaks | `insertWordBreak`, `insertWordPageBreakAtTextRange` | Logical sections are not rendered pages. |
| Headers/footers | `setWordHeaderFooter`, `setWordPageNumbers` | Supported native variants; complex section/pagination parity remains open. |
| Links | Insert/update/remove Word hyperlinks | Link text and address are document data; host must handle unsafe targets. |
| Forms | Insert/update/duplicate/delete form fields, values and tab order | Supported native controls only; not every Word automation/control type. |

[Compilable authoring recipe](../examples/document_workflows.dart) inserts a
paragraph and table, formats a text range and saves a reopened document. It
requires a known editable first paragraph. Adapt indices and format choices to
the inspected model. See [session ownership](low-level-api.md),
[exported model members](api-types.md) and [compatibility](compatibility.md).

## Scan to Word

The Word scanner recognizes text and structured regions, then reviews a Word
reconstruction/template before DOCX creation. Its preview text is read-only;
edit the created file in `AresWordEditor`. Document, form, notes and handwriting
modes have different output settings and recognition limits. Camera capture is
Android/iOS only. [Scanner guide](scanning.md)
