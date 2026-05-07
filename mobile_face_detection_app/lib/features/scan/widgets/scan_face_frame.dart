import 'package:flutter/material.dart';

class ScanFaceFrame extends StatelessWidget {
  const ScanFaceFrame({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 260,
                height: 360,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 220,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primary,
                    width: 2,
                  ),
                ),
              ),
              ..._corners(),
            ],
          ),
        ),
      ],
    );
  }

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
              ? const BorderSide(color: primary, width: 2)
              : BorderSide.none,
          bottom: !top
              ? const BorderSide(color: primary, width: 2)
              : BorderSide.none,
          left: left
              ? const BorderSide(color: primary, width: 2)
              : BorderSide.none,
          right: !left
              ? const BorderSide(color: primary, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}
