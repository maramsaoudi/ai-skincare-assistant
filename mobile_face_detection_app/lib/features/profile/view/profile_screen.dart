import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _profileImage = 'assets/images/avatar.png';

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFF06090);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIcon(Icons.arrow_back, primaryColor, () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }),
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _circleIcon(Icons.settings, primaryColor, () {}),
                ],
              ),
            ),

            // 🔹 CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 👤 PROFILE
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(_profileImage),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: primaryColor,
                            child: const Icon(Icons.edit,
                                size: 16, color: Colors.white),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      "Sophia Chen",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "sophia.chen@glowmail.com",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 SKIN PROFILE
                    _sectionTitle("Your Skin Profile", primaryColor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: _profileCard(
                                  "Skin Type",
                                  "Oily/Combination",
                                  Icons.local_fire_department,
                                  primaryColor)),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _profileCard("Main Concern",
                                  "Acne & Aging", Icons.warning, primaryColor)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ⚙️ PREFERENCES
                    _sectionTitle("Preferences", primaryColor),
                    _listTile("Budget Range", "\$\$ (Mid-range)",
                        Icons.attach_money, primaryColor),
                    _listTile("Ingredients", "Vegan, Cruelty-free", Icons.eco,
                        primaryColor),

                    const SizedBox(height: 20),

                    // 🔧 SETTINGS
                    _settingsTile(
                        "Edit Profile", "Update your info", Icons.person),
                    _settingsTile(
                        "Notifications", "Manage alerts", Icons.notifications),

                    // 🚪 LOGOUT
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFFFEBEE),
                        child: Icon(Icons.logout, color: Colors.red),
                      ),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // 🔹 Widgets

  Widget _circleIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _profileCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _listTile(String title, String value, IconData icon, Color color) {
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
            Text(value,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(String title, String subtitle, IconData icon) {
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
