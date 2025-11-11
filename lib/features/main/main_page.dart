import 'package:alla/features/main/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({required this.navigationShell, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: CustomNavigationBar(navigationShell: navigationShell),
      ),
    );
  }
}
