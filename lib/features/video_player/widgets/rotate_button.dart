import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotateButton extends StatefulWidget {
  const RotateButton({super.key, required this.isOrientationFullscreen, required this.onToggleOrientation});
  final bool isOrientationFullscreen;
  final VoidCallback onToggleOrientation;

  @override
  State<RotateButton> createState() => _RotateButtonState();
}

class _RotateButtonState extends State<RotateButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          widget.onToggleOrientation();
        },
        icon: SvgPicture.asset(
          'assets/icons/rotate.svg',
          width: 24,
          height: 24,
        )
    );
  }
}
