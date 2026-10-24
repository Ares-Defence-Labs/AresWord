import 'package:ares_word/ares_word.dart';

Future<AresOfficeSaveResult> updateAresWord(
  AresWordSdk sdk, String path, String copyPath,
) async {
  final original = await sdk.load(path);
  final session = await sdk.edit(original);
  try {
    // Use a supported editable fixture containing at least one section.
    session.replaceWordTextRangePreservingRuns(0, 0, 0, 'Hello Word! ');
    return await sdk.save(session, outputPath: copyPath);
  } finally {
    session.dispose();
  }
}
