# AresWord integration examples

These files are source-contract examples compiled against the current private
SDK development graph. They do not install a protected customer package, provide
a runnable public app, establish paid/admin activation or bypass release gates.
When the reviewed package exists, copy the examples into a Flutter host with the
exact accepted package dependency and your own token/picker/error handling.

| Example | Purpose | Prerequisites |
| --- | --- | --- |
| [File operations](../examples/file_operations.dart) | Open, domain edit, save copy, dispose | Supported editable `.docx` with a first section; new destination. |
| [Byte storage](../examples/byte_storage.dart) | Picker bytes → edit → save → export | Native writable destination or browser IndexedDB. |
| [Editor host](../examples/editor_host.dart) | Theme, controller, lifecycle and errors | Valid SDK and existing document path; host widget lifecycle. |
| [Scan and edit](../examples/scan_and_edit.dart) | Camera through domain output/editor | Android/iOS device, permission and readable document; no desktop/web scanning. |
| [Domain workflows](../examples/document_workflows.dart) | Document content, layout and formatting; comments, bookmarks and tracked revisions | Supported domain fixture and operation-specific restrictions. |

The functions intentionally receive paths/bytes/SDK instances rather than fake
picker implementations. Never hardcode owner tokens, mock verification or signing
material in a customer host. Cancellation is normal; mutation errors must retain
originals. Examples are analysis-checked, not proof of full feature parity or all
platform/runtime behavior. Repeat compilation against the final hosted package.
