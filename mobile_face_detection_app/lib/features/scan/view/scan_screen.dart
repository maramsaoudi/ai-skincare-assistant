import 'dart:io';

import 'package:face_detection_app/features/scan/cubit/scan_cubit.dart';
import 'package:face_detection_app/features/scan/cubit/scan_state.dart';
import 'package:face_detection_app/features/scan/domain/repo/scan_repository.dart';
import 'package:face_detection_app/features/scan/widgets/scan_bottom_actions.dart';
import 'package:face_detection_app/features/scan/widgets/scan_face_frame.dart';
import 'package:face_detection_app/features/scan/widgets/scan_header.dart';
import 'package:face_detection_app/features/scan/widgets/scan_loading_overlay.dart';
import 'package:face_detection_app/features/scan/widgets/scan_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker picker = ImagePicker();

  File? image;
  bool pickedFromGallery = false;

  late final ScanCubit scanCubit;

  @override
  void initState() {
    super.initState();
    scanCubit = ScanCubit(ScanRepository());
  }

  @override
  void dispose() {
    scanCubit.close();
    super.dispose();
  }

  Future<void> openCamera(BuildContext context) async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked == null) return;

    setState(() {
      image = File(picked.path);
      pickedFromGallery = false;
    });

    if (!context.mounted) return;
    context.read<ScanCubit>().analyze(image!);
  }

  Future<void> pickFromGallery() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() {
      image = File(picked.path);
      pickedFromGallery = true;
    });
  }

  void analyzeSelectedImage(BuildContext context) {
    if (image != null && pickedFromGallery) {
      context.read<ScanCubit>().analyze(image!);
      return;
    }

    openCamera(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanCubit>.value(
      value: scanCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: BlocListener<ScanCubit, ScanState>(
                listener: (context, state) {
                  if (state is ScanLoaded) {
                    context.push('/result', extra: state.result);
                  }

                  if (state is ScanError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Stack(
                  children: [
                    ScanPreview(image: image),
                    const ScanHeader(),
                    const ScanFaceFrame(),
                    ScanBottomActions(
                      pickedFromGallery: pickedFromGallery,
                      onGalleryTap: pickFromGallery,
                      onMainTap: () => analyzeSelectedImage(context),
                      onFlipTap: () {},
                    ),
                    const ScanLoadingOverlay(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
