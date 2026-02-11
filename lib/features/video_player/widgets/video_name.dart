import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';

class VideoName extends StatelessWidget {
  const VideoName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomBoldText(text: 'Sehrlandiya', size: 16, fontWeight: FontWeight.w700,),
        CustomSubText(text: 'Qahramonlik missiyasi', size: 12, fontWeight: FontWeight.w500,)
      ],
    );
  }
}
