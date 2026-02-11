import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeBar extends StatefulWidget {
  const VolumeBar({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<VolumeBar> createState() => _VolumeBarState();
}

class _VolumeBarState extends State<VolumeBar> {
  double _currentVolume = 0.5;
  bool mute = false;
  IconData volumeIcon = Icons.volume_up;


  @override
  void initState() {
    super.initState();
    VolumeController.instance..setVolume(_currentVolume)..addListener(
        (volume) {
          _currentVolume = volume;
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    VolumeController.instance.removeListener();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppUtils.kPaddingHor4,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (mute) {
                  volumeIcon = Icons.volume_off;
                  VolumeController.instance.setMute(true);

                } else {
                  volumeIcon = Icons.volume_up;
                  VolumeController.instance.setMute(false);
                }

                setState(() {
                  mute = !mute;
                });

                // setState(() {
                //   if (_currentVolume == 0) { // volumeless
                //     volumeIcon = Icons.volume_off;
                //   }  else if (_currentVolume > 0){ // volume
                //     volumeIcon = Icons.volume_up;
                //     VolumeController.instance.setMute(true);
                //     _currentVolume = 0;
                //   }
                // });
              },
              icon: Icon(
                volumeIcon,
                size: 24,
                color: AppColors.white,
              ),
          ),

          AppUtils.kGap12,

          SizedBox(
            width: 100,
              height: 32,
              child: Slider(
                padding: EdgeInsets.zero,
                max: 1.0,
                  min: 0.0,
                  value: _currentVolume,
                  onChanged: (double newVolume) {
                    setState(() {
                      _currentVolume = newVolume;
                      if (_currentVolume == 0) { // volumeless
                        volumeIcon = Icons.volume_off;
                      }  else if (_currentVolume > 0){ // volume
                        volumeIcon = Icons.volume_up;
                      }
                    });

                    VolumeController.instance.setVolume(_currentVolume);
                  },
                activeColor: AppColors.white,
                inactiveColor: AppColors.white.withOpacity(0.3),
                thumbColor: Colors.white,
              )
          )
        ],
      ),
    );
  }
}
