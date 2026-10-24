# AresWord host callbacks and I/O

Your app owns destinations, pickers and external services. The SDK owns supported
document transformations. No callback can replace mandatory licence verification.
Returning `null` from a destination/picker callback cancels that request; handle
host exceptions and preserve pending work. Do not log document text or licence keys.

## Lifecycle notifications

| Callback | Payload | Use |
| --- | --- | --- |
| `onDocumentReady` | `AresOfficeDocument` | Loaded and parsed workspace; update host title/navigation. |
| `onDocumentModified` | None | Pending document change; not persisted yet. |
| `onDocumentSaved` | `AresOfficeSaveResult` | Successful explicit save with reopened document. |
| `onAutoSaved` | `AresOfficeSaveResult` | Successful autosave; default idle delay 500ms. |
| `onError` | `Object` | Recoverable editor load/action/save error; keep unsaved-work UI visible. |

Initial product rejection is displayed by the licensed surface itself before the
editor loads; do not assume every authorization failure reaches `onError`.
Autosave is not a crash-recovery service. `autoSaveEnabled: false` lets your host
choose explicit saves. Await external file writes and keep the workspace alive.

## Host requests and output notifications

| Input callback | Return | Host responsibility |
| --- | --- | --- |
| `onRequestSaveAsPath` | Future nullable path | Choose a native or workspace destination for a copy. |
| `onRequestSaveAsFormatPath` | Future nullable path | Choose a destination using the requested format descriptor. |
| `onRequestPdfExportPath` | Future nullable path | Choose a PDF export destination; export fidelity is bounded. |
| `onRequestCompressedCopyPath` | Future nullable path | Choose a separate compressed-copy path. |
| `onRequestTextExportPath` | Future nullable path | Choose a text-output destination. |
| `onExternalToolAction` | Handler for `AresOfficeExternalToolAction` | Implement only commands declared in `supportedExternalTools`. |
| `onScanPage` | Future nullable `AresOfficeScanResult` | Mobile-only host capture flow; SDK hides scanner actions outside mobile. |
| `onLoadCustomStamps` | Future list of stamps | Supply host-managed stamp assets. |
| `onScanWatermark` | Future nullable stamp | Host watermark creation; camera capture remains mobile-only. |
| `onEmbedVideos` | Future nullable list of paths | Select compatible video files; host owns storage/codec policy. |
| `onEmbedAudio` | Future nullable path | Select a compatible audio file. |


`onDocumentImagesExtracted`, `onPdfExported`, `onDocumentCompressed` and
`onTextExtracted` report completed supported outputs. `onUpgrade` is host purchase
UI, and `showProBadge` is presentation only. They cannot authorize a document API.

External action payloads carry the mode/label, document type/path, current section,
selected text/sections and optional insert-image/insert-text commands. Use only
provided commands for the current workspace; do not retain them after the editor
is disposed or replace a package file underneath pending edits. External actions
are extension requests, not proof that the SDK implements the named feature.

## Paths, bytes and limits

Native destinations must be host-selected writable paths. Browser destinations
are virtual origin-local paths; do not return a host disk path or URL. Browser
picker/download bytes go through `sdk.loadBytes`/`sdk.exportBytes`. Current byte
import is bounded at 128MiB; memory usage and renderer limits can be lower for a
complex document. See [storage](storage.md) and [web integration](web.md).

See [constructor declarations](api-reference.md) for exact callback types and
[exported models](api-types.md) for output payloads. A nullable callback is not a
promise that the editor automatically implements a picker for every platform.
