import 'package:ares_word/ares_word.dart';

// Native callers supply nativeDestination; browsers leave it null.
Future<List<int>> importEditExport(AresWordSdk sdk, List<int> bytes,
    {String? nativeDestination}) async {
  final imported = await sdk.loadBytes(name: 'document.docx', bytes: bytes,
    path: nativeDestination);
  final session = await sdk.edit(imported);
  try {
    session.replaceWordTextRangePreservingRuns(0, 0, 0, 'Hello Word! ');
    final saved = await sdk.save(session);
    return await sdk.exportBytes(saved.document.path);
  } finally {
    session.dispose();
  }
}
