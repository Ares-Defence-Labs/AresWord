# Exported type and member reference

Exported named classes, enums, typedefs and named extensions; declaration/member signatures only; conditional export union; inherited members listed on their declaring type; internal-annotated members omitted. Top-level functions, variables and unnamed extensions are outside this inventory. Not a frozen protected-customer API.

This is generated from the current canonical full import, not a hand-written claim that every helper is a stable customer API. Declaration origins identify libraries; they do not expose private paths or method bodies. Conditional storage implementations are listed as a union. Inherited declarations are listed on the declaring type. Domain aliases inherit session methods even when the session class is not exported by name. The final narrowed customer API remains a release gate.

Use [SDK constructors and operations](api-reference.md), [managed lifecycle](low-level-api.md) and [domain recipes](document-authoring.md) alongside this reference.

**172 named exported declarations.** Machine-readable: [API inventory](api-inventory.json).

## AresDomainSdk

`package:ares_office_core/src/sdk/ares_domain_sdk.dart`

```dart
class AresDomainSdk
AresDomainSdk({required this.product, required this.licenceKey, this.verifyLicence});
final AresOfficeProduct product;
final String licenceKey;
final AresOfficeLicenceVerifier? verifyLicence;
AresOfficeDocumentType get documentType;
AresOfficeScannerFormat get scannerFormat;
Set<String> get extensions;
String get outputExtension;
Future<AresOfficeDocument> createFromTemplate({required String templatePath, required String outputPath, bool overwrite = false});
Future<AresOfficeSaveResult> saveAsTemplate({required AresOfficeEditSession session, required String outputPath, bool overwrite = false});
Future<void> authorize();
void requirePath(String path);
void requireDocument(AresOfficeDocument document);
void requireOutputPath(String path);
void requireTemplate(AresOfficeScanTemplate template);
List<AresOfficeScanTemplate> get templates;
AresDomainDocumentLoader get loader;
AresDomainDocumentWriter get writer;
Future<AresOfficeDocument> load(String path);
Future<List<AresOfficeAnnotation>> readAnnotations(String path);
Future<AresOfficeSaveResult> replaceAnnotations(String path, {required Iterable<AresOfficeAnnotation> annotations, String? expectedSourceFingerprint});
Future<(AresOfficeSaveResult, AresOfficeAnnotation)> embedMedia(String path, {required Uint8List bytes, required String fileName, required int sectionIndex, Rect? initialRect, Map<String, Object?> metadata = const {}, String? expectedSourceFingerprint});
Future<AresOfficeSaveResult> confirmMediaPlacement(String path, String id, Rect rect, {String? expectedSourceFingerprint});
Future<AresOfficeSaveResult> discardPendingMedia(String path, String id, {String? expectedSourceFingerprint});
Future<AresOfficeDocument> loadBytes({required String name, required List<int> bytes, String? path, bool overwrite = false});
Future<Uint8List> exportBytes(String path);
Future<AresDomainEditSession> edit(AresOfficeDocument document);
Future<AresOfficeSaveResult> save(AresOfficeEditSession session, {String? outputPath, bool overwrite = false});
Future<AresOfficeScanGenerationResult> generateDocument({required String outputPath, required AresOfficeScanTemplate template, required List<AresOfficeRecognizedPage> pages, AresWordDocumentSettings wordSettings = const AresWordDocumentSettings(), AresWordFormOutput? formOutput, List<String> formSourcePaths = const []});
```

## AresExcelHyperlinkOperationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresExcelHyperlinkOperationResult extends AresOfficePageOperationResult
const AresExcelHyperlinkOperationResult({required super.document, required super.activeIndex, required this.reference, required this.snapshot});
final String reference;
final AresExcelHyperlinksSnapshot snapshot;
```

## AresExcelNoteOperationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresExcelNoteOperationResult extends AresOfficePageOperationResult
const AresExcelNoteOperationResult({required super.document, required super.activeIndex, required this.address, required this.snapshot});
final String address;
final AresExcelNotesSnapshot snapshot;
```

## AresHandwritingBlock

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresHandwritingBlock
const AresHandwritingBlock({required this.text, this.kind = AresHandwritingBlockKind.text, this.bounds = Rect.zero, this.revised, this.comment = '', this.reviewed = false});
final String text;
final AresHandwritingBlockKind kind;
final Rect bounds;
final String? revised;
final String comment;
final bool reviewed;
AresHandwritingBlock copyWith({String? text, AresHandwritingBlockKind? kind, String? revised, String? comment, bool? reviewed});
```

## AresHandwritingBlockKind

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresHandwritingBlockKind { text, equation, checklist, table, diagram, change }
```

## AresHandwritingOutput

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresHandwritingOutput { editableText, searchable, math, edits, structured }
```

## AresHandwritingOutputDetails

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
extension AresHandwritingOutputDetails on AresHandwritingOutput
String get label;
String get description;
List<String> get templates;
```

## AresHandwritingPage

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresHandwritingPage
const AresHandwritingPage({required this.settings, required this.blocks});
final AresHandwritingSettings settings;
final List<AresHandwritingBlock> blocks;
```

## AresHandwritingSettings

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresHandwritingSettings
const AresHandwritingSettings({this.output = AresHandwritingOutput.editableText, this.templateName = 'Simple document', this.language = 'Latin', this.includeSourceImages = true, this.convertCheckboxes = true});
final AresHandwritingOutput output;
final String templateName, language;
final bool includeSourceImages, convertCheckboxes;
AresHandwritingSettings copyWith({AresHandwritingOutput? output, String? templateName, String? language, bool? includeSourceImages, bool? convertCheckboxes});
```

## AresNotesAction

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresNotesAction
const AresNotesAction({required this.title, this.owner = '', this.dueAt, this.remindAt});
final String title;
final String owner;
final DateTime? dueAt;
final DateTime? remindAt;
```

## AresNotesOutput

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresNotesOutput { meeting, study, clean, actionPlan }
```

## AresNotesOutputDetails

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
extension AresNotesOutputDetails on AresNotesOutput
String get label;
String get description;
List<String> get templates;
```

## AresNotesSettings

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresNotesSettings
const AresNotesSettings({this.output = AresNotesOutput.meeting, this.templateName = 'Modern notes', this.understanding = AresNotesUnderstanding.structured, this.includeSourceImages = true, this.createJobs = false, this.scheduleReminders = false, this.reminderDaysBefore = 1});
final AresNotesOutput output;
final String templateName;
final AresNotesUnderstanding understanding;
final bool includeSourceImages;
final bool createJobs;
final bool scheduleReminders;
final int reminderDaysBefore;
AresNotesSettings copyWith({AresNotesOutput? output, String? templateName, AresNotesUnderstanding? understanding, bool? includeSourceImages, bool? createJobs, bool? scheduleReminders, int? reminderDaysBefore});
```

## AresNotesUnderstanding

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresNotesUnderstanding { light, structured, detailed }
```

## AresOfficeAnnotation

`package:ares_office_core/src/office_annotations.dart`

```dart
class AresOfficeAnnotation
const AresOfficeAnnotation({required this.id, required this.type, required this.sectionIndex, required this.created, this.text, this.author, this.start, this.end, this.colorValue, this.modified, this.data = const <String, Object?>{}});
final String id;
final AresOfficeAnnotationType type;
final int sectionIndex;
final DateTime created;
final String? text;
final String? author;
final int? start;
final int? end;
final int? colorValue;
final DateTime? modified;
final Map<String, Object?> data;
Map<String, Object?> toJson();
factory AresOfficeAnnotation.fromJson(Map<String, Object?> json);
```

## AresOfficeAnnotationStore

`package:ares_office_core/src/office_annotations.dart`

```dart
class AresOfficeAnnotationStore
const AresOfficeAnnotationStore();
Future<List<AresOfficeAnnotation>> load(String documentPath);
Future<void> save(String documentPath, Iterable<AresOfficeAnnotation> annotations);
Future<AresOfficeAnnotation> embedMedia(String documentPath, {required Uint8List bytes, required String fileName, required int sectionIndex, Rect? initialRect, Map<String, Object?> metadata = const <String, Object?>{}});
Future<List<PdfBoundMedia>> loadMedia(String documentPath);
static Rect mediaRect(AresOfficeAnnotation annotation);
Future<void> confirmMediaPlacement(String documentPath, String id, Rect rect);
Future<void> discardPendingMedia(String documentPath, String id);
```

## AresOfficeAnnotationType

`package:ares_office_core/src/office_annotations.dart`

```dart
enum AresOfficeAnnotationType { comment, highlight, underline, strikeout, link, stamp, drawing, redaction, attachment }
```

## AresOfficeCellBorders

`package:ares_office_core/src/office_document.dart`

```dart
enum AresOfficeCellBorders { none, all, bottom }
```

## AresOfficeChartInsertion

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeChartInsertion
const AresOfficeChartInsertion({required this.id, required this.sectionIndex, required this.range, required this.title, this.line = false, required this.fromRow, required this.fromColumn});
final String id;
final int sectionIndex;
final String range;
final String title;
final bool line;
final int fromRow;
final int fromColumn;
```

## AresOfficeCompressionResult

`package:ares_office_core/src/office_service_utilities.dart`

```dart
class AresOfficeCompressionResult
const AresOfficeCompressionResult({required this.path, required this.originalBytes, required this.compressedBytes});
final String path;
final int originalBytes;
final int compressedBytes;
double get ratio;
```

## AresOfficeDisplayMode

`package:ares_office_core/src/office_editor_modes.dart`

```dart
enum AresOfficeDisplayMode { singleSection, continuous, twoPage, horizontal, grid }
```

## AresOfficeDocument

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeDocument
const AresOfficeDocument({required this.path, required this.type, required this.sections, this.metadata = const AresOfficeDocumentMetadata(), this.formatChanges = const <AresOfficeFormatChange>[], this.sourceFingerprint, this.nativeEditingRestricted = false, this.slideWidthEmu, this.slideHeightEmu, this.date1904 = false, this.definedNames = const <AresExcelDefinedName>[], this.customShows = const <AresPresentationCustomShow>[], this.showSettings = const AresPresentationShowSettings(), this.slideSections = const <AresPresentationSlideSection>[], this.presentationPartChanges = const <AresPresentationPartChange>[], this.presentationThemeChanges = const <AresPresentationThemeChange>[], this.slideChartChanges = const <AresSlideChartChange>[], this.chartInsertions = const <AresOfficeChartInsertion>[], this.wordHeaderFooterChanges = const <AresWordHeaderFooterChange>[]});
final int? slideWidthEmu, slideHeightEmu;
final String path;
final AresOfficeDocumentType type;
final List<AresOfficeDocumentSection> sections;
final AresOfficeDocumentMetadata metadata;
final List<AresOfficeFormatChange> formatChanges;
final String? sourceFingerprint;
final bool nativeEditingRestricted;
final bool date1904;
final List<AresExcelDefinedName> definedNames;
final List<AresPresentationCustomShow> customShows;
final AresPresentationShowSettings showSettings;
final List<AresPresentationSlideSection> slideSections;
final List<AresPresentationPartChange> presentationPartChanges;
final List<AresPresentationThemeChange> presentationThemeChanges;
final List<AresSlideChartChange> slideChartChanges;
final List<AresOfficeChartInsertion> chartInsertions;
final List<AresWordHeaderFooterChange> wordHeaderFooterChanges;
String get text;
AresOfficeDocument copyWith({String? path, AresOfficeDocumentType? type, List<AresOfficeDocumentSection>? sections, AresOfficeDocumentMetadata? metadata, List<AresOfficeFormatChange>? formatChanges, String? sourceFingerprint, bool? nativeEditingRestricted, int? slideWidthEmu, int? slideHeightEmu, bool? date1904, List<AresExcelDefinedName>? definedNames, List<AresPresentationCustomShow>? customShows, AresPresentationShowSettings? showSettings, List<AresPresentationSlideSection>? slideSections, List<AresPresentationPartChange>? presentationPartChanges, List<AresPresentationThemeChange>? presentationThemeChanges, List<AresSlideChartChange>? slideChartChanges, List<AresOfficeChartInsertion>? chartInsertions, List<AresWordHeaderFooterChange>? wordHeaderFooterChanges});
```

## AresOfficeDocumentException

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeDocumentException implements Exception
const AresOfficeDocumentException(this.message, {this.cause});
final String message;
final Object? cause;
String toString();
```

## AresOfficeDocumentMetadata

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeDocumentMetadata
const AresOfficeDocumentMetadata({this.title, this.subject, this.creator, this.lastModifiedBy, this.description, this.keywords, this.category, this.application, this.company, this.created, this.modified, this.pageCount, this.wordCount, this.slideCount});
final String? title;
final String? subject;
final String? creator;
final String? lastModifiedBy;
final String? description;
final String? keywords;
final String? category;
final String? application;
final String? company;
final DateTime? created;
final DateTime? modified;
final int? pageCount;
final int? wordCount;
final int? slideCount;
bool get isEmpty;
```

## AresOfficeDocumentSection

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeDocumentSection
const AresOfficeDocumentSection({required this.index, required this.title, required this.text, this.sourceSectionIndex, this.sourceXml, this.speakerNotes, this.slideLayoutPath, this.slideAudioRelationships = const <String, String>{}, this.isTable = false, this.rowCount, this.columnCount, this.cellValues, this.cellTypes = const <String, String>{}});
final int? sourceSectionIndex;
final String? sourceXml;
final String? speakerNotes;
final String? slideLayoutPath;
final Map<String, String> slideAudioRelationships;
final bool isTable;
final int index;
final String title;
final String text;
final int? rowCount;
final int? columnCount;
final List<List<String>>? cellValues;
final Map<String, String> cellTypes;
List<List<String>> get cells;
AresOfficeDocumentSection copyWith({int? index, int? sourceSectionIndex, String? sourceXml, String? speakerNotes, String? slideLayoutPath, Map<String, String>? slideAudioRelationships, bool? isTable, String? title, String? text, int? rowCount, int? columnCount, List<List<String>>? cellValues, Map<String, String>? cellTypes});
```

## AresOfficeDocumentType

`package:ares_office_core/src/office_document.dart`

```dart
enum AresOfficeDocumentType { word, spreadsheet, presentation, csv, text, markdown, unknown }
```

## AresOfficeEditSession

`package:ares_office_core/src/office_edit_session.dart`

```dart
class AresOfficeEditSession extends ChangeNotifier
AresOfficeEditSession(AresOfficeDocument document);
AresOfficeDocument get originalDocument;
AresOfficeDocument get document;
bool get isDirty;
bool get canUndo;
bool get canRedo;
List<({int sectionIndex, AresWordFormField field})> get wordFormFieldLocations;
List<AresWordFormField> get wordFormFields;
void setWordHeaderFooter(AresWordHeaderFooterKind kind, {AresWordHeaderFooterVariant variant = AresWordHeaderFooterVariant.defaultPages, String? text, AresWordPageNumberAlignment? textAlignment, bool? textBold, bool? textItalic, bool? textUnderline, double? textFontSize, bool? pageNumber, AresWordPageNumberAlignment pageNumberAlignment = AresWordPageNumberAlignment.center, AresWordPageNumberFormat? pageNumberFormat, int? pageNumberStart});
void setWordPageNumbers({required bool enabled, AresWordHeaderFooterKind? kind, AresWordPageNumberAlignment alignment = AresWordPageNumberAlignment.center, AresWordPageNumberFormat? format, int? start});
void editPresentationPart(String path, String sourceXml);
void setPresentationFooters(int index, AresSlideFooter options);
void setSlideTimings(Map<int, int?> timings);
void setCustomShows(List<AresPresentationCustomShow> shows);
void setPresentationShowSettings(AresPresentationShowSettings settings);
void setSlideSections(List<AresPresentationSlideSection> sections);
void setPresentationTheme(String name, Map<String, String> colors, {String? headingFont, String? bodyFont});
void editSlideChart(int index, {String? relationshipId, required String title, required bool line, AresSlideChartKind? kind, int firstSliceAngle = 0, int holeSize = 50, bool showLegend = true, bool? showValues, bool? showPercent, required List<List<String>> rows});
void setSlideSize(int widthEmu, int heightEmu);
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
void toggleWorksheetGridlines(int sectionIndex);
void toggleWorksheetHeadings(int sectionIndex);
void freezeWorksheetPanes(int sectionIndex, {int rows = 0, int columns = 0});
void setWorksheetSize(int sectionIndex, AresSpreadsheetRange range, {double? rowHeight, double? columnWidth});
void autoFitWorksheet(int sectionIndex, AresSpreadsheetRange range, {required bool rows});
void setWorksheetVisibility(int sectionIndex, AresSpreadsheetRange range, {required bool rows, required bool hidden});
void setWorksheetTabColor(int sectionIndex, int argb);
void setDataValidation(int sectionIndex, AresSpreadsheetRange range, AresDataValidation? rule);
void mergeCells(int sectionIndex, AresSpreadsheetRange range, {bool remove = false});
void applyTransitionToAll(int sectionIndex);
int addPresentationFreeform(int sectionIndex, AresFreeformPath path, {String text = '', double x = 72, double y = 72, double width = 240, double height = 180});
void setPresentationFreeform(int sectionIndex, int objectId, AresFreeformPath path);
void movePresentationFreeformHandle(int sectionIndex, int objectId, int vertexIndex, {required bool incoming, required Offset position, AresFreeformHandleConstraint constraint = AresFreeformHandleConstraint.independent});
void splitPresentationFreeformSegment(int sectionIndex, int objectId, int segmentIndex, {double t = .5});
void editPresentationXml(int sectionIndex, String Function(String source) edit, {String? slideLayoutPath});
void updatePresentationOutline(Map<int, Map<int, String>> textBySlide, {Map<int, Map<int, List<int>>> paragraphLevelsBySlide = const <int, Map<int, List<int>>>{}});
void changePresentationTextCase(int sectionIndex, String mode);
void clearPresentationTextFormatting(int sectionIndex);
void setSpeakerNotes(int sectionIndex, String text);
void renameSection(int sectionIndex, String title);
List<List<String>> previewTextToColumns(int sectionIndex, AresSpreadsheetRange range, String delimiter);
void splitTextToColumns(int sectionIndex, AresSpreadsheetRange range, String delimiter, {bool overwrite = false});
void insertWorksheetChart(int sectionIndex, AresSpreadsheetRange range, {required String title, bool line = false, int? fromRow, int? fromColumn});
void setCell({required int sectionIndex, required int row, required int column, required String value});
void setRangeValues({required int sectionIndex, required int row, required int column, required List<List<String>> values});
List<List<String>> rangeValues(int sectionIndex, AresSpreadsheetRange range);
AresSpreadsheetRange currentRegion(int sectionIndex, {required int row, required int column});
void sortRange(int sectionIndex, AresSpreadsheetRange range, {int keyColumn = 0, bool descending = false, bool hasHeader = false});
int removeDuplicateRows(int sectionIndex, AresSpreadsheetRange range, {bool hasHeader = false});
void filterRange(int sectionIndex, AresSpreadsheetRange range, {required int keyColumn, required String value});
void clearFilter(int sectionIndex);
void clearRange(int sectionIndex, AresSpreadsheetRange range);
void fillRange(int sectionIndex, AresSpreadsheetRange range, {bool down = true});
void applyRangeFormatting(int sectionIndex, AresSpreadsheetRange range, AresOfficeFormatChange style);
void applyFormatting(AresOfficeFormatChange change);
AresOfficeFormatChange formattingFor({required int sectionIndex, int? row, int? column});
int replaceAll(String query, String replacement, {bool matchCase = false, bool wholeWords = false, bool includePresentationNotes = false});
int replaceSpreadsheetCells(String query, String replacement, {bool matchCase = false, bool wildcards = false, int? sectionIndex});
int redactAll(String query, {String replacement = '[REDACTED]', bool matchCase = false, bool wholeWords = false, bool includePresentationNotes = false});
void redactRange(int sectionIndex, int start, int end, {String replacement = '[REDACTED]'});
void securelyRedactWordSection(int sectionIndex);
void undo();
void redo();
void refreshPackageMetadata(AresOfficeDocument refreshed);
void markSaved(AresOfficeDocument savedDocument);
void markSnapshotSaved(AresOfficeDocument savedDocument, AresOfficeDocument savedSnapshot);
void reset();
```

## AresOfficeEditorMode

`package:ares_office_core/src/office_editor_modes.dart`

```dart
enum AresOfficeEditorMode { view, page, navigation, ink, draw, edit, text, annotate, fillAndSign, prepareForm, insert, measure, redact, ai, favorites }
```

## AresOfficeEmbeddedImageExtractor

`package:ares_office_core/src/office_embedded_image_extractor.dart`

```dart
class AresOfficeEmbeddedImageExtractor
const AresOfficeEmbeddedImageExtractor({this.maximumCompressedBytes = 128 * 1024 * 1024, this.maximumExpandedBytes = 256 * 1024 * 1024, this.maximumImageBytes = 64 * 1024 * 1024, this.maximumArchiveEntries = 10000});
final int maximumCompressedBytes;
final int maximumExpandedBytes;
final int maximumImageBytes;
final int maximumArchiveEntries;
Future<AresOfficeImageExtractionResult> extract(String documentPath, {String? outputDirectory});
```

## AresOfficeEncryptedDocumentException

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeEncryptedDocumentException extends AresOfficeDocumentException
const AresOfficeEncryptedDocumentException();
```

## AresOfficeExternalToolAction

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeExternalToolAction
const AresOfficeExternalToolAction({required this.mode, required this.label, required this.documentPath, required this.documentType, required this.sectionIndex, this.selectedText, this.selectedSectionIndexes = const <int>[], this.insertImagePath, this.insertImageBytes, this.insertText});
final String mode;
final String label;
final String documentPath;
final AresOfficeDocumentType documentType;
final int sectionIndex;
final String? selectedText;
final List<int> selectedSectionIndexes;
final Future<void> Function(String path)? insertImagePath;
final Future<void> Function(Uint8List bytes)? insertImageBytes;
final Future<void> Function(String text)? insertText;
```

## AresOfficeExternalToolHandler

`package:ares_office_core/src/office_document.dart`

```dart
typedef AresOfficeExternalToolHandler = FutureOr<void> Function(AresOfficeExternalToolAction action);
```

## AresOfficeFormatChange

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeFormatChange
const AresOfficeFormatChange({required this.sectionIndex, this.row, this.column, this.fontFamily, this.fontSize, this.bold, this.italic, this.underline, this.underlineStyle, this.strikethrough, this.textPosition, this.fontColorArgb, this.fillColorArgb, this.alignment, this.wrapText, this.numberFormatCode, this.paragraphStyle, this.listKind, this.spaceBeforePoints, this.spaceAfterPoints, this.lineSpacing, this.leftIndentPoints, this.rightIndentPoints, this.firstLineIndentPoints, this.keepWithNext, this.keepLinesTogether, this.widowOrphanControl, this.pageBreakBefore, this.suppressAutoHyphens, this.contextualSpacing, this.rightToLeft, this.tabStops, this.pageWidthPoints, this.pageHeightPoints, this.pageMarginTopPoints, this.pageMarginRightPoints, this.pageMarginBottomPoints, this.pageMarginLeftPoints, this.pageColumnCount, this.pageColumnSpacingPoints, this.verticalAlignment, this.cellBorders});
final int sectionIndex;
final int? row;
final int? column;
final String? fontFamily;
final double? fontSize;
final bool? bold;
final bool? italic;
final bool? underline;
final String? underlineStyle;
final bool? strikethrough;
final AresOfficeTextPosition? textPosition;
final int? fontColorArgb;
final int? fillColorArgb;
final AresOfficeHorizontalAlignment? alignment;
final bool? wrapText;
final String? numberFormatCode;
final String? paragraphStyle;
final String? listKind;
final double? spaceBeforePoints;
final double? spaceAfterPoints;
final double? lineSpacing;
final double? leftIndentPoints;
final double? rightIndentPoints;
final double? firstLineIndentPoints;
final bool? keepWithNext;
final bool? keepLinesTogether;
final bool? widowOrphanControl;
final bool? pageBreakBefore;
final bool? suppressAutoHyphens;
final bool? contextualSpacing;
final bool? rightToLeft;
final List<AresWordTabStop>? tabStops;
final double? pageWidthPoints;
final double? pageHeightPoints;
final double? pageMarginTopPoints;
final double? pageMarginRightPoints;
final double? pageMarginBottomPoints;
final double? pageMarginLeftPoints;
final int? pageColumnCount;
final double? pageColumnSpacingPoints;
final AresOfficeVerticalAlignment? verticalAlignment;
final AresOfficeCellBorders? cellBorders;
bool get targetsCell;
bool targets({required int sectionIndex, int? row, int? column});
AresOfficeFormatChange at({required int sectionIndex, int? row, int? column});
AresOfficeFormatChange merge(AresOfficeFormatChange other);
```

## AresOfficeGalleryCapture

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeGalleryCapture
const AresOfficeGalleryCapture({required this.bytes, required this.frame});
final Uint8List bytes;
final QuadFrame frame;
```

## AresOfficeGalleryPicker

`package:ares_office_core/src/scanner/ares_office_scanner.dart`

```dart
typedef AresOfficeGalleryPicker = FutureOr<AresOfficeGalleryCapture?> Function();
```

## AresOfficeHorizontalAlignment

`package:ares_office_core/src/office_document.dart`

```dart
enum AresOfficeHorizontalAlignment { left, center, right, justify }
```

## AresOfficeImageExtractionResult

`package:ares_office_core/src/office_embedded_image_extractor.dart`

```dart
class AresOfficeImageExtractionResult
AresOfficeImageExtractionResult({required this.images, required this.outputDirectory, required bool ownsOutputDirectory});
final List<ExtractedOfficeImage> images;
final String outputDirectory;
Future<void> discard();
```

## AresOfficeInteropExporter

`package:ares_office_core/src/office_interop_exporter.dart`

```dart
class AresOfficeInteropExporter
const AresOfficeInteropExporter();
Future<String> export(String sourcePath, {required String outputPath});
```

## AresOfficeLicence

`package:ares_office_core/src/sdk/ares_office_licence.dart`

```dart
class AresOfficeLicence
static Future<bool> verify(AresOfficeProduct product, String licenceKey);
```

## AresOfficeLicenceException

`package:ares_office_core/src/sdk/ares_domain_sdk.dart`

```dart
class AresOfficeLicenceException implements Exception
const AresOfficeLicenceException(this.product);
final AresOfficeProduct product;
String toString();
```

## AresOfficeLicenceVerifier

`package:ares_office_core/src/sdk/ares_domain_sdk.dart`

```dart
typedef AresOfficeLicenceVerifier = FutureOr<bool> Function(AresOfficeProduct product, String licenceKey);
```

## AresOfficeModeAction

`package:ares_office_core/src/office_editor_modes.dart`

```dart
class AresOfficeModeAction
const AresOfficeModeAction({required this.icon, required this.label, this.destructive = false, this.isPro = false});
final IconData icon;
final String label;
final bool destructive;
final bool isPro;
```

## AresOfficeModeDescriptor

`package:ares_office_core/src/office_editor_modes.dart`

```dart
class AresOfficeModeDescriptor
const AresOfficeModeDescriptor({required this.mode, required this.label, required this.icon});
final AresOfficeEditorMode mode;
final String label;
final IconData icon;
```

## AresOfficePackageFormat

`package:ares_office_core/src/office_package_format.dart`

```dart
enum AresOfficePackageFormat { docx, docm, dotx, dotm, xlsx, xlsm, xltx, xltm, pptx, pptm, potx, potm, ppsx, ppsm }
const AresOfficePackageFormat(this.extension, this.documentType, this.label, this.contentType, {this.isTemplate = false, this.supportsMacros = false});
final String extension;
final AresOfficeDocumentType documentType;
final String label;
final String contentType;
final bool isTemplate;
final bool supportsMacros;
String get mainPart;
static AresOfficePackageFormat? forPath(String path);
static List<AresOfficePackageFormat> forDocumentType(AresOfficeDocumentType type);
```

## AresOfficePageFitMode

`package:ares_office_core/src/office_editor_modes.dart`

```dart
enum AresOfficePageFitMode { fitPage, fitWidth, actualSize }
```

## AresOfficePageOperationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresOfficePageOperationResult
const AresOfficePageOperationResult({required this.document, required this.activeIndex});
final AresOfficeDocument document;
final int activeIndex;
```

## AresOfficePageOperations

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresOfficePageOperations
const AresOfficePageOperations({this.loader = const AresOfficeDocumentLoader()});
final AresOfficeDocumentLoader loader;
Future<AresPresentationCommentsSnapshot> presentationComments(String path);
Future<AresPresentationCommentOperationResult> addPresentationComment(String path, {required int slideIndex, required String text, required String author, String initials = '', int x = 0, int y = 0, DateTime? date, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> addPresentationCommentCoordinates(String path, {required int slideIndex, required String text, required String author, String initials = '', String x = '0', String y = '0', DateTime? date, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> replacePresentationCommentText(String path, AresPresentationComment comment, String text, {DateTime? date, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> movePresentationComment(String path, AresPresentationComment comment, {required int x, required int y, DateTime? date, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> movePresentationCommentCoordinates(String path, AresPresentationComment comment, {required String x, required String y, DateTime? date, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> removePresentationSlideComments(String path, {required int slideIndex, String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> removeAllPresentationComments(String path, {String? expectedSourceFingerprint});
Future<AresPresentationCommentOperationResult> removePresentationComment(String path, AresPresentationComment comment, {String? expectedSourceFingerprint});
Future<AresWordCommentsSnapshot> wordComments(String path);
Future<AresWordCommentCreationResult> addWordComment(String path, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentCreationResult> addWordCommentThread(String path, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> migrateLegacyWordComments(String path, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> replaceWordCommentText(String path, String id, String text, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> replyToWordComment(String path, String parentId, {required String text, required String author, String? initials, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> replaceWordThreadCommentText(String path, String id, String text, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeWordCommentReply(String path, String commentId, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeWordCommentThread(String path, String rootCommentId, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> setWordCommentThreadResolved(String path, String rootCommentId, {required bool resolved, String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeAllLegacyWordComments(String path, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeWordComment(String path, String id, {String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> reusePresentationSlides(String path, {required String sourcePath, required List<int> slideIndexes, required int afterIndex, AresSlideReuseFormatting formatting = AresSlideReuseFormatting.source, String? expectedSourceFingerprint, String? expectedImportFingerprint});
Future<AresOfficePageOperationResult> setExcelDefinedName(String path, AresExcelDefinedName value, {bool replace = false, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> removeExcelDefinedName(String path, String name, {int? localSheetId, String? expectedSourceFingerprint});
Future<AresExcelNoteOperationResult> addExcelNote(String path, {required int sheetIndex, required String address, required String author, required String text, String? expectedSourceFingerprint});
Future<AresExcelNoteOperationResult> replaceExcelNoteText(String path, {required int sheetIndex, required String address, required String text, String? expectedSourceFingerprint});
Future<AresExcelNoteOperationResult> setExcelNotePlacement(String path, {required int sheetIndex, required String address, required AresExcelNotePlacement placement, String? expectedSourceFingerprint});
Future<AresExcelNoteOperationResult> setExcelNoteVisibility(String path, {required int sheetIndex, required String address, required bool visible, String? expectedSourceFingerprint});
Future<AresExcelNoteOperationResult> removeExcelNote(String path, {required int sheetIndex, required String address, String? expectedSourceFingerprint});
Future<AresExcelHyperlinksSnapshot> excelHyperlinks(String path, int sheetIndex);
Future<AresExcelHyperlinkOperationResult> setExcelHyperlink(String path, {required int sheetIndex, required String reference, String? target, String? location, String? display, String? tooltip, bool replace = false, String? expectedSourceFingerprint});
Future<AresExcelHyperlinkOperationResult> removeExcelHyperlink(String path, {required int sheetIndex, required String reference, String? expectedSourceFingerprint});
Future<AresExcelNotesSnapshot> excelNotes(String path, int sheetIndex);
Future<List<AresWordRevision>> wordRevisions(String path);
Future<AresOfficePageOperationResult> reviewWordRevisions(String path, List<AresWordRevision> revisions, AresWordRevisionDecision decision, {String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> reviewWordRevision(String path, AresWordRevision revision, AresWordRevisionDecision decision, {String? expectedSourceFingerprint});
Future<List<AresWordBookmark>> wordBookmarks(String documentPath);
Future<AresOfficePageOperationResult> addWordBookmark(String documentPath, {required int sectionIndex, required String name, int? startOffset, int? endOffset, int? endSectionIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> redefineWordBookmark(String documentPath, {required String name, required int sectionIndex, int? startOffset, int? endOffset, int? endSectionIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> renameWordBookmark(String documentPath, {required String name, required String newName, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> removeWordBookmark(String documentPath, String name, {String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> addBlankPage(String documentPath, {required int afterIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> duplicatePage(String documentPath, {required int index, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> deletePage(String documentPath, {required int index, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> movePresentationSection(String path, {required String sectionId, required int toIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> reorderPages(String documentPath, {required List<int> order, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> extractPage(String documentPath, {required int index, required String outputPath});
```

## AresOfficePageRecognizer

`package:ares_office_core/src/sdk/ares_scan_workflow.dart`

```dart
typedef AresOfficePageRecognizer = Future<List<AresOfficeRecognizedPage>> Function(List<String> imagePaths);
```

## AresOfficePdfExportOptions

`package:ares_office_core/src/office_pdf_exporter.dart`

```dart
class AresOfficePdfExportOptions
const AresOfficePdfExportOptions({this.pageFormat = PdfPageFormat.a4, this.margin = 32, this.maximumSpreadsheetColumns = 20, this.maximumSpreadsheetRows, this.maximumSections, this.maximumTextCharacters, this.useCurrentMediaPositions = false, this.font, this.boldFont, this.italicFont, this.boldItalicFont, this.fontFallback = const <pw.Font>[]});
final bool useCurrentMediaPositions;
final PdfPageFormat pageFormat;
final double margin;
final int maximumSpreadsheetColumns;
final int? maximumSpreadsheetRows;
final int? maximumSections;
final int? maximumTextCharacters;
final pw.Font? font;
final pw.Font? boldFont;
final pw.Font? italicFont, boldItalicFont;
final List<pw.Font> fontFallback;
```

## AresOfficePdfExportResult

`package:ares_office_core/src/office_pdf_exporter.dart`

```dart
class AresOfficePdfExportResult
const AresOfficePdfExportResult({required this.path, required this.bytesWritten, required this.pageCount});
final String path;
final int bytesWritten;
final int pageCount;
```

## AresOfficePdfExporter

`package:ares_office_core/src/office_pdf_exporter.dart`

```dart
class AresOfficePdfExporter
const AresOfficePdfExporter();
Future<AresOfficePdfExportResult> export(AresOfficeDocument document, {required String outputPath, AresOfficePdfExportOptions options = const AresOfficePdfExportOptions(), bool overwrite = false});
```

## AresOfficePlatform

`package:ares_office_core/src/sdk/ares_office_platforms.dart`

```dart
enum AresOfficePlatform { android, ios, macos, windows, linux, web }
```

## AresOfficePlatforms

`package:ares_office_core/src/sdk/ares_office_platforms.dart`

```dart
abstract final class AresOfficePlatforms
static const Set<AresOfficePlatform> editorTargets;
static const Set<AresOfficePlatform> documentApiTargets;
static const Set<AresOfficePlatform> scannerTargets;
static AresOfficePlatform get current;
static bool get canScan;
static void requireScanner();
```

## AresOfficeProduct

`package:ares_office_core/src/sdk/ares_office_product.dart`

```dart
enum AresOfficeProduct { word, excel, powerpoint }
```

## AresOfficeProductIdentity

`package:ares_office_core/src/sdk/ares_office_product.dart`

```dart
extension AresOfficeProductIdentity on AresOfficeProduct
String get sdkProduct;
```

## AresOfficeRawScanCapture

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeRawScanCapture
const AresOfficeRawScanCapture({required this.format, required this.template, required this.processingMode, required this.frames, this.wordDocumentOutput = AresWordDocumentOutput.editableDocument, this.wordSettings = const AresWordDocumentSettings(), this.notesSettings = const AresNotesSettings(), this.handwritingSettings = const AresHandwritingSettings(), this.formOutput = AresWordFormOutput.editableForm, this.excelOutput = AresExcelOutput.cleanTable, this.scanOptions = const {}, this.recognizedPages = const <AresOfficeRecognizedPage>[]});
final AresOfficeScannerFormat format;
final AresOfficeScanTemplate template;
final AresOfficeScanProcessingMode processingMode;
final List<QuadFrame> frames;
final AresWordDocumentOutput wordDocumentOutput;
final AresWordDocumentSettings wordSettings;
final AresNotesSettings notesSettings;
final AresHandwritingSettings handwritingSettings;
final AresWordFormOutput formOutput;
final AresExcelOutput excelOutput;
final Map<String, String> scanOptions;
final List<AresOfficeRecognizedPage> recognizedPages;
```

## AresOfficeReadingMode

`package:ares_office_core/src/office_editor_modes.dart`

```dart
enum AresOfficeReadingMode { light, dark, sepia, grayscale, highContrast }
```

## AresOfficeRecognizedPage

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeRecognizedPage
const AresOfficeRecognizedPage({required this.text, this.rows = const <List<String>>[], this.imagePaths = const <String>[], this.elements = const <AresWordScanElement>[], this.sourceAspectRatio, this.slidePlan, this.handwriting});
final double? sourceAspectRatio;
final AresSlidePlan? slidePlan;
final AresHandwritingPage? handwriting;
final String text;
final List<List<String>> rows;
final List<String> imagePaths;
final List<AresWordScanElement> elements;
```

## AresOfficeSampleDocuments

`package:ares_office_core/src/office_sample_documents.dart`

```dart
class AresOfficeSampleDocuments
static const String wordAssetPath;
static const String excelAssetPath;
static const String powerpointAssetPath;
static Future<String> installWordSample({required String outputPath, AssetBundle? bundle, bool overwrite = false});
static Future<String> installExcelSample({required String outputPath, AssetBundle? bundle, bool overwrite = false});
static Future<String> installPowerPointSample({required String outputPath, AssetBundle? bundle, bool overwrite = false});
```

## AresOfficeSaveAsFormatPathRequest

`package:ares_office_core/src/office_package_format.dart`

```dart
typedef AresOfficeSaveAsFormatPathRequest = Future<String?> Function(AresOfficeDocument document, AresOfficePackageFormat format);
```

## AresOfficeSaveConflictException

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeSaveConflictException extends AresOfficeDocumentException
const AresOfficeSaveConflictException(super.message);
```

## AresOfficeSaveResult

`package:ares_office_core/src/office_document_writer.dart`

```dart
class AresOfficeSaveResult
const AresOfficeSaveResult({required this.path, required this.document, required this.bytesWritten, required this.sourceOverwritten});
final String path;
final AresOfficeDocument document;
final int bytesWritten;
final bool sourceOverwritten;
```

## AresOfficeScanContentFormatter

`package:ares_office_core/src/scanner/ares_office_scan_generator.dart`

```dart
class AresOfficeScanContentFormatter
static String word(List<AresOfficeRecognizedPage> pages);
static String spreadsheet(List<AresOfficeRecognizedPage> pages);
static List<String> presentation(List<AresOfficeRecognizedPage> pages);
```

## AresOfficeScanGenerationResult

`package:ares_office_core/src/scanner/ares_office_scan_generator.dart`

```dart
class AresOfficeScanGenerationResult
const AresOfficeScanGenerationResult({required this.path, required this.document, required this.template});
final String path;
final AresOfficeDocument document;
final AresOfficeScanTemplate template;
```

## AresOfficeScanProcessingMode

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresOfficeScanProcessingMode { wordLayout, wordText, wordForms, wordHandwriting, spreadsheetSmart, spreadsheetTables, spreadsheetReceipts, spreadsheetForms, spreadsheetInvoices, spreadsheetInventory, presentationAutoArrange }
```

## AresOfficeScanResult

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeScanResult
const AresOfficeScanResult({required this.format, required this.template, required this.processingMode, required this.imagePaths, this.wordDocumentOutput = AresWordDocumentOutput.editableDocument, this.wordSettings = const AresWordDocumentSettings(), this.notesSettings = const AresNotesSettings(), this.handwritingSettings = const AresHandwritingSettings(), this.formOutput = AresWordFormOutput.editableForm, this.excelOutput = AresExcelOutput.cleanTable, this.notesActions = const [], this.excelWorkbook, this.recognizedPages = const <AresOfficeRecognizedPage>[]});
final AresOfficeScannerFormat format;
final AresOfficeScanTemplate template;
final AresOfficeScanProcessingMode processingMode;
final List<String> imagePaths;
final AresWordDocumentOutput wordDocumentOutput;
final AresWordDocumentSettings wordSettings;
final AresNotesSettings notesSettings;
final AresHandwritingSettings handwritingSettings;
final AresWordFormOutput formOutput;
final AresExcelOutput excelOutput;
final List<AresNotesAction> notesActions;
final AresExcelWorkbook? excelWorkbook;
final List<AresOfficeRecognizedPage> recognizedPages;
```

## AresOfficeScanTemplate

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeScanTemplate
const AresOfficeScanTemplate({required this.id, required this.name, required this.description, required this.format, this.sourcePath, this.isUserTemplate = false, this.designId, this.previewBuilder});
final bool isUserTemplate;
final String? designId;
final String id;
final String name;
final String description;
final AresOfficeScannerFormat format;
final String? sourcePath;
final WidgetBuilder? previewBuilder;
bool get isCustom;
```

## AresOfficeScanTemplateCatalog

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresOfficeScanTemplateCatalog
static List<AresOfficeScanTemplate> templatesFor(AresOfficeScannerFormat format);
static const List<AresOfficeScanTemplate> word;
static const List<AresOfficeScanTemplate> spreadsheet;
static const List<AresOfficeScanTemplate> presentation;
```

## AresOfficeScannerFormat

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresOfficeScannerFormat { word, spreadsheet, presentation }
```

## AresOfficeSearchResult

`package:ares_office_core/src/office_document.dart`

```dart
class AresOfficeSearchResult
const AresOfficeSearchResult({required this.sectionIndex, required this.start, required this.length, required this.preview});
final int sectionIndex;
final int start;
final int length;
final String preview;
```

## AresOfficeSecurityInspector

`package:ares_office_core/src/office_security_inspector.dart`

```dart
class AresOfficeSecurityInspector
const AresOfficeSecurityInspector({this.maximumCompressedBytes = 128 * 1024 * 1024, this.maximumExpandedBytes = 256 * 1024 * 1024, this.maximumArchiveEntries = 10000});
final int maximumCompressedBytes;
final int maximumExpandedBytes;
final int maximumArchiveEntries;
Future<AresOfficeSecurityReport> inspect(String documentPath);
```

## AresOfficeSecurityReport

`package:ares_office_core/src/office_security_inspector.dart`

```dart
class AresOfficeSecurityReport
const AresOfficeSecurityReport({required this.isOpenXml, required this.isEncrypted, required this.hasDigitalSignatures, required this.hasMacros, required this.externalRelationshipCount, required this.embeddedObjectCount, required this.signaturePartCount});
final bool isOpenXml;
final bool isEncrypted;
final bool hasDigitalSignatures;
final bool hasMacros;
final int externalRelationshipCount;
final int embeddedObjectCount;
final int signaturePartCount;
```

## AresOfficeServiceUtilities

`package:ares_office_core/src/office_service_utilities.dart`

```dart
class AresOfficeServiceUtilities
const AresOfficeServiceUtilities({this.loader = const AresOfficeDocumentLoader()});
final AresOfficeDocumentLoader loader;
Future<AresOfficeCompressionResult> compress(String documentPath, {required String outputPath, int level = 9, bool overwrite = false});
Future<String> extractText(AresOfficeDocument document, {required String outputPath, bool overwrite = false});
```

## AresOfficeStorage

`package:ares_office_core/src/storage/ares_office_storage.dart`

```dart
abstract final class AresOfficeStorage
static Future<String> importBytes({required String name, required List<int> bytes, String? path, bool overwrite = false});
static Future<String> open(String path);
static Future<Uint8List> readBytes(String path);
static Future<List<String>> list({String? directoryPath});
static Future<void> remove(String path);
```

## AresOfficeStorageConflict

`package:ares_office_core/src/storage/office_storage_error.dart`

```dart
class AresOfficeStorageConflict extends AresOfficeStorageException
const AresOfficeStorageConflict();
```

## AresOfficeStorageException

`package:ares_office_core/src/storage/office_storage_error.dart`

```dart
class AresOfficeStorageException implements Exception
const AresOfficeStorageException(this.message);
final String message;
String toString();
```

## AresOfficeTemplateManagerLauncher

`package:ares_office_core/src/scanner/ares_office_scanner.dart`

```dart
typedef AresOfficeTemplateManagerLauncher = FutureOr<List<AresOfficeScanTemplate>?> Function(BuildContext context, AresOfficeScannerFormat format);
```

## AresOfficeTemplateSelectionChanged

`package:ares_office_core/src/scanner/ares_office_scanner.dart`

```dart
typedef AresOfficeTemplateSelectionChanged = FutureOr<void> Function(AresOfficeScanTemplate template);
```

## AresOfficeTextPosition

`package:ares_office_core/src/office_document.dart`

```dart
enum AresOfficeTextPosition { normal, superscript, subscript }
```

## AresOfficeToolConfig

`package:ares_office_core/src/office_viewer_config.dart`

```dart
class AresOfficeToolConfig
const AresOfficeToolConfig({required this.label, required this.icon, this.isPro = false});
final String label;
final IconData icon;
final bool isPro;
```

## AresOfficeToolsSheetConfig

`package:ares_office_core/src/office_viewer_config.dart`

```dart
class AresOfficeToolsSheetConfig
const AresOfficeToolsSheetConfig({this.header = 'Extra Document Tools', this.showSaveCopy = true, this.showShare = true, this.showPrint = true, this.showExportPdf = true, this.showReadAloud = true, this.showDocumentInfo = true, this.showExtractImages = true, this.showAnnotations = true, this.showCompress = true, this.showExtractText = true, this.showSecurityInfo = true, this.customTools = const <AresOfficeToolConfig>[]});
final String header;
final bool showSaveCopy;
final bool showShare;
final bool showPrint;
final bool showExportPdf;
final bool showReadAloud;
final bool showDocumentInfo;
final bool showExtractImages;
final bool showAnnotations;
final bool showCompress;
final bool showExtractText;
final bool showSecurityInfo;
final List<AresOfficeToolConfig> customTools;
```

## AresOfficeVerticalAlignment

`package:ares_office_core/src/office_document.dart`

```dart
enum AresOfficeVerticalAlignment { top, center, bottom }
```

## AresOfficeViewerAppBarConfig

`package:ares_office_core/src/office_viewer_config.dart`

```dart
class AresOfficeViewerAppBarConfig
const AresOfficeViewerAppBarConfig({this.title, this.showBackButton = true, this.showSearch = true, this.showTools = true});
final String? title;
final bool showBackButton;
final bool showSearch;
final bool showTools;
```

## AresOfficeViewerConfig

`package:ares_office_core/src/office_viewer_config.dart`

```dart
class AresOfficeViewerConfig
const AresOfficeViewerConfig({this.initialSectionIndex = 0, this.initialZoom = 1, this.minimumZoom = 0.75, this.maximumZoom = 4, this.showBottomNavigation = true, this.allowEditing = true, this.allowCopy = true, this.authorizeAction, this.commentAuthorName = '', this.photoTextRecognizer, this.supportedExternalTools = const <String>{}, this.padding = const EdgeInsets.only(bottom: 24)});
final int initialSectionIndex;
final double initialZoom;
final double minimumZoom;
final double maximumZoom;
final bool showBottomNavigation;
final bool allowEditing;
final bool allowCopy;
final String commentAuthorName;
final Future<bool> Function(String action)? authorizeAction;
final Future<List<AresWordScanElement>> Function(String path)? photoTextRecognizer;
final Set<String> supportedExternalTools;
final EdgeInsets padding;
```

## AresOfficeViewerController

`package:ares_office_core/src/office_viewer_controller.dart`

```dart
class AresOfficeViewerController extends ChangeNotifier
AresOfficeDocument? get document;
bool get isReady;
int get sectionIndex;
double get zoom;
String get searchQuery;
List<AresOfficeSearchResult> get searchResults;
int get activeSearchResult;
int get reloadGeneration;
Set<int> get bookmarkedSections;
int get sectionCount;
void goToSection(int index);
void nextSection();
void previousSection();
bool isSectionBookmarked(int index);
void toggleBookmark([int? sectionIndex]);
void clearBookmarks();
void setZoom(double zoom);
void zoomIn();
void zoomOut();
void resetZoom();
void search(String query);
void clearSearch();
void nextSearchResult();
void previousSearchResult();
void reload();
```

## AresPresentationCommentOperationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresPresentationCommentOperationResult extends AresOfficePageOperationResult
const AresPresentationCommentOperationResult({required super.document, required super.activeIndex, required this.commentId, required this.snapshot});
final String commentId;
final AresPresentationCommentsSnapshot snapshot;
```

## AresPresentationCustomShow

`package:ares_office_core/src/office_document.dart`

```dart
class AresPresentationCustomShow
AresPresentationCustomShow({required this.id, required this.name, required List<int> slides});
final int id;
final String name;
final List<int> slides;
```

## AresPresentationPartChange

`package:ares_office_core/src/office_document.dart`

```dart
class AresPresentationPartChange
const AresPresentationPartChange({required this.id, required this.path, required this.sourceXml});
final String id, path, sourceXml;
```

## AresPresentationShowSettings

`package:ares_office_core/src/office_document.dart`

```dart
class AresPresentationShowSettings
const AresPresentationShowSettings({this.type = AresPresentationShowType.speaker, this.loop = false, this.showNarration = true, this.showAnimation = true, this.useTimings = true, this.showScrollbar = true, this.startSlide, this.endSlide, this.customShowId});
final AresPresentationShowType type;
final bool loop, showNarration, showAnimation, useTimings, showScrollbar;
final int? startSlide, endSlide;
final int? customShowId;
bool get usesRange;
AresPresentationShowSettings copyWith({AresPresentationShowType? type, bool? loop, bool? showNarration, bool? showAnimation, bool? useTimings, bool? showScrollbar, int? startSlide, int? endSlide, int? customShowId, bool clearRange = false, bool clearCustomShow = false});
bool ==(Object other);
int get hashCode;
```

## AresPresentationShowType

`package:ares_office_core/src/office_document.dart`

```dart
enum AresPresentationShowType { speaker, individual, kiosk }
```

## AresPresentationSlideSection

`package:ares_office_core/src/office_document.dart`

```dart
class AresPresentationSlideSection
const AresPresentationSlideSection({required this.id, required this.name, required this.slides});
final String id, name;
final List<int> slides;
```

## AresPresentationThemeChange

`package:ares_office_core/src/office_document.dart`

```dart
class AresPresentationThemeChange
AresPresentationThemeChange({required this.id, required this.name, required Map<String, String> colors, this.headingFont, this.bodyFont});
final String id, name;
final Map<String, String> colors;
final String? headingFont, bodyFont;
```

## AresSlideChartChange

`package:ares_office_core/src/office_document.dart`

```dart
class AresSlideChartChange
AresSlideChartChange({required this.id, required this.sectionIndex, required this.relationshipId, required this.title, required this.line, this.kind, this.firstSliceAngle = 0, this.holeSize = 50, this.showLegend = true, this.showValues, this.showPercent, required List<List<String>> rows});
final String id, relationshipId, title;
final int sectionIndex;
final bool line;
final AresSlideChartKind? kind;
final int firstSliceAngle, holeSize;
final bool showLegend;
final bool? showValues, showPercent;
AresSlideChartKind get effectiveKind;
final List<List<String>> rows;
```

## AresSlideChartKind

`package:ares_office_core/src/office_document.dart`

```dart
enum AresSlideChartKind { column, line, pie, doughnut, bar, stackedColumn, stackedBar, percentColumn, percentBar }
```

## AresWordBlock

`package:ares_office_core/src/word_file_preview.dart`

```dart
sealed class AresWordBlock
const AresWordBlock({required this.sectionIndex});
final int? sectionIndex;
```

## AresWordBookmark

`package:ares_office_core/src/office_word_bookmarks.dart`

```dart
class AresWordBookmark
const AresWordBookmark({required this.id, required this.name, this.sectionIndex, this.startOffset, this.endOffset, this.endSectionIndex});
final String id;
final String name;
final int? sectionIndex;
final int? startOffset, endOffset, endSectionIndex;
bool get hidden;
```

## AresWordBookmarks

`package:ares_office_core/src/office_word_bookmarks.dart`

```dart
class AresWordBookmarks
static String? nameError(String name);
static List<XmlElement> blocks(XmlDocument xml);
static List<AresWordBookmark> read(XmlDocument xml);
static void redefine(XmlDocument xml, {required String name, required int sectionIndex, int? startOffset, int? endOffset, int? endSectionIndex});
static void add(XmlDocument xml, {required int sectionIndex, required String name});
static String rangeText(XmlElement paragraph);
static void addRange(XmlDocument xml, {required int sectionIndex, required String name, required int startOffset, required int endOffset, int? endSectionIndex});
static void rename(XmlDocument xml, {required String name, required String newName});
static bool retargetReferences(XmlDocument xml, {required String name, required String newName});
static void remove(XmlDocument xml, String name);
```

## AresWordBreakType

`package:ares_office_core/src/office_edit_session.dart`

```dart
enum AresWordBreakType { page, column, nextPageSection, continuousSection, evenPageSection, oddPageSection }
```

## AresWordCaretRequest

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordCaretRequest = void Function(int sectionIndex, int textOffset);
```

## AresWordCharacterPageBounds

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordCharacterPageBounds = ({int pageNumber, int sectionIndex, int start, int end, Rect rect});
```

## AresWordComment

`package:ares_office_core/src/office_word_comments.dart`

```dart
class AresWordComment
const AresWordComment({required this.id, required this.text, this.author, this.initials, this.date, this.sectionIndex, this.restriction, this.plainText = false});
final String id, text;
final String? author, initials, restriction;
final DateTime? date;
final int? sectionIndex;
final bool plainText;
bool get canDelete;
bool get canReplaceText;
```

## AresWordCommentCreationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresWordCommentCreationResult extends AresWordCommentOperationResult
const AresWordCommentCreationResult({required super.document, required super.activeIndex, required super.commentId, required super.snapshot});
```

## AresWordCommentOperationResult

`package:ares_office_core/src/office_page_operations.dart`

```dart
class AresWordCommentOperationResult extends AresOfficePageOperationResult
const AresWordCommentOperationResult({required super.document, required super.activeIndex, required this.commentId, required this.snapshot});
final String commentId;
final AresWordCommentsSnapshot snapshot;
```

## AresWordCommentThreadState

`package:ares_office_core/src/office_word_comment_threads.dart`

```dart
class AresWordCommentThreadState
const AresWordCommentThreadState({required this.commentId, required this.paragraphId, required this.rootCommentId, required this.depth, required this.resolved, required this.threadResolved, this.parentCommentId, this.restriction, this.plainText = false});
final String commentId, paragraphId, rootCommentId;
final String? parentCommentId, restriction;
final bool plainText;
bool get canEditText;
bool get canDeleteThread;
bool get canDeleteReply;
final int depth;
final bool resolved, threadResolved;
bool get isRoot;
bool get canResolve;
bool get canReply;
```

## AresWordCommentThreads

`package:ares_office_core/src/office_word_comment_threads.dart`

```dart
class AresWordCommentThreads
static const dynamic namespace;
static const dynamic paragraphNamespace;
static const dynamic relationshipType;
static const dynamic peopleRelationshipType;
static const dynamic contentType;
static const dynamic peopleContentType;
static AresWordCommentThreadsSnapshot inspect(Archive archive, {List<({String path, XmlDocument xml})>? stories});
static void initializeRoot(Archive archive, String commentId);
static String initializeLegacy(Archive archive);
static void replaceText(Archive archive, String commentId, String text);
static void removeThread(Archive archive, String rootCommentId);
static void removeReply(Archive archive, String commentId);
static String reply(Archive archive, String parentCommentId, {required String text, required String author, String? initials, DateTime? date});
static String addRoot(Archive archive, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date});
static void setResolved(Archive archive, String rootCommentId, bool resolved);
```

## AresWordCommentThreadsSnapshot

`package:ares_office_core/src/office_word_comment_threads.dart`

```dart
class AresWordCommentThreadsSnapshot
AresWordCommentThreadsSnapshot({this.partPath, List<AresWordCommentThreadState> states = const [], this.restriction});
final String? partPath, restriction;
final List<AresWordCommentThreadState> states;
AresWordCommentThreadState? stateFor(String commentId);
Iterable<AresWordCommentThreadState> get roots;
bool get canCreateRoot;
```

## AresWordComments

`package:ares_office_core/src/office_word_comments.dart`

```dart
class AresWordComments
static AresWordCommentsSnapshot inspect(Archive archive);
static List<AresWordComment> read(Archive archive);
static String? restriction(Archive archive);
static String add(Archive archive, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date});
static void replaceText(Archive archive, String id, String text);
static String removeAllLegacy(Archive archive);
static void remove(Archive archive, String id);
```

## AresWordCommentsSnapshot

`package:ares_office_core/src/office_word_comments.dart`

```dart
class AresWordCommentsSnapshot
const AresWordCommentsSnapshot({required this.comments, this.restriction, this.sourceFingerprint, this.threads});
final List<AresWordComment> comments;
final AresWordCommentThreadsSnapshot? threads;
final String? restriction;
final String? sourceFingerprint;
AresWordCommentsSnapshot withSourceFingerprint(String? value);
String? get creationRestriction;
bool get canCreate;
bool get canStartThread;
bool get canMigrateToThreads;
```

## AresWordContentControlType

`package:ares_office_core/src/office_edit_session.dart`

```dart
enum AresWordContentControlType { text, checkbox, radioButton, date, dropdown, combo, signature, button }
```

## AresWordCropAdjuster

`package:ares_office_core/src/scanner/ares_word_editable_preview.dart`

```dart
typedef AresWordCropAdjuster = Future<AresWordEditablePreviewSource?> Function(List<String> imagePaths);
```

## AresWordCropSession

`package:ares_office_core/src/scanner/ares_word_crop_session.dart`

```dart
class AresWordCropSession
AresWordCropSession(List<QuadFrame> frames);
Future<List<QuadFrame>> prepare();
Future<List<QuadFrame>?> review(NavigatorState navigator, {required Future<QuadFrame?> Function() onRetake, Future<CropResult?> Function(WidgetBuilder builder)? openReview});
```

## AresWordDocument

`package:ares_word/src/ares_word_sdk.dart`

```dart
typedef AresWordDocument = AresOfficeDocument;
```

## AresWordDocumentLayout

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordDocumentLayout
const AresWordDocumentLayout({required this.pages, required this.pageWidthTwips, required this.pageHeightTwips, required this.topMarginTwips, required this.rightMarginTwips, required this.bottomMarginTwips, required this.leftMarginTwips, required this.headerText, required this.footerText});
final List<AresWordPage> pages;
final double pageWidthTwips;
final double pageHeightTwips;
final double topMarginTwips;
final double rightMarginTwips;
final double bottomMarginTwips;
final double leftMarginTwips;
final String headerText;
final String footerText;
Iterable<AresWordBlock> get blocks;
```

## AresWordDocumentOutput

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresWordDocumentOutput { editableDocument, originalScan }
```

## AresWordDocumentOutputDetails

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
extension AresWordDocumentOutputDetails on AresWordDocumentOutput
String get label;
String get description;
```

## AresWordDocumentParser

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordDocumentParser
const AresWordDocumentParser();
Future<AresWordDocumentLayout> parse(File file);
Future<AresWordDocumentLayout> parseBytes(Uint8List bytes);
```

## AresWordDocumentSettings

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresWordDocumentSettings
const AresWordDocumentSettings({this.preserveImages = true, this.matchOriginalStructure = false, this.usePortableTableLayout = true, this.editablePositionedText = false});
final bool preserveImages;
final bool matchOriginalStructure;
final bool usePortableTableLayout;
final bool editablePositionedText;
```

## AresWordEditSession

`package:ares_word/src/ares_word_sdk.dart`

```dart
typedef AresWordEditSession = AresDomainEditSession;
```

## AresWordEditablePreviewResult

`package:ares_office_core/src/scanner/ares_word_editable_preview.dart`

```dart
class AresWordEditablePreviewResult
const AresWordEditablePreviewResult({required this.template, this.formOutput, required this.imagePaths, required this.pages});
final AresOfficeScanTemplate template;
final AresWordFormOutput? formOutput;
final List<String> imagePaths;
final List<AresOfficeRecognizedPage> pages;
```

## AresWordEditablePreviewScreen

`package:ares_office_core/src/scanner/ares_word_editable_preview.dart`

```dart
class AresWordEditablePreviewScreen extends StatefulWidget
const AresWordEditablePreviewScreen({super.key, required this.templates, required this.initialTemplate, required this.imagePaths, required this.pages, this.wordSettings = const AresWordDocumentSettings(), this.onPrepare, this.onRecognize, this.onAdjustCrop, this.onTemplateSelected, this.formOutput, this.modeLabel = 'Document', this.outputLabel = 'Clean document', this.loadingLabel = 'Preparing document…', this.reviewNotice, this.onBeforeCreate, this.runProcessing});
final List<AresOfficeScanTemplate> templates;
final AresOfficeScanTemplate initialTemplate;
final List<String> imagePaths;
final List<AresOfficeRecognizedPage> pages;
final AresWordDocumentSettings wordSettings;
final AresWordFormOutput? formOutput;
final String modeLabel, outputLabel, loadingLabel;
final String? reviewNotice;
final Future<bool> Function()? onBeforeCreate;
final Future<String?> Function(Future<String> Function() operation)? runProcessing;
final Future<AresWordEditablePreviewSource> Function()? onPrepare;
final Future<List<AresOfficeRecognizedPage>> Function(List<String>)? onRecognize;
final AresWordCropAdjuster? onAdjustCrop;
final ValueChanged<AresOfficeScanTemplate>? onTemplateSelected;
State<AresWordEditablePreviewScreen> createState();
```

## AresWordEditablePreviewSource

`package:ares_office_core/src/scanner/ares_word_editable_preview.dart`

```dart
class AresWordEditablePreviewSource
const AresWordEditablePreviewSource({required this.imagePaths, required this.pages});
final List<String> imagePaths;
final List<AresOfficeRecognizedPage> pages;
```

## AresWordEditor

`package:ares_word/src/ares_word_sdk.dart`

```dart
class AresWordEditor extends StatelessWidget
const AresWordEditor({super.key, required this.sdk, required this.documentPath, this.controller, this.viewerConfig = const AresOfficeViewerConfig(), this.appBarConfig = const AresOfficeViewerAppBarConfig(), this.toolsSheetConfig = const AresOfficeToolsSheetConfig(), this.theme, this.darkTheme, this.themeMode = ThemeMode.system, this.autoSaveEnabled = true, this.onDocumentReady, this.onDocumentModified, this.onDocumentSaved, this.onError, this.onRequestSaveAsPath, this.onRequestSaveAsFormatPath, this.onRequestPdfExportPath, this.onExternalToolAction, this.onScanPage, this.showProBadge = false, this.onUpgrade, this.autoSaveIdleDelay = const Duration(milliseconds: 500), this.onAutoSaved, this.onDocumentImagesExtracted, this.onPdfExported, this.onDocumentCompressed, this.onTextExtracted, this.onRequestCompressedCopyPath, this.onRequestTextExportPath, this.onLoadCustomStamps, this.onScanWatermark, this.onEmbedVideos, this.onEmbedAudio});
final AresWordSdk sdk;
final String documentPath;
final AresOfficeViewerController? controller;
final AresOfficeViewerConfig viewerConfig;
final AresOfficeViewerAppBarConfig appBarConfig;
final AresOfficeToolsSheetConfig toolsSheetConfig;
final ThemeData? theme;
final ThemeData? darkTheme;
final ThemeMode themeMode;
final bool autoSaveEnabled;
final ValueChanged<AresOfficeDocument>? onDocumentReady;
final VoidCallback? onDocumentModified;
final ValueChanged<AresOfficeSaveResult>? onDocumentSaved;
final ValueChanged<Object>? onError;
final Future<String?> Function(AresOfficeDocument)? onRequestSaveAsPath;
final AresOfficeSaveAsFormatPathRequest? onRequestSaveAsFormatPath;
final Future<String?> Function(AresOfficeDocument)? onRequestPdfExportPath;
final AresOfficeExternalToolHandler? onExternalToolAction;
final Future<AresOfficeScanResult?> Function(AresOfficeExternalToolAction)? onScanPage;
final bool showProBadge;
final VoidCallback? onUpgrade;
final Duration autoSaveIdleDelay;
final ValueChanged<AresOfficeSaveResult>? onAutoSaved;
final ValueChanged<AresOfficeImageExtractionResult>? onDocumentImagesExtracted;
final ValueChanged<AresOfficePdfExportResult>? onPdfExported;
final ValueChanged<AresOfficeCompressionResult>? onDocumentCompressed;
final ValueChanged<String>? onTextExtracted;
final Future<String?> Function(AresOfficeDocument)? onRequestCompressedCopyPath;
final Future<String?> Function(AresOfficeDocument)? onRequestTextExportPath;
final Future<List<AresStampModel>> Function()? onLoadCustomStamps;
final Future<AresStampModel?> Function()? onScanWatermark;
final Future<List<String>?> Function()? onEmbedVideos;
final Future<String?> Function()? onEmbedAudio;
Widget build(BuildContext context);
```

## AresWordFormField

`package:ares_office_core/src/office_word_form_fields.dart`

```dart
class AresWordFormField
const AresWordFormField({required this.id, required this.name, required this.type, this.label = '', this.tooltip = '', this.value = '', this.defaultValue = '', this.options = const <String>[], this.required = false, this.readOnly = false, this.multiline = false, this.maxLength = 0, this.validation = AresWordFormValidationType.none, this.validationPattern = '', this.tabIndex = 0, this.fillColor = 0xfff5f8fd, this.borderColor = 0xff9bb1cf, this.fontSize = 12});
static const String tagPrefix;
final String id;
final String name;
final String label;
final String tooltip;
final AresWordFormFieldType type;
final String value;
final String defaultValue;
final List<String> options;
final bool required;
final bool readOnly;
final bool multiline;
final int maxLength;
final AresWordFormValidationType validation;
final String validationPattern;
final int tabIndex;
final int fillColor;
final int borderColor;
final double fontSize;
AresWordFormField copyWith({String? id, String? name, String? label, String? tooltip, AresWordFormFieldType? type, String? value, String? defaultValue, List<String>? options, bool? required, bool? readOnly, bool? multiline, int? maxLength, AresWordFormValidationType? validation, String? validationPattern, int? tabIndex, int? fillColor, int? borderColor, double? fontSize});
Map<String, Object?> toJson();
String get encodedTag;
static AresWordFormField fromControl(XmlElement control, {String fallbackLabel = '', int fallbackTabIndex = 0});
```

## AresWordFormFieldType

`package:ares_office_core/src/office_word_form_fields.dart`

```dart
enum AresWordFormFieldType { text, checkbox, radioButton, dropdown, listBox, signature, date, button }
```

## AresWordFormItem

`package:ares_office_core/src/scanner/ares_word_forms.dart`

```dart
class AresWordFormItem
const AresWordFormItem(this.label, {this.value = '', this.field = false, this.checkbox = false, this.checked = false});
final String label, value;
final bool field, checkbox, checked;
```

## AresWordFormOutput

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
enum AresWordFormOutput { editableForm, completedRecord, checklist }
```

## AresWordFormOutputDetails

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
extension AresWordFormOutputDetails on AresWordFormOutput
String get label;
String get description;
```

## AresWordFormValidationIssue

`package:ares_office_core/src/office_word_form_fields.dart`

```dart
class AresWordFormValidationIssue
const AresWordFormValidationIssue(this.field, this.message);
final AresWordFormField field;
final String message;
```

## AresWordFormValidationType

`package:ares_office_core/src/office_word_form_fields.dart`

```dart
enum AresWordFormValidationType { none, email, number, date, regularExpression }
```

## AresWordHeaderFooterChange

`package:ares_office_core/src/office_document.dart`

```dart
class AresWordHeaderFooterChange
const AresWordHeaderFooterChange({required this.id, required this.kind, this.variant = AresWordHeaderFooterVariant.defaultPages, this.text, this.textAlignment, this.textBold, this.textItalic, this.textUnderline, this.textFontSize, this.pageNumber, this.pageNumberAlignment = AresWordPageNumberAlignment.center, this.pageNumberFormat, this.pageNumberStart});
final String id;
final AresWordHeaderFooterKind kind;
final AresWordHeaderFooterVariant variant;
final String? text;
final AresWordPageNumberAlignment? textAlignment;
final bool? textBold;
final bool? textItalic;
final bool? textUnderline;
final double? textFontSize;
final bool? pageNumber;
final AresWordPageNumberAlignment pageNumberAlignment;
final AresWordPageNumberFormat? pageNumberFormat;
final int? pageNumberStart;
```

## AresWordHeaderFooterKind

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordHeaderFooterKind { header, footer }
```

## AresWordHeaderFooterVariant

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordHeaderFooterVariant { defaultPages, firstPage, evenPages }
```

## AresWordImage

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordImage
const AresWordImage({required this.bytes, required this.packagePath, this.widthPoints, this.heightPoints, this.altText, this.drawingId});
final String? drawingId;
final Uint8List bytes;
final String packagePath;
final double? widthPoints;
final double? heightPoints;
final String? altText;
```

## AresWordImagePageBounds

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordImagePageBounds = ({int pageNumber, int sectionIndex, String packagePath, Rect rect});
```

## AresWordPage

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordPage
const AresWordPage({required this.blocks});
final List<AresWordBlock> blocks;
```

## AresWordPageGeometryOverride

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordPageGeometryOverride = ({double pageWidthTwips, double pageHeightTwips, double topMarginTwips, double rightMarginTwips, double bottomMarginTwips, double leftMarginTwips});
```

## AresWordPageNumberAlignment

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordPageNumberAlignment { left, center, right }
```

## AresWordPageNumberFormat

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordPageNumberFormat { decimal, lowerRoman, upperRoman, lowerLetter, upperLetter }
```

## AresWordPageThumbnail

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordPageThumbnail extends StatelessWidget
const AresWordPageThumbnail({super.key, required this.layout, required this.pageIndex, this.mediaOverlayBuilder});
final AresWordDocumentLayout layout;
final int pageIndex;
final Widget Function(Size, Set<int>)? mediaOverlayBuilder;
Widget build(BuildContext context);
```

## AresWordParagraphBlock

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordParagraphBlock extends AresWordBlock
const AresWordParagraphBlock({required super.sectionIndex, required this.runs, required this.images, required this.style, this.directStyle = const AresWordParagraphStyle(), required this.listMarker, this.styleId, this.availableStyles = const <String, AresWordResolvedStyle>{}, this.frameTwips, this.sourceImageOverlay = false, this.behindDocument = false});
final List<AresWordTextRun> runs;
final List<AresWordImage> images;
final AresWordParagraphStyle style;
final AresWordParagraphStyle directStyle;
final String? listMarker;
final String? styleId;
final Map<String, AresWordResolvedStyle> availableStyles;
final Rect? frameTwips;
final bool sourceImageOverlay;
final bool behindDocument;
String get text;
```

## AresWordParagraphStyle

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordParagraphStyle
const AresWordParagraphStyle({this.alignment, this.spaceBeforePoints, this.spaceAfterPoints, this.leftIndentPoints, this.rightIndentPoints, this.firstLineIndentPoints, this.lineHeight, this.backgroundColor, this.border, this.isHeading, this.rightToLeft});
final TextAlign? alignment;
final double? spaceBeforePoints;
final double? spaceAfterPoints;
final double? leftIndentPoints;
final double? rightIndentPoints;
final double? firstLineIndentPoints;
final double? lineHeight;
final Color? backgroundColor;
final Border? border;
final bool? isHeading;
final bool? rightToLeft;
AresWordParagraphStyle merge(AresWordParagraphStyle other);
TextAlign get alignmentValue;
double get spaceBeforePointsValue;
double get spaceAfterPointsValue;
double get leftIndentPointsValue;
double get rightIndentPointsValue;
bool get rightToLeftValue;
double get lineHeightValue;
```

## AresWordPicture

`package:ares_office_core/src/office_word_pictures.dart`

```dart
class AresWordPicture
const AresWordPicture({required this.id, required this.name, required this.title, required this.description, required this.widthPoints, required this.heightPoints, required this.bytes});
final int id;
final String name, title, description;
final double widthPoints, heightPoints;
final Uint8List bytes;
```

## AresWordPicturesSnapshot

`package:ares_office_core/src/office_word_pictures.dart`

```dart
class AresWordPicturesSnapshot
const AresWordPicturesSnapshot({required this.pictures, required this.unsupportedPictures, required this.sourceFingerprint, this.restriction});
final List<AresWordPicture> pictures;
final int unsupportedPictures;
final String sourceFingerprint;
final String? restriction;
bool get canEdit;
```

## AresWordRedactionGeometry

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordRedactionGeometry = ({List<AresWordCharacterPageBounds> characters, List<AresWordImagePageBounds> images});
```

## AresWordResolvedStyle

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordResolvedStyle
const AresWordResolvedStyle({required this.run, required this.paragraph});
final AresWordRunStyle run;
final AresWordParagraphStyle paragraph;
```

## AresWordRevision

`package:ares_office_core/src/office_word_revisions.dart`

```dart
class AresWordRevision
const AresWordRevision({required this.partPath, required this.id, required this.kind, required this.text, this.author, this.date, this.unsupportedReason, this.storyKind = 'document'});
final String partPath, id, kind, text, storyKind;
final String? author;
final DateTime? date;
final String? unsupportedReason;
bool get canReview;
String get storyLabel;
AresWordRevision blocked(String reason);
String get label;
```

## AresWordRevisionDecision

`package:ares_office_core/src/office_word_revisions.dart`

```dart
enum AresWordRevisionDecision { accept, reject }
```

## AresWordRevisions

`package:ares_office_core/src/office_word_revisions.dart`

```dart
class AresWordRevisions
static const dynamic namespaces;
static const dynamic kinds;
static const dynamic properties;
static bool isHistorical(XmlElement node);
static String finalText(XmlElement element);
static List<AresWordRevision> read(XmlDocument xml, {String partPath = 'word/document.xml'});
static void decide(XmlDocument xml, {required String id, required String kind, required AresWordRevisionDecision decision});
```

## AresWordRunStyle

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordRunStyle
const AresWordRunStyle({this.fontFamily, this.fontSizePoints, this.bold, this.italic, this.underline, this.underlineStyle, this.strike, this.textPosition, this.embossed, this.color, this.backgroundColor, this.characterSpacingPoints});
final String? fontFamily;
final double? fontSizePoints;
final bool? bold;
final bool? italic;
final bool? underline;
final String? underlineStyle;
final bool? strike;
final AresOfficeTextPosition? textPosition;
final bool? embossed;
final Color? color;
final Color? backgroundColor;
final double? characterSpacingPoints;
AresWordRunStyle merge(AresWordRunStyle other);
```

## AresWordScanElement

`package:ares_office_core/src/scanner/ares_office_scanner_models.dart`

```dart
class AresWordScanElement
const AresWordScanElement({required this.bounds, this.text = '', this.imagePng, this.fontColorArgb});
final Rect bounds;
final String text;
final Uint8List? imagePng;
final int? fontColorArgb;
```

## AresWordScanner

`package:ares_word/src/ares_word_sdk.dart`

```dart
class AresWordScanner extends StatelessWidget
const AresWordScanner({super.key, required this.sdk, this.edgeSdkLicenceKey, this.isPro = false, this.scanMode = EdgeDetectionScannerMode.Balanced, this.templates, this.initialTemplateId, this.initialProcessingMode, this.initialScanOptions = const {}, this.onCustomiseTemplates, this.onTemplateSelected, this.onPickFromGallery, this.onUpgrade, this.initialWordSettings = const AresWordDocumentSettings(), this.initialWordDocumentOutput = AresWordDocumentOutput.editableDocument, this.initialNotesSettings = const AresNotesSettings(), this.initialHandwritingSettings = const AresHandwritingSettings()});
final AresWordSdk sdk;
final String? edgeSdkLicenceKey;
final bool isPro;
final EdgeDetectionScannerMode scanMode;
final List<AresOfficeScanTemplate>? templates;
final String? initialTemplateId;
final AresOfficeScanProcessingMode? initialProcessingMode;
final Map<String, String> initialScanOptions;
final AresOfficeTemplateManagerLauncher? onCustomiseTemplates;
final AresOfficeTemplateSelectionChanged? onTemplateSelected;
final AresOfficeGalleryPicker? onPickFromGallery;
final Future<void> Function()? onUpgrade;
final AresWordDocumentSettings initialWordSettings;
final AresWordDocumentOutput initialWordDocumentOutput;
final AresNotesSettings initialNotesSettings;
final AresHandwritingSettings initialHandwritingSettings;
Widget build(BuildContext context);
```

## AresWordSdk

`package:ares_word/src/ares_word_sdk.dart`

```dart
class AresWordSdk extends AresDomainSdk
AresWordSdk({required super.licenceKey, super.verifyLicence});
Future<AresWordDocumentLayout> loadLayout(String path);
Future<AresOfficeSaveResult> insertImage(String path, {required Uint8List bytes, required String fileName, required int afterSectionIndex, String? expectedSourceFingerprint});
Future<AresWordPicturesSnapshot> inspectPictures(String path);
Future<AresOfficeSaveResult> replacePicture(String path, {required int pictureId, required Uint8List bytes, String? expectedSourceFingerprint});
Future<AresOfficeSaveResult> setPictureMetadata(String path, {required int pictureId, String? name, String? title, String? description, String? expectedSourceFingerprint});
Future<AresOfficeSaveResult> setPictureSize(String path, {required int pictureId, required double widthPoints, required double heightPoints, bool lockAspectRatio = true, String? expectedSourceFingerprint});
Future<AresOfficeSaveResult> deletePicture(String path, {required int pictureId, String? expectedSourceFingerprint});
Future<AresWordCommentsSnapshot> inspectComments(String path);
Future<List<AresWordComment>> comments(String path);
Future<AresWordCommentCreationResult> addComment(String path, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentCreationResult> addCommentThread(String path, {required int sectionIndex, required String text, required String author, String? initials, int? startOffset, int? endOffset, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> migrateLegacyComments(String path, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> replaceCommentText(String path, String id, String text, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeAllLegacyComments(String path, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeComment(String path, String id, {String? expectedSourceFingerprint});
Future<AresWordCommentThreadsSnapshot> inspectCommentThreads(String path);
Future<AresWordCommentOperationResult> replyToComment(String path, String parentId, {required String text, required String author, String? initials, DateTime? date, String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> replaceThreadCommentText(String path, String id, String text, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeCommentReply(String path, String commentId, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> removeCommentThread(String path, String rootCommentId, {String? expectedSourceFingerprint});
Future<AresWordCommentOperationResult> setCommentThreadResolved(String path, String rootCommentId, {required bool resolved, String? expectedSourceFingerprint});
Future<List<AresWordBookmark>> bookmarks(String path);
Future<AresOfficePageOperationResult> addBookmark(String path, {required int sectionIndex, required String name, int? startOffset, int? endOffset, int? endSectionIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> redefineBookmark(String path, {required String name, required int sectionIndex, int? startOffset, int? endOffset, int? endSectionIndex, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> renameBookmark(String path, {required String name, required String newName, String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> removeBookmark(String path, String name, {String? expectedSourceFingerprint});
Future<List<AresWordRevision>> revisions(String path);
Future<AresOfficePageOperationResult> reviewRevisions(String path, List<AresWordRevision> revisions, AresWordRevisionDecision decision, {String? expectedSourceFingerprint});
Future<AresOfficePageOperationResult> reviewRevision(String path, AresWordRevision revision, AresWordRevisionDecision decision, {String? expectedSourceFingerprint});
Future<AresOfficeScanGenerationResult?> scanToFile({required BuildContext context, required String outputPath, String? edgeSdkLicenceKey, bool isPro = false, AresWordScanner? scanner, AresOfficePageRecognizer? recognizePages});
```

## AresWordSectionPageBounds

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordSectionPageBounds = ({int pageNumber, Rect rect});
```

## AresWordTabAlignment

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordTabAlignment { left, center, right, decimal, bar }
```

## AresWordTabLeader

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordTabLeader { none, dot, hyphen, underscore, heavy, middleDot }
```

## AresWordTabStop

`package:ares_office_core/src/office_document.dart`

```dart
class AresWordTabStop
const AresWordTabStop({required this.positionPoints, this.alignment = AresWordTabAlignment.left, this.leader = AresWordTabLeader.none});
final double positionPoints;
final AresWordTabAlignment alignment;
final AresWordTabLeader leader;
```

## AresWordTableBlock

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordTableBlock extends AresWordBlock
const AresWordTableBlock({required super.sectionIndex, required this.tableIndex, required this.rows, required this.columnWidthsTwips, required this.maximumColumns, required this.borderColor, required this.borderWidth});
final int tableIndex;
final List<AresWordTableRow> rows;
final List<int> columnWidthsTwips;
final int maximumColumns;
final Color borderColor;
final double borderWidth;
```

## AresWordTableCell

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordTableCell
const AresWordTableCell({required this.gridColumn, required this.gridSpan, required this.paragraphs, required this.backgroundColor, required this.padding, required this.verticalAlignment, this.textDirection = 'lrTb', required this.border});
final int gridColumn;
final int gridSpan;
final List<AresWordParagraphBlock> paragraphs;
final Color? backgroundColor;
final EdgeInsets padding;
final MainAxisAlignment verticalAlignment;
final String textDirection;
final Border border;
```

## AresWordTableCellBuilder

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordTableCellBuilder = Widget Function(int sectionIndex, int row, int column, AresWordTableCell cell, double scale);
```

## AresWordTableCellCaretRequest

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordTableCellCaretRequest = void Function(int sectionIndex, int row, int column, int textOffset);
```

## AresWordTableDateFormat

`package:ares_office_core/src/office_word_table_sort.dart`

```dart
enum AresWordTableDateFormat { yearMonthDay, dayMonthYear, monthDayYear }
```

## AresWordTableRow

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordTableRow
const AresWordTableRow({required this.cells, this.minimumHeightPoints, this.heightRule = 'atLeast', this.repeatAsHeader = false, this.preventPageBreak = false});
final List<AresWordTableCell> cells;
final double? minimumHeightPoints;
final String heightRule;
final bool repeatAsHeader;
final bool preventPageBreak;
```

## AresWordTableSortKey

`package:ares_office_core/src/office_word_table_sort.dart`

```dart
class AresWordTableSortKey
const AresWordTableSortKey(this.column, {this.type = AresWordTableSortType.text, this.descending = false, this.caseSensitive = false, this.dateFormat = AresWordTableDateFormat.yearMonthDay});
final int column;
final AresWordTableSortType type;
final AresWordTableDateFormat dateFormat;
final bool descending, caseSensitive;
```

## AresWordTableSortType

`package:ares_office_core/src/office_word_table_sort.dart`

```dart
enum AresWordTableSortType { text, number, date }
```

## AresWordTableSorting

`package:ares_office_core/src/office_word_table_sort.dart`

```dart
abstract final class AresWordTableSorting
static List<int> order(List<List<String>> cells, {required List<AresWordTableSortKey> keys, int headerRows = 1});
static String reorder(String source, List<int> order);
```

## AresWordTableStylePreset

`package:ares_office_core/src/office_document.dart`

```dart
enum AresWordTableStylePreset { plain, grid, header, bandedRows }
```

## AresWordTextRun

`package:ares_office_core/src/word_file_preview.dart`

```dart
class AresWordTextRun
const AresWordTextRun({required this.text, required this.style});
final String text;
final AresWordRunStyle style;
```

## AresWordTextSelectionRequest

`package:ares_office_core/src/word_file_preview.dart`

```dart
typedef AresWordTextSelectionRequest = void Function(int sectionIndex, TextSelection selection);
```

## DocxToFlutter

`package:ares_office_core/src/word_file_preview.dart`

```dart
class DocxToFlutter extends StatefulWidget
const DocxToFlutter({super.key, required this.file, this.padding = const EdgeInsets.only(bottom: 24), this.sectionIndex = 0, this.onSectionEditRequested, this.onSectionCaretRequested, this.onTextSelectionChanged, this.onSectionViewportBoundsChanged, this.onSectionPageBoundsChanged, this.onRedactionGeometryChanged, this.onBlankPageEditRequested, this.inlineParagraphBuilder, this.inlineParagraphSectionIndex, this.persistentInlineParagraphSections = const <int>{}, this.inlineTableCellBuilder, this.onTableCellCaretRequested, this.inlineParagraphListMarkerBuilder, this.inlineParagraphLeftIndentBuilder, this.mediaOverlayBuilder, this.pageOverlayBuilder, this.enableZoom = false, this.transformationController, this.onPageMetricsChanged, this.layoutFuture, this.pageGeometryOverride, this.displayMode = AresOfficeDisplayMode.continuous, this.pageFitMode = AresOfficePageFitMode.fitWidth, this.onPhotoTextRequested, this.photoTextBusy = false, this.initialPage = 0, this.bottomObscured = 0});
final ValueChanged<AresWordPhotoTextRequest>? onPhotoTextRequested;
final bool photoTextBusy;
final double bottomObscured;
final bool enableZoom;
final TransformationController? transformationController;
final ValueChanged<({int page, int pageCount})>? onPageMetricsChanged;
final Future<AresWordDocumentLayout>? layoutFuture;
final AresWordPageGeometryOverride? pageGeometryOverride;
final AresOfficeDisplayMode displayMode;
final AresOfficePageFitMode pageFitMode;
final int initialPage;
final Widget Function(Size, Set<int>)? mediaOverlayBuilder;
final Widget Function(Size, Set<int>, int)? pageOverlayBuilder;
final File file;
final EdgeInsets? padding;
final int sectionIndex;
final ValueChanged<int>? onSectionEditRequested;
final AresWordCaretRequest? onSectionCaretRequested;
final AresWordTextSelectionRequest? onTextSelectionChanged;
final ValueChanged<Map<int, Rect>>? onSectionViewportBoundsChanged;
final ValueChanged<Map<int, AresWordSectionPageBounds>>? onSectionPageBoundsChanged;
final ValueChanged<AresWordRedactionGeometry>? onRedactionGeometryChanged;
final ValueChanged<int>? onBlankPageEditRequested;
final Widget Function(AresWordParagraphBlock, double)? inlineParagraphBuilder;
final int? inlineParagraphSectionIndex;
final Set<int> persistentInlineParagraphSections;
final AresWordTableCellBuilder? inlineTableCellBuilder;
final AresWordTableCellCaretRequest? onTableCellCaretRequested;
final String? Function(AresWordParagraphBlock)? inlineParagraphListMarkerBuilder;
final double? Function(AresWordParagraphBlock)? inlineParagraphLeftIndentBuilder;
State<DocxToFlutter> createState();
```

## EdgeDetectionScannerMode

`package:ares_defence_labs_embedded_edge_detection/edgeTypes.dart`

```dart
enum EdgeDetectionScannerMode { LowResFast, Balanced, UltraDetailed }
```

## ExtractedOfficeImage

`package:ares_office_core/src/office_embedded_image_extractor.dart`

```dart
class ExtractedOfficeImage
const ExtractedOfficeImage({required this.path, required this.packagePath, required this.bytes});
final String path;
final String packagePath;
final int bytes;
```

## FileType

`package:ares_office_core/src/file_type_detector.dart`

```dart
enum FileType { image, video, word, excel, csv, powerpoint, text, md }
```
