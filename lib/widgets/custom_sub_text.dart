import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubText extends StatelessWidget {
  final String text;
  final double size;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  const CustomSubText({
    super.key,
    required this.text,
    required this.size,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.white08
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: size,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        color: color,
        letterSpacing: 0,
      ),
      textAlign: textAlign,
    );
  }
}