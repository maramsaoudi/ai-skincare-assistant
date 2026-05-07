import 'dart:io';

import 'package:flutter/material.dart';

class ScanPreview extends StatelessWidget {
  const ScanPreview({
    super.key,
    required this.image,
  });

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: image != null
              ? Image.file(image!, fit: BoxFit.cover)
              : Container(color: Colors.black),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
