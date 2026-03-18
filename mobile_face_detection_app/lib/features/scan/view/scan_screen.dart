import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

import '../cubit/scan_cubit.dart';
import '../cubit/scan_state.dart';
import '../data/scan_repository.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;
  final picker = ImagePicker();
  final String userId = "03e30f88-220e-4365-8fae-508bf0d723af";

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanCubit(ScanRepository(Dio())),
      child: Builder(
        // ✅ FIX: NEW CONTEXT
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: BlocListener<ScanCubit, ScanState>(
                listener: (context, state) {
                  if (state is ScanSuccess) {
                    context.push('/result', extra: state.data);
                  }

                  if (state is ScanError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Stack(
                  children: [
                    // ===== IMAGE =====
                    Positioned.fill(
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : Image.network(
                              "https://picsum.photos/600",
                              fit: BoxFit.cover,
                            ),
                    ),

                    // ===== DARK OVERLAY =====
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),

                    // ===== HEADER =====
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _circleBtn(Icons.close, () => context.pop()),
                            const Text(
                              "Face Scan",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _circleBtn(Icons.help_outline, () {}),
                          ],
                        ),
                      ),
                    ),

                    // ===== INSTRUCTION =====
                    const Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Center your face and ensure good lighting",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),

                    // ===== FACE FRAME =====
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 260,
                            height: 360,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Container(
                            width: 220,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFF06090),
                                width: 2,
                              ),
                            ),
                          ),
                          ..._corners(),
                        ],
                      ),
                    ),

                    // ===== BUTTONS =====
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _circleBtn(Icons.image, pickImage),

                              // ===== ANALYZE BUTTON =====
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text("Pick an image first")),
                                        );
                                        return;
                                      }

                                      context.read<ScanCubit>().scan(userId);
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _image == null
                                            ? Colors.grey
                                            : const Color(0xFFF06090),
                                      ),
                                      child: Icon(
                                        _image == null
                                            ? Icons.camera_alt
                                            : Icons.check, // ✅ better UX
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _image == null ? "Pick Image" : "Analyze",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              _circleBtn(Icons.flip_camera_ios, () {}),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // ===== LOADING =====
                    BlocBuilder<ScanCubit, ScanState>(
                      builder: (context, state) {
                        if (state is ScanLoading) {
                          return Container(
                            color: Colors.black.withOpacity(0.6),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===== BUTTON =====
  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }

  // ===== CORNERS =====
  List<Widget> _corners() {
    return [
      Positioned(top: 10, left: 10, child: _corner(true, true)),
      Positioned(top: 10, right: 10, child: _corner(true, false)),
      Positioned(bottom: 10, left: 10, child: _corner(false, true)),
      Positioned(bottom: 10, right: 10, child: _corner(false, false)),
    ];
  }

  Widget _corner(bool top, bool left) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? const BorderSide(color: Color(0xFFF06090), width: 2)
              : BorderSide.none,
          bottom: !top
              ? const BorderSide(color: Color(0xFFF06090), width: 2)
              : BorderSide.none,
          left: left
              ? const BorderSide(color: Color(0xFFF06090), width: 2)
              : BorderSide.none,
          right: !left
              ? const BorderSide(color: Color(0xFFF06090), width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}
