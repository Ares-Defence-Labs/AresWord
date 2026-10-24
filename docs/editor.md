# Embedded editor

The editor must support **Android, iOS, macOS, Windows, Linux and web**, with
the same document features and file round-trip behavior. The low-level document
API has the same six-platform requirement. Only scanning is restricted to mobile.
The source integration includes desktop files and browser IndexedDB/byte adapters.
All three full SDK imports compile for web and pass synthetic browser API
round trips. This does not certify protected customer packages or full Microsoft
feature parity. See [storage](storage.md) and [platforms](platforms.md).
Windows runtime acceptance is tracked in [Windows validation](windows-validation.md).

Landscape layouts expose Undo and Redo in the document bar. They restore saved
package history as well as pending edits, respect read-only/host policy and are
disabled while a file operation is busy. Compact bars place fit/zoom actions in
a Zoom menu to keep history controls usable without overflowing.

`AresWordEditor(sdk: sdk, documentPath: path)` embeds the domain editor and its
editing controls. It checks the SDK licence and the document domain before
loading. Use an absolute native path, or a virtual path returned by browser storage.
Import browser picker bytes with `sdk.loadBytes`; export with `sdk.exportBytes`.

Pass an `AresOfficeViewerController` to observe readiness and the current
document. The lifecycle callbacks are `onDocumentReady`, `onDocumentModified`,
`onDocumentSaved`, `onAutoSaved` and `onError`. Keep error handling visible to the
host; do not discard an unsaved edit after an error.

Autosave defaults to enabled with a 500 ms idle delay. Set `autoSaveEnabled:
false` when your host manages explicit saves. Autosave is not a crash-recovery
guarantee. Use the Save As callbacks to supply a writable destination; the editor
does not grant your app filesystem access. Save-as-format, PDF export, compression,
text export and media actions have separate host callbacks and format limits.

`viewerConfig`, `appBarConfig`, `toolsSheetConfig`, themes and `themeMode`
configure the UI. Host actions such as `onScanPage`, `onLoadCustomStamps`,
`onEmbedVideos` and `onEmbedAudio` require host integrations. A visible action or
callback does not mean every Microsoft feature is implemented.

Use the same SDK configuration for scanner, loader, writer and editor. Customer
examples must not inject a mock verifier or owner mode. See [API declarations](api-reference.md)
for constructor options and [compatibility limits](compatibility.md).

## Word native pictures

Insert → Pictures manages supported main-story inline rasters. Replace image,
Picture size, Alternative text and Delete picture use guarded staged saves and
saved undo/redo. Picture size uses point dimensions and a proportional lock;
unlocking explicitly permits stretch. Normal/live inline previews use the saved
size. Native resize locks and unsupported transforms/positioned frames refuse.
Names/title/description are native metadata; accessible labels prefer description,
then title, then name. Replacement preserves frame and shared resources; deletion
preserves surrounding text/bookmarks. Old media remains retained. Managed Ares
ink/redaction/photo-text resources use their own editors. Floating/VML, controls,
historical/alternate content and other stories are not handled by this route.
See [native picture APIs and limits](low-level-api.md#managed-native-pictures-and-powerpoint-media).
