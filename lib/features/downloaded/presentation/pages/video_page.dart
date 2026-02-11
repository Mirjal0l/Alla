import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_darker2,
      appBar: CustomAppBar(
          hasLeadingIcon: true,
        title: 'Video page',
      )
    );
  }
}
