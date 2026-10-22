# API reference — development snapshot

These declarations are extracted from the current source wrappers. They are
not a frozen release contract. Named option types are re-exported by
`package:ares_word/ares_word.dart`. The final narrowed API and complete dartdoc
site must be validated against the protected candidate before release.

## Domain SDK

```dart
AresWordSdk({required super.licenceKey, super.verifyLicence});

Future<AresWordCommentsSnapshot> inspectComments(String path);

Future<List<AresWordComment>> comments(String path);

Future<AresWordCommentCreationResult> addComment(
    String path, {
    required int sectionIndex,
    required String text,
    required String author,
    String? initials,
    int? startOffset,
    int? endOffset,
    DateTime? date,
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> replaceCommentText(
    String path,
    String id,
    String text, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> removeComment(
    String path,
    String id, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentThreadsSnapshot> inspectCommentThreads(
    String path,
  );

Future<AresWordCommentOperationResult> replyToComment(
    String path,
    String parentId, {
    required String text,
    required String author,
    String? initials,
    DateTime? date,
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> setCommentThreadResolved(
    String path,
    String rootCommentId, {
    required bool resolved,
    String? expectedSourceFingerprint,
  });

Future<List<AresWordBookmark>> bookmarks(String path);

Future<AresOfficePageOperationResult> addBookmark(
    String path, {
    required int sectionIndex,
    required String name,
    int? startOffset,
    int? endOffset,
    String? expectedSourceFingerprint,
  });

Future<AresOfficePageOperationResult> renameBookmark(
    String path, {
    required String name,
    required String newName,
    String? expectedSourceFingerprint,
  });

Future<AresOfficePageOperationResult> removeBookmark(
    String path,
    String name, {
    String? expectedSourceFingerprint,
  });

Future<List<AresWordRevision>> revisions(String path);

Future<AresOfficePageOperationResult> reviewRevision(
    String path,
    AresWordRevision revision,
    AresWordRevisionDecision decision, {
    String? expectedSourceFingerprint,
  });

Future<AresOfficeScanGenerationResult?> scanToFile({
    required BuildContext context,
    required String outputPath,
    String? edgeSdkLicenceKey,
    bool isPro = false,
    AresWordScanner? scanner,
    AresOfficePageRecognizer? recognizePages,
  });
```

## Common file and generation operations

The domain class fixes the product; do not construct or use a generic core SDK
to bypass product restrictions. `generateDocument` consumes already recognized
pages; it does not invoke the camera. `scanToFile` performs the complete workflow.

```dart
AresDomainSdk({
    required this.product,
    required this.licenceKey,
    this.verifyLicence,
  });

Future<AresOfficeDocument> createFromTemplate({
    required String templatePath,
    required String outputPath,
    bool overwrite = false,
  });

Future<AresOfficeSaveResult> saveAsTemplate({
    required AresOfficeEditSession session,
    required String outputPath,
    bool overwrite = false,
  });

Future<void> authorize();

Future<AresOfficeDocument> load(String path);

Future<AresDomainEditSession> edit(AresOfficeDocument document);

Future<AresOfficeSaveResult> save(
    AresOfficeEditSession session, {
    String? outputPath,
    bool overwrite = false,
  });

Future<AresOfficeScanGenerationResult> generateDocument({
    required String outputPath,
    required AresOfficeScanTemplate template,
    required List<AresOfficeRecognizedPage> pages,
    AresWordDocumentSettings wordSettings = const AresWordDocumentSettings(),
    AresWordFormOutput? formOutput,
    List<String> formSourcePaths = const [],
  });
```

## Scanner construction

```dart
const AresWordScanner({
    super.key,
    required this.sdk,
    this.edgeSdkLicenceKey,
    this.isPro = false,
    this.scanMode = EdgeDetectionScannerMode.Balanced,
    this.templates,
    this.initialTemplateId,
    this.initialProcessingMode,
    this.initialScanOptions = const {},
    this.onCustomiseTemplates,
    this.onTemplateSelected,
    this.onPickFromGallery,
    this.onUpgrade,
    this.initialWordSettings = const AresWordDocumentSettings(),
    this.initialWordDocumentOutput = AresWordDocumentOutput.editableDocument,
    this.initialNotesSettings = const AresNotesSettings(),
    this.initialHandwritingSettings = const AresHandwritingSettings(),
  });
```

## Editor construction

```dart
const AresWordEditor({
    super.key,
    required this.sdk,
    required this.documentPath,
    this.controller,
    this.viewerConfig = const AresOfficeViewerConfig(),
    this.appBarConfig = const AresOfficeViewerAppBarConfig(),
    this.toolsSheetConfig = const AresOfficeToolsSheetConfig(),
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.autoSaveEnabled = true,
    this.onDocumentReady,
    this.onDocumentModified,
    this.onDocumentSaved,
    this.onError,
    this.onRequestSaveAsPath,
    this.onRequestSaveAsFormatPath,
    this.onRequestPdfExportPath,
    this.onExternalToolAction,
    this.onScanPage,
    this.showProBadge = false,
    this.onUpgrade,
    this.autoSaveIdleDelay = const Duration(milliseconds: 500),
    this.onAutoSaved,
    this.onDocumentImagesExtracted,
    this.onPdfExported,
    this.onDocumentCompressed,
    this.onTextExtracted,
    this.onRequestCompressedCopyPath,
    this.onRequestTextExportPath,
    this.onLoadCustomStamps,
    this.onScanWatermark,
    this.onEmbedVideos,
    this.onEmbedAudio,
  });
```

## Platform contract

`AresOfficePlatforms.editorTargets` and `documentApiTargets` require Android,
iOS, macOS, Windows, Linux and web. These are release requirements, not a list
of already certified builds. `scannerTargets` is Android/iOS only.
`AresOfficePlatforms.canScan` is a lightweight runtime check; it does not grant
a licence or camera permission. `requireScanner()` throws `UnsupportedError`
outside mobile. Import `package:ares_word/platforms.dart` to query this without
loading camera, OCR, editor or filesystem libraries.

## Models and low-level operations

`AresOfficeDocument` contains logical sections and the source fingerprint.
`AresOfficeSaveResult.document` is the reopened saved model. A domain edit session
tracks pending changes and in-session undo/redo; dispose it after use. Its
`undoSaved`/`redoSaved` methods operate on in-place saved history, and require no
pending edits. Saved history is not a durable cross-process recovery journal.

`AresOfficeScanTemplate`, `AresOfficeRecognizedPage` and
`AresOfficeScanGenerationResult` describe generation inputs and verified output.
OOXML operations may return operation-specific snapshots/results. Consult their
restriction/status fields before enabling mutations. Pass
`expectedSourceFingerprint` when a mutation supports it to prevent stale writes.

The current source still broadly exports shared core classes. Those exports are
under a [security boundary review](security-and-assets.md); direct low-level
helpers are not an independent authorization boundary. Customer distribution
requires a narrowed adapter API whose native operations enforce the product.

See [scanning](scanning.md), [editor lifecycle](editor.md) and the compilable
[integration example](../examples/scan_and_edit.dart). Exceptions include
`AresOfficeLicenceException`, invalid-domain/path errors and unsupported package
operations. Preserve the original on a failed edit and present a recoverable error.
