# Product licensing

AresWord uses the existing Defence Labs signed licence system with product claim
`AresWordSDK` and annual token prefix `AWORD2`. This product's scanner,
editor and managed document API are included. Word, Excel and PowerPoint are
separate grants; one grant does not unlock the other two. The configured annual
commercial price is US$50; this document does not verify live
checkout or a customer's current entitlement.

Construct `AresWordSdk(licenceKey: customerToken)`. Native verification in the
development integration checks the pinned signature, exact product, app identity
and validity period. Missing native support, errors and wrong-product keys fail
closed. The optional `verifyLicence` callback can impose an extra restriction;
returning true cannot replace a valid native grant.

AresScan's owner/admin grants explicitly cover authorized products and are bound
to the owner app/platform/signing identity. They are separate from customer
packages. Do not distribute owner tokens, signing tools, test trust or debug
authorization switches. `isPro` and UI flags do not grant admin access.

The development integration currently uses the private mobile native plugin's
Office verification channel. Editors and low-level APIs also require secure
product verification on macOS, Windows, Linux and web; that implementation is
still a release blocker. No platform may skip licensing or use a host boolean
as authorization. Browser origin/storage and desktop application binding require
an explicit security design and tests rather than reusing mobile identity claims.
Independent customer camera/processing binaries are also pending. The public Edge
package cannot be assumed to supply the private Office channel. An Office trial
policy must be implemented and tested explicitly; this
preparation does not promise Edge's trial behavior for the Office SDKs.

Tokens are client configuration; signing secrets remain server-side. App identity
or signer changes may require reissuance. Never include real licence strings in
bug reports or screenshots. See [security](security-and-assets.md).
