import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIcon(Icons.arrow_back, () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }),
          const Text(
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _circleIcon(Icons.settings, () {}),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: primary.withOpacity(0.1),
        child: Icon(icon, color: primary),
      ),
    );
  }
}
