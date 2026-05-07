
import 'package:face_detection_app/features/scan/cubit/scan_cubit.dart';
import 'package:face_detection_app/features/scan/cubit/scan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanLoadingOverlay extends StatelessWidget {
  const ScanLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanCubit, ScanState>(
      builder: (context, state) {
        if (state is! ScanLoading) {
          return const SizedBox();
        }

        return Container(
          color: Colors.black.withOpacity(0.6),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      },
    );
  }
}
