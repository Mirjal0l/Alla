import 'package:flutter/material.dart';

import '../../data/static_datas.dart';

class MyPageView extends StatefulWidget {
  MyPageView({Key? key, required this.currentIndex, required this.pageController}) : super(key: key);
  late int currentIndex;
  final PageController pageController;


  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: StaticDatas().pageBuilderItem.length,
        controller: widget.pageController,
        onPageChanged: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  StaticDatas().pageBuilderItem[index]['image'],
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          );
        },
      ),
    );
  }
}
