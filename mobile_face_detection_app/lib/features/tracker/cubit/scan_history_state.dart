import 'package:face_detection_app/features/tracker/models/scan_history_item.dart';

abstract class ScanHistoryState {}

class ScanHistoryInitial extends ScanHistoryState {}

class ScanHistoryLoading extends ScanHistoryState {}

class ScanHistoryLoaded extends ScanHistoryState {
  final List<ScanHistoryItem> scans;

  ScanHistoryLoaded(this.scans);
}

class ScanHistoryError extends ScanHistoryState {
  final String message;

  ScanHistoryError(this.message);
}
