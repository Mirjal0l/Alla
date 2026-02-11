import 'dart:io';
import 'dart:ui';

import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/utils.dart';

class GamePageDetails extends StatelessWidget {
  const GamePageDetails({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.black,

      appBar: CustomAppBar(
          hasLeadingIcon: true,
        title: StaticData().gamePageData[index]['title'],
      ),

      body: Container(
        margin: EdgeInsets.only(bottom: 6),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppUtils.kBorderRadius28,
          color: AppColors.black2,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: AppUtils.kPaddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 317,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(StaticData().gamePageData[index]['image2'] ?? StaticData().gamePageData[index]['image']),
                    fit: BoxFit.fill)
                  ),
                  child: Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: AppUtils.kBorderRadius64,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),
                              child: Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.25),
                                  shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset('assets/icons/play.svg', color: AppColors.white, width: 24, height: 24),
                              ),
                            ),
                          )
                        ],
                      ),
          
                    ),
                  )
                ),
          
                AppUtils.kGap32,
          
                CustomBoldText(text: StaticData().gamePageData[index]['title'], size: 18, fontWeight: FontWeight.w800,),
          
                AppUtils.kGap8,
          
                CustomSubText(text: StaticData().gamePageData[index]['description'], size: 15, fontWeight: FontWeight.w400, textAlign: TextAlign.start)
          
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: AppUtils.kPaddingAll16,
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppUtils.kBorderRadiusTop28,
          color: AppColors.black2,
        ),
        child: GestureDetector(
          onTap: () {

          },
          child: Container(
            padding: AppUtils.kPaddingAll16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/blue_button_long.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Platform.isAndroid ? SvgPicture.asset('assets/icons/google_play.svg') : SvgPicture.asset('assets/icons/apple.svg'),
                  AppUtils.kGap8,
                  CustomBoldText(text: 'Yuklab olish', size: 17, fontWeight: FontWeight.w800,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
