import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';

class HeaderContentsHD extends StatefulWidget {
  const HeaderContentsHD({super.key});

  @override
  State<HeaderContentsHD> createState() => _HeaderContentsHDState();
}

class _HeaderContentsHDState extends State<HeaderContentsHD> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.chevron_left,
            size: 24,
            color: AppColors.white,
          ),
        ),

        IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border,
            size: 24,
            color: isFavorite
                ? Colors.red
                : AppColors.white,
          ),
        ),
      ],
    );
  }
}
