import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBlueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const CustomBlueButton({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: AssetImage('assets/images/button_bg.png'), fit: BoxFit.contain)
            ),
            child: Center(
              child: CustomBoldText(
                  text: title,
                  size: 17
              ),
            ),
          )
      ),
    );
  }
}
