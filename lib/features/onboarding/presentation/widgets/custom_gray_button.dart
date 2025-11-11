import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGrayButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomGrayButton({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 85,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.gray_darker,
          borderRadius: BorderRadius.circular(40)
        ),

        child: Center(

          child: CustomSubText(
              text: title,
              size: 15
          ),
        ),
      ),
    );
  }
}
