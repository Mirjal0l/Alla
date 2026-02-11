import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class DigitalLibraryCard extends StatelessWidget {
  const DigitalLibraryCard({super.key, required this.data, required this.index});

  final Map<String, dynamic> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Container(
        padding: AppUtils.kPaddingBottom10,
        width: 165,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/edu_card.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: AppUtils.kBorderRadiusTopRight48Others24,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [

                Container(
                  margin: AppUtils.kPaddingHor12,
                  width: 110,
                  height: 131,
                  decoration: BoxDecoration(
                    borderRadius: AppUtils.kBorderRadiusTopRight24Others12,
                    image: DecorationImage(image: AssetImage(data['image'])),
                  ),
                ),

                Positioned(
                  top: 16,
                    right: 20,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/edu_orange.png'))
                      ),
                    ),
                ),

                Positioned(
                  top: 26,
                  right: 30,
                  child: SvgPicture.asset('assets/icons/edu_download.svg', width: 16, height: 16,),
                )
              ],
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/edu_book.svg',
                    color: data['hasBook']
                        ? AppColors.green
                        : AppColors.gray_edu,
                    width: 20,
                    height: 20,
                  ),
                  AppUtils.kGap6,
                  SvgPicture.asset(
                    'assets/icons/edu_audio.svg',
                    width: 20,
                    height: 20,
                    color: data['hasAudio']
                        ? AppColors.green
                        : AppColors.gray_edu,
                  ),
                ],
              ),
            ),

            AppUtils.kGap12,

            Padding(
              padding: AppUtils.kPaddingHor12,
              child: CustomBoldText(
                text: data['title'],
                size: 18,
                textAlign: TextAlign.start,
                color: AppColors.white,
              ),
            ),

            AppUtils.kGap2,

            Padding(
              padding: AppUtils.kPaddingLeft12Bottom12,
              child: CustomSubText(
                text:
                    '${data['duration']}${(data['pages'] != '' && data['duration'] != '') ? ' • ' : ''}${data['pages']}',
                size: 12,
                color: AppColors.white08,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
