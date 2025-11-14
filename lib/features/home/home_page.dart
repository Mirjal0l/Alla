import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/home/data/home_data.dart';
import 'package:alla/features/home/presentation/pages/home_page_content.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // listview contents

  dynamic selectedValue = 18; // for dropdown button

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(16.0),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 35,
                      width: 125,
                      decoration: BoxDecoration(
                        color: AppColors.black2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: DropdownButton(
                        dropdownColor: AppColors.black2,
                        isExpanded: true,
                        underline: const SizedBox(),
                        elevation: 0,
                        value: selectedValue,
                        items: List.generate(20, (index) {
                          // item of dropdown button
                          return DropdownMenuItem(
                            value: index + 1,
                            child: CustomBoldText(
                              text: "${index + 1} yosh",
                              size: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
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
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(28),
                      topLeft: Radius.circular(28),
                    ),
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
                        padding: const EdgeInsets.all(16.0),
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
                          itemCount: HomeData.items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: 96,
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(64),
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),

                                // background list item
                                image: DecorationImage(
                                  image: AssetImage('assets/images/img13.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                        child: Image.asset(
                                          HomeData.items[index]['image']!,
                                          // width: 100,
                                          // height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomBoldText(
                                            text: HomeData.items[index]['text']!,
                                            size: 17,
                                            textAlign: TextAlign.start,
                                          ),

                                          CustomSubText(
                                            text: HomeData.items[index]['subtext']!,
                                            size: 14,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (builder) => HomePageContent(index: index)
                                            )
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 4, bottom: 4),
                                              child: Image.asset(
                                                  'assets/images/img14.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                            ),
                                          ),

                                          Positioned(
                                            bottom: 6,
                                            right: 6,
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: AppColors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
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
  }
}
