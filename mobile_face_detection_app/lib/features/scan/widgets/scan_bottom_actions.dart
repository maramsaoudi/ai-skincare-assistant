
import 'package:face_detection_app/features/scan/widgets/scan_circle_button.dart';
import 'package:flutter/material.dart';

class ScanBottomActions extends StatelessWidget {
  const ScanBottomActions({
    super.key,
    required this.pickedFromGallery,
    required this.onGalleryTap,
    required this.onMainTap,
    required this.onFlipTap,
  });

  final bool pickedFromGallery;
  final VoidCallback onGalleryTap;
  final VoidCallback onMainTap;
  final VoidCallback onFlipTap;

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScanCircleButton(
                icon: Icons.image,
                onTap: onGalleryTap,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: onMainTap,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary,
                      ),
                      child: Icon(
                        pickedFromGallery ? Icons.check : Icons.camera_alt,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pickedFromGallery ? "Pick this image" : "Take Photo",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              ScanCircleButton(
                icon: Icons.flip_camera_ios,
                onTap: onFlipTap,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
