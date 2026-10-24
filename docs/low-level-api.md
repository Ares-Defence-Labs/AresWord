# Managed document API and ownership

Use `AresWordSdk` for authorization and domain validation around file operations.
`load` produces a document snapshot; `edit` creates an independent mutable session;
`save` writes and reopens an output. Models hold document data rather than an
open OS handle requiring `close()`. Dispose every edit session in `finally`.

```dart
import 'package:ares_word/ares_word.dart';

Future<AresOfficeSaveResult> updateAresWord(
  AresWordSdk sdk, String path, String copyPath,
) async {
  final original = await sdk.load(path);
  final session = await sdk.edit(original);
  try {
    // Use a supported editable fixture containing at least one section.
    session.replaceWordTextRangePreservingRuns(0, 0, 0, 'Hello Word! ');
    return await sdk.save(session, outputPath: copyPath);
  } finally {
    session.dispose();
  }
}
```

## Package input safety

OOXML inputs pass shared ZIP-index checks before package parts are expanded.
The default loader limits are 128 MiB compressed, 256 MiB declared expanded and
10,000 entries. The preflight verifies directory bounds/counts, local-header
name/flags/method/size agreement, payload bounds and non-overlap. It rejects
ambiguous duplicate or case/escaped-alias part names, traversal/control names,
encoded path separators, split volumes, encrypted ZIP entries, ZIP64 metadata
and compression methods other than Stored/Deflate. Proper comment lengths and
streaming-size metadata are accounted for. Unsupported inputs raise
`AresOfficeDocumentException`; a rejected managed import leaves an existing
output unchanged. Editors do not expose the rejected package as ready.

These are parser input checks, not document authenticity or malware detection.
They do not verify decompressed payload CRCs, prove actual expansion bounds for
malicious compressed streams or establish complete OOXML/Office conformance.
Keep host resource limits and original files; show load/import errors before
allowing edits. ZIP-wrapped encryption is rejected; this does not add password
unlocking or encrypted-document authoring. See [compatibility](compatibility.md).

## Snapshots and session state

`session.originalDocument` is the committed base; `session.document` includes
pending edits. Observe the session with ChangeNotifier listeners when building
your own controls. `isDirty`, `canUndo`, `canRedo`, `undo()` and `redo()` describe
unsaved model history. Domain-specific mutations can reject unsupported structures;
catch errors and keep the original rather than flattening it yourself.

`save` snapshots pending changes before awaiting I/O. `markSnapshotSaved` preserves
edits made while that save was running. Serialize your own saves and file mutations;
do not assume concurrent operations are merged. `outputPath` defaults to the
active path; new destinations reject collisions unless `overwrite: true`.
Successful save results contain the reopened `document`; use that current path
and fingerprint for following operations. Template copies use
`sdk.saveAsTemplate` and do not redirect or mark the active session saved.

## Two history scopes

| History | Commands | Scope |
| --- | --- | --- |
| Pending session edits | `undo`, `redo` | In-memory model changes before saving. |
| Completed in-place SDK saves | `undoSaved`, `redoSaved` | Temporary package history for this domain session; requires `isDirty == false`. |

`canUndoSaved` and `canRedoSaved` are false for dirty sessions. Save As changes the
active path and does not transfer old-path history. Session disposal clears
session-owned history; this is not a persisted cross-process recovery journal.
The editor has its own guarded saving/history orchestration.

## Saved-package operations and stale writes

Some operations (for example Word bookmarks/comments/revisions)
write the package immediately and return a committed operation result. Save or
resolve any pending session first. Pass `expectedSourceFingerprint` from the
latest inspected document/snapshot when supported. Fingerprints detect external
changes; they are not signatures or permissions. PowerPoint slide reuse can also
check the source deck with `expectedImportFingerprint`.

After a file-level mutation, dispose the old session and call `sdk.edit(result.document)`
for further editing. Keep only one authoritative workspace for that file. Do not
apply old pending edits over a changed package or reuse a stale comment/revision ID.
`AresOfficeSaveConflictException` and `AresOfficeStorageConflict` require reload
and user reconciliation, not unconditional overwrite/retry.

## Ares annotations and native drawings

All three SDKs expose `readAnnotations(path)` and
`replaceAnnotations(path, annotations:, expectedSourceFingerprint:)`.
Replacement writes the complete Ares annotation list. Retain unchanged records
when modifying one item:

```dart
final source = await sdk.load(path);
final annotations = await sdk.readAnnotations(path);
final saved = await sdk.replaceAnnotations(
  path,
  annotations: annotations.where((item) => item.id != annotationId),
  expectedSourceFingerprint: source.sourceFingerprint,
);
// Reopen saved.document before continuing with a session.
```

The methods enforce the designated product licence and file domain. Native Word
protection reported as read-only by the loaded model rejects replacement; use the
separate native comment/review APIs where those operations are supported.
Replacement supports OOXML files, snapshots nested input data before awaiting authorization,
checks the source fingerprint, and stages editable geometry with supported native
Draw/Ink, watermark, stamp and text-box pictures. Removing a supported overlay
removes its generated picture. Metadata-only changes retain existing pictures.
Word replacement preserves user text sharing a paragraph and permanent redaction
pictures; covered shared-image cases retain their bytes and relationships.

Ares annotations are distinct from native Microsoft comments and revision review.
Redaction records here are metadata; this API does not redact document content or
restore permanently removed content. Retained confirmed-media records keep their
fixed geometry; removing an Ares media record also removes its private resource.

## Managed native pictures and PowerPoint media

`AresWordSdk.insertImage(path, bytes:, fileName:, afterSectionIndex:,
expectedSourceFingerprint:)` inserts a supported raster as a native inline Word
picture and returns `AresOfficeSaveResult`.

`AresPowerPointSdk.insertImage(path, bytes:, fileName:, slideIndex:,
expectedSourceFingerprint:)` returns `(AresOfficeSaveResult, int objectId)`.
`insertAudioObject` additionally requires `iconBytes`; `insertVideoObject`
requires `posterBytes`. Both return `(AresOfficeSaveResult, int objectId,
String relationshipId)`. Preview bytes must be a supported raster. Payloads and
preview images are snapshotted before asynchronous authorization.

These operations stage the complete native picture/media graph, reopen it, then
recheck domain entitlement, source bytes and native Word protection before
replacement. Negative/out-of-range section/slide indexes are rejected. Save pending
session edits first and reopen the committed document afterwards; direct file APIs
do not automatically join another editor's history. Codec conversion is not
provided. Actual playback requires a supported host/runtime codec.

The Word, Excel and PowerPoint editor Image commands now create native pictures; PowerPoint
Audio/Video commands create native media objects. These editor saves use staged
history and bind picker/preparation callbacks to the original document. Native
pickers can supply paths; browser-style selections can supply bytes without a
filesystem path. Add Photos and configured raster annotations remain Ares private
attachments. Multi-attachment host insertion is one staged transaction and one
saved history step; a later item failure preserves the complete original file.

### Excel worksheet pictures

`AresExcelSdk.inspectPictures(path, sheetIndex:)` returns supported pictures,
unsupported picture counts, a protection/graph restriction and a source fingerprint.
`insertImage(path, bytes:, fileName:, sheetIndex:, row:, column:, width:,
height:, offsetX:, offsetY:, expectedSourceFingerprint:)` returns
`(AresOfficeSaveResult, int pictureId)`. `setPictureBounds` updates a supported
picture's cell anchor and dimensions; `deletePicture` removes its anchor and unused
relationship. Both accept `pictureId` and `expectedSourceFingerprint` and return
`AresOfficeSaveResult`. These methods require an OOXML workbook, the Excel licence
and a writable conventional worksheet/drawing graph; CSV/XLS are excluded.

Rows and columns are zero-based in the SDK; the editor dialog uses one-based
labels. Geometry uses 96-dpi pixels, quantized to OOXML EMUs. Insertion accepts
fully decodable PNG/JPEG, up to 32 MiB, 16,384 pixels per raster dimension and
32 million raster pixels. Width/height must be positive; offsets non-negative;
each geometry component is at most 32,768 pixels. Omitted height retains raster
aspect ratio. Picture names are non-empty valid XML text up to 1,024 characters.
A worksheet cell anchor can reach row 1,048,575 and column 16,383.

```dart
final (saved, pictureId) = await sdk.insertImage(
  workbookPath, bytes: pngBytes, fileName: 'Quarterly results',
  sheetIndex: 0, row: 2, column: 1, width: 240,
);
final pictures = await sdk.inspectPictures(workbookPath, sheetIndex: 0);
await sdk.setPictureBounds(
  workbookPath, sheetIndex: 0, pictureId: pictureId,
  row: 3, column: 2, width: 240, height: 160,
  expectedSourceFingerprint: pictures.sourceFingerprint,
);
```

Save pending cell edits before direct file operations and reopen the returned
model afterwards. The editor's Image action and picture selection dialog provide
insertion, cell/offset movement, resizing and deletion with saved undo/redo.
Failed authorization, stale callbacks, unsupported/protected graphs and changed
source bytes preserve the original package. Shared/unknown parts are retained.
Deleting a picture removes media only when no package relationship still needs it;
shared or unfamiliar graphs can retain payload bytes. This is not secure erasure.

The viewer displays plain, untransformed one-cell PNG/JPEG pictures within its
existing 500-row/100-column preview bounds, decoding near the visible viewport.
Pictures outside those bounds are reported, not displayed. Two-cell/absolute
anchors, grouped/cropped/rotated/effected pictures and other unsupported drawing
objects are preserved and reported rather than edited. Sheet protection prevents
picture writes conservatively; full Excel protection semantics, structural
row/column anchor migration, drawing fidelity and Microsoft reference acceptance
remain incomplete. Browser checks cover raw package/IndexedDB behavior, not full
licensed SDK/editor rendering or protected customer artifacts.

These native writers currently cover tested conventional OOXML main/slide graphs; arbitrary
relocated parts, strict/alternate namespaces, full native media semantics and
reference Office rendering/playback remain compatibility work. Browser source
checks do not establish full SDK/editor or protected customer acceptance.

## Ares private attachments

All three SDKs expose `embedMedia`, `confirmMediaPlacement` and
`discardPendingMedia` for OOXML files. `embedMedia` returns a record containing
`(AresOfficeSaveResult, AresOfficeAnnotation)`; use the annotation identifier to
confirm normalized page bounds or cancel pending placement. The methods recheck
the product licence, source fingerprint and native protection before replacement.
Byte payloads and metadata are snapshotted before asynchronous authorization.
Metadata cannot override `mediaPart`, `mimeType`, `pendingPlacement` or `rect`.
Section indexes must identify an existing document section. Confirmed geometry
is fixed; cancellation removes only pending attachments and their private bytes.

With `Rect` from `dart:ui` and host-supplied `Uint8List mediaBytes`:

```dart
final (inserted, attachment) = await sdk.embedMedia(
  path,
  bytes: mediaBytes,
  fileName: 'attachment.bin',
  sectionIndex: 0,
  expectedSourceFingerprint: (await sdk.load(path)).sourceFingerprint,
);
final placed = await sdk.confirmMediaPlacement(
  path,
  attachment.id,
  const Rect.fromLTWH(.1, .1, .4, .3),
  expectedSourceFingerprint: inserted.document.sourceFingerprint,
);
// Reopen placed.document before continuing with an existing session.
// To cancel instead, call discardPendingMedia with the pending source fingerprint.
```

These are Ares private attachments inside an Office package. They do not author
native Microsoft picture/audio/video objects or provide native Office playback.
The editor groups batch insertion and configured placements into saved history;
file methods require reopening an existing session after saving. Source tests use
mock licence verification; they do not certify paid/admin platform acceptance.


Resolve pending session edits first and reopen from `saved.document` afterwards.
These file APIs do not automatically join an existing session's saved history.
The supplied editor records annotation-sheet changes in its own saved undo/redo.
Sidecar formats remain outside managed annotation replacement and atomic package
history. Platform and protected-release acceptance remain separate gates.

## Formats and coordinates

Word sections in the logical model are content blocks such as paragraphs and tables. They are not guaranteed to be printed pages or Word section-break boundaries.

Word text selections use UTF-16 code-unit offsets with an end position. These are positions in supported paragraph text, not glyph coordinates or printed pages. Bookmark locations outside supported main-story blocks may have null indices/offsets.

The exported declarations in [API types](api-types.md) include helper APIs for
advanced source integrations. Their visibility does not certify production
protection or support for every imported structure. [Domain recipes](document-authoring.md)
show supported entry points and boundaries.
