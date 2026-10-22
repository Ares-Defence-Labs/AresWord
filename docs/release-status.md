# Release status

Status: **local preparation only; publication disabled**. Planned package name:
`ares_word`. Blueprint version: `0.1.0-dev.1`. It is not a
published or installable SDK. The blueprint in [packaging](../packaging/pubspec.yaml)
retains `publish_to: none` and omits unresolved native/plugin/dependency wiring.
Do not run it as an upload candidate.

The three source SDKs already bind scanning, review, generation and editor entry
points to their domain and licence. Scanner-only imports and synthetic UI media
are included in this preparation. Source integration tests are separate evidence
from the customer binaries that still need to be built.

## Remaining gates

1. Office processing remains private Dart source; build protected native desktop/mobile and browser-compatible processing boundaries with thin domain adapters before customer packaging.
2. Build independent product-scoped native camera binaries; the public Edge customer build does not expose the private Office verification channel.
3. Implement and verify each product's authenticated encrypted model reader and resources; the proposed Office .aem names are reserved, not built artifacts.
4. Replace private path dependencies, dependency overrides, owner asset-delivery and source exports with audited redistributable dependencies and adapters.
5. Implement product licensing on all six editor/API platforms; current verification only uses the private mobile plugin. Isolate mobile camera/OCR and dart:io from browser editor/document entry points; provide browser byte/storage adapters and desktop file adapters.
6. Audit redistribution rights and include complete third-party notices, model/font licences and final customer licence terms.
7. Freeze and document the final public API; current inherited/exported core surfaces need a domain-isolation and bypass review.
8. Complete nested artifact, plaintext-model hash, secret, ABI, product isolation and sandbox/production trust checks on real release binaries.
9. Complete clean-host installation, editor and low-level API parity on Android/iOS/macOS/Windows/Linux/web, plus Android/iOS capture-review-edit-save device tests on those exact candidates.
10. Run pub.dev dry-run in a disposable copy, then hash the unchanged reviewed package and record build provenance; publication requires a separate instruction.

The broader Microsoft feature parity target is unfinished. See
[compatibility](compatibility.md). Neither passing source tests nor generating
these docs closes the release gates. No SDK was published or deployed by this
preparation. Public repo edits are local until explicitly pushed.
