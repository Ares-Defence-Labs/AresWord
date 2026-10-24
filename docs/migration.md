# Migrate to AresWord

Replace combined Office engine integration with the `ares_word` package once its
reviewed distribution is available. Do not point a public app at private path
dependencies or this docs-only repository. Each product remains separately licensed.

| Combined integration | Domain integration |
| --- | --- |
| Generic product selection | `AresWordSdk(licenceKey: token)` fixes the domain. |
| Generic viewer construction | `AresWordEditor(sdk: sdk, documentPath: path)` uses its loader/writer. |
| Shared scanner with output selector | `AresWordScanner` or `sdk.scanToFile` fixes `.docx` output. |
| Direct file access on every target | Managed byte import/export and origin-local browser storage. |
| Shared entitlement assumptions | A valid `AresWordSDK` grant including its mobile scanner. |

Route existing `.docx` files to this SDK. Do not reuse a grant or template from
another Office product. Save pending sessions before using saved-package APIs;
reopen from their returned document. Replace assumptions that logical sections
are printed pages with the domain conventions in [architecture](architecture.md).

The source still exposes shared `AresOffice*` model/configuration names and some
broad helpers. Those names are not a promise of a stable combined customer engine.
Use the domain SDK and [current export reference](api-types.md). Its inherited
`generateDocument` signature retains `wordSettings`, `formOutput` and
`formSourcePaths` from the shared generator. These are Word reconstruction/form
inputs, not Excel cell formatting or PowerPoint slide settings. Leave them at
defaults for non-form Word workflows; use the
domain scanner review and typed domain APIs for output-specific behavior.

Camera flows stay Android/iOS only. Hide scan controls on desktop/web and test
existing-file editor/API workflows there. Desktop/web source verification supports
customer-wide grants; do not migrate mobile owner/admin tokens into those hosts.
[Platform and licensing scope](platforms.md)
