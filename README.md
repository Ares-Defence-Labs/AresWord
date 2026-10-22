# AresWord

Flutter SDK for scanning documents into editable DOCX files, embedding
the AresWord editor, and creating, modifying and managing files through an API.
Each product has independent licensing, including its bundled scanner.

**Pre-release documentation.** This repository contains documentation, examples
and synthetic screenshots. It is not an installable SDK or a pub.dev release.
The protected customer package is being prepared. Full Microsoft Office feature
parity and release certification are unfinished; see [release status](docs/release-status.md).

| Entry | API |
| --- | --- |
| SDK | `AresWordSdk` |
| Capture through file generation | `sdk.scanToFile(...)` |
| Scanner widget | `AresWordScanner` |
| Embedded editor | `AresWordEditor` |
| File operations | `sdk.load`, `sdk.edit`, `sdk.save` |
| Scanner-only import | `package:ares_word/scanner.dart` |
| Complete import | `package:ares_word/ares_word.dart` |

| Required platform | Editor | Low-level file API | Scanner |
| --- | --- | --- | --- |
| Android | Required | Required | Mobile scanner |
| iOS | Required | Required | Mobile scanner |
| macOS | Required | Required | Unavailable |
| Windows | Required | Required | Unavailable |
| Linux | Required | Required | Unavailable |
| Web | Required | Required | Unavailable, including mobile browsers |

This is the release support requirement, not completed certification. Desktop
licensing and browser-compatible document/storage adapters remain release gates.

Start with [integration](docs/integration.md), [scanning](docs/scanning.md),
[editor integration](docs/editor.md) and the [API guide](docs/api-reference.md).
Also read [licensing](docs/licensing.md), [platform setup](docs/platforms.md),
[security and assets](docs/security-and-assets.md), [compatibility](docs/compatibility.md)
and [screenshots](docs/screenshots.md). The [packaging guide](docs/packaging.md)
records the customer artifact layout and publication checks.

![Synthetic scan review](docs/assets/screenshots/scan-review.png)
![Synthetic document editor](docs/assets/screenshots/editor.png)

These are actual Flutter SDK widgets rendered with synthetic fixtures in a test
harness. They do not demonstrate a camera session, customer licence or admin mode.
Example code is in [scan and edit](examples/scan_and_edit.dart) and
[file operations](examples/file_operations.dart). Package installation becomes
available only after the release gates pass. See [changelog](CHANGELOG.md).
