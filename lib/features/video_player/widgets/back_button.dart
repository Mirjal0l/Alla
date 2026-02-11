import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButton1 extends StatelessWidget {
  const BackButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppUtils.kBorderRadius12,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 24, sigmaX: 24),
        child: Container(
          width: 44,
          height: 44,
          color: AppColors.white.withOpacity(0.1),
          child: IconButton(
            icon: Icon(Icons.chevron_left, size: 24, color: Colors.white,),
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ),
    );
  }
}
