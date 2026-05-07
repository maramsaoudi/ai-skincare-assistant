import 'package:face_detection_app/features/tracker/models/scan_history_item.dart';
import 'package:flutter/material.dart';

import 'scan_item.dart';

class RecentScansSection extends StatelessWidget {
  const RecentScansSection({
    super.key,
    required this.scans,
  });

  final List<ScanHistoryItem> scans;

  @override
  Widget build(BuildContext context) {
    if (scans.isEmpty) {
      return const Text('No scans yet');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Scans',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...scans.map((scan) {
          final score = scan.skinScore.round();

          return ScanItem(
            _formatDate(scan.createdAt),
            score.toString(),
            _getStatus(score),
            score >= 80,
          );
        }),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getStatus(int score) {
    if (score >= 85) return 'Excellent';
    if (score >= 70) return 'Good';
    if (score >= 50) return 'Average';
    return 'Needs care';
  }
}
