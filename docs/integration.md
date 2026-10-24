# Integrating AresWord

There is no approved customer package in this repository yet. Do not use this
documentation repository as a Git dependency. The examples describe the current
private development API and will be compiled against the eventual candidate.
Do not copy private source dependencies into a public application.

1. Obtain the approved `ares_word` package when released and a `AresWordSDK`
   token with the supported binding for your platform: identity-bound on mobile,
   customer-wide on desktop/web. Scanning is included on Android/iOS.
2. Complete the [Android/iOS setup](platforms.md).
3. Construct `AresWordSdk(licenceKey: customerToken)` once per intended configuration.
4. Call `sdk.scanToFile(context: context, outputPath: absolutePath)` from an active
   Flutter route. It returns `null` on cancellation and throws on failure.
5. Open the returned `result.path` with `AresWordEditor`, using the same SDK instance.
6. Catch failures, retain source captures until the result is verified, and let
   users review recognition before saving. The host owns storage and cleanup.

The [complete example](../examples/scan_and_edit.dart) uses a build-time value
instead of embedding a real token in source. A client token is still recoverable
from a client app; native signature and app binding establish authorization.
Do not ship signing keys or owner grants.

Use `sdk.load(path)` → `sdk.edit(document)` → `sdk.save(session, outputPath: path)`
for [file operations](../examples/file_operations.dart). Dispose sessions when
finished. Save pending edits before calling a file-based native OOXML operation;
use the snapshot fingerprint where supported to reject stale writes.

Editors and low-level APIs must support all six Flutter platforms. The scan
example is mobile-only; desktop/web hosts open existing documents with the
editor/API without initializing a scanner. Use
`AresOfficePlatforms.canScan` to decide whether to show a Scan action. The
[platform guide](platforms.md) separates this requirement from current gaps.


Start with [getting started](getting-started.md) for editor-first and byte-import workflows.
