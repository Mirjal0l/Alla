import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:alla/features/home/presentation/widgets/edu_content.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../widgets/custom_bold_text.dart';
import '../../../../../widgets/custom_sub_text.dart';
import '../../../../downloaded/presentation/pages/book_page.dart';
import '../../../../downloaded/presentation/pages/video_page.dart';
import '../../../../downloaded/presentation/widgets/custom_button.dart';
import '../../widgets/digital_library.dart';

class EducationalContentPage extends StatefulWidget {
  const EducationalContentPage({super.key});
  @override
  State<EducationalContentPage> createState() => _EducationalContentPageState();
}

class _EducationalContentPageState extends State<EducationalContentPage> {
  int selectedIndex = 0; // 0 - video, 1 - book
  @override
  Widget build(BuildContext context) {

    final isEduContent = selectedIndex == 0;
    final currentData = isEduContent ? StaticData().eduData : StaticData().digitalLibrary;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
          hasLeadingIcon: true,
          title: 'Ta\’limiy kontentlar & raqamli kutubxona',
        maxLines: 1,
      ),

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppUtils.kBorderRadiusTop28,
          gradient: LinearGradient(
            colors: [AppColors.black, AppColors.black2],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
        padding: AppUtils.kPaddingHor16,
        child: Column(
          children: [
            Padding(
              padding: AppUtils.kPaddingTop16,

              // Toggle buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        isSelected: selectedIndex == 0,
                        text: "Ta'limiy kontent",
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        }
                    ),
                  ),

                  AppUtils.kGap20,

                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        isSelected: selectedIndex == 1,
                        text: "Raqamli kutubxona",
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                    ),
                  ),
                ],
              ),
            ),

            AppUtils.kGap16,

            Flexible(
              child: selectedIndex == 0 ?
              EduContent(currentData: currentData) : DigitalLibrary(currentData: currentData),
            )
          ],
        ),
      ),
    );
  }
}


