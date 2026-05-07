import 'package:face_detection_app/features/scanResult/widgets/result_marker.dart';
import 'package:flutter/material.dart';

class ResultImageCard extends StatelessWidget {
  const ResultImageCard({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
          ),
          const Positioned(
            top: 30,
            left: 140,
            child: ResultMarker(color: Colors.pink),
          ),
          const Positioned(
            top: 130,
            left: 40,
            child: ResultMarker(color: Colors.green),
          ),
          const Positioned(
            top: 130,
            right: 40,
            child: ResultMarker(color: Colors.orange),
          ),
          const Positioned(
            bottom: 30,
            left: 140,
            child: ResultMarker(color: Colors.red),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "AI ANALYZED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
