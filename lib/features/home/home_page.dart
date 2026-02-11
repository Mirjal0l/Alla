import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/data/home_data.dart';
import 'package:alla/features/home/presentation/bloc/home_bloc.dart';
import 'package:alla/features/home/presentation/mixins/home_mixin.dart';
import 'package:alla/router/app_routes.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router/name_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  // listview contents

  @override
  void initState() {
    super.initState();
    print("HomePage initState called");

    // Check if Bloc is initialized and making API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Triggering getCategories API...");
      // Add your event here
      context.read<HomeBloc>().add(GetCategoriesEvent(activeOnly: true));
    });
  }

  String selectedValue = localSource.age; // for dropdown button

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (HomeState previous, HomeState current) =>
          previous.status != current.status ||
          previous.categoryResponse != current.categoryResponse,
      listener: (context, state) {
        print('HOMEPAGE CATEGORY LISTENER: State changed to: ${state.status}');
        print("Local storage AGE = ${localSource.age}");

        // Clear any existing snackbars first
        // ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (state.status == ApiStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message ?? "state.message javob bermadi error",
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        if (state.status == ApiStatus.success) {
          print('CATEGORY LISTENER: Success! STATE.STATUS: ${state.status}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Muvaffaqiyatli CATOGORY API'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state.status == ApiStatus.loading) {
          print('CATEGORY LISTENER STATE LOADING');
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (p, n) => p.categoryResponse != n.categoryResponse,
        builder: (context, state) {
          final categoryData = state.categoryResponse?.data ?? [];
          final List<dynamic> categories = categoryData;
          return Scaffold(
            backgroundColor: AppColors.transparent,
            body: Container(
              // background container
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.orange, Colors.yellowAccent, Colors.black],
                  stops: [0, 0.3, 0],
                ),
              ),

              child: SafeArea(
                child: Column(
                  // the page content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppUtils.kPaddingAll16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBoldText(
                            // alla text
                            text: "Alla",
                            size: 26,
                          ),

                          // age selection container
                          Container(
                            padding: AppUtils.kPaddingHor10,
                            height: 35,
                            width: 125,
                            decoration: BoxDecoration(
                              color: AppColors.black2,
                              borderRadius:
                                  AppUtils.kBorderRadiusBottomRight20Others10,
                            ),
                            child: DropdownButton(
                              dropdownColor: AppColors.black2,
                              isExpanded: true,
                              underline: const SizedBox(),
                              elevation: 0,
                              value: selectedValue,
                              items: List.generate(100, (index) {
                                // item of dropdown button
                                return DropdownMenuItem(
                                  value: (index + 1).toString(),
                                  child: CustomBoldText(
                                    text: "${index + 1} yosh",
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value.toString();
                                  localSource.setAge(selectedValue.toString());
                                  print('AGE CHANGED To = ${localSource.age.toString()}');
                                });
                              },
                              style: TextStyle(color: AppColors.white),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.white,
                              ),
                              iconSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        // black card contains listview
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadiusTop28,
                          gradient: RadialGradient(
                            center: Alignment.bottomRight,
                            colors: [
                              // Color(0xFF35070D),
                              AppColors.reddish.withOpacity(0.3),
                              AppColors.black,
                            ],
                            radius: 1.5,
                            stops: [0.0, 0.5],
                          ),
                        ),

                        child: Column(
                          // column of listview
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              // text above list
                              padding: AppUtils.kPaddingAll16,
                              child: CustomBoldText(
                                text: "Kontent bo‘limlari",
                                size: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white.withOpacity(0.8),
                              ),
                            ),

                            // listview itself
                            Expanded(
                              child: ListView.builder(
                                // itemCount: HomeData.items.length,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (index == 3) {
                                        context.pushNamed(
                                          Routes.eduContentPage,
                                        ); // No parameters needed
                                      } else if (index == 7) {
                                        context.pushNamed(Routes.gamePage);
                                      } else {
                                        context.pushNamed(
                                          Routes.homePageContent,
                                          // This needs index
                                          pathParameters: {
                                            'index': index.toString(),
                                          }, // Add parameter here
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 96,
                                      margin: AppUtils.kPaddingHor8Ver4,
                                      decoration: BoxDecoration(
                                        borderRadius: AppUtils
                                            .kBorderRadiusTopRight64Others24,
                                        // background list item
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/img13.png',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      child: Padding(
                                        padding: AppUtils.kPaddingAll8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 80,
                                              padding: AppUtils
                                                  .kPaddingLeft2Top2Bottom10,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  HomeData
                                                      .items[index]['image']!,
                                                  // categories[index]['iconUrl'],
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomBoldText(
                                                    // text: HomeData
                                                    //     .items[index]['text']!,
                                                    text:
                                                        categories[index]['name'],
                                                    size: 17,
                                                    textAlign: TextAlign.start,
                                                  ),

                                                  CustomSubText(
                                                    // text: HomeData
                                                    //     .items[index]['subtext']!,
                                                    text:
                                                        categories[index]['description'],
                                                    size: 14,
                                                    textAlign: TextAlign.start,
                                                  ),

                                                  AppUtils.kGap12,
                                                ],
                                              ),
                                            ),

                                            Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Padding(
                                                    padding: AppUtils
                                                        .kPaddingRight8Bottom14,
                                                    child: Image.asset(
                                                      'assets/images/img14.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  bottom: 16,
                                                  right: 10,
                                                  child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color: AppColors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // child: ListTile(
                                      //   leading: Container(
                                      //     width: 100,
                                      //     height: 65,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(20),
                                      //             image: DecorationImage(image: AssetImage(items[index]["image"]!), fit: BoxFit.cover)
                                      //     ),
                                      //   ),
                                      //   title: CustomBoldText(
                                      //       text: items[index]["text"]!,
                                      //       size: 17,
                                      //     textAlign: TextAlign.start,
                                      //   ),
                                      //   subtitle: CustomSubText(
                                      //       text: items[index]["subtext"]!,
                                      //       size: 14,
                                      //     textAlign: TextAlign.start,
                                      //
                                      //   ),
                                      //   trailing: ...
                                      //
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
