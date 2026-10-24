# AresWord integration modes

`AresWordSdk` fixes the product domain for authorization, allowed file extensions,
loading, writing and scanner generation. `AresWordEditor` embeds the document
workspace using that same SDK. `AresWordScanner` captures mobile pages; the
higher-level `scanToFile` adds recognition, domain review and verified file creation.
Use one configured SDK across a workflow so licence and domain checks agree.

| Layer | Owner | Responsibility |
| --- | --- | --- |
| Application | Host | Routes, pickers, permissions, customer-token delivery, storage policy and recovery UI. |
| Domain SDK | AresWord | Product authorization, input/output domain checks, managed load/edit/save/generation. |
| Edit session | Host-created, SDK model | Pending changes, history and immutable document snapshots; dispose after use. |
| Editor widget | Flutter lifecycle | Mounted editing workspace and lifecycle callbacks; optional host-owned controller. |
| Scanner | Android/iOS only | Capture, crop/OCR, domain review and generation orchestration. |
| Storage | Host plus SDK adapter | Native app paths or browser origin-local IndexedDB; no implicit cloud backup. |

Word sections in the logical model are content blocks such as paragraphs and tables. They are not guaranteed to be printed pages or Word section-break boundaries.

`AresWordDocument` aliases `AresOfficeDocument`; `AresWordEditSession` aliases
`AresDomainEditSession`. A shared model name does not imply another Office
product is authorized. Field/sourceXML availability varies by file format.

The source currently has broad shared exports and private path dependencies.
Public helper visibility is not an authorization guarantee. Use the managed SDK
for customer workflows; a narrowed, protected native/browser distribution and
bypass review remain release gates. See [security](security-and-assets.md),
[API inventory](api-types.md) and [release state](release-status.md).
