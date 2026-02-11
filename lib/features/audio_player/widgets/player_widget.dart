import 'dart:async';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Timer? timer;
  double? dragValue = 0;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  StreamSubscription? _playerCompleteSubscription;


  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration.toString().split('.').first;

  String get _positionText => _position.toString().split('.').first;

  AudioPlayer get player => widget.audioPlayer;

  void togglePlay() async {
    if (_playerState == PlayerState.playing) {
      await player.pause();
      setState(() {

      });
    } else {
      await player.resume();
      setState((){});
    }
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (mounted && dragValue == null) {
        setState((){

        });
      }
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (player.state == PlayerState.playing) {
        setState((){

        });
      }
    });
    // use initial values from player
    _playerState = player.state;

    player.getDuration().then((value) {
      setState(() {
        _duration = value!;
      });
    });

    player.getCurrentPosition().then((value) {
      setState(() {
        _position = value!;
      });
    });

    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    timer?.cancel();
    super.dispose();
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });
    
    _positionSubscription = player.onPositionChanged.listen((position) {
       setState(() => _position = position);
    });
    
    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSubText(
          text: _durationText,
          size: 14,
          color: AppColors.white.withOpacity(0.8),
        ),
        AppUtils.kGap48,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomSubText(
              text: _positionText,
              size: 12,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),

            Slider(
              min: 0.0,
              max: 1.0,
              value: dragValue?.clamp(0.0, 1.0) ?? // Use dragValue when dragging
                  ((_duration.inMilliseconds > 0)
                  ? _position.inMilliseconds / _duration.inMilliseconds
                  : 0.0),
              onChanged: (value) {
                final position = value * _duration.inMilliseconds;
                player.seek(Duration(milliseconds: position.round()));

                setState(() {
                  dragValue = value;
                  _position = Duration(milliseconds: position.round());
                });
              },
              onChangeEnd: (value) {
                final position = value * _duration.inMilliseconds;
                player.seek(Duration(milliseconds: position.round()));

                setState(() {
                  dragValue = value;
                  _position = Duration(milliseconds: position.round());
                });
              },
            ),

            CustomSubText(
              text: _durationText,
              size: 12,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),

        AppUtils.kGap32,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // - 15s
            IconButton(
              onPressed: () {
                Duration newPosition = _position - Duration(seconds: 15);

                if (newPosition.inSeconds < 0) {
                  newPosition = Duration.zero;
                }

                player.seek(newPosition);

                setState(() {
                  _position = newPosition;

                  // update slider position
                  if (_duration.inMilliseconds > 0) {
                    dragValue = newPosition.inMilliseconds / _duration.inMilliseconds;
                  }  else {
                    dragValue = 0;
                  }
                });
              },
              icon: SvgPicture.asset(
                'assets/icons/left15s.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: AppUtils.kBorderRadius64,
                color: AppColors.violet,
              ),
              child: IconButton(
                onPressed: () {
                  togglePlay();
                },
                icon: Icon(
                  _playerState == PlayerState.playing
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),

            // + 15s
            IconButton(
              onPressed: () {
                Duration newPosition = _position + Duration(seconds: 15);

                if (newPosition.inSeconds > _duration.inSeconds) {
                  newPosition = _duration;
                }
                
                player.seek(newPosition);
                
                setState((){
                  _position = newPosition;
                });
                
                if (_duration.inMilliseconds > 0) {
                  dragValue = newPosition.inMilliseconds / _duration.inMilliseconds;
                }  else {
                  dragValue = 1.0;
                }

              },
              icon: SvgPicture.asset(
                'assets/icons/right15s.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension on Duration {
  double? operator /(Duration other) {}
}
