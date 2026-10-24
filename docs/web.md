# AresWord on the web

The editor and managed document APIs target browser Flutter builds. Native mobile
camera/crop/OCR scanning is unavailable in web builds, even on a phone.
`AresOfficePlatforms.canScan` is false and scanner entry points reject before
camera/plugin work. Use `AresWordEditor` for an imported document.

## Import, persist and export

1. Your host file picker obtains `.docx` bytes.
2. `sdk.loadBytes(name: 'document.docx', bytes: bytes)` authorizes, validates and
   imports into origin-local IndexedDB, returning the workspace `document.path`.
3. Open `AresWordEditor(sdk: sdk, documentPath: document.path)`.
4. After a completed save, call `sdk.exportBytes(document.path)` and let your
   host download or share the copied bytes. The SDK does not choose a browser
   download UI or send files to a remote service.
5. Use `AresOfficeStorage.list()` / `open(path)` to restore persisted documents
   after reload. Storage methods alone never grant processing authorization.

Do not pass a host disk path or HTTP URL as a browser document path. There is no
`dart:io` file-picker contract in the browser. The same storage origin must remain
available after reload; private browsing, site-data deletion, quotas or origin
changes can remove documents. Offer explicit exports/backups.

## Conflicts, licensing and runtime scope

Atomic IndexedDB saves detect conflicts from another tab. Handle
`AresOfficeStorageConflict` by reopening/reconciling; do not overwrite silently.
A successful save callback follows persistence, while a modified callback does not.

Current desktop/web source verification accepts pinned signed customer-wide
licences. App-bound/admin/owner grants fail closed there until a genuine identity
binding exists. Never insert an origin string or boolean verifier as a substitute.
Browser clients cannot keep signing secrets. [Licensing](licensing.md)

The source imports compile for web and synthetic API/editor round trips have
passed; this does not certify an installable protected runtime. Final browser
runtime/asset delivery and supported minimum browser versions remain release
gates. Do not copy PDF Wasm files, native artifacts or hosting instructions into
an Office deployment and assume they apply. [Platform evidence](platforms.md)

Blob-backed media depends on browser codecs and app lifecycle. Keep private
captures/documents out of URLs, analytics and logs. See [storage](storage.md)
and [security](security-and-assets.md).
