import 'dart:async';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/audio_player/widgets/player_widget.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key /*, required this.url*/});

  // final String url;

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer player;
  bool _isLoading = true;
  Duration? _duration;
  String _errorMessage = '';


  @override
  void initState() {
    super.initState();
    // create the audio player
    player = AudioPlayer();
    print('INITIALIZING AUDIO PLAYER');

    // set the release mode to keep the source after playback has finished
    // Sets the resource release mode to stop, which means when audio playback finishes, the audio source will remain loaded in memory rather than being automatically released.
    player.setReleaseMode(ReleaseMode.stop);

    // Listen for duration changes
    player.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
          _isLoading = false;
        });
      }
    });

    // Listen for errors
    player.onPlayerComplete.listen((event) {
      print('Playback completed');
    });

    // Start the player as soon as the app displayed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeAudio();
    });
  }

  Future<void> _initializeAudio() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Try loading from assets
      await player.setSource(AssetSource('audio/sehrlandiya.mp3'));

      // Wait a bit for duration to be available
      await Future.delayed(const Duration(milliseconds: 500));

      // Try to get duration
      final duration = await player.getDuration();
      if (duration != null) {
        setState(() {
          _duration = duration;
          _isLoading = false;
        });
      }

      // Start playing
      await player.resume();
    } catch (e) {
      print('Error loading audio: $e');
      setState(() {
        _errorMessage = 'Audio yuklanmadi: $e';
        _isLoading = false;
      });

      // Try network fallback
      try {
        await player.setSourceUrl(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        );
        await player.resume();
      } catch (e2) {
        print('Network fallback also failed: $e2');
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    print('AUDIO PLAYER DISPOSED');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark_blue,
      appBar: CustomAppBar(
        hasLeadingIcon: true,
        title: 'Audio',
        fontSize: 17,
        fontWeight: FontWeight.w700,
        background: AppColors.dark_blue,
      ),
      body: Container(
        padding: AppUtils.kPaddingAll16,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: AppUtils.kBorderRadiusTop28,
          gradient: LinearGradient(
            colors: [AppColors.blue2, AppColors.dark_blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppUtils.kGap24,

              ClipRRect(
                borderRadius: AppUtils.kBorderRadius16,
                child: Image.asset(
                  'assets/images/sehrlandiya_sq.png',
                  width: 246,
                  height: 321,
                  fit: BoxFit.cover,
                ),
              ),

              AppUtils.kGap48,

              CustomBoldText(
                text: 'Sehrlandiya',
                size: 20,
                color: AppColors.white,
              ),

              _isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(color: Colors.white),
                          const SizedBox(height: 20),
                          const Text(
                            'Audio yuklanmoqda...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : PlayerWidget(audioPlayer: player),
            ],
          ),
        ),
      ),
    );
  }
}
