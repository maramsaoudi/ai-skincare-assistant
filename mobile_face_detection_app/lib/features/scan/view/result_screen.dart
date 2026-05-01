import 'package:face_detection_app/features/scan/domain/ScanResult.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  final ScanResult result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final int score = result.overallScore;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  _iconButton(Icons.arrow_back, () => context.pop()),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Scan Result",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _iconButton(Icons.share, () {}),
                ],
              ),
            ),

            // ===== IMAGE =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://picsum.photos/500",
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // MARKERS
                  Positioned(top: 30, left: 140, child: _marker(Colors.pink)),
                  Positioned(top: 130, left: 40, child: _marker(Colors.green)),
                  Positioned(
                      top: 130, right: 40, child: _marker(Colors.orange)),
                  Positioned(bottom: 30, left: 140, child: _marker(Colors.red)),

                  // AI badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF06090),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.auto_awesome,
                              size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            "AI ANALYZED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== CONTENT =====
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  children: [
                    // ===== SCORE =====
                    Text(
                      "Overall Score: $score/100",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _scoreMessage(score),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // ===== METRICS =====
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _metric("Acne", result.acne, Colors.green),
                        _metric("Oiliness", result.oiliness, Colors.orange),
                        _metric("Hydration", result.dryness, Colors.green),
                        _metric("Redness", result.redness, Colors.red),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ===== INSIGHTS =====
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF06090).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Insights",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.insight,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ===== CTA =====
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== SCORE LOGIC =====

  String _scoreMessage(int score) {
    if (score > 80) return "Your skin is looking healthy today!";
    if (score > 60)
      return "Your skin is doing okay, small improvements needed.";
    return "Your skin needs attention. Follow a proper routine.";
  }

  // ===== LEVEL =====
  String _level(double v) {
    if (v < 0.3) return "Low";
    if (v < 0.7) return "Moderate";
    return "High";
  }

  // ===== METRIC CARD =====
  Widget _metric(String label, double value, Color color) {
    final percent = (value * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: value,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
                Text(
                  "$percent%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            _level(value),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ===== ICON BUTTON =====
  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTap,
      ),
    );
  }

  // ===== MARKER =====
  Widget _marker(Color color) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
