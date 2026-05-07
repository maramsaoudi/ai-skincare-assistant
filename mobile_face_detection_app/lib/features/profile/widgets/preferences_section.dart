import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tile("Budget Range", "\$\$ (Mid-range)", Icons.attach_money),
        _tile("Ingredients", "Vegan, Cruelty-free", Icons.eco),
      ],
    );
  }

  Widget _tile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(child: Text(title)),
            Text(
              value,
              style: const TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
