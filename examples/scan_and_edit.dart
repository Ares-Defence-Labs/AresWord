import 'package:flutter/material.dart';
import 'package:ares_word/ares_word.dart';

// After an approved SDK is installed. Supply a customer token at build time;
// never use an owner token, a mock verifier, or a signing secret in customer apps.
final AresWordSdk sdk = AresWordSdk(
  licenceKey: const String.fromEnvironment('ARES_OFFICE_LICENCE'),
);

// The host supplies a new absolute path in its writable application directory.
Future<void> scanAndEdit(BuildContext context, String outputPath) async {
  try {
    final AresOfficeScanGenerationResult? result = await sdk.scanToFile(
      context: context,
      outputPath: outputPath, // Must end in .docx.
    );
    if (result == null || !context.mounted) return;
    await Navigator.of(context).push<void>(MaterialPageRoute<void>(
      builder: (BuildContext _) => AresWordEditor(
        sdk: sdk,
        documentPath: result.path,
        onError: (Object error) => debugPrint('Office editor operation failed: $error'),
      ),
    ));
  } on Object {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to complete this scan. Please try again.')),
    );
  }
}
