import 'package:ares_word/ares_word.dart';
import 'package:ares_word/storage.dart';

Future<AresWordDocumentLayout> readImportedLayout(
  AresWordSdk sdk, List<int> bytes, {String? nativePath}
) async {
  // Native hosts supply an absolute writable path; web can omit it.
  final handle = await AresOfficeStorage.importBytes(
    name: 'document.docx', bytes: bytes, path: nativePath,
  );
  // A persisted browser handle is restored automatically when necessary.
  return sdk.loadLayout(handle);
}
