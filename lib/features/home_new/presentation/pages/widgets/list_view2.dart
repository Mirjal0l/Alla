import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../../../data/static_datas.dart';

class ListView2 extends StatelessWidget {
  const ListView2({Key? key, required this.index1}) : super(key: key);
  final int index1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 147,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: StaticDatas().super_list[index1].length,
        itemBuilder: (context, index) {
          return Container(
            margin: AppUtils.kPaddingHor4,
            width: 106,
            height: 147,
            decoration: BoxDecoration(
              borderRadius: AppUtils.kBorderRadius8,
              image: DecorationImage(
                image: AssetImage(
                  StaticDatas().super_list[index1][index],
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
