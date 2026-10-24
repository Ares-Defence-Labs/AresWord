# AresWord release process

**Pipeline preparation only.** No first AresWord version is approved and no customer
package is published by these documents. Version 0.1.0-dev.1 is proposed metadata,
not acceptance. Sales availability and publishing stay disabled until their
separate acceptance processes pass. Updating docs does not activate either one.

AresWord uses package `ares_word`, public documentation repository `https://github.com/Ares-Defence-Labs/AresWord` and
private release tags `ares_word-v{{version}}`. Word, Excel and PowerPoint have
independent configurations, reviews, tags, upload attempts and release state.
One product's licence or release approval cannot authorize another product.

The private process validates signed GitHub deliveries, queues work durably and
records exact source/version state. Existing release-bot Apps use short-lived
installation tokens limited to one repository and minimum permissions. Office
product webhook/runner secrets, queues and release databases stay separate. No
issuer signing secret belongs in a package, runner image, workflow or public repo.

Fresh isolated builds must produce protected Android/iOS/macOS/Windows/Linux/web
editor/API artifacts, mobile-only Android/iOS scanner binaries and authenticated
encrypted model resources. Source widget tests, a successful web build or copied
Edge/PDF receipts do not replace native, dependency, rights, platform or customer
acceptance. Native producers and clean customer artifacts remain unfinished.
Windows runtime validation was deferred to the customer team. GitHub required-
reviewer protection is unavailable on the current plan. The corrected local Office
pipeline instead requires independent Cloudflare-owner D1 approval bound to the
exact product/source/version/signed review and company publisher, in addition to
the independent signed review. This control is not deployed or accepted for Office;
effective review protection remains a blocking gate.

After a human accepts the exact product version/source, a signed review binds
candidate, dependency/native receipts, docs and upload inventories. Protected
product tags and effective review protection gate the private runner. Pub dry-run
uses a disposable directory; the final upload is rebuilt from reviewed inputs.
The actual published archive is then checked against the accepted runtime files
before allowlisted documentation, a matching public `v<version>` tag and GitHub
Release can be synchronized. Conflicting user edits or immutable tags stop sync.

Pub.dev requires a separately approved **manual first publication** for a new
package. Trusted publishing can then use the private repository and per-product
tag pattern above; pub.dev requires a tag-push workflow. First publication and
bootstrap documentation synchronization are not performed by this preparation.
Do not install this docs repo as an SDK Git dependency or copy the disabled
pubspec blueprint into a release without accepted binaries and review.

Unknown upload outcomes are reconciled against pub.dev; never blindly retry,
move a tag or reset release state. A bad published version needs a reviewed
corrective version rather than claims that publication was undone.

See [release status](release-status.md), [packaging](packaging.md),
[security and assets](security-and-assets.md), [platforms](platforms.md) and
[Windows acceptance](windows-validation.md).

References: [pub.dev automated publishing](https://dart.dev/tools/pub/automated-publishing),
[GitHub webhook validation](https://docs.github.com/en/webhooks/using-webhooks/validating-webhook-deliveries)
and [Cloudflare delivery guarantees](https://developers.cloudflare.com/queues/reference/delivery-guarantees/).
