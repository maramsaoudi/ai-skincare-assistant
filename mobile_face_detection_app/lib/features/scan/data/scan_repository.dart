import 'package:dio/dio.dart';

class ScanRepository {
  final Dio dio;

  ScanRepository(this.dio);

  Future<Map<String, dynamic>> createScan(String userId) async {
    final response = await dio.post(
      "http://10.0.2.2:8080/scans?userId=$userId",
      data: {"imageUrl": "dummy.jpg"},
    );

    return response.data;
  }
}
