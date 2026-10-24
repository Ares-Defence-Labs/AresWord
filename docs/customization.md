# Configure the AresWord workspace

Pass Flutter `ThemeData`, `darkTheme` and `themeMode` to `AresWordEditor`. The
editor defaults to `ThemeMode.system`. Themes style the workspace; they do not
reformat document contents or promise replacement of every native dialog.
See [complete host example](../examples/editor_host.dart).

## Configuration objects

| Configuration | Fields and defaults | Meaning |
| --- | --- | --- |
| `AresOfficeViewerConfig` | `initialSectionIndex: 0`, `initialZoom: 1`, `minimumZoom: 0.75`, `maximumZoom: 4` | Initial navigation and bounded zoom. Minimum must be ≥0.25, maximum ≤8 and initial value within bounds. |
| Viewer policy | `allowEditing: true`, `allowCopy: true`, `authorizeAction` | Host UI policy checked for relevant actions; cannot grant SDK product authorization. |
| Viewer layout | `showBottomNavigation: true`, `padding: EdgeInsets.only(bottom: 24)` | Workspace navigation and inset. |
| Reviewer metadata | `commentAuthorName: ''` | Initial Word/PowerPoint comment author, editable in the dialog; not authenticated identity. |
| Host integrations | `photoTextRecognizer`, `supportedExternalTools: {}` | Explicit host OCR and external ribbon commands. |
| `AresOfficeViewerAppBarConfig` | Optional `title`; back/search/tools enabled | Controls the supplied app bar. |
| `AresOfficeToolsSheetConfig` | Optional header, feature booleans and `customTools` | Selects actions visible in the tools sheet. |

The tools sheet has flags for save copy, share, print, PDF export, read aloud,
info, extracted images, annotations, compression, extracted text and security
info. Custom tool items use `AresOfficeToolConfig(label:, icon:, isPro:)` and
need a host external-tool handler. UI visibility and `isPro` are not security gates.
A visible tool does not establish lossless format support. Hide actions your host
cannot service. [Callback contract](host-callbacks.md)

## Controller

Retain one `AresOfficeViewerController` in the host State and dispose it with that
State. Do not create a new controller on every build. Listen with ChangeNotifier
or a ListenableBuilder; remove separately registered listeners when finished.

| State or command | Behavior |
| --- | --- |
| `document`, `isReady`, `sectionCount` | Current loaded snapshot and readiness; may be empty during load/detach. |
| `goToSection`, `nextSection`, `previousSection` | Zero-based logical section navigation, clamped to the current document. |
| `setZoom`, `zoomIn`, `zoomOut`, `resetZoom` | Controller clamp is 0.25..8; editor configuration may impose a narrower display range. |
| `search`, `clearSearch`, result navigation | Case-insensitive logical text search with section/UTF-16 positions; not OCR or rendered-glyph search. |
| `toggleBookmark`, `clearBookmarks`, `bookmarkedSections` | In-memory navigation bookmarks only. They do not write native Word bookmark ranges. |
| `reload` | Requests a workspace reload generation; does not save pending edits. Resolve unsaved work before external mutations/reload. |

Search uses literal, case-insensitive Unicode matching against original section
text. Result `start`/`length` are UTF-16 offsets in that original text; previews
retain complete surrogate pairs at their edges. Results support next/previous
navigation and recompute when a document attaches. Locale-specific Office word
matching, grapheme-aware preview truncation, whole-word options and searching
rendered glyphs or every related story remain separate parity work.

Commands update controller state before attachment; the editor applies relevant
state as it becomes ready. Calling a controller command is not a save-completion
signal. Do not call internal attach/detach helpers from a host application.
