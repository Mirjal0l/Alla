import 'dart:async';

import 'package:alla/core/utils/utils.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TimerBar extends StatefulWidget {
  const TimerBar({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar> {

  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppUtils.kPaddingHor12,
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSubText(text: timeFormat(widget.controller.value.position.inSeconds) + ' / ', size: 14),
          CustomSubText(text: timeFormat(widget.controller.value.duration.inSeconds), size: 14)
        ],
      ),
    );
  }
}

String timeFormat(int seconds) {
  String minT = (seconds ~/ 60).toString().padLeft(2, '0');
  String hoursT = (seconds ~/ 60 ~/ 60).toString().padLeft(2, '0');
  String secondsT = (seconds % 60).toString().padLeft(2, '0');
  if (hoursT == '00') {
    return '$minT:$secondsT';
  }
  return '$hoursT:$minT:$secondsT';
}
