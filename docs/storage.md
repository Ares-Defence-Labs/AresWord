# Native files and browser documents

Import `package:ares_word/storage.dart` for the storage API without editor or
scanner widgets. Storage access alone never grants a product licence.

Use `await sdk.loadBytes(name: 'document.docx', bytes: pickedBytes)` on web.
The SDK checks authorization and validates the document before importing it.
Use the returned document's `path` when opening the editor. On native platforms,
also supply an absolute writable destination with `path:`. Names must be a single
filename with the domain's extension. Inputs larger than 128 MB are rejected.
`overwrite` defaults to false; explicit replacement is required for existing paths.

`await sdk.exportBytes(document.path)` authorizes and exports a consistent byte
snapshot. The host chooses a save dialog/download, sharing policy and permissions.
`AresOfficeStorage.list`, `open`, `readBytes` and `remove` manage host-selected
native paths or browser virtual documents. Native listing requires `directoryPath`.

Browser paths are virtual POSIX paths, not host disk paths or HTTP URLs. Documents
are stored in origin-scoped IndexedDB and restored after page reload. Atomic
read/write transactions reject conflicting saves from another browser tab;
`AresOfficeStorageConflict` leaves the existing document intact. Reopen the saved
version and ask the user to reconcile changes. Storage/quota failures are surfaced
as `AresOfficeStorageException`, not a successful save callback.

Browser storage is not encrypted by this API, permanent backup or cross-origin
sync. Private browsing, site data removal, quota eviction or origin changes may
remove access. Offer explicit exports and document retention in the host app.
Only temporary history uses transient memory; durable saves complete before
`onAutoSaved` / `onDocumentSaved`. Hosts must keep editors mounted until saves
complete or use the editor's normal guarded navigation flow.
