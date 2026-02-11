import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../widgets/custom_bold_text.dart';
import '../../../../../widgets/custom_sub_text.dart';

class ListView1 extends StatelessWidget {
  const ListView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: 77,
            height: 112,
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: AppUtils.kBorderRadius64,
                      color: AppColors.white.withOpacity(0.1)
                  ),
                  child: Center(
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: AppUtils.kBorderRadius64,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.orange2,
                            AppColors.orange3,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/account_icon.svg',
                          width: 24,
                          height: 24,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                AppUtils.kGap4,

                CustomBoldText(
                  text: 'Akbarali',
                  size: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                CustomBoldText(
                  text: 'Khasanov',
                  size: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),

                AppUtils.kGap6,

                CustomSubText(
                  text: 'Aktyor',
                  size: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.light_gray,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
