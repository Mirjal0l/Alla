import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/data/home_data.dart';
import 'package:alla/features/home/data/static_data/static_data.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/custom_sub_text.dart';

class HomePageContent extends StatefulWidget {
  final int index;
  const HomePageContent({super.key, required this.index});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        hasLeadingIcon: true,
        title: HomeData.items[widget.index]['text']!,
      ),
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: AppUtils.kPaddingHor16,
      //     child: IconButton(
      //         onPressed: (){
      //           context.pop();
      //         },
      //         icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 24)
      //     ),
      //   ),
      //   backgroundColor: AppColors.gray_darker2,
      //   title: CustomBoldText(text: HomeData.items[widget.index]['text']! , size: 20),
      //   centerTitle: true,
      // ),

      body: CustomListView(isVideo: true, data: StaticData().superList?[widget.index])
    );
  }
}