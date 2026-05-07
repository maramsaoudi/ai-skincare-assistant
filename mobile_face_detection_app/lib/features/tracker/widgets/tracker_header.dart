import 'package:flutter/material.dart';

class TrackerHeader extends StatelessWidget {
  const TrackerHeader({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.analytics, color: primary),
        ),
        const SizedBox(width: 10),
        const Text(
          'Glowlytics Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          height: 40,
          width: 40,
          decoration: _card(),
          child: const Icon(Icons.notifications, size: 20),
        ),
      ],
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
