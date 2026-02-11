import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({super.key, required this.isFavorite});
  bool isFavorite;
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppUtils.kBorderRadius12,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 24,
          sigmaY: 24,
        ),
        child: Container(
          width: 44,
          height: 44,
          color: AppColors.white.withOpacity(0.1),
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
                });
              },
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border, size: 24,
                  color: widget.isFavorite ? Colors.red : AppColors.white
              ),
          ),
        ),
      ),
    );
  }
}
