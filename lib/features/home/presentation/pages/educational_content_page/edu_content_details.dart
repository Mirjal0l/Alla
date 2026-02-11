import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/audio_player/audio_player_page.dart';
import 'package:alla/features/downloaded/presentation/widgets/custom_button.dart';
import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/app_colors.dart';

class EduContentDetails extends StatefulWidget {
  const EduContentDetails({super.key, required this.index});

  final int index;

  @override
  State<EduContentDetails> createState() => _EduContentDetailsState();
}

class _EduContentDetailsState extends State<EduContentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        hasLeadingIcon: true,
        title: StaticData().digitalLibrary[widget.index]['title'],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: AppUtils.kPaddingHor16,
              width: double.infinity,
              height: 596,
              decoration: BoxDecoration(
                borderRadius: AppUtils.kBorderRadius28,
                gradient: LinearGradient(
                  colors: [AppColors.gray_darker3, AppColors.black2],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppUtils.kGap24,
                  Center(
                    child: Container(
                      width: 275,
                      height: 317,
                      child: ClipRRect(
                        borderRadius: AppUtils.kBorderRadius16,
                        child: Image.asset(
                          StaticData().digitalLibrary[widget.index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  AppUtils.kGap24,

                  Row(
                    children: [
                      StaticData().digitalLibrary[widget.index]['hasBook'] ? Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 107,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadius8,
                          color: AppColors.green.withOpacity(0.1),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/edu_book.svg',
                              width: 16,
                              height: 16,
                              color: AppColors.green,
                            ),
                            AppUtils.kGap6,
                            CustomSubText(
                              text: StaticData()
                                  .digitalLibrary[widget.index]['pages'],
                              size: 13,
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ) : SizedBox(),

                      // AppUtils.kGap8,

                      StaticData().digitalLibrary[widget.index]['hasAudio'] ? Container(
                        width: 107,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadius8,
                          color: AppColors.green.withOpacity(0.1),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/edu_audio.svg',
                              width: 16,
                              height: 16,
                              color: AppColors.green,
                            ),
                            AppUtils.kGap6,
                            CustomSubText(
                              text: StaticData()
                                  .digitalLibrary[widget.index]['duration'],
                              size: 13,
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ) : SizedBox(),
                    ],
                  ),

                  AppUtils.kGap8,

                  CustomBoldText(
                    text:
                        StaticData().digitalLibrary[widget.index]['title'] +
                        ' asari',
                    size: 18,
                    fontWeight: FontWeight.w800,
                  ),

                  AppUtils.kGap4,

                  CustomSubText(
                    text: StaticData().digitalLibrary[widget.index]['subText'],
                    size: 15,
                    color: AppColors.white08,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: AppUtils.kPaddingAll16,
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            topLeft: Radius.circular(28),
          ),
          color: AppColors.gray_darker3,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StaticData().digitalLibrary[widget.index]['hasBook'] ? Expanded(
              child: Container(

                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: StaticData().digitalLibrary[widget.index]['hasAudio'] ? AssetImage('assets/images/blue_button.png')
                    : AssetImage('assets/images/blue_button_long.png'),
                  ),
                ),

                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/edu_book.svg', height: 20, width: 20, color: AppColors.white,),

                        AppUtils.kGap8,

                        CustomBoldText(text: 'O\'qish', size: 17, fontWeight: FontWeight.w800,)
                      ],
                    )
                ),
              ),
            ) : SizedBox(),

            StaticData().digitalLibrary[widget.index]['hasAudio'] && StaticData().digitalLibrary[widget.index]['hasBook'] ? AppUtils.kGap12 : SizedBox(),

            StaticData().digitalLibrary[widget.index]['hasAudio'] ? Expanded(
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.audioPlayer);
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: StaticData().digitalLibrary[widget.index]['hasBook'] ? AssetImage('assets/images/orange_button.png')
                          : AssetImage('assets/images/orange_button_long.png'),)
                  ),

                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/edu_audio.svg', height: 20, width: 20, color: AppColors.white,),

                          AppUtils.kGap8,

                          CustomBoldText(text: 'Tinglash', size: 17, fontWeight: FontWeight.w800,)
                        ],
                      )
                  ),
                ),
              ),
            ) : SizedBox(),

          ],
        ),
      ),
    );
  }
}
