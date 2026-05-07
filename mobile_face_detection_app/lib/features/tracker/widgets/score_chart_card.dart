import 'package:face_detection_app/features/tracker/domain/models/scan_history_item.dart';
import 'package:flutter/material.dart';


class ScoreChartCard extends StatelessWidget {
  const ScoreChartCard({
    super.key,
    required this.scans,
  });

  final List<ScanHistoryItem> scans;

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    final average = _averageScore();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _card(),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Skin Score Average',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${average.round()} pts',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _trendBadge(),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: scans.take(7).map((scan) {
                final heightFactor = (scan.skinScore / 100).clamp(0.1, 1.0);

                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 80 * heightFactor,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.8),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  double _averageScore() {
    if (scans.isEmpty) return 0;

    final total = scans.fold<double>(
      0,
      (sum, scan) => sum + scan.skinScore,
    );

    return total / scans.length;
  }

  Widget _trendBadge() {
    if (scans.length < 2) {
      return const SizedBox();
    }

    final latest = scans.first.skinScore;
    final previous = scans[1].skinScore;
    final difference = latest - previous;

    final isPositive = difference >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isPositive ? Colors.green : Colors.red).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: 16,
            color: isPositive ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '${difference.toStringAsFixed(1)}',
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(0.04),
        ),
      ],
    );
  }
}
