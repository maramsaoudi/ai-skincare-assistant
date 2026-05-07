import 'dart:io';

import 'package:dio/dio.dart';
import 'package:face_detection_app/features/scan/domain/models/scan_result.dart';

class ScanRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8080',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<ScanResult> analyzeImage(File image) async {
    const String userId = '03e30f88-220e-4365-8fae-508bf0d723af';

    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await _dio.post(
        '/scans',
        queryParameters: {'userId': userId},
        data: formData,
      );

      print('SCAN SUCCESS: ${response.data}');
      return ScanResult.fromJson(response.data);
    } on DioException catch (e) {
      print('DIO ERROR TYPE: ${e.type}');
      print('DIO ERROR MESSAGE: ${e.message}');
      print('DIO REAL ERROR: ${e.error}');
      print('DIO STATUS: ${e.response?.statusCode}');
      print('DIO DATA: ${e.response?.data}');
      throw Exception(e.error ?? e.message);
    }
  }
}
