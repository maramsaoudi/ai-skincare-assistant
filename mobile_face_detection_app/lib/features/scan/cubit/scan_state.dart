abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final Map<String, dynamic> data;

  ScanSuccess(this.data);
}

class ScanError extends ScanState {
  final String message;

  ScanError(this.message);
}
