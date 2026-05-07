import 'package:face_detection_app/features/tracker/domain/repo/scan_history_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scan_history_state.dart';

class ScanHistoryCubit extends Cubit<ScanHistoryState> {
  final ScanHistoryRepository repository;

  ScanHistoryCubit(this.repository) : super(ScanHistoryInitial());

  Future<void> loadTrackerHistory() async {
    emit(ScanHistoryLoading());

    try {
      final scans = await repository.getTrackerHistory();
      emit(ScanHistoryLoaded(scans));
    } catch (e) {
      print('SCAN HISTORY ERROR: $e');
      emit(ScanHistoryError(e.toString()));
    }
  }
}
