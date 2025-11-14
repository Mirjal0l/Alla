import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_darker2,
      appBar: AppBar(
        backgroundColor: AppColors.gray_darker2,
        title: CustomBoldText(text: 'Books Page', size: 20),
        centerTitle: true,
      ),
    );
  }
}
