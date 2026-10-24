# Product licensing

AresWord uses the existing Defence Labs signed licence system with product claim
`AresWordSDK` and annual token prefix `AWORD2`. This product's scanner,
editor and managed document API are included. Word, Excel and PowerPoint are
separate grants; one grant does not unlock the other two. See the [developer portal](https://aresdefencelabs.com/development-sdks) for
current commercial pricing and entitlement options. These docs do not verify
live checkout or a customer's current entitlement.

Construct `AresWordSdk(licenceKey: customerToken)`. Android/iOS use the existing
native verifier for pinned signatures, exact product, identity and validity.
macOS/Windows/Linux/web use the same pinned Ed25519 issuer for customer-wide
grants (`applicationId: "*"`, `licenceScope: "customer"`). Product, customer,
annual term and optional platform claims are checked. Invalid signatures, expired
grants, cross-product keys and unsupported bindings fail closed. The optional
`verifyLicence` callback adds a restriction; returning true cannot grant access.

AresScan's owner/admin grants explicitly cover authorized products and are bound
to the owner app/platform/signing identity. They are separate from customer
packages. Do not distribute owner tokens, signing tools, test trust or debug
authorization switches. `isPro` and UI flags do not grant admin access.

Desktop/web app-bound and owner/admin grants are rejected until a genuine OS or
origin identity binding is implemented. Do not substitute a host-provided string
or boolean for that boundary. Customer-wide verification is implemented in the
source integration; protected release enforcement and independent customer
artifacts remain pending. Mobile native rejection never falls back to Dart.
Independent customer camera/processing binaries are also pending. The public Edge
package cannot be assumed to supply the private Office channel. An Office trial
policy must be implemented and tested explicitly; this
preparation does not promise Edge's trial behavior for the Office SDKs.

Tokens are client configuration; signing secrets remain server-side. App identity
or signer changes may require reissuance. Never include real licence strings in
bug reports or screenshots. See [security](security-and-assets.md).
