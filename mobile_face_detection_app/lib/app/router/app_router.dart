import 'package:face_detection_app/features/home/widget/main_navigation.dart';
import 'package:face_detection_app/features/profile/view/profile_screen.dart';
import 'package:face_detection_app/features/scan/domain/models/scan_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



import 'package:face_detection_app/features/home/view/home_screen.dart';
import 'package:face_detection_app/features/scan/view/scan_screen.dart';
import 'package:face_detection_app/features/scanResult/view/result_screen.dart';
import 'package:face_detection_app/features/tracker/view/tracker_screen.dart';

class AppRouter {
  final GoRouter goRouter;

  const AppRouter._({required this.goRouter});

  factory AppRouter.create() {
    return AppRouter._(
      goRouter: GoRouter(
        initialLocation: '/home',

        // ✅ ERROR HANDLER (outside routes)
        errorBuilder: (context, state) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),

        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return MainNavigation(child: child);
            },
            routes: [
              // 🔹 HOME
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),

              // 🔹 SCAN
              GoRoute(
                path: '/scan',
                name: 'scan',
                builder: (context, state) => const ScanScreen(),
              ),

              // 🔹 TRACKER
              GoRoute(
                path: '/tracker',
                name: 'tracker',
                builder: (context, state) => const TrackerScreen(),
              ),

              // 🔹 RESULT (WITH DATA)
              GoRoute(
                path: '/result',
                name: 'result',
                builder: (context, state) {
                  final result = state.extra as ScanResult;
                  return ResultScreen(result: result);
                },
              ),
              // 🔹 profile
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
