import 'package:face_detection_app/features/home/widget/daily_routine_card.dart';
import 'package:face_detection_app/features/home/widget/for_you_section.dart';
import 'package:face_detection_app/features/home/widget/home_header.dart';
import 'package:face_detection_app/features/home/widget/latest_scan_card.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const bg = Color(0xFFF8F6F6);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: [
            HomeHeader(),
            SizedBox(height: 24),
            LatestScanCard(),
            SizedBox(height: 24),
            DailyRoutineCard(),
            SizedBox(height: 24),
            ForYouSection(),
          ],
        ),
      ),
    );
  }
}
