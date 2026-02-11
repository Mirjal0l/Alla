import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/router/name_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/utils.dart';
import 'custom_bold_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key,
    required this.hasLeadingIcon,
    this.title,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w900,
    this.background = AppColors.black,
    this.maxLines = 1
  });

  final bool hasLeadingIcon;
  final String? title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color background;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasLeadingIcon ? Padding(
        padding: AppUtils.kPaddingHor16,
        child: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 24)
        ),
      ) : null,

      title: title != null
        ? Padding(
          padding: AppUtils.kPaddingRight16,
          child: CustomBoldText(text: title! , size: fontSize, fontWeight: fontWeight, maxLines: 1,)
      ) : null,
      backgroundColor: background,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
