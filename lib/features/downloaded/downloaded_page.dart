import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/downloaded/presentation/pages/book_page.dart';
import 'package:alla/features/downloaded/presentation/pages/video_page.dart';
import 'package:alla/features/downloaded/presentation/widgets/custom_button.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadedPage extends StatefulWidget {
  const DownloadedPage({super.key});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  int selectedIndex = 0; // 0 - video, 1 - book
  List<Map<String, String>> bookData = [
    {
      'title': 'Andijon allasi',
      'pages': '10 bet',
      'image': 'assets/images/img01.png',
    },

    {
      'title': 'Buxoro allasi',
      'pages': '10 bet',
      'image': 'assets/images/img02.png',
    },

    {
      'title': 'Qoraqalpoq allasi',
      'pages': '10 bet',
      'image': 'assets/images/img03.png',
    },

    {
      'title': 'Samarqand allasi',
      'pages': '10 bet',
      'image': 'assets/images/img04.png',
    },

    {
      'title': 'Qo‘qon allasi',
      'pages': '10 bet',
      'image': 'assets/images/img05.png',
    },
  ];

  List<Map<String, String>> videoData = [
    {
      'title': 'Andijon allasi',
      'duration': '3:25 minut',
      'quality': '1080p',
      'image': 'assets/images/img01.png',
    },

    {
      'title': 'Buxoro allasi',
      'duration': '2:47 minut',
      'quality': '1080p',
      'image': 'assets/images/img02.png',
    },

    {
      'title': 'Qoraqalpoq allasi',
      'duration': '4:02 minut',
      'quality': '1080p',
      'image': 'assets/images/img03.png',
    },

    {
      'title': 'Samarqand allasi',
      'duration': '2:58 minut',
      'quality': '1080p',
      'image': 'assets/images/img04.png',
    },

    {
      'title': 'Qo‘qon allasi',
      'duration': '2:47 minut',
      'quality': '1080p',
      'image': 'assets/images/img05.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isVideo = selectedIndex == 0;
    final currentData = isVideo ? videoData : bookData;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const CustomBoldText(
          text: 'Yuklaganlar',
          size: 18,
          fontWeight: FontWeight.w800,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            topLeft: Radius.circular(28),
          ),
          gradient: LinearGradient(
            colors: [AppColors.black, AppColors.black2],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        isSelected: selectedIndex == 0,
                        text: "Video kontentlar",
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        }
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        isSelected: selectedIndex == 1,
                        text: "Kitoblar",
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: currentData.length,
                itemBuilder: (context, index) {
                  final item = currentData[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(64),
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),

                      image: DecorationImage(
                        image: AssetImage('assets/images/img13.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: ListTile(
                        leading: Container(
                          width: 100,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: AssetImage(item["image"]!), fit: BoxFit.cover)
                          ),
                          child: isVideo ? Center(
                            child: SvgPicture.asset('assets/icons/play.svg', width: 24, height: 24,),
                          ) : null
                        ),
                        title: CustomBoldText(
                            text: item["title"]!,
                            size: 17,
                          textAlign: TextAlign.start,
                        ),
                        subtitle: CustomSubText(
                            text: isVideo ? item['duration']! + ' • ' + item['quality']! : item['pages']!,
                            size: 14,
                          textAlign: TextAlign.start,

                        ),
                        trailing: GestureDetector(
                          onTap: (){
                            if (isVideo) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (builder) => const VideoPage())
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (builder) => const BookPage())
                              );
                            }
                          },

                          child: Stack(
                            children: [
                              Image.asset('assets/images/img14.png', width: 44, height: 44,),
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
            )
          ],
        ),
      ),
    );
  }
}
