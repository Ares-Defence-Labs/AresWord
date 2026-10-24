# Customer package preparation

The public repository is documentation only. The private source package and
this repository are both unsuitable for direct publication. The
[pubspec blueprint](../packaging/pubspec.yaml) is disabled and incomplete by
design. Its screenshot paths describe a future package root.

## Intended customer layout

```text
ares_word/
  pubspec.yaml                 # final audited hosted/SDK dependencies
  lib/ares_word.dart           # supported public API and DTOs
  lib/scanner.dart             # product scanner API
  lib/src/                    # thin adapters, no private processing engine
  android/                    # compiled product AAR and minimal registration
  ios/                        # stripped device/simulator XCFramework and registration
  macos/Binaries/             # checksum-bound local .xcframework.zip artifacts
  docs/assets/screenshots/    # readable documentation only
  LICENSE                     # reviewed customer terms
  THIRD_PARTY_NOTICES.md       # dependency/model/font redistribution notices
```

The Android/iOS scanner artifact/resource bundles must contain the authenticated
encrypted model; they must not contain raw ONNX or private source. Camera/OCR
resources must not be required by desktop/web editors or document APIs. The
editor/API processing boundary needs compiled desktop/mobile implementations
and a protected browser-compatible adapter/runtime, with licensing on all six
targets. Exact registration class names,
ABI versions, resources and native dependencies must be determined from working
builds; none are fabricated in the blueprint.

Final Android shared libraries and the exact consumer APK must pass 16 KB
ELF LOAD/RELRO and ZIP-offset checks plus a real 16 KB runtime test. Flags on
static archives alone cannot prove compatibility. macOS versioned frameworks must
retain bytes, modes and internal symlinks inside checksum-bound local
`.xcframework.zip` artifacts: pub materializes outer-package symlinks and can break
strict signatures. SwiftPM local ZIP and CocoaPods verified extraction both need
clean release consumer builds and complete-app deep strict codesign. These checks
follow the corrected PDF process; PDF receipts do not certify Office artifacts.
All four new artifact/consumer acceptance flags remain false until verified.

Exclude private source/helpers, issuer tooling, owner grants/store assets,
development model delivery, test-only trust, credentials, debug maps, build caches
and local dependency overrides. Use an allowlist-based assembler, then audit the
entire final package including nested AAR/JAR/ZIP contents. A `.pubignore` file
alone cannot establish that the package is safe.

## Review sequence

1. Complete the native boundary and all [release gates](release-status.md).
2. Freeze the adapter API, produce the native artifacts reproducibly and record
   ABI/provenance hashes. Compile all examples against that exact package.
3. Verify app/product/expiry/signature and sandbox isolation on production-trust
   builds, plus independent owner/admin behavior in the owner app.
4. Exercise editor/API creation, rendering, editing, saving, reopening, undo/redo
   and licensing on Android/iOS/macOS/Windows/Linux/web. Exercise capture, crop,
   OCR and review on Android/iOS only, including permission/lifecycle failures.
5. Review package contents and redistribution rights, then freeze the package.
6. Run `dart pub publish --dry-run` (or the Flutter equivalent for the final
   Flutter package) from a disposable copy. Review warnings and size/dependency
   validation. Record a receipt for the unchanged reviewed upload tree.
7. Publish only after a separate deployment/publication instruction. This
   preparation provides no publication authorization.

The final manifest needs plugin registrations, declared runtime resources and
versioned redistributable dependencies. pub.dev requires hosted/SDK dependencies;
private filesystem paths do not satisfy that requirement. Screenshots are package
page metadata and must not be added as Flutter runtime assets unless needed by
the actual product. See the official
[pubspec reference](https://dart.dev/tools/pub/pubspec) and
[publishing guide](https://dart.dev/tools/pub/publishing).
