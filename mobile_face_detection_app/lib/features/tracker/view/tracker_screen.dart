import 'package:dio/dio.dart';
import 'package:face_detection_app/features/tracker/cubit/scan_history_cubit.dart';
import 'package:face_detection_app/features/tracker/cubit/scan_history_state.dart';
import 'package:face_detection_app/features/tracker/repo/scan_history_repository.dart';
import 'package:face_detection_app/features/tracker/widgets/calendar_card.dart';
import 'package:face_detection_app/features/tracker/widgets/recent_scans_section.dart';
import 'package:face_detection_app/features/tracker/widgets/score_chart_card.dart';
import 'package:face_detection_app/features/tracker/widgets/tracker_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  static const bg = Color(0xFFF8F6F6);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final dio = Dio(
          BaseOptions(
            baseUrl: 'http://127.0.0.1:8080',
          ),
        );

        return ScanHistoryCubit(
          ScanHistoryRepository(dio),
        )..loadTrackerHistory();
      },
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
            builder: (context, state) {
              if (state is ScanHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ScanHistoryError) {
                return Center(child: Text(state.message));
              }

              if (state is ScanHistoryLoaded) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                  children: [
                    const TrackerHeader(),
                    const SizedBox(height: 20),
                    ScoreChartCard(scans: state.scans),
                    const SizedBox(height: 20),
                    const CalendarCard(),
                    const SizedBox(height: 20),
                    RecentScansSection(scans: state.scans),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
