import 'package:dio/dio.dart';
import 'package:face_detection_app/features/tracker/domain/models/scan_history_item.dart';

class ScanHistoryRepository {
  final Dio dio;

  ScanHistoryRepository(this.dio);

  static const String userId = '03e30f88-220e-4365-8fae-508bf0d723af';

  Future<List<ScanHistoryItem>> getTrackerHistory() async {
    final response = await dio.get('/scans/tracker/$userId');

    final data = response.data as List;

    return data.map((item) {
      return ScanHistoryItem.fromJson(item);
    }).toList();
  }
}
