# API reference — development snapshot

These declarations are extracted from the current source wrappers. They are
not a frozen release contract. Named option types are re-exported by
`package:ares_word/ares_word.dart`. The final narrowed API and complete dartdoc
site must be validated against the protected candidate before release.

## Domain SDK

```dart
AresWordSdk({required super.licenceKey, super.verifyLicence});

Future<AresWordDocumentLayout> loadLayout(String path);

Future<AresOfficeSaveResult> insertImage(
    String path, {
    required Uint8List bytes,
    required String fileName,
    required int afterSectionIndex,
    String? expectedSourceFingerprint,
  });

Future<AresWordPicturesSnapshot> inspectPictures(String path);

Future<AresOfficeSaveResult> replacePicture(
    String path, {
    required int pictureId,
    required Uint8List bytes,
    String? expectedSourceFingerprint,
  });

Future<AresOfficeSaveResult> setPictureMetadata(
    String path, {
    required int pictureId,
    String? name,
    String? title,
    String? description,
    String? expectedSourceFingerprint,
  });

Future<AresOfficeSaveResult> setPictureSize(
    String path, {
    required int pictureId,
    required double widthPoints,
    required double heightPoints,
    bool lockAspectRatio = true,
    String? expectedSourceFingerprint,
  });

Future<AresOfficeSaveResult> deletePicture(
    String path, {
    required int pictureId,
    String? expectedSourceFingerprint,
  });

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

Future<AresWordCommentCreationResult> addCommentThread(
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

Future<AresWordCommentOperationResult> migrateLegacyComments(
    String path, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> replaceCommentText(
    String path,
    String id,
    String text, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> removeAllLegacyComments(
    String path, {
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

Future<AresWordCommentOperationResult> replaceThreadCommentText(
    String path,
    String id,
    String text, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> removeCommentReply(
    String path,
    String commentId, {
    String? expectedSourceFingerprint,
  });

Future<AresWordCommentOperationResult> removeCommentThread(
    String path,
    String rootCommentId, {
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
    int? endSectionIndex,
    String? expectedSourceFingerprint,
  });

Future<AresOfficePageOperationResult> redefineBookmark(
    String path, {
    required String name,
    required int sectionIndex,
    int? startOffset,
    int? endOffset,
    int? endSectionIndex,
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

Future<AresOfficePageOperationResult> reviewRevisions(
    String path,
    List<AresWordRevision> revisions,
    AresWordRevisionDecision decision, {
    String? expectedSourceFingerprint,
  });

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

Future<List<AresOfficeAnnotation>> readAnnotations(String path);

Future<AresOfficeSaveResult> replaceAnnotations(
    String path, {
    required Iterable<AresOfficeAnnotation> annotations,
    String? expectedSourceFingerprint,
  });

Future<(AresOfficeSaveResult, AresOfficeAnnotation)> embedMedia(
    String path, {
    required Uint8List bytes,
    required String fileName,
    required int sectionIndex,
    Rect? initialRect,
    Map<String, Object?> metadata = const {},
    String? expectedSourceFingerprint,
  });

Future<AresOfficeSaveResult> confirmMediaPlacement(
    String path,
    String id,
    Rect rect, {
    String? expectedSourceFingerprint,
  });

Future<AresOfficeSaveResult> discardPendingMedia(
    String path,
    String id, {
    String? expectedSourceFingerprint,
  });

Future<AresOfficeDocument> loadBytes({
    required String name,
    required List<int> bytes,
    String? path,
    bool overwrite = false,
  });

Future<Uint8List> exportBytes(String path);

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


## Domain edit-session signatures

Selected inherited session declarations relevant to this product; operations still enforce format and structure limits. See [full exported declarations](api-types.md) for helper/model types.

```dart
AresOfficeDocument get originalDocument;
AresOfficeDocument get document;
bool get isDirty;
bool get canUndo;
bool get canRedo;
List<({int sectionIndex, AresWordFormField field})> get wordFormFieldLocations;
List<AresWordFormField> get wordFormFields;
void setWordHeaderFooter(AresWordHeaderFooterKind kind, {AresWordHeaderFooterVariant variant = AresWordHeaderFooterVariant.defaultPages, String? text, AresWordPageNumberAlignment? textAlignment, bool? textBold, bool? textItalic, bool? textUnderline, double? textFontSize, bool? pageNumber, AresWordPageNumberAlignment pageNumberAlignment = AresWordPageNumberAlignment.center, AresWordPageNumberFormat? pageNumberFormat, int? pageNumberStart});
void setWordPageNumbers({required bool enabled, AresWordHeaderFooterKind? kind, AresWordPageNumberAlignment alignment = AresWordPageNumberAlignment.center, AresWordPageNumberFormat? format, int? start});
void setWordFormValue(int sectionIndex, String id, String value, {bool? checked});
void clearWordContentControls(int sectionIndex);
void flattenWordContentControls(int sectionIndex);
void updateWordFormField(int sectionIndex, AresWordFormField field);
void deleteWordFormField(int sectionIndex, String id);
AresWordFormField duplicateWordFormField(int sectionIndex, AresWordFormField field);
void setWordFormTabOrder(List<String> ids);
void replaceSectionText(int sectionIndex, String text);
void replaceWordTextRange(int sectionIndex, int start, int end, String replacement);
void replaceWordTextRangePreservingRuns(int sectionIndex, int start, int end, String replacement);
void replaceWordTextRangeWithFormatting(int sectionIndex, int start, int end, String replacement, AresOfficeFormatChange style);
void insertWordParagraph(int afterIndex, String text);
void insertWordReferenceParagraph(int afterIndex, {required String title, required String text, String? fieldInstruction, String prefix = '', String suffix = '', bool superscript = false});
void insertWordContentControl(int afterIndex, AresWordContentControlType type, {required String label, List<String> options = const <String>[]});
void insertWordFormField(int afterIndex, AresWordFormField field);
void insertWordBreak(int afterIndex, AresWordBreakType type);
void insertWordPageBreakAtTextRange(int sectionIndex, int start, int end);
void insertWordHyperlink(int afterIndex, String text, String address);
({String text, String address})? wordHyperlinkAt(int sectionIndex);
void updateWordHyperlink(int sectionIndex, String text, String address);
void removeWordHyperlink(int sectionIndex);
void insertWordTable(int afterIndex, int rows, int columns);
void editWordTableAxis(int sectionIndex, int index, {required bool column, required bool insert});
void resizeWordTable(int sectionIndex, int rows, int columns);
void sortWordTable(int sectionIndex, {required List<AresWordTableSortKey> keys, int headerRows = 1});
void setWordTableCell(int sectionIndex, int row, int column, String value, {int? fillColorArgb, String? verticalAlignment, String? textDirection, String? tableLayout, String? borderPreset, double? cellMarginPoints, double? columnWidthPoints, double? rowHeightPoints, String? rowHeightRule, bool? repeatHeaderRow, bool? preventRowSplit});
void applyWordTableStylePreset(int sectionIndex, AresWordTableStylePreset preset);
void mergeWordTableCells(int sectionIndex, String range, {bool split = false});
void deleteWordBlock(int index);
void moveWordBlock(int index, int destination);
void formatWordTextRange(int sectionIndex, int start, int end, AresOfficeFormatChange style);
void clearWordTextRangeFormatting(int sectionIndex, int start, int end);
void clearWordParagraphFormatting(int sectionIndex);
void mergeWordParagraphWithNext(int index);
void splitWordParagraph(int index, int offset);
void replaceWordTextRangeWithParagraphs(int index, int start, int end, String replacement);
bool wordParagraphHasListFormatting(int index);
int? wordParagraphListLevel(int index);
double? wordParagraphLeftIndentPoints(int index);
String? wordParagraphListKind(int index);
String wordParagraphStyleId(int index);
void setWordParagraphStyle(int index, String styleId);
void exitWordList(int index);
void setWordListKind(int index, String? kind);
void adjustWordListLevel(int index, int delta);
void applyTransitionToAll(int sectionIndex);
void setSpeakerNotes(int sectionIndex, String text);
void renameSection(int sectionIndex, String title);
void applyFormatting(AresOfficeFormatChange change);
AresOfficeFormatChange formattingFor({required int sectionIndex, int? row, int? column});
int replaceAll(String query, String replacement, {bool matchCase = false, bool wholeWords = false, bool includePresentationNotes = false});
int redactAll(String query, {String replacement = '[REDACTED]', bool matchCase = false, bool wholeWords = false, bool includePresentationNotes = false});
void securelyRedactWordSection(int sectionIndex);
void undo();
void redo();
void refreshPackageMetadata(AresOfficeDocument refreshed);
void markSaved(AresOfficeDocument savedDocument);
void markSnapshotSaved(AresOfficeDocument savedDocument, AresOfficeDocument savedSnapshot);
void reset();
```

Saved-session history extensions (inherited by the domain alias):

```dart
final AresDomainSdk sdk;
bool get canUndoSaved;
bool get canRedoSaved;
Future<bool> undoSaved();
Future<bool> redoSaved();
void dispose();
void markSaved(AresOfficeDocument savedDocument);
void refreshPackageMetadata(AresOfficeDocument refreshed);
void markSnapshotSaved(AresOfficeDocument savedDocument, AresOfficeDocument savedSnapshot);
```
