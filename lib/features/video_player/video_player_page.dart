import 'dart:async';
import 'dart:math' as math;

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/video_player/widgets/video_player_overlay.dart';
import 'package:alla/widgets/gradient_progress_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;

  const VideoPlayerPage({super.key, required this.url});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  late final AnimationController _animatedController; // for progress bar
  late final VideoPlayerController controller;
  late Future<void> _futureInitializeVP;
  late Timer timer;
  bool isFavorite = false;

  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];

  @override
  void initState() {
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    controller = VideoPlayerController.network(widget.url);
    _futureInitializeVP = controller.initialize().then((_) {
      controller.play();
      controller.setLooping(false);
      setState(() {});
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);



    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (controller.value.isPlaying) {
        setState(() {});
      }
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    WakelockPlus.enable();

    super.initState();

    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
    }
  }

  @override
  void didChangeAppLifecycyleState(AppLifecycleState state) {
    setState(() {
      _stateHistoryList.add(state);
    });
  }

  @override
  void dispose() {
    // controller.pause();
    controller.dispose();
    WakelockPlus.disable();
    timer.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureInitializeVP,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: AppColors.black2,
            body: Stack(
              children: [

                // Video
                Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),

                // UI
                VideoPlayerOverlay(controller: controller, isFavorite: isFavorite,),
              ],
            ),
          );
        } else {
          return Center(
            child: AnimatedBuilder(
              animation: _animatedController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animatedController.value * 2 * math.pi,
                  child: CustomPaint(
                    painter: GradientProgressPainter(),
                    size: Size(20, 20),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
