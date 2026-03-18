import 'package:flutter/material.dart';
import 'package:face_detection_app/app/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

final appRouter = AppRouter.create();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Glowlytics',
      routerConfig: appRouter.goRouter,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF7F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF48FB1), // 🌸 pink theme
        ),
      ),
    );
  }
}
