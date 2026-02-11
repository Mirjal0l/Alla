import 'dart:async';
import 'dart:ui';

import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/onboarding/presentation/widgets/custom_gray_button.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_blue_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Timer? _timer;

  late final PageController
  _pageController; // controller for managing swiping pages
  int _currentPage = 0;

  // list of pages
  final List<Map<String, String>> pages = [
    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle":
      "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img1.png",
    },

    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle":
      "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img2.png",
    },

    {
      "title": "Bolalar uchun xavfsiz kontent",
      "subtitle":
      "Sizning farzandingiz uchun faqat xavfsiz va foydali kontent.",
      "image": "assets/images/img3.png",
    },

    {
      "title": "Sifatli ta’limiy va qiziqarli videolar",
      "subtitle":
      "O‘yinlar, ertaklar, qo‘shiqlar va foydali bilimlar bir joyda.",
      "image": "assets/images/img4.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // initialize controller together
    _autoPlay(); // for swiping pages automatically
  }


  // auto swiping after 3 seconds
  void _autoPlay() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      //Safety check
      if (!_pageController.hasClients) {
        _timer?.cancel();
        return;
      }

      if (_currentPage < pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose(); // always dispose controller
    _timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Container(
        padding: AppUtils.kPaddingHor16,

        // background gradient
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            colors: [AppColors.reddish, AppColors.black],
            radius: 1.5,
            stops: [0.0, 0.5],
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
                scrollDirection: Axis.horizontal,
                itemCount: pages.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  // building each screen
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

                      AppUtils.kGap20,

                      CustomBoldText(text: page["title"]!, size: 28),

                      AppUtils.kGap10,

                      CustomSubText(text: page["subtitle"]!, size: 17),

                      AppUtils.kGap20,
                    ],
                  );
                },
              ),

              // skip button
              Positioned(
                top: 16,
                right: 0,
                child: CustomGrayButton(
                  title: "O'tkazish",
                  onPressed: () {
                    // if (_currentPage != pages.length - 1) {
                    //   _pageController.animateToPage(
                    //     _currentPage, // last page
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.easeInOut,
                    //   );
                    // }

                    if (_currentPage < pages.length - 1) {
                      _currentPage++;
                    } else {
                      _currentPage = 0;
                    }

                    _pageController.animateToPage(
                        _currentPage,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut
                    );
                  },
                ),
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
                        (index) =>
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: AppUtils.kPaddingHor5,
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.white
                                : AppColors.white.withOpacity(0.3),
                            borderRadius: AppUtils.kBorderRadius50,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // start button
        padding: AppUtils.kPaddingBottom30Left16Right16,
        child: CustomBlueButton(
          title: "Boshlash",
          onPressed: () {
            // context.push(Routes.login); change after test
            context.push(Routes.newHomePage);
          },
        ),
      ),
    );
  }
}
