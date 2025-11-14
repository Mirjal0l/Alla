import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';

class DownloadedPage extends StatefulWidget {
  const DownloadedPage({super.key});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const CustomBoldText(
            text: 'Yuklanganlar',
            size: 18,
        ),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(28),
              topLeft: Radius.circular(28)
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.black,
              AppColors.black2,
            ],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBoldText(
                  text: 'Yuklangan media fayllar yo’q',
                  size: 18,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 4),

              CustomSubText(
                  text: 'Siz hali media fayl yuklamagansiz. Bu yerda yuklangan fayllaringiz aks etadi.',
                  size: 15,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
