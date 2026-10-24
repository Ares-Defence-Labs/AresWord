# Compatibility and feature limits

Word bookmarks, supported tracked-revision review, legacy comments and supported Word 2013 replies/status/plain-body editing/whole-thread deletion have dedicated APIs. Rich-text selection fidelity, pagination/sections, fields/citations, modern comment formats, compare, mail merge and the remaining Microsoft feature set are unfinished. Protected/unsupported graph structures may be read-only.

New scanner output uses `.docx`. Native templates and supported macro-enabled
containers may preserve parts, but macro/VBA execution is not provided by that
preservation. Import support is not a guarantee of lossless editing or rendering.
Legacy binary formats and text/CSV conversions have different fidelity limits;
retain originals and test your actual document corpus.

Unknown parts should survive supported unrelated operations; unsupported edits
must be rejected rather than silently flattening a document. Preservation,
extraction, UI exposure and host callbacks do not establish full feature parity.

Full Microsoft Word/Excel/PowerPoint parity is the requested target and remains
unfinished. Compatibility must be recorded against explicit desktop Office builds
and exercised through save/reopen/re-edit, undo/redo and platform tests. No new
physical-device or admin-mode certification is claimed by these documentation
screenshots. See [release gates](release-status.md).
