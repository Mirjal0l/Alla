import 'package:alla/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarItem extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final String icon;
  final String title;
  final int index;
  final VoidCallback onPressed;

  const NavBarItem({
    super.key,
    required this.navigationShell,
    required this.title,
    required this.icon,
    required this.index,
    required this.onPressed
  });

  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {

  @override
  Widget build(BuildContext context) {
    late final bool isSelected = widget.navigationShell.currentIndex == widget.index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: widget.onPressed,
        child: SizedBox(
          height: 56,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  widget.icon,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(isSelected ? AppColors.blue : AppColors.gray, BlendMode.srcIn)
              ),

              Text(
                widget.title,
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.blue : AppColors.gray,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
