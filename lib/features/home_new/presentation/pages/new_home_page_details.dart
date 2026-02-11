import 'dart:ui';

import 'package:alla/features/home_new/presentation/pages/widgets/header_contents_h_d.dart';
import 'package:alla/features/home_new/presentation/pages/widgets/list_view1.dart';
import 'package:alla/features/home_new/presentation/pages/widgets/list_view2.dart';
import 'package:alla/features/home_new/presentation/pages/widgets/middle_contents_h_d.dart';
import 'package:alla/features/home_new/presentation/pages/widgets/my_rating.dart';
import 'package:alla/features/home_new/presentation/pages/widgets/my_toggle_button.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../router/name_routes.dart';
import '../../../../widgets/custom_bold_text.dart';

class NewHomePageDetails extends StatefulWidget {
  NewHomePageDetails({
    super.key,
    required this.index1,
    required this.index2,
    required this.imagePath,
  });

  final String? imagePath;
  final int index1;
  final int index2;

  @override
  State<NewHomePageDetails> createState() => _NewHomePageDetailsState();
}

class _NewHomePageDetailsState extends State<NewHomePageDetails> {
  int currentIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [

                  // IMAGE
                  Positioned(
                    child: (widget.imagePath != null) ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath!),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ) : SizedBox()
                  ),

                  // Gradient effect
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.dark_blue, AppColors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.05, 0.5],
                        ),
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Column(
                      children: [
                        AppUtils.kGap48,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              // HEADER CONTENTS
                              HeaderContentsHD(),

                              // GRADIENT
                              MiddleContentsHD(currentIndex: currentIndex)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BLUE CONTAINER
            Container(
              // padding: AppUtils.kPaddingHor12,
              color: AppColors.dark_blue,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  // Toggle buttons
                  Padding(
                    padding: AppUtils.kPaddingHor12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyToggleButton(text: '1:52:00'),
                        MyToggleButton(text: 'Sarguzashtlar'),
                        MyToggleButton(text: 'Drama'),
                        MyToggleButton(text: '3+'),
                      ],
                    ),
                  ),

                  Padding(
                    padding: AppUtils.kPaddingHor12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyToggleButton(text: '2025'),
                        MyToggleButton(text: 'Full HD'),
                      ],
                    ),
                  ),

                  // DESCRIPTION TEXT
                  Padding(
                    padding: AppUtils.kPaddingAll16,
                    child: CustomSubText(
                      text:
                          'Markaziy Osiyoda ilk to‘liq metrajli animatsion '
                          'film hisoblangan “Sehrlandiya” voqealari tog‘ '
                          'yonbag‘ridagi shaharchada boshlanadi. Qahramonlar to‘p '
                          'o‘ynayotib tasodifan makonlararo portalni ishga tushirib yuboradi '
                          'va sarguzasht tomon yo‘l olishadi.',
                      size: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                    ),
                  ),

                  AppUtils.kGap20,

                  Padding(
                    padding: AppUtils.kPaddingHor12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomSubText(
                          text: 'Ishlab chiqaruvchi: ',
                          size: 16,
                          color: AppColors.white.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                        ),

                        CustomBoldText(
                          text: ' Lola Animation',
                          size: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),

                  AppUtils.kGap24,

                  Container(
                    width: double.infinity,
                    padding: AppUtils.kPaddingHor16,
                    child: CustomBoldText(
                      text: 'Ijodiy guruh',
                      size: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                    ),
                  ),

                  AppUtils.kGap20,

                  // IJODIY GURUH LIST
                  ListView1(),

                  AppUtils.kGap20,

                  Container(
                    padding: AppUtils.kPaddingHor12,
                    width: double.infinity,
                    child: CustomBoldText(
                      text: 'O\'xshash kontentlar',
                      size: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                    ),
                  ),

                  AppUtils.kGap20,


                  // O'XSHASH KONTENTLAR LIST
                  ListView2(index1: widget.index1),

                  AppUtils.kGap20,

                  // RATING CONTAINER
                  Padding(
                    padding: AppUtils.kPaddingHor12,
                    child: MyRating(),
                  ),

                  AppUtils.kGap16,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
