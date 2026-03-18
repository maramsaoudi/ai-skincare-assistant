import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/scan_repository.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository repository;

  ScanCubit(this.repository) : super(ScanInitial());

  Future<void> scan(String userId) async {
    emit(ScanLoading());

    try {
      final result = await repository.createScan(userId);
      emit(ScanSuccess(result));
    } catch (e) {
      emit(ScanError("Scan failed"));
    }
  }
}
