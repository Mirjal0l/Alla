import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../router/name_routes.dart';
import '../../../../../widgets/custom_bold_text.dart';
import '../../../data/static_datas.dart';

class MiddleContentsHD extends StatelessWidget {
  const MiddleContentsHD({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppUtils.kPaddingHor16,
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

          // VIOLET BUTTON
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.videoPlayer,
                  );
                },
                child: Container(
                  padding: AppUtils.kPaddingHor16,
                  width:
                  MediaQuery.of(
                    context,
                  ).size.width -
                      64 -
                      32,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius:
                    AppUtils.kBorderRadius16,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/violet_button.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
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

              // DOWNLOAD BUTTON
              SizedBox(
                width: 56,
                height: 56,
                child: ClipRRect(
                  borderRadius:
                  AppUtils.kBorderRadius12,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaY: 24,
                      sigmaX: 24,
                    ),
                    child: Container(
                      width: 56,
                      height: 56,
                      color: AppColors.white
                          .withOpacity(0.1),
                      child: IconButton(
                        icon: Icon(
                          Icons
                              .file_download_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.pushNamed(
                            Routes.downloaded,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          AppUtils.kGap16,
        ],
      ),
    );
  }
}
