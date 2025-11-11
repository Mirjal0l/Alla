import 'dart:math' as math;

import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GradientProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 3.5;
    final rect = Offset.zero & size;

    final Gradient gradient = SweepGradient(
      colors: [
        AppColors.black,
        AppColors.white,
        AppColors.black
      ],
      startAngle: 0.0,
      endAngle: math.pi * 2
    );

    final paint = Paint()
    ..shader = gradient.createShader(rect)
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        0,
        math.pi * 3 / 2, // controls how much of the circle is drawn (1.8 ≈ 90%)
        false,
        paint
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
