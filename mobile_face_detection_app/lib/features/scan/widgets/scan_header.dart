
import 'package:face_detection_app/features/scan/widgets/scan_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanHeader extends StatelessWidget {
  const ScanHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScanCircleButton(
              icon: Icons.close,
              onTap: () => context.pop(),
            ),
            const Text(
              "Face Scan",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ScanCircleButton(
              icon: Icons.help_outline,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
