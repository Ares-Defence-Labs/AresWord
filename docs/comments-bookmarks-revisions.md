# Word comments, bookmarks and tracked revisions

These APIs mutate the saved Word package. Save or resolve pending session edits
first, inspect current metadata and pass the current source fingerprint.
[Executable signatures and recipes](../examples/document_workflows.dart)

## Native bookmarks

`bookmarks` lists main-story markers. `addBookmark` anchors a supported paragraph
or a UTF-16 range when both offsets are supplied. `renameBookmark` updates
supported internal references without moving the range; `removeBookmark` removes
markers while retaining content. Names use 1–40 letters/numbers/underscores and
start with a letter. Hidden/unsupported locations can have null section/offsets.

`addBookmark` and `redefineBookmark` accept `endSectionIndex` with both offsets
for supported multi-paragraph main-body ranges. Start/end offsets are local to
their respective paragraphs. Different endpoints must be ordinary main-body
paragraphs in document order; unsupported endpoint stories/content reject.
Runs, links and intermediate content survive; invalid raw spans leave XML
unchanged. The Word View ribbon offers Bookmark paragraph range for whole
paragraphs with source/permission checks and saved undo. Arbitrary multi-paragraph
character selection, table-column/other-story authoring and full native reference
conformance remain open. Inspection excludes paragraph tab-stop definitions from
visible character offsets.

These are persisted Word ranges. The viewer controller's `toggleBookmark` is an
in-memory navigation marker and never writes a WordprocessingML bookmark.

## Comments and supported threads

`inspectComments` returns comments, source fingerprint and restrictions. Check
`canCreate` before adding and `canReplaceText` / `canDelete` on individual comments.
`addComment` returns a `commentId`, reopened document and updated snapshot.
`replaceCommentText` updates supported plain bodies; rich/linked bodies may stay
read-only. `removeComment` preserves surrounding document content.
`removeAllLegacyComments(path, expectedSourceFingerprint:)` removes all supported
legacy comments and related-story anchors as one transaction, retaining the
empty owned part. Modern metadata, orphan anchors, ambiguous identities,
protection, empty batches or over 10,000 records reject the whole change. The
editor confirms the count, rechecks host permission and supports saved undo.

`inspectCommentThreads` describes supported Word 2013 reply associations. Check
thread `canReply` / root `canResolve` before `replyToComment` or
`setCommentThreadResolved`. Resolved/unsupported/overdeep graphs reject changes.
`replaceThreadCommentText` edits supported open plain Word 2013 bodies while
retaining the final paragraph ID and reply associations. `removeCommentThread`
deletes a supported root and all of its descendants/anchors. Check
`canEditText` / `canDeleteThread` on thread state first.
`removeCommentReply` removes one reply from an open supported thread; its direct
children attach to its parent, retaining their own bodies and identities. Check
`canDeleteReply` first. Root deletion remains an explicit whole-thread operation.

`addCommentThread` adds a root to a supported Word 2013 graph, or initializes
one in an **unrestricted, comment-free file**. Check `threads.canCreateRoot` for
an existing graph or `canStartThread` on the comment snapshot for a fresh one;
both are separate from legacy `canCreate`. Existing legacy comments are never
silently migrated. Supply a section and optional paired text offsets for its anchor.
The result includes `commentId`, reopened document and updated snapshot. Existing
thread associations, author identities and unrelated content remain intact.
The editor's Add comment uses this writer for supported existing graphs. In a
comment-free file, **Start thread** explicitly initializes a Word 2013 graph;
Add comment retains the legacy workflow. Both use saved undo, retained failed
drafts and permission rechecks after composition/confirmation. Initialization
allocates new parts and paragraph IDs without overwriting orphaned content.

`migrateLegacyComments` explicitly converts supported plain legacy comments into
independent Word 2013 roots. Check `canMigrateToThreads` on the fresh snapshot and
pass its source fingerprint. IDs, bodies, author/date fields, anchors and unrelated
parts are retained; no reply associations are guessed. The editor's Convert to
threads action confirms the change, rechecks permission and records saved undo.
The conversion accepts the legacy writer's supported plain body shapes; richer
paragraph metadata, rich/newer graphs and Microsoft 365 collaboration remain
unfinished. Conversion is never implicit in add/open/edit operations. These bounded operations do not
establish full Word comment or reference interoperability parity.

Durable modern/person-linked comment graphs are not blanket-supported. Reinspect
after each write; do not infer thread compatibility from the presence of comments.

Bookmark rename also retargets supported local HYPERLINK `\l` field targets
through related Word stories. External addresses must be absent or empty. Styled
split instructions and cached results survive. Tooltips/frames/formatting
arguments stay unchanged; unknown switches, duplicate/missing locations,
malformed quoting and nested/dynamic fields remain untouched. This does not add
full field calculation or arbitrary HYPERLINK authoring.

`redefineBookmark(path, name:, sectionIndex:, startOffset:, endOffset:,
endSectionIndex:, expectedSourceFingerprint:)` relocates an ordinary visible
bookmark while keeping its ID/name/references. Omit both offsets for a paragraph
or pass both UTF-16 offsets, optionally with an ending paragraph index for the
supported main-body multi-paragraph subset. The View ribbon's Redefine
bookmark action captures the selection, confirms a bookmark and joins saved undo.
Unsupported/ambiguous/column/hidden ranges reject, and raw XML remains unchanged
when destination validation fails. Arbitrary cross-paragraph character selection
in the editor and complete range affinity remain open. The existing bookmark panel also retains its
displayed path/version across background reloads; reopen after a source change.

## Revision review

`revisions` lists native tracked changes, including story/part, ID, kind, text,
author/date and `unsupportedReason`. A revision's `canReview` controls whether
`reviewRevision(..., accept/reject)` can transform it. Unsupported structural or
nested changes are retained. `reviewRevisions(path, revisions, decision,
expectedSourceFingerprint:)` applies an explicit selection of 1–10,000 distinct
supported records atomically; missing/unsupported/duplicate/protected targets
reject the whole save. Reinspect after every committed decision. The editor's
Accept supported / Reject supported actions confirm the selected and remaining
unsupported counts and join saved undo as one action. Both individual and batch
review bind to the displayed path/version and recheck host permission; reopen
after a background reload. This remains bounded revision review, with native
change-tracking authoring, nested/move/structural decisions and full review
rendering unfinished.

A fingerprint detects stale package state; it does not make author metadata an
authenticated identity. Present actual restrictions to the user and retain an
original copy. [Feature limits](compatibility.md)
