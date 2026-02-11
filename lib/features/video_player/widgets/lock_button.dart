import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';

class LockButton extends StatefulWidget {
  const LockButton({super.key, required this.onToggleLock, required this.locked});
  final VoidCallback onToggleLock;
  final bool locked;

  @override
  State<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends State<LockButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      child: ClipRRect(
        borderRadius: AppUtils.kBorderRadius12,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 24,
            sigmaX: 24
          ),
          child: Container(
            width: 44,
            height: 44,
            color: AppColors.white.withOpacity(0.1),
            child: IconButton(
                onPressed: () {
                  widget.onToggleLock();
                },
                icon: Icon(
                  widget.locked ? Icons.lock_open : Icons.lock,
                  color: AppColors.white,
                  size: 24,
                ),
            ),
          )
        ),
      ),
    );
  }
}
