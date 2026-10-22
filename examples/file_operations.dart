import 'package:ares_word/ares_word.dart';

// A focused example for a known editable fixture with at least one section.
// Imported complex files may reject operations; preserve originals and handle errors.
Future<void> updateFile(AresWordSdk sdk, String inputPath, String newOutputPath) async {
  final AresOfficeDocument original = await sdk.load(inputPath);
  final AresWordEditSession session = await sdk.edit(original);
  try {
    session.replaceSectionText(0, 'Updated content');
    await sdk.save(session, outputPath: newOutputPath);
  } finally {
    session.dispose();
  }
}
