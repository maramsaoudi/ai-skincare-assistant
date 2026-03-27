import 'dart:io';

import 'package:face_detection_app/features/scan/domain/ScanResult.dart';

class ScanRepository {
  Future<ScanResult> analyzeImage(File image) async {
    await Future.delayed(const Duration(seconds: 2));

    // Fake AI output
    return ScanResult(
      oiliness: 0.7,
      dryness: 0.3,
      acne: 0.6,
      redness: 0.2,
    );
  }
}
