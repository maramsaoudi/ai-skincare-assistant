import 'package:flutter/material.dart';

class LatestScanCard extends StatelessWidget {
  const LatestScanCard({super.key});

  static const scanImage = 'assets/images/scan_placeholder.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              scanImage,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LATEST SCAN",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "84%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Excellent",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(0.04),
        ),
      ],
    );
  }
}
