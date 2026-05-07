import 'package:face_detection_app/features/scan/domain/models/scan_result.dart';
import 'package:face_detection_app/features/scanResult/widgets/result_content.dart';
import 'package:face_detection_app/features/scanResult/widgets/result_image_card.dart';
import 'package:face_detection_app/features/scanResult/widgets/result_top_bar.dart';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      body: SafeArea(
        child: Column(
          children: [
            const ResultTopBar(),
            const ResultImageCard(),
            const SizedBox(height: 20),
            Expanded(
              child: ResultContent(result: result),
            ),
          ],
        ),
      ),
    );
  }
}
