import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../data/static_datas.dart';
import 'package:shimmer/shimmer.dart';

class ImageGrayed extends StatelessWidget {
  const ImageGrayed({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: AppUtils.kPaddingTop8Others4,
    //   width: StaticDatas().list_item_sizes[index1]['width'],
    //   height: StaticDatas().list_item_sizes[index1]['height'],
    //   decoration: BoxDecoration(
    //     borderRadius: AppUtils.kBorderRadius8,
    //     color: CupertinoColors.inactiveGray
    //   ),
    // );

    return Shimmer.fromColors(
        child: Container(
          margin: AppUtils.kPaddingAll4,
          width: 106,
          height: 147,
          decoration: BoxDecoration(
            borderRadius: AppUtils.kBorderRadius8,
            color: Colors.grey[300],
          ),
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      period: Duration(seconds: 1),
      direction: ShimmerDirection.ltr,
    );
  }
}
