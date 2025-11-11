import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/main/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomNavigationBar({
    required this.navigationShell,
    super.key
  });

  void onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex
    );
  }

  @override
  Widget build(BuildContext context) {
    // ingridients of navigation bar
    final List<Map<String, dynamic>> navItems = [
      {
        "title": "Bosh sahifa",
        "icon": "assets/icons/home.svg",
        "index": 0
      },

      {
        "title": "Yuklanganlar",
        "icon": "assets/icons/downloaded.svg",
        "index": 1
      },

      {
        "title": "Profil",
        "icon": "assets/icons/profile.svg",
        "index": 2
      }
    ];

    return Container(
      color: AppColors.black2,
      padding: EdgeInsets.only(top: 8),
      width: double.infinity,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navItems.map(
            (item) {
              return NavBarItem(
                  navigationShell: navigationShell,
                  title: item["title"] as String,
                  icon: item["icon"] as String,
                  index: item["index"] as int,
                  onPressed: () => onItemTapped(item["index"] as int, context)
              );
            }
        ).toList()
      ),
    );
  }
}