import 'package:face_detection_app/features/scan/domain/ScanResult.dart';

abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanLoaded extends ScanState {
  final ScanResult result;

  ScanLoaded(this.result);
}

class ScanError extends ScanState {
  final String message;

  ScanError(this.message);
}
