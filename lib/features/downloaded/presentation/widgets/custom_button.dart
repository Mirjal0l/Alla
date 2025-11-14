import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/custom_bold_text.dart';

class CustomButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: isSelected
            ? BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/img17.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        )
            : BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: AppColors.gray_darker2,
        ),
        child: Center(
          child: CustomBoldText(
            text: text,
            size: 15,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            textAlign: TextAlign.center,
            color: isSelected
                ? AppColors.white
                : AppColors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
