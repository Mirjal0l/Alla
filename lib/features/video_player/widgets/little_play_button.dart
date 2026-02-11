import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LittlePlayButton extends StatelessWidget {
  const LittlePlayButton({super.key, required this.onTogglePlay, required this.controller});
  final VideoPlayerController controller;
  final VoidCallback onTogglePlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: IconButton(
          onPressed: () {
            onTogglePlay();
          },
          icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow, size: 24, color: AppColors.white,)
      ),
    );
  }
}
