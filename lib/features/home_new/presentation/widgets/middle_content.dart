import 'dart:ui';

import 'package:alla/router/name_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../widgets/custom_bold_text.dart';
import '../../data/static_datas.dart';

class MiddleContent extends StatelessWidget {
  const MiddleContent({Key? key, required this.currentIndex, this.list, this.animationController}) : super(key: key);
  final int currentIndex;
  final List<bool>? list;
  final AnimationController? animationController;


  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.transparent,
            AppColors.dark_blue,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.65],
        ),
      ),

      // TITLE AND SUBTITLE
      child: Column(
        children: [
          CustomBoldText(
            text: StaticDatas()
                .pageBuilderItem[currentIndex]['title'],
            size: 36,
            color: AppColors.white,
          ),
          CustomBoldText(
            text: StaticDatas()
                .pageBuilderItem[currentIndex]['subtext'],
            size: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),

          AppUtils.kGap20,

          // BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.newHomeDetails,
                    extra: StaticDatas()
                        .pageBuilderItem[currentIndex]['image'],
                    pathParameters: {
                      'index1': '0'.toString(),
                      'index2': '0'.toString(), // not used just for filling index2
                    },
                  );
                },
                child: Container(
                  padding: AppUtils.kPaddingHor16,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: AppUtils.kBorderRadius16,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/violet_button.png',
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/play_circle.svg',
                        width: 24,
                        height: 24,
                      ),
                      AppUtils.kGap12,
                      CustomBoldText(
                        text: 'Tomosha qilish',
                        size: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          AppUtils.kGap16,

          // PROGRESS BAR
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: List.generate(
              6,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: list![index] ? 48 : 24,
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.white
                      .withOpacity(0.1),
                  color: AppColors.white,
                  // value: list[index] ? _progress_value : 0,
                  value: list![index]
                      ? (animationController?.value
                      ?? 0) : 0,
                  borderRadius: AppUtils.kBorderRadius8,
                  minHeight: 3,
                ),
              ),
            ),
          ),

          AppUtils.kGap12
        ],
      ),
    );
  }
}
