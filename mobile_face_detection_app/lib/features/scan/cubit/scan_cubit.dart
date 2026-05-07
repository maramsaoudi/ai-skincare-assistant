import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repo/scan_repository.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository repository;

  ScanCubit(this.repository) : super(ScanInitial());

  Future<void> analyze(File image) async {
    try {
      emit(ScanLoading());

      final result = await repository.analyzeImage(image);

      emit(ScanLoaded(result));
    } catch (e) {
      print('SCAN ERROR: $e');
      emit(ScanError(e.toString()));
    }
  }
}
