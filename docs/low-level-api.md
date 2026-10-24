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

## Portable typed layouts

`AresWordSdk.loadLayout(String path)` returns `AresWordDocumentLayout` from a native path
or a public `AresOfficeStorage` handle. It checks the designated product licence
before storage access and again before releasing the result. A host callback
returning true cannot authorize an unsigned or wrong-product token.

```dart
import 'package:ares_word/ares_word.dart';
import 'package:ares_word/storage.dart';

Future<AresWordDocumentLayout> readImportedLayout(
  AresWordSdk sdk, List<int> bytes, {String? nativePath}
) async {
  // Native hosts supply an absolute writable path; web can omit it.
  final handle = await AresOfficeStorage.importBytes(
    name: 'document.docx', bytes: bytes, path: nativePath,
  );
  // A persisted browser handle is restored automatically when necessary.
  return sdk.loadLayout(handle);
}
```

[Complete typed-layout example](../examples/typed_layout.dart).

Only this domain's native OOXML document/template/macro-enabled formats are
accepted; legacy binary formats and Word text/RTF are outside this reader.
Macros are not executed. Save pending editor changes before requesting a saved
layout. The result describes one owned byte snapshot, not a live file view or
a guarantee that the file stays unchanged after reading it. Reading does not
write the package. Do not treat a layout as an editable managed session.

Acquisition checks the compressed size and bounds the stream to the limit plus
one detection byte. The same snapshot passes the ZIP-index limits below and is
parsed without re-reading the path. Malformed XML or missing main parts raise
`AresOfficeDocumentException`, retaining the cause for diagnostics. A licence revoked at the final check prevents returning the
layout. Native source fixtures cover denial, revocation, format/corrupt-package
errors and source replacement. Browser fixtures cover unsigned-token denial
before IO and restored-storage parsing; issued customer/admin activation and
protected all-platform acceptance remain release gates.

Raw parser `parseBytes(Uint8List)` copies its input before awaiting and applies
the same ZIP-index limits. Raw parser helpers do not authorize processing and
are not the customer licence boundary. Layout fidelity retains the documented
feature limits; this reader does not establish full Microsoft Office parity.

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

`AresWordSdk.inspectPictures(path)` returns supported main-story inline rasters,
protection/identity restrictions, unsupported drawing counts and a fingerprint.
Pictures expose `id`, `name`, `title`, `description`, `widthPoints`, `heightPoints`
and bytes. `replacePicture(path, pictureId:, bytes:, expectedSourceFingerprint:)`,
`setPictureMetadata(path, pictureId:, name:, title:, description:,
expectedSourceFingerprint:)` and `deletePicture(path, pictureId:,
expectedSourceFingerprint:)` use the licensed staged-save contract. Replacement
retains identity/frame/metadata and isolates shared image data; deletion retains
surrounding text, bookmarks and paragraph/run structure. Null metadata stays;
empty title/description clears it. Invalid XML/Unicode and reserved managed-image
markers refuse. Save/reopen other active sessions around direct file APIs.

`setPictureSize(path, pictureId:, widthPoints:, heightPoints:,
lockAspectRatio: true, expectedSourceFingerprint:)` updates both native extents
in points, retaining bytes/metadata and writing graphic-frame/picture aspect locks.
Locked dimensions must retain the existing ratio within EMU rounding; explicit
`false` permits stretch. Native resize locks, ambiguous/inconsistent geometry,
rotation/flip/nonzero offsets and positioned paragraph frames refuse resizing.
Dimensions must be finite, positive, at least one EMU and at most 16,384 points
per axis (an implementation guard, not a Microsoft limit).

The Word editor's Insert → Pictures route exposes these operations with saved
history, native/bytes-only picker support and original-document guards. Picture
size provides paired point dimensions and an explicit aspect-lock checkbox.
Normal/live inline previews follow saved dimensions, including explicit stretch;
malformed imported dimensions fall back safely. Description,
then title, then name supplies the accessible image label. Preview binds each
picture to its own drawing frame, including multiple pictures in one text run,
and recognizes native image namespace aliases. Floating/VML authoring, other
stories, strict/relocated graphs, controls/historical/alternate drawings and full
image/layout parity remain unfinished. Ares drawing/redaction/photo-text resources
use their existing editors. Original image parts/relationships are retained:
replacement/deletion is not secure erasure or document redaction.

`AresPowerPointSdk.insertImage(path, bytes:, fileName:, slideIndex:,
expectedSourceFingerprint:)` returns `(AresOfficeSaveResult, int objectId)`.
`insertAudioObject` additionally requires `iconBytes`; `insertVideoObject`
requires `posterBytes`. Both return `(AresOfficeSaveResult, int objectId,
String relationshipId)`. Preview bytes must be a supported raster. Payloads and
preview images are snapshotted before asynchronous authorization.

`AresPowerPointSdk.replacePicture(path, bytes:, fileName:, slideIndex:, objectId:,
clearCrop: false, expectedSourceFingerprint:)` returns `AresOfficeSaveResult`.
It retains native identity, name, frame, rotation and formatting; cropping remains
unless explicitly cleared. A fresh image relationship/part isolates shared media.
Old image bytes remain in the package, so replacement is not secure erasure.
Imported image labels prefer description, then title, then native name. The
accessibility audit still requests a meaningful description when one is missing;
a display fallback does not clear that warning. Native decorative pictures
expose `AresPresentationImage.decorative` and are excluded from spoken content,
including their fallback label. Clearing the native flag restores the label;
ordinary object selection/editing metadata remains available.
PNG/JPEG/GIF/BMP/WebP native writes now validate decodable frames under declared
raster limits: 32 MiB encoded bytes, 16,384 pixels per axis, 1,024 frames and
32 million canvas pixels times frame count. PNG/GIF rectangles and WebP frame
bitstream dimensions are checked before frame decode. This does not sanitize
images, bound every decoder working allocation/inflation, isolate processing or
validate every imported image during rendering. Strict/relocated/escaped slide
graphs and complete imported picture fidelity still require broader coverage.

`AresPowerPointSdk.compressPicture(path, slideIndex:, objectId:, pixelsPerInch:,
applyCropToRaster: false, expectedSourceFingerprint:)` returns
`AresOfficeSaveResult`. Supported resolutions are 96, 150, 220 and 330 PPI.
Resampling uses the selected picture's native slide extent and does not upscale.
Applying the crop affects the replacement raster and clears its crop metadata;
original media remains retained. This is not secure erasure or document redaction.
The SDK stages, reopens and rechecks the save; separately held sessions must be
saved/reopened. Declared raster/frame budgets also apply to the original compression image;
decoder isolation, actual bounded inflation and imported graph fidelity remain open.

Word insertion without explicit internal size overrides now uses the encoded
raster dimensions at the existing 96-dpi assumption and fits within the existing
page limits without upscaling. PowerPoint insertion uses encoded aspect for all
five supported raster formats, including JPEG/WebP. EXIF orientation and physical
DPI normalization remain separate compatibility work; original payload bytes
are retained.

These operations stage the complete native picture/media graph, reopen it, then
recheck domain entitlement, source bytes and native Word protection before
replacement. Negative/out-of-range section/slide indexes are rejected. Save pending
session edits first and reopen the committed document afterwards; direct file APIs
do not automatically join another editor's history. Codec conversion is not
provided. Actual playback requires a supported host/runtime codec.

The Word, Excel and PowerPoint editor Image commands now create native pictures; PowerPoint
Audio/Video commands create native media objects. PowerPoint Replace picture
uses the same guarded transaction and saved undo/redo, including byte-only
selections. These editor saves use staged
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

`setPictureMetadata(path, sheetIndex:, pictureId:, name:, title:, description:,
expectedSourceFingerprint:)` updates the selected native picture's name and
alternative text without replacing its raster, relationship or geometry.
`inspectPictures` exposes `name`, `title` and `description`. Null properties remain
unchanged; empty title/description clears that attribute. A supplied name must
contain non-whitespace text. Invalid XML characters and unpaired UTF-16 surrogates
are rejected. All-null updates are rejected. These saves use the same licensed,
protected-source and staged conflict checks as the other picture operations.

The editor's Alternative text dialog edits these properties with saved undo/redo.
The picture's accessible label uses its description, then title, then native name.
Decorative flags, reading order and complete Microsoft accessibility remain open.

`replacePicture(path, sheetIndex:, pictureId:, bytes:,
expectedSourceFingerprint:)` replaces the PNG/JPEG payload of a supported picture
and returns `AresOfficeSaveResult`. It retains native identity, name/title/description,
cell anchor and pixel geometry, including when the new raster has a different
aspect ratio. It creates an independent image part/relationship, preserving other
pictures or package owners that share the old payload. Unreferenced old media may
be pruned; shared/unfamiliar graphs retain bytes. This is not secure erasure.
Caller bytes are copied before asynchronous authorization. The same decoding,
protection, source-conflict and product checks apply as for insertion.

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
insertion, cell/offset movement, resizing, replacement and deletion with saved
undo/redo. Replace image changes only the saved picture payload; use Apply to save
position/size field edits. Native and bytes-only selections work; cancelling leaves
the workbook unchanged.
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
