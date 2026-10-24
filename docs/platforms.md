# Platforms and host setup

## Required support

| Platform | Editor | Low-level document API | Camera scanner |
| --- | --- | --- | --- |
| Android | Full feature support required | Full feature support required | Supported mobile target |
| iOS | Full feature support required | Full feature support required | Supported mobile target |
| macOS | Full feature support required | Full feature support required | Not supported |
| Windows | Full feature support required | Full feature support required | Not supported |
| Linux | Full feature support required | Full feature support required | Not supported |
| Web | Full feature support required | Full feature support required | Not supported |

The desktop/web editor and API scope must not be reduced to viewing or extraction.
Creation, editing, rendering, save/reopen, undo/redo, licensing and the supported
file-format feature set must work on every target. The native camera, crop and
OCR workflow is available only in native Android/iOS apps. Web scanning is
unavailable, including browsers running on phones.

`AresOfficePlatforms.editorTargets` and `documentApiTargets` record the six-platform
requirement; they are not runtime certification. `scannerTargets` contains only
Android/iOS. `AresOfficePlatforms.canScan` checks runtime platform availability,
not camera permission/hardware or the product licence. The lightweight
`package:ares_word/platforms.dart` library imports no camera, OCR, filesystem or
editor code. Use it to hide Scan actions outside mobile.

## Current implementation gaps

The source has conditional file/path adapters, native desktop files, durable
IndexedDB browser documents and byte import/export. All three full SDKs compile
for web and pass synthetic licensed document round trips in an isolated test
fixture. Browser media uses local Blob URLs; Windows/Linux media use a native
backend. Codec support depends on the runtime and must be verified per platform.

Android/iOS retain native product verification. Desktop/web verify signed
customer-wide grants; app-bound and owner/admin grants fail closed there. See
[licensing](licensing.md). Browser document processing does not invoke a native
camera or require camera permission. Scan actions are hidden outside Android/iOS.

Current source evidence: 1,061 regression tests passed (one existing skip).
Linux ARM64 passed 37 licensing/storage/byte/guard tests and 17 editor checks.
All three browser editors saved UI edits verified in fresh-page ZIP bytes; the
browser API round trips and local WAV media path passed. A disposable macOS 14
host built and ran all three SDK API round trips. macOS UI interaction and
clean-host customer installations remain unverified. These checks use synthetic
documents and isolated ephemeral test trust, not production customer/admin grants.

The current private dependency graph requires macOS 14 because of ONNX even
though scanning is mobile-only. Final modular dependencies and minimum OS
contracts are release gates; do not infer a customer minimum from this test host.

Protected processing binaries, customer installation and exact-candidate runtime
certification remain release gates. Windows runtime checks are explicitly deferred
to the customer team because no Windows runner is available. Source tests, a web
build or platform metadata alone do not establish full platform certification.

The source requires Dart ^3.12.0 and Flutter >=3.44.0. Final customer minimum OS
versions and native ABIs remain to be certified; the reference Edge native build
uses Android API 24 and iOS 16. Those are not tested Office minimum versions.

## Mobile scanner setup

On Android, declare `android.permission.CAMERA`, request runtime permission and
handle denial. Supply writable app storage and the correct application ID and
release signing identity. On iOS, provide `NSCameraUsageDescription`, honor user
permission and app lifecycle, use writable app storage and match the issued
bundle/application identity. Add photo-library descriptions only when your chosen
gallery integration requires them. Never copy a sample app's signing settings.

Capture requires a real camera-capable device or a separately documented emulator
camera setup. Desktop/widget tests exercise model and UI behavior, not a mobile
camera or native licence gate. No independent licensed customer candidate is
certified by the source/widget tests or synthetic screenshots.

Native release work still requires Android AAR/ABI validation, iOS device and
simulator XCFramework linking, dependency/runtime checks, background/foreground
behavior, permission retry, low-memory capture and clean-host installation.
See [release status](release-status.md).
