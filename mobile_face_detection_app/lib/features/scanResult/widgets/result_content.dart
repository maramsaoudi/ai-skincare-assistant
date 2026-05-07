import 'package:face_detection_app/features/scan/domain/ScanResult.dart';
import 'package:face_detection_app/features/scanResult/widgets/insights_card.dart';
import 'package:face_detection_app/features/scanResult/widgets/metric_card.dart';
import 'package:flutter/material.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({
    super.key,
    required this.result,
  });

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    final score = result.overallScore;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ListView(
        children: [
          Text(
            "Overall Score: $score/100",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            _scoreMessage(score),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              MetricCard(
                  label: "Acne", value: result.acne, color: Colors.green),
              MetricCard(
                label: "Oiliness",
                value: result.oiliness,
                color: Colors.orange,
              ),
              MetricCard(
                label: "Hydration",
                value: result.dryness,
                color: Colors.green,
              ),
              MetricCard(
                label: "Redness",
                value: result.redness,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 20),
          InsightsCard(insight: result.insight),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF06090),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Generate Routine",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String _scoreMessage(int score) {
    if (score > 80) return "Your skin is looking healthy today!";
    if (score > 60) {
      return "Your skin is doing okay, small improvements needed.";
    }
    return "Your skin needs attention. Follow a proper routine.";
  }
}
