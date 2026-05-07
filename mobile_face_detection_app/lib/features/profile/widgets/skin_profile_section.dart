import 'package:flutter/material.dart';

class SkinProfileSection extends StatelessWidget {
  const SkinProfileSection({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title("Your Skin Profile"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _card(
                  "Skin Type",
                  "Oily/Combination",
                  Icons.local_fire_department,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _card(
                  "Main Concern",
                  "Acne & Aging",
                  Icons.warning,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title(String text) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "YOUR SKIN PROFILE",
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _card(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primary),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
