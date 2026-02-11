import 'dart:async';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BottomSlider extends StatefulWidget {
  const BottomSlider({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<BottomSlider> createState() => _BottomSliderState();
}

class _BottomSliderState extends State<BottomSlider> {
  double? dragValue = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (mounted && dragValue == null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayValue =
        dragValue ??
        (widget.controller.value.position.inSeconds /
            widget.controller.value.duration.inSeconds);
    return Container(
      margin: AppUtils.kPaddingHor16,
      width: MediaQuery.of(context).size.width,
      height: 12,
      child: Slider(
        value: displayValue,
        onChanged: (double value) {
          setState(() {
            dragValue = value;
          });
          widget.controller.seekTo(
            Duration(
              seconds: (value * widget.controller.value.duration.inSeconds)
                  .toInt(),
            ),
          );
        },
        onChangeEnd: (value) {
          setState(() {
            dragValue = null;
          });
        },

        thumbColor: AppColors.white,
        activeColor: AppColors.white,
        inactiveColor: AppColors.white.withOpacity(0.3),
      ),
    );
  }
}
