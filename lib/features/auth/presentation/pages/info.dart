import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black2,
      appBar: CustomAppBar(
          hasLeadingIcon: true,
        title: 'Info',
      )
    );
  }
}
