import 'package:flutter/material.dart';

import '../widgets/profile_avatar.dart';
import '../widgets/profile_header.dart';
import '../widgets/skin_profile_section.dart';
import '../widgets/preferences_section.dart';
import '../widgets/settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const bg = Color(0xFFF8F6F6);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ProfileAvatar(),
                    SizedBox(height: 20),
                    SkinProfileSection(),
                    SizedBox(height: 20),
                    PreferencesSection(),
                    SizedBox(height: 20),
                    SettingsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
