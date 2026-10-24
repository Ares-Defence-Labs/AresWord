# First AresWord integration

## Install the reviewed distribution

The proposed package is `ares_word` with canonical import
`package:ares_word/ares_word.dart`. No approved installable customer version is available
in this documentation checkout. Do not add this repo as a Git dependency or copy
the disabled [pubspec blueprint](../packaging/pubspec.yaml) into an application.
Use the released hosted version and reviewed setup instructions when available.

Construct one domain SDK with a valid customer token from private build/runtime
configuration. No Office trial behavior is promised. Missing, invalid, expired or
wrong-product licences reject managed operations. Read [licensing](licensing.md)
for mobile identity-bound and desktop/web customer-wide grant support.

```dart
final sdk = AresWordSdk(
  licenceKey: const String.fromEnvironment('ARES_OFFICE_LICENCE'),
);
```

## Open and edit an existing document

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

Use an actual native `.docx` fixture supported by the requested operation. The
example does not create an empty file or guarantee arbitrary imports can be edited.
Save to a new path to preserve the original. Return values describe reopened
outputs; handle exceptions before reporting a successful save.

## Import picker bytes

`await sdk.loadBytes(name: 'example.docx', bytes: pickedBytes, path: destination)`
validates the bytes and persists them. Native hosts must supply an absolute,
writable destination. Browser hosts omit `path` to get a virtual IndexedDB path.
Open the returned `document.path`; use `sdk.exportBytes` for download/sharing.
The host owns picker UI, download and permissions. [Storage](storage.md)

## Embed the editor

```dart
AresWordEditor(
  sdk: sdk,
  documentPath: document.path,
  onDocumentSaved: (saved) { /* update the host with saved.document */ },
  onError: (error) { /* show an actionable error; retain unsaved work */ },
)
```

`sdk` and `document` above are host-owned initialized values. See the
[complete editor example](../examples/editor_host.dart), [customization](customization.md)
and [callback guide](host-callbacks.md). Keep the editor mounted until its save
completes; programmatic route disposal is not an automatic save guarantee.
Delayed saves, package operations and saved undo/redo remain bound to their
starting document and history. If the host switches files or reloads while a write runs, its result
cannot replace the newly displayed document or invoke current-document save/
modification callbacks. Saved undo/redo recheck that source after authorization
and loading before accessing history. An authorized write may still finish for its original
file; switching is not cancellation or persistent crash recovery.
For DOCX, XLSX and PPTX, the Draw/Ink Save action stages native pictures and
editable geometry together before replacing the original package. It rechecks
product entitlement, host edit policy and source content before replacement;
failed preparation preserves the saved file and pending drawing. Saved undo/redo
restore both package bytes and annotation geometry. Repeated saves replace generated
pictures in all three formats; native replacement can also clear an empty drawing
set. Excel/PowerPoint replacement retains unrelated objects and shared image media.
Switching files during preparation prevents the old drawing from committing or
updating the new view.
Legacy Word overlay conversion follows the same guarded, undoable path; read-only
or policy-denied views preserve the original file. Drawing controls adapt to
narrow screens and enlarged text.

The annotation sheet's add/delete operations and shared decoration commits now
use the same staged package/history path. Native drawing deletion removes the
picture as well as editable geometry. Note prompts and annotation-sheet actions
retain their originating file; read-only and denied actions preserve saved bytes.

Ares photo and attachment insertion batches, confirmation and cancellation use staged
package writes and saved undo/redo. Placement callbacks retain their source;
read-only views disable placement controls. Picker and configuration flows check
the originating file before insertion. Sidecar formats do not have atomic package
history. These checks
do not certify complete Microsoft Office ink compatibility, native-process file
locking, persistent crash recovery or protected customer artifact acceptance.

## Add mobile scanning

On Android/iOS call `sdk.scanToFile(context: context, outputPath: newPath)`.
Cancellation returns `null`; success includes a verified `document` and `path`.
Only then open the editor. Hide scanning outside mobile using
`AresOfficePlatforms.canScan`. Follow [mobile setup](platforms.md) and the
[scan-and-edit example](../examples/scan_and_edit.dart).
