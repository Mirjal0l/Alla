import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/home/data/home_data.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.gray_darker2,
      appBar: AppBar(
        backgroundColor: AppColors.gray_darker2,
        title: CustomBoldText(text: HomeData.items[widget.index]['text']! , size: 20),
        centerTitle: true,
      ),
    );
  }
}