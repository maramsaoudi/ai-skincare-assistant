import 'package:flutter/material.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({
    super.key,
    required this.insight,
  });

  final String insight;

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Insights", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            insight,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
