import 'dart:async';

import 'package:alla/features/home_new/models/category_response.dart';
import 'package:alla/features/home_new/models/category_content.dart';
import 'package:alla/features/home_new/presentation/widgets/header_grayed.dart';
import 'package:alla/features/home_new/presentation/widgets/image_grayed.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../data/static_datas.dart';

class SuperList extends StatefulWidget {
  const SuperList({
    super.key,
    required this.allCategories,
    required this.categoryContentData,
  });

  final List<CategoryData> allCategories;
  final List<CategoryContent>? categoryContentData;

  @override
  State<SuperList> createState() => _SuperListState();
}

class _SuperListState extends State<SuperList> {
  bool isLoading = true;

  void setTimer() {
    Future.delayed(Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          isLoading = !isLoading;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print('SUPERLISTIMAGE: ${widget.categoryContentData?.length}');
    setTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading ? shimmerView(isLoading)
        : widget.allCategories.isNotEmpty ? Container(
            padding: AppUtils.kPaddingBottom10,
            color: AppColors.dark_blue,
            // FIRST LIST
            child: ListView.builder(
              // cacheExtent: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.allCategories.length,
              itemBuilder: (context, index1) {
                return (index1 < widget.allCategories.length && index1 >= 0 &&
                widget.allCategories[index1].children!.isNotEmpty)
                     ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: AppUtils.kPaddingTop16,
                        height: widget.allCategories[index1].contentIntentType != 'GAME' ? 198 : 157,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: AppUtils.kPaddingHor16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBoldText(
                                    text: widget.allCategories[index1].name
                                        .toString(),
                                    size: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white08,
                                  ),

                                  Spacer(),
                                  CustomSubText(
                                    text: 'Barchasi',
                                    size: 14,
                                    color: AppColors.white08,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 24,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                            // SECOND LIST
                            widget.categoryContentData!.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.categoryContentData![index1].data?.content!.length,
                                      itemBuilder: (context, index2) {
                                        print("__________________________________${widget.categoryContentData![index1].data?.content?.length}----------------------------------------");
                                        var img = widget
                                            .categoryContentData![index1].data?.content![index2].mobileThumbnailUrl;

                                        return (img != 'null' && img != null)
                                            ? Container(
                                                margin: AppUtils
                                                    .kPaddingTop8Others4,
                                                width: 106,
                                                height: widget.allCategories[index1].contentIntentType != 'GAME' ? 147 : 106,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      AppUtils.kBorderRadius8,
                                                  image: DecorationImage(
                                                    image: NetworkImage(img),
                                                    // image: AssetImage('assets/images/sehrlandiya_sq.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                ),
                                              )
                                            : SizedBox();
                                      },
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    : SizedBox();
              },
            ),
          )
        : SizedBox();
  }
}

Widget shimmerView(bool isLoading) {
  return Container(
    padding: AppUtils.kPaddingBottom10,
    color: AppColors.dark_blue,
    // FIRST LIST
    child: ListView.builder(
      shrinkWrap: true,
      physics: isLoading ? NeverScrollableScrollPhysics() : null,
      scrollDirection: Axis.vertical,
      itemCount: 6,
      itemBuilder: (context, index1) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: AppUtils.kPaddingTop16,
          height: 198,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderGrayed(),
              // SECOND LIST
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 106,
                  physics: isLoading ? NeverScrollableScrollPhysics() : null,
                  itemCount: 6,
                  itemBuilder: (context, index2) {
                    return ImageGrayed();
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
