import 'package:ares_word/ares_word.dart';

// Input is a supported editable DOCX whose first section is a plain paragraph.
Future<AresOfficeDocument> authorDocument(AresWordSdk sdk, String path) async {
  final session = await sdk.edit(await sdk.load(path));
  try {
    session.replaceWordTextRangePreservingRuns(0, 0, 0, 'Project update: ');
    session.formatWordTextRange(0, 0, 7,
      const AresOfficeFormatChange(sectionIndex: 0, bold: true));
    session.insertWordParagraph(0, 'Next steps and review notes.');
    session.insertWordTable(1, 2, 2);
    session.setWordTableCell(2, 0, 0, 'Owner');
    return (await sdk.save(session)).document;
  } finally {
    session.dispose();
  }
}

// Demonstrates persisted bookmark and legacy-comment lifecycle. Each mutation
// uses the newly committed fingerprint. Do not run alongside a dirty session.
Future<void> reviewDocument(AresWordSdk sdk, String path) async {
  var document = await sdk.load(path);
  var changed = await sdk.addBookmark(path, sectionIndex: 0, name: 'ReviewStart',
    expectedSourceFingerprint: document.sourceFingerprint);
  changed = await sdk.renameBookmark(path, name: 'ReviewStart', newName: 'ReviewHere',
    expectedSourceFingerprint: changed.document.sourceFingerprint);
  changed = await sdk.removeBookmark(path, 'ReviewHere',
    expectedSourceFingerprint: changed.document.sourceFingerprint);
  final snapshot = await sdk.inspectComments(path);
  if (!snapshot.canCreate) return;
  final created = await sdk.addComment(path, sectionIndex: 0, text: 'Please check.',
    author: 'Reviewer', expectedSourceFingerprint: snapshot.sourceFingerprint);
  final edited = await sdk.replaceCommentText(path, created.commentId, 'Checked.',
    expectedSourceFingerprint: created.document.sourceFingerprint);
  await sdk.removeComment(path, created.commentId,
    expectedSourceFingerprint: edited.document.sourceFingerprint);
}

// The host confirms this supported subset and displays the remaining count.
Future<void> acceptSupportedRevisionBatch(AresWordSdk sdk, String path) async {
  final document = await sdk.load(path);
  final revisions = await sdk.revisions(path);
  final supported = revisions.where((r) => r.canReview).toList();
  if (supported.isEmpty) return;
  await sdk.reviewRevisions(path, supported, AresWordRevisionDecision.accept,
    expectedSourceFingerprint: document.sourceFingerprint);
}

Future<void> bookmarkParagraphSpan(AresWordSdk sdk, String path, int first, int last) async {
  final document = await sdk.load(path);
  if (first < 0 || last <= first || last >= document.sections.length) return;
  await sdk.addBookmark(path, sectionIndex: first, endSectionIndex: last,
    name: 'ReviewSpan', startOffset: 0, endOffset: document.sections[last].text.length,
    expectedSourceFingerprint: document.sourceFingerprint);
}

Future<void> redefineVisibleBookmark(AresWordSdk sdk, String path, int targetSection) async {
  final document = await sdk.load(path);
  final visible = (await sdk.bookmarks(path)).where((b) => !b.hidden).toList();
  if (visible.isEmpty) return;
  await sdk.redefineBookmark(path, name: visible.first.name, sectionIndex: targetSection,
    expectedSourceFingerprint: document.sourceFingerprint);
}

// Requires a simple table with at least two columns at tableSectionIndex.
Future<AresOfficeDocument> sortDocumentTable(AresWordSdk sdk, String path,
    int tableSectionIndex) async {
  final session = await sdk.edit(await sdk.load(path));
  try {
    session.sortWordTable(tableSectionIndex, headerRows: 1,
      keys: const [AresWordTableSortKey(0),
        AresWordTableSortKey(1, type: AresWordTableSortType.number, descending: true)]);
    return (await sdk.save(session)).document;
  } finally { session.dispose(); }
}

// Inspect the chosen column and explicitly match its calendar format.
Future<AresOfficeDocument> sortDocumentDates(AresWordSdk sdk, String path,
    int tableSectionIndex, int column, AresWordTableDateFormat format) async {
  final session = await sdk.edit(await sdk.load(path));
  try {
    session.sortWordTable(tableSectionIndex, keys: [AresWordTableSortKey(column,
      type: AresWordTableSortType.date, dateFormat: format)]);
    return (await sdk.save(session)).document;
  } finally { session.dispose(); }
}

// User explicitly chooses one supported revision after inspecting its metadata.
Future<void> acceptFirstSupportedRevision(AresWordSdk sdk, String path) async {
  final document = await sdk.load(path);
  final revisions = await sdk.revisions(path);
  for (final revision in revisions) {
    if (!revision.canReview) continue;
    await sdk.reviewRevision(path, revision, AresWordRevisionDecision.accept,
      expectedSourceFingerprint: document.sourceFingerprint);
    break; // Reinspect after each committed revision decision.
  }
}


Future<void> clearLegacyReview(AresWordSdk sdk, String path) async {
  final snapshot = await sdk.inspectComments(path);
  if (snapshot.restriction != null || snapshot.comments.isEmpty ||
      snapshot.comments.any((c) => !c.canDelete)) return;
  // Confirm this whole-document deletion with the user first.
  await sdk.removeAllLegacyComments(path,
    expectedSourceFingerprint: snapshot.sourceFingerprint);
}

// An existing supported Word 2013 graph or a comment-free file.
Future<void> createThreadInSupportedGraph(AresWordSdk sdk, String path) async {
  final inspected = await sdk.inspectComments(path);
  if (inspected.threads?.canCreateRoot != true && !inspected.canStartThread) return;
  final root = await sdk.addCommentThread(path, sectionIndex: 0,
    text: 'Review this paragraph.', author: 'Reviewer',
    expectedSourceFingerprint: inspected.sourceFingerprint);
  final reply = await sdk.replyToComment(path, root.commentId,
    text: 'Checking.', author: 'Reviewer',
    expectedSourceFingerprint: root.document.sourceFingerprint);
  // Delete only the reply: the independently authored root remains.
  await sdk.removeCommentReply(path, reply.commentId,
    expectedSourceFingerprint: reply.document.sourceFingerprint);
}

Future<void> convertPlainLegacyComments(AresWordSdk sdk, String path) async {
  final inspected = await sdk.inspectComments(path);
  if (!inspected.canMigrateToThreads) return;
  await sdk.migrateLegacyComments(path,
    expectedSourceFingerprint: inspected.sourceFingerprint);
}

Future<void> replyAndResolve(AresWordSdk sdk, String path, String rootId) async {
  final inspected = await sdk.inspectComments(path);
  final state = inspected.threads?.stateFor(rootId);
  if (state == null || !state.canReply || !state.canResolve) return;
  final reply = await sdk.replyToComment(path, rootId, text: 'Reviewed.',
    author: 'Reviewer', expectedSourceFingerprint: inspected.sourceFingerprint);
  await sdk.setCommentThreadResolved(path, rootId, resolved: true,
    expectedSourceFingerprint: reply.document.sourceFingerprint);
}
