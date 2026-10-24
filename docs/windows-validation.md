# Windows acceptance — deferred to the customer team

No Windows runner is available in the current preparation environment. Windows
runtime certification is pending; Linux tests and browser checks do not replace it.

When a protected installable candidate is available, use a clean Windows host
and record Windows/Flutter versions, CPU architecture and exact package hashes.
Run Flutter analysis/tests and build/run the release example with a customer-wide
`AresWordSDK` grant. Validate valid, expired, wrong-product, modified-signature,
missing-grant and unsupported app-bound/admin cases. A host callback returning
true must never authorize a rejected grant.

Import a real `DOCX` document through a file picker, edit and format it,
save, close, reopen, export bytes and verify in Microsoft Office. Test autosave,
undo/redo, save-as, protected/read-only paths, non-ASCII paths, missing files,
external-change conflicts and disk-full/permission errors. Confirm failed saves
retain unsaved work. Test rendering, keyboard shortcuts, selection, clipboard,
zoom, accessibility, dialogs and native media codec/error behavior.

Every scanner entry point must reject Windows before camera/plugin calls, and
Scan/Camera actions must be absent. Also run the browser example on Windows:
validate reload persistence, export/download, cross-tab save conflicts and quota
errors. Record any unsupported feature against the compatibility guide instead
of marking the platform complete. Do not publish or deploy during validation.
