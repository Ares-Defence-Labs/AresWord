# Troubleshooting AresWord

| Symptom | Likely cause | Recovery |
| --- | --- | --- |
| Licence verification failed | Missing/expired/wrong-product/signature or unsupported binding | Obtain the correct `AresWordSDK` grant; check [licensing](licensing.md). A host callback returning true cannot authorize it. |
| Scanner unavailable | Desktop/web target or denied mobile camera permission | Hide scan action outside Android/iOS; handle permission denial/lifecycle on devices. |
| Scan cancelled | User left capture/review | `scanToFile` returns null; do not open a nonexistent output. |
| Empty/incorrect OCR | Unreadable image, wrong crop or unsupported layout | Recapture clear text/table; review before generation. Preserve source captures per host policy. |
| Wrong format/template | Cross-domain input, extension or template | Use this SDK's extensions/template catalog; scanner outputs `.docx` only. |
| Document operation unsupported | Protection, ambiguous linked graph or unsupported native structure | Inspect restrictions, retain original, offer a narrower action. Do not flatten silently. |
| Save conflict | File changed externally or another browser tab committed | Reload/reconcile; use current fingerprint. Never blind overwrite/retry. |
| Save/export failed | Destination collision/permissions/disk/quota | Choose a writable new path; keep pending work. Native import requires an absolute path. |
| Browser document missing | Changed origin, cleared/evicted/private-mode storage | Restore host backup/import; IndexedDB is not a backup service. |
| Controller not ready | Workspace still loading or detached | Wait for document readiness; controller commands do not force a successful load. |
| Media cannot play | Unsupported codec/container/runtime | Check host files and actual platform codecs; preserved media metadata is not playback acceptance. |

Include package/source version, platform/runtime, sanitized exception type,
operation and a minimal synthetic reproduction in a support report. Never upload
real customer documents, phone captures, licence strings or signing material to
a public issue. [Support](../SUPPORT.md) · [Security](../SECURITY.md)

Full Microsoft feature parity and protected customer release acceptance remain
unfinished. Review [compatibility](compatibility.md) and [release status](release-status.md)
before interpreting a missing feature as a supported contract regression.
