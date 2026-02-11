import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/main/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NewNavigationBar({required this.navigationShell, super.key});

  void onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {
        'title': 'Bosh sahifa',
        'icon': 'assets/icons/new-nav1.svg',
        'index': 0
      },

      {
        'title': 'Yuklanganlar',
        'icon': 'assets/icons/new-nav2.svg',
        'index': 1
      },

      {
        'title': 'Qidiruv',
        'icon': 'assets/icons/new-nav3.svg',
        'index': 2
      },

      {
        'title': 'Tanlanganlar',
        'icon': 'assets/icons/new-nav4.svg',
        'index': 3
      },

      {
        'title': 'Profil',
        'icon': 'assets/icons/new-nav5.svg',
        'index': 4
      },
    ];
    return Container(
      padding: AppUtils.kPaddingAll12,
      color: AppColors.dark_blue,
      // height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navItems.map((item) {
          return Expanded(
            child: NavBarItem(
                navigationShell: navigationShell,
                title: item['title'],
                icon: item['icon'],
                index: item['index'] as int,
                onPressed: () => onItemTapped(item['index'] as int, context)
            ),
          );
        }).toList()
      ),
    );
  }
}
