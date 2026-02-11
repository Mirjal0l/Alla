import 'dart:io';
import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import '../../../../router/app_routes.dart';
import '../../../../widgets/custom_sub_text.dart';

class HeaderContent extends StatefulWidget {
  const HeaderContent({Key? key}) : super(key: key);

  @override
  State<HeaderContent> createState() => _HeaderContentState();
}

class _HeaderContentState extends State<HeaderContent> {
  File? imageFile;
  @override
  void initState() {
    super.initState();
    imageFile = localSource.profileImagePath;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppUtils.kPaddingHor16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo
          Image.asset(
            'assets/images/logotip.png',
            width: 67,
            height: 32,
            fit: BoxFit.cover,
          ),

          Row(
            children: [
              // yosh
              ClipRRect(
                borderRadius: AppUtils.kBorderRadius10,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: Container(
                    width: 59,
                    height: 30,
                    color: AppColors.white.withOpacity(0.1),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomBoldText(
                            text: '${localSource.age}',
                            size: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                          CustomSubText(
                            text: ' yosh',
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              AppUtils.kGap12,

              // Account icon
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: AppUtils.kBorderRadius64,
                        gradient: LinearGradient(
                          colors: [AppColors.violet, AppColors.violet2],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: AppUtils.kBorderRadius64,
                        color: AppColors.dark_blue,
                      ),
                    ),
                  ),

                  imageFile == null ? Positioned(
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.profile);
                      },
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadius64,
                          gradient: LinearGradient(
                            colors: [AppColors.orange2, AppColors.orange3],

                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/account_icon.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ) : Positioned(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadius64,
                        ),
                        child: Center(
                          child: Image.file(imageFile!, fit: BoxFit.cover,
                          width: 36, height: 36,),

                          ),
                        ),
                    ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
