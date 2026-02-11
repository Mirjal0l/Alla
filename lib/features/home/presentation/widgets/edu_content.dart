import 'dart:ui';

import 'package:alla/features/downloaded/presentation/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../widgets/custom_bold_text.dart';
import '../../../../widgets/custom_sub_text.dart';
import '../../../downloaded/presentation/pages/book_page.dart';

class EduContent extends StatefulWidget {
  const EduContent({super.key, required this.currentData});

  final List currentData;

  @override
  State<EduContent> createState() => _EduContentState();
}

class _EduContentState extends State<EduContent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.currentData.length,
      itemBuilder: (context, index) {
        final item = widget.currentData[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => const VideoPage()),
            );
          },
          child: Container(
            margin: AppUtils.kPaddingVer4,
            height: 82,
            decoration: BoxDecoration(
              borderRadius: AppUtils.kBorderRadiusTopRight64Others24,

              image: DecorationImage(
                image: AssetImage('assets/images/img13.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: ListTile(
                leading: SizedBox(
                  height: 56,
                  child: Container(
                    margin: AppUtils.kPaddingBottom4,
                    width: 62,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: AppUtils.kBorderRadius12,
                      image: DecorationImage(
                        image: AssetImage(item["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
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
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.25),
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
                    ),
                  ),
                ),
                title: CustomBoldText(
                  text: item["title"]!,
                  size: 17,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                subtitle: Padding(
                  padding: AppUtils.kPaddingBottom8,
                  child: CustomSubText(
                    text: '${item['duration']} • ${item['quality']}',
                    size: 14,
                    textAlign: TextAlign.start,
                  ),
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
          ),
        );
      },
    );
  }
}
