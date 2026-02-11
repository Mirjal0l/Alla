import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/custom_bold_text.dart';
import '../../../../../widgets/custom_sub_text.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
          hasLeadingIcon: true,
        title: 'O\'yinlar',
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppUtils.kBorderRadiusTop28,
          color: AppColors.black2,
        ),
        child: Padding(
          padding: AppUtils.kPaddingAll16,
          child: ListView.builder(
            itemCount: StaticData().gamePageData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.gamePageDetails,
                    pathParameters: {'index': index.toString()}
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 96,
                  margin: AppUtils.kPaddingVer4,
                  decoration: BoxDecoration(
                    borderRadius: AppUtils.kBorderRadiusTopRight64Others24,

                    // background list item
                    image: DecorationImage(
                      image: AssetImage('assets/images/img13.png'),
                      fit: BoxFit.fill,
                    ),
                  ),

                  child: Padding(
                    padding: AppUtils.kPaddingAll8,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 62,
                          height: 70,
                          // padding: EdgeInsets.only(bottom: 10, left: 2, top: 2),
                          margin: AppUtils.kPaddingLeft2Top2Bottom10,
                          child: ClipRRect(
                            borderRadius: AppUtils.kBorderRadius20,
                            child: Image.asset(
                              StaticData().gamePageData[index]['image']!,
                              // width: 100,
                              // height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        AppUtils.kGap12,

                        Expanded(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              CustomBoldText(
                                text: StaticData().gamePageData[index]['title']!,
                                size: 17,
                                textAlign: TextAlign.start,
                              ),

                              CustomSubText(
                                text: StaticData().gamePageData[index]['subtitle']!,
                                size: 14,
                                textAlign: TextAlign.start,
                              ),

                              AppUtils.kGap12
                            ],
                          ),
                        ),


                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: AppUtils.kPaddingRight8Bottom14,
                                child: Image.asset(
                                  'assets/images/img14.png',
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 23,
                              right: 16,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: AppColors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
