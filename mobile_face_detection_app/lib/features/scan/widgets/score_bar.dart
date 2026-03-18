import 'package:flutter/material.dart';

class ScoreBar extends StatelessWidget {
  final String label;
  final double value;

  const ScoreBar({
    super.key,
    required this.label,
    required this.value,
  });

  Color getColor(double value) {
    if (value < 0.3) return Colors.green;
    if (value < 0.6) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label ($percent%)",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(getColor(value)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
