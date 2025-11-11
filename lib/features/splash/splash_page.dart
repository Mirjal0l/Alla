import 'dart:math' as math;

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/router/name_routes.dart';
import 'package:flutter/material.dart';
import 'package:alla/widgets/gradient_progress_painter.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
      duration: Duration(seconds: 1),

    )..repeat();
    
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted) {
        context.go(Routes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 240,
              height: 170,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                      child: CustomPaint(
                        painter: GradientProgressPainter(),
                        size: Size(24, 24),
                      ),
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );
  }
}
