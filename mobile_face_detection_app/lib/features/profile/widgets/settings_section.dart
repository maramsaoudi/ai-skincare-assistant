import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tile("Edit Profile", "Update your info", Icons.person),
        _tile("Notifications", "Manage alerts", Icons.notifications),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFFFEBEE),
            child: Icon(Icons.logout, color: Colors.red),
          ),
          title: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
