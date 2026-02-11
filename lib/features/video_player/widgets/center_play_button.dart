import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class CenterPlayButton extends StatelessWidget {
  const CenterPlayButton({super.key, required this.controller, required this.onTogglePlay, this.size = 70});
  final VideoPlayerController controller;
  final VoidCallback onTogglePlay;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppUtils.kBorderRadius64,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: size,
          height: size,
          color: AppColors.white.withValues(alpha: 0.1),
          child: IconButton(
              onPressed: () {
                onTogglePlay();
              },
              icon: Icon(!controller.value.isPlaying ? Icons.play_arrow : Icons.pause, size: size - 14, color: Colors.white,)
          ),
        ),
      ),
    );
  }
}
