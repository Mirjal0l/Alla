import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBoldText extends StatelessWidget {
  final String text;
  final double size;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  final int maxLines;
  const CustomBoldText({
    super.key,
    required this.text,
    required this.size,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w900,
    this.color = AppColors.white,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontWeight: fontWeight,
        fontSize: size,
        fontStyle: FontStyle.normal,
        color: color,
        letterSpacing: 0,
        height: 0
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
