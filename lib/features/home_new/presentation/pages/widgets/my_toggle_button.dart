import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../widgets/custom_sub_text.dart';

class MyToggleButton extends StatelessWidget {
  const MyToggleButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      margin: AppUtils.kPaddingAll4,
      padding: AppUtils.kPaddingHor8,
      decoration: BoxDecoration(
        borderRadius: AppUtils.kBorderRadius8,
        color: AppColors.white.withOpacity(0.1),
      ),
      child: Center(
        child: CustomSubText(
          text: text,
          size: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white08,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
