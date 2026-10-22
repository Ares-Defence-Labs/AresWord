# Distribution security and assets

## Required boundary and current gap

The intended customer architecture follows AresEdge and AresIdentity: public
Dart APIs/DTOs and thin adapters, compiled mobile/desktop processing and a protected
browser-compatible processing boundary, mobile-only camera implementations,
product/app/signature/expiry enforcement on all six editor/API platforms, and authenticated
encrypted model resources. It excludes private processing source, owner delivery
services, issuer tools, test trust, credentials and debug symbols/mappings.

**Office currently uses private Dart implementation and path dependencies.**
Publicly copying those packages, obfuscating Dart names or encrypting a source
archive does not establish the required native boundary. Existing broad core
exports also need authorization/bypass review. This repository contains no
installable customer binaries and makes no binary-protection claim.

## Models and other files

Reserve `ares_word_inferencer.aem` for the product's encrypted camera-model resource.
That filename is a packaging proposal, not evidence that an Office reader or
model has been built. Adopt the existing authenticated AES-256-GCM `.aem` design
with verified readers; reject corrupt/truncated containers and cleartext
replacements. Raw ONNX/TFLite/checkpoints must not be shipped, including renamed
files or files inside nested AAR/JAR/ZIP archives.

Reference Android readers use direct memory buffers. The reference iOS runtime
uses a protected transient model file when required, deleting it after session
creation or failure. These properties must be reverified for each Office binary.
Offline keys embedded in compiled code can be extracted by a host controlling
the process. Encryption raises extraction cost; it is not tamper-proof protection.

Templates, fonts, icons and screenshots need an explicit inventory and
redistribution review. Readable documentation screenshots are intentional and
must not become Flutter runtime assets. `docs/public-assets.json` records their
hashes. The manifest records all other public files; a hash inventory detects
changes relative to a snapshot and is not a publisher signature or security audit.

Office documents and source captures are customer data, not model containers.
The host owns access controls, storage encryption, consent, cleanup, retention
and transport. Default mobile OCR is on device; custom callbacks may change that.
No claim is made that deleting a temporary file erases other retained copies.

## Release verification

Require independent native product isolation, production issuer pins, no sandbox
trust, bounded nested archive checks, raw-model fingerprint checks, source/shim
allowlists, secret scans, ABI checks, third-party notices and reviewed build/package
receipts. Run pub dry-run on a disposable copy; keep the reviewed upload tree
unchanged. These checks require actual release binaries and remain open.
See [release status](release-status.md) and [reporting](../SECURITY.md).
