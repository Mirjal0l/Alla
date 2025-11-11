
import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/onboarding/presentation/widgets/custom_gray_button.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/widgets/custom_blue_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  late final PageController _pageController; // controller for managing swiping pages
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // initialize controller together
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose(); // always dispose controller
  }

  // list of pages
  final List<Map<String, String>> pages = [
    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle": "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img1.png"
    },

    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle": "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img2.png"
    },

    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle": "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img3.png"
    },

    {
      "title": "Sifatli ta’limiy va qiziqarli videolar",
      "subtitle": "O‘yinlar, ertaklar, qo‘shiqlar va foydali bilimlar bir joyda.",
      "image": "assets/images/img4.png"
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),

        // background gradient
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            colors: [
              AppColors.reddish,
              AppColors.black,
            ],
            radius: 1.5,
            stops: [0.0, 0.5]
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              IgnorePointer(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                  child: Container(color: AppColors.transparent),
                ),
              ),

              // pageview (swipable screens)
              PageView.builder(
                itemCount: pages.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) { // building each screen
                  final page = pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          page["image"]!,
                        width: 276,
                        height: 276,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),

                      CustomBoldText(
                          text: page["title"]!,
                          size: 28
                      ),

                      const SizedBox(height: 10),

                      CustomSubText(
                          text: page["subtitle"]!,
                          size: 17
                      ),

                      const SizedBox(height: 20)
                    ]
                  );
                },
              ),

              // skip button
              Positioned(
                top: 16,
                right: 0,
                child: CustomGrayButton(title: "O'tkazish", onPressed: (){
                  if (_currentPage != pages.length - 1) {
                    _pageController.animateToPage(
                        pages.length - 1, // last page
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut
                    );
                  }
                })
              ),

              // dots
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppColors.white : AppColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(50)
                        ),
                      )
                  )
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container( // start button
        padding: EdgeInsets.only(bottom: 30, left: 16, right: 16),
        child: CustomBlueButton(title: "Boshlash", onPressed: (){
          context.push(Routes.home);
        }),
      ),
    );
  }
}

