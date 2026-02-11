import 'dart:ui';

import 'package:alla/core/utils/utils.dart';
import 'package:alla/router/name_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/app_colors.dart';
import 'custom_bold_text.dart';
import 'custom_sub_text.dart';

class CustomListView extends StatefulWidget {
  final bool isVideo;
  final List<Map<String, dynamic>> data;

  const CustomListView({super.key, required this.isVideo, required this.data});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0; // 0 - video, 1 - book

  @override
  Widget build(BuildContext context) {
    var isVideo = widget.isVideo;
    isVideo = selectedIndex == 0;
    return Container(
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final item = widget.data[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      Routes.videoPlayer,
                    );
                  },
                  child: Container(
                    height: 82,
                    margin: AppUtils.kPaddingVer8,
                    decoration: BoxDecoration(
                      borderRadius: AppUtils.kBorderRadiusTopRight64Others24,

                      image: DecorationImage(
                        image: AssetImage('assets/images/img13.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        // margin: EdgeInsets.only(bottom: 4),
                        width: 62,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: AppUtils.kBorderRadius20,
                          image: DecorationImage(
                            image: AssetImage(item["image"]!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: isVideo
                            ? Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: AppUtils.kBorderRadius24,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Background image

                                      // Blurred circular play icon
                                      ClipOval(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 3,
                                            sigmaY: 3,
                                          ),
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.25,
                                              ),
                                              // translucent fog
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/play.svg',
                                              width: 16,
                                              height: 16,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : null,
                      ),
                      title: CustomBoldText(
                        text: item["title"]!,
                        size: 17,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      subtitle: CustomSubText(
                        text: widget.isVideo
                            ? item['duration']! + ' • ' + item['quality']!
                            : item['pages']!,
                        size: 14,
                        textAlign: TextAlign.start,
                      ),
                      trailing: Stack(
                        children: [
                          Image.asset(
                            'assets/images/img14.png',
                            width: 44,
                            height: 44,
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
