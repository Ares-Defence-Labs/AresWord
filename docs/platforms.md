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
OCR workflow is Android/iOS only, including when the browser runs on a phone.

`AresOfficePlatforms.editorTargets` and `documentApiTargets` record the six-platform
requirement; they are not runtime certification. `scannerTargets` contains only
Android/iOS. `AresOfficePlatforms.canScan` checks runtime platform availability,
not camera permission/hardware or the product licence. The lightweight
`package:ares_word/platforms.dart` library imports no camera, OCR, filesystem or
editor code. Use it to hide Scan actions outside mobile.

## Current implementation gaps

The development licence gate currently uses a private Android/iOS plugin.
Desktop/browser licensing is unfinished. The full editor/API import also reaches
`dart:io` and mobile camera/OCR dependencies. It must be separated with conditional
adapters before claiming browser support. Changing pubspec platform metadata alone
does not establish support.

Native desktop hosts need file-picker/storage adapters and protected licensed
processing builds. Browser hosts need byte/document-handle and asynchronous
storage/download adapters without `dart:io`, plus the protected browser processing
and licensing boundary. Mobile imports must not be required to compile or use
desktop/web editors and APIs. These are mandatory release gates.

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
