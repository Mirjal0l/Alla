import 'package:alla/features/video_player/widgets/bottom_slider.dart';
import 'package:alla/features/video_player/widgets/center_play_button.dart';
import 'package:alla/features/video_player/widgets/favorite_button.dart';
import 'package:alla/features/video_player/widgets/little_play_button.dart';
import 'package:alla/features/video_player/widgets/lock_button.dart';
import 'package:alla/features/video_player/widgets/rotate_button.dart';
import 'package:alla/features/video_player/widgets/timer_bar.dart';
import 'package:alla/features/video_player/widgets/video_name.dart';
import 'package:alla/features/video_player/widgets/video_quality_button.dart';
import 'package:alla/features/video_player/widgets/volume_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'back_button.dart';

class VideoPlayerOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final bool isFavorite;
  const VideoPlayerOverlay({super.key, required this.controller, required this.isFavorite});

  State<VideoPlayerOverlay> createState() => _VideoPlayerOverlayState();

}

class _VideoPlayerOverlayState extends State<VideoPlayerOverlay> {

  bool showControl = true;
  bool locked = false;
  bool isOrientationFullscreen = true;

  void toggleLock() {
    locked = !locked;
    showControl = !locked;
    setState(() {

    });
  }

  void toggleOrientation() async {
    isOrientationFullscreen = !isOrientationFullscreen;
    if (isOrientationFullscreen) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }


  void togglePlay() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Back button
        Positioned(
          top: 16,
          left: 16,
          child: showControl ? BackButton1() : SizedBox(),
        ),

        // Title and sub title
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: showControl ? VideoName() : SizedBox(),
        ),

        // Favorite button
        Positioned(
          top: 16,
          right: 16,
          child: showControl ? FavoriteButton(isFavorite: widget.isFavorite) : SizedBox(),
        ),

        // Lock button
        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height / 2 - 22,
          child: LockButton(onToggleLock: toggleLock, locked: locked),
        ),

        // Rotate button
        Positioned(
          right: 16,
          bottom: 32,
          child: showControl ? RotateButton(isOrientationFullscreen: isOrientationFullscreen, onToggleOrientation: toggleOrientation) : SizedBox(),
        ),

        // Center Play button
        Positioned(
          top: MediaQuery.of(context).size.height / 2 - 35,
          left: MediaQuery.of(context).size.width / 2 - 35,
          child: showControl ? CenterPlayButton(controller: widget.controller, onTogglePlay: togglePlay) : SizedBox(),
        ),

        Positioned(
          bottom: 32,
          right: 16 + 40,
          child: VideoQualityButton(),
        ),
        // Volume bar
        Positioned(
          bottom: 32,
          right: 16 + 40 + 44,
          child: showControl ? VolumeBar(controller: widget.controller) : SizedBox(),
        ),

        // Timer bar
        Positioned(
          bottom: 32,
          left: 40,
          child: showControl ? TimerBar(controller: widget.controller) : SizedBox(),
        ),

        // Little Play Button on LeftBottm
        Positioned(
          bottom: 32,
          left: 16,
          child: showControl ? LittlePlayButton(onTogglePlay: togglePlay, controller: widget.controller) : SizedBox()
        ),

        // Bottom SLIDER
        Positioned(
          bottom: 20,
          child: showControl ? BottomSlider(controller: widget.controller) : SizedBox(),
        )
      ],
    );
  }
}