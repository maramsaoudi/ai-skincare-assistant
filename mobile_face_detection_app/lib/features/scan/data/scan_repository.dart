import 'dart:io';

import 'package:dio/dio.dart';
import 'package:face_detection_app/features/scan/domain/ScanResult.dart';

class ScanRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.100.93:8080',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<ScanResult> analyzeImage(File image) async {
    const String userId = '03e30f88-220e-4365-8fae-508bf0d723af';

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

    return ScanResult.fromJson(response.data);
  }
}
