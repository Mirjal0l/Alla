import 'package:alla/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/custom_bold_text.dart';
import '../../data/static_datas.dart';

class HeaderGrayed extends StatelessWidget {
  const HeaderGrayed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(seconds: 1),
      direction: ShimmerDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: AppUtils.kBorderRadius8,
                color: Colors.grey[300]
            ),
          ),
          Spacer(),
          Container(
            width: 80,
            height: 8,
            decoration: BoxDecoration(
                borderRadius: AppUtils.kBorderRadius8,
                color: Colors.grey[300]
            ),
          ),
          Icon(Icons.keyboard_arrow_right_rounded, size: 24, color: AppColors.white,)
        ],
      ),
    );
  }
}
