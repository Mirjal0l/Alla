import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubText extends StatelessWidget {
  final String text;
  final double size;
  final TextAlign textAlign;
  const CustomSubText({
    super.key,
    required this.text,
    required this.size,
    this.textAlign = TextAlign.center
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: AppColors.white.withOpacity(0.8),
        letterSpacing: 0,
      ),
      textAlign: textAlign,
    );
  }
}
